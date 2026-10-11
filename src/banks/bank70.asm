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
    INCBIN "dwm2-cobi-us.gbc", $1C030D, $40F

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
    INCBIN "dwm2-cobi-us.gbc", $1C0E5C, $57D

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
    INCBIN "dwm2-cobi-us.gbc", $1C224A, $30C

; LZSS-compressed asset: 3295 bytes expand to 3359 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_070_6556:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1C2556, $29A

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
    INCBIN "dwm2-cobi-us.gbc", $1C2AC4, $771

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
    INCBIN "dwm2-cobi-us.gbc", $1C3575, $528

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
