SECTION "Bank 4F", ROMX[$4000], BANK[$4F]
    INCBIN "dwm2-cobi-us.gbc", $13C000, $3AA
    ds $22, $00
    INCBIN "dwm2-cobi-us.gbc", $13C3CC, $869
    ds $12, $00
    dw Data_04F_4C5F
    db $4F
    dw Data_04F_4D63
    db $4F
    dw Data_04F_4E51
    db $4F
    dw Data_04F_4F43
    db $4F
    dw Data_04F_5027
    db $4F
    dw Data_04F_507C
    db $4F
    dw Data_04F_50C6
    db $4F
    dw Data_04F_5105
    db $4F

Data_04F_4C5F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13CC5F, $104

Data_04F_4D63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13CD63, $EE

Data_04F_4E51:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13CE51, $F2

Data_04F_4F43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13CF43, $E4

Data_04F_5027:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13D027, $55

Data_04F_507C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13D07C, $4A

Data_04F_50C6:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $02, $02, $FF, $F8, $03, $03, $03, $03, $02, $FC, $FF, $07, $01, $02
    db $2A, $03, $02, $1E, $0F, $0D, $04, $02, $52, $01, $02, $30, $04, $02, $0C, $02
    db $02, $52, $0F, $07, $04, $04, $02, $6E, $0F, $17, $02, $FF, $F6, $02, $A2, $0F
    db $4B, $02, $30, $00, $02, $B4, $0F, $0D, $02, $2C, $04, $02, $3F, $1F, $15

Data_04F_5105:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13D105, $466
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $13D57D, $410
    dw Data_04F_59ED
    db $4F
    dw Data_04F_5AB0
    db $4F
    dw Data_04F_5B50
    db $4F
    dw Data_04F_5C1D
    db $4F
    dw Data_04F_5CAF
    db $4F
    dw Data_04F_5D59
    db $4F
    dw Data_04F_5DF6
    db $4F
    dw Data_04F_5EAB
    db $4F
    dw Data_04F_5F61
    db $4F
    dw Data_04F_6019
    db $4F
    dw Data_04F_60CF
    db $4F
    dw Data_04F_6179
    db $4F
    dw Data_04F_6239
    db $4F
    dw Data_04F_62C0
    db $4F
    dw Data_04F_6362
    db $4F
    dw Data_04F_6417
    db $4F
    dw Data_04F_64B0
    db $4F
    dw Data_04F_64C4
    db $4F
    dw Data_04F_64D8
    db $4F
    dw Data_04F_6516
    db $4F
    dw Data_04F_652A
    db $4F
    dw Data_04F_653E
    db $4F
    dw Data_04F_6552
    db $4F
    dw Data_04F_6566
    db $4F
    dw Data_04F_657A
    db $4F
    dw Data_04F_658E
    db $4F
    dw Data_04F_65A2
    db $4F
    dw Data_04F_65B6
    db $4F
    dw Data_04F_65CA
    db $4F
    dw Data_04F_65DE
    db $4F
    dw Data_04F_65F2
    db $4F
    dw Data_04F_6606
    db $4F

Data_04F_59ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13D9ED, $C3

Data_04F_5AB0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DAB0, $A0

Data_04F_5B50:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DB50, $CD

Data_04F_5C1D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DC1D, $92

Data_04F_5CAF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DCAF, $AA

Data_04F_5D59:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DD59, $9D

Data_04F_5DF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DDF6, $B5

Data_04F_5EAB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DEAB, $B6

Data_04F_5F61:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13DF61, $B8

Data_04F_6019:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E019, $B6

Data_04F_60CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E0CF, $AA

Data_04F_6179:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E179, $C0

Data_04F_6239:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E239, $87

Data_04F_62C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E2C0, $A2

Data_04F_6362:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E362, $B5

Data_04F_6417:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E417, $99

Data_04F_64B0:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_64C4:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_64D8:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $03, $00, $01, $0D, $01, $00, $00, $0F, $09, $02, $02, $02
    db $02, $00, $20, $0F, $0F, $02, $02, $01, $01, $01, $01, $00, $30, $03, $00, $4F
    db $0F, $03, $01, $01, $00, $55, $03, $00, $7E, $02, $02, $02, $00, $76, $01, $01
    db $00, $7C, $0A, $00, $7E, $06, $00, $A7, $0F, $4D, $00, $07, $1F, $4D

Data_04F_6516:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_652A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_653E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_6552:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_6566:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_657A:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_658E:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_65A2:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_65B6:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_65CA:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_65DE:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_65F2:: ; heuristic: target of a monotone pointer table; C0
    db $68, $01, $00, $01, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_04F_6606:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13E606, $631
    dw Data_04F_6C4F
    db $4F
    dw Data_04F_6D37
    db $4F
    dw Data_04F_6E0F
    db $4F
    dw Data_04F_6F12
    db $4F
    dw Data_04F_700E
    db $4F
    dw Data_04F_706E
    db $4F
    dw Data_04F_70BC
    db $4F
    dw Data_04F_7114
    db $4F

Data_04F_6C4F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13EC4F, $E8

Data_04F_6D37:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13ED37, $D8

Data_04F_6E0F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13EE0F, $103

Data_04F_6F12:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13EF12, $FC

Data_04F_700E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13F00E, $60

Data_04F_706E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13F06E, $4E

Data_04F_70BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13F0BC, $58

Data_04F_7114:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $13F114, $DF6
    ds $F6, $00
