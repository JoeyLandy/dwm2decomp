SECTION "Bank 4E", ROMX[$4000], BANK[$4E]
    db $4E

; compressed tileset of map $4F (the first map record using it)
; LZSS-compressed asset: 1490 bytes expand to 1776 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map4FTileset:: ; heuristic: map tileset stream; C0
Data_04E_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $138001, $5D2

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4FScreens0::
Data_04E_45D3:: ; address name
    dfar Data_04E_4603 ; entry 0
    dfar Data_04E_46E4 ; entry 1
    dfar Data_04E_47D5 ; entry 2
    dfar Data_04E_4991 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4FAttrs0::
Data_04E_45DF:: ; address name
    dfar Data_04E_4B40 ; entry 0
    dfar Data_04E_4B8F ; entry 1
    dfar Data_04E_4BE9 ; entry 2
    dfar Data_04E_4C61 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4FScreens2::
Data_04E_45EB:: ; address name
    dfar Data_04E_4603 ; entry 0
    dfar Data_04E_46E4 ; entry 1
    dfar Data_04E_48B9 ; entry 2
    dfar Data_04E_4A78 ; entry 3

; E-0142 (derived: 4 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map4FAttrs2::
Data_04E_45F7:: ; address name
    dfar Data_04E_4B40 ; entry 0
    dfar Data_04E_4B8F ; entry 1
    dfar Data_04E_4C25 ; entry 2
    dfar Data_04E_4C9E ; entry 3

; LZSS-compressed asset: 225 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4603:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $138603, $E1

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_46E4:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1386E4, $F1

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_47D5:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1387D5, $E4

; LZSS-compressed asset: 216 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_48B9:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1388B9, $D8

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4991:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $138991, $E7

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4A78:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $138A78, $C8

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4B40:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $138B40, $4F

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4B8F:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $138B8F, $5A

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4BE9:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $17, $02, $02, $01, $FF, $F4, $04, $01, $34, $01
    db $01, $26, $0F, $05, $01, $36, $04, $01, $46, $0F, $0F, $01, $FF, $FE, $01, $7A
    db $0F, $01, $01, $F0, $FF, $29, $01, $2A, $06, $01, $FA, $FF, $1D, $06, $01, $18
    db $17, $01, $16, $1A, $01, $1E, $1F, $07, $01, $3A, $1F, $09

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4C25:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $17, $02, $02, $01, $FF, $F4, $04, $01, $34, $01
    db $01, $26, $0F, $05, $01, $36, $04, $01, $46, $0F, $0F, $01, $FF, $FE, $01, $7A
    db $0F, $01, $01, $F0, $FF, $29, $01, $2A, $06, $01, $FA, $FF, $1D, $06, $01, $18
    db $17, $01, $16, $1A, $01, $1E, $1F, $07, $01, $3A, $1F, $09

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4C61:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $05, $02, $02, $01, $FC, $FF, $09, $04, $04, $01
    db $18, $0E, $01, $36, $0F, $03, $04, $04, $01, $4E, $0F, $11, $01, $12, $04, $01
    db $18, $0F, $0B, $01, $12, $0F, $03, $01, $8C, $00, $01, $8E, $0F, $11, $01, $FF
    db $FC, $06, $01, $FA, $05, $01, $F0, $0F, $01, $01, $0E, $1F, $3D

; LZSS-compressed asset: 61 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_4C9E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $05, $02, $02, $01, $FC, $FF, $09, $04, $04, $01
    db $18, $0E, $01, $36, $0F, $03, $04, $04, $01, $4E, $0F, $11, $01, $12, $04, $01
    db $18, $0F, $0B, $01, $12, $0F, $03, $01, $8C, $00, $01, $8E, $0F, $11, $01, $FF
    db $FC, $06, $01, $FA, $05, $01, $F0, $0F, $01, $01, $0E, $1F, $3D

; compressed tileset of map $50 (the first map record using it)
; LZSS-compressed asset: 1182 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map50Tileset:: ; heuristic: map tileset stream; C0
Data_04E_4CDB:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $138CDB, $49E

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map50Screens0::
Data_04E_5179:: ; address name
    dfar Data_04E_5185 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map50Attrs0::
Data_04E_517C:: ; address name
    dfar Data_04E_5248 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map51Screens0::
Data_04E_517F:: ; address name
    dfar Data_04E_5274 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map51Attrs0::
Data_04E_5182:: ; address name
    dfar Data_04E_5332 ; entry 0

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5185:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $139185, $C3

; LZSS-compressed asset: 44 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5248:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $00, $00, $02, $02, $02, $02, $01, $F2, $FF, $01, $01, $04, $0C
    db $01, $16, $02, $01, $02, $0A, $01, $2A, $0F, $4D, $01, $8A, $0F, $4D, $01, $D6
    db $0F, $31, $01, $FE, $F2, $01, $F0, $FF, $01, $01, $A0, $F8

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5274:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $139274, $BE

; LZSS-compressed asset: 70 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5332:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $139332, $46

; compressed tileset of map $52 (the first map record using it)
; LZSS-compressed asset: 811 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map52Tileset:: ; heuristic: map tileset stream; C0
Data_04E_5378:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $139378, $32B

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map52Screens0::
Data_04E_56A3:: ; address name
    dfar Data_04E_56C7 ; entry 0
    dfar Data_04E_57BF ; entry 1
    dfar Data_04E_58C0 ; entry 2
    dfar Data_04E_59A8 ; entry 3
    dfar Data_04E_56C7 ; entry 4
    dfar Data_04E_56C7 ; entry 5

; E-0142 (derived: 6 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map52Attrs0::
Data_04E_56B5:: ; address name
    dfar Data_04E_5A43 ; entry 0
    dfar Data_04E_5ABC ; entry 1
    dfar Data_04E_5B24 ; entry 2
    dfar Data_04E_5B90 ; entry 3
    dfar Data_04E_5A43 ; entry 4
    dfar Data_04E_5A43 ; entry 5

; LZSS-compressed asset: 248 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_56C7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1396C7, $F8

; LZSS-compressed asset: 257 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_57BF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1397BF, $101

; LZSS-compressed asset: 232 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_58C0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1398C0, $E8

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_59A8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $1399A8, $9B

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5A43:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $139A43, $79

; LZSS-compressed asset: 104 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5ABC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $139ABC, $68

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5B24:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $139B24, $6C

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_5B90:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $139B90, $52

; compressed tileset of map $53 (the first map record using it)
; LZSS-compressed asset: 1103 bytes expand to 1760 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map53Tileset:: ; heuristic: map tileset stream; C0
Data_04E_5BE2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $139BE2, $44F

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map53Screens0::
Data_04E_6031:: ; address name
    dfar Data_04E_6091 ; entry 0
    dfar Data_04E_6173 ; entry 1
    dfar Data_04E_61CD ; entry 2
    dfar Data_04E_62BC ; entry 3
    dfar Data_04E_62CF ; entry 4
    dfar Data_04E_6395 ; entry 5
    dfar Data_04E_6467 ; entry 6
    dfar Data_04E_6549 ; entry 7
    dfar Data_04E_65F7 ; entry 8
    dfar Data_04E_66CD ; entry 9
    dfar Data_04E_67CB ; entry 10
    dfar Data_04E_68AB ; entry 11
    dfar Data_04E_6942 ; entry 12
    dfar Data_04E_6A2B ; entry 13
    dfar Data_04E_6ADA ; entry 14
    dfar Data_04E_6BB1 ; entry 15

; E-0142 (derived: 16 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map53Attrs0::
Data_04E_6061:: ; address name
    dfar Data_04E_6C80 ; entry 0
    dfar Data_04E_6CD6 ; entry 1
    dfar Data_04E_6CF8 ; entry 2
    dfar Data_04E_6D4A ; entry 3
    dfar Data_04E_6D5D ; entry 4
    dfar Data_04E_6DB0 ; entry 5
    dfar Data_04E_6E06 ; entry 6
    dfar Data_04E_6E67 ; entry 7
    dfar Data_04E_6EA8 ; entry 8
    dfar Data_04E_6F01 ; entry 9
    dfar Data_04E_6F63 ; entry 10
    dfar Data_04E_6FC3 ; entry 11
    dfar Data_04E_6FFA ; entry 12
    dfar Data_04E_704E ; entry 13
    dfar Data_04E_7090 ; entry 14
    dfar Data_04E_70D1 ; entry 15

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6091:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A091, $E2

; LZSS-compressed asset: 90 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6173:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A173, $5A

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_61CD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A1CD, $EF

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_62BC:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_62CF:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A2CF, $C6

; LZSS-compressed asset: 210 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6395:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A395, $D2

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6467:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A467, $E2

; LZSS-compressed asset: 174 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6549:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A549, $AE

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_65F7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A5F7, $D6

; LZSS-compressed asset: 254 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_66CD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A6CD, $FE

; LZSS-compressed asset: 224 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_67CB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A7CB, $E0

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_68AB:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A8AB, $97

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6942:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13A942, $E9

; LZSS-compressed asset: 175 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6A2B:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AA2B, $AF

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6ADA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AADA, $D7

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6BB1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13ABB1, $CF

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6C80:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AC80, $56

; LZSS-compressed asset: 34 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6CD6:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $FF, $3D, $05, $01, $50, $0F, $14, $02, $01, $78, $0F
    db $14, $03, $01, $A0, $0F, $4D, $01, $B8, $0F, $04, $01, $50, $0F, $15, $01, $A0
    db $FF, $15

; LZSS-compressed asset: 82 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6CF8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13ACF8, $52

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6D4A:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6D5D:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AD5D, $53

; LZSS-compressed asset: 86 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6DB0:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13ADB0, $56

; LZSS-compressed asset: 97 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6E06:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AE06, $61

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6E67:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AE67, $41

; LZSS-compressed asset: 89 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6EA8:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AEA8, $59

; LZSS-compressed asset: 98 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6F01:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AF01, $62

; LZSS-compressed asset: 96 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6F63:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AF63, $60

; LZSS-compressed asset: 55 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6FC3:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $FF, $F0, $05, $05, $03, $01, $06, $01, $05, $05, $01, $FA
    db $FF, $3D, $01, $0C, $06, $01, $54, $0F, $09, $02, $02, $01, $72, $0F, $0D, $01
    db $04, $0E, $01, $A4, $0F, $01, $01, $A2, $06, $01, $C2, $0F, $0D, $01, $02, $04
    db $01, $EA, $0F, $4D, $01, $0E, $16

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_6FFA:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13AFFA, $54

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_704E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B04E, $42

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7090:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B090, $41

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_70D1:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B0D1, $4F

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map56Screens0::
Data_04E_7120:: ; address name
    dfar Data_04E_7132 ; entry 0
    dfar Data_04E_71CC ; entry 1
    dfar Data_04E_72A7 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map56Attrs0::
Data_04E_7129:: ; address name
    dfar Data_04E_739E ; entry 0
    dfar Data_04E_73DD ; entry 1
    dfar Data_04E_7432 ; entry 2

; LZSS-compressed asset: 154 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7132:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B132, $9A

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_71CC:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B1CC, $DB

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_72A7:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B2A7, $F7

; LZSS-compressed asset: 63 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_739E:: ; heuristic: map screen stream; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $1E, $0F, $0B, $05, $01, $7E, $05, $01
    db $74, $0F, $09, $01, $7E, $00, $02, $01, $A8, $01, $01, $84, $06, $01, $A4, $0F
    db $03, $02, $02, $03, $01, $D0, $01, $01, $AC, $00, $01, $C6, $0F, $09, $01, $D0
    db $02, $01, $D0, $00, $01, $EC, $0F, $33, $01, $7E, $00, $01, $36, $1F, $0B

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_73DD:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B3DD, $55

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7432:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13B432, $55

; compressed tileset of map $57 (the first map record using it)
; LZSS-compressed asset: 1345 bytes expand to 1520 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map57Tileset:: ; heuristic: map tileset stream; C0
Data_04E_7487:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $13B487, $541

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map57Palettes::
Data_04E_79C8:: ; address name
    dw $1415, $7FFF, $3C1F, $0000 ; entry 0
    dw $184C, $7FFF, $6980, $0000 ; entry 1
    dw $184C, $0217, $1116, $0000 ; entry 2
    dw $0854, $029E, $1116, $0000 ; entry 3
    dw $001B, $2BFF, $023F, $0000 ; entry 4
    dw $0186, $3F3D, $02AF, $0084 ; entry 5
    dw $218C, $4F18, $3A52, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map57Screens0::
Data_04E_7A08:: ; address name
    dfar Data_04E_7A1A ; entry 0
    dfar Data_04E_7B3E ; entry 1
    dfar Data_04E_7C76 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map57Attrs0::
Data_04E_7A11:: ; address name
    dfar Data_04E_7DA6 ; entry 0
    dfar Data_04E_7E12 ; entry 1
    dfar Data_04E_7E87 ; entry 2

; LZSS-compressed asset: 292 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7A1A:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13BA1A, $124

; LZSS-compressed asset: 312 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7B3E:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13BB3E, $138

; LZSS-compressed asset: 304 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7C76:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13BC76, $130

; LZSS-compressed asset: 108 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7DA6:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13BDA6, $6C

; LZSS-compressed asset: 117 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7E12:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13BE12, $75

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_04E_7E87:: ; heuristic: map screen stream; C0
    INCBIN "dwm2-cobi-us.gbc", $13BE87, $67
    ds $112, $00
