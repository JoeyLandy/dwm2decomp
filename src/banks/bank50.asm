SECTION "Bank 50", ROMX[$4000], BANK[$50]
    INCBIN "dwm2-cobi-us.gbc", $140000, $B0
    dw Data_050_41F1
    db $50, $87, $4F, $50
    dw Data_050_5025
    db $50, $F1, $41, $50
    dw Data_050_5104
    db $50, $86, $51, $50
    dw Data_050_525D
    db $50, $4C, $53, $50
    dw Data_050_53E7
    db $50, $85, $54, $50
    dw Data_050_5529
    db $50, $D3, $55, $50
    dw Data_050_5694
    db $50, $61, $57, $50
    dw Data_050_5823
    db $50
    dw Data_050_58CC
    db $50, $F1, $41, $50
    dw Data_050_594B
    db $50, $F1, $41, $50
    dw Data_050_5A13
    db $50, $BD, $5A, $50
    dw Data_050_5B7C
    db $50, $42, $5C, $50
    dw Data_050_5D42
    db $50, $B3, $5D, $50
    dw Data_050_5EA5
    db $50, $57, $5F, $50
    dw Data_050_6007
    db $50, $F1, $41, $50
    dw Data_050_60F2
    db $50, $99, $61, $50
    dw Data_050_6242
    db $50, $1D, $63, $50
    dw Data_050_41F1
    db $50
    dw Data_050_41F1
    db $50
    dw Data_050_41F1
    db $50
    dw Data_050_63D9
    db $50
    dw Data_050_64C3
    db $50
    dw Data_050_653D
    db $50
    dw Data_050_65B1
    db $50
    dw Data_050_667C
    db $50
    dw Data_050_6749
    db $50
    dw Data_050_67EF
    db $50
    dw Data_050_68BF
    db $50
    dw Data_050_6961
    db $50
    dw Data_050_41F1
    db $50
    dw Data_050_41F1
    db $50
    dw Data_050_41F1
    db $50
    dw Data_050_6A23
    db $50
    dw Data_050_6A97
    db $50
    dw Data_050_6B7B
    db $50
    dw Data_050_6C12
    db $50
    dw Data_050_6CBC
    db $50
    dw Data_050_6D67
    db $50
    dw Data_050_6E08
    db $50
    dw Data_050_6E67
    db $50
    dw Data_050_6F0B
    db $50, $F1, $41, $50, $F1, $41, $50, $D0, $6F, $50, $58, $70, $50
    dw Data_050_41F1
    db $50
    dw Data_050_710C
    db $50
    dw Data_050_71DC
    db $50
    dw Data_050_7294
    db $50
    dw Data_050_730E
    db $50
    dw Data_050_73B7
    db $50
    dw Data_050_744B
    db $50
    dw Data_050_7522
    db $50, $F1, $41, $50, $F1, $41, $50, $F1, $75, $50, $84, $76, $50
    dw Data_050_41F1
    db $50
    dw Data_050_41F1
    db $50
    dw Data_050_7721
    db $50
    dw Data_050_7823
    db $50
    dw Data_050_78D4
    db $50
    dw Data_050_79BB
    db $50
    dw Data_050_7AA8
    db $50
    dw Data_050_7B77
    db $50
    dw Data_050_7C1D
    db $50
    dw Data_050_7D16
    db $50
    dw Data_050_7E09
    db $50
    dw Data_050_7EB4
    db $50, $01, $40, $51, $8A, $40, $51, $68, $41, $51, $F3, $41, $51, $D9, $42, $51
    dw Data_050_41F1
    db $50
    dw Data_050_41F1
    db $50
    dw Data_050_43BD
    db $51
    dw Data_050_447E
    db $51
    dw Data_050_456D
    db $51
    dw Data_050_4641
    db $51
    dw Data_050_46DB
    db $51
    dw Data_050_4781
    db $51
    dw Data_050_484C
    db $51
    dw Data_050_490B
    db $51
    dw Data_050_49C7
    db $51
    dw Data_050_4A81
    db $51, $F1, $41, $50, $F1, $41, $50, $F1, $41, $50, $22, $4B, $51, $D5, $4B, $51

; LZSS-compressed asset: 29 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_41F1:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $28, $29, $00, $00, $0E, $38, $39, $00, $14, $0E, $00, $00, $0F
    db $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D, $00, $F8, $0F, $0D

; LZSS-compressed asset: 156 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_420E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14020E, $9C

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_42AA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1402AA, $BF

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4369:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140369, $54

Data_050_43BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1403BD, $77

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4434:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140434, $4A

Data_050_447E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14047E, $67

; LZSS-compressed asset: 121 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_44E5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1404E5, $79

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_455E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $02, $28, $29, $28, $29, $06, $07, $40, $41, $02, $06, $00, $42

Data_050_456D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14056D, $B5

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4622:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $00, $42, $43, $42, $43, $40, $41, $40, $41, $24, $25, $04, $05, $28
    db $29, $00, $0C, $02, $52, $53, $52, $53, $50, $51, $50, $51, $34, $35, $14

Data_050_4641:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $140641, $88

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_46C9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $02, $28, $29, $06, $07, $2A, $2B, $02, $04, $02, $42, $43, $02, $0C
    db $02, $38

Data_050_46DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1406DB, $A6

Data_050_4781:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $18, $02, $F0, $00, $02, $C8, $0A, $02, $2A, $12, $02, $DC, $0A, $54, $55

; LZSS-compressed asset: 187 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4791:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140791, $BB

; LZSS-compressed asset: 145 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_484C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14084C, $91

; LZSS-compressed asset: 204 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_48DD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $04, $28, $29, $04, $00, $00, $00, $01, $02, $03, $04, $08, $06, $38
    db $39, $04, $14, $00, $10, $11, $12, $13, $04, $1C, $06, $04, $02, $02, $26, $27
    db $40, $41, $04, $30, $00, $2A, $2B, $04, $36, $00, $04, $16, $02, $36

Data_050_490B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14090B, $9E

; LZSS-compressed asset: 168 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_49A9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $00, $02, $03, $04, $05, $28, $29, $00, $04, $0A, $12, $13, $14, $15
    db $38, $39, $00, $18, $0A, $2A, $2B, $24, $25, $00, $00, $0C, $3A, $3B

Data_050_49C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1409C7, $8A

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4A51:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $68, $01, $24, $28, $29, $24, $00, $02, $00, $01, $02, $03, $24, $0A, $02, $04
    db $05, $38, $39, $24, $14, $02, $10, $11, $12, $13, $24, $1E, $02, $14, $15, $24
    db $04, $04, $26, $27, $2A, $2B, $2C, $2D, $40, $41, $40, $41, $08, $09, $24, $18

Data_050_4A81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $140A81, $C1

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4B42:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140B42, $DE

; LZSS-compressed asset: 173 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4C20:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140C20, $AD

; LZSS-compressed asset: 196 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4CCD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140CCD, $C4

; LZSS-compressed asset: 190 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4D91:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140D91, $BE

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4E4F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140E4F, $A1

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4EF0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140EF0, $97

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_4F87:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $140F87, $9E

; LZSS-compressed asset: 223 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5025:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141025, $DF

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5104:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141104, $82

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5186:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141186, $D7

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_525D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14125D, $EF

; LZSS-compressed asset: 155 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_534C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14134C, $9B

; LZSS-compressed asset: 158 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_53E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1413E7, $9E

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5485:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141485, $A4

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5529:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141529, $AA

; LZSS-compressed asset: 193 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_55D3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1415D3, $C1

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5694:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141694, $CD

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5761:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141761, $C2

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5823:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141823, $A9

; LZSS-compressed asset: 127 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_58CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1418CC, $7F

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_594B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14194B, $C8

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5A13:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141A13, $AA

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5ABD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141ABD, $BF

; LZSS-compressed asset: 198 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5B7C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141B7C, $C6

; LZSS-compressed asset: 256 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5C42:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141C42, $100

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5D42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141D42, $71

; LZSS-compressed asset: 242 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5DB3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141DB3, $F2

; LZSS-compressed asset: 178 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5EA5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141EA5, $B2

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_5F57:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $141F57, $B0

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6007:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142007, $EB

; LZSS-compressed asset: 167 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_60F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1420F2, $A7

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6199:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $142199, $A9

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6242:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142242, $DB

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_631D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $14231D, $BC

; LZSS-compressed asset: 234 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_63D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1423D9, $EA

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_64C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1424C3, $7A

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_653D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14253D, $74

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_65B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1425B1, $CB

; LZSS-compressed asset: 205 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_667C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14267C, $CD

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6749:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142749, $A6

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_67EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1427EF, $D0

; LZSS-compressed asset: 162 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_68BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1428BF, $A2

; LZSS-compressed asset: 194 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6961:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142961, $C2

; LZSS-compressed asset: 116 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6A23:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142A23, $74

; LZSS-compressed asset: 228 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6A97:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142A97, $E4

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6B7B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142B7B, $97

; LZSS-compressed asset: 170 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6C12:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142C12, $AA

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6CBC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142CBC, $AB

; LZSS-compressed asset: 161 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6D67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142D67, $A1

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6E08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142E08, $5F

; LZSS-compressed asset: 164 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6E67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142E67, $A4

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6F0B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142F0B, $C5

; LZSS-compressed asset: 136 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_6FD0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $142FD0, $88

; LZSS-compressed asset: 180 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7058:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $143058, $B4

; LZSS-compressed asset: 208 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_710C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14310C, $D0

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_71DC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1431DC, $B8

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7294:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143294, $7A

; LZSS-compressed asset: 169 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_730E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14330E, $A9

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_73B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1433B7, $94

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_744B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14344B, $D7

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7522:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143522, $CF

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_75F1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1435F1, $93

; LZSS-compressed asset: 157 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7684:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $143684, $9D

; LZSS-compressed asset: 258 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7721:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143721, $102

; LZSS-compressed asset: 177 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7823:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143823, $B1

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_78D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1438D4, $E7

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_79BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1439BB, $ED

; LZSS-compressed asset: 207 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7AA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143AA8, $CF

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7B77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143B77, $A6

; LZSS-compressed asset: 249 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7C1D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143C1D, $F9

; LZSS-compressed asset: 243 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7D16:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143D16, $F3

; LZSS-compressed asset: 171 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7E09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143E09, $AB

; LZSS-compressed asset: 200 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_050_7EB4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143EB4, $C8
    ds $84, $00
