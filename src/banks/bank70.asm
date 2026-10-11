SECTION "Bank 70", ROMX[$4000], BANK[$70]
    db $70

; compressed BG tiles (2048 bytes, 128 tiles): entry 8 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 716 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles8:: ; heuristic: map type 5 tileset stream; C0
Data_070_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1C0001, $191

; LZSS-compressed asset: 1418 bytes expand to 1478 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4192:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0192, $13B

; E-0140 (C1: entry 8 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes8::
Data_070_42CD:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $5F17, $15AE, $0044 ; entry 1
    dw $3DEA, $5F17, $4EAE, $0000 ; entry 2
    dw $150B, $5F17, $15AE, $0000 ; entry 3
    dw $5D8C, $5F17, $5AB1, $0000 ; entry 4
    dw $218C, $5F17, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_430D:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C030D, $77

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4384:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0384, $A6

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_442A:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C042A, $D6

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4500:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0500, $D5

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_45D5:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C05D5, $A0

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4675:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0675, $A7

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_471C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C071C, $DA

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_47F6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C07F6, $EB

; LZSS-compressed asset: 138 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_48E1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C08E1, $8A

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_496B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C096B, $CC

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4A37:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0A37, $E0

; LZSS-compressed asset: 245 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4B17:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0B17, $F5

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4C0C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0C0C, $92

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4C9E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0C9E, $C8

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4D66:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0D66, $F6

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4E5C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0E5C, $D0

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4F2C:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $24, $0C, $00, $80, $04, $00, $78, $0F, $0D, $00, $18, $0C, $00
    db $A8, $0F, $29, $00, $F7, $0F, $4D, $00, $20, $0C

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4F56:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $2B, $00, $08, $00, $00, $52, $08, $00, $4E, $0F, $09, $03, $00, $7E, $03
    db $00, $5C, $04, $00, $7A, $0F, $07, $00, $A2, $06, $00, $9E, $0F, $0B, $00, $80
    db $0F, $13, $00, $56, $0F, $15, $00, $56, $0F, $11, $00, $3E, $1F, $13

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4F94:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0F94, $47

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_4FDB:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C0FDB, $4A

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5025:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $03, $00, $08, $00, $00, $2A, $08, $00, $26, $0F, $05, $03, $03, $01, $01
    db $00, $52, $08, $00, $4E, $0F, $05, $00, $28, $0F, $17, $00, $50, $0A, $00, $9E
    db $0F, $09, $00, $28, $0A, $00, $C8, $0F, $09, $00, $F7, $0F, $4D, $00, $0C, $0C

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5065:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $10, $0A, $03, $00, $82, $03, $00, $1E, $06, $00, $80, $0F, $01
    db $00, $1A, $02, $00, $88, $00, $00, $9E, $0F, $3B, $00, $22, $0E, $00, $FE, $0A
    db $00, $1C, $00, $00, $1E, $0C, $00, $20, $1F, $01, $00, $3A, $1F, $0D

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_50A3:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C10A3, $4A

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_50ED:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C10ED, $209

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_52F6:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C12F6, $4E

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5344:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1344, $4E

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5392:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1392, $47

; compressed BG tiles (2048 bytes, 128 tiles): entry 9 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 653 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles9:: ; heuristic: map type 5 tileset stream; C0
Data_070_53D9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1C13D9, $28D

; E-0140 (C1: entry 9 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes9::
Data_070_5666:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $6BFF, $4D8C, $0044 ; entry 1
    dw $4D8C, $6BFF, $5E73, $0000 ; entry 2
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 3
    dw $5D8C, $6BFF, $5AB1, $0000 ; entry 4
    dw $218C, $6BFF, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_56A6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C16A6, $8B

; LZSS-compressed asset: 183 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5731:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1731, $B7

; LZSS-compressed asset: 217 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_57E8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C17E8, $D9

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_58C1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C18C1, $A9

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_596A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C196A, $C2

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5A2C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1A2C, $EC

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5B18:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1B18, $EE

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5C06:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1C06, $DE

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5CE4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1CE4, $A2

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5D86:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1D86, $C7

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5E4D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1E4D, $E0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_5F2D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C1F2D, $D8

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6005:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2005, $95

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_609A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C209A, $D6

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6170:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2170, $DA

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_624A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C224A, $D7

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6321:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $09, $00, $20, $0F, $17, $00, $1E, $0F, $01, $00, $0A, $06, $00, $08, $00
    db $00, $78, $04, $00, $70, $0F, $0B, $03, $03, $00, $90, $0F, $39, $00, $EF, $0F
    db $4D, $00, $20, $0F, $05

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6356:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2356, $42

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6398:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $31, $00, $06, $02, $00, $0A, $0C, $00, $5A, $06, $00, $5A, $02, $00, $78
    db $06, $00, $74, $0F, $09, $00, $76, $06, $00, $02, $08, $00, $A6, $0C, $00, $00
    db $06, $00, $CA, $0F, $09, $00, $EF, $0F, $4D, $00, $08, $1F, $05

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_63D5:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C23D5, $4C

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6421:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2421, $49

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_646A:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C246A, $4B

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_64B5:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C24B5, $59

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_650E:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C250E, $48

; LZSS-compressed asset: 3295 bytes expand to 3359 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6556:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2556, $202

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6758:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2758, $98

; compressed BG tiles (2048 bytes, 128 tiles): entry 10 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 660 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles10:: ; heuristic: map type 5 tileset stream; C0
Data_070_67F0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1C27F0, $294

; E-0140 (C1: entry 10 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes10::
Data_070_6A84:: ; heuristic: map type 5 BG palettes; C0
    dw $01A2, $7FFF, $0348, $0063 ; entry 0
    dw $01A2, $3F7F, $0348, $0084 ; entry 1
    dw $01A2, $3F7F, $0348, $0084 ; entry 2
    dw $01A2, $7FFF, $0348, $0084 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $218C, $3F7F, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6AC4:: ; heuristic: key-world room screen tile map; C0
    db $68, $01, $00, $20, $21, $00, $00, $00, $08, $09, $40, $41, $40, $41, $06, $07
    db $00, $00, $02, $30, $31, $00, $14, $00, $18, $19, $50, $51, $50, $51, $16, $17
    db $00, $14, $02, $00, $00, $0F, $4D, $00, $60, $0F, $35, $42, $43, $00, $5A, $0E
    db $52, $53, $00, $BE, $0F, $27, $00, $58, $0F, $35

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6AFE:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2AFE, $BA

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6BB8:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2BB8, $CE

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6C86:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2C86, $D7

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6D5D:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2D5D, $A1

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6DFE:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2DFE, $E5

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6EE3:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2EE3, $B9

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6F9C:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2F9C, $299

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_7235:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C3235, $C9

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_72FE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C32FE, $BD

; LZSS-compressed asset: 257 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_73BB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C33BB, $101

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_74BC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C34BC, $B9

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_7575:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C3575, $DD

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_7652:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $60, $0F, $49, $00, $6A, $00, $00, $C0, $0F, $39, $00, $6C, $0F
    db $35

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_7673:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $2D, $00, $08, $00, $00, $54, $06, $00, $4E, $0F, $05, $00, $56, $0E, $00
    db $78, $0F, $0D, $00, $4A, $0F, $01, $00, $AC, $0F, $1F, $00, $52, $06, $00, $E8
    db $0F, $0D, $00, $78, $0F, $17, $00, $06, $0F, $0F

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_76AD:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C36AD, $47

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_76F4:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C36F4, $51

; LZSS-compressed asset: 58 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_7745:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $2F, $00, $08, $00, $00, $08, $0C, $00, $56, $0E, $00, $56, $04, $00, $08
    db $08, $00, $7C, $0E, $00, $7C, $08, $00, $08, $04, $00, $A2, $0F, $29, $00, $7A
    db $0F, $15, $00, $52, $0F, $17, $00, $04, $0F, $11

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_777F:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C377F, $4E

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_77CD:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $09, $00, $06, $00, $00, $20, $0F, $39, $00, $08, $00, $03, $00, $84, $01
    db $00, $76, $0F, $0B, $00, $7C, $06, $00, $9E, $0F, $39, $00, $9A, $0F, $01, $00
    db $86, $0A, $03, $03, $00, $FC, $0E, $00, $20, $1F, $01, $00, $08, $0F, $0D

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_780C:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C380C, $162

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_796E:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C396E, $4C

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_79BA:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C39BA, $98

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_7A52:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1C3A52, $4B

; compressed BG tiles (2048 bytes, 128 tiles): entry 11 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 1053 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles11:: ; heuristic: map type 5 tileset stream; C0
Data_070_7A9D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1C3A9D, $41D

; E-0140 (C1: entry 11 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes11::
Data_070_7EBA:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $218C, $3F7F, $029A, $0000 ; entry 1
    dw $3523, $42D8, $318C, $0044 ; entry 2
    dw $218C, $3F7F, $318C, $0084 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $218C, $3F7F, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $106, $00
