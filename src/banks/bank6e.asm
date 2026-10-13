SECTION "Bank 6E", ROMX[$4000], BANK[$6E]
    db $6e

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom45_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B8001, $D6

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B80D7, $E7

; LZSS-compressed: 159 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom61_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B81BE, $9F

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom45_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B825D, $46

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom37_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B82A3, $54

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom61_Y1X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B82F7, $42

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B8339, $51

KeyWorldRoom00_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B838A, $51

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B83DB, $4D

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B8428, $53

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B847B, $50

; LZSS-compressed: 89 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B84CB, $59

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B8524, $4E

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B8572, $5A

KeyWorldScreen_6E_45CC::
    INCBIN "dwm2-cobi-us.gbc", $1B85CC, $4E

KeyWorldScreen_6E_461A::
    INCBIN "dwm2-cobi-us.gbc", $1B861A, $50

; LZSS-compressed: 97 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_466A::
    INCBIN "dwm2-cobi-us.gbc", $1B866A, $61

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_46CB::
    INCBIN "dwm2-cobi-us.gbc", $1B86CB, $5C

; LZSS-compressed: 80 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8B_Y3X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B8727, $50

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_4777::
    INCBIN "dwm2-cobi-us.gbc", $1B8777, $51

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_47C8::
    INCBIN "dwm2-cobi-us.gbc", $1B87C8, $54

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B881C, $55

; compressed BG tiles (2048 bytes, 128 tiles): entry 3 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 916 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles3::
    INCBIN "dwm2-cobi-us.gbc", $1B8871, $394

; entry 3 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes3::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $24c6, $7fd9, $7fe0, $0063 ; entry 1
    dw $7da0, $7f75, $6b40, $0063 ; entry 2
    dw $7da0, $7fd9, $7380, $0063 ; entry 3
    dw $5d8c, $7fd9, $5ab1, $0000 ; entry 4
    dw $7da0, $7fd9, $7fe0, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $1529, $7fd9, $3631, $0063 ; entry 7

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B8C45, $80

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B8CC5, $DD

; LZSS-compressed: 181 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B8DA2, $B5

; LZSS-compressed: 224 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B8E57, $E0

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X0_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B8F37, $E5

; LZSS-compressed: 220 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B901C, $DC

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B90F8, $E6

KeyWorldRoom0A_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B91DE, $DC

; LZSS-compressed: 133 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_52BA::
    INCBIN "dwm2-cobi-us.gbc", $1B92BA, $85

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_533F::
    INCBIN "dwm2-cobi-us.gbc", $1B933F, $BE

; LZSS-compressed: 225 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_53FD::
    INCBIN "dwm2-cobi-us.gbc", $1B93FD, $E1

; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_54DE::
    INCBIN "dwm2-cobi-us.gbc", $1B94DE, $F5

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_55D3::
    INCBIN "dwm2-cobi-us.gbc", $1B95D3, $E6

; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_56B9::
    INCBIN "dwm2-cobi-us.gbc", $1B96B9, $E2

ScreenMap_6E_579B::
    INCBIN "dwm2-cobi-us.gbc", $1B979B, $E6

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_5881::
    INCBIN "dwm2-cobi-us.gbc", $1B9881, $E7

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y2X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $24, $0c, $03, $03, $03, $03, $00, $1c, $08, $00, $80, $0f, $01
    db $00, $7e, $04, $00, $9c, $0f, $13, $00, $d2, $02, $00, $c8, $0f, $09, $00, $1c
    db $0f, $4d, $00, $08, $1c

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B999D, $4A

; LZSS-compressed: 63 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y1X0_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $35, $01, $01, $03, $03, $00, $4c, $0f, $0d, $00, $04, $02, $03, $03, $00
    db $08, $0c, $00, $84, $0f, $03, $00, $58, $02, $00, $a0, $0f, $31, $00, $5a, $02
    db $00, $9e, $0e, $00, $fc, $0f, $01, $00, $9c

; LZSS-compressed: 2358 bytes that expand to 5391 (E-0016, E-0017)
Gfx_6E_5A20::
    db $0f, $15, $00, $0c, $0f, $09

; LZSS-compressed: 75 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B9A26, $4B

; LZSS-compressed: 84 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X0_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B9A71, $54

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B9AC5, $49

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B9B0E, $52

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B9B60, $47

; LZSS-compressed: 66 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5BA7::
    INCBIN "dwm2-cobi-us.gbc", $1B9BA7, $42

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5BE9::
    INCBIN "dwm2-cobi-us.gbc", $1B9BE9, $45

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5C2E::
    INCBIN "dwm2-cobi-us.gbc", $1B9C2E, $56

; LZSS-compressed: 108 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5C84::
    INCBIN "dwm2-cobi-us.gbc", $1B9C84, $6C

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5CF0::
    INCBIN "dwm2-cobi-us.gbc", $1B9CF0, $5C

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5D4C::
    INCBIN "dwm2-cobi-us.gbc", $1B9D4C, $5B

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5DA7::
    INCBIN "dwm2-cobi-us.gbc", $1B9DA7, $5E

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_5E05::
    INCBIN "dwm2-cobi-us.gbc", $1B9E05, $60

; compressed BG tiles (2048 bytes, 128 tiles): entry 4 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 1071 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles4::
    INCBIN "dwm2-cobi-us.gbc", $1B9E65, $42F

; entry 4 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes4::
    dw $000f, $7fff, $3c1f, $0063 ; entry 0
    dw $150b, $269f, $0157, $0044 ; entry 1
    dw $000f, $269f, $0157, $0044 ; entry 2
    dw $00cc, $269f, $01d5, $0044 ; entry 3
    dw $5d8c, $269f, $5ab1, $0000 ; entry 4
    dw $218c, $269f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 130 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA2D4, $82

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA356, $D5

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA42B, $E6

; LZSS-compressed: 214 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA511, $D6

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA5E7, $DA

; LZSS-compressed: 228 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA6C1, $E4

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA7A5, $D7

; LZSS-compressed: 201 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BA87C, $C9

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_6945::
    INCBIN "dwm2-cobi-us.gbc", $1BA945, $A2

; LZSS-compressed: 197 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_69E7::
    INCBIN "dwm2-cobi-us.gbc", $1BA9E7, $C5

; LZSS-compressed: 240 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_6AAC::
    INCBIN "dwm2-cobi-us.gbc", $1BAAAC, $F0

; LZSS-compressed: 231 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_6B9C::
    INCBIN "dwm2-cobi-us.gbc", $1BAB9C, $E7

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BAC83, $B8

; LZSS-compressed: 205 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4C_Y1X3_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BAD3B, $CD

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6E_6E08::
    INCBIN "dwm2-cobi-us.gbc", $1BAE08, $EC

; LZSS-compressed: 229 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4B_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1BAEF4, $E5

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y1X2_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $33, $03, $03, $00, $48, $0f, $09, $00, $08, $00, $00, $78, $02, $00, $6e
    db $0f, $11, $00, $6a, $0f, $01, $00, $6a, $0e, $00, $68, $0f, $01, $00, $54, $0f
    db $07, $00, $0a, $0f, $3d, $00, $0a, $0f, $0b

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB012, $47

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB059, $4D

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB0A6, $5A

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom04_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB100, $4E

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB14E, $53

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB1A1, $4F

; LZSS-compressed: 73 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB1F0, $49

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_7239::
    INCBIN "dwm2-cobi-us.gbc", $1BB239, $52

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_728B::
    INCBIN "dwm2-cobi-us.gbc", $1BB28B, $5B

; LZSS-compressed: 93 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_72E6::
    INCBIN "dwm2-cobi-us.gbc", $1BB2E6, $5D

; LZSS-compressed: 92 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_7343::
    INCBIN "dwm2-cobi-us.gbc", $1BB343, $5C

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB39F, $46

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4C_Y1X3_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB3E5, $4D

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6E_7432::
    INCBIN "dwm2-cobi-us.gbc", $1BB432, $4E

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom4B_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1BB480, $64

; compressed BG tiles (2048 bytes, 128 tiles): entry 5 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 764 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles5::
    INCBIN "dwm2-cobi-us.gbc", $1BB4E4, $2FC

; entry 5 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes5::
BGPaletteBufferData_6E_77E0::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $150b, $5f17, $15ae, $0044 ; entry 1
    dw $1528, $5f17, $15ae, $0000 ; entry 2
    dw $218c, $5f17, $15ae, $0044 ; entry 3
    dw $5d8c, $5f17, $5ab1, $0000 ; entry 4
    dw $218c, $5f17, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7
    ds $7e0, $00
