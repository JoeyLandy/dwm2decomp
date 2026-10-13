SECTION "Bank 5C", ROMX[$4000], BANK[$5C]
    db $5c

; compressed tileset of map $C8 (the first map record using it)
; LZSS-compressed: 1493 bytes that expand to 1920 (E-0016, E-0017)
MapC8Tileset::
    INCBIN "dwm2-cobi-us.gbc", $170001, $5D5

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapC8Palettes::
    dw $7da0, $7fff, $01d3, $0063 ; entry 0
    dw $01d3, $7fff, $0348, $0006 ; entry 1
    dw $01c4, $03ff, $0348, $0084 ; entry 2
    dw $01c4, $7fff, $0348, $0084 ; entry 3
    dw $001f, $7fff, $0348, $0000 ; entry 4
    dw $00d0, $01d9, $0348, $0084 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; compressed tileset of map $C9 (the first map record using it)
; LZSS-compressed: 1262 bytes that expand to 2048 (E-0016, E-0017)
MapC9Tileset::
    INCBIN "dwm2-cobi-us.gbc", $170616, $4EE

MapC9Palettes::
    dw $3cc5, $7fff, $1415, $0000 ; entry 0
    dw $400c, $025c, $0015, $0000 ; entry 1
    dw $00ef, $5ad6, $2a13, $0000 ; entry 2
    dw $3cc5, $3f7f, $1415, $0000 ; entry 3
    dw $3cc5, $6ad8, $5d12, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $01c4, $03ff, $0348, $0084 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapC9Screens0::
    dfar MapC9Screens0_Y0X0 ; entry 0
    dfar MapC9Screens0_Y1X0 ; entry 1

MapC9Attrs0::
    dfar MapC9Attrs0_Y0X0 ; entry 0
    dfar MapC9Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 185 bytes that expand to 360 (E-0016, E-0017)
MapC9Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $170B50, $B9

; LZSS-compressed: 174 bytes that expand to 360 (E-0016, E-0017)
MapC9Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $170C09, $AE

; LZSS-compressed: 62 bytes that expand to 360 (E-0016, E-0017)
MapC9Attrs0_Y0X0::
    db $68, $01, $01, $04, $01, $00, $0f, $1a, $03, $03, $01, $2a, $06, $01, $00, $04
    db $01, $fe, $f2, $01, $fe, $f6, $01, $34, $0a, $01, $2e, $02, $01, $fe, $fa, $01
    db $fe, $f6, $02, $01, $7e, $03, $01, $00, $08, $01, $7e, $0c, $01, $7e, $04, $01
    db $7e, $08, $01, $a2, $0f, $4d, $01, $da, $0f, $19, $01, $7a, $0f, $13

; LZSS-compressed: 64 bytes that expand to 360 (E-0016, E-0017)
MapC9Attrs0_Y1X0::
    db $68, $01, $01, $04, $01, $00, $01, $02, $01, $06, $03, $01, $00, $02, $01, $00
    db $0f, $2b, $03, $03, $01, $04, $08, $01, $52, $00, $04, $04, $01, $fe, $f0, $01
    db $06, $06, $01, $fe, $f4, $01, $04, $0f, $13, $01, $06, $04, $01, $06, $08, $01
    db $a2, $0f, $4d, $01, $12, $0f, $1d, $01, $04, $02, $01, $3a, $1a, $01, $46, $1a

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapCAScreens0::
    dfar MapCAScreens0_Y0X0 ; entry 0
    dfar MapCAScreens0_Y1X0 ; entry 1

MapCAAttrs0::
    dfar MapCAAttrs0_Y0X0 ; entry 0
    dfar MapCAAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 192 bytes that expand to 360 (E-0016, E-0017)
MapCAScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $170D41, $C0

; LZSS-compressed: 211 bytes that expand to 360 (E-0016, E-0017)
MapCAScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $170E01, $D3

; LZSS-compressed: 83 bytes that expand to 360 (E-0016, E-0017)
MapCAAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $170ED4, $53

; LZSS-compressed: 74 bytes that expand to 360 (E-0016, E-0017)
MapCAAttrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $170F27, $4A

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapCEScreens0::
    dfar MapCEScreens0_Y0X0 ; entry 0
    dfar MapCEScreens0_Y1X0 ; entry 1

MapCEAttrs0::
    dfar MapCEAttrs0_Y0X0 ; entry 0
    dfar MapCEAttrs0_Y1X0 ; entry 1

; LZSS-compressed: 241 bytes that expand to 360 (E-0016, E-0017)
MapCEScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $170F7D, $F1

; LZSS-compressed: 206 bytes that expand to 360 (E-0016, E-0017)
MapCEScreens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $17106E, $CE

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
MapCEAttrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $17113C, $4D

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
MapCEAttrs0_Y1X0::
    db $68, $01, $00, $06, $06, $04, $00, $02, $01, $02, $02, $00, $02, $02, $04, $04
    db $06, $06, $00, $00, $0f, $2f, $02, $00, $56, $03, $00, $4a, $0f, $4d, $00, $6e
    db $0e, $00, $68, $02, $00, $c2, $0f, $0d, $00, $d0, $06, $00, $ec, $0f, $0d, $00
    db $1a, $16, $00, $16, $1f, $2b

; compressed tileset of map $D1 (the first map record using it)
; LZSS-compressed: 632 bytes that expand to 1664 (E-0016, E-0017)
MapD1Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1711BF, $278

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapD1Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $0152, $3f7f, $0218, $00c8 ; entry 1
    dw $026e, $3f7f, $02f3, $0188 ; entry 2
    dw $2130, $3f7f, $39d9, $00c8 ; entry 3
    dw $0018, $3f7f, $0218, $00c8 ; entry 4
    dw $7c01, $3f7f, $7fe1, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapD1Screens0::
    dfar MapD1Screens0_Y0X0 ; entry 0
    dfar MapD1Screens0_Y1X0 ; entry 1

MapD1Attrs0::
    dfar MapD1Attrs0_Y0X0 ; entry 0
    dfar MapD1Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 104 bytes that expand to 360 (E-0016, E-0017)
MapD1Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $171483, $68

; LZSS-compressed: 124 bytes that expand to 360 (E-0016, E-0017)
MapD1Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1714EB, $7C

; LZSS-compressed: 57 bytes that expand to 360 (E-0016, E-0017)
MapD1Attrs0_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $46, $01, $01, $01, $01, $00, $4a, $0f, $0d
    db $00, $5a, $00, $01, $01, $02, $02, $02, $02, $00, $74, $0f, $09, $00, $7e, $0f
    db $13, $00, $58, $02, $00, $84, $0a, $00, $ca, $0f, $01, $00, $cc, $0f, $13, $00
    db $58, $00, $00, $d0, $0c, $00, $18, $1f, $29

; LZSS-compressed: 67 bytes that expand to 360 (E-0016, E-0017)
MapD1Attrs0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1715A0, $43

; compressed tileset of map $D2 (the first map record using it)
; LZSS-compressed: 1272 bytes that expand to 1792 (E-0016, E-0017)
MapD2Tileset::
    INCBIN "dwm2-cobi-us.gbc", $1715E3, $4F8

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapD2Palettes::
    dw $3cc5, $7fff, $1415, $0000 ; entry 0
    dw $400c, $025c, $0015, $0000 ; entry 1
    dw $00ef, $5ad6, $2a13, $0000 ; entry 2
    dw $3cc5, $3f7f, $1415, $0000 ; entry 3
    dw $3cc5, $6ad8, $5d12, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0152, $3f7f, $0218, $00c8 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapD7Screens0::
    dfar MapD7Screens0_Y0X0 ; entry 0
    dfar MapD7Screens0_Y1X0 ; entry 1

MapD7Attrs0::
    dfar MapD7Attrs0_Y0X0 ; entry 0
    dfar MapD7Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 260 bytes that expand to 360 (E-0016, E-0017)
MapD7Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $171B27, $104

; LZSS-compressed: 215 bytes that expand to 360 (E-0016, E-0017)
MapD7Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $171C2B, $D7

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
MapD7Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $171D02, $4D

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
MapD7Attrs0_Y1X0::
    db $68, $01, $00, $06, $06, $04, $00, $02, $01, $02, $02, $00, $02, $02, $04, $04
    db $06, $06, $00, $00, $0f, $2f, $02, $00, $56, $03, $00, $4a, $0f, $4d, $00, $6e
    db $0e, $00, $68, $02, $00, $c2, $0f, $0d, $00, $d0, $06, $00, $ec, $0f, $0d, $00
    db $1a, $16, $00, $16, $1f, $2b

; compressed tileset of map $DA (the first map record using it)
; LZSS-compressed: 840 bytes that expand to 1536 (E-0016, E-0017)
MapDATileset::
    INCBIN "dwm2-cobi-us.gbc", $171D85, $348

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapDAPalettes::
    dw $0173, $7fff, $0235, $0063 ; entry 0
    dw $0110, $51ce, $0235, $0063 ; entry 1
    dw $0142, $03ff, $034e, $0000 ; entry 2
    dw $0110, $03ff, $034e, $0000 ; entry 3
    dw $384e, $03ff, $5956, $0000 ; entry 4
    dw $300c, $35b8, $4812, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapDAScreens0::
    dfar MapDAScreens0_Y0X0 ; entry 0
    dfar MapDAScreens0_Y0X1 ; entry 1

MapDAAttrs0::
    dfar MapDAAttrs0_Y0X0 ; entry 0
    dfar MapDAAttrs0_Y0X1 ; entry 1

; LZSS-compressed: 100 bytes that expand to 360 (E-0016, E-0017)
MapDAScreens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $172119, $64

; LZSS-compressed: 137 bytes that expand to 360 (E-0016, E-0017)
MapDAScreens0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $17217D, $89

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
MapDAAttrs0_Y0X0::
    db $68, $01, $00, $03, $00, $00, $0f, $44, $02, $00, $58, $03, $00, $4c, $0f, $0b
    db $00, $58, $04, $00, $5a, $08, $00, $7e, $0e, $00, $7e, $0a, $00, $9e, $0f, $07
    db $00, $56, $02, $00, $56, $0c, $00, $ce, $0f, $01, $00, $4e, $0a, $00, $f0, $0f
    db $11, $00, $00, $0f, $2d

; LZSS-compressed: 65 bytes that expand to 360 (E-0016, E-0017)
MapDAAttrs0_Y0X1::
    INCBIN "dwm2-cobi-us.gbc", $17223B, $41

; compressed tileset of map $DB (the first map record using it)
; LZSS-compressed: 1274 bytes that expand to 1792 (E-0016, E-0017)
MapDBTileset::
    INCBIN "dwm2-cobi-us.gbc", $17227C, $4FA

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
MapDBPalettes::
    dw $3cc5, $7fff, $1415, $0000 ; entry 0
    dw $400c, $025c, $0015, $0000 ; entry 1
    dw $00ef, $5ad6, $2a13, $0000 ; entry 2
    dw $3cc5, $3f7f, $1415, $0000 ; entry 3
    dw $3cc5, $6ad8, $5d12, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $0142, $03ff, $034e, $0000 ; entry 6
    dw $218c, $4f18, $3a52, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
MapE0Screens0::
    dfar MapE0Screens0_Y0X0 ; entry 0
    dfar MapE0Screens0_Y1X0 ; entry 1

MapE0Attrs0::
    dfar MapE0Attrs0_Y0X0 ; entry 0
    dfar MapE0Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
MapE0Screens0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $1727C2, $F5

; LZSS-compressed: 191 bytes that expand to 360 (E-0016, E-0017)
MapE0Screens0_Y1X0::
    INCBIN "dwm2-cobi-us.gbc", $1728B7, $BF

; LZSS-compressed: 77 bytes that expand to 360 (E-0016, E-0017)
MapE0Attrs0_Y0X0::
    INCBIN "dwm2-cobi-us.gbc", $172976, $4D

; LZSS-compressed: 54 bytes that expand to 360 (E-0016, E-0017)
MapE0Attrs0_Y1X0::
    db $68, $01, $00, $06, $06, $04, $00, $02, $01, $02, $02, $00, $02, $02, $04, $04
    db $06, $06, $00, $00, $0f, $2f, $02, $00, $56, $03, $00, $4a, $0f, $4d, $00, $6e
    db $0e, $00, $68, $02, $00, $c2, $0f, $0d, $00, $d0, $06, $00, $ec, $0f, $0d, $00
    db $1a, $16, $00, $16, $1f, $2b
    ds $1607, $00
