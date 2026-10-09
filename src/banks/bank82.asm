SECTION "Bank 82", ROMX[$4000], BANK[$82]
    db $82

; 3 call sites from 3 routines (e.g. Func_001_4AD4, Func_010_4AD0, Func_05F_69FB)
; reads: wC529
Func_082_4001::
    ld a, [wC529]
    cp a, $90
    jr c, Jump_082_400F
    farcall Func_096_4026
    ret

Jump_082_400F::
    ld de, Data_082_4032
    call Func_000_25C9
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC529
Func_082_4016:: ; heuristic: follows a terminator; C0
    ld a, [wC529]
    cp a, $90
    jr c, Jump_082_4024
    farcall Func_096_4026
    ret

Jump_082_4024::
    ld de, Data_082_4032
    call Func_000_25FE
    ret
    db $CD, $01, $40, $CD, $11, $26, $C9

Data_082_4032:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_082_4034

Data_082_4034:: ; heuristic: target of a monotone pointer table; C0
    dw Data_082_4154
    dw Data_082_420D
    dw Data_082_426B
    dw Data_082_4375
    dw Data_082_443E
    dw Data_082_44A8
    dw Data_082_4517
    dw Data_082_45A2
    dw Data_082_462C
    dw Data_082_46B6
    dw Data_082_4724
    dw Data_082_47B5
    dw Data_082_488C
    dw Data_082_4964
    dw Data_082_49F0
    dw Data_082_4A57
    dw Data_082_4AE2
    dw Data_082_4B52
    dw Data_082_4BE2
    dw Data_082_4C6A
    dw Data_082_4CD9
    dw Data_082_4D43
    dw Data_082_4D90
    dw Data_082_4E07
    dw Data_082_4E2D
    dw Data_082_4E7C
    dw Data_082_4F09
    dw Data_082_4F75
    dw Data_082_4FE1
    dw Data_082_5074
    dw Data_082_5111
    dw Data_082_5150
    dw Data_082_51E0
    dw Data_082_5234
    dw Data_082_52A2
    dw Data_082_52DD
    dw Data_082_5300
    dw Data_082_5323
    dw Data_082_5372
    dw Data_082_53DF
    dw Data_082_5477
    dw Data_082_554D
    dw Data_082_5600
    dw Data_082_56AC
    dw Data_082_571A
    dw Data_082_57AE
    dw Data_082_586E
    dw Data_082_58FC
    dw Data_082_5968
    dw Data_082_5A47
    dw Data_082_5AD9
    dw Data_082_5B23
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5B8E
    dw Data_082_5C1E
    dw Data_082_5CFB
    dw Data_082_5DD9
    dw Data_082_5E43
    dw Data_082_5EAD
    dw Data_082_5F30
    dw Data_082_5F9A
    dw Data_082_6056
    dw Data_082_616A
    dw Data_082_61DD
    dw Data_082_6295
    dw Data_082_6359
    dw Data_082_6379
    dw Data_082_63CD
    dw Data_082_64AB
    dw Data_082_64F6
    dw Data_082_659F
    dw Data_082_660E
    dw Data_082_662D
    dw Data_082_6678
    dw Data_082_676F
    dw Data_082_67E9
    dw Data_082_6828
    dw Data_082_6869
    dw Data_082_690F
    dw Data_082_698B
    dw Data_082_69AD
    dw Data_082_69F4
    dw Data_082_6A34
    dw Data_082_6B29
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6B4E
    dw Data_082_6C52
    dw Data_082_6C9D
    dw Data_082_6CF6
    dw Data_082_6D66
    dw Data_082_6DFB
    dw Data_082_6E68
    dw Data_082_6E89
    dw Data_082_6EA9
    dw Data_082_6F32
    dw Data_082_6F5A
    dw Data_082_6FA5
    dw Data_082_7018
    dw Data_082_7030
    dw Data_082_7050
    dw Data_082_70E5
    dw Data_082_719B
    dw Data_082_7226
    dw Data_082_728D
    dw Data_082_72D5
    dw Data_082_72D6
    dw Data_082_7385
    dw Data_082_73E8
    dw Data_082_749F
    dw Data_082_7574
    dw Data_082_75FD
    dw Data_082_763D
    dw Data_082_76C7
    dw Data_082_7788
    dw Data_082_779E
    dw Data_082_7836
    dw Data_082_792B
    dw Data_082_79D3
    dw Data_082_7A7C
    dw Data_082_7A92
    dw Data_082_7B41
    dw Data_082_7BF1
    dw Data_082_7C07
    dw Data_082_7CB3
    dw Data_082_7D60
    dw Data_082_7D76
    dw Data_082_7E05
    dw Data_082_7E98

Data_082_4154:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208154, $B9

Data_082_420D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20820D, $5E

Data_082_426B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20826B, $10A

Data_082_4375:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208375, $C9

Data_082_443E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20843E, $6A

Data_082_44A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2084A8, $6F

Data_082_4517:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208517, $8B

Data_082_45A2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2085A2, $8A

Data_082_462C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20862C, $8A

Data_082_46B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2086B6, $6E

Data_082_4724:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208724, $91

Data_082_47B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2087B5, $D7

Data_082_488C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20888C, $D8

Data_082_4964:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208964, $8C

Data_082_49F0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2089F0, $67

Data_082_4A57:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208A57, $8B

Data_082_4AE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208AE2, $70

Data_082_4B52:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208B52, $90

Data_082_4BE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208BE2, $88

Data_082_4C6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208C6A, $6F

Data_082_4CD9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208CD9, $6A

Data_082_4D43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208D43, $4D

Data_082_4D90:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208D90, $77

Data_082_4E07:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $28, $2F, $2F, $32, $99, $90, $11, $32, $3A, $90, $30, $24
    db $3C, $90, $12, $F1, $36, $28, $35, $39, $28, $90, $3C, $32, $38, $90, $37, $32
    db $27, $24, $3C, $98, $F7, $F0

Data_082_4E2D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208E2D, $4F

Data_082_4E7C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208E7C, $8D

Data_082_4F09:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208F09, $6C

Data_082_4F75:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208F75, $6C

Data_082_4FE1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $208FE1, $93

Data_082_5074:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209074, $9D

Data_082_5111:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $40, $28, $90, $10, $35, $28, $24, $37, $15, $32
    db $2A, $3E, $F1, $36, $24, $39, $2C, $32, $35, $99, $FA, $F7, $EF, $EE, $0D, $32
    db $90, $3C, $32, $38, $90, $31, $28, $28, $27, $90, $24, $31, $3C, $EF, $EE, $2E
    db $28, $3C, $36, $90, $24, $33, $33, $35, $24, $2C, $36, $28, $27, $98, $F0

Data_082_5150:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209150, $90

Data_082_51E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2091E0, $54

Data_082_5234:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209234, $6E

Data_082_52A2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $43, $2F, $90, $37, $24, $2E, $28, $90, $2C, $37
    db $98, $F1, $0E, $3B, $26, $28, $2F, $2F, $28, $31, $37, $99, $FA, $F7, $EF, $EE
    db $12, $43, $2F, $90, $36, $28, $31, $27, $90, $2C, $37, $90, $37, $32, $EF, $EE
    db $37, $2B, $28, $90, $29, $24, $35, $30, $B5, $F7, $F0

Data_082_52DD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $98, $90, $0B, $38, $37, $90, $37, $2B, $28, $35, $28
    db $3E, $F1, $31, $32, $90, $35, $32, $32, $30, $90, $29, $32, $35, $90, $2C, $37
    db $B5, $F7, $F0

Data_082_5300:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $2B, $A4, $90, $20, $28, $2F, $2F, $AB, $90, $37, $2B, $24
    db $37, $3E, $F1, $37, $32, $32, $90, $25, $24, $27, $AB, $90, $37, $2B, $28, $31
    db $B5, $F7, $F0

Data_082_5323:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209323, $4F

Data_082_5372:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209372, $6D

Data_082_53DF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2093DF, $98

Data_082_5477:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209477, $D6

Data_082_554D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20954D, $B3

Data_082_5600:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209600, $AC

Data_082_56AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2096AC, $6E

Data_082_571A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20971A, $94

Data_082_57AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2097AE, $C0

Data_082_586E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20986E, $8E

Data_082_58FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2098FC, $6C

Data_082_5968:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209968, $DF

Data_082_5A47:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209A47, $92

Data_082_5AD9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209AD9, $4A

Data_082_5B23:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209B23, $6B

Data_082_5B8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209B8E, $90

Data_082_5C1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209C1E, $DD

Data_082_5CFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209CFB, $DE

Data_082_5DD9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209DD9, $6A

Data_082_5E43:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209E43, $6A

Data_082_5EAD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209EAD, $83

Data_082_5F30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209F30, $6A

Data_082_5F9A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $209F9A, $BC

Data_082_6056:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A056, $114

Data_082_616A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A16A, $73

Data_082_61DD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A1DD, $B8

Data_082_6295:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A295, $C4

Data_082_6359:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $32, $25, $37, $24, $2C, $31, $28, $27, $90, $37, $2B, $28, $F1
    db $0B, $35, $24, $3A, $31, $90, $14, $28, $3C, $B5, $E5, $58, $F7, $E9, $FF, $F0

Data_082_6379:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A379, $54

Data_082_63CD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A3CD, $DE

Data_082_64AB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A4AB, $4B

Data_082_64F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A4F6, $A9

Data_082_659F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A59F, $6F

Data_082_660E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $10, $35, $28, $24, $37, $99, $90, $15, $28, $37, $3E, $F1, $2A
    db $2C, $39, $28, $90, $2C, $37, $90, $24, $90, $37, $35, $3C, $99, $F7, $F0

Data_082_662D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A62D, $4B

Data_082_6678:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A678, $F7

Data_082_676F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A76F, $7A

Data_082_67E9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $24, $3C, $90, $2A, $32, $32, $27, $90, $29, $32, $35, $37
    db $38, $31, $28, $F1, $24, $35, $35, $2C, $39, $28, $90, $34, $38, $2C, $26, $2E
    db $2F, $3C, $B5, $FA, $F7, $EF, $EE, $19, $2F, $28, $24, $36, $28, $AB, $90, $30
    db $24, $3C, $90, $3A, $28, $EF, $EE, $25, $28, $2A, $2C, $31, $98, $F7, $F0

Data_082_6828:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A828, $41

Data_082_6869:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A869, $A6

Data_082_690F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A90F, $7C

Data_082_698B:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $28, $2F, $2F, $AB, $90, $31, $32, $90, $37, $2C, $30, $28
    db $90, $37, $32, $F1, $2F, $32, $36, $28, $99, $90, $1A, $38, $2C, $26, $2E, $99
    db $F7, $F0

Data_082_69AD:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20A9AD, $47

Data_082_69F4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $19, $38, $37, $90, $24, $26, $26, $28, $36, $36, $32, $35, $2C
    db $28, $36, $F1, $32, $31, $90, $3C, $32, $38, $35, $90, $30, $32, $31, $36, $37
    db $28, $35, $36, $B5, $FA, $F7, $EF, $EE, $1D, $2B, $28, $3C, $90, $26, $24, $31
    db $90, $35, $28, $24, $2F, $2F, $3C, $EF, $EE, $2B, $28, $2F, $33, $99, $F7, $F0

Data_082_6A34:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AA34, $F5

Data_082_6B29:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $99, $90, $0A, $35, $28, $90
    db $3C, $32, $38, $F1, $2B, $28, $35, $28, $90, $37, $32, $90, $25, $24, $37, $37
    db $2F, $28, $98, $F7, $F0

Data_082_6B4E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AB4E, $104

Data_082_6C52:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AC52, $4B

Data_082_6C9D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AC9D, $59

Data_082_6CF6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20ACF6, $70

Data_082_6D66:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AD66, $95

Data_082_6DFB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20ADFB, $6D

Data_082_6E68:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $14, $99, $90, $15, $28, $37, $90, $37, $2B, $28, $F1, $25
    db $35, $28, $28, $27, $2C, $31, $2A, $90, $2B, $24, $33, $33, $28, $31, $99, $F7
    db $F0

Data_082_6E89:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $17, $32, $98, $90, $20, $28, $2F, $2F, $AB, $90, $2C, $29, $90
    db $3A, $28, $F1, $30, $28, $28, $37, $90, $24, $2A, $24, $2C, $31, $A4, $F7, $F0

Data_082_6EA9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AEA9, $89

Data_082_6F32:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $16, $3C, $90, $29, $35, $2C, $2A, $2C, $27, $90, $25, $35, $28
    db $24, $37, $2B, $F1, $26, $2B, $2C, $2F, $2F, $36, $90, $28, $39, $28, $31, $90
    db $36, $32, $38, $2F, $36, $B5, $F7, $F0

Data_082_6F5A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AF5A, $4B

Data_082_6FA5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20AFA5, $73

Data_082_7018:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $10, $35, $28, $24, $37, $99, $F1, $10, $32, $32, $27, $90, $24
    db $31, $36, $3A, $28, $35, $99, $F7, $F0

Data_082_7030:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $3E, $90, $37, $32, $32, $90, $25, $24, $27
    db $B5, $F1, $12, $37, $3E, $90, $24, $90, $3A, $24, $36, $37, $28, $A4, $F7, $F0

Data_082_7050:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B050, $95

Data_082_70E5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B0E5, $B6

Data_082_719B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B19B, $8B

Data_082_7226:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B226, $67

Data_082_728D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B28D, $48

Data_082_72D5:: ; heuristic: target of a monotone pointer table; C0
    db $EB

Data_082_72D6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B2D6, $AF

Data_082_7385:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B385, $63

Data_082_73E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B3E8, $B7

Data_082_749F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B49F, $D5

Data_082_7574:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B574, $89

Data_082_75FD:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $14, $2C, $31, $2A, $A3, $90, $22, $32, $38, $90, $35, $28, $29, $38, $36
    db $28, $F1, $30, $3C, $90, $35, $28, $34, $38, $28, $36, $37, $98, $FA, $F7, $EF
    db $EE, $0A, $29, $37, $28, $35, $90, $24, $2F, $2F, $90, $3A, $28, $42, $28, $EF
    db $EE, $25, $28, $28, $31, $90, $37, $2B, $35, $32, $38, $2A, $2B, $98, $F7, $F0

Data_082_763D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B63D, $8A

Data_082_76C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B6C7, $C1

Data_082_7788:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $01, $00, $AB, $00
    db $00, $00, $10, $B5, $F7, $F0

Data_082_779E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B79E, $98

Data_082_7836:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B836, $F5

Data_082_792B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B92B, $A8

Data_082_79D3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20B9D3, $A9

Data_082_7A7C:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $02, $00, $AB, $00
    db $00, $00, $10, $B5, $F7, $F0

Data_082_7A92:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20BA92, $AF

Data_082_7B41:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20BB41, $B0

Data_082_7BF1:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $03, $00, $AB, $00
    db $00, $00, $10, $B5, $F7, $F0

Data_082_7C07:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20BC07, $AC

Data_082_7CB3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20BCB3, $AD

Data_082_7D60:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $35, $28, $26, $28, $2C, $39, $28, $27, $F1, $04, $00, $AB, $00
    db $00, $00, $10, $B5, $F7, $F0

Data_082_7D76:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20BD76, $8F

Data_082_7E05:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20BE05, $93

Data_082_7E98:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20BE98, $81
    ds $E7, $00
