SECTION "Bank 6D", ROMX[$4000], BANK[$6D]
    db $6D

; compressed BG tiles (2048 bytes, 128 tiles): entry 0 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 938 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles0:: ; heuristic: map type 5 tileset stream; C0
Data_06D_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4001, $3AA

; E-0140 (C1: entry 0 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes0::
Data_06D_43AB:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0140, $03E7, $01A0, $00A0 ; entry 1
    dw $012F, $3F7F, $01D5, $0044 ; entry 2
    dw $012F, $029A, $01D5, $0044 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $218C, $3F7F, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_43EB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B43EB, $AB

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4496:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4496, $D0

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4566:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4566, $EE

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4654:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4654, $BB

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_470F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B470F, $DD

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_47EC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B47EC, $E9

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_48D5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B48D5, $D7

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_49AC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B49AC, $E3

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4A8F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4A8F, $F1

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4B80:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4B80, $A0

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4C20:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4C20, $D3

; LZSS-compressed asset: 261 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4CF3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4CF3, $105

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4DF8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4DF8, $BE

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4EB6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4EB6, $D1

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_4F87:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B4F87, $F6

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_507D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B507D, $5EC

; compressed BG tiles (2048 bytes, 128 tiles): entry 1 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 909 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles1:: ; heuristic: map type 5 tileset stream; C0
Data_06D_5669:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5669, $38D

; E-0140 (C1: entry 1 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes1::
Data_06D_59F6:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $012F, $3F7F, $01D5, $0044 ; entry 1
    dw $012F, $3F7F, $01D5, $0044 ; entry 2
    dw $012F, $029A, $01D5, $0044 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $218C, $3F7F, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_5A36:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B5A36, $A2

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_5AD8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B5AD8, $C1

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_5B99:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B5B99, $EB

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_5C84:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B5C84, $EC

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_5D70:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B5D70, $F2

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_5E62:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B5E62, $ED

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_5F4F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B5F4F, $EC

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_603B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B603B, $ED

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_6128:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B6128, $98

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_61C0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B61C0, $DE

; LZSS-compressed asset: 257 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_629E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B629E, $101

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_639F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B639F, $E2

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_6481:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B6481, $D7

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_6558:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B6558, $BB

; LZSS-compressed asset: 244 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_6613:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B6613, $F4

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_6707:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B6707, $5A1

; compressed BG tiles (2048 bytes, 128 tiles): entry 2 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 913 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles2:: ; heuristic: map type 5 tileset stream; C0
Data_06D_6CA8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6CA8, $A4

; LZSS-compressed asset: 992 bytes expand to 989 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_6D4C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B6D4C, $2ED

; E-0140 (C1: entry 2 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes2::
Data_06D_7039:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $012F, $3F7F, $01D5, $0044 ; entry 1
    dw $012F, $3F7F, $01D5, $0044 ; entry 2
    dw $012F, $029A, $01D5, $0044 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $7DA0, $3F7F, $7FE0, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $1B7079, $B3

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_712C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B712C, $CC

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_71F8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B71F8, $D5

; LZSS-compressed asset: 273 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_72CD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B72CD, $111

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_73DE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B73DE, $EE

; LZSS-compressed asset: 273 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_74CC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B74CC, $111

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_75DD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B75DD, $109

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_76E6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B76E6, $E9

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_77CF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B77CF, $B2

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_7881:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B7881, $EC

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_796D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B796D, $F3

; LZSS-compressed asset: 217 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_7A60:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B7A60, $D9

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_7B39:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B7B39, $DA

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_7C13:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B7C13, $D5

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_7CE8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B7CE8, $DE

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06D_7DC6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B7DC6, $CE
    ds $16C, $00
