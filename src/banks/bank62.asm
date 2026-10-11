SECTION "Bank 62", ROMX[$4000], BANK[$62]
    db $62

Data_062_4001:: ; heuristic: key-world screen header; C0
    db $03, $02, $04, $0B, $0D, $33, $01, $00

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4009:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $188009, $61

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_406A::
Data_062_406A:: ; address name
    db $05, $00, $01, $0E, $0F, $33, $02, $00 ; entry 0

; LZSS-compressed asset: 124 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4072:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $188072, $7C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_40EE::
Data_062_40EE:: ; address name
    db $07, $00, $07, $08, $0F, $33, $03, $00 ; entry 0

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_40F6:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1880F6, $D3

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_41C9::
Data_062_41C9:: ; address name
    db $06, $04, $05, $0A, $0B, $33, $04, $00 ; entry 0

; LZSS-compressed asset: 105 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_41D1:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1881D1, $69

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_423A::
Data_062_423A:: ; address name
    db $04, $03, $07, $08, $0A, $33, $05, $00 ; entry 0

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4242:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $188242, $71

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_42B3::
Data_062_42B3:: ; address name
    db $07, $04, $06, $09, $0B, $33, $06, $00 ; entry 0

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_42BB:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1882BB, $AA

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_4365::
Data_062_4365:: ; address name
    db $00, $00, $06, $09, $0F, $33, $07, $00 ; entry 0

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_436D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18836D, $5D

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_43CA::
Data_062_43CA:: ; address name
    db $01, $01, $06, $0C, $0E, $33, $08, $00 ; entry 0

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_43D2:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1883D2, $82

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_4454::
Data_062_4454:: ; address name
    db $00, $02, $05, $0A, $0D, $33, $09, $00 ; entry 0

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_445C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18845C, $AB

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_4507::
Data_062_4507:: ; address name
    db $01, $03, $07, $08, $0F, $33, $0A, $00 ; entry 0

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_450F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18850F, $98

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_45A7::
Data_062_45A7:: ; address name
    db $04, $02, $04, $0B, $0D, $33, $0B, $00 ; entry 0

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_45AF:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1885AF, $93

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_4642::
Data_062_4642:: ; address name
    db $06, $00, $01, $09, $0F, $33, $0C, $00 ; entry 0

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_464A:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18864A, $82

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_46CC::
Data_062_46CC:: ; address name
    db $04, $00, $07, $08, $0F, $33, $0D, $00 ; entry 0

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_46D4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1886D4, $5F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_4733::
Data_062_4733:: ; address name
    db $05, $03, $07, $08, $0A, $33, $0E, $00 ; entry 0

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_473B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18873B, $57

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_4792::
Data_062_4792:: ; address name
    db $01, $05, $07, $08, $0C, $33, $0F, $00 ; entry 0

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_479A:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18879A, $93

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_482D::
Data_062_482D:: ; address name
    db $06, $04, $06, $09, $0B, $33, $10, $00 ; entry 0

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4835:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $188835, $77

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_48AC:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 26 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_48C0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $09, $09, $00, $44, $0F, $13, $00, $7D
    db $0F, $4D, $00, $DD, $0F, $4D, $00, $00, $0F, $17

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_48DA:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1888DA, $55

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_492F:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $09, $09, $00, $44, $0F, $39, $09, $09
    db $00, $92, $0F, $4D, $00, $B6, $0F, $03, $00, $00, $0F, $39

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_494B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $09, $09, $00, $44, $0F, $39, $09, $09
    db $00, $92, $0F, $3B, $00, $F3, $0F, $4D, $00, $00, $0F, $01

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4967:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $188967, $43

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_49AA:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $09, $09, $00, $44, $0F, $39, $09, $09
    db $00, $92, $0F, $13, $00, $54, $0F, $3D, $00, $00, $0F, $39

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_49C6:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $48, $03, $03, $00, $4A, $0F, $0D, $03, $00
    db $7E, $01, $00, $5A, $0A, $00, $7E, $0F, $05, $00, $4C, $0E, $00, $5C, $0C, $00
    db $A6, $0F, $13, $00, $5A, $0F, $11, $00, $00, $0F, $3F

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_49F1:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1889F1, $45

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4A36:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1C, $03, $03, $00, $1E, $0F, $11, $03, $00
    db $56, $01, $00, $48, $0F, $15, $00, $30, $0A, $00, $7E, $0F, $01, $00, $7C, $0F
    db $17, $00, $A8, $0F, $1B, $00, $48, $0F, $0F, $00, $12, $1F, $35

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4A63:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1A, $03, $03, $00, $1C, $0F, $11, $03, $00
    db $54, $01, $00, $46, $0F, $0D, $00, $54, $02, $00, $6C, $0F, $0F, $00, $52, $02
    db $00, $44, $0F, $01, $00, $1C, $0F, $03, $00, $58, $0E, $00, $2C, $0F, $05, $00
    db $A6, $0F, $15, $00, $12, $1F, $31

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4A9A:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1C, $03, $03, $00, $1E, $0F, $11, $03, $00
    db $56, $03, $00, $4A, $0F, $11, $00, $46, $0F, $01, $00, $84, $0F, $0D, $00, $7C
    db $0F, $0B, $00, $5A, $08, $00, $CC, $0F, $01, $00, $54, $0F, $17, $00, $A2, $0F
    db $17, $00, $00, $0F, $0D

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4ACF:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4AE3:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4AF7:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $46, $02, $00, $5A, $01, $00, $4C, $0F, $35
    db $00, $5A, $02, $00, $9A, $0F, $3D, $00, $4C, $0F, $0F, $00, $00, $0F, $35

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_4B16:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $01, $00, $00, $0F, $40, $02, $00, $54, $03, $00, $48, $0F, $0B
    db $00, $54, $04, $00, $58, $08, $00, $7A, $0F, $4D, $00, $4E, $0F, $19, $00, $00
    db $0F, $3B

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 4: entry 4 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1366 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles4:: ; heuristic: key-world tileset stream; C0
Data_062_4B38:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $188B38, $556

; E-0139 (C1: entry 4 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes4::
Data_062_508E:: ; address name
    dw $7DA0, $7FFF, $2AB7, $0063 ; entry 0
    dw $0160, $3FBF, $03E2, $0000 ; entry 1
    dw $01C4, $03FF, $0348, $0084 ; entry 2
    dw $01C4, $7FFF, $0348, $0084 ; entry 3
    dw $158F, $2AB7, $03E2, $0000 ; entry 4
    dw $0171, $3FBF, $03E2, $0000 ; entry 5
    dw $1415, $7FFF, $03E2, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

Data_062_50CE:: ; heuristic: key-world screen header; C0
    db $03, $04, $05, $0C, $0E, $33, $35, $00

; LZSS-compressed asset: 144 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_50D6:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1890D6, $90

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_5166::
Data_062_5166:: ; address name
    db $04, $04, $05, $0C, $0E, $33, $36, $00 ; entry 0

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_516E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18916E, $9B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_5209::
Data_062_5209:: ; address name
    db $06, $00, $04, $05, $0E, $33, $37, $00 ; entry 0

; LZSS-compressed asset: 125 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5211:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $189211, $7D

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_528E::
Data_062_528E:: ; address name
    db $00, $04, $05, $0C, $0E, $33, $38, $00 ; entry 0

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5296:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $189296, $A1

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_5337::
Data_062_5337:: ; address name
    db $05, $04, $05, $0C, $0E, $33, $39, $00 ; entry 0

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_533F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18933F, $88

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_53C7::
Data_062_53C7:: ; address name
    db $06, $04, $05, $0C, $0E, $33, $3A, $00 ; entry 0

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_53CF:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1893CF, $B6

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_5485::
Data_062_5485:: ; address name
    db $01, $04, $05, $0D, $0E, $33, $3B, $00 ; entry 0

; LZSS-compressed asset: 140 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_548D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18948D, $8C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_5519::
Data_062_5519:: ; address name
    db $00, $04, $05, $07, $0E, $33, $3C, $00 ; entry 0

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5521:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $189521, $7A

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_559B::
Data_062_559B:: ; address name
    db $01, $04, $06, $08, $0B, $33, $3D, $00 ; entry 0

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_55A3:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1895A3, $CC

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_566F:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $52, $0F, $3E, $03, $03, $00, $A0
    db $0F, $11, $03, $03, $00, $C6, $0F, $11, $00, $D8, $00, $00, $EE, $0F, $0F, $00
    db $FE, $02, $00, $16, $1F, $0D, $00, $24, $14, $00, $3E, $1F, $03

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_569C:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18969C, $43

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_56DF:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $4C, $0F, $38, $03, $00, $AC, $03
    db $00, $A0, $0F, $0B, $00, $AC, $04, $00, $C6, $0F, $4D, $00, $FE, $0F, $1B

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_56FE:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1E, $02, $00, $32, $01, $00, $24, $0F, $0B
    db $00, $32, $02, $00, $36, $0A, $00, $56, $0E, $00, $32, $0F, $11, $00, $30, $0C
    db $03, $03, $03, $03, $00, $A0, $0F, $07, $00, $AA, $06, $00, $C4, $0F, $09, $00
    db $A8, $08, $00, $EC, $0F, $07, $00, $F4, $0C, $00, $16, $1F, $2B

; LZSS-compressed asset: 38 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_573B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $52, $0F, $3E, $03, $03, $00, $A0
    db $0F, $4D, $00, $C4, $0F, $01, $03, $03, $00, $16, $1F, $0D, $00, $28, $10, $00
    db $4A, $12, $00, $40, $1F, $01

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5761:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $189761, $41

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_57A2:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $48, $03, $03, $03, $03, $00, $4C, $0F, $15
    db $00, $5E, $0C, $00, $84, $0F, $07, $00, $5E, $0A, $00, $AC, $0F, $01, $00, $82
    db $0F, $17, $00, $58, $02, $00, $F0, $0F, $0B, $00, $5C, $04, $00, $16, $1F, $11
    db $00, $84, $0C, $00, $4A, $16

; LZSS-compressed asset: 41 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_57D8:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $46, $03, $00, $5A, $01, $00, $4C, $0F, $15
    db $00, $5E, $0A, $00, $82, $0F, $01, $00, $80, $0F, $11, $00, $82, $04, $00, $C2
    db $0F, $35, $00, $CA, $0A, $00, $18, $1F, $29

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5801:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $189801, $51

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 8: entry 8 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1243 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles8:: ; heuristic: key-world tileset stream; C0
Data_062_5852:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $189852, $4DB

; E-0139 (C1: entry 8 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes8::
Data_062_5D2D:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $0188, $3FBF, $0210, $0000 ; entry 1
    dw $012F, $3FBF, $01D5, $0000 ; entry 2
    dw $012F, $3FBF, $01D5, $0000 ; entry 3
    dw $318C, $3FBF, $2A13, $0000 ; entry 4
    dw $0171, $3FBF, $2A13, $0000 ; entry 5
    dw $1415, $3FBF, $25F5, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

Data_062_5D6D:: ; heuristic: key-world screen header; C0
    db $05, $02, $06, $09, $0D, $33, $59, $00

; LZSS-compressed asset: 125 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5D75:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $189D75, $7D

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_5DF2::
Data_062_5DF2:: ; address name
    db $06, $02, $07, $09, $0F, $33, $5A, $00 ; entry 0

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5DFA:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $189DFA, $97

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_5E91::
Data_062_5E91:: ; address name
    db $07, $02, $06, $09, $0D, $33, $5B, $00 ; entry 0

; LZSS-compressed asset: 127 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5E99:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $189E99, $7F

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_5F18::
Data_062_5F18:: ; address name
    db $02, $02, $03, $06, $0D, $33, $5C, $00 ; entry 0

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5F20:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $189F20, $9C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_5FBC::
Data_062_5FBC:: ; address name
    db $03, $01, $04, $09, $0A, $33, $5D, $00 ; entry 0

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_5FC4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $189FC4, $BF

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6083::
Data_062_6083:: ; address name
    db $07, $04, $07, $09, $0B, $33, $5E, $00 ; entry 0

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_608B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A08B, $B3

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_613E::
Data_062_613E:: ; address name
    db $FF, $02, $03, $07, $0B, $33, $5F, $00 ; entry 0

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6146:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A146, $9B

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_61E1::
Data_062_61E1:: ; address name
    db $FF, $00, $08, $07, $0F, $33, $60, $00 ; entry 0

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_61E9:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A1E9, $A4

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_628D::
Data_062_628D:: ; address name
    db $07, $05, $0A, $0B, $0D, $33, $61, $00 ; entry 0

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6295:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A295, $BD

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6352:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $06, $06, $00, $28, $0F, $0F, $00, $08, $02, $00, $50, $0F, $11, $00, $08, $00
    db $00, $78, $0F, $01, $00, $76, $0F, $29, $00, $4C, $0F, $05, $00, $26, $0F, $17
    db $00, $26, $0A, $00, $18, $1F, $09, $00, $12, $0F, $0D

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_638D:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A38D, $4D

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_63DA:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $4D, $00
    db $10, $0A, $00, $1C, $06, $00, $78, $0F, $01, $00, $72, $0E, $00, $1C, $04, $00
    db $A6, $0F, $01, $00, $76, $0F, $19, $00, $E6, $0F, $4D, $00, $F6, $0A

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6408:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A408, $48

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6450:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A450, $46

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6496:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A496, $5A

; LZSS-compressed asset: 64 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_64F0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $08, $06, $00, $28, $0F, $0D, $00, $04, $04, $00, $50, $0F, $29, $00, $12, $02
    db $00, $0E, $0A, $00, $A0, $0F, $05, $00, $0A, $06, $00, $A0, $04, $00, $CA, $0F
    db $01, $00, $F0, $0A, $00, $EC, $0F, $0D, $00, $28, $0F, $15, $00, $12, $0F, $0D

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6530:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A530, $4F

; LZSS-compressed asset: 88 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_657F:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A57F, $58

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_65D7::
Data_062_65D7:: ; address name
    db $06, $06, $08, $09, $0B, $33, $7D, $00 ; entry 0

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_65DF:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A5DF, $4F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_662E::
Data_062_662E:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $33, $7E, $00 ; entry 0

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6636:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A636, $54

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_668A::
Data_062_668A:: ; address name
    db $FF, $08, $09, $0A, $0B, $33, $7F, $00 ; entry 0

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6692:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A692, $75

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_6707::
Data_062_6707:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $33, $80, $00 ; entry 0

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_670F:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A70F, $75

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6784::
Data_062_6784:: ; address name
    db $04, $05, $06, $0B, $0C, $33, $81, $00 ; entry 0

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_678C:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A78C, $7B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6807::
Data_062_6807:: ; address name
    db $01, $04, $06, $07, $09, $33, $82, $00 ; entry 0

; LZSS-compressed asset: 179 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_680F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A80F, $B3

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_68C2::
Data_062_68C2:: ; address name
    db $04, $03, $05, $0A, $0B, $33, $83, $00 ; entry 0

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_68CA:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A8CA, $82

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_694C::
Data_062_694C:: ; address name
    db $06, $04, $06, $0D, $0E, $33, $84, $00 ; entry 0

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6954:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18A954, $92

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_62_69E6::
Data_062_69E6:: ; address name
    db $06, $00, $03, $07, $08, $33, $85, $00 ; entry 0

; LZSS-compressed asset: 211 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_69EE:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18A9EE, $D3

; LZSS-compressed asset: 39 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6AC1:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $4D, $00
    db $10, $06, $00, $1E, $06, $00, $74, $0F, $13, $00, $14, $06, $00, $A4, $0F, $2B
    db $00, $F5, $0F, $4D, $00, $08, $1E

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6AE8:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $33, $03
    db $03, $02, $02, $02, $02, $00, $4C, $0F, $11, $00, $5A, $00, $00, $74, $0F, $13
    db $00, $AD, $0F, $4D, $00, $08, $1F, $47

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6B10:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $33, $00, $08, $0F, $15, $00, $06, $04, $00, $A0, $08
    db $00, $A8, $0F, $07, $00, $B0, $0C, $00, $D2, $0F, $03, $00, $FB, $0F, $4D, $00
    db $A0, $08

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6B42:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $0F, $02
    db $02, $00, $24, $0F, $11, $00, $36, $02, $00, $4E, $0F, $0D, $00, $5C, $04, $00
    db $76, $0F, $0F, $02, $02, $00, $00, $06, $00, $A4, $0F, $07, $00, $D1, $0F, $4D
    db $00, $08, $1F, $23

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6B76:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $31, $00, $30, $08, $00, $76, $0F, $13, $00, $00, $0F
    db $1D, $00, $08, $0F, $09, $00, $00, $06, $00, $F2, $0F, $05, $00, $10, $1F, $37

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6BA6:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18ABA6, $51

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6BF7:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $07, $00
    db $0A, $06, $00, $24, $0F, $09, $00, $2E, $0A, $00, $4E, $0F, $2D, $00, $2E, $0F
    db $13, $00, $08, $02, $00, $06, $06, $00, $C4, $0F, $09, $00, $00, $08, $00, $EC
    db $0F, $07, $00, $14, $1F, $3B

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6C2D:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18AC2D, $50

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6C7D:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $18AC7D, $64

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6CE1::
Data_062_6CE1:: ; address name
    db $01, $02, $04, $09, $0D, $01, $A1, $00 ; entry 0

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6CE9:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18ACE9, $82

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6D6B::
Data_062_6D6B:: ; address name
    db $00, $02, $04, $09, $0D, $01, $A2, $00 ; entry 0

; LZSS-compressed asset: 192 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6D73:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18AD73, $C0

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6E33::
Data_062_6E33:: ; address name
    db $03, $02, $04, $09, $0D, $30, $A3, $00 ; entry 0

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6E3B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18AE3B, $A1

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6EDC::
Data_062_6EDC:: ; address name
    db $FF, $02, $04, $05, $0D, $30, $A4, $00 ; entry 0

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6EE4:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18AEE4, $AC

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_6F90::
Data_062_6F90:: ; address name
    db $05, $02, $04, $09, $0D, $01, $A5, $00 ; entry 0

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_6F98:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18AF98, $94

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_702C::
Data_062_702C:: ; address name
    db $05, $02, $04, $09, $0D, $01, $A6, $00 ; entry 0

; LZSS-compressed asset: 141 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7034:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B034, $8D

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_70C1::
Data_062_70C1:: ; address name
    db $FF, $02, $04, $06, $0D, $01, $A7, $00 ; entry 0

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_70C9:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B0C9, $AC

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_7175::
Data_062_7175:: ; address name
    db $FF, $02, $04, $09, $0D, $01, $A8, $00 ; entry 0

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_717D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B17D, $AA

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_7227::
Data_062_7227:: ; address name
    db $00, $02, $09, $0B, $0C, $01, $A9, $00 ; entry 0

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_722F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B22F, $D7

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7306:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $15, $02, $08, $06, $02, $28
    db $0F, $0D, $02, $08, $04, $02, $50, $0F, $0F, $02, $08, $02, $02, $78, $0F, $11
    db $02, $AF, $0F, $4D, $02, $08, $1F, $45

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_732E:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B32E, $4D

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_737B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $11, $02, $02, $03, $1C, $0F
    db $11, $02, $02, $03, $42, $0F, $11, $03, $54, $02, $03, $04, $08, $03, $78, $0F
    db $03, $03, $A1, $0F, $4D, $03, $01, $1F, $4D, $03, $04, $02

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_73A7:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B3A7, $41

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_73E8:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $15, $02, $04, $06, $02, $28
    db $0F, $11, $02, $08, $00, $02, $50, $0F, $3B, $02, $B1, $0F, $4D, $02, $08, $1F
    db $43

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7409:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B409, $41

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_744A:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $13, $02, $F4, $FF, $01, $02
    db $F4, $FE, $02, $F2, $FF, $01, $02, $56, $0F, $07, $02, $7C, $06, $02, $7A, $0F
    db $09, $02, $A2, $08, $02, $A2, $0F, $05, $02, $B2, $0C, $02, $CA, $0F, $0D, $02
    db $FD, $0F, $4D, $02, $00, $06

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7480:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B480, $41

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_74C1:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B4C1, $56

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_7517::
Data_062_7517:: ; address name
    db $05, $03, $05, $08, $0A, $38, $C5, $00 ; entry 0

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_751F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B51F, $91

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_75B0::
Data_062_75B0:: ; address name
    db $FF, $08, $09, $0A, $0D, $05, $C6, $00 ; entry 0

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_75B8:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B5B8, $6E

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_7626::
Data_062_7626:: ; address name
    db $FF, $0B, $0D, $0E, $0F, $05, $C7, $00 ; entry 0

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_762E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B62E, $80

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_76AE::
Data_062_76AE:: ; address name
    db $FF, $0B, $0C, $0D, $0F, $05, $C8, $00 ; entry 0

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_76B6:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B6B6, $94

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_774A::
Data_062_774A:: ; address name
    db $06, $03, $07, $08, $0A, $38, $C9, $00 ; entry 0

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7752:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B752, $99

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_77EB::
Data_062_77EB:: ; address name
    db $07, $03, $05, $0B, $0D, $38, $CA, $00 ; entry 0

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_77F3:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B7F3, $CD

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_78C0::
Data_062_78C0:: ; address name
    db $04, $03, $04, $05, $0B, $38, $CB, $00 ; entry 0

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_78C8:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B8C8, $BD

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_7985::
Data_062_7985:: ; address name
    db $05, $00, $03, $07, $08, $38, $CC, $00 ; entry 0

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_798D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18B98D, $D5

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_62_7A62::
Data_062_7A62:: ; address name
    db $07, $04, $06, $09, $0B, $38, $CD, $00 ; entry 0

; LZSS-compressed asset: 209 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7A6A:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $18BA6A, $D1

; LZSS-compressed asset: 43 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7B3B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $4D, $02, $10
    db $06, $02, $1E, $06, $02, $74, $0F, $09, $02, $7E, $0A, $02, $9E, $0F, $07, $02
    db $7C, $0F, $15, $02, $18, $0F, $4D, $02, $04, $1F, $01

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7B66:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $FF, $F6, $01, $03, $0A, $05, $03, $00, $0F, $0F, $02, $02
    db $03, $24, $0F, $11, $02, $03, $5C, $01, $03, $4E, $0F, $4D, $03, $72, $0F, $03
    db $03, $4C, $0F, $01, $03, $24, $0F, $25, $03, $0C, $0F, $17, $03, $0E, $0F, $07

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7B96:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $0B, $02, $08
    db $06, $02, $28, $0F, $0D, $02, $08, $04, $02, $50, $0F, $0F, $02, $08, $02, $02
    db $78, $0F, $4D, $02, $4C, $0F, $25, $02, $20, $0F, $13, $02, $0A, $0F, $0B

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7BC5:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $FF, $F6, $01, $03, $0A, $05, $03, $00, $0F, $0B, $00, $00
    db $02, $02, $02, $02, $03, $24, $0F, $11, $03, $32, $00, $03, $4C, $0F, $15, $03
    db $36, $00, $03, $78, $0F, $4D, $03, $9C, $0C, $03, $34, $0F, $13, $03, $34, $04
    db $03, $16, $1F, $0D, $03, $0A, $0F, $0B

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7BFD:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $05, $02, $0A
    db $06, $02, $22, $0F, $09, $02, $2C, $0C, $02, $4E, $0F, $4D, $02, $AE, $0F, $45
    db $02, $2A, $0F, $15, $02, $02, $0F, $13

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7C25:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18BC25, $5D

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7C82:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $31, $02, $0A
    db $06, $02, $4E, $0F, $07, $02, $58, $08, $02, $74, $0F, $07, $02, $7C, $0C, $02
    db $9E, $0F, $09, $02, $04, $0A, $02, $C8, $0F, $2B, $02, $08, $00, $02, $06, $0E
    db $02, $1C, $1F, $01, $02, $04, $0F, $11

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7CBA:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18BCBA, $45

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_062_7CFF:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $18BCFF, $50
    ds $2B1, $00
