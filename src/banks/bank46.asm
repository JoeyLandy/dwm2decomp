SECTION "Bank 46", ROMX[$4000], BANK[$46]
    db $46

; LZSS-compressed asset: 644 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $118001, $284

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens0::
Data_046_4285:: ; heuristic: map screen array; C0
    dfar Data_046_4435 ; entry 0
    dfar Data_046_4435 ; entry 1
    dfar Data_046_4435 ; entry 2
    dfar Data_046_4435 ; entry 3
    dfar Data_046_4451 ; entry 4
    dfar Data_046_4686 ; entry 5
    dfar Data_046_47B2 ; entry 6
    dfar Data_046_496B ; entry 7
    dfar Data_046_49F6 ; entry 8
    dfar Data_046_4C1D ; entry 9
    dfar Data_046_4CF6 ; entry 10
    dfar Data_046_4E30 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Attrs0::
Data_046_42A9:: ; heuristic: map screen array; C0
    dfar Data_046_4F4F ; entry 0
    dfar Data_046_4F4F ; entry 1
    dfar Data_046_4F4F ; entry 2
    dfar Data_046_4F4F ; entry 3
    dfar Data_046_4F6B ; entry 4
    dfar Data_046_5133 ; entry 5
    dfar Data_046_521D ; entry 6
    dfar Data_046_5301 ; entry 7
    dfar Data_046_5363 ; entry 8
    dfar Data_046_551B ; entry 9
    dfar Data_046_55CD ; entry 10
    dfar Data_046_5698 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens2::
Data_046_42CD:: ; heuristic: map screen array; C0
    dfar Data_046_4435 ; entry 0
    dfar Data_046_4435 ; entry 1
    dfar Data_046_4435 ; entry 2
    dfar Data_046_4435 ; entry 3
    dfar Data_046_4516 ; entry 4
    dfar Data_046_4686 ; entry 5
    dfar Data_046_47B2 ; entry 6
    dfar Data_046_496B ; entry 7
    dfar Data_046_4AA8 ; entry 8
    dfar Data_046_4C1D ; entry 9
    dfar Data_046_4D98 ; entry 10
    dfar Data_046_4ECE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Attrs2::
Data_046_42F1:: ; heuristic: map screen array; C0
    dfar Data_046_4F4F ; entry 0
    dfar Data_046_4F4F ; entry 1
    dfar Data_046_4F4F ; entry 2
    dfar Data_046_4F4F ; entry 3
    dfar Data_046_4FEF ; entry 4
    dfar Data_046_5133 ; entry 5
    dfar Data_046_521D ; entry 6
    dfar Data_046_5301 ; entry 7
    dfar Data_046_53FB ; entry 8
    dfar Data_046_551B ; entry 9
    dfar Data_046_5630 ; entry 10
    dfar Data_046_56DE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens3::
Data_046_4315:: ; heuristic: map screen array; C0
    dfar Data_046_4435 ; entry 0
    dfar Data_046_4435 ; entry 1
    dfar Data_046_4435 ; entry 2
    dfar Data_046_4435 ; entry 3
    dfar Data_046_45BB ; entry 4
    dfar Data_046_4686 ; entry 5
    dfar Data_046_47B2 ; entry 6
    dfar Data_046_496B ; entry 7
    dfar Data_046_4B60 ; entry 8
    dfar Data_046_4C1D ; entry 9
    dfar Data_046_4D98 ; entry 10
    dfar Data_046_4ECE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Attrs3::
Data_046_4339:: ; heuristic: map screen array; C0
    dfar Data_046_4F4F ; entry 0
    dfar Data_046_4F4F ; entry 1
    dfar Data_046_4F4F ; entry 2
    dfar Data_046_4F4F ; entry 3
    dfar Data_046_5072 ; entry 4
    dfar Data_046_5133 ; entry 5
    dfar Data_046_521D ; entry 6
    dfar Data_046_5301 ; entry 7
    dfar Data_046_5494 ; entry 8
    dfar Data_046_551B ; entry 9
    dfar Data_046_5630 ; entry 10
    dfar Data_046_56DE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens4::
Data_046_435D:: ; heuristic: map screen array; C0
    dfar Data_046_4435 ; entry 0
    dfar Data_046_4435 ; entry 1
    dfar Data_046_4435 ; entry 2
    dfar Data_046_4435 ; entry 3
    dfar Data_046_45BB ; entry 4
    dfar Data_046_4719 ; entry 5
    dfar Data_046_47B2 ; entry 6
    dfar Data_046_496B ; entry 7
    dfar Data_046_4B60 ; entry 8
    dfar Data_046_4C1D ; entry 9
    dfar Data_046_4D98 ; entry 10
    dfar Data_046_4ECE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Attrs4::
Data_046_4381:: ; heuristic: map screen array; C0
    dfar Data_046_4F4F ; entry 0
    dfar Data_046_4F4F ; entry 1
    dfar Data_046_4F4F ; entry 2
    dfar Data_046_4F4F ; entry 3
    dfar Data_046_5072 ; entry 4
    dfar Data_046_51A7 ; entry 5
    dfar Data_046_521D ; entry 6
    dfar Data_046_5301 ; entry 7
    dfar Data_046_5494 ; entry 8
    dfar Data_046_551B ; entry 9
    dfar Data_046_5630 ; entry 10
    dfar Data_046_56DE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens5::
Data_046_43A5:: ; heuristic: map screen array; C0
    dfar Data_046_4435 ; entry 0
    dfar Data_046_4435 ; entry 1
    dfar Data_046_4435 ; entry 2
    dfar Data_046_4435 ; entry 3
    dfar Data_046_45BB ; entry 4
    dfar Data_046_4719 ; entry 5
    dfar Data_046_488C ; entry 6
    dfar Data_046_496B ; entry 7
    dfar Data_046_4B60 ; entry 8
    dfar Data_046_4C1D ; entry 9
    dfar Data_046_4D98 ; entry 10
    dfar Data_046_4ECE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Attrs5::
Data_046_43C9:: ; heuristic: map screen array; C0
    dfar Data_046_4F4F ; entry 0
    dfar Data_046_4F4F ; entry 1
    dfar Data_046_4F4F ; entry 2
    dfar Data_046_4F4F ; entry 3
    dfar Data_046_5072 ; entry 4
    dfar Data_046_51A7 ; entry 5
    dfar Data_046_528E ; entry 6
    dfar Data_046_5301 ; entry 7
    dfar Data_046_5494 ; entry 8
    dfar Data_046_551B ; entry 9
    dfar Data_046_5630 ; entry 10
    dfar Data_046_56DE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Screens6::
Data_046_43ED:: ; heuristic: map screen array; C0
    dfar Data_046_4435 ; entry 0
    dfar Data_046_4435 ; entry 1
    dfar Data_046_4435 ; entry 2
    dfar Data_046_4435 ; entry 3
    dfar Data_046_4451 ; entry 4
    dfar Data_046_4719 ; entry 5
    dfar Data_046_488C ; entry 6
    dfar Data_046_496B ; entry 7
    dfar Data_046_4B60 ; entry 8
    dfar Data_046_4C1D ; entry 9
    dfar Data_046_4D98 ; entry 10
    dfar Data_046_4ECE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map00Attrs6::
Data_046_4411:: ; heuristic: map screen array; C0
    dfar Data_046_4F4F ; entry 0
    dfar Data_046_4F4F ; entry 1
    dfar Data_046_4F4F ; entry 2
    dfar Data_046_4F4F ; entry 3
    dfar Data_046_4F6B ; entry 4
    dfar Data_046_51A7 ; entry 5
    dfar Data_046_528E ; entry 6
    dfar Data_046_5301 ; entry 7
    dfar Data_046_5494 ; entry 8
    dfar Data_046_551B ; entry 9
    dfar Data_046_5630 ; entry 10
    dfar Data_046_56DE ; entry 11

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4435:: ; heuristic: map screen stream; C0
    db $68, $01, $02, $00, $01, $02, $00, $0E, $02, $01, $0F, $00, $02, $FF, $FF, $4D
    db $02, $5F, $0F, $4D, $02, $BF, $0F, $4D, $02, $F7, $0F, $0E

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4451:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118451, $C5

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4516:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118516, $A5

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_45BB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1185BB, $CB

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4686:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118686, $93

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4719:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118719, $99

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_47B2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1187B2, $DA

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_488C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11888C, $DF

; LZSS-compressed asset: 139 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_496B:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $11896B, $8B

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_49F6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1189F6, $B2

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4AA8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118AA8, $B8

; LZSS-compressed asset: 189 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4B60:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118B60, $BD

; LZSS-compressed asset: 217 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4C1D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118C1D, $D9

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4CF6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118CF6, $A2

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4D98:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118D98, $98

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4E30:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118E30, $9E

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4ECE:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118ECE, $81

; LZSS-compressed asset: 28 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4F4F:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $10, $01, $FF, $FF, $00, $01, $FF, $FF, $01, $01, $00, $0F, $4D
    db $01, $60, $0F, $4D, $01, $C0, $0F, $4D, $01, $F8, $0F, $0D

; LZSS-compressed asset: 132 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4F6B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118F6B, $84

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_4FEF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $118FEF, $83

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5072:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119072, $C1

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5133:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119133, $5A

; LZSS-compressed asset: 257 bytes expand to 258 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_518D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $02, $01, $40, $02, $01, $58, $0F, $0C, $01, $29, $01, $01, $19, $00, $01, $56
    db $04, $01, $60, $03, $01, $15, $01, $01, $48, $18

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_51A7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1191A7, $76

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_521D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11921D, $71

; LZSS-compressed asset: 115 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_528E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11928E, $73

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5301:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $119301, $62

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5363:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119363, $98

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_53FB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1193FB, $99

; LZSS-compressed asset: 135 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5494:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119494, $87

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_551B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11951B, $B2

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_55CD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1195CD, $63

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5630:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119630, $68

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5698:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119698, $46

; LZSS-compressed asset: 46 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_56DE:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $05, $03, $03, $03, $03, $01, $FA, $FF, $37, $01
    db $0A, $00, $01, $48, $0F, $15, $01, $F8, $FC, $01, $80, $0E, $01, $80, $08, $01
    db $9E, $0F, $03, $01, $58, $08, $01, $C0, $0F, $31, $01, $17, $1F, $3D

; compressed tileset of map $01 (the first map record using it)
; LZSS-compressed asset: 1352 bytes expand to 1712 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map01Tileset:: ; heuristic: map tileset stream; C0
Data_046_570C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11970C, $548

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Screens0::
Data_046_5C54:: ; heuristic: map screen array; C0
    dfar Data_046_5DBC ; entry 0
    dfar Data_046_5E80 ; entry 1
    dfar Data_046_5DBC ; entry 2
    dfar Data_046_5DBC ; entry 3
    dfar Data_046_5F5A ; entry 4
    dfar Data_046_5FCD ; entry 5
    dfar Data_046_609A ; entry 6
    dfar Data_046_6254 ; entry 7
    dfar Data_046_63DB ; entry 8
    dfar Data_046_657C ; entry 9
    dfar Data_046_66A7 ; entry 10
    dfar Data_046_68FE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Attrs0::
Data_046_5C78:: ; heuristic: map screen array; C0
    dfar Data_046_6A9B ; entry 0
    dfar Data_046_6AF1 ; entry 1
    dfar Data_046_6A9B ; entry 2
    dfar Data_046_6A9B ; entry 3
    dfar Data_046_6B58 ; entry 4
    dfar Data_046_6B88 ; entry 5
    dfar Data_046_6BE6 ; entry 6
    dfar Data_046_6C8B ; entry 7
    dfar Data_046_6D18 ; entry 8
    dfar Data_046_6DD2 ; entry 9
    dfar Data_046_6E67 ; entry 10
    dfar Data_046_6F65 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Screens3::
Data_046_5C9C:: ; heuristic: map screen array; C0
    dfar Data_046_5DBC ; entry 0
    dfar Data_046_5E80 ; entry 1
    dfar Data_046_5DBC ; entry 2
    dfar Data_046_5DBC ; entry 3
    dfar Data_046_5F5A ; entry 4
    dfar Data_046_5FCD ; entry 5
    dfar Data_046_6169 ; entry 6
    dfar Data_046_633F ; entry 7
    dfar Data_046_63DB ; entry 8
    dfar Data_046_657C ; entry 9
    dfar Data_046_6750 ; entry 10
    dfar Data_046_69E5 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Attrs3::
Data_046_5CC0:: ; heuristic: map screen array; C0
    dfar Data_046_6A9B ; entry 0
    dfar Data_046_6AF1 ; entry 1
    dfar Data_046_6A9B ; entry 2
    dfar Data_046_6A9B ; entry 3
    dfar Data_046_6B58 ; entry 4
    dfar Data_046_6B88 ; entry 5
    dfar Data_046_6C2F ; entry 6
    dfar Data_046_6CD3 ; entry 7
    dfar Data_046_6D18 ; entry 8
    dfar Data_046_6DD2 ; entry 9
    dfar Data_046_6EA0 ; entry 10
    dfar Data_046_6FC8 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Screens4::
Data_046_5CE4:: ; heuristic: map screen array; C0
    dfar Data_046_5DBC ; entry 0
    dfar Data_046_5E80 ; entry 1
    dfar Data_046_5DBC ; entry 2
    dfar Data_046_5DBC ; entry 3
    dfar Data_046_5F5A ; entry 4
    dfar Data_046_5FCD ; entry 5
    dfar Data_046_6169 ; entry 6
    dfar Data_046_633F ; entry 7
    dfar Data_046_64A0 ; entry 8
    dfar Data_046_657C ; entry 9
    dfar Data_046_6750 ; entry 10
    dfar Data_046_69E5 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Attrs4::
Data_046_5D08:: ; heuristic: map screen array; C0
    dfar Data_046_6A9B ; entry 0
    dfar Data_046_6AF1 ; entry 1
    dfar Data_046_6A9B ; entry 2
    dfar Data_046_6A9B ; entry 3
    dfar Data_046_6B58 ; entry 4
    dfar Data_046_6B88 ; entry 5
    dfar Data_046_6C2F ; entry 6
    dfar Data_046_6CD3 ; entry 7
    dfar Data_046_6D6F ; entry 8
    dfar Data_046_6DD2 ; entry 9
    dfar Data_046_6EA0 ; entry 10
    dfar Data_046_6FC8 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Screens5::
Data_046_5D2C:: ; heuristic: map screen array; C0
    dfar Data_046_5DBC ; entry 0
    dfar Data_046_5E80 ; entry 1
    dfar Data_046_5DBC ; entry 2
    dfar Data_046_5DBC ; entry 3
    dfar Data_046_5F5A ; entry 4
    dfar Data_046_5FCD ; entry 5
    dfar Data_046_6169 ; entry 6
    dfar Data_046_633F ; entry 7
    dfar Data_046_64A0 ; entry 8
    dfar Data_046_6612 ; entry 9
    dfar Data_046_6833 ; entry 10
    dfar Data_046_69E5 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Attrs5::
Data_046_5D50:: ; heuristic: map screen array; C0
    dfar Data_046_6A9B ; entry 0
    dfar Data_046_6AF1 ; entry 1
    dfar Data_046_6A9B ; entry 2
    dfar Data_046_6A9B ; entry 3
    dfar Data_046_6B58 ; entry 4
    dfar Data_046_6B88 ; entry 5
    dfar Data_046_6C2F ; entry 6
    dfar Data_046_6CD3 ; entry 7
    dfar Data_046_6D6F ; entry 8
    dfar Data_046_6E19 ; entry 9
    dfar Data_046_6F04 ; entry 10
    dfar Data_046_6FC8 ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Screens6::
Data_046_5D74:: ; heuristic: map screen array; C0
    dfar Data_046_5DBC ; entry 0
    dfar Data_046_5E80 ; entry 1
    dfar Data_046_5DBC ; entry 2
    dfar Data_046_5DBC ; entry 3
    dfar Data_046_5F5A ; entry 4
    dfar Data_046_5FCD ; entry 5
    dfar Data_046_609A ; entry 6
    dfar Data_046_6254 ; entry 7
    dfar Data_046_64A0 ; entry 8
    dfar Data_046_657C ; entry 9
    dfar Data_046_66A7 ; entry 10
    dfar Data_046_68FE ; entry 11

; E-0142 (derived: 12 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map01Attrs6::
Data_046_5D98:: ; heuristic: map screen array; C0
    dfar Data_046_6A9B ; entry 0
    dfar Data_046_6AF1 ; entry 1
    dfar Data_046_6A9B ; entry 2
    dfar Data_046_6A9B ; entry 3
    dfar Data_046_6B58 ; entry 4
    dfar Data_046_6B88 ; entry 5
    dfar Data_046_6BE6 ; entry 6
    dfar Data_046_6C8B ; entry 7
    dfar Data_046_6D6F ; entry 8
    dfar Data_046_6DD2 ; entry 9
    dfar Data_046_6E67 ; entry 10
    dfar Data_046_6F65 ; entry 11

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5DBC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119DBC, $C4

; LZSS-compressed asset: 218 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5E80:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $119E80, $DA

; LZSS-compressed asset: 115 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5F5A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $119F5A, $73

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_5FCD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $119FCD, $CD

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_609A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11A09A, $CF

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6169:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11A169, $EB

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6254:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11A254, $EB

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_633F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11A33F, $9C

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_63DB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11A3DB, $C5

; LZSS-compressed asset: 220 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_64A0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11A4A0, $DC

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_657C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11A57C, $96

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6612:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11A612, $95

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_66A7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11A6A7, $A9

; LZSS-compressed asset: 227 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6750:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11A750, $E3

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6833:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11A833, $CB

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_68FE:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11A8FE, $E7

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_69E5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11A9E5, $B6

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6A9B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AA9B, $56

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6AF1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AAF1, $67

; LZSS-compressed asset: 48 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6B58:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $00, $00, $04, $01, $02, $0D, $01, $00, $0F, $29, $02, $02, $01
    db $3E, $0F, $4D, $01, $62, $0F, $05, $03, $03, $04, $04, $01, $CA, $00, $01, $CC
    db $04, $01, $C6, $0F, $07, $01, $F2, $0C, $01, $F0, $0F, $03, $01, $66, $0F, $3B

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6B88:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AB88, $5E

; LZSS-compressed asset: 73 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6BE6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11ABE6, $49

; LZSS-compressed asset: 92 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6C2F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AC2F, $5C

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6C8B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AC8B, $48

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6CD3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11ACD3, $45

; LZSS-compressed asset: 87 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6D18:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AD18, $57

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6D6F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AD6F, $63

; LZSS-compressed asset: 71 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6DD2:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11ADD2, $47

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6E19:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AE19, $4E

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6E67:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $02, $01, $00, $05, $03, $03, $02, $02, $01, $FA, $FF, $15, $03
    db $03, $01, $24, $0F, $13, $01, $0C, $02, $01, $50, $0F, $11, $01, $84, $0A, $01
    db $82, $0E, $03, $01, $A8, $01, $01, $9A, $0F, $07, $01, $A8, $02, $01, $C8, $0F
    db $0F, $01, $A0, $0F, $15, $01, $12, $1F, $3D

; LZSS-compressed asset: 100 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6EA0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AEA0, $64

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6F04:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AF04, $61

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6F65:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AF65, $63

; LZSS-compressed asset: 93 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_6FC8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11AFC8, $5D

; compressed tileset of map $02 (the first map record using it)
; LZSS-compressed asset: 827 bytes expand to 1136 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map02Tileset:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_046_7025:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $11B025, $33B

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens0::
Data_046_7360:: ; heuristic: map screen array; C0
    dfar Data_046_73CC ; entry 0
    dfar Data_046_764A ; entry 1
    dfar Data_046_777A ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Attrs0::
Data_046_7369:: ; heuristic: map screen array; C0
    dfar Data_046_794C ; entry 0
    dfar Data_046_7A22 ; entry 1
    dfar Data_046_7A9D ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens1::
Data_046_7372:: ; heuristic: map screen array; C0
    dfar Data_046_74A3 ; entry 0
    dfar Data_046_764A ; entry 1
    dfar Data_046_777A ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Attrs1::
Data_046_737B:: ; heuristic: map screen array; C0
    dfar Data_046_7992 ; entry 0
    dfar Data_046_7A22 ; entry 1
    dfar Data_046_7A9D ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens3::
Data_046_7384:: ; heuristic: map screen array; C0
    dfar Data_046_73CC ; entry 0
    dfar Data_046_764A ; entry 1
    dfar Data_046_77FF ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Attrs3::
Data_046_738D:: ; heuristic: map screen array; C0
    dfar Data_046_794C ; entry 0
    dfar Data_046_7A22 ; entry 1
    dfar Data_046_7AD3 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens4::
Data_046_7396:: ; heuristic: map screen array; C0
    dfar Data_046_7578 ; entry 0
    dfar Data_046_764A ; entry 1
    dfar Data_046_77FF ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Attrs4::
Data_046_739F:: ; heuristic: map screen array; C0
    dfar Data_046_79D3 ; entry 0
    dfar Data_046_7A22 ; entry 1
    dfar Data_046_7AD3 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens5::
Data_046_73A8:: ; heuristic: map screen array; C0
    dfar Data_046_7578 ; entry 0
    dfar Data_046_76E4 ; entry 1
    dfar Data_046_78A7 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Attrs5::
Data_046_73B1:: ; heuristic: map screen array; C0
    dfar Data_046_79D3 ; entry 0
    dfar Data_046_7A5E ; entry 1
    dfar Data_046_7B23 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Screens6::
Data_046_73BA:: ; heuristic: map screen array; C0
    dfar Data_046_7578 ; entry 0
    dfar Data_046_764A ; entry 1
    dfar Data_046_777A ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map02Attrs6::
Data_046_73C3:: ; heuristic: map screen array; C0
    dfar Data_046_79D3 ; entry 0
    dfar Data_046_7A22 ; entry 1
    dfar Data_046_7A9D ; entry 2

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_73CC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11B3CC, $D7

; LZSS-compressed asset: 213 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_74A3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11B4A3, $D5

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_7578:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11B578, $D2

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_764A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11B64A, $9A

; LZSS-compressed asset: 150 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_76E4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11B6E4, $96

; LZSS-compressed asset: 133 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_777A:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $11B77A, $85

; LZSS-compressed asset: 168 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_77FF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11B7FF, $A8

; LZSS-compressed asset: 165 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_78A7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $11B8A7, $A5

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_794C:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11B94C, $46

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_7992:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11B992, $41

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_79D3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11B9D3, $4F

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_7A22:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FC, $02, $02, $02, $02, $01, $00, $0F, $01, $03, $01
    db $28, $01, $04, $04, $04, $04, $05, $05, $01, $28, $00, $01, $24, $0F, $0B, $01
    db $50, $0F, $47, $01, $4C, $0F, $01, $01, $10, $02, $01, $28, $00, $01, $04, $0A
    db $01, $C8, $0F, $03, $01, $F1, $0F, $4D, $01, $51, $1F, $03

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_7A5E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FC, $06, $06, $06, $06, $01, $FC, $FF, $01, $03, $01
    db $28, $01, $04, $04, $04, $04, $05, $05, $01, $28, $00, $01, $24, $0F, $0B, $01
    db $50, $0F, $47, $06, $06, $02, $02, $01, $50, $0C, $00, $00, $02, $02, $01, $26
    db $02, $01, $04, $0A, $01, $C8, $0E, $01, $ED, $0F, $4D, $01, $4D, $1F, $07

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_7A9D:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $68, $01, $01, $02, $01, $00, $0F, $3C, $03, $01, $50, $0F, $16, $01, $4E, $06
    db $01, $48, $06, $01, $7A, $0E, $01, $16, $0F, $29, $01, $3E, $0F, $01, $01, $FE
    db $FA, $01, $50, $02, $01, $F0, $0F, $03, $01, $FE, $F6, $01, $14, $14, $01, $18
    db $1F, $05, $01, $43, $1F, $11

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_7AD3:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11BAD3, $50

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_046_7B23:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $11BB23, $45
    ds $498, $00
