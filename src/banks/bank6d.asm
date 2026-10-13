SECTION "Bank 6D", ROMX[$4000], BANK[$6D]
    db $6d

; compressed BG tiles (2048 bytes, 128 tiles): entry 0 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 938 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles0::
    INCBIN "dwm2-cobi-us.gbc", $1B4001, $3AA

; entry 0 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes0::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $0140, $03e7, $01a0, $00a0 ; entry 1
    dw $012f, $3f7f, $01d5, $0044 ; entry 2
    dw $012f, $029a, $01d5, $0044 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 171 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B43EB, $AB

; LZSS-compressed: 208 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B4496, $D0

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B4566, $EE

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0B_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B4654, $BB

; LZSS-compressed: 221 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B470F, $DD

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B47EC, $E9

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B48D5, $D7

; LZSS-compressed: 227 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom16_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B49AC, $E3

; LZSS-compressed: 241 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_4A8F::
    INCBIN "dwm2-cobi-us.gbc", $1B4A8F, $F1

; LZSS-compressed: 160 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_4B80::
    INCBIN "dwm2-cobi-us.gbc", $1B4B80, $A0

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_4C20::
    INCBIN "dwm2-cobi-us.gbc", $1B4C20, $D3

; LZSS-compressed: 261 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_4CF3::
    INCBIN "dwm2-cobi-us.gbc", $1B4CF3, $105

; LZSS-compressed: 190 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_4DF8::
    INCBIN "dwm2-cobi-us.gbc", $1B4DF8, $BE

; LZSS-compressed: 209 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_4EB6::
    INCBIN "dwm2-cobi-us.gbc", $1B4EB6, $D1

; LZSS-compressed: 246 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B4F87, $F6

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom30_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B507D, $C0

; LZSS-compressed: 59 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $03, $01, $01, $01, $01, $00, $00, $04, $00, $00
    db $0f, $4d, $00, $18, $04, $00, $78, $04, $00, $72, $0e, $00, $82, $0f, $03, $00
    db $0a, $00, $00, $9e, $0c, $00, $ac, $06, $00, $84, $0f, $13, $00, $14, $0f, $1d
    db $00, $06, $00, $00, $10, $1f, $11, $00, $08, $0f, $0d

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom07_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B5178, $44

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B51BC, $52

KeyWorldRoom0B_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B520E, $44

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B5252, $4C

; LZSS-compressed: 98 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom10_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B529E, $62

; LZSS-compressed: 94 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom11_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B5300, $5E

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom16_Y2X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B535E, $58

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_53B6::
    INCBIN "dwm2-cobi-us.gbc", $1B53B6, $67

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_541D::
    INCBIN "dwm2-cobi-us.gbc", $1B541D, $46

; LZSS-compressed: 87 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_5463::
    INCBIN "dwm2-cobi-us.gbc", $1B5463, $57

; LZSS-compressed: 102 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_54BA::
    INCBIN "dwm2-cobi-us.gbc", $1B54BA, $66

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_5520::
    INCBIN "dwm2-cobi-us.gbc", $1B5520, $51

; LZSS-compressed: 78 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_5571::
    INCBIN "dwm2-cobi-us.gbc", $1B5571, $4E

; LZSS-compressed: 96 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom29_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B55BF, $60

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom30_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B561F, $4A

; compressed BG tiles (2048 bytes, 128 tiles): entry 1 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 909 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles1::
    INCBIN "dwm2-cobi-us.gbc", $1B5669, $38D

; entry 1 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes1::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $012f, $3f7f, $01d5, $0044 ; entry 1
    dw $012f, $3f7f, $01d5, $0044 ; entry 2
    dw $012f, $029a, $01d5, $0044 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $218c, $3f7f, $029a, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 162 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B5A36, $A2

; LZSS-compressed: 193 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B5AD8, $C1

; LZSS-compressed: 235 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B5B99, $EB

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B5C84, $EC

; LZSS-compressed: 242 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B5D70, $F2

; LZSS-compressed: 237 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B5E62, $ED

KeyWorldRoom0A_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B5F4F, $EC

KeyWorldRoom0A_Y0X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B603B, $ED

; LZSS-compressed: 152 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_6128::
    INCBIN "dwm2-cobi-us.gbc", $1B6128, $98

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_61C0::
    INCBIN "dwm2-cobi-us.gbc", $1B61C0, $DE

; LZSS-compressed: 257 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_629E::
    INCBIN "dwm2-cobi-us.gbc", $1B629E, $101

; LZSS-compressed: 226 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_639F::
    INCBIN "dwm2-cobi-us.gbc", $1B639F, $E2

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_6481::
    INCBIN "dwm2-cobi-us.gbc", $1B6481, $D7

; LZSS-compressed: 187 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_6558::
    INCBIN "dwm2-cobi-us.gbc", $1B6558, $BB

; LZSS-compressed: 244 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B6613, $F4

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y0X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B6707, $C0

; LZSS-compressed: 68 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B67C7, $44

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X1_Attrs::
    db $68, $01, $00, $02, $00, $00, $0f, $42, $03, $03, $01, $01, $01, $01, $03, $03
    db $00, $4a, $0f, $07, $00, $58, $00, $00, $5a, $00, $00, $7e, $02, $00, $78, $02
    db $00, $78, $0f, $07, $00, $9a, $0f, $37, $00, $00, $04, $00, $ec, $08, $00, $f0
    db $0f, $4d, $00, $00, $00

; LZSS-compressed: 76 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B6840, $4C

; LZSS-compressed: 91 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B688C, $5B

; LZSS-compressed: 81 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom1D_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B68E7, $51

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom09_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B6938, $52

; LZSS-compressed: 70 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B698A, $46

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y0X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B69D0, $4A

; LZSS-compressed: 69 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_6A1A::
    INCBIN "dwm2-cobi-us.gbc", $1B6A1A, $45

; LZSS-compressed: 101 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_6A5F::
    INCBIN "dwm2-cobi-us.gbc", $1B6A5F, $65

; LZSS-compressed: 90 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_6AC4::
    INCBIN "dwm2-cobi-us.gbc", $1B6AC4, $5A

; LZSS-compressed: 88 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_6B1E::
    INCBIN "dwm2-cobi-us.gbc", $1B6B1E, $58

; LZSS-compressed: 86 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_6B76::
    INCBIN "dwm2-cobi-us.gbc", $1B6B76, $56

; LZSS-compressed: 71 bytes that expand to 360 (E-0016, E-0017)
KeyWorldScreen_6D_6BCC::
    INCBIN "dwm2-cobi-us.gbc", $1B6BCC, $47

; LZSS-compressed: 82 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom06_Y1X2_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B6C13, $52

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom05_Y0X1_Attrs::
    INCBIN "dwm2-cobi-us.gbc", $1B6C65, $43

; compressed BG tiles (2048 bytes, 128 tiles): entry 2 of MapType5TilesetTable, decompressed to
; vTiles2 by LoadMapType5TilesetAndHeader
; LZSS-compressed: 913 bytes that expand to 2048 (E-0016, E-0017)
MapType5Tiles2::
    INCBIN "dwm2-cobi-us.gbc", $1B6CA8, $A4

; LZSS-compressed: 992 bytes that expand to 989 (E-0016, E-0017)
Gfx_6D_6D4C::
    INCBIN "dwm2-cobi-us.gbc", $1B6D4C, $2ED

; entry 2 of MapType5TilesetTable; copied to wBGPaletteBuffer (E-0140, C1)
; record: one CGB palette: 4 BGR555 colours
MapType5Palettes2::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $012f, $3f7f, $01d5, $0044 ; entry 1
    dw $012f, $3f7f, $01d5, $0044 ; entry 2
    dw $012f, $029a, $01d5, $0044 ; entry 3
    dw $5d8c, $3f7f, $5ab1, $0000 ; entry 4
    dw $7da0, $3f7f, $7fe0, $0000 ; entry 5
    dw $001b, $2bff, $023f, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; LZSS-compressed: 179 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom01_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B7079, $B3

; LZSS-compressed: 204 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom00_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B712C, $CC

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom02_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B71F8, $D5

; LZSS-compressed: 273 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom03_Y2X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B72CD, $111

; LZSS-compressed: 238 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom08_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B73DE, $EE

KeyWorldRoom09_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B74CC, $111

; LZSS-compressed: 265 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B75DD, $109

; LZSS-compressed: 233 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom0A_Y3X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B76E6, $E9

; LZSS-compressed: 178 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_77CF::
    INCBIN "dwm2-cobi-us.gbc", $1B77CF, $B2

; LZSS-compressed: 236 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_7881::
    INCBIN "dwm2-cobi-us.gbc", $1B7881, $EC

; LZSS-compressed: 243 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_796D::
    INCBIN "dwm2-cobi-us.gbc", $1B796D, $F3

; LZSS-compressed: 217 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_7A60::
    INCBIN "dwm2-cobi-us.gbc", $1B7A60, $D9

; LZSS-compressed: 218 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom8B_Y3X1_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B7B39, $DA

; LZSS-compressed: 213 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_7C13::
    INCBIN "dwm2-cobi-us.gbc", $1B7C13, $D5

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
ScreenMap_6D_7CE8::
    INCBIN "dwm2-cobi-us.gbc", $1B7CE8, $DE

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
KeyWorldRoom22_Y1X2_Tiles::
    INCBIN "dwm2-cobi-us.gbc", $1B7DC6, $CE
    ds $16c, $00
