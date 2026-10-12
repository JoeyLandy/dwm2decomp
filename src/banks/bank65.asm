SECTION "Bank 65", ROMX[$4000], BANK[$65]
    db $65

; E-0139 (C1: entry 3 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes3::
Data_065_4001:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $026E, $3F7F, $02F3, $0188 ; entry 1
    dw $0152, $3F7F, $0218, $00C8 ; entry 2
    dw $2130, $3F7F, $39D9, $00C8 ; entry 3
    dw $158F, $3FBF, $2AB7, $0000 ; entry 4
    dw $0171, $3FBF, $2A13, $0000 ; entry 5
    dw $0018, $3F7F, $0218, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_4041::
Data_065_4041:: ; address name
    db $06, $03, $08, $0B, $0D, $33, $2C, $00 ; entry 0

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4049:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194049, $7B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_40C4::
Data_065_40C4:: ; address name
    db $07, $03, $08, $0B, $0D, $33, $2D, $00 ; entry 0

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_40CC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1940CC, $A1

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_416D::
Data_065_416D:: ; address name
    db $05, $05, $08, $0B, $0D, $33, $2E, $00 ; entry 0

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4175:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194175, $7B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_41F0::
Data_065_41F0:: ; address name
    db $00, $03, $08, $0B, $0D, $33, $2F, $00 ; entry 0

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_41F8:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1941F8, $99

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_4291::
Data_065_4291:: ; address name
    db $03, $03, $08, $0B, $0D, $33, $30, $00 ; entry 0

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4299:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194299, $85

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_431E::
Data_065_431E:: ; address name
    db $00, $03, $08, $0B, $0D, $33, $31, $00 ; entry 0

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4326:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194326, $97

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_43BD::
Data_065_43BD:: ; address name
    db $FF, $02, $0B, $0D, $0F, $33, $32, $00 ; entry 0

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_43C5:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1943C5, $96

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_445B::
Data_065_445B:: ; address name
    db $FF, $03, $08, $0B, $0D, $33, $33, $00 ; entry 0

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4463:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194463, $88

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_44EB::
Data_065_44EB:: ; address name
    db $06, $02, $06, $09, $0D, $33, $34, $00 ; entry 0

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_44F3:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1944F3, $CD

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_45C0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $03, $03, $00, $8E
    db $0F, $15, $00, $A0, $0E, $00, $C8, $0F, $05, $00, $A0, $0C, $00, $F0, $0F, $07
    db $00, $A0, $0A, $00, $18, $1F, $09, $00, $A0, $08, $00, $40, $1F, $01

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_45EE:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1945EE, $55

; LZSS-compressed asset: 31 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4643:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $03, $00, $A0, $03
    db $00, $94, $0F, $15, $00, $A6, $08, $00, $C8, $0F, $4D, $00, $00, $1F, $19

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4662:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $1C, $02, $00, $30, $01, $00, $22, $0F, $0B
    db $00, $30, $02, $00, $30, $0A, $00, $54, $0E, $00, $58, $0C, $00, $76, $0F, $03
    db $03, $03, $03, $03, $00, $34, $0C, $00, $A0, $0F, $05, $00, $A0, $00, $00, $BC
    db $0F, $3D, $00, $CE, $08, $00, $18, $1F, $29

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_469B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $40, $0F, $2C, $03, $03, $00, $8E
    db $0F, $4D, $00, $B2, $0F, $05, $00, $B4, $0E, $00, $18, $1F, $05, $00, $40, $12
    db $00, $36, $1F, $0B

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_46BF:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1946BF, $4C

; LZSS-compressed asset: 51 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_470B:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $44, $03, $03, $03, $03, $00, $48, $0F, $0F
    db $00, $58, $00, $00, $7E, $02, $00, $74, $0F, $05, $00, $5A, $00, $00, $7E, $06
    db $00, $9A, $0F, $09, $00, $80, $06, $00, $C0, $0F, $15, $00, $76, $0F, $17, $00
    db $FE, $0F, $2F

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_473E:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $20, $0F, $0C, $02, $02, $02, $02
    db $00, $70, $0F, $09, $03, $03, $00, $9C, $02, $00, $A6, $00, $00, $80, $04, $00
    db $A0, $0F, $03, $00, $C8, $08, $00, $C2, $0F, $15, $00, $9A, $04, $00, $F2, $0F
    db $05, $00, $20, $0A, $00, $18, $1F, $07, $00, $1A, $1A, $00, $40, $1F, $01

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_477D:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $19477D, $5B

; compressed BG tiles (2048 bytes, 128 tiles) of key-world kind 7: entry 7 of KeyWorldTilesetTable, decompressed to vTiles2 by RunWCC44Type_420D_Case00
; LZSS-compressed asset: 1185 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
KeyWorldTiles7:: ; heuristic: key-world tileset stream; C0
Data_065_47D8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1947D8, $4A1

; E-0139 (C1: entry 7 of KeyWorldTilesetTable; RunWCC44Type_420D_Case00 copies these $40 bytes to wBGPaletteBuffer).
; record: one CGB palette: 4 BGR555 colours
KeyWorldPalettes7::
Data_065_4C79:: ; address name
    dw $1412, $7FFF, $259F, $0063 ; entry 0
    dw $318C, $5AD6, $4631, $0000 ; entry 1
    dw $1415, $7DFF, $7C18, $2C09 ; entry 2
    dw $318C, $5AD6, $4631, $0000 ; entry 3
    dw $318C, $5AD6, $2A13, $0000 ; entry 4
    dw $0171, $3FBF, $5294, $0000 ; entry 5
    dw $7DA0, $3FBF, $5294, $0000 ; entry 6
    dw $318C, $7FFF, $5294, $0000 ; entry 7

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_65_4CB9::
Data_065_4CB9:: ; address name
    db $03, $04, $06, $09, $0B, $33, $50, $00 ; entry 0

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4CC1:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $194CC1, $88

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_4D49::
Data_065_4D49:: ; address name
    db $01, $04, $06, $09, $0B, $33, $51, $00 ; entry 0

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4D51:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194D51, $92

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_4DE3::
Data_065_4DE3:: ; address name
    db $03, $04, $06, $09, $0B, $33, $52, $00 ; entry 0

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4DEB:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194DEB, $74

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_65_4E5F::
Data_065_4E5F:: ; address name
    db $01, $04, $06, $09, $0B, $33, $53, $00 ; entry 0

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4E67:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $194E67, $B6

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_65_4F1D::
Data_065_4F1D:: ; address name
    db $05, $04, $06, $09, $0B, $33, $54, $00 ; entry 0

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4F25:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $194F25, $88

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_4FAD::
Data_065_4FAD:: ; address name
    db $04, $02, $07, $0B, $0F, $33, $55, $00 ; entry 0

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_4FB5:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $194FB5, $A1

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5056::
Data_065_5056:: ; address name
    db $FF, $02, $03, $04, $0B, $33, $56, $00 ; entry 0

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_505E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19505E, $98

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_50F6::
Data_065_50F6:: ; address name
    db $FF, $00, $04, $0C, $0F, $33, $57, $00 ; entry 0

; LZSS-compressed asset: 172 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_50FE:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1950FE, $AC

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_65_51AA::
Data_065_51AA:: ; address name
    db $01, $03, $06, $09, $0F, $33, $58, $00 ; entry 0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_51B2:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $1951B2, $D8

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_528A:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $07, $00
    db $0A, $06, $00, $24, $0F, $09, $00, $2E, $0A, $00, $4E, $0F, $05, $00, $54, $0C
    db $00, $76, $0F, $03, $00, $7A, $0F, $13, $00, $52, $0F, $15, $00, $2C, $0F, $15
    db $00, $2C, $0A, $00, $02, $0E, $00, $22, $1F, $01, $00, $00, $0F, $0B

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_52C8:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1952C8, $56

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_531E:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $4D, $00
    db $10, $08, $00, $1E, $06, $00, $76, $0F, $03, $00, $80, $0F, $0D, $00, $AC, $0F
    db $27, $00, $14, $0F, $4D, $00, $F6, $0A

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5346:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $195346, $4B

; LZSS-compressed asset: 45 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5391:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $03, $00, $00, $05, $01, $00, $0A, $05, $00, $00, $0F, $03, $00
    db $0A, $06, $00, $20, $0F, $4D, $00, $8E, $0F, $0B, $00, $3C, $0F, $4D, $00, $C2
    db $0F, $03, $00, $06, $0A, $00, $22, $1F, $01, $00, $00, $0F, $0B

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_53BE:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1953BE, $56

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5414:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $195414, $43

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5457:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $195457, $4F

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_54A6:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $1954A6, $65

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_65_550B::
Data_065_550B:: ; address name
    db $00, $00, $02, $09, $0A, $33, $74, $00 ; entry 0

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5513:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $195513, $74

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5587::
Data_065_5587:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $33, $75, $00 ; entry 0

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_558F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19558F, $53

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_55E2::
Data_065_55E2:: ; address name
    db $FF, $00, $02, $08, $09, $33, $76, $00 ; entry 0

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_55EA:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1955EA, $61

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_564B::
Data_065_564B:: ; address name
    db $00, $FF, $FF, $FF, $FF, $33, $77, $00 ; entry 0

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5653:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $195653, $65

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_56B8::
Data_065_56B8:: ; address name
    db $02, $00, $09, $0A, $0C, $33, $78, $00 ; entry 0

; LZSS-compressed asset: 119 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_56C0:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1956C0, $77

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5737::
Data_065_5737:: ; address name
    db $02, $00, $06, $0D, $0F, $33, $79, $00 ; entry 0

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_573F:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19573F, $91

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_57D0::
Data_065_57D0:: ; address name
    db $FF, $04, $0B, $0C, $0E, $33, $7A, $00 ; entry 0

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_57D8:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1957D8, $7A

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5852::
Data_065_5852:: ; address name
    db $FF, $07, $09, $0C, $0F, $33, $7B, $00 ; entry 0

; LZSS-compressed asset: 127 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_585A:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19585A, $7F

; E-0222 (derived: an 8-byte key-world screen header (bytes 6-7 pick the AutomapBlocks entry, E-0146) found by tiling a gap)
; record: screen header
KeyWorldScreenHeader_65_58D9::
Data_065_58D9:: ; address name
    db $00, $06, $08, $09, $0D, $33, $7C, $00 ; entry 0

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_58E1:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $1958E1, $B6

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5997:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $09, $00
    db $0A, $06, $00, $26, $0F, $33, $00, $04, $08, $00, $78, $0F, $01, $00, $22, $0F
    db $43, $00, $F5, $0F, $4D, $00, $08, $1E

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_59BF:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $2F, $02
    db $02, $00, $0A, $06, $00, $4E, $0F, $09, $00, $58, $08, $00, $76, $0F, $03, $00
    db $9F, $0F, $4D, $00, $FF, $0F, $4D, $00, $0A, $04

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_59E9:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $0B, $00
    db $08, $06, $00, $28, $0F, $2D, $00, $74, $08, $00, $74, $0F, $05, $00, $0C, $06
    db $00, $98, $0C, $00, $A6, $0F, $03, $00, $CF, $0F, $4D, $00, $08, $1F, $25

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5A18:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $09, $02
    db $02, $00, $1E, $0F, $11, $02, $02, $00, $44, $0F, $11, $00, $56, $00, $00, $6C
    db $0F, $0D, $00, $0A, $02, $00, $90, $0F, $01, $00, $90, $0F, $03, $00, $CF, $0F
    db $4D, $00, $08, $1F, $25

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5A4D:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $33, $00
    db $06, $06, $00, $50, $0F, $29, $00, $4C, $0C, $00, $9C, $0F, $31, $00, $10, $08
    db $00, $EC, $0F, $0D, $00, $14, $1F, $35

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5A75:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $195A75, $4B

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5AC0:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $0F, $00
    db $06, $02, $00, $28, $0F, $0B, $00, $02, $06, $00, $50, $0F, $29, $00, $12, $04
    db $00, $32, $06, $00, $9E, $0F, $0F, $00, $0A, $0C, $00, $D0, $0A, $00, $AA, $08
    db $00, $EA, $0F, $0B, $00, $0C, $1F, $39

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5AF8:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $01, $00, $00, $05, $03, $00, $0A, $05, $00, $00, $0F, $09, $02
    db $00, $30, $05, $00, $26, $0F, $0B, $00, $2C, $06, $00, $4E, $0F, $0F, $00, $2C
    db $02, $00, $76, $0F, $03, $00, $9E, $0A, $00, $9A, $0F, $39, $00, $5A, $06, $00
    db $F0, $0F, $09, $00, $FA, $0F, $13, $00, $3C, $1F, $0F

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5B33:: ; heuristic: key-world screen map found by tiling a gap after another; C0
    INCBIN "dwm2-cobi-us.gbc", $195B33, $65

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5B98::
Data_065_5B98:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $33, $17, $01 ; entry 0

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5BA0:: ; heuristic: key-world screen tile map; C0
    db $68, $01, $00, $2A, $2B, $00, $00, $0E, $3A, $3B, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5BBD:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5BD1::
Data_065_5BD1:: ; address name
    db $02, $01, $05, $0E, $0F, $00, $98, $00 ; entry 0

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5BD9:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $195BD9, $98

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5C71::
Data_065_5C71:: ; address name
    db $07, $01, $05, $0E, $0F, $00, $99, $00 ; entry 0

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5C79:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $195C79, $A4

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5D1D::
Data_065_5D1D:: ; address name
    db $06, $01, $05, $0E, $0F, $31, $9A, $00 ; entry 0

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5D25:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $195D25, $AF

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5DD4::
Data_065_5DD4:: ; address name
    db $FF, $01, $06, $0E, $0F, $31, $9B, $00 ; entry 0

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5DDC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $195DDC, $B0

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5E8C::
Data_065_5E8C:: ; address name
    db $01, $01, $05, $0E, $0F, $00, $9C, $00 ; entry 0

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5E94:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $195E94, $AE

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5F42::
Data_065_5F42:: ; address name
    db $07, $01, $05, $0E, $0F, $00, $9D, $00 ; entry 0

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5F4A:: ; heuristic: key-world screen tile map; C0
    db $68, $01, $02, $00, $01, $02, $00, $03, $27, $42, $43, $40, $41, $02, $0C, $02
    db $01, $00, $01, $11, $12, $13, $35, $36, $36, $37, $52, $53, $50, $51, $02, $20
    db $02, $02, $06, $02, $02, $2C, $02, $02, $0C, $05, $11, $02, $1C, $00, $02, $40

; LZSS-compressed asset: 485 bytes expand to 514 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5F7A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $195F7A, $6B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_5FE5::
Data_065_5FE5:: ; address name
    db $FF, $01, $06, $0E, $0F, $00, $9E, $00 ; entry 0

; LZSS-compressed asset: 181 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_5FED:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $195FED, $B5

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_60A2::
Data_065_60A2:: ; address name
    db $FF, $01, $03, $0E, $0F, $00, $9F, $00 ; entry 0

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_60AA:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1960AA, $B4

Data_065_615E:: ; heuristic: key-world screen header; C0
    db $07

; LZSS-compressed asset: 1253 bytes expand to 1281 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_615F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $01, $05, $0B, $0E, $00, $A0, $00

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6166:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196166, $B0

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6216:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $09, $02, $0A
    db $06, $02, $26, $0F, $09, $02, $30, $08, $02, $4E, $0F, $07, $02, $56, $0A, $02
    db $76, $0F, $03, $02, $9F, $0F, $4D, $02, $FF, $0F, $4D, $02, $0C, $04

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6244:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $196244, $4F

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6293:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $FF, $F6, $01, $03, $0A, $05, $03, $00, $0F, $4D, $03, $10
    db $06, $03, $1E, $06, $03, $74, $0F, $05, $01, $01, $02, $02, $03, $92, $0C, $03
    db $A0, $0F, $05, $03, $CA, $00, $03, $BC, $0F, $15, $03, $CA, $0A, $03, $F2, $0F
    db $01, $03, $F0, $06, $03, $E6, $0F, $01, $03, $A4, $0E, $03, $38, $1F, $0B

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_62D2:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $09, $02, $0A
    db $06, $02, $26, $0F, $0B, $02, $08, $0F, $0F, $02, $12, $04, $02, $6E, $0F, $0B
    db $02, $0E, $06, $02, $96, $0F, $11, $02, $CD, $0F, $4D, $02, $08, $1F, $27

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6301:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $196301, $4A

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_634B:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $19634B, $46

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6391:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $33, $02, $08
    db $06, $02, $50, $0F, $0D, $02, $06, $04, $02, $FA, $FF, $03, $02, $8E, $0F, $15
    db $02, $12, $02, $02, $C8, $08, $02, $C8, $0F, $0D, $02, $F8, $08, $02, $F4, $0F
    db $01, $02, $0C, $1F, $39

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_63C6:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $F6, $01, $02, $0A, $05, $02, $00, $0F, $33, $02, $08
    db $06, $02, $50, $0F, $03, $02, $10, $0E, $02, $78, $0F, $01, $02, $0C, $0C, $02
    db $9C, $0F, $0D, $02, $10, $04, $02, $C4, $0F, $39, $02, $14, $1F, $31

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_63F4:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1963F4, $4B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_643F::
Data_065_643F:: ; address name
    db $05, $03, $04, $0A, $0D, $37, $BC, $00 ; entry 0

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6447:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196447, $83

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_64CA::
Data_065_64CA:: ; address name
    db $07, $03, $04, $0A, $0D, $04, $BD, $00 ; entry 0

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_64D2:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1964D2, $74

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6546::
Data_065_6546:: ; address name
    db $FF, $01, $04, $0D, $0F, $04, $BE, $00 ; entry 0

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_654E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19654E, $9C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_65EA::
Data_065_65EA:: ; address name
    db $FF, $01, $04, $0A, $0F, $04, $BF, $00 ; entry 0

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_65F2:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1965F2, $52

; LZSS-compressed asset: 512 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6644:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $196644, $4F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6693::
Data_065_6693:: ; address name
    db $03, $04, $05, $08, $0C, $37, $C0, $00 ; entry 0

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_669B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19669B, $9B

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6736::
Data_065_6736:: ; address name
    db $05, $08, $09, $0A, $0D, $37, $C1, $00 ; entry 0

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_673E:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19673E, $CA

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6808::
Data_065_6808:: ; address name
    db $FF, $04, $05, $08, $0D, $37, $C2, $00 ; entry 0

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6810:: ; heuristic: key-world screen tile map; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $01, $11, $12, $13, $02, $1A
    db $00, $14, $02, $00, $03, $02, $00, $01, $27, $42, $43, $02, $2E, $00, $08, $02
    db $0D, $06, $11, $36, $37, $52, $53, $02, $42, $00, $18, $02, $21, $06, $07, $02
    db $2E, $02, $20, $21

; LZSS-compressed asset: 509 bytes expand to 526 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6844:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $196844, $73

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_68B7::
Data_065_68B7:: ; address name
    db $FF, $04, $08, $0B, $0D, $37, $C3, $00 ; entry 0

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_68BF:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1968BF, $D2

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6991::
Data_065_6991:: ; address name
    db $01, $03, $06, $08, $0D, $37, $C4, $00 ; entry 0

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6999:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196999, $A8

; LZSS-compressed asset: 517 bytes expand to 514 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6A41:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $02, $02, $B6, $00, $02, $EE, $02, $02, $F2, $00, $02, $A8, $02, $02, $18, $12
    db $02, $B8, $00, $02, $06, $10, $02, $BC, $02, $02, $2C, $12, $02, $18, $12, $02
    db $7C, $00, $02, $40, $14, $02, $2A, $14, $02, $90, $00, $02, $54, $14, $50, $51

; LZSS-compressed asset: 30 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6A71:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $1E, $0F, $0B, $01, $02, $7E, $03, $02
    db $72, $0F, $07, $02, $7E, $04, $02, $A7, $0F, $4D, $02, $07, $1F, $4D

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6A8F:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $40, $0F, $2D, $01, $03, $A0, $01, $02
    db $03, $A6, $03, $03, $A0, $02, $03, $A0, $0F, $03, $03, $A6, $04, $03, $A6, $08
    db $03, $CA, $0F, $01, $03, $C8, $0A, $03, $C2, $0F, $01, $03, $B0, $0F, $07, $03
    db $A2, $0F, $05, $03, $3A, $1F, $0F

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6AC6:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $40, $0F, $2D, $01, $01, $01, $01, $02
    db $94, $0C, $02, $A0, $0F, $2D, $02, $A2, $06, $02, $EC, $06, $02, $F4, $0F, $03
    db $02, $12, $1F, $37

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6AEA:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $196AEA, $42

; LZSS-compressed asset: 36 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6B2C:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $07, $02, $24, $0F, $07, $02
    db $2C, $08, $02, $34, $04, $02, $52, $0F, $27, $02, $52, $0C, $02, $AF, $0F, $4D
    db $02, $08, $1F, $45

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6B50:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $196B50, $4F

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6B9F:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $1B, $01, $02, $2E, $01, $02, $20, $0F, $0D, $02
    db $2E, $0F, $13, $02, $2C, $0F, $13, $02, $2E, $02, $02, $30, $06, $02, $A0, $06
    db $02, $A6, $0F, $05, $02, $32, $02, $02, $C4, $0F, $11, $02, $FB, $0F, $4D, $02
    db $B2, $08

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6BD1:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $196BD1, $54

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6C25:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $FF, $FF, $1D, $02, $02, $02, $02, $03, $20, $0F, $0D, $03
    db $30, $00, $04, $04, $03, $30, $00, $03, $32, $06, $03, $54, $0E, $02, $02, $01
    db $03

; LZSS-compressed asset: 97 bytes expand to 380 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6C46:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $7C, $01, $04, $04, $03, $58, $02, $03, $76, $0F, $03, $03, $7C, $02, $03, $A0
    db $04, $03, $58, $00, $03, $A0, $0A, $03, $AC, $0F, $01, $04, $04, $03, $B2, $0C
    db $03, $D2, $0A, $03, $56, $00, $03, $AE, $0C, $03, $F4, $0F, $01, $03, $F2, $00
    db $03, $D6, $0E, $03, $1E, $1F, $01, $03, $34, $1F, $0F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6C81::
Data_065_6C81:: ; address name
    db $01, $02, $04, $07, $0C, $39, $E0, $00 ; entry 0

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6C89:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196C89, $84

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6D0D::
Data_065_6D0D:: ; address name
    db $FF, $02, $04, $05, $07, $08, $E1, $00 ; entry 0

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6D15:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196D15, $50

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6D65::
Data_065_6D65:: ; address name
    db $FF, $00, $01, $02, $04, $08, $E2, $00 ; entry 0

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6D6D:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196D6D, $76

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6DE3::
Data_065_6DE3:: ; address name
    db $FF, $00, $01, $02, $07, $08, $E3, $00 ; entry 0

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6DEB:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196DEB, $A0

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6E8B::
Data_065_6E8B:: ; address name
    db $05, $02, $06, $0C, $0D, $39, $E4, $00 ; entry 0

; LZSS-compressed asset: 221 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6E93:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196E93, $DD

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_6F70::
Data_065_6F70:: ; address name
    db $00, $04, $06, $09, $0C, $39, $E5, $00 ; entry 0

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_6F78:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $196F78, $AB

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_7023::
Data_065_7023:: ; address name
    db $00, $02, $03, $06, $0F, $39, $E6, $00 ; entry 0

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_702B:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $19702B, $92

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_70BD::
Data_065_70BD:: ; address name
    db $FF, $03, $08, $09, $0B, $39, $E7, $00 ; entry 0

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_70C5:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1970C5, $9C

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_7161::
Data_065_7161:: ; address name
    db $01, $03, $05, $0A, $0B, $39, $E8, $00 ; entry 0

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7169:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $197169, $E8

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7251:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $4D, $02, $1A, $0F, $05, $02
    db $1A, $06, $02, $78, $0F, $0F, $02, $1C, $02, $02, $A0, $0F, $0F, $02, $72, $0F
    db $11, $02, $1E, $0F, $4D, $02, $F6, $0A

; LZSS-compressed asset: 23 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7279:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $4D, $02, $56, $0F, $4D, $02
    db $B6, $0F, $4D, $02, $02, $1F, $2B

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7290:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $37, $02, $F0, $FF, $01, $02
    db $54, $0F, $4D, $02, $8C, $0F, $19, $02, $8E, $0C, $02, $F0, $0F, $07, $02, $06
    db $0F, $37

; LZSS-compressed asset: 52 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_72B2:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $01, $03, $00, $05, $03, $F6, $FF, $3B, $03, $F4, $FF, $01, $03
    db $F4, $FE, $02, $02, $03, $6C, $0F, $11, $03, $7E, $0A, $03, $9E, $0F, $31, $03
    db $F4, $00, $03, $E6, $0F, $0F, $03, $7C, $00, $03, $08, $0E, $03, $1E, $1F, $01
    db $03, $06, $0F, $0F

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_72E6:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1972E6, $4E

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7334:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $197334, $48

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_737C:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $01, $02, $00, $05, $02, $F6, $FF, $39, $02, $F2, $FF, $01, $02
    db $56, $0F, $29, $02, $04, $0A, $02, $A0, $0F, $0D, $02, $06, $04, $02, $C8, $0F
    db $11, $02, $08, $00, $02, $F0, $0F, $0B, $02, $F6, $FF, $33

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_73A8:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1973A8, $42

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_73EA:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $1973EA, $55

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_743F::
Data_065_743F:: ; address name
    db $03, $03, $06, $07, $09, $3D, $04, $01 ; entry 0

; LZSS-compressed asset: 111 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7447:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $197447, $6F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_74B6::
Data_065_74B6:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $0C, $05, $01 ; entry 0

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_74BE:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1974BE, $5F

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_751D::
Data_065_751D:: ; address name
    db $FF, $03, $04, $05, $06, $26, $06, $01 ; entry 0

; LZSS-compressed asset: 126 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7525:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $197525, $7E

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_75A3::
Data_065_75A3:: ; address name
    db $01, $03, $06, $07, $09, $3D, $07, $01 ; entry 0

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_75AB:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1975AB, $96

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_7641::
Data_065_7641:: ; address name
    db $05, $05, $06, $08, $0B, $3D, $08, $01 ; entry 0

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7649:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $197649, $A4

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_76ED::
Data_065_76ED:: ; address name
    db $01, $04, $09, $0B, $0D, $3D, $09, $01 ; entry 0

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_76F5:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1976F5, $AF

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_77A4::
Data_065_77A4:: ; address name
    db $FF, $02, $04, $0A, $0C, $3D, $0A, $01 ; entry 0

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_77AC:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $1977AC, $CC

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_7878::
Data_065_7878:: ; address name
    db $FF, $02, $05, $0B, $0D, $3D, $0B, $01 ; entry 0

; LZSS-compressed asset: 202 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7880:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $197880, $CA

; E-0222 (derived: the 8-byte header of the screen stream that follows)
; record: screen header
KeyWorldScreenHeader_65_794A::
Data_065_794A:: ; address name
    db $01, $04, $09, $02, $0C, $3D, $0C, $01 ; entry 0

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7952:: ; heuristic: key-world screen tile map; C0
    INCBIN "dwm2-cobi-us.gbc", $197952, $DE

; LZSS-compressed asset: 33 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7A30:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $A0, $FF, $4D, $02, $1E, $0F, $0B, $01, $02, $7E, $03, $02
    db $72, $0F, $07, $02, $7E, $04, $02, $94, $0F, $3F, $02, $74, $0E, $02, $F8, $0F
    db $49

; LZSS-compressed asset: 47 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7A51:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $40, $0F, $2D, $01, $01, $02, $02, $03
    db $90, $0F, $15, $03, $A2, $0C, $03, $C8, $0F, $07, $03, $A2, $0A, $03, $F0, $0F
    db $09, $03, $A2, $08, $03, $18, $1F, $03, $03, $40, $14, $03, $36, $1F, $0B

; LZSS-compressed asset: 42 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7A80:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $43, $01, $01, $02, $44, $0F, $0F, $01, $02, $7A
    db $01, $02, $6C, $0F, $0D, $02, $7A, $02, $02, $7C, $0A, $02, $A0, $0F, $0B, $02
    db $56, $06, $02, $C8, $0F, $4D, $02, $9C, $0F, $19

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7AAA:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $03, $03, $A0, $FF, $4D, $03, $20, $0F, $0D, $02, $02, $02, $02, $03
    db $70, $0F, $09, $01, $03, $A0, $01, $03, $80, $00, $03, $80, $06, $03, $A0, $0F
    db $07, $03, $A4, $02, $03, $98, $0A, $03, $CE, $0F, $03, $01, $01, $03, $20, $06
    db $03, $F0, $0F, $4D, $03, $63, $10

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7AE1:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $1D, $01, $02, $30, $01, $02, $22, $0F, $15, $02
    db $34, $0A, $02, $58, $0C, $02, $58, $04, $02, $70, $0F, $09, $02, $7C, $08, $02
    db $34, $04, $02, $A0, $0F, $4D, $02, $78, $0A, $02, $4E, $0E, $02, $20, $1F, $21

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7B11:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $197B11, $4F

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7B60:: ; heuristic: key-world screen attribute map; C0
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $01, $02, $1A, $0F, $3D, $02, $2C, $06
    db $02, $2C, $04, $02, $7C, $0C, $02, $7C, $00, $02, $7C, $06, $02, $7C, $02, $02
    db $A0, $0F, $0D, $02, $A2, $04, $02, $C8, $0F, $09, $02, $C8, $0E, $02, $F6, $0F
    db $09, $02, $76, $06, $02, $1C, $1F, $07, $02, $72, $0A, $02, $44, $1C

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7B9E:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $197B9E, $46

; LZSS-compressed asset: 91 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_065_7BE4:: ; heuristic: key-world screen attribute map; C0
    INCBIN "dwm2-cobi-us.gbc", $197BE4, $5B
    ds $3C1, $00
