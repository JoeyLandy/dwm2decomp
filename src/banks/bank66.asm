SECTION "Bank 66", ROMX[$4000], BANK[$66]
    db $66

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 3: entry 3 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1188 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles3:: ; heuristic: key-world tileset stream; C0
Data_066_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198001, $4A4

KeyWorld06_0_Y3X1_Header:: ; heuristic: key-world screen header; C0
Data_066_44A5:: ; address name
    db $02, $02, $05, $06, $0B, $3A, $E9, $00

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld06_0_Y3X1_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_44AD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1984AD, $99

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4546::
KeyWorld05_0_Y3X2_Header:: ; heuristic: key-world screen header; C0
Data_066_4546:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $09, $EA, $00 ; entry 0

; LZSS-compressed asset: 102 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld05_0_Y3X2_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_454E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19854E, $66

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_45B4::
KeyWorld0A_0_Y1X2_Header:: ; heuristic: key-world screen header; C0
Data_066_45B4:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $09, $EB, $00 ; entry 0

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld0A_0_Y1X2_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_45BC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1985BC, $79

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4635::
KeyWorld05_0_Y3X1_Header:: ; heuristic: key-world screen header; C0
Data_066_4635:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $09, $EC, $00 ; entry 0

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld05_0_Y3X1_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_463D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19863D, $88

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_46C5::
KeyWorld04_0_Y3X2_Header:: ; heuristic: key-world screen header; C0
Data_066_46C5:: ; address name
    db $05, $00, $06, $07, $0B, $3A, $ED, $00 ; entry 0

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld04_0_Y3X2_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_46CD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1986CD, $C1

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_478E::
KeyWorld02_0_Y2X2_Header:: ; heuristic: key-world screen header; C0
Data_066_478E:: ; address name
    db $04, $03, $06, $07, $08, $3A, $EE, $00 ; entry 0

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld02_0_Y2X2_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4796:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198796, $C3

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4859::
KeyWorld00_0_Y3X1_Header:: ; heuristic: key-world screen header; C0
Data_066_4859:: ; address name
    db $FF, $00, $09, $0A, $0C, $3A, $EF, $00 ; entry 0

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y3X1_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4861:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198861, $B6

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4917::
KeyWorld00_0_Y3X2_Header:: ; heuristic: key-world screen header; C0
Data_066_4917:: ; address name
    db $FF, $00, $05, $07, $08, $3A, $F0, $00 ; entry 0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y3X2_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_491F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19891F, $D8

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_49F7::
KeyWorld27_1_Y3X1_Header:: ; heuristic: key-world screen header; C0
Data_066_49F7:: ; address name
    db $00, $06, $07, $09, $0E, $3A, $F1, $00 ; entry 0

; LZSS-compressed asset: 212 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld27_1_Y3X1_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_49FF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1989FF, $D4

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld06_0_Y3X1_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4AD3:: ; address name
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $40, $0F, $2C, $02, $FA, $FA, $02
    db $F4, $FF, $01, $02, $AE, $0F, $21, $02, $FE, $F2, $02, $F0, $FF, $01, $02, $A0
    db $FF, $45

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld05_0_Y3X2_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4AF5:: ; address name
    db $68, $01, $03, $01, $03, $00, $0F, $20, $02, $02, $03, $22, $0F, $11, $03, $34
    db $0F, $11, $02, $03, $7E, $01, $03, $70, $0F, $09, $03, $A0, $FF, $4D, $03, $FF
    db $0F, $4D, $03, $5F, $14

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld0A_0_Y1X2_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4B1A:: ; address name
    db $68, $01, $02, $01, $02, $00, $0F, $42, $02, $F8, $FF, $01, $02, $F8, $FE, $02
    db $F4, $FF, $01, $02, $F4, $FC, $02, $A0, $FF, $4D, $02, $FF, $0F, $4D, $02, $5F
    db $14

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld05_0_Y3X1_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4B3B:: ; address name
    db $68, $01, $03, $01, $03, $00, $0F, $20, $02, $02, $02, $02, $03, $24, $0F, $09
    db $03, $34, $00, $03, $FC, $F0, $03, $34, $00, $03, $36, $04, $03, $54, $0E, $03
    db $54, $04, $03, $FA, $F2, $03, $74, $0F, $05, $03, $A0, $FF, $4D, $03, $FF, $0F
    db $4D, $03, $5F, $14

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld04_0_Y3X2_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4B6F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198B6F, $51

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld02_0_Y2X2_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4BC0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198BC0, $44

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y3X1_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4C04:: ; address name
    db $68, $01, $02, $01, $02, $00, $0F, $4D, $02, $1E, $0F, $0A, $02, $FC, $FF, $01
    db $02, $FC, $FA, $02, $FE, $F2, $02, $FC, $F8, $02, $FC, $F4, $02, $A6, $0E, $02
    db $FA, $F8, $02, $FA, $F4, $02, $CC, $0E, $02, $F8, $FA, $02, $EC, $0F, $0F, $02
    db $21, $1F, $33

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y3X2_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4C37:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198C37, $42

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld27_1_Y3X1_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_4C79:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198C79, $5D

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4CD6::
KeyWorld02_0_Y2X3_Header:: ; heuristic: key-world screen header; C0
Data_066_4CD6:: ; address name
    db $00, $00, $02, $09, $0A, $3B, $F2, $00 ; entry 0

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld02_0_Y2X3_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4CDE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198CDE, $9F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4D7D::
KeyWorld00_0_Y3X3_Header:: ; heuristic: key-world screen header; C0
Data_066_4D7D:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $0A, $F3, $00 ; entry 0

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y3X3_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4D85:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198D85, $5F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4DE4::
KeyWorld01_0_Y3X2_Header:: ; heuristic: key-world screen header; C0
Data_066_4DE4:: ; address name
    db $FF, $00, $02, $08, $09, $24, $F4, $00 ; entry 0

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y3X2_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4DEC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198DEC, $82

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4E6E::
KeyWorld01_0_Y2X3_Header:: ; heuristic: key-world screen header; C0
Data_066_4E6E:: ; address name
    db $00, $FF, $FF, $FF, $FF, $24, $F5, $00 ; entry 0

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y2X3_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4E76:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198E76, $81

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4EF7::
KeyWorld08_0_Y3X3_Header:: ; heuristic: key-world screen header; C0
Data_066_4EF7:: ; address name
    db $02, $00, $09, $0A, $0C, $3B, $F6, $00 ; entry 0

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld08_0_Y3X3_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4EFF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198EFF, $5B

; LZSS-compressed asset: 560 bytes expand to 563 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_4F5A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $33, $02, $90, $06, $02, $1C, $02, $00, $01, $00, $07, $02, $58, $02, $02, $AA
    db $09, $17, $02, $6C, $02, $02, $BE, $09, $0B, $02, $A0, $02, $02, $AA, $09, $02
    db $0C, $00, $33, $02, $E4, $0B, $02, $0B, $00, $0B, $0C, $0D, $02, $20, $12, $0E
    db $02, $01, $16, $02, $2D, $19, $02, $2D, $1F, $00, $02, $2B, $1F, $02

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_4F98::
KeyWorld03_0_Y2X2_Header:: ; heuristic: key-world screen header; C0
Data_066_4F98:: ; address name
    db $02, $00, $06, $0D, $0F, $3B, $F7, $00 ; entry 0

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld03_0_Y2X2_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_4FA0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $198FA0, $BC

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_505C::
KeyWorld10_1_Y3X3_Header:: ; heuristic: key-world screen header; C0
Data_066_505C:: ; address name
    db $FF, $04, $0B, $0C, $0E, $3B, $F8, $00 ; entry 0

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld10_1_Y3X3_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_5064:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199064, $B1

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_5115::
KeyWorld05_0_Y3X3_Header:: ; heuristic: key-world screen header; C0
Data_066_5115:: ; address name
    db $FF, $07, $09, $0C, $0F, $3B, $F9, $00 ; entry 0

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld05_0_Y3X3_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_511D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19911D, $6D

; LZSS-compressed asset: 560 bytes expand to 567 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_518A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $37, $02, $C2, $0B, $27, $42, $43, $02, $34, $04, $02, $DE, $04, $36, $37, $52
    db $53, $02, $48, $04, $02, $0C, $03, $07, $02, $2E, $04, $20, $21, $0E, $02, $B3
    db $04, $17, $02, $42, $04, $30, $00, $01, $02, $C7, $04, $0B, $02, $A0, $04, $0E
    db $01, $00, $02, $B3, $0A, $02, $0C, $03

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_51C2::
KeyWorld0F_0_Y3X1_Header:: ; heuristic: key-world screen header; C0
Data_066_51C2:: ; address name
    db $00, $06, $08, $09, $0D, $3B, $FA, $00 ; entry 0

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld0F_0_Y3X1_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_51CA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1991CA, $D6

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld02_0_Y2X3_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_52A0:: ; address name
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $13, $02, $F4, $FF, $01, $02
    db $30, $0F, $29, $02, $04, $08, $02, $78, $0F, $01, $02, $22, $0F, $43, $02, $F5
    db $0F, $4D, $02, $55, $1E

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y3X3_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_52C5:: ; address name
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $39, $02, $02, $03, $F4, $FE
    db $03, $56, $0F, $01, $03, $F2, $FF, $01, $03, $A0, $FF, $4D, $03, $F1, $0F, $4D
    db $03, $51, $1F, $03

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y3X2_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_52E9:: ; address name
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $15, $02, $08, $06, $02, $28
    db $0F, $2D, $02, $74, $08, $02, $74, $0F, $05, $02, $F8, $F6, $02, $EE, $FF, $01
    db $02, $A0, $FF, $4D, $02, $1D, $1F, $37

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y2X3_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5311:: ; address name
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $13, $02, $02, $03, $1E, $0F
    db $11, $02, $02, $03, $44, $0F, $11, $03, $56, $00, $03, $6C, $0F, $0D, $03, $FA
    db $F2, $03, $90, $0F, $01, $03, $90, $0F, $03, $03, $CF, $0F, $4D, $03, $2F, $1F
    db $25

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld08_0_Y3X3_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5342:: ; address name
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $3D, $02, $06, $06, $02, $50
    db $0F, $29, $02, $4C, $0C, $02, $9C, $0F, $31, $02, $FC, $F8, $02, $EC, $0F, $0D
    db $02, $1F, $1F, $35

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld03_0_Y2X2_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5366:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199366, $47

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld10_1_Y3X3_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_53AD:: ; address name
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $19, $02, $06

; LZSS-compressed asset: 501 bytes expand to 514 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_53BA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $02, $02, $28, $0F, $0B, $02, $02, $06, $02, $50, $0F, $29, $02, $FE, $F4, $02
    db $32, $06, $02, $9E, $0F, $0F, $02, $F6, $FC, $02, $F0, $FF, $01, $02, $E4, $0F
    db $11, $02, $1B, $1F, $39

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld05_0_Y3X3_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_53DF:: ; address name
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $13, $02, $03, $30, $05, $03
    db $26, $0F, $0B, $03, $2C, $06, $03, $4E, $0F, $0F, $03, $2C, $02, $03, $76, $0F
    db $03, $03, $F2, $FC, $03, $9C, $0F, $37, $03, $5A, $06, $03, $F0, $0F, $09, $03
    db $FA, $0F, $13, $03, $45, $1F, $0F

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld0F_0_Y3X1_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5416:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199416, $61

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_5477::
KeyWorld02_0_Y0X0_Header:: ; heuristic: key-world screen header; C0
Data_066_5477:: ; address name
    db $07, $05, $06, $0C, $0D, $3E, $0D, $01 ; entry 0

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld02_0_Y0X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_547F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19947F, $7E

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_54FD::
KeyWorld00_0_Y0X0_Header:: ; heuristic: key-world screen header; C0
Data_066_54FD:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $0D, $0E, $01 ; entry 0

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y0X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_5505:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199505, $5B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_5560::
KeyWorld01_0_Y1X0_Header:: ; heuristic: key-world screen header; C0
Data_066_5560:: ; address name
    db $FF, $06, $07, $0C, $0F, $27, $0F, $01 ; entry 0

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y1X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_5568:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199568, $47

; LZSS-compressed asset: 522 bytes expand to 519 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_55AF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $07, $02, $D0, $08, $02, $DA, $03, $17, $02, $E4, $08, $02, $EE, $03, $0B, $22
    db $23, $02, $F8, $0D, $00, $01, $33, $02, $0C, $1D, $01, $00, $0B, $0C, $23, $02
    db $FC, $04, $02, $2A, $15, $02, $31, $11, $02, $12, $12, $50, $51

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_55DC::
KeyWorld01_0_Y0X1_Header:: ; heuristic: key-world screen header; C0
Data_066_55DC:: ; address name
    db $FF, $09, $0A, $0D, $0F, $27, $10, $01 ; entry 0

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y0X1_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_55E4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1995E4, $74

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_5658::
KeyWorld0B_0_Y0X0_Header:: ; heuristic: key-world screen header; C0
Data_066_5658:: ; address name
    db $05, $02, $05, $06, $0C, $3E, $11, $01 ; entry 0

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld0B_0_Y0X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_5660:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199660, $A5

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_5705::
KeyWorld04_0_Y0X0_Header:: ; heuristic: key-world screen header; C0
Data_066_5705:: ; address name
    db $07, $00, $08, $09, $07, $3E, $12, $01 ; entry 0

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld04_0_Y0X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_570D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19970D, $AC

; LZSS-compressed asset: 519 bytes expand to 519 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_57B9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $07, $02, $F6, $0A, $02, $02, $11, $17, $02, $0A, $1A, $02, $16, $11, $0B, $0C
    db $0D, $0C, $0D, $02, $F2, $00, $02, $24, $17, $02, $00, $02, $33, $02, $66, $06

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_57D9::
KeyWorld17_1_Y2X1_Header:: ; heuristic: key-world screen header; C0
Data_066_57D9:: ; address name
    db $FF, $00, $03, $04, $0A, $3E, $13, $01 ; entry 0

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld17_1_Y2X1_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_57E1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1997E1, $BB

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_589C::
KeyWorld10_1_Y0X0_Header:: ; heuristic: key-world screen header; C0
Data_066_589C:: ; address name
    db $FF, $00, $03, $07, $09, $3E, $14, $01 ; entry 0

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld10_1_Y0X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_58A4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1998A4, $C7

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_596B::
KeyWorld07_0_Y0X0_Header:: ; heuristic: key-world screen header; C0
Data_066_596B:: ; address name
    db $07, $02, $06, $07, $09, $3E, $15, $01 ; entry 0

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld07_0_Y0X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_5973:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199973, $4D

; LZSS-compressed asset: 539 bytes expand to 536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_59C0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1999C0, $7B

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld02_0_Y0X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5A3B:: ; address name
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $1E, $0F, $0B, $01, $02, $7E, $03, $02
    db $72, $0F, $15, $02, $80, $08, $02, $A6, $0F, $29, $02, $A2, $0A, $02, $F0, $0F
    db $4D, $02, $82, $00

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld00_0_Y0X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5A5F:: ; address name
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $50, $0F, $3D, $01, $01, $01, $01, $02
    db $A0, $0F, $0F, $02, $B0, $00, $02, $C6, $0F, $0F, $02, $D6, $02, $02, $EE, $0F
    db $0D, $02, $FC, $04, $02, $16, $1F, $2B

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y1X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5A87:: ; address name
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $28, $0F, $15, $01, $01, $02, $76, $0F
    db $0F, $01, $02, $AC, $03, $02, $A0, $0F, $09, $02, $AC, $04, $02, $C4, $0F, $0B
    db $02, $D0, $08, $02, $EE, $0F, $09, $02, $CE, $0F, $15, $02, $CC, $0A, $02, $40
    db $1F, $01

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y0X1_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5AB9:: ; address name
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $22, $0F, $0F, $02, $02, $02, $02, $03
    db $72, $0F, $15, $02, $02, $01, $01, $01, $01, $03, $A0, $0F, $0D, $03, $B0, $00
    db $03, $C4, $0F, $4D, $03, $E8, $0E, $03, $E8, $04, $03, $3E, $1F, $03

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld0B_0_Y0X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5AE7:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $03, $02, $20, $0F, $15, $02
    db $30, $08, $02, $54, $0F, $29, $02, $52, $0A, $02, $32, $04, $02, $A6, $0F, $01
    db $02, $52, $0F, $4B, $02, $18, $1F, $29

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld04_0_Y0X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5B0F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199B0F, $4B

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld17_1_Y2X1_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5B5A:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $17, $01, $01, $02, $18, $0F, $15, $02, $2A, $06
    db $02, $2A, $04, $02, $52, $0F, $0B, $02, $7A, $0F, $0F, $02, $2A, $02, $02, $A2
    db $02, $02, $2A, $00, $02, $A2, $0F, $07, $02, $CA, $08, $02, $C8, $0F, $2B, $02
    db $A8, $08, $02, $12, $1F, $0D, $02, $1A, $1A, $02, $40, $1F, $01

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld10_1_Y0X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5B97:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199B97, $42

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld07_0_Y0X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_5BD9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199BD9, $59

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_5C32::
KeyWorld52_0_Y3X3_Header:: ; heuristic: key-world screen header; C0
Data_066_5C32:: ; address name
    db $FF, $03, $08, $09, $0A, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 142 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld52_0_Y3X3_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_5C3A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $199C3A, $8E

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_66_5CC8::
KeyWorld01_0_Y0X0_Header:: ; heuristic: key-world screen header; C0
Data_066_5CC8:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y0X0_Tiles:: ; heuristic: key-world screen tile map; C0
Data_066_5CD0:: ; address name
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_66_5CEC::
Data_066_5CEC:: ; address name
    db $FF, $02, $05, $0A, $0D, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5CF4:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $199CF4, $9B

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_66_5D8F::
Data_066_5D8F:: ; address name
    db $FF, $04, $05, $06, $0B, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5D97:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $199D97, $C6

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_66_5E5D::
Data_066_5E5D:: ; address name
    db $FF, $03, $04, $08, $0D, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 185 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5E65:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $199E65, $B9

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_66_5F1E::
Data_066_5F1E:: ; address name
    db $FF, $06, $07, $08, $09, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5F26:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $199F26, $9F

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_66_5FC5::
Data_066_5FC5:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_5FCD:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $199FCD, $85

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_66_6052::
Data_066_6052:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_605A:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $19A05A, $76

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_66_60D0::
Data_066_60D0:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $32, $16, $01 ; entry 0

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_60D8:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $19A0D8, $60

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld52_0_Y3X3_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_6138:: ; address name
    db $68, $01, $02, $02, $FF, $FF, $1B, $01, $02, $2E, $03, $02, $22, $0F, $0B, $02
    db $2E, $04, $02, $32, $08, $02, $54, $0F, $4D, $02, $B4, $0F, $41, $02, $2C, $0F
    db $15, $02, $43, $1F, $11

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorld01_0_Y0X0_Attrs:: ; heuristic: key-world screen attribute map; C0
Data_066_615D:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6170:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $01, $02, $1E, $0F, $19, $02
    db $30, $06, $02, $54, $0F, $0B, $02, $22, $0F, $29, $02, $1C, $0F, $03, $02, $30
    db $0A, $02, $D2, $0F, $2F, $02, $AA, $0F, $15, $02, $4F, $1F, $05

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_619D:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $19A19D, $42

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_61DF:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $01, $01, $FF, $FF, $1D, $02, $02, $02, $02, $01, $20, $0F, $0D, $01
    db $30, $00, $01, $54, $02, $01, $4A, $0F, $15, $01, $30, $06, $01, $7C, $0E, $01
    db $96, $0A, $01, $4E, $0A, $01, $AA, $0F, $21, $01, $52, $04, $01, $2C, $0A, $01
    db $F4, $0F, $01, $01, $26, $0F, $1B, $01, $49, $1F, $0B

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_621A:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $03, $03, $FF, $FF, $19, $01, $03, $2C, $07, $03, $24, $0F, $07, $03
    db $2C, $00, $02, $03, $56, $03, $03, $34, $04, $03, $52, $0F, $03, $03, $5A, $04
    db $03, $5A, $02, $03, $76, $0F, $09, $03, $2C, $04, $03, $9A, $0F, $0D, $03, $7E
    db $0F, $13, $03, $54, $0F, $13, $03, $2A, $0F, $15, $03, $41, $1F, $13

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_6258:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $02, $02, $FF, $FF, $41, $01, $02, $54, $01, $02, $46, $0F, $0F, $02
    db $02, $0F, $41, $02, $50, $04, $02, $C4, $0F, $09, $02, $EA, $0F, $15, $02, $1B
    db $1F, $39

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_627A:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $46, $0F, $33, $01, $01, $01, $01, $03
    db $96, $0F, $0F, $03, $A6, $00, $03, $A6, $0C, $03, $CC, $0F, $03, $02, $02, $03
    db $E4, $0F, $11, $00, $00, $02, $02, $02, $02, $03, $46, $0C, $03, $1E, $1F, $01
    db $03, $45, $1F, $0F

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_066_62AE:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $02, $02, $FF, $FF, $41, $01, $02, $54, $07, $02, $4C, $0F, $0B, $04
    db $02, $7E, $03, $02, $72, $0F, $0F, $02, $54, $00, $02, $98, $0F, $11, $02, $80
    db $0F, $13, $02, $56, $0F, $13, $02, $1B, $1F, $39

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map54Screens0::
Data_066_62D8:: ; address name
    dfar Map54Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map54Attrs0::
Data_066_62DB:: ; address name
    dfar Map54Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map54Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_62DE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19A2DE, $D7

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map54Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_63B5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19A3B5, $4D

; compressed tileset of map $62 (the first map record using it)
; LZSS-compressed asset: 1152 bytes expand to 1312 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Tileset:: ; heuristic: map tileset stream; C0
Data_066_6402:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19A402, $480

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map62Palettes::
Data_066_6882:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $194C, $7FFF, $01DA, $0000 ; entry 1
    dw $001B, $2BFF, $023F, $0000 ; entry 2
    dw $218C, $7FFF, $5AB1, $0000 ; entry 3
    dw $194C, $3A9A, $01DA, $0000 ; entry 4
    dw $0142, $7FFF, $7E80, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $0000 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map62Screens0::
Data_066_68C2:: ; address name
    dfar Map62Screens0_Y0X0 ; entry 0
    dfar Map62Screens0_Y0X1 ; entry 1
    dfar Map62Screens0_Y1X0 ; entry 2
    dfar Map62Screens0_Y1X1 ; entry 3
    dfar Map62Screens0_Y2X0 ; entry 4
    dfar Map62Screens0_Y2X1 ; entry 5
    dfar Map62Screens0_Y3X0 ; entry 6
    dfar Map62Screens0_Y3X1 ; entry 7

; E-0142 (derived: 8 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map62Attrs0::
Data_066_68DA:: ; address name
    dfar Map62Attrs0_Y0X0 ; entry 0
    dfar Map62Attrs0_Y0X1 ; entry 1
    dfar Map62Attrs0_Y1X0 ; entry 2
    dfar Map62Attrs0_Y1X1 ; entry 3
    dfar Map62Attrs0_Y2X0 ; entry 4
    dfar Map62Attrs0_Y2X1 ; entry 5
    dfar Map62Attrs0_Y3X0 ; entry 6
    dfar Map62Attrs0_Y3X1 ; entry 7

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_68F2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19A8F2, $C5

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_69B7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19A9B7, $E8

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_6A9F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AA9F, $B4

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_6B53:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AB53, $B4

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y2X0:: ; heuristic: map screen stream; C0
Data_066_6C07:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AC07, $AF

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y2X1:: ; heuristic: map screen stream; C0
Data_066_6CB6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19ACB6, $90

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y3X0:: ; heuristic: map screen stream; C0
Data_066_6D46:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AD46, $AB

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Screens0_Y3X1:: ; heuristic: map screen stream; C0
Data_066_6DF1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19ADF1, $DD

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_6ECE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AECE, $5C

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_6F2A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AF2A, $61

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_6F8B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AF8B, $41

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_6FCC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19AFCC, $54

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y2X0:: ; heuristic: map screen stream; C0
Data_066_7020:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B020, $52

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y2X1:: ; heuristic: map screen stream; C0
Data_066_7072:: ; address name
    db $68, $01, $00, $01, $01, $04, $04, $01, $00, $04, $0D, $00, $02, $0F, $31, $00
    db $02, $08, $00, $52, $08, $03, $03, $00, $60, $0F, $01, $00, $86, $00, $00, $78
    db $0F, $4B, $00, $04, $02, $00, $86, $02, $00, $F0, $04, $00, $EA, $0F, $1B, $00
    db $0E, $0C, $00, $22, $18, $00, $34, $1F, $09, $00, $04, $00

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y3X0:: ; heuristic: map screen stream; C0
Data_066_70AE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B0AE, $4F

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map62Attrs0_Y3X1:: ; heuristic: map screen stream; C0
Data_066_70FD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B0FD, $62

; compressed tileset of map $63 (the first map record using it)
; LZSS-compressed asset: 856 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Tileset:: ; heuristic: map tileset stream; C0
Data_066_715F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B15F, $358

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map63Palettes::
Data_066_74B7:: ; address name
    dw $294A, $7FFF, $5294, $0000 ; entry 0
    dw $24C6, $7FD9, $5AB1, $0063 ; entry 1
    dw $7DA0, $7F75, $6B40, $0063 ; entry 2
    dw $7DA0, $7FD9, $7380, $0063 ; entry 3
    dw $5D8C, $7FD9, $5AB1, $0000 ; entry 4
    dw $7DA0, $7FD9, $7FE0, $0000 ; entry 5
    dw $001B, $2BFF, $023F, $0000 ; entry 6
    dw $218C, $4F18, $3A52, $03E0 ; entry 7

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map63Screens0::
Data_066_74F7:: ; address name
    dfar Map63Screens0_Y0X0 ; entry 0
    dfar Map63Screens0_Y0X1 ; entry 1
    dfar Map63Screens0_Y1X0 ; entry 2
    dfar Map63Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map63Attrs0::
Data_066_7503:: ; address name
    dfar Map63Attrs0_Y0X0 ; entry 0
    dfar Map63Attrs0_Y0X1 ; entry 1
    dfar Map63Attrs0_Y1X0 ; entry 2
    dfar Map63Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_750F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B50F, $95

; LZSS-compressed asset: 168 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_75A4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B5A4, $A8

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_764C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B64C, $9B

; LZSS-compressed asset: 114 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_76E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B6E7, $72

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_7759:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B759, $45

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_779E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B79E, $49

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_77E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B7E7, $4E

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map63Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_7835:: ; address name
    db $68, $01, $01, $03, $03, $03, $03, $01, $F6, $FA, $02, $02, $01, $00, $0F, $29
    db $04, $04, $04, $04, $01, $F8, $F8, $01, $10, $00, $01, $F4, $FC, $01, $60, $0A
    db $01, $5C, $02, $01, $74, $0F, $0B, $01, $82, $04, $01, $9A, $0F, $07, $01, $A6
    db $08, $01, $C0, $0F, $4D, $01, $A8, $08, $01, $3E, $1F, $15

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map64Screens0::
Data_066_7871:: ; address name
    dfar Map64Screens0_Y0X0 ; entry 0
    dfar Map64Screens0_Y0X1 ; entry 1
    dfar Map64Screens0_Y1X0 ; entry 2
    dfar Map64Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map64Attrs0::
Data_066_787D:: ; address name
    dfar Map64Attrs0_Y0X0 ; entry 0
    dfar Map64Attrs0_Y0X1 ; entry 1
    dfar Map64Attrs0_Y1X0 ; entry 2
    dfar Map64Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_7889:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B889, $B0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_7939:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B939, $A2

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_79DB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19B9DB, $82

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_7A5D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BA5D, $84

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_7AE1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BAE1, $67

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_7B48:: ; address name
    db $68, $01, $01, $02, $01, $00, $0F, $3C, $03, $03, $04, $04, $03, $01, $54, $01
    db $01, $52, $00, $01, $52, $00, $01, $4E, $00, $00, $00, $01, $54, $0C, $04, $04
    db $01, $66, $0E, $01, $FC, $F0, $01, $7C, $0F, $4D, $01, $B4, $0F, $17, $01, $54
    db $02, $01, $0C, $1F, $0D, $01, $4C, $02, $01, $3E, $0F, $01, $01, $00, $0A

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_7B87:: ; address name
    db $68, $01, $00, $02, $02, $03, $03, $02, $00, $04, $0D, $00, $02, $0F, $2B, $00
    db $52, $02, $04, $04, $00, $58, $02, $00, $4E, $0F, $09, $00, $5A, $04, $00, $72
    db $0F, $11, $00, $56, $04, $00, $9E, $0F, $0D, $00, $6E, $0F, $19, $00, $52, $00
    db $00, $EE, $0F, $11, $00, $72, $0F, $09, $00, $3E, $1F, $13

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map64Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_7BC3:: ; address name
    db $68, $01, $00, $02, $02, $02, $02, $03, $03, $00, $00, $00, $00, $06, $0A, $00
    db $04, $0F, $27, $03, $00, $52, $0B, $00, $4E, $0F, $2D, $00, $9E, $0F, $3D, $00
    db $52, $0F, $4D, $00, $9E, $0F, $03

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map65Screens0::
Data_066_7BEA:: ; address name
    dfar Map65Screens0_Y0X0 ; entry 0
    dfar Map65Screens0_Y0X1 ; entry 1
    dfar Map65Screens0_Y1X0 ; entry 2
    dfar Map65Screens0_Y1X1 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map65Attrs0::
Data_066_7BF6:: ; address name
    dfar Map65Attrs0_Y0X0 ; entry 0
    dfar Map65Attrs0_Y0X1 ; entry 1
    dfar Map65Attrs0_Y1X0 ; entry 2
    dfar Map65Attrs0_Y1X1 ; entry 3

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_7C02:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BC02, $52

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Screens0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_7C54:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BC54, $60

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_7CB4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BCB4, $61

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Screens0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_7D15:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BD15, $BD

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_7DD2:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $3E, $03, $00, $52, $0D, $00, $50, $0F, $03
    db $04, $00, $7A, $0D, $00, $78, $0F, $03, $00, $52, $0F, $4D, $00, $B2, $0F, $3D
    db $00, $4E, $0F, $01, $02, $02

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Attrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_066_7DF8:: ; address name
    db $68, $01, $00, $02, $00, $00, $0F, $3C, $03, $00, $50, $0D, $00, $4E, $0F, $03
    db $04, $00, $78, $0D, $00, $76, $0F, $03, $00, $50, $0F, $4D, $00, $B0, $0F, $2D
    db $00, $00, $0F, $15

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_066_7E1C:: ; address name
    db $68, $01, $00, $02, $02, $03, $00, $02, $0B, $02, $02, $00, $00, $0F, $03, $04
    db $00, $2A, $0B, $00, $26, $0F, $05, $00, $02, $0F, $4D, $00, $62, $0F, $4D, $00
    db $C2, $0F, $1D, $00, $3E, $1F, $13

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map65Attrs0_Y1X1:: ; heuristic: map screen stream; C0
Data_066_7E43:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BE43, $76

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map67Screens0::
Data_066_7EB9:: ; address name
    dfar Map67Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map67Attrs0::
Data_066_7EBC:: ; address name
    dfar Map67Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map67Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_7EBF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BEBF, $D0

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map67Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_066_7F8F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $19BF8F, $58
    ds $19, $00
