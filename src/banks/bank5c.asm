SECTION "Bank 5C", ROMX[$4000], BANK[$5C]
    db $5C

; compressed tileset of map $C8 (the first map record using it)
; LZSS-compressed asset: 1493 bytes expand to 1920 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapC8Tileset:: ; heuristic: map tileset stream; C0
Data_05C_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $170001, $5D5

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapC8Palettes::
Data_05C_45D6:: ; address name
    dw $7DA0, $7FFF, $01D3, $0063 ; entry 0
    dw $01D3, $7FFF, $0348, $0006 ; entry 1
    dw $01C4, $03FF, $0348, $0084 ; entry 2
    dw $01C4, $7FFF, $0348, $0084 ; entry 3
    dw $001F, $7FFF, $0348, $0000 ; entry 4
    dw $00D0, $01D9, $0348, $0084 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; compressed tileset of map $C9 (the first map record using it)
; LZSS-compressed asset: 1262 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapC9Tileset:: ; heuristic: map tileset stream; C0
Data_05C_4616:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $170616, $4EE

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapC9Palettes::
Data_05C_4B04:: ; address name
    dw $3CC5, $7FFF, $1415, $0000 ; entry 0
    dw $400C, $025C, $0015, $0000 ; entry 1
    dw $00EF, $5AD6, $2A13, $0000 ; entry 2
    dw $3CC5, $3F7F, $1415, $0000 ; entry 3
    dw $3CC5, $6AD8, $5D12, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $01C4, $03FF, $0348, $0084 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC9Screens0::
Data_05C_4B44:: ; address name
    dfar Data_05C_4B50 ; entry 0
    dfar Data_05C_4C09 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapC9Attrs0::
Data_05C_4B4A:: ; address name
    dfar Data_05C_4CB7 ; entry 0
    dfar Data_05C_4CF5 ; entry 1

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4B50:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $170B50, $B9

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4C09:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $170C09, $AE

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4CB7:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $04, $01, $00, $0F, $1A, $03, $03, $01, $2A, $06, $01, $00, $04
    db $01, $FE, $F2, $01, $FE, $F6, $01, $34, $0A, $01, $2E, $02, $01, $FE, $FA, $01
    db $FE, $F6, $02, $01, $7E, $03, $01, $00, $08, $01, $7E, $0C, $01, $7E, $04, $01
    db $7E, $08, $01, $A2, $0F, $4D, $01, $DA, $0F, $19, $01, $7A, $0F, $13

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4CF5:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $04, $01, $00, $01, $02, $01, $06, $03, $01, $00, $02, $01, $00
    db $0F, $2B, $03, $03, $01, $04, $08, $01, $52, $00, $04, $04, $01, $FE, $F0, $01
    db $06, $06, $01, $FE, $F4, $01, $04, $0F, $13, $01, $06, $04, $01, $06, $08, $01
    db $A2, $0F, $4D, $01, $12, $0F, $1D, $01, $04, $02, $01, $3A, $1A, $01, $46, $1A

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapCAScreens0::
Data_05C_4D35:: ; address name
    dfar Data_05C_4D41 ; entry 0
    dfar Data_05C_4E01 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapCAAttrs0::
Data_05C_4D3B:: ; address name
    dfar Data_05C_4ED4 ; entry 0
    dfar Data_05C_4F27 ; entry 1

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4D41:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $170D41, $C0

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4E01:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $170E01, $D3

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4ED4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $170ED4, $53

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4F27:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $170F27, $4A

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapCEScreens0::
Data_05C_4F71:: ; address name
    dfar Data_05C_4F7D ; entry 0
    dfar Data_05C_506E ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapCEAttrs0::
Data_05C_4F77:: ; address name
    dfar Data_05C_513C ; entry 0
    dfar Data_05C_5189 ; entry 1

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_4F7D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $170F7D, $F1

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_506E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17106E, $CE

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_513C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17113C, $4D

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_5189:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $06, $06, $04, $00, $02, $01, $02, $02, $00, $02, $02, $04, $04
    db $06, $06, $00, $00, $0F, $2F, $02, $00, $56, $03, $00, $4A, $0F, $4D, $00, $6E
    db $0E, $00, $68, $02, $00, $C2, $0F, $0D, $00, $D0, $06, $00, $EC, $0F, $0D, $00
    db $1A, $16, $00, $16, $1F, $2B

; compressed tileset of map $D1 (the first map record using it)
; LZSS-compressed asset: 632 bytes expand to 1664 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapD1Tileset:: ; heuristic: map tileset stream; C0
Data_05C_51BF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1711BF, $278

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapD1Palettes::
Data_05C_5437:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $0152, $3F7F, $0218, $00C8 ; entry 1
    dw $026E, $3F7F, $02F3, $0188 ; entry 2
    dw $2130, $3F7F, $39D9, $00C8 ; entry 3
    dw $0018, $3F7F, $0218, $00C8 ; entry 4
    dw $7C01, $3F7F, $7FE1, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapD1Screens0::
Data_05C_5477:: ; address name
    dfar Data_05C_5483 ; entry 0
    dfar Data_05C_54EB ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapD1Attrs0::
Data_05C_547D:: ; address name
    dfar Data_05C_5567 ; entry 0
    dfar Data_05C_55A0 ; entry 1

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_5483:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $171483, $68

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_54EB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1714EB, $7C

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_5567:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $46, $01, $01, $01, $01, $00, $4A, $0F, $0D
    db $00, $5A, $00, $01, $01, $02, $02, $02, $02, $00, $74, $0F, $09, $00, $7E, $0F
    db $13, $00, $58, $02, $00, $84, $0A, $00, $CA, $0F, $01, $00, $CC, $0F, $13, $00
    db $58, $00, $00, $D0, $0C, $00, $18, $1F, $29

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_55A0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1715A0, $43

; compressed tileset of map $D2 (the first map record using it)
; LZSS-compressed asset: 1272 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapD2Tileset:: ; heuristic: map tileset stream; C0
Data_05C_55E3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1715E3, $4F8

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapD2Palettes::
Data_05C_5ADB:: ; address name
    dw $3CC5, $7FFF, $1415, $0000 ; entry 0
    dw $400C, $025C, $0015, $0000 ; entry 1
    dw $00EF, $5AD6, $2A13, $0000 ; entry 2
    dw $3CC5, $3F7F, $1415, $0000 ; entry 3
    dw $3CC5, $6AD8, $5D12, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0152, $3F7F, $0218, $00C8 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapD7Screens0::
Data_05C_5B1B:: ; address name
    dfar Data_05C_5B27 ; entry 0
    dfar Data_05C_5C2B ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapD7Attrs0::
Data_05C_5B21:: ; address name
    dfar Data_05C_5D02 ; entry 0
    dfar Data_05C_5D4F ; entry 1

; LZSS-compressed asset: 260 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_5B27:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $171B27, $104

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_5C2B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $171C2B, $D7

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_5D02:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $171D02, $4D

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_5D4F:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $06, $06, $04, $00, $02, $01, $02, $02, $00, $02, $02, $04, $04
    db $06, $06, $00, $00, $0F, $2F, $02, $00, $56, $03, $00, $4A, $0F, $4D, $00, $6E
    db $0E, $00, $68, $02, $00, $C2, $0F, $0D, $00, $D0, $06, $00, $EC, $0F, $0D, $00
    db $1A, $16, $00, $16, $1F, $2B

; compressed tileset of map $DA (the first map record using it)
; LZSS-compressed asset: 840 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapDATileset:: ; heuristic: map tileset stream; C0
Data_05C_5D85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $171D85, $348

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapDAPalettes::
Data_05C_60CD:: ; address name
    dw $0173, $7FFF, $0235, $0063 ; entry 0
    dw $0110, $51CE, $0235, $0063 ; entry 1
    dw $0142, $03FF, $034E, $0000 ; entry 2
    dw $0110, $03FF, $034E, $0000 ; entry 3
    dw $384E, $03FF, $5956, $0000 ; entry 4
    dw $300C, $35B8, $4812, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapDAScreens0::
Data_05C_610D:: ; address name
    dfar Data_05C_6119 ; entry 0
    dfar Data_05C_617D ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapDAAttrs0::
Data_05C_6113:: ; address name
    dfar Data_05C_6206 ; entry 0
    dfar Data_05C_623B ; entry 1

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_6119:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $172119, $64

; LZSS-compressed asset: 137 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_617D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17217D, $89

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_6206:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $03, $00, $00, $0F, $44, $02, $00, $58, $03, $00, $4C, $0F, $0B
    db $00, $58, $04, $00, $5A, $08, $00, $7E, $0E, $00, $7E, $0A, $00, $9E, $0F, $07
    db $00, $56, $02, $00, $56, $0C, $00, $CE, $0F, $01, $00, $4E, $0A, $00, $F0, $0F
    db $11, $00, $00, $0F, $2D

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_623B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $17223B, $41

; compressed tileset of map $DB (the first map record using it)
; LZSS-compressed asset: 1274 bytes expand to 1792 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapDBTileset:: ; heuristic: map tileset stream; C0
Data_05C_627C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17227C, $4FA

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
MapDBPalettes::
Data_05C_6776:: ; address name
    dw $3CC5, $7FFF, $1415, $0000 ; entry 0
    dw $400C, $025C, $0015, $0000 ; entry 1
    dw $00EF, $5AD6, $2A13, $0000 ; entry 2
    dw $3CC5, $3F7F, $1415, $0000 ; entry 3
    dw $3CC5, $6AD8, $5D12, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0142, $03FF, $034E, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapE0Screens0::
Data_05C_67B6:: ; address name
    dfar Data_05C_67C2 ; entry 0
    dfar Data_05C_68B7 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
MapE0Attrs0::
Data_05C_67BC:: ; address name
    dfar Data_05C_6976 ; entry 0
    dfar Data_05C_69C3 ; entry 1

; LZSS-compressed asset: 245 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_67C2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1727C2, $F5

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_68B7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1728B7, $BF

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_6976:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $172976, $4D

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_05C_69C3:: ; heuristic: map screen stream; C0
    db $68, $01, $00, $06, $06, $04, $00, $02, $01, $02, $02, $00, $02, $02, $04, $04
    db $06, $06, $00, $00, $0F, $2F, $02, $00, $56, $03, $00, $4A, $0F, $4D, $00, $6E
    db $0E, $00, $68, $02, $00, $C2, $0F, $0D, $00, $D0, $06, $00, $EC, $0F, $0D, $00
    db $1A, $16, $00, $16, $1F, $2B
    ds $1607, $00
