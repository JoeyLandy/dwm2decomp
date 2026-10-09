SECTION "Bank 52", ROMX[$4000], BANK[$52]
    INCBIN "dwm2-cobi-us.gbc", $148000, $583
    dw Data_052_459B
    db $52
    dw Data_052_4657
    db $52
    dw Data_052_46FC
    db $52
    dw Data_052_47DF
    db $52
    dw Data_052_489E
    db $52
    dw Data_052_48E8
    db $52
    dw Data_052_492E
    db $52
    dw Data_052_497C
    db $52

Data_052_459B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14859B, $BC

Data_052_4657:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148657, $A5

Data_052_46FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1486FC, $E3

Data_052_47DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1487DF, $BF

Data_052_489E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14889E, $4A

Data_052_48E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1488E8, $46

Data_052_492E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14892E, $4E

Data_052_497C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14897C, $4B
    dw Data_052_49DF
    db $52
    dw Data_052_4A9A
    db $52
    dw Data_052_4B33
    db $52
    dw Data_052_4BFC
    db $52
    dw Data_052_4CB1
    db $52
    dw Data_052_4CFA
    db $52
    dw Data_052_4D38
    db $52
    dw Data_052_4D7B
    db $52

Data_052_49DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1489DF, $BB

Data_052_4A9A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148A9A, $99

Data_052_4B33:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148B33, $C9

Data_052_4BFC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148BFC, $B5

Data_052_4CB1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148CB1, $49

Data_052_4CFA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $01, $02, $00, $0B, $02, $FC, $FF, $15, $02, $0E, $00, $02, $28
    db $0F, $13, $02, $50, $0F, $03, $04, $02, $78, $07, $02, $70, $0F, $15, $02, $82
    db $04, $02, $A0, $0F, $01, $02, $6C, $0C, $02, $C4, $0F, $11, $02, $D2, $0F, $09
    db $02, $7A, $0A, $02, $12, $1F, $07, $02, $76, $06, $02, $36, $1F, $0B

Data_052_4D38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148D38, $43

Data_052_4D7B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148D7B, $43
    dw Data_052_4DD6
    db $52
    dw Data_052_4EBA
    db $52
    dw Data_052_4F8A
    db $52
    dw Data_052_503E
    db $52
    dw Data_052_50F2
    db $52
    dw Data_052_5150
    db $52
    dw Data_052_5197
    db $52
    dw Data_052_51CD
    db $52

Data_052_4DD6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148DD6, $E4

Data_052_4EBA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148EBA, $D0

Data_052_4F8A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $148F8A, $B4

Data_052_503E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14903E, $B4

Data_052_50F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1490F2, $5E

Data_052_5150:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $149150, $47

Data_052_5197:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $09, $04, $04, $04, $04, $00, $00, $0A, $00, $0C
    db $0F, $25, $00, $0E, $00, $00, $58, $02, $00, $4E, $0F, $0B, $00, $76, $0F, $3D
    db $00, $70, $0F, $01, $00, $D0, $0F, $07, $00, $10, $00, $00, $10, $06, $00, $F8
    db $0F, $01, $00, $56, $0F, $35

Data_052_51CD:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $42, $04, $04, $00, $44, $0F, $11, $04, $00
    db $7C, $01, $00, $54, $0A, $00, $7C, $0E, $00, $7C, $02, $00, $7C, $04, $00, $9C
    db $0F, $05, $00, $7C, $06, $00, $BE, $0F, $0F, $00, $CE, $0A, $00, $EE, $0F, $07
    db $00, $A8, $0A, $00, $16, $1F, $03, $00, $00, $0F, $15
    dw Data_052_5220
    db $52
    dw Data_052_5316
    db $52
    dw Data_052_53D2
    db $52
    dw Data_052_549B
    db $52
    dw Data_052_5561
    db $52
    dw Data_052_55DE
    db $52
    dw Data_052_5629
    db $52
    dw Data_052_565E
    db $52

Data_052_5220:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $149220, $F6

Data_052_5316:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $149316, $BC

Data_052_53D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1493D2, $C9

Data_052_549B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14949B, $C6

Data_052_5561:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $149561, $7D

Data_052_55DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1495DE, $4B

Data_052_5629:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $00, $01, $02, $01, $0E, $02, $00, $0F, $01, $02, $15, $0F, $1B
    db $04, $04, $04, $04, $02, $46, $0F, $11, $02, $54, $00, $02, $7E, $06, $02, $78
    db $0F, $07, $02, $80, $0F, $13, $02, $7C, $08, $02, $C4, $0F, $0D, $02, $A4, $0F
    db $19, $02, $18, $1F, $31

Data_052_565E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14965E, $EE0
    ds $12, $00
    dw Data_052_6568
    db $52
    dw Data_052_668F
    db $52
    dw Data_052_67B3
    db $52
    dw Data_052_68EA
    db $52
    dw Data_052_6A0A
    db $52
    dw Data_052_6A65
    db $52
    dw Data_052_6AEE
    db $52
    dw Data_052_6B5A
    db $52

Data_052_6568:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14A568, $127

Data_052_668F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14A68F, $124

Data_052_67B3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14A7B3, $137

Data_052_68EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14A8EA, $120

Data_052_6A0A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14AA0A, $5B

Data_052_6A65:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14AA65, $89

Data_052_6AEE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14AAEE, $6C

Data_052_6B5A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14AB5A, $4AF
    ds $1A, $00
    INCBIN "dwm2-cobi-us.gbc", $14B023, $FDD
