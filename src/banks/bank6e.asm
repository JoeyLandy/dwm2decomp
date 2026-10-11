SECTION "Bank 6E", ROMX[$4000], BANK[$6E]
    db $6E

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4001:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8001, $D6

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_40D7:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B80D7, $E7

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_41BE:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B81BE, $9F

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_425D:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B825D, $46

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_42A3:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B82A3, $54

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_42F7:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B82F7, $42

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4339:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8339, $51

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_438A:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B838A, $51

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_43DB:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B83DB, $4D

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4428:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8428, $53

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_447B:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B847B, $50

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_44CB:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B84CB, $59

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4524:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8524, $4E

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4572:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8572, $1B5

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4727:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8727, $F5

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_481C:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B881C, $55

; compressed BG tiles (2048 bytes, 128 tiles): entry 3 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 916 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles3:: ; heuristic: map type 5 tileset stream; C0
Data_06E_4871:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B8871, $394

; E-0140 (C1: entry 3 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes3::
Data_06E_4C05:: ; heuristic: map type 5 BG palettes; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $24C6, $7FD9, $7FE0, $0063 ; entry 1
    dw $7DA0, $7F75, $6B40, $0063 ; entry 2
    dw $7DA0, $7FD9, $7380, $0063 ; entry 3
    dw $5D8C, $7FD9, $5AB1, $0000 ; entry 4
    dw $7DA0, $7FD9, $7FE0, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $1529, $7FD9, $3631, $0063 ; entry 7

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4C45:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8C45, $80

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4CC5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8CC5, $DD

; LZSS-compressed asset: 181 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4DA2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8DA2, $B5

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4E57:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8E57, $E0

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_4F37:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B8F37, $E5

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_501C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B901C, $DC

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_50F8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B90F8, $E6

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_51DE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B91DE, $DC

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_52BA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B92BA, $85

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_533F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B933F, $BE

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_53FD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B93FD, $E1

; LZSS-compressed asset: 245 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_54DE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B94DE, $F5

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_55D3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B95D3, $E6

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_56B9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B96B9, $E2

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_579B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B979B, $E6

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5881:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1B9881, $E7

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5968:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $24, $0C, $03, $03, $03, $03, $00, $1C, $08, $00, $80, $0F, $01
    db $00, $7E, $04, $00, $9C, $0F, $13, $00, $D2, $02, $00, $C8, $0F, $09, $00, $1C
    db $0F, $4D, $00, $08, $1C

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_599D:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B999D, $4A

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_59E7:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $35, $01, $01, $03, $03, $00, $4C, $0F, $0D, $00, $04, $02, $03, $03, $00
    db $08, $0C, $00, $84, $0F, $03, $00, $58, $02, $00, $A0, $0F, $31, $00, $5A, $02
    db $00, $9E, $0E, $00, $FC, $0F, $01, $00, $9C

; LZSS-compressed asset: 2358 bytes expand to 5391 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5A20:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $0F, $15, $00, $0C, $0F, $09

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5A26:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B9A26, $4B

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5A71:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B9A71, $54

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5AC5:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B9AC5, $49

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5B0E:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B9B0E, $52

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_5B60:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1B9B60, $305

; compressed BG tiles (2048 bytes, 128 tiles): entry 4 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 1071 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles4:: ; heuristic: map type 5 tileset stream; C0
Data_06E_5E65:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B9E65, $42F

; E-0140 (C1: entry 4 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes4::
Data_06E_6294:: ; heuristic: map type 5 BG palettes; C0
    dw $000F, $7FFF, $3C1F, $0063 ; entry 0
    dw $150B, $269F, $0157, $0044 ; entry 1
    dw $000F, $269F, $0157, $0044 ; entry 2
    dw $00CC, $269F, $01D5, $0044 ; entry 3
    dw $5D8C, $269F, $5AB1, $0000 ; entry 4
    dw $218C, $269F, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_62D4:: ; heuristic: key-world room screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA2D4, $82

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6356:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA356, $D5

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_642B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA42B, $E6

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6511:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA511, $D6

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_65E7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA5E7, $DA

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_66C1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA6C1, $E4

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_67A5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA7A5, $D7

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_687C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA87C, $C9

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6945:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA945, $A2

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_69E7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BA9E7, $C5

; LZSS-compressed asset: 240 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6AAC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BAAAC, $F0

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6B9C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BAB9C, $E7

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6C83:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BAC83, $B8

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6D3B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BAD3B, $CD

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6E08:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BAE08, $EC

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6EF4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1BAEF4, $E5

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_6FD9:: ; heuristic: key-world room screen attribute map; C0
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $33, $03, $03, $00, $48, $0F, $09, $00, $08, $00, $00, $78, $02, $00, $6E
    db $0F, $11, $00, $6A, $0F, $01, $00, $6A, $0E, $00, $68, $0F, $01, $00, $54, $0F
    db $07, $00, $0A, $0F, $3D, $00, $0A, $0F, $0B

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_7012:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB012, $47

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_7059:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB059, $4D

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_70A6:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB0A6, $5A

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_7100:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB100, $4E

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_714E:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB14E, $53

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_71A1:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB1A1, $4F

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_71F0:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB1F0, $1AF

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_739F:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB39F, $46

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_73E5:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB3E5, $9B

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06E_7480:: ; heuristic: key-world room screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1BB480, $64

; compressed BG tiles (2048 bytes, 128 tiles): entry 5 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 764 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles5:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_06E_74E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1BB4E4, $2FC

; E-0140 (C1: entry 5 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes5::
Data_06E_77E0:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $150B, $5F17, $15AE, $0044 ; entry 1
    dw $1528, $5F17, $15AE, $0000 ; entry 2
    dw $218C, $5F17, $15AE, $0044 ; entry 3
    dw $5D8C, $5F17, $5AB1, $0000 ; entry 4
    dw $218C, $5F17, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $7E0, $00
