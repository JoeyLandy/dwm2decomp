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
Data_06D_43AB:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0140, $03E7, $01A0, $00A0 ; entry 1
    dw $012F, $3F7F, $01D5, $0044 ; entry 2
    dw $012F, $029A, $01D5, $0044 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $218C, $3F7F, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y1X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_43EB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B43EB, $AB

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom07_Y1X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4496:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4496, $D0

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y2X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4566:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4566, $EE

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0B_Y2X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4654:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4654, $BB

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom10_Y2X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_470F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B470F, $DD

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom10_Y2X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_47EC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B47EC, $E9

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom11_Y1X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_48D5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B48D5, $D7

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom16_Y2X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_49AC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B49AC, $E3

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_4A8F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4A8F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4A8F, $F1

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_4B80:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4B80:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4B80, $A0

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_4C20:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4C20:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4C20, $D3

; LZSS-compressed asset: 261 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_4CF3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4CF3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4CF3, $105

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_4DF8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4DF8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4DF8, $BE

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_4EB6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4EB6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4EB6, $D1

; LZSS-compressed asset: 246 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom29_Y1X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_4F87:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B4F87, $F6

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom30_Y1X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_507D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B507D, $C0

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y1X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_513D:: ; address name
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0F, $4D, $00, $18, $04, $00, $78, $04, $00, $72, $0E, $00, $82, $0F, $03, $00
    db $0A, $00, $00, $9E, $0C, $00, $AC, $06, $00, $84, $0F, $13, $00, $14, $0F, $1D
    db $00, $06, $00, $00, $10, $1F, $11, $00, $08, $0F, $0D

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom07_Y1X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_5178:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5178, $44

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y2X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_51BC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B51BC, $52

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0B_Y2X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_520E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B520E, $44

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom10_Y2X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_5252:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5252, $4C

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom10_Y2X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_529E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B529E, $62

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom11_Y1X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_5300:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5300, $5E

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom16_Y2X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_535E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B535E, $58

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_53B6:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_53B6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B53B6, $67

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_541D:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_541D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B541D, $46

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_5463:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_5463:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5463, $57

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_54BA:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_54BA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B54BA, $66

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_5520:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_5520:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5520, $51

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_5571:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_5571:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5571, $4E

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom29_Y1X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_55BF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B55BF, $60

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom30_Y1X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_561F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B561F, $4A

; compressed BG tiles (2048 bytes, 128 tiles): entry 1 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 909 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles1:: ; heuristic: map type 5 tileset stream; C0
Data_06D_5669:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5669, $38D

; E-0140 (C1: entry 1 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes1::
Data_06D_59F6:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $012F, $3F7F, $01D5, $0044 ; entry 1
    dw $012F, $3F7F, $01D5, $0044 ; entry 2
    dw $012F, $029A, $01D5, $0044 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $218C, $3F7F, $029A, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom01_Y0X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_5A36:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5A36, $A2

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom06_Y1X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_5AD8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5AD8, $C1

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y0X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_5B99:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5B99, $EB

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y0X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_5C84:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5C84, $EC

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom1D_Y0X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_5D70:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5D70, $F2

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom09_Y0X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_5E62:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5E62, $ED

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0A_Y0X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_5F4F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B5F4F, $EC

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0A_Y0X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_603B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B603B, $ED

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_6128:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_6128:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6128, $98

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_61C0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_61C0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B61C0, $DE

; LZSS-compressed asset: 257 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_629E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_629E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B629E, $101

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_639F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_639F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B639F, $E2

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_6481:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_6481:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6481, $D7

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_6558:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_6558:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6558, $BB

; LZSS-compressed asset: 244 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom06_Y1X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_6613:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6613, $F4

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom05_Y0X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_6707:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6707, $C0

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom01_Y0X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_67C7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B67C7, $44

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom06_Y1X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_680B:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $42, $03, $03, $01, $01, $01, $01, $03, $03
    db $00, $4A, $0F, $07, $00, $58, $00, $00, $5A, $00, $00, $7E, $02, $00, $78, $02
    db $00, $78, $0F, $07, $00, $9A, $0F, $37, $00, $00, $04, $00, $EC, $08, $00, $F0
    db $0F, $4D, $00, $00, $00

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y0X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_6840:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6840, $4C

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y0X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_688C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B688C, $5B

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom1D_Y0X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_68E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B68E7, $51

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom09_Y0X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_6938:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6938, $52

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0A_Y0X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_698A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B698A, $46

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0A_Y0X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_69D0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B69D0, $4A

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_6A1A:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_6A1A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6A1A, $45

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_6A5F:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_6A5F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6A5F, $65

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_6AC4:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_6AC4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6AC4, $5A

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_6B1E:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_6B1E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6B1E, $58

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_6B76:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_6B76:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6B76, $56

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldScreen_6D_6BCC:: ; heuristic: key-world screen map found by tiling a gap after another; C0
Data_06D_6BCC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6BCC, $47

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom06_Y1X2_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_6C13:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6C13, $52

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom05_Y0X1_Attrs:: ; heuristic: key-world room screen attribute map; C0
Data_06D_6C65:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6C65, $43

; compressed BG tiles (2048 bytes, 128 tiles): entry 2 of MapType5TilesetTable, decompressed to vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed asset: 913 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MapType5Tiles2:: ; heuristic: map type 5 tileset stream; C0
Data_06D_6CA8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6CA8, $A4

; LZSS-compressed asset: 992 bytes expand to 989 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Gfx_6D_6D4C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_6D4C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B6D4C, $2ED

; E-0140 (C1: entry 2 of MapType5TilesetTable; copied to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes2::
Data_06D_7039:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $012F, $3F7F, $01D5, $0044 ; entry 1
    dw $012F, $3F7F, $01D5, $0044 ; entry 2
    dw $012F, $029A, $01D5, $0044 ; entry 3
    dw $5D8C, $3F7F, $5AB1, $0000 ; entry 4
    dw $7DA0, $3F7F, $7FE0, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom01_Y3X1_Tiles:: ; heuristic: key-world room screen tile map; C0
Data_06D_7079:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B7079, $B3

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom00_Y3X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_712C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B712C, $CC

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom02_Y2X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_71F8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B71F8, $D5

; LZSS-compressed asset: 273 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom03_Y2X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_72CD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B72CD, $111

; LZSS-compressed asset: 238 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom08_Y1X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_73DE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B73DE, $EE

; LZSS-compressed asset: 273 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom09_Y3X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_74CC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B74CC, $111

; LZSS-compressed asset: 265 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0A_Y3X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_75DD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B75DD, $109

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom0A_Y3X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_76E6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B76E6, $E9

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_77CF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_77CF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B77CF, $B2

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_7881:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_7881:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B7881, $EC

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_796D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_796D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B796D, $F3

; LZSS-compressed asset: 217 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_7A60:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_7A60:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B7A60, $D9

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom8B_Y3X1_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_7B39:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B7B39, $DA

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_7C13:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_7C13:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B7C13, $D5

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenMap_6D_7CE8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_7CE8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B7CE8, $DE

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldRoom22_Y1X2_Tiles:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_06D_7DC6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1B7DC6, $CE
    ds $16C, $00
