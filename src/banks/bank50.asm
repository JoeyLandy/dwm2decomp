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

Data_050_41F1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1401F1, $1CC

Data_050_43BD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1403BD, $C1

Data_050_447E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14047E, $EF

Data_050_456D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14056D, $D4

Data_050_4641:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $140641, $9A

Data_050_46DB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1406DB, $A6

Data_050_4781:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $140781, $CB

Data_050_484C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14084C, $BF

Data_050_490B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14090B, $BC

Data_050_49C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1409C7, $BA

Data_050_4A81:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $140A81, $5A4

Data_050_5025:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141025, $DF

Data_050_5104:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141104, $159

Data_050_525D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14125D, $18A

Data_050_53E7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1413E7, $142

Data_050_5529:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141529, $16B

Data_050_5694:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141694, $18F

Data_050_5823:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141823, $A9

Data_050_58CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1418CC, $7F

Data_050_594B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14194B, $C8

Data_050_5A13:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141A13, $169

Data_050_5B7C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141B7C, $1C6

Data_050_5D42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141D42, $163

Data_050_5EA5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $141EA5, $162

Data_050_6007:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142007, $EB

Data_050_60F2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1420F2, $150

Data_050_6242:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142242, $197

Data_050_63D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1423D9, $EA

Data_050_64C3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1424C3, $7A

Data_050_653D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14253D, $74

Data_050_65B1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1425B1, $CB

Data_050_667C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14267C, $CD

Data_050_6749:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142749, $A6

Data_050_67EF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1427EF, $D0

Data_050_68BF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1428BF, $A2

Data_050_6961:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142961, $C2

Data_050_6A23:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142A23, $74

Data_050_6A97:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142A97, $E4

Data_050_6B7B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142B7B, $97

Data_050_6C12:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142C12, $AA

Data_050_6CBC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142CBC, $AB

Data_050_6D67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142D67, $A1

Data_050_6E08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142E08, $5F

Data_050_6E67:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142E67, $A4

Data_050_6F0B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $142F0B, $201

Data_050_710C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14310C, $D0

Data_050_71DC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1431DC, $B8

Data_050_7294:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143294, $7A

Data_050_730E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14330E, $A9

Data_050_73B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1433B7, $94

Data_050_744B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $14344B, $D7

Data_050_7522:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143522, $1FF

Data_050_7721:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143721, $102

Data_050_7823:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143823, $B1

Data_050_78D4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1438D4, $E7

Data_050_79BB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1439BB, $ED

Data_050_7AA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143AA8, $CF

Data_050_7B77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143B77, $A6

Data_050_7C1D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143C1D, $F9

Data_050_7D16:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143D16, $F3

Data_050_7E09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143E09, $AB

Data_050_7EB4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $143EB4, $C8
    ds $84, $00
