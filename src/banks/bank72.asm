SECTION "Bank 72", ROMX[$4000], BANK[$72]
    db $72, $70, $43, $70, $43
    dw Data_072_4247
    db $70, $43
    dw Data_072_4370
    db $0D, $43
    dw Data_072_43D3
    db $70, $43
    dw Data_072_4436
    db $25, $46
    dw Data_072_4625
    db $25, $46
    dw Data_072_4625
    db $99, $44
    dw Data_072_4688
    db $25, $46
    dw Data_072_46EB
    db $DA, $48
    dw Data_072_48DA
    db $DA, $48
    dw Data_072_48DA
    db $77, $48
    dw Data_072_493D
    db $DA, $48
    dw Data_072_49A0
    db $8F, $4B
    dw Data_072_4B8F
    db $8F, $4B
    dw Data_072_4B8F
    db $03, $4A
    dw Data_072_4BF2
    db $8F, $4B
    dw Data_072_4C55
    db $44, $4E
    dw Data_072_4E44
    db $44, $4E
    dw Data_072_4E44
    db $E1, $4D
    dw Data_072_4EA7
    db $44, $4E
    dw Data_072_50F9
    db $6D, $4F
    dw Data_072_50F9
    db $F9, $50
    dw Data_072_50F9
    db $0A, $4F
    dw Data_072_515C
    db $F9, $50
    dw Data_072_53AE
    db $AE, $53
    dw Data_072_53AE
    db $E8, $52
    dw Data_072_53AE
    db $BF, $51
    dw Data_072_5411
    db $AE, $53
    dw Data_072_5663
    db $63, $56
    dw Data_072_5663
    db $63, $56
    dw Data_072_5600
    db $3A, $55
    dw Data_072_56C6
    db $63, $56
    dw Data_072_5729
    db $18, $59
    dw Data_072_5918
    db $18, $59
    dw Data_072_5918
    db $52, $58
    dw Data_072_597B
    db $18, $59
    dw Data_072_5BCD
    db $41, $5A
    dw Data_072_5BCD
    db $CD, $5B
    dw Data_072_5BCD
    db $A4, $5A
    dw Data_072_5C30
    db $CD, $5B
    dw Data_072_5C93
    db $82, $5E
    dw Data_072_5E82
    db $82, $5E
    dw Data_072_5E82
    db $59, $5D
    dw Data_072_5EE5
    db $82, $5E
    dw Data_072_6137
    db $AB, $5F
    dw Data_072_6137
    db $37, $61
    dw Data_072_6137
    db $D4, $60
    dw Data_072_619A
    db $37, $61
    dw Data_072_63EC
    db $EC, $63
    dw Data_072_63EC
    db $26, $63
    dw Data_072_63EC
    db $60, $62
    dw Data_072_644F
    db $EC, $63
    dw Data_072_66A1
    db $A1, $66
    dw Data_072_66A1
    db $A1, $66
    dw Data_072_663E
    db $DB, $65, $04, $67
    dw Data_072_66A1
    db $56, $69, $56, $69
    dw Data_072_682D
    db $56, $69, $56, $69
    dw Data_072_68F3
    db $B9, $69, $56, $69
    dw Data_072_6A1C
    db $0B, $6C, $0B, $6C
    dw Data_072_6C0B
    db $0B, $6C, $7F, $6A
    dw Data_072_6C6E
    db $0B, $6C, $C0, $6E
    dw Data_072_6EC0
    db $C0, $6E, $C0, $6E
    dw Data_072_6E5D
    db $FA, $6D
    dw Data_072_6F23
    db $C0, $6E
    dw Data_072_7175
    db $75, $71
    dw Data_072_7175
    db $AF, $70
    dw Data_072_7175
    db $86, $6F
    dw Data_072_71D8
    db $75, $71
    dw Data_072_742A
    db $9E, $72
    dw Data_072_742A
    db $2A, $74
    dw Data_072_742A
    db $01, $73
    dw Data_072_748D
    db $2A, $74
    dw Data_072_76DF
    db $DF, $76
    dw Data_072_76DF
    db $19, $76
    dw Data_072_76DF
    db $B6, $75
    dw Data_072_7742
    db $DF, $76
    dw Data_072_77A5
    db $08, $78
    dw Data_072_786B
    db $CE, $78
    dw Data_072_7931
    INCBIN "dwm2-cobi-us.gbc", $1C814B, $FC

Data_072_4247:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8247, $129

Data_072_4370:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8370, $63

Data_072_43D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C83D3, $63

Data_072_4436:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8436, $1EF

Data_072_4625:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8625, $63

Data_072_4688:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8688, $63

Data_072_46EB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C86EB, $1EF

Data_072_48DA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C88DA, $63

Data_072_493D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C893D, $63

Data_072_49A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C89A0, $1EF

Data_072_4B8F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8B8F, $63

Data_072_4BF2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8BF2, $63

Data_072_4C55:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8C55, $1EF

Data_072_4E44:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8E44, $63

Data_072_4EA7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C8EA7, $252

Data_072_50F9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C90F9, $63

Data_072_515C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C915C, $252

Data_072_53AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C93AE, $63

Data_072_5411:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9411, $1EF

Data_072_5600:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9600, $63

Data_072_5663:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9663, $63

Data_072_56C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C96C6, $63

Data_072_5729:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9729, $1EF

Data_072_5918:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9918, $63

Data_072_597B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C997B, $252

Data_072_5BCD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9BCD, $63

Data_072_5C30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9C30, $63

Data_072_5C93:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1C9C93, $1EF

Data_072_5E82:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $03, $77, $7C, $71, $77, $7C, $71, $D2, $55, $6F, $A5
    dw Data_072_715D
    db $77, $7C, $71, $E8
    dw Data_072_716C
    db $F4, $6E, $6E, $77
    dw Data_072_717C
    db $77, $7C, $71, $77
    dw Data_072_717C
    db $01, $40, $71, $77
    dw Data_072_717C
    db $77, $7C, $71, $77
    dw Data_072_717C
    db $77, $7C, $71, $77
    dw Data_072_717C
    db $8A, $7E, $71, $8A
    dw Data_072_717E
    db $24, $60, $6F, $CC, $68, $71, $8A, $7E, $71, $9B, $78, $71, $80, $74, $6E, $8A
    db $7E, $71, $8A, $7E, $71, $8A, $7E, $71, $F4, $4B, $71, $8A, $7E, $71, $8A, $7E
    db $71, $8A, $7E, $71, $8A, $7E, $71, $8A, $7E, $71

Data_072_5EE5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $03, $77, $7C, $71, $77, $7C, $71, $77, $7C, $71, $CC, $50, $71, $77
    db $7C, $71, $CC, $50, $71, $48, $75, $71, $3B, $6D, $6E, $77, $7C, $71, $F6, $47
    db $70, $01
    dw Data_072_6F40
    db $A6
    dw Data_072_7056
    db $77
    dw Data_072_717C
    db $77
    dw Data_072_717C
    db $77
    dw Data_072_717C
    db $77
    dw Data_072_717C
    db $8A
    dw Data_072_717E
    db $8A
    dw Data_072_717E
    db $8A
    dw Data_072_717E
    INCBIN "dwm2-cobi-us.gbc", $1C9F21, $216

Data_072_6137:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CA137, $63

Data_072_619A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CA19A, $252

Data_072_63EC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CA3EC, $63

Data_072_644F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CA44F, $1EF

Data_072_663E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CA63E, $63

Data_072_66A1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $03, $04, $77, $7C, $71, $77, $7C, $71, $77, $7C, $71, $CC, $50, $71, $77
    db $7C, $71, $77, $7C, $71, $77, $7C, $71, $5D, $6D, $70, $77, $7C, $71, $38, $57
    db $6F, $59
    dw Data_072_6F40
    db $A6, $56, $70, $E8
    dw Data_072_716C
    db $A6, $56, $70, $77
    dw Data_072_717C
    db $77, $7C, $71, $8A
    dw Data_072_717E
    db $8A, $7E, $71, $8A
    dw Data_072_717E
    db $2B, $5A, $71, $8A
    dw Data_072_717E
    db $8A, $7E, $71, $8A
    dw Data_072_717E
    db $45, $77, $70, $8A
    dw Data_072_717E
    INCBIN "dwm2-cobi-us.gbc", $1CA6EF, $13E

Data_072_682D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CA82D, $C6

Data_072_68F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CA8F3, $129

Data_072_6A1C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CAA1C, $1EF

Data_072_6C0B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CAC0B, $63

Data_072_6C6E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CAC6E, $1EF

Data_072_6E5D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CAE5D, $63

Data_072_6EC0:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $04, $77, $7C, $71, $77, $7C, $71, $77, $7C, $71, $77, $7C, $71, $77
    db $7C, $71, $31, $6D, $71, $90, $66, $6F, $77, $7C, $71, $77, $7C, $71, $77, $7C
    db $71, $C4, $6A, $70, $77, $7C, $71, $31, $6D, $71, $01
    dw Data_072_6F40
    db $A6
    dw Data_072_7056
    db $77
    dw Data_072_717C
    db $8A
    dw Data_072_717E
    db $8A
    dw Data_072_717E
    db $8A
    dw Data_072_717E
    db $8A
    dw Data_072_717E
    db $8A
    dw Data_072_717E
    db $B9, $78, $71, $CD, $72, $6F, $8A, $7E, $71, $8A, $7E, $71, $8A, $7E, $71, $52
    db $76, $70, $8A, $7E, $71, $B9, $78, $71, $CE, $4B, $6F, $21, $63, $70, $8A, $7E
    db $71

Data_072_6F23:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $04, $3E, $53, $6F, $99, $5B, $6D, $F0, $71, $6F, $77, $7C, $71, $FE
    db $72, $70, $FE, $6A, $70, $5D, $6D, $70, $77, $7C, $71, $C4, $6A

Data_072_6F40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CAF40, $116

Data_072_7056:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB056, $107

Data_072_715D:: ; heuristic: target of a monotone pointer table; C0
    db $4B, $5A, $71, $A3, $50, $70, $39, $43, $6E, $00, $71, $6E, $25, $50, $70

Data_072_716C:: ; heuristic: target of a monotone pointer table; C0
    db $BA, $4C, $6F, $53, $4D, $6F, $21, $63, $70

Data_072_7175:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $05, $77, $7C, $71, $77

Data_072_717C:: ; heuristic: target of a monotone pointer table; C0
    db $7C, $71

Data_072_717E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB17E, $5A

Data_072_71D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB1D8, $252

Data_072_742A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB42A, $63

Data_072_748D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB48D, $252

Data_072_76DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB6DF, $63

Data_072_7742:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB742, $63

Data_072_77A5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB7A5, $C6

Data_072_786B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB86B, $C6

Data_072_7931:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1CB931, $630
    ds $9F, $00
