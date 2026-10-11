SECTION "Bank 6A", ROMX[$4000], BANK[$6A]
    db $6A

; compressed tileset of special map record 0 (SpecialMapRecords)
; LZSS-compressed asset: 1131 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap00Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A8001, $46B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap00Palettes::
Data_06A_446C:: ; address name
    dw $0220, $7FFF, $357B, $0000 ; entry 0
    dw $01C0, $3C1F, $03E2, $0000 ; entry 1
    dw $49AE, $6B79, $4ACD, $0000 ; entry 2
    dw $01C0, $3F7F, $03E2, $0000 ; entry 3
    dw $012F, $035F, $01DA, $0000 ; entry 4
    dw $1012, $4FFF, $3C1F, $0000 ; entry 5
    dw $7D68, $7FFF, $7F32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap00Screens::
Data_06A_44AC:: ; address name
    dfar Data_06A_44B8 ; entry 0
    dfar Data_06A_45B8 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap00Attrs::
Data_06A_44B2:: ; address name
    dfar Data_06A_46C8 ; entry 0
    dfar Data_06A_4707 ; entry 1

; LZSS-compressed asset: 256 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_44B8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A84B8, $100

; LZSS-compressed asset: 272 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_45B8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A85B8, $110

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_46C8:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $0F, $2E, $04, $01, $42, $01, $01, $34, $0B, $05
    db $05, $05, $05, $01, $47, $0F, $0A, $01, $FA, $F3, $01, $57, $00, $01, $77, $04
    db $01, $77, $0F, $04, $01, $00, $0A, $01, $9C, $0F, $0C, $01, $7F, $01, $01, $C0
    db $0F, $31, $01, $00, $03, $01, $CF, $05, $01, $00, $07, $01, $1F, $1F, $22

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_4707:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A8707, $5F

; compressed tileset of special map record 1 (SpecialMapRecords)
; LZSS-compressed asset: 1268 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap01Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_4766:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A8766, $4F4

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap01Palettes::
Data_06A_4C5A:: ; address name
    dw $00CE, $7FFF, $01DA, $0063 ; entry 0
    dw $1415, $3F7F, $029A, $0000 ; entry 1
    dw $01D3, $3F7F, $029A, $0000 ; entry 2
    dw $01C0, $3F7F, $03E2, $0000 ; entry 3
    dw $012F, $035F, $01DA, $0000 ; entry 4
    dw $1415, $035F, $3C1F, $0000 ; entry 5
    dw $7D68, $7FFF, $7F32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap01Screens::
Data_06A_4C9A:: ; address name
    dfar Data_06A_4CA6 ; entry 0
    dfar Data_06A_4DA6 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap01Attrs::
Data_06A_4CA0:: ; address name
    dfar Data_06A_4E92 ; entry 0
    dfar Data_06A_4ECB ; entry 1

; LZSS-compressed asset: 256 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_4CA6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A8CA6, $100

; LZSS-compressed asset: 236 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_4DA6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A8DA6, $EC

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_4E92:: ; heuristic: map screen stream; C0
    db $68, $01, $03, $02, $02, $01, $01, $02, $03, $04, $05, $03, $02, $04, $03, $02
    db $0F, $05, $03, $FA, $FC, $03, $2A, $0F, $05, $04, $05, $05, $05, $05, $04, $03
    db $00, $0A, $03, $56, $04, $03, $70, $08, $03, $57, $00, $05, $05, $03, $70, $0F
    db $4D, $03, $D0, $0F, $4D, $03, $08, $1F, $11

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_4ECB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A8ECB, $44

; compressed tileset of special map record 2 (SpecialMapRecords)
; LZSS-compressed asset: 1173 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap02Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_4F0F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A8F0F, $495

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap02Palettes::
Data_06A_53A4:: ; address name
    dw $31EF, $7FFF, $357B, $0000 ; entry 0
    dw $258C, $5BDF, $39F3, $0000 ; entry 1
    dw $31EF, $7FFF, $4ACD, $0000 ; entry 2
    dw $01C0, $3F7F, $03E2, $0000 ; entry 3
    dw $012F, $035F, $01DA, $0000 ; entry 4
    dw $1415, $4FFF, $3C1F, $0000 ; entry 5
    dw $7D68, $7FFF, $7F32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap02Screens::
Data_06A_53E4:: ; address name
    dfar Data_06A_53F0 ; entry 0
    dfar Data_06A_54C7 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap02Attrs::
Data_06A_53EA:: ; address name
    dfar Data_06A_55B6 ; entry 0
    dfar Data_06A_5626 ; entry 1

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_53F0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A93F0, $D7

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_54C7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A94C7, $EF

; LZSS-compressed asset: 112 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_55B6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A95B6, $70

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_5626:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A9626, $55

; compressed tileset of special map record 3 (SpecialMapRecords)
; LZSS-compressed asset: 1327 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap03Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_567B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A967B, $52F

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap03Palettes::
Data_06A_5BAA:: ; address name
    dw $1C2E, $7FFF, $357B, $0000 ; entry 0
    dw $1C2E, $5F17, $357B, $0000 ; entry 1
    dw $218C, $7FFF, $5AB1, $0000 ; entry 2
    dw $1586, $7FFF, $02C0, $0000 ; entry 3
    dw $012F, $035F, $01DA, $0000 ; entry 4
    dw $0015, $035F, $481F, $0000 ; entry 5
    dw $7D68, $7FFF, $7F32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap03Screens::
Data_06A_5BEA:: ; address name
    dfar Data_06A_5BF6 ; entry 0
    dfar Data_06A_5D16 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap03Attrs::
Data_06A_5BF0:: ; address name
    dfar Data_06A_5E29 ; entry 0
    dfar Data_06A_5E87 ; entry 1

; LZSS-compressed asset: 288 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_5BF6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A9BF6, $120

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_5D16:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A9D16, $113

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_5E29:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A9E29, $5E

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_5E87:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1A9E87, $53

; compressed tileset of special map record 4 (SpecialMapRecords)
; LZSS-compressed asset: 1126 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap04Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_5EDA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1A9EDA, $466

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap04Palettes::
Data_06A_6340:: ; address name
    dw $7DA0, $7FFF, $7D51, $0063 ; entry 0
    dw $1147, $4718, $3252, $0063 ; entry 1
    dw $012F, $357B, $1C2E, $0000 ; entry 2
    dw $01C0, $3F7F, $01DA, $0000 ; entry 3
    dw $012F, $035F, $01DA, $0000 ; entry 4
    dw $2010, $035F, $3C1F, $0000 ; entry 5
    dw $7D68, $7FFF, $7F32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap04Screens::
Data_06A_6380:: ; address name
    dfar Data_06A_638C ; entry 0
    dfar Data_06A_6485 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap04Attrs::
Data_06A_6386:: ; address name
    dfar Data_06A_657A ; entry 0
    dfar Data_06A_65D7 ; entry 1

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_638C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AA38C, $F9

; LZSS-compressed asset: 245 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_6485:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AA485, $F5

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_657A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AA57A, $5D

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_65D7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AA5D7, $69

; compressed tileset of special map record 5 (SpecialMapRecords)
; LZSS-compressed asset: 1138 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap05Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_6640:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AA640, $472

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap05Palettes::
Data_06A_6AB2:: ; address name
    dw $38A8, $7FFF, $3A33, $0000 ; entry 0
    dw $3C6B, $3A52, $2510, $0000 ; entry 1
    dw $194A, $5F17, $3A33, $0000 ; entry 2
    dw $1415, $5F17, $3A33, $0000 ; entry 3
    dw $012F, $035F, $01DA, $0000 ; entry 4
    dw $0000, $0000, $0000, $0000 ; entry 5
    dw $7D68, $7FFF, $7F32, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap05Screens::
Data_06A_6AF2:: ; address name
    dfar Data_06A_6AFE ; entry 0
    dfar Data_06A_6C30 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap05Attrs::
Data_06A_6AF8:: ; address name
    dfar Data_06A_6D58 ; entry 0
    dfar Data_06A_6DBD ; entry 1

; LZSS-compressed asset: 306 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_6AFE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AAAFE, $132

; LZSS-compressed asset: 296 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_6C30:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AAC30, $128

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_6D58:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AAD58, $65

; LZSS-compressed asset: 109 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_6DBD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AADBD, $6D

; compressed tileset of special map record 31 (SpecialMapRecords)
; LZSS-compressed asset: 712 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap1FTileset:: ; heuristic: special map tileset stream; C0
Data_06A_6E2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AAE2A, $2C8

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap1FPalettes::
Data_06A_70F2:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $014C, $0252, $01D0, $00C8 ; entry 1
    dw $5084, $7ED2, $61A8, $0044 ; entry 2
    dw $1986, $664E, $2A4A, $0044 ; entry 3
    dw $50C6, $664E, $61A8, $0044 ; entry 4
    dw $012F, $02FC, $01D5, $00C8 ; entry 5
    dw $218C, $4F18, $3A52, $0CA5 ; entry 6
    dw $218C, $4F18, $3A52, $0CA5 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1FScreens::
Data_06A_7132:: ; address name
    dfar Data_06A_7138 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap1FAttrs::
Data_06A_7135:: ; address name
    dfar Data_06A_7210 ; entry 0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_7138:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AB138, $D8

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_7210:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AB210, $5D

; compressed tileset of special map record 32 (SpecialMapRecords)
; LZSS-compressed asset: 712 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap20Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_726D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AB26D, $2C8

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap20Palettes::
Data_06A_7535:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $014C, $0252, $01D0, $00C8 ; entry 1
    dw $1094, $4A9F, $21B8, $0044 ; entry 2
    dw $1986, $3A1C, $2A4A, $0044 ; entry 3
    dw $1094, $3A1C, $21B8, $0044 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap20Screens::
Data_06A_7575:: ; address name
    dfar Data_06A_757B ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap20Attrs::
Data_06A_7578:: ; address name
    dfar Data_06A_765A ; entry 0

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_757B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AB57B, $DF

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_765A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AB65A, $68

; compressed tileset of special map record 33 (SpecialMapRecords)
; LZSS-compressed asset: 441 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SpecialMap21Tileset:: ; heuristic: special map tileset stream; C0
Data_06A_76C2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1AB6C2, $1B9

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
SpecialMap21Palettes::
Data_06A_787B:: ; address name
    dw $0173, $7FFF, $029A, $0084 ; entry 0
    dw $01D3, $3F7F, $029A, $00C8 ; entry 1
    dw $012F, $029A, $01D5, $0044 ; entry 2
    dw $2112, $7FFF, $39DA, $0000 ; entry 3
    dw $1528, $7FFF, $6B2B, $0020 ; entry 4
    dw $218C, $4F18, $3A52, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap21Screens::
Data_06A_78BB:: ; address name
    dfar Data_06A_78C1 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
SpecialMap21Attrs::
Data_06A_78BE:: ; address name
    dfar Data_06A_796F ; entry 0

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_78C1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AB8C1, $AE

; LZSS-compressed asset: 106 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_06A_796F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1AB96F, $6A
    ds $627, $00
