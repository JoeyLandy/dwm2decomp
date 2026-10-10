SECTION "Bank 48", ROMX[$4000], BANK[$48]
    db $48

Data_048_4001:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $120001, $80

Data_048_4081:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $120081, $D5B

; LZSS-compressed asset: 860 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_4DDC:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $120DDC, $35C

Data_048_5138:: ; heuristic: argument of a bank-switching copy helper; C0
    db $86, $7D, $FF, $7F, $E1, $7F, $00, $00, $2F, $01, $1D, $03, $D8, $01, $00, $00
    db $2F, $01, $FF, $67, $14, $02, $00, $00, $8F, $15, $98, $42, $13, $2A, $20, $00
    db $6A, $30, $BF, $50, $71, $30, $20, $00, $CE, $29, $FF, $4F, $95, $36, $20, $00
    db $A9, $04, $FF, $50, $2E, $09, $20, $00, $4A, $29, $FF, $7F, $52, $4A, $00, $00
    dw Data_048_519C
    db $48
    dw Data_048_523C
    db $48
    dw Data_048_52D3
    db $48
    dw Data_048_5362
    db $48
    dw Data_048_53D3
    db $48
    dw Data_048_541D
    db $48
    dw Data_048_547C
    db $48
    dw Data_048_54BF
    db $48
    dw Data_048_5509
    db $48
    dw Data_048_5544
    db $48
    dw Data_048_557C
    db $48
    dw Data_048_55A4
    db $48

; LZSS-compressed asset: 160 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_519C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12119C, $A0

; LZSS-compressed asset: 151 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_523C:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $12123C, $97

; LZSS-compressed asset: 143 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_52D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1212D3, $8F

; LZSS-compressed asset: 113 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5362:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $121362, $71

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_53D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1213D3, $4A

; LZSS-compressed asset: 95 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_541D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12141D, $5F

; LZSS-compressed asset: 67 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_547C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $12147C, $43

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_54BF:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1214BF, $4A

; LZSS-compressed asset: 59 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5509:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $03, $00, $00, $01, $01, $01, $00, $00, $02, $00, $00, $00, $02
    db $02, $00, $00, $0F, $37, $00, $06, $00, $00, $4E, $0F, $03, $04, $00, $78, $01
    db $01, $01, $00, $78, $00, $00, $70, $0F, $0F, $00, $A0, $04, $00, $9A, $0F, $3D
    db $00, $82, $00, $00, $EE, $0F, $39, $00, $9A, $0F, $07

; LZSS-compressed asset: 56 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5544:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $02, $02, $03, $03, $01, $01, $04, $00, $06, $09, $00, $00, $0F
    db $4D, $00, $10, $04, $06, $06, $00, $6A, $0F, $15, $00, $7C, $0A, $00, $A0, $0F
    db $05, $00, $7A, $00, $00, $18, $02, $00, $18, $02, $00, $C8, $0F, $07, $00, $F2
    db $0A, $00, $F0, $0F, $4D, $00, $CA, $00

; LZSS-compressed asset: 40 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_557C:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $90, $0F, $1C
    db $03, $03, $01, $01, $04, $04, $00, $F2, $00, $00, $F4, $02, $01, $01, $03, $03
    db $00, $F0, $0F, $03, $00, $16, $1F, $3B

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_55A4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $09, $01, $01, $03, $03, $02, $02, $00, $00, $0F
    db $4D, $00, $24, $0E, $04, $04, $00, $74, $0F, $13, $06, $06, $00, $9C, $0F, $09
    db $01, $01, $00, $A8, $06, $00, $C4, $0F, $05, $00, $D6, $00, $00, $F0, $0A, $00
    db $EE, $0F, $4D, $00, $D6, $02

; LZSS-compressed asset: 1627 bytes expand to 1920 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_55DA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1215DA, $6A3

; LZSS-compressed asset: 229 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5C7D:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $121C7D, $E5

; LZSS-compressed asset: 231 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5D62:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $121D62, $E7

; LZSS-compressed asset: 235 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5E49:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $121E49, $EB

; LZSS-compressed asset: 226 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_5F34:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $121F34, $E2

; LZSS-compressed asset: 201 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_6016:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $122016, $C9

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_60DF:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1220DF, $113

; LZSS-compressed asset: 130 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_61F2:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1221F2, $166F

; LZSS-compressed asset: 1494 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_048_7861:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $123861, $5FC
    ds $1A, $00
    INCBIN "dwm2-cobi-us.gbc", $123E77, $16D
    ds $1C, $00
