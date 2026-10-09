SECTION "Bank 55", ROMX[$4000], BANK[$55]
    INCBIN "dwm2-cobi-us.gbc", $154000, $2DC
    dw Data_055_4312
    db $55
    dw Data_055_43D4
    db $55
    dw Data_055_4454
    db $55
    dw Data_055_44FE
    db $55
    dw Data_055_45C9
    db $55
    dw Data_055_46A0
    db $55
    dw Data_055_4738
    db $55
    dw Data_055_47BF
    db $55
    dw Data_055_489C
    db $55
    dw Data_055_4906
    db $55
    dw Data_055_4930
    db $55
    dw Data_055_4968
    db $55
    dw Data_055_49A4
    db $55
    dw Data_055_49E2
    db $55
    dw Data_055_4A27
    db $55
    dw Data_055_4A60
    db $55
    dw Data_055_4A8D
    db $55
    dw Data_055_4ACD
    db $55

Data_055_4312:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154312, $C2

Data_055_43D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1543D4, $80

Data_055_4454:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154454, $AA

Data_055_44FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1544FE, $CB

Data_055_45C9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1545C9, $D7

Data_055_46A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1546A0, $98

Data_055_4738:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154738, $87

Data_055_47BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1547BF, $DD

Data_055_489C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15489C, $6A

Data_055_4906:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $3E, $02, $00, $52, $05, $00, $50, $04, $00
    db $50, $0F, $2F, $00, $A0, $0A, $00, $A0, $0F, $4D, $00, $C4, $0C, $00, $56, $04
    db $00, $18, $1F, $09, $00, $44, $0E, $00, $00, $0A

Data_055_4930:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $01, $03, $00, $0F, $14, $04, $03, $28, $0F, $14, $02, $03, $50
    db $0F, $3C, $03, $00, $0F, $15, $10, $03, $C8, $01, $03, $26, $04, $03, $C6, $04
    db $03, $CA, $0F, $07, $03, $9A, $04, $03, $C8, $01, $00, $03, $04, $10, $03, $F6
    db $07, $03, $05, $11, $03, $06, $1F, $3B

Data_055_4968:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $01, $03, $00, $0F, $14, $04, $03, $28, $0D, $03, $26, $0F, $03
    db $02, $03, $50, $0D, $03, $4E, $0F, $2B, $03, $00, $02, $03, $92, $0F, $0F, $03
    db $4A, $0E, $03, $C6, $0F, $03, $10, $00, $10, $00, $03, $E0, $0F, $17, $03, $A0
    db $08, $03, $16, $1F, $07, $03, $FA, $F4, $03, $38, $1F, $09

Data_055_49A4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $01, $02, $02, $02, $02, $01, $00, $06, $0B, $00, $02, $0F
    db $07, $04, $00, $30, $05, $00, $26, $0F, $09, $00, $52, $08, $00, $4E, $0F, $2D
    db $00, $0E, $08, $00, $9A, $0F, $09, $00, $34, $04, $00, $58, $08, $00, $CA, $0F
    db $01, $00, $EA, $0A, $00, $EC, $0F, $37, $00, $9E, $0E, $00, $06, $08

Data_055_49E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1549E2, $45

Data_055_4A27:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $01, $03, $00, $07, $02, $03, $0C, $01, $03, $00, $08, $03, $0A
    db $06, $04, $03, $28, $05, $03, $1E, $0F, $0B, $03, $0C, $02, $03, $4A, $08, $03
    db $4E, $0F, $4D, $03, $0E, $0F, $07, $03, $00, $0F, $01, $03, $F6, $F8, $03, $E8
    db $0F, $3D, $03, $00, $04, $03, $40, $1F, $01

Data_055_4A60:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $01, $01, $02, $03, $02, $01, $01, $01, $03, $F6, $FF, $4D, $03
    db $42, $0F, $2D, $03, $A8, $08, $03, $A2, $0F, $09, $04, $03, $D2, $05, $03, $C8
    db $0F, $09, $03, $F2, $08, $03, $F0, $0F, $2B, $03, $40, $1F, $13

Data_055_4A8D:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $09, $02, $02, $02, $02, $00, $00, $0A, $00, $0C
    db $06, $04, $00, $2A, $05, $00, $20, $0F, $0B, $00, $0E, $00, $00, $52, $02, $00
    db $48, $0F, $37, $00, $A0, $0A, $00, $A0, $0F, $01, $04, $00, $B5, $0F, $14, $00
    db $56, $08, $00, $F8, $0A, $00, $F6, $0F, $23, $00, $12, $0C, $00, $40, $1F, $05

Data_055_4ACD:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $03, $10, $03, $00, $06, $00, $03, $0A, $05, $03, $01, $0F, $4D, $03
    db $11, $0A, $03, $1E, $00, $03, $73, $0F, $06, $01, $03, $A0, $0F, $14, $04, $03
    db $C8, $0D, $03, $C6, $0F, $03, $02, $03, $F0, $0D, $03, $EE, $0F, $2B, $03, $A0
    db $0F, $15
    dw Data_055_4B23
    db $55
    dw Data_055_4BEC
    db $55
    dw Data_055_4C90
    db $55
    dw Data_055_4D3F
    db $55
    dw Data_055_4DF8
    db $55
    dw Data_055_4EB9
    db $55
    dw Data_055_4F50
    db $55
    dw Data_055_4FA6
    db $55
    dw Data_055_4FEC
    db $55
    dw Data_055_5034
    db $55
    dw Data_055_5084
    db $55
    dw Data_055_50D6
    db $55

Data_055_4B23:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154B23, $C9

Data_055_4BEC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154BEC, $A4

Data_055_4C90:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154C90, $AF

Data_055_4D3F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154D3F, $B9

Data_055_4DF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154DF8, $C1

Data_055_4EB9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154EB9, $97

Data_055_4F50:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154F50, $56

Data_055_4FA6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154FA6, $46

Data_055_4FEC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $154FEC, $48

Data_055_5034:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155034, $50

Data_055_5084:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155084, $52

Data_055_50D6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1550D6, $66C
    dw Data_055_57AE
    db $55
    dw Data_055_58B7
    db $55
    dw Data_055_5A7D
    db $55
    dw Data_055_5B88
    db $55
    dw Data_055_5C53
    db $55
    dw Data_055_5D02
    db $55
    dw Data_055_5E02
    db $55
    dw Data_055_5F00
    db $55
    dw Data_055_5FF7
    db $55
    dw Data_055_60F2
    db $55
    dw Data_055_6163
    db $55
    dw Data_055_6239
    db $55
    dw Data_055_62BB
    db $55
    dw Data_055_632C
    db $55
    dw Data_055_637E
    db $55
    dw Data_055_63F6
    db $55
    dw Data_055_6467
    db $55
    dw Data_055_64C3
    db $55
    dw Data_055_57AE
    db $55
    dw Data_055_599A
    db $55
    dw Data_055_5A7D
    db $55
    dw Data_055_5B88
    db $55
    dw Data_055_5C53
    db $55
    dw Data_055_5D02
    db $55
    dw Data_055_5E02
    db $55
    dw Data_055_5F00
    db $55
    dw Data_055_5FF7
    db $55
    dw Data_055_60F2
    db $55
    dw Data_055_61CE
    db $55
    dw Data_055_6239
    db $55
    dw Data_055_62BB
    db $55
    dw Data_055_632C
    db $55
    dw Data_055_637E
    db $55
    dw Data_055_63F6
    db $55
    dw Data_055_6467
    db $55
    dw Data_055_64C3
    db $55

Data_055_57AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1557AE, $109

Data_055_58B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1558B7, $E3

Data_055_599A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15599A, $E3

Data_055_5A7D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155A7D, $10B

Data_055_5B88:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155B88, $CB

Data_055_5C53:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155C53, $AF

Data_055_5D02:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155D02, $100

Data_055_5E02:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155E02, $FE

Data_055_5F00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155F00, $F7

Data_055_5FF7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $155FF7, $FB

Data_055_60F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1560F2, $71

Data_055_6163:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156163, $6B

Data_055_61CE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1561CE, $6B

Data_055_6239:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156239, $82

Data_055_62BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1562BB, $71

Data_055_632C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15632C, $52

Data_055_637E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15637E, $78

Data_055_63F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1563F6, $71

Data_055_6467:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156467, $5C

Data_055_64C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1564C3, $4AD
    dw Data_055_69A6
    db $55
    dw Data_055_6A67
    db $55
    dw Data_055_6B39
    db $55
    dw Data_055_6C0B
    db $55
    dw Data_055_6CE2
    db $55
    dw Data_055_6DA4
    db $55
    dw Data_055_6E7B
    db $55
    dw Data_055_6F37
    db $55
    dw Data_055_701C
    db $55
    dw Data_055_7103
    db $55
    dw Data_055_7133
    db $55
    dw Data_055_716A
    db $55
    dw Data_055_71A3
    db $55
    dw Data_055_71EF
    db $55
    dw Data_055_7239
    db $55
    dw Data_055_7289
    db $55
    dw Data_055_72CD
    db $55
    dw Data_055_7317
    db $55

Data_055_69A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1569A6, $C1

Data_055_6A67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156A67, $D2

Data_055_6B39:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156B39, $D2

Data_055_6C0B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156C0B, $D7

Data_055_6CE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156CE2, $C2

Data_055_6DA4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156DA4, $D7

Data_055_6E7B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156E7B, $BC

Data_055_6F37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $156F37, $E5

Data_055_701C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15701C, $E7

Data_055_7103:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $01, $00, $2A, $06, $00, $26, $0F
    db $2F, $02, $00, $7C, $07, $00, $74, $0F, $07, $00, $7C, $08, $00, $84, $04, $00
    db $A2, $0F, $4D, $00, $76, $0F, $19, $00, $76, $04, $00, $00, $0E, $00, $3A, $18

Data_055_7133:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $01, $00, $2A, $06, $00, $26, $0F
    db $2F, $02, $00, $7C, $07, $00, $74, $0F, $07, $00, $82, $04, $00, $80, $08, $00
    db $A2, $0F, $07, $00, $7E, $0A, $00, $CA, $0F, $29, $00, $7A, $0F, $15, $00, $76
    db $04, $00, $00, $0E, $00, $3A, $18

Data_055_716A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $04, $00, $00, $0F, $1A, $01, $01, $00, $2A, $06, $00, $26, $0F
    db $2F, $02, $00, $7C, $07, $00, $74, $0F, $07, $00, $7C, $02, $05, $05, $00, $80
    db $08, $00, $A2, $0F, $07, $00, $7E, $0A, $00, $CA, $0F, $29, $00, $7A, $0F, $15
    db $00, $76, $04, $00, $00, $0E, $00, $3A, $18

Data_055_71A3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1571A3, $4C

Data_055_71EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1571EF, $4A

Data_055_7239:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157239, $50

Data_055_7289:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157289, $44

Data_055_72CD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1572CD, $4A

Data_055_7317:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157317, $47
    dw Data_055_7382
    db $55
    dw Data_055_7446
    db $55
    dw Data_055_74F4
    db $55
    dw Data_055_759D
    db $55
    dw Data_055_764F
    db $55
    dw Data_055_7703
    db $55
    dw Data_055_77C4
    db $55
    dw Data_055_7815
    db $55
    dw Data_055_7863
    db $55
    dw Data_055_78AD
    db $55
    dw Data_055_78F6
    db $55
    dw Data_055_793F
    db $55

Data_055_7382:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157382, $C4

Data_055_7446:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157446, $AE

Data_055_74F4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1574F4, $A9

Data_055_759D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15759D, $B2

Data_055_764F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15764F, $B4

Data_055_7703:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157703, $C1

Data_055_77C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1577C4, $51

Data_055_7815:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157815, $4E

Data_055_7863:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157863, $4A

Data_055_78AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1578AD, $49

Data_055_78F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1578F6, $49

Data_055_793F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $15793F, $4A
    dw Data_055_79A1
    db $55
    dw Data_055_7A57
    db $55
    dw Data_055_7B15
    db $55
    dw Data_055_7BD7
    db $55
    dw Data_055_7C77
    db $55
    dw Data_055_7CC0
    db $55
    dw Data_055_7D13
    db $55
    dw Data_055_7D62
    db $55

Data_055_79A1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1579A1, $B6

Data_055_7A57:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157A57, $BE

Data_055_7B15:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157B15, $C2

Data_055_7BD7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157BD7, $A0

Data_055_7C77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157C77, $49

Data_055_7CC0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157CC0, $53

Data_055_7D13:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157D13, $4F

Data_055_7D62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $157D62, $46
    ds $258, $00
