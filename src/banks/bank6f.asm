SECTION "Bank 6F", ROMX[$4000], BANK[$6F]
    db $6F

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4001:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC001, $58

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4059:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC059, $9B

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_40F4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC0F4, $AB

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_419F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC19F, $DC

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_427B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC27B, $CE

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4349:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC349, $EA

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4433:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC433, $D1

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4504:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC504, $D1

; LZSS-compressed asset: 107 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_45D5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC5D5, $6B

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4640:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC640, $E7

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4727:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC727, $EC

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4813:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC813, $C8

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_48DB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC8DB, $64

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_493F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BC93F, $C7

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4A06:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCA06, $C0

; LZSS-compressed asset: 264 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_4AC6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BCAC6, $558

; compressed BG tiles (2048 bytes, 128 tiles): entry 6 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 736 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles6:: ; heuristic: map type 5 tileset stream; C0
Data_06F_501E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1BD01E, $2E0

; E-0140 (C1: entry 6 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes6::
Data_06F_52FE:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $5F17, $15AE, $0044 ; entry 1
    dw $1528, $5F17, $15AE, $0000 ; entry 2
    dw $218C, $5F17, $15AE, $0044 ; entry 3
    dw $5D8C, $5F17, $5AB1, $0000 ; entry 4
    dw $7DA0, $5F17, $7FE0, $0063 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_533E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD33E, $88

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_53C6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD3C6, $AD

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5473:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD473, $8B

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_54FE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD4FE, $D4

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_55D2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD5D2, $92

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5664:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD664, $D4

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5738:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD738, $E3

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_581B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD81B, $C9

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_58E4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD8E4, $8B

; LZSS-compressed asset: 252 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_596F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BD96F, $FC

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5A6B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDA6B, $BE

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5B29:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDB29, $C5

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5BEE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDBEE, $93

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5C81:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDC81, $C7

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5D48:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDD48, $F9

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_5E41:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BDE41, $556

; compressed BG tiles (2048 bytes, 128 tiles): entry 7 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 697 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles7:: ; heuristic: map type 5 tileset stream; C0
Data_06F_6397:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1BE397, $DE

; LZSS-compressed asset: 1043 bytes expand to 1040 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6475:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE475, $1DB

; E-0140 (C1: entry 7 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes7::
Data_06F_6650:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $5F17, $15AE, $0044 ; entry 1
    dw $1528, $5F17, $15AE, $0000 ; entry 2
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 3
    dw $5D8C, $5F17, $5AB1, $0000 ; entry 4
    dw $218C, $5F17, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    INCBIN "dwm2-cobi-us.gbc", $1BE690, $1F8

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6888:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE888, $CA

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6952:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BE952, $DB

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6A2D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEA2D, $AD

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6ADA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEADA, $CA

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6BA4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEBA4, $F7

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6C9B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEC9B, $99

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6D34:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BED34, $D8

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6E0C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEE0C, $E1

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6EED:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEEED, $D6

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_6FC3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BEFC3, $88

; LZSS-compressed asset: 186 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_704B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF04B, $BA

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_7105:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF105, $EB

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06F_71F0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BF1F0, $559
    ds $8B7, $00
