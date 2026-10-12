SECTION "Bank 49", ROMX[$4000], BANK[$49]
    db $49

; compressed tileset of map $15 (the first map record using it)
; LZSS-compressed asset: 651 bytes expand to 880 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map15Tileset:: ; heuristic: map tileset stream; C0
Data_049_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $124001, $28B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map15Palettes::
Data_049_428C:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $158F, $4FFF, $03E2, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $18EA ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map15Screens0::
Data_049_42CC:: ; address name
    dfar Map15Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map15Attrs0::
Data_049_42CF:: ; address name
    dfar Map15Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map15Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_42D2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1242D2, $E3

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map15Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_43B5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1243B5, $63

; compressed tileset of map $0A (the first map record using it)
; address loaded by EggServiceMenu_Case0F_DecompressToVRAM
; LZSS-compressed asset: 708 bytes expand to 1168 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0ATileset:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_049_4418:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $124418, $2C4

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map0APalettes::
BGPaletteBufferData_49_46DC:: ; heuristic: argument of a bank-switching copy helper; C0
Data_049_46DC:: ; address name
    dw $7D00, $7FFF, $7FE1, $0000 ; entry 0
    dw $7D00, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $001F, $2BFF, $0214, $0000 ; entry 4
    dw $1415, $67FF, $3C1F, $0000 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0AScreens0::
Data_049_471C:: ; address name
    dfar Map0AScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0AAttrs0::
Data_049_471F:: ; address name
    dfar Map0AAttrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0AScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_4722:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $124722, $D1

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0AAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_47F3:: ; address name
    db $68, $01, $06, $03, $03, $03, $03, $06, $F4, $FC, $06, $00, $0F, $41, $01, $06
    db $68, $07, $06, $10, $02, $05, $05, $05, $05, $02, $02, $04, $04, $02, $02, $02
    db $02, $06, $7A, $00, $06, $76, $0F, $05, $06, $82, $00, $06, $A2, $08, $06, $9E
    db $0F, $4D, $06, $D6, $0F, $1D, $06, $10, $04, $06, $3C, $1A, $06, $44, $1C

; compressed tileset of map $13 (the first map record using it)
; address loaded by RenameMenu_Case06_DecompressToVRAM
; LZSS-compressed asset: 659 bytes expand to 960 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map13Tileset:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_049_4832:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $124832, $293

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map13Palettes::
BGPaletteBufferData_49_4AC5:: ; heuristic: argument of a bank-switching copy helper; C0
Data_049_4AC5:: ; address name
    dw $7D86, $7FFF, $7FE1, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $012F, $67FF, $0214, $0000 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $158F, $4FFF, $03E2, $0000 ; entry 4
    dw $49AE, $7FFF, $4ACD, $0000 ; entry 5
    dw $29CE, $4FFF, $3695, $0020 ; entry 6
    dw $29CE, $4FFF, $3695, $18EA ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map13Screens0::
Data_049_4B05:: ; address name
    dfar Map13Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map13Attrs0::
Data_049_4B08:: ; address name
    dfar Map13Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map13Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_4B0B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $124B0B, $BF

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map13Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_4BCA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $124BCA, $51

; compressed tileset of map $1A (the first map record using it)
; address loaded by DebugStaffRoll_Scene04_DecompressToVRAM
; LZSS-compressed asset: 1696 bytes expand to 1984 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1ATileset:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_049_4C1B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $124C1B, $6A0

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map1APalettes::
BGPaletteBufferData_49_52BB:: ; heuristic: argument of a bank-switching copy helper; C0
Data_049_52BB:: ; address name
    dw $7D86, $7FFF, $7F26, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $01E0, $031D, $0214, $0020 ; entry 2
    dw $7D86, $1BF0, $02C0, $0000 ; entry 3
    dw $01E0, $1BF0, $02C0, $0000 ; entry 4
    dw $158F, $1BF0, $2A13, $0000 ; entry 5
    dw $012F, $1BF0, $02C0, $0000 ; entry 6
    dw $0020, $0020, $0020, $0020 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1AScreens0::
Data_049_52FB:: ; address name
    dfar Map1AScreens0_Y0X0 ; entry 0
    dfar Map1AScreens0_Y0X1 ; entry 1
    dfar Map1AScreens0_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1AAttrs0::
Data_049_5304:: ; address name
    dfar Map1AAttrs0_Y0X0 ; entry 0
    dfar Map1AAttrs0_Y0X1 ; entry 1
    dfar Map1AAttrs0_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1AScreens5::
Data_049_530D:: ; address name
    dfar Map1AScreens0_Y0X0 ; entry 0
    dfar Map1AScreens0_Y0X1 ; entry 1
    dfar Map1AScreens5_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map1AAttrs5::
Data_049_5316:: ; address name
    dfar Map1AAttrs0_Y0X0 ; entry 0
    dfar Map1AAttrs0_Y0X1 ; entry 1
    dfar Map1AAttrs5_Y0X2 ; entry 2

; address loaded by DebugStaffRoll_Scene04_DecompressToVRAM
; LZSS-compressed asset: 250 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AScreens0_Y0X0:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_049_531F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12531F, $FA

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_049_5419:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $125419, $112

; LZSS-compressed asset: 251 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AScreens0_Y0X2:: ; heuristic: map screen stream; C0
Data_049_552B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12552B, $FB

; LZSS-compressed asset: 263 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AScreens5_Y0X2:: ; heuristic: map screen stream; C0
Data_049_5626:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $125626, $107

; address loaded by DebugStaffRoll_Scene04_DecompressToVRAM
; LZSS-compressed asset: 163 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AAttrs0_Y0X0:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_049_572D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12572D, $A3

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_049_57D0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1257D0, $93

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AAttrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_049_5863:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $125863, $99

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map1AAttrs5_Y0X2:: ; heuristic: map screen stream; C0
Data_049_58FC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1258FC, $A4

; compressed tileset of map $0B (the first map record using it)
; LZSS-compressed asset: 1607 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0BTileset:: ; heuristic: map tileset stream; C0
Data_049_59A0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1259A0, $647

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map0BPalettes::
Data_049_5FE7:: ; address name
    dw $5400, $7FFF, $3071, $0000 ; entry 0
    dw $012F, $031D, $01D8, $0000 ; entry 1
    dw $306A, $46BF, $3071, $0020 ; entry 2
    dw $158F, $4298, $2A13, $0020 ; entry 3
    dw $306A, $6B79, $3071, $0000 ; entry 4
    dw $29CE, $4FFF, $3695, $0020 ; entry 5
    dw $001F, $46BF, $3071, $0020 ; entry 6
    dw $0B02, $46BF, $3071, $0020 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0BScreens0::
Data_049_6027:: ; address name
    dfar Map0BScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map0BAttrs0::
Data_049_602A:: ; address name
    dfar Map0BAttrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 271 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0BScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_602D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12602D, $10F

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map0BAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_613C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12613C, $96

; compressed tileset of map $22 (the first map record using it)
; LZSS-compressed asset: 650 bytes expand to 1088 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map22Tileset:: ; heuristic: map tileset stream; C0
Data_049_61D2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1261D2, $28A

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map22Palettes::
Data_049_645C:: ; address name
    dw $01D5, $7FFF, $029A, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0000 ; entry 1
    dw $012F, $029A, $01D5, $0000 ; entry 2
    dw $0248, $3F7F, $029A, $0000 ; entry 3
    dw $498C, $7FFF, $6652, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map22Screens0::
Data_049_649C:: ; address name
    dfar Map22Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map22Attrs0::
Data_049_649F:: ; address name
    dfar Map22Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map22Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_64A2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1264A2, $D1

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map22Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_6573:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $126573, $6E

; compressed tileset of map $23 (the first map record using it)
; LZSS-compressed asset: 676 bytes expand to 1088 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map23Tileset:: ; heuristic: map tileset stream; C0
Data_049_65E1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1265E1, $2A4

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map23Palettes::
Data_049_6885:: ; address name
    dw $01D5, $7FFF, $029A, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0000 ; entry 1
    dw $012F, $029A, $01D5, $0000 ; entry 2
    dw $0248, $3F7F, $029A, $0000 ; entry 3
    dw $498C, $7FFF, $6652, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map23Screens0::
Data_049_68C5:: ; address name
    dfar Map23Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map23Attrs0::
Data_049_68C8:: ; address name
    dfar Map23Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map23Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_68CB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1268CB, $C0

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map23Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_698B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12698B, $5B

; compressed tileset of map $24 (the first map record using it)
; LZSS-compressed asset: 1312 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Tileset:: ; heuristic: map tileset stream; C0
Data_049_69E6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1269E6, $520

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map24Palettes::
Data_049_6F06:: ; address name
    dw $014F, $7FFF, $029A, $0000 ; entry 0
    dw $0110, $3F7F, $0214, $0042 ; entry 1
    dw $0308, $3F7F, $029A, $0042 ; entry 2
    dw $2111, $3A5C, $21B8, $0044 ; entry 3
    dw $318C, $6318, $4A52, $0842 ; entry 4
    dw $7D68, $7FFF, $7F32, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map24Screens0::
Data_049_6F46:: ; address name
    dfar Map24Screens0_Y0X0 ; entry 0
    dfar Map24Screens0_Y0X1 ; entry 1
    dfar Map24Screens0_Y1X0 ; entry 2
    dfar Map24Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map24Attrs0::
Data_049_6F52:: ; address name
    dfar Map24Attrs0_Y0X0 ; entry 0
    dfar Map24Attrs0_Y0X1 ; entry 1
    dfar Map24Attrs0_Y1X0 ; entry 2
    dfar Map24Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_6F5E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $126F5E, $F1

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_049_704F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12704F, $BF

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_049_710E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12710E, $E3

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_049_71F1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1271F1, $E6

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_72D7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1272D7, $51

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_049_7328:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $127328, $52

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_049_737A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $12737A, $4F

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map24Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_049_73C9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1273C9, $4B

; compressed tileset of map $25 (the first map record using it)
; LZSS-compressed asset: 1170 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map25Tileset:: ; heuristic: map tileset stream; C0
Data_049_7414:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $127414, $492

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map25Palettes::
Data_049_78A6:: ; address name
    dw $0173, $7FFF, $6B2B, $0000 ; entry 0
    dw $01D3, $3F7F, $029A, $0042 ; entry 1
    dw $012F, $3F7F, $01DA, $0000 ; entry 2
    dw $2111, $3A5C, $21B8, $0044 ; entry 3
    dw $18D0, $3FFF, $01DA, $0042 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $0308, $3F7F, $029A, $0042 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map25Screens0::
Data_049_78E6:: ; address name
    dfar Map25Screens0_Y0X0 ; entry 0
    dfar Map25Screens0_Y0X1 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map25Attrs0::
Data_049_78EC:: ; address name
    dfar Map25Attrs0_Y0X0 ; entry 0
    dfar Map25Attrs0_Y0X1 ; entry 1

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map25Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_78F2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1278F2, $E8

; LZSS-compressed asset: 244 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map25Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_049_79DA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1279DA, $F4

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map25Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_7ACE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $127ACE, $4F

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map25Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_049_7B1D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $127B1D, $62

; compressed tileset of map $2D (the first map record using it)
; LZSS-compressed asset: 751 bytes expand to 880 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2DTileset:: ; heuristic: map tileset stream; C0
Data_049_7B7F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $127B7F, $2EF

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map2DPalettes::
Data_049_7E6E:: ; address name
    dw $318C, $7FFF, $4A52, $0000 ; entry 0
    dw $012F, $5AD6, $029A, $0042 ; entry 1
    dw $00EB, $5AD6, $318C, $0000 ; entry 2
    dw $2111, $3A5C, $21B8, $0044 ; entry 3
    dw $0000, $0000, $0000, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $0000, $0000, $0000, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2DScreens0::
Data_049_7EAE:: ; address name
    dfar Map2DScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map2DAttrs0::
Data_049_7EB1:: ; address name
    dfar Map2DAttrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2DScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_7EB4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $127EB4, $DF

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map2DAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_049_7F93:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $127F93, $5B
    ds $12, $00
