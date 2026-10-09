SECTION "Bank 57", ROMX[$4000], BANK[$57]
    db $57
    dw Data_057_4031
    db $57
    dw Data_057_413F
    db $57
    dw Data_057_426E
    db $57
    dw Data_057_447A
    db $57
    dw Data_057_4670
    db $57
    dw Data_057_46BC
    db $57
    dw Data_057_470C
    db $57
    dw Data_057_47DF
    db $57
    dw Data_057_4031
    db $57
    dw Data_057_413F
    db $57
    dw Data_057_437A
    db $57
    dw Data_057_4581
    db $57
    dw Data_057_4670
    db $57
    dw Data_057_46BC
    db $57
    dw Data_057_477C
    db $57
    dw Data_057_484F
    db $57

; LZSS-compressed asset: 270 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_4031:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C031, $10E

; LZSS-compressed asset: 303 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_413F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C13F, $12F

; LZSS-compressed asset: 268 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_426E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C26E, $10C

; LZSS-compressed asset: 256 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_437A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C37A, $100

; LZSS-compressed asset: 263 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_447A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C47A, $107

; LZSS-compressed asset: 239 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_4581:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C581, $EF

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_4670:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C670, $4C

; LZSS-compressed asset: 80 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_46BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C6BC, $50

; LZSS-compressed asset: 112 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_470C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C70C, $70

; LZSS-compressed asset: 99 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_477C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C77C, $63

; LZSS-compressed asset: 112 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_47DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C7DF, $70

; LZSS-compressed asset: 83 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_484F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15C84F, $B5B
    dw Data_057_540A
    db $57
    dw Data_057_54F7
    db $57
    dw Data_057_55C2
    db $57
    dw Data_057_5690
    db $57
    dw Data_057_5779
    db $57
    dw Data_057_5835
    db $57
    dw Data_057_58C7
    db $57
    dw Data_057_598C
    db $57
    dw Data_057_5A53
    db $57
    dw Data_057_5B0F
    db $57
    dw Data_057_5BEA
    db $57
    dw Data_057_5CDB
    db $57
    dw Data_057_5DB2
    db $57
    dw Data_057_5E58
    db $57
    dw Data_057_5F2E
    db $57
    dw Data_057_6009
    db $57
    dw Data_057_6100
    db $57
    dw Data_057_6154
    db $57
    dw Data_057_619F
    db $57
    dw Data_057_61ED
    db $57
    dw Data_057_624B
    db $57
    dw Data_057_6290
    db $57
    dw Data_057_62C1
    db $57
    dw Data_057_62F6
    db $57
    dw Data_057_6340
    db $57
    dw Data_057_6382
    db $57
    dw Data_057_63CA
    db $57
    dw Data_057_641B
    db $57
    dw Data_057_645F
    db $57
    dw Data_057_6491
    db $57
    dw Data_057_64E5
    db $57
    dw Data_057_6532
    db $57

; LZSS-compressed asset: 237 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_540A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D40A, $ED

; LZSS-compressed asset: 203 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_54F7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D4F7, $CB

; LZSS-compressed asset: 206 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_55C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D5C2, $CE

; LZSS-compressed asset: 233 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5690:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D690, $E9

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5779:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D779, $BC

; LZSS-compressed asset: 146 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5835:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D835, $92

; LZSS-compressed asset: 197 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_58C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D8C7, $C5

; LZSS-compressed asset: 199 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_598C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15D98C, $C7

; LZSS-compressed asset: 188 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5A53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15DA53, $BC

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5B0F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15DB0F, $DB

; LZSS-compressed asset: 241 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5BEA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15DBEA, $F1

; LZSS-compressed asset: 215 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5CDB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15DCDB, $D7

; LZSS-compressed asset: 166 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5DB2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15DDB2, $A6

; LZSS-compressed asset: 214 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5E58:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15DE58, $D6

; LZSS-compressed asset: 219 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_5F2E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15DF2E, $DB

; LZSS-compressed asset: 247 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6009:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E009, $F7

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6100:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E100, $54

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6154:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E154, $4B

; LZSS-compressed asset: 78 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_619F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E19F, $4E

; LZSS-compressed asset: 94 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_61ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E1ED, $5E

; LZSS-compressed asset: 69 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_624B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E24B, $45

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6290:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $F2, $01, $02, $06, $01, $02, $F8, $FF, $09, $02, $06
    db $02, $02, $1A, $0F, $0F, $03, $02, $50, $03, $02, $44, $0F, $0D, $02, $28, $08
    db $02, $83, $0F, $4D, $02, $28, $0C, $02, $E0, $0F, $4B, $02, $72, $0F, $01, $00
    db $00

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_62C1:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $F0, $01, $02, $04, $01, $02, $00, $0F, $19, $03, $02
    db $36, $01, $02, $28, $0F, $0B, $02, $08, $02, $02, $FC, $FA, $02, $5A, $06, $02
    db $54, $04, $02, $6C, $0F, $19, $02, $06, $0A, $02, $A6, $0F, $0B, $02, $D7, $0F
    db $4D, $02, $A8, $0F, $1D

; LZSS-compressed asset: 74 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_62F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E2F6, $4A

; LZSS-compressed asset: 66 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6340:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E340, $42

; LZSS-compressed asset: 72 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6382:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E382, $48

; LZSS-compressed asset: 81 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_63CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E3CA, $51

; LZSS-compressed asset: 68 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_641B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E41B, $44

; LZSS-compressed asset: 50 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_645F:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $F0, $01, $02, $04, $0B, $02, $00, $0F, $11, $03, $03
    db $03, $03, $02, $28, $0F, $0F, $03, $03, $02, $10, $0E, $02, $5E, $0F, $01, $02
    db $0E, $0F, $17, $02, $88, $0F, $31, $02, $02, $06, $02, $F8, $FF, $01, $02, $A0
    db $FF, $43

; LZSS-compressed asset: 84 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6491:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E491, $54

; LZSS-compressed asset: 77 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_64E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E4E5, $4D

; LZSS-compressed asset: 75 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_6532:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15E532, $C34
    dw Data_057_71C6
    db $57
    dw Data_057_71D9
    db $57
    dw Data_057_725A
    db $57
    dw Data_057_726D
    db $57
    dw Data_057_7280
    db $57
    dw Data_057_733F
    db $57
    dw Data_057_73DE
    db $57
    dw Data_057_7477
    db $57
    dw Data_057_752D
    db $57
    dw Data_057_7540
    db $57
    dw Data_057_75D3
    db $57
    dw Data_057_7668
    db $57
    dw Data_057_7718
    db $57
    dw Data_057_772B
    db $57
    dw Data_057_773E
    db $57
    dw Data_057_77D2
    db $57
    dw Data_057_77E5
    db $57
    dw Data_057_77F8
    db $57
    dw Data_057_7834
    db $57
    dw Data_057_7847
    db $57
    dw Data_057_785A
    db $57
    dw Data_057_7890
    db $57
    dw Data_057_78C6
    db $57
    dw Data_057_78FF
    db $57
    dw Data_057_793D
    db $57
    dw Data_057_7950
    db $57
    dw Data_057_7991
    db $57
    dw Data_057_79CA
    db $57
    dw Data_057_7A06
    db $57
    dw Data_057_7A19
    db $57
    dw Data_057_7A2C
    db $57
    dw Data_057_7A65
    db $57

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_71C6:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 129 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_71D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F1D9, $81

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_725A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_726D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 191 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7280:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F280, $BF

; LZSS-compressed asset: 159 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_733F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F33F, $9F

; LZSS-compressed asset: 153 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_73DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F3DE, $99

; LZSS-compressed asset: 182 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7477:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F477, $B6

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_752D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 147 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7540:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F540, $93

; LZSS-compressed asset: 149 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_75D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F5D3, $95

; LZSS-compressed asset: 176 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7668:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F668, $B0

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7718:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_772B:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 148 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_773E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F73E, $94

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_77D2:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_77E5:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_77F8:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $F2, $10, $02, $B7, $FF, $3C, $01, $02, $56, $03, $02
    db $4A, $0F, $0B, $02, $56, $00, $03, $03, $03, $03, $02, $5A, $08, $02, $7C, $0F
    db $03, $02, $80, $00, $02, $80, $0A, $02, $A4, $0F, $0B, $02, $82, $00, $02, $C6
    db $0F, $4D, $02, $EA, $0F, $05, $02, $5C, $02, $02, $44, $1C

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7834:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7847:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_785A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $F0, $01, $02, $04, $09, $02, $FE, $FF, $05, $02, $04
    db $00, $03, $02, $2E, $05, $02, $0E, $02, $02, $2A, $0F, $03, $02, $2E, $06, $02
    db $2E, $02, $02, $50, $0F, $4D, $02, $88, $0F, $1D, $02, $2C, $0F, $13, $02, $02
    db $0F, $15, $02, $41, $1F, $13

; LZSS-compressed asset: 54 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7890:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $00, $01, $01, $01, $01, $03, $02, $06, $07, $01, $01, $02
    db $00, $0F, $01, $02, $02, $0C, $02, $22, $04, $02, $2C, $0C, $02, $4F, $0F, $4D
    db $02, $90, $0F, $2D, $02, $28, $0F, $15, $02, $00, $0E, $02, $16, $1F, $05, $02
    db $00, $00, $02, $32, $1F, $0F

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_78C6:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $01, $02, $00, $07, $02, $F8, $FF, $09, $03, $02, $28, $05, $02
    db $06, $06, $02, $28, $0F, $0B, $02, $2E, $06, $02, $50, $0F, $0F, $02, $2E, $02
    db $02, $78, $0F, $4D, $02, $9C, $0E, $02, $5E, $0F, $13, $02, $48, $0F, $01, $02
    db $24, $1F, $03, $02, $22, $0C, $02, $4A, $16

; LZSS-compressed asset: 62 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_78FF:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $FF, $19, $01, $02, $2C, $07, $02, $24, $0F, $07, $02
    db $2C, $00, $03, $02, $56, $03, $02, $34, $04, $02, $52, $0F, $03, $02, $56, $04
    db $02, $5A, $02, $02, $76, $0F, $2F, $02, $54, $0F, $13, $02, $50, $06, $02, $34
    db $0C, $02, $F8, $0C, $02, $78, $04, $02, $12, $18, $02, $1C, $1F, $25

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_793D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 65 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7950:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15F950, $41

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7991:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $03, $02, $00, $07, $01, $02, $0C, $03, $02, $00, $0F, $0D, $02
    db $33, $0F, $4D, $02, $68, $0F, $21, $02, $24, $0F, $01, $02, $24, $0F, $01, $00
    db $00, $02, $DE, $0F, $17, $02, $12, $06, $02, $0C, $02, $02, $18, $1F, $03, $02
    db $F0, $08, $02, $3E, $12, $02, $40, $1F, $01

; LZSS-compressed asset: 60 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_79CA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $01, $02, $00, $03, $03, $03, $03, $03, $02, $00, $02, $02, $FE
    db $FF, $03, $02, $08, $00, $02, $28, $08, $02, $24, $0F, $4D, $02, $70, $0F, $2B
    db $02, $22, $0F, $01, $02, $22, $0C, $02, $0C, $04, $02, $EE, $0F, $03, $02, $00
    db $04, $02, $FC, $04, $02, $14, $1F, $05, $02, $3F, $1F, $15

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7A06:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7A19:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 57 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7A2C:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $F0, $01, $01, $03, $02, $06, $03, $01, $01, $02, $FC
    db $FF, $07, $01, $01, $02, $04, $08, $02, $0E, $02, $02, $2A, $0E, $02, $2A, $08
    db $02, $32, $04, $02, $50, $0F, $03, $02, $54, $08, $02, $32, $04, $02, $7A, $0F
    db $4D, $02, $DA, $0F, $4D, $02, $FE, $0F, $07

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_057_7A65:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35
    ds $588, $00
