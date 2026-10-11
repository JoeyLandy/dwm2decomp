SECTION "Bank 66", ROMX[$4000], BANK[$66]
    db $66

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 3: entry 3 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1188 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles3:: ; heuristic: key-world tileset stream; C0
Data_066_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198001, $4A4

Data_066_44A5:: ; heuristic: key-world screen header; C0
    db $02, $02, $05, $06, $0B, $3A, $E9, $00

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_44AD:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1984AD, $99

Data_066_4546:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $09, $EA, $00

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_454E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19854E, $66

Data_066_45B4:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $09, $EB, $00

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_45BC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1985BC, $79

Data_066_4635:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $09, $EC, $00

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_463D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19863D, $88

Data_066_46C5:: ; heuristic: key-world screen header; C0
    db $05, $00, $06, $07, $0B, $3A, $ED, $00

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_46CD:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1986CD, $C1

Data_066_478E:: ; heuristic: key-world screen header; C0
    db $04, $03, $06, $07, $08, $3A, $EE, $00

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4796:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198796, $C3

Data_066_4859:: ; heuristic: key-world screen header; C0
    db $FF, $00, $09, $0A, $0C, $3A, $EF, $00

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4861:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198861, $B6

Data_066_4917:: ; heuristic: key-world screen header; C0
    db $FF, $00, $05, $07, $08, $3A, $F0, $00

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_491F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19891F, $D8

Data_066_49F7:: ; heuristic: key-world screen header; C0
    db $00, $06, $07, $09, $0E, $3A, $F1, $00

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_49FF:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1989FF, $D4

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4AD3:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $40, $0F, $2C, $02, $FA, $FA, $02
    db $F4, $FF, $01, $02, $AE, $0F, $21, $02, $FE, $F2, $02, $F0, $FF, $01, $02, $A0
    db $FF, $45

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4AF5:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $0F, $20, $02, $02, $03, $22, $0F, $11, $03, $34
    db $0F, $11, $02, $03, $7E, $01, $03, $70, $0F, $09, $03, $A0, $FF, $4D, $03, $FF
    db $0F, $4D, $03, $5F, $14

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4B1A:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $42, $02, $F8, $FF, $01, $02, $F8, $FE, $02
    db $F4, $FF, $01, $02, $F4, $FC, $02, $A0, $FF, $4D, $02, $FF, $0F, $4D, $02, $5F
    db $14

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4B3B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $0F, $20, $02, $02, $02, $02, $03, $24, $0F, $09
    db $03, $34, $00, $03, $FC, $F0, $03, $34, $00, $03, $36, $04, $03, $54, $0E, $03
    db $54, $04, $03, $FA, $F2, $03, $74, $0F, $05, $03, $A0, $FF, $4D, $03, $FF, $0F
    db $4D, $03, $5F, $14

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4B6F:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $198B6F, $51

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4BC0:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $198BC0, $44

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4C04:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $1E, $0F, $0A, $02, $FC, $FF, $01
    db $02, $FC, $FA, $02, $FE, $F2, $02, $FC, $F8, $02, $FC, $F4, $02, $A6, $0E, $02
    db $FA, $F8, $02, $FA, $F4, $02, $CC, $0E, $02, $F8, $FA, $02, $EC, $0F, $0F, $02
    db $21, $1F, $33

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4C37:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $198C37, $42

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4C79:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $198C79, $5D

Data_066_4CD6:: ; heuristic: key-world screen header; C0
    db $00, $00, $02, $09, $0A, $3B, $F2, $00

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4CDE:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198CDE, $9F

Data_066_4D7D:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $0A, $F3, $00

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4D85:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198D85, $5F

Data_066_4DE4:: ; heuristic: key-world screen header; C0
    db $FF, $00, $02, $08, $09, $24, $F4, $00

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4DEC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198DEC, $82

Data_066_4E6E:: ; heuristic: key-world screen header; C0
    db $00, $FF, $FF, $FF, $FF, $24, $F5, $00

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4E76:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198E76, $81

Data_066_4EF7:: ; heuristic: key-world screen header; C0
    db $02, $00, $09, $0A, $0C, $3B, $F6, $00

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4EFF:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198EFF, $5B

; LZSS-compressed asset: 560 bytes expand to 563 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4F5A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $33, $02, $90, $06, $02, $1C, $02, $00, $01, $00, $07, $02, $58, $02, $02, $AA
    db $09, $17, $02, $6C, $02, $02, $BE, $09, $0B, $02, $A0, $02, $02, $AA, $09, $02
    db $0C, $00, $33, $02, $E4, $0B, $02, $0B, $00, $0B, $0C, $0D, $02, $20, $12, $0E
    db $02, $01, $16, $02, $2D, $19, $02, $2D, $1F, $00, $02, $2B, $1F, $02

Data_066_4F98:: ; heuristic: key-world screen header; C0
    db $02, $00, $06, $0D, $0F, $3B, $F7, $00

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4FA0:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $198FA0, $BC

Data_066_505C:: ; heuristic: key-world screen header; C0
    db $FF, $04, $0B, $0C, $0E, $3B, $F8, $00

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5064:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $199064, $B1

Data_066_5115:: ; heuristic: key-world screen header; C0
    db $FF, $07, $09, $0C, $0F, $3B, $F9, $00

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_511D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19911D, $6D

; LZSS-compressed asset: 560 bytes expand to 567 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_518A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $37, $02, $C2, $0B, $27, $42, $43, $02, $34, $04, $02, $DE, $04, $36, $37, $52
    db $53, $02, $48, $04, $02, $0C, $03, $07, $02, $2E, $04, $20, $21, $0E, $02, $B3
    db $04, $17, $02, $42, $04, $30, $00, $01, $02, $C7, $04, $0B, $02, $A0, $04, $0E
    db $01, $00, $02, $B3, $0A, $02, $0C, $03

Data_066_51C2:: ; heuristic: key-world screen header; C0
    db $00, $06, $08, $09, $0D, $3B, $FA, $00

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_51CA:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1991CA, $D6

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_52A0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $13, $02, $F4, $FF, $01, $02
    db $30, $0F, $29, $02, $04, $08, $02, $78, $0F, $01, $02, $22, $0F, $43, $02, $F5
    db $0F, $4D, $02, $55, $1E

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_52C5:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $39, $02, $02, $03, $F4, $FE
    db $03, $56, $0F, $01, $03, $F2, $FF, $01, $03, $A0, $FF, $4D, $03, $F1, $0F, $4D
    db $03, $51, $1F, $03

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_52E9:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $15, $02, $08, $06, $02, $28
    db $0F, $2D, $02, $74, $08, $02, $74, $0F, $05, $02, $F8, $F6, $02, $EE, $FF, $01
    db $02, $A0, $FF, $4D, $02, $1D, $1F, $37

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5311:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $13, $02, $02, $03, $1E, $0F
    db $11, $02, $02, $03, $44, $0F, $11, $03, $56, $00, $03, $6C, $0F, $0D, $03, $FA
    db $F2, $03, $90, $0F, $01, $03, $90, $0F, $03, $03, $CF, $0F, $4D, $03, $2F, $1F
    db $25

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5342:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $3D, $02, $06, $06, $02, $50
    db $0F, $29, $02, $4C, $0C, $02, $9C, $0F, $31, $02, $FC, $F8, $02, $EC, $0F, $0D
    db $02, $1F, $1F, $35

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5366:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $199366, $47

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_53AD:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $19, $02, $06

; LZSS-compressed asset: 501 bytes expand to 514 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_53BA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $02, $02, $28, $0F, $0B, $02, $02, $06, $02, $50, $0F, $29, $02, $FE, $F4, $02
    db $32, $06, $02, $9E, $0F, $0F, $02, $F6, $FC, $02, $F0, $FF, $01, $02, $E4, $0F
    db $11, $02, $1B, $1F, $39

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_53DF:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $13, $02, $03, $30, $05, $03
    db $26, $0F, $0B, $03, $2C, $06, $03, $4E, $0F, $0F, $03, $2C, $02, $03, $76, $0F
    db $03, $03, $F2, $FC, $03, $9C, $0F, $37, $03, $5A, $06, $03, $F0, $0F, $09, $03
    db $FA, $0F, $13, $03, $45, $1F, $0F

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5416:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $199416, $61

Data_066_5477:: ; heuristic: key-world screen header; C0
    db $07, $05, $06, $0C, $0D, $3E, $0D, $01

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_547F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19947F, $7E

Data_066_54FD:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $0D, $0E, $01

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5505:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $199505, $5B

Data_066_5560:: ; heuristic: key-world screen header; C0
    db $FF, $06, $07, $0C, $0F, $27, $0F, $01

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5568:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $199568, $47

; LZSS-compressed asset: 522 bytes expand to 519 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_55AF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $07, $02, $D0, $08, $02, $DA, $03, $17, $02, $E4, $08, $02, $EE, $03, $0B, $22
    db $23, $02, $F8, $0D, $00, $01, $33, $02, $0C, $1D, $01, $00, $0B, $0C, $23, $02
    db $FC, $04, $02, $2A, $15, $02, $31, $11, $02, $12, $12, $50, $51

Data_066_55DC:: ; heuristic: key-world screen header; C0
    db $FF, $09, $0A, $0D, $0F, $27, $10, $01

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_55E4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1995E4, $74

Data_066_5658:: ; heuristic: key-world screen header; C0
    db $05, $02, $05, $06, $0C, $3E, $11, $01

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5660:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $199660, $A5

Data_066_5705:: ; heuristic: key-world screen header; C0
    db $07, $00, $08, $09, $07, $3E, $12, $01

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_570D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19970D, $AC

; LZSS-compressed asset: 519 bytes expand to 519 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_57B9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $07, $02, $F6, $0A, $02, $02, $11, $17, $02, $0A, $1A, $02, $16, $11, $0B, $0C
    db $0D, $0C, $0D, $02, $F2, $00, $02, $24, $17, $02, $00, $02, $33, $02, $66, $06

Data_066_57D9:: ; heuristic: key-world screen header; C0
    db $FF, $00, $03, $04, $0A, $3E, $13, $01

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_57E1:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1997E1, $BB

Data_066_589C:: ; heuristic: key-world screen header; C0
    db $FF, $00, $03, $07, $09, $3E, $14, $01

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_58A4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1998A4, $C7

Data_066_596B:: ; heuristic: key-world screen header; C0
    db $07, $02, $06, $07, $09, $3E, $15, $01

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5973:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $199973, $4D

; LZSS-compressed asset: 539 bytes expand to 536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_59C0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1999C0, $7B

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5A3B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $1E, $0F, $0B, $01, $02, $7E, $03, $02
    db $72, $0F, $15, $02, $80, $08, $02, $A6, $0F, $29, $02, $A2, $0A, $02, $F0, $0F
    db $4D, $02, $82, $00

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5A5F:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $50, $0F, $3D, $01, $01, $01, $01, $02
    db $A0, $0F, $0F, $02, $B0, $00, $02, $C6, $0F, $0F, $02, $D6, $02, $02, $EE, $0F
    db $0D, $02, $FC, $04, $02, $16, $1F, $2B

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5A87:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $28, $0F, $15, $01, $01, $02, $76, $0F
    db $0F, $01, $02, $AC, $03, $02, $A0, $0F, $09, $02, $AC, $04, $02, $C4, $0F, $0B
    db $02, $D0, $08, $02, $EE, $0F, $09, $02, $CE, $0F, $15, $02, $CC, $0A, $02, $40
    db $1F, $01

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5AB9:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $22, $0F, $0F, $02, $02, $02, $02, $03
    db $72, $0F, $15, $02, $02, $01, $01, $01, $01, $03, $A0, $0F, $0D, $03, $B0, $00
    db $03, $C4, $0F, $4D, $03, $E8, $0E, $03, $E8, $04, $03, $3E, $1F, $03

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5AE7:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $03, $02, $20, $0F, $15, $02
    db $30, $08, $02, $54, $0F, $29, $02, $52, $0A, $02, $32, $04, $02, $A6, $0F, $01
    db $02, $52, $0F, $4B, $02, $18, $1F, $29

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5B0F:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $199B0F, $4B

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5B5A:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $17, $01, $01, $02, $18, $0F, $15, $02, $2A, $06
    db $02, $2A, $04, $02, $52, $0F, $0B, $02, $7A, $0F, $0F, $02, $2A, $02, $02, $A2
    db $02, $02, $2A, $00, $02, $A2, $0F, $07, $02, $CA, $08, $02, $C8, $0F, $2B, $02
    db $A8, $08, $02, $12, $1F, $0D, $02, $1A, $1A, $02, $40, $1F, $01

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5B97:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $199B97, $42

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5BD9:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $199BD9, $59

Data_066_5C32:: ; heuristic: key-world screen header; C0
    db $FF, $03, $08, $09, $0A, $32, $16, $01

; LZSS-compressed asset: 142 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5C3A:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $199C3A, $8E

Data_066_5CC8:: ; heuristic: key-world screen header; C0
    db $FF, $FF, $FF, $FF, $FF, $32, $16, $01

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5CD0:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $199CD0, $468

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6138:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $1B, $01, $02, $2E, $03, $02, $22, $0F, $0B, $02
    db $2E, $04, $02, $32, $08, $02, $54, $0F, $4D, $02, $B4, $0F, $41, $02, $2C, $0F
    db $15, $02, $43, $1F, $11

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_615D:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $19A15D, $17B

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map54Screens0::
Data_066_62D8:: ; heuristic: map screen array; C0
    dfar Data_066_62DE ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map54Attrs0::
Data_066_62DB:: ; heuristic: map screen array; C0
    dfar Data_066_63B5 ; entry 0

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_62DE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A2DE, $D7

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_63B5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A3B5, $4D

; compressed tileset of map $62 (the first map record using it)
; LZSS-compressed asset: 1152 bytes expand to 1312 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Tileset:: ; heuristic: map tileset stream; C0
Data_066_6402:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19A402, $480

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map62Palettes::
Data_066_6882:: ; heuristic: map BG palettes; C0
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $194C, $7FFF, $01DA, $0000 ; entry 1
    dw $001B, $2BFF, $023F, $0000 ; entry 2
    dw $218C, $7FFF, $5AB1, $0000 ; entry 3
    dw $194C, $3A9A, $01DA, $0000 ; entry 4
    dw $0142, $7FFF, $7E80, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map62Screens0::
Data_066_68C2:: ; heuristic: map screen array; C0
    dfar Data_066_68F2 ; entry 0
    dfar Data_066_69B7 ; entry 1
    dfar Data_066_6A9F ; entry 2
    dfar Data_066_6B53 ; entry 3
    dfar Data_066_6C07 ; entry 4
    dfar Data_066_6CB6 ; entry 5
    dfar Data_066_6D46 ; entry 6
    dfar Data_066_6DF1 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map62Attrs0::
Data_066_68DA:: ; heuristic: map screen array; C0
    dfar Data_066_6ECE ; entry 0
    dfar Data_066_6F2A ; entry 1
    dfar Data_066_6F8B ; entry 2
    dfar Data_066_6FCC ; entry 3
    dfar Data_066_7020 ; entry 4
    dfar Data_066_7072 ; entry 5
    dfar Data_066_70AE ; entry 6
    dfar Data_066_70FD ; entry 7

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_68F2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A8F2, $C5

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_69B7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19A9B7, $E8

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6A9F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AA9F, $B4

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6B53:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AB53, $B4

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6C07:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AC07, $AF

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6CB6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19ACB6, $90

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6D46:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AD46, $AB

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6DF1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19ADF1, $DD

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6ECE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AECE, $5C

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6F2A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AF2A, $61

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6F8B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AF8B, $41

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6FCC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19AFCC, $54

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7020:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B020, $52

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7072:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $01, $01, $04, $04, $01, $00, $04, $0D, $00, $02, $0F, $31, $00
    db $02, $08, $00, $52, $08, $03, $03, $00, $60, $0F, $01, $00, $86, $00, $00, $78
    db $0F, $4B, $00, $04, $02, $00, $86, $02, $00, $F0, $04, $00, $EA, $0F, $1B, $00
    db $0E, $0C, $00, $22, $18, $00, $34, $1F, $09, $00, $04, $00

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_70AE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B0AE, $4F

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_70FD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B0FD, $62

; compressed tileset of map $63 (the first map record using it)
; LZSS-compressed asset: 856 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Tileset:: ; heuristic: map tileset stream; C0
Data_066_715F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B15F, $358

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map63Palettes::
Data_066_74B7:: ; heuristic: map BG palettes; C0
    dw $294A, $7FFF, $5294, $0000 ; entry 0
    dw $24C6, $7FD9, $5AB1, $0063 ; entry 1
    dw $7DA0, $7F75, $6B40, $0063 ; entry 2
    dw $7DA0, $7FD9, $7380, $0063 ; entry 3
    dw $5D8C, $7FD9, $5AB1, $0000 ; entry 4
    dw $7DA0, $7FD9, $7FE0, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $03E0 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map63Screens0::
Data_066_74F7:: ; heuristic: map screen array; C0
    dfar Data_066_750F ; entry 0
    dfar Data_066_75A4 ; entry 1
    dfar Data_066_764C ; entry 2
    dfar Data_066_76E7 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map63Attrs0::
Data_066_7503:: ; heuristic: map screen array; C0
    dfar Data_066_7759 ; entry 0
    dfar Data_066_779E ; entry 1
    dfar Data_066_77E7 ; entry 2
    dfar Data_066_7835 ; entry 3

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_750F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B50F, $95

; LZSS-compressed asset: 168 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_75A4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B5A4, $A8

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_764C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B64C, $9B

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_76E7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B6E7, $72

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7759:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B759, $45

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_779E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B79E, $49

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_77E7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B7E7, $4E

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7835:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $03, $03, $03, $03, $01, $F6, $FA, $02, $02, $01, $00, $0F, $29
    db $04, $04, $04, $04, $01, $F8, $F8, $01, $10, $00, $01, $F4, $FC, $01, $60, $0A
    db $01, $5C, $02, $01, $74, $0F, $0B, $01, $82, $04, $01, $9A, $0F, $07, $01, $A6
    db $08, $01, $C0, $0F, $4D, $01, $A8, $08, $01, $3E, $1F, $15

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map64Screens0::
Data_066_7871:: ; heuristic: map screen array; C0
    dfar Data_066_7889 ; entry 0
    dfar Data_066_7939 ; entry 1
    dfar Data_066_79DB ; entry 2
    dfar Data_066_7A5D ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map64Attrs0::
Data_066_787D:: ; heuristic: map screen array; C0
    dfar Data_066_7AE1 ; entry 0
    dfar Data_066_7B48 ; entry 1
    dfar Data_066_7B87 ; entry 2
    dfar Data_066_7BC3 ; entry 3

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7889:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B889, $B0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7939:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B939, $A2

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_79DB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19B9DB, $82

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7A5D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BA5D, $84

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7AE1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BAE1, $67

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7B48:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0F, $3C, $03, $03, $04, $04, $03, $01, $54, $01
    db $01, $52, $00, $01, $52, $00, $01, $4E, $00, $00, $00, $01, $54, $0C, $04, $04
    db $01, $66, $0E, $01, $FC, $F0, $01, $7C, $0F, $4D, $01, $B4, $0F, $17, $01, $54
    db $02, $01, $0C, $1F, $0D, $01, $4C, $02, $01, $3E, $0F, $01, $01, $00, $0A

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7B87:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $03, $03, $02, $00, $04, $0D, $00, $02, $0F, $2B, $00
    db $52, $02, $04, $04, $00, $58, $02, $00, $4E, $0F, $09, $00, $5A, $04, $00, $72
    db $0F, $11, $00, $56, $04, $00, $9E, $0F, $0D, $00, $6E, $0F, $19, $00, $52, $00
    db $00, $EE, $0F, $11, $00, $72, $0F, $09, $00, $3E, $1F, $13

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7BC3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $02, $02, $03, $03, $00, $00, $00, $00, $06, $0A, $00
    db $04, $0F, $27, $03, $00, $52, $0B, $00, $4E, $0F, $2D, $00, $9E, $0F, $3D, $00
    db $52, $0F, $4D, $00, $9E, $0F, $03

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map65Screens0::
Data_066_7BEA:: ; heuristic: map screen array; C0
    dfar Data_066_7C02 ; entry 0
    dfar Data_066_7C54 ; entry 1
    dfar Data_066_7CB4 ; entry 2
    dfar Data_066_7D15 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map65Attrs0::
Data_066_7BF6:: ; heuristic: map screen array; C0
    dfar Data_066_7DD2 ; entry 0
    dfar Data_066_7DF8 ; entry 1
    dfar Data_066_7E1C ; entry 2
    dfar Data_066_7E43 ; entry 3

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7C02:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BC02, $52

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7C54:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BC54, $60

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7CB4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BCB4, $61

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7D15:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BD15, $BD

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7DD2:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $03, $00, $52, $0D, $00, $50, $0F, $03
    db $04, $00, $7A, $0D, $00, $78, $0F, $03, $00, $52, $0F, $4D, $00, $B2, $0F, $3D
    db $00, $4E, $0F, $01, $02, $02

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7DF8:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $03, $00, $50, $0D, $00, $4E, $0F, $03
    db $04, $00, $78, $0D, $00, $76, $0F, $03, $00, $50, $0F, $4D, $00, $B0, $0F, $2D
    db $00, $00, $0F, $15

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7E1C:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $02, $02, $03, $00, $02, $0B, $02, $02, $00, $00, $0F, $03, $04
    db $00, $2A, $0B, $00, $26, $0F, $05, $00, $02, $0F, $4D, $00, $62, $0F, $4D, $00
    db $C2, $0F, $1D, $00, $3E, $1F, $13

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7E43:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BE43, $76

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map67Screens0::
Data_066_7EB9:: ; heuristic: map screen array; C0
    dfar Data_066_7EBF ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map67Attrs0::
Data_066_7EBC:: ; heuristic: map screen array; C0
    dfar Data_066_7F8F ; entry 0

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7EBF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BEBF, $D0

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_7F8F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $19BF8F, $58
    ds $19, $00
