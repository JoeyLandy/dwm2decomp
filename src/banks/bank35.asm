SECTION "Bank 35", ROMX[$4000], BANK[$35]
    db $35

; copies the whole 47-byte species record of monster id wSpeciesIdLo/Hi to wSpeciesRecord; byte 0 is the family (E-0069)
; 37 call sites from 36 routines (e.g. DebugResultsDisplay_Update_Sub02_Sub01_Sub01, CreateMonsterRecordOfKindTemp1_Sub01_Sub01, WithSRAMDraw4ACEAnd4BE8_Sub01, ShowRecordSpeciesAndSkillNames, ...)
; points at: wSpeciesRecord
LoadSpeciesRecord::
Func_035_4001:: ; address name
    ld de, wSpeciesRecord
    ld b, $2F
    call CopySpeciesRecordPrefix
    ret

; copies byte 0 of the species record of monster id wSpeciesIdLo/Hi, the family (0 Slime ... 9 Water, 10 Boss; $FF for an unused id), to wSpeciesRecord (E-0069)
; 8 call sites from 7 routines (e.g. GetSlotSpeciesFamily, CountSpeciesPerFamilyFlaggedOrListed, BattleEnd_Step3_Sub01_Sub01, FamilyNibbleOrSpeciesFamily, ...)
; points at: wSpeciesRecord
LoadSpeciesFamily::
Func_035_400A:: ; address name
    ld de, wSpeciesRecord
    ld b, $01
    call CopySpeciesRecordPrefix
    ret

; copies bytes 0-1 of the species record of monster id wSpeciesIdLo/Hi (the family and byte 1) to wSpeciesRecord (E-0069)
; 1 call site from 1 routine (e.g. RollWCADEFromSpeciesFlag)
; points at: wSpeciesRecord
LoadSpeciesRecordWord0::
Func_035_4013:: ; address name
    ld de, wSpeciesRecord
    ld b, $02
    call CopySpeciesRecordPrefix
    ret

; B = byte count, DE = destination: copies the first B bytes of the species record for monster id wSpeciesIdLo/Hi (pointer table SpeciesRecordPointers, 384 entries, 47-byte records) to DE (E-0062, E-0069)
; 3 call sites from 3 routines (e.g. LoadSpeciesFamily, LoadSpeciesRecord, LoadSpeciesRecordWord0)
; reads: wSpeciesIdLo, wSpeciesIdHi
CopySpeciesRecordPrefix::
Func_035_401C:: ; address name
    push bc
    push de
    ld a, [wSpeciesIdLo]
    ld c, a
    ld a, [wSpeciesIdHi]
    ld b, a
    sla c
    rl b
    ld hl, SpeciesRecordPointers
    add hl, bc
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    pop bc

Jump_035_4034::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_035_4034
    ret

; 384 pointers indexed by monster id (the numbering of StringTable_MonsterNames and StringTable_MonsterNames2) to 47-byte species records; byte 0 is the family index of StringTable_MonsterFamilies, $FF for an unused id (E-0069)
; address loaded by CopySpeciesRecordPrefix
SpeciesRecordPointers:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_035_403B:: ; address name
    dw Data_035_433B
    dw Data_035_436A
    dw Data_035_4399
    dw Data_035_43C8
    dw Data_035_43F7
    dw Data_035_4426
    dw Data_035_4455
    dw Data_035_4484
    dw Data_035_44B3
    dw Data_035_44E2
    dw Data_035_4511
    dw Data_035_4540
    dw Data_035_456F
    dw Data_035_459E
    dw Data_035_45CD
    dw Data_035_45FC
    dw Data_035_462B
    dw Data_035_465A
    dw Data_035_4689
    dw Data_035_46B8
    dw Data_035_46E7
    dw Data_035_4716
    dw Data_035_4745
    dw Data_035_4774
    dw Data_035_47A3
    dw Data_035_47D2
    dw Data_035_4801
    dw Data_035_4830
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_485F
    dw Data_035_488E
    dw Data_035_48BD
    dw Data_035_48EC
    dw Data_035_491B
    dw Data_035_494A
    dw Data_035_4979
    dw Data_035_49A8
    dw Data_035_49D7
    dw Data_035_4A06
    dw Data_035_4A35
    dw Data_035_4A64
    dw Data_035_4A93
    dw Data_035_4AC2
    dw Data_035_4AF1
    dw Data_035_4B20
    dw Data_035_4B4F
    dw Data_035_4B7E
    dw Data_035_4BAD
    dw Data_035_4BDC
    dw Data_035_4C0B
    dw Data_035_4C3A
    dw Data_035_4C69
    dw Data_035_4C98
    dw Data_035_4CC7
    dw Data_035_4CF6
    dw Data_035_4D25
    dw Data_035_4D54
    dw Data_035_4D83
    dw Data_035_4DB2
    dw Data_035_4DE1
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_4E10
    dw Data_035_4E3F
    dw Data_035_4E6E
    dw Data_035_4E9D
    dw Data_035_4ECC
    dw Data_035_4EFB
    dw Data_035_4F2A
    dw Data_035_4F59
    dw Data_035_4F88
    dw Data_035_4FB7
    dw Data_035_4FE6
    dw Data_035_5015
    dw Data_035_5044
    dw Data_035_5073
    dw Data_035_50A2
    dw Data_035_50D1
    dw Data_035_5100
    dw Data_035_512F
    dw Data_035_515E
    dw Data_035_518D
    dw Data_035_51BC
    dw Data_035_51EB
    dw Data_035_521A
    dw Data_035_5249
    dw Data_035_5278
    dw Data_035_52A7
    dw Data_035_52D6
    dw Data_035_5305
    dw Data_035_5334
    dw Data_035_5363
    dw Data_035_5392
    dw Data_035_53C1
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_53F0
    dw Data_035_541F
    dw Data_035_544E
    dw Data_035_547D
    dw Data_035_54AC
    dw Data_035_54DB
    dw Data_035_550A
    dw Data_035_5539
    dw Data_035_5568
    dw Data_035_5597
    dw Data_035_55C6
    dw Data_035_55F5
    dw Data_035_5624
    dw Data_035_5653
    dw Data_035_5682
    dw Data_035_56B1
    dw Data_035_56E0
    dw Data_035_570F
    dw Data_035_573E
    dw Data_035_576D
    dw Data_035_579C
    dw Data_035_57CB
    dw Data_035_57FA
    dw Data_035_5829
    dw Data_035_5858
    dw Data_035_5887
    dw Data_035_58B6
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_58E5
    dw Data_035_5914
    dw Data_035_5943
    dw Data_035_5972
    dw Data_035_59A1
    dw Data_035_59D0
    dw Data_035_59FF
    dw Data_035_5A2E
    dw Data_035_5A5D
    dw Data_035_5A8C
    dw Data_035_5ABB
    dw Data_035_5AEA
    dw Data_035_5B19
    dw Data_035_5B48
    dw Data_035_5B77
    dw Data_035_5BA6
    dw Data_035_5BD5
    dw Data_035_5C04
    dw Data_035_5C33
    dw Data_035_5C62
    dw Data_035_5C91
    dw Data_035_5CC0
    dw Data_035_5CEF
    dw Data_035_5D1E
    dw Data_035_5D4D
    dw Data_035_5D7C
    dw Data_035_5DAB
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_5DDA
    dw Data_035_5E09
    dw Data_035_5E38
    dw Data_035_5E67
    dw Data_035_5E96
    dw Data_035_5EC5
    dw Data_035_5EF4
    dw Data_035_5F23
    dw Data_035_5F52
    dw Data_035_5F81
    dw Data_035_5FB0
    dw Data_035_5FDF
    dw Data_035_600E
    dw Data_035_603D
    dw Data_035_606C
    dw Data_035_609B
    dw Data_035_60CA
    dw Data_035_60F9
    dw Data_035_6128
    dw Data_035_6157
    dw Data_035_6186
    dw Data_035_61B5
    dw Data_035_61E4
    dw Data_035_6213
    dw Data_035_6242
    dw Data_035_6271
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_62A0
    dw Data_035_62CF
    dw Data_035_62FE
    dw Data_035_632D
    dw Data_035_635C
    dw Data_035_638B
    dw Data_035_63BA
    dw Data_035_63E9
    dw Data_035_6418
    dw Data_035_6447
    dw Data_035_6476
    dw Data_035_64A5
    dw Data_035_64D4
    dw Data_035_6503
    dw Data_035_6532
    dw Data_035_6561
    dw Data_035_6590
    dw Data_035_65BF
    dw Data_035_65EE
    dw Data_035_661D
    dw Data_035_664C
    dw Data_035_667B
    dw Data_035_66AA
    dw Data_035_66D9
    dw Data_035_6708
    dw Data_035_6737
    dw Data_035_6766
    dw Data_035_6795
    dw Data_035_67C4
    dw Data_035_67F3
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_6822
    dw Data_035_6851
    dw Data_035_6880
    dw Data_035_68AF
    dw Data_035_68DE
    dw Data_035_690D
    dw Data_035_693C
    dw Data_035_696B
    dw Data_035_699A
    dw Data_035_69C9
    dw Data_035_69F8
    dw Data_035_6A27
    dw Data_035_6A56
    dw Data_035_6A85
    dw Data_035_6AB4
    dw Data_035_6AE3
    dw Data_035_6B12
    dw Data_035_6B41
    dw Data_035_6B70
    dw Data_035_6B9F
    dw Data_035_6BCE
    dw Data_035_6BFD
    dw Data_035_6C2C
    dw Data_035_6C5B
    dw Data_035_6C8A
    dw Data_035_6CB9
    dw Data_035_6CE8
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_6D17
    dw Data_035_6D46
    dw Data_035_6D75
    dw Data_035_6DA4
    dw Data_035_6DD3
    dw Data_035_6E02
    dw Data_035_6E31
    dw Data_035_6E60
    dw Data_035_6E8F
    dw Data_035_6EBE
    dw Data_035_6EED
    dw Data_035_6F1C
    dw Data_035_6F4B
    dw Data_035_6F7A
    dw Data_035_6FA9
    dw Data_035_6FD8
    dw Data_035_7007
    dw Data_035_7036
    dw Data_035_7065
    dw Data_035_7094
    dw Data_035_70C3
    dw Data_035_70F2
    dw Data_035_7121
    dw Data_035_7150
    dw Data_035_717F
    dw Data_035_71AE
    dw Data_035_71DD
    dw Data_035_720C
    dw Data_035_723B
    dw Data_035_726A
    dw Data_035_7299
    dw Data_035_72C8
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_72F7
    dw Data_035_7326
    dw Data_035_7355
    dw Data_035_7384
    dw Data_035_73B3
    dw Data_035_73E2
    dw Data_035_7411
    dw Data_035_7440
    dw Data_035_746F
    dw Data_035_749E
    dw Data_035_74CD
    dw Data_035_74FC
    dw Data_035_752B
    dw Data_035_755A
    dw Data_035_7589
    dw Data_035_75B8
    dw Data_035_75E7
    dw Data_035_7616
    dw Data_035_7645
    dw Data_035_7674
    dw Data_035_76A3
    dw Data_035_76D2
    dw Data_035_7701
    dw Data_035_7730
    dw Data_035_775F
    dw Data_035_778E
    dw Data_035_77BD
    dw Data_035_77EC
    dw Data_035_781B
    dw Data_035_784A
    dw Data_035_7879
    dw Data_035_78A8
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_433B
    dw Data_035_78D7
    dw Data_035_7906
    dw Data_035_7935
    dw Data_035_7964
    dw Data_035_7993
    dw Data_035_79C2
    dw Data_035_79F1
    dw Data_035_7A20
    dw Data_035_7A4F
    dw Data_035_7A7E
    dw Data_035_7AAD
    dw Data_035_7ADC
    dw Data_035_7B0B
    dw Data_035_7B3A
    dw Data_035_7B69
    dw Data_035_7B98
    dw Data_035_7BC7
    dw Data_035_7BF6
    dw Data_035_7C25
    dw Data_035_7C54
    dw Data_035_7C83
    dw Data_035_7CB2
    dw Data_035_7CE1
    dw Data_035_7D10
    dw Data_035_7D3F
    dw Data_035_7D6E
    dw Data_035_7D9D
    dw Data_035_7DCC
    dw Data_035_7DFB
    dw Data_035_7E2A
    dw Data_035_7E59
    dw Data_035_7E88
    db $3B, $43

Data_035_433B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF
    ds $24, $00

Data_035_436A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $04, $00, $2D, $0D, $3B, $40, $89, $00, $10, $0A, $0D, $08
    db $14, $10, $01, $01, $01, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02
    db $03, $02, $02, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $4F, $00

Data_035_4399:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $03, $00, $23, $0A, $4E, $8B, $9E, $00, $11, $01, $11, $04
    db $11, $08, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $03, $03
    db $02, $02, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $41, $00

Data_035_43C8:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $01, $00, $04, $01, $23, $0A, $48, $62, $99, $00, $0D, $02, $0B, $0B
    db $18, $08, $00, $00, $00, $01, $01, $00, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $44, $00

Data_035_43F7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $04, $00, $32, $0B, $27, $60, $71, $00, $0D, $0B, $08, $0E
    db $11, $11, $00, $00, $00, $01, $01, $00, $02, $02, $02, $03, $03, $02, $02, $02
    db $02, $02, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $02, $4B, $00

Data_035_4426:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $03, $00, $23, $08, $10, $23, $4E, $00, $0B, $0A, $11, $14
    db $14, $08, $00, $00, $00, $00, $00, $00, $02, $03, $02, $02, $03, $02, $02, $02
    db $02, $02, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $02, $4E, $00

Data_035_4455:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $04, $00, $28, $0F, $16, $25, $56, $00, $0E, $01, $0F, $0E
    db $14, $0E, $01, $01, $01, $01, $01, $01, $02, $02, $03, $02, $02, $02, $02, $02
    db $03, $02, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $4E, $00

Data_035_4484:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $04, $00, $2D, $0C, $2E, $5F, $80, $00, $11, $07, $11, $08
    db $0E, $0D, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $03, $02, $02
    db $02, $02, $00, $00, $03, $01, $01, $00, $00, $00, $00, $00, $01, $4A, $00

Data_035_44B3:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $03, $00, $32, $0B, $01, $25, $6F, $00, $0B, $0A, $0E, $13
    db $0E, $0D, $00, $00, $01, $00, $00, $01, $02, $02, $03, $02, $02, $02, $02, $02
    db $03, $02, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $48, $00

Data_035_44E2:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $04, $00, $28, $0A, $25, $68, $7F, $01, $0A, $10, $08, $16
    db $0E, $09, $00, $00, $00, $00, $00, $01, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $02, $46, $00

Data_035_4511:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $01, $00, $28, $10, $04, $3D, $7F, $00, $16, $0B, $0E, $11
    db $0B, $0D, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $46, $00

Data_035_4540:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $03, $00, $32, $0B, $16, $19, $25, $00, $0B, $0F, $0B, $0B
    db $14, $12, $00, $00, $00, $01, $01, $00, $02, $02, $02, $03, $03, $02, $02, $02
    db $02, $02, $00, $00, $00, $00, $00, $01, $02, $02, $00, $00, $00, $4E, $00

Data_035_456F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $05, $00, $23, $0A, $4E, $68, $90, $00, $19, $01, $12, $0D
    db $14, $0D, $00, $00, $00, $00, $00, $00, $02, $02, $03, $02, $02, $02, $03, $03
    db $03, $02, $00, $00, $00, $01, $00, $01, $01, $01, $01, $01, $00, $54, $00

Data_035_459E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $05, $00, $2D, $0B, $6A, $6F, $94, $03, $0D, $0A, $0E, $17
    db $10, $0E, $00, $00, $01, $00, $00, $02, $02, $02, $03, $02, $02, $02, $02, $02
    db $03, $02, $00, $02, $00, $00, $01, $00, $00, $00, $00, $00, $00, $51, $00

Data_035_45CD:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $05, $00, $32, $0B, $4A, $65, $96, $00, $12, $0B, $14, $0F
    db $0E, $0D, $01, $01, $00, $01, $02, $01, $02, $02, $03, $02, $02, $03, $02, $02
    db $03, $02, $01, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $57, $00

Data_035_45FC:: ; heuristic: target of a monotone pointer table; C0
    db $00, $03, $00, $00, $04, $00, $23, $0A, $7D, $8D, $A2, $00, $0F, $07, $0E, $08
    db $15, $0F, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $03, $03
    db $02, $02, $00, $00, $00, $00, $00, $02, $01, $01, $02, $01, $01, $4C, $00

Data_035_462B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $06, $00, $2D, $0C, $1B, $38, $1E, $00, $12, $0E, $0F, $0E
    db $14, $0F, $01, $01, $01, $01, $01, $01, $03, $02, $03, $02, $02, $03, $03, $03
    db $03, $02, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $67, $00

Data_035_465A:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $01, $06, $00, $14, $19, $01, $10, $13, $00, $00, $1E, $0B, $1E
    db $1F, $0D, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $03, $03, $03, $03, $03, $00, $00, $00, $03, $00, $03, $C8, $00

Data_035_4689:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $01, $06, $00, $23, $1B, $04, $07, $15, $00, $00, $1E, $0E, $1F
    db $1F, $0F, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $02, $03, $03, $03, $03, $03, $00, $00, $00, $03, $00, $03, $BC, $02

Data_035_46B8:: ; heuristic: target of a monotone pointer table; C0
    db $00, $03, $00, $00, $06, $00, $2D, $09, $5C, $61, $93, $00, $12, $0B, $12, $0B
    db $14, $0F, $01, $01, $01, $00, $00, $01, $03, $02, $03, $02, $02, $03, $03, $03
    db $03, $02, $01, $01, $00, $01, $00, $02, $02, $02, $02, $02, $01, $67, $00

Data_035_46E7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $05, $00, $28, $0E, $1B, $71, $8B, $00, $0F, $14, $13, $09
    db $0E, $0F, $01, $01, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $01, $02, $00, $00, $00, $00, $00, $00, $00, $00, $01, $4E, $00

Data_035_4716:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $04, $00, $28, $11, $34, $8F, $A1, $00, $0A, $0C, $08, $13
    db $14, $11, $01, $01, $01, $01, $00, $01, $01, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $01, $55, $00

Data_035_4745:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $01, $00, $05, $01, $23, $10, $2F, $9C, $A0, $02, $09, $14, $0B, $0D
    db $0C, $16, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $00, $00, $00, $00, $02, $02, $02, $02, $01, $00, $00, $52, $00

Data_035_4774:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $01, $06, $00, $37, $1D, $0D, $35, $3F, $00, $00, $1F, $0F, $1F
    db $1F, $12, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $02, $03, $03, $03, $03, $03, $00, $00, $00, $03, $01, $03, $84, $03

Data_035_47A3:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $06, $00, $46, $1F, $3C, $3E, $81, $03, $00, $1F, $13, $1F
    db $1F, $12, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $02, $03, $03, $03, $03, $03, $01, $01, $01, $03, $02, $03, $9C, $00

Data_035_47D2:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $06, $00, $50, $1E, $20, $8A, $A6, $02, $19, $1D, $1B, $1F
    db $06, $1F, $03, $03, $03, $03, $03, $03, $01, $01, $03, $03, $03, $03, $03, $03
    db $03, $02, $03, $03, $03, $02, $03, $02, $02, $02, $02, $03, $02, $A7, $00

Data_035_4801:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $00, $00, $01, $00, $28, $04, $15, $35, $3C, $00, $08, $0D, $0B, $13
    db $0B, $14, $01, $01, $01, $02, $01, $02, $01, $02, $03, $01, $00, $03, $00, $00
    db $00, $00, $02, $01, $02, $02, $02, $02, $02, $02, $01, $01, $03, $4D, $00

Data_035_4830:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $07, $00, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $01, $01, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $03, $03
    db $02, $02, $02, $02, $00, $00, $00, $01, $01, $01, $01, $01, $02, $00, $00

Data_035_485F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $04, $00, $1E, $07, $40, $71, $95, $00, $0A, $03, $11, $02
    db $05, $05, $01, $02, $02, $00, $00, $02, $01, $01, $01, $01, $01, $01, $01, $01
    db $03, $01, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $30, $00

Data_035_488E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $04, $00, $23, $11, $35, $36, $4A, $03, $0F, $0B, $12, $06
    db $07, $0D, $02, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $02, $00, $02, $01, $00, $00, $00, $01, $01, $01, $01, $01, $01, $3F, $00

Data_035_48BD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $01, $00, $03, $01, $23, $10, $04, $48, $99, $02, $0E, $0B, $12, $02
    db $14, $04, $02, $02, $02, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $02, $00, $02, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $3A, $00

Data_035_48EC:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $01, $00, $04, $01, $32, $12, $15, $20, $6E, $02, $11, $0F, $0D, $0B
    db $07, $12, $02, $02, $02, $01, $01, $00, $00, $00, $00, $01, $01, $00, $00, $00
    db $02, $00, $02, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $43, $00

Data_035_491B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $03, $01, $00, $03, $01, $1E, $0F, $2E, $71, $8B, $00, $09, $0D, $11, $10
    db $0E, $04, $02, $02, $02, $00, $00, $00, $00, $01, $00, $00, $00, $01, $00, $00
    db $02, $00, $02, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $3C, $00

Data_035_494A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $04, $00, $2D, $14, $5D, $67, $6B, $05, $11, $0A, $13, $0D
    db $05, $10, $00, $02, $02, $01, $01, $01, $01, $00, $02, $00, $00, $01, $00, $00
    db $03, $00, $02, $00, $00, $01, $02, $00, $00, $00, $00, $00, $00, $43, $00

Data_035_4979:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $03, $00, $2D, $13, $5F, $73, $8B, $00, $15, $10, $0F, $0D
    db $07, $01, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $01, $00, $00
    db $02, $00, $02, $00, $02, $01, $01, $00, $00, $00, $00, $00, $01, $3E, $00

Data_035_49A8:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $04, $00, $32, $14, $5C, $65, $96, $05, $09, $03, $17, $06
    db $01, $05, $01, $01, $01, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00
    db $03, $00, $02, $01, $01, $00, $01, $01, $00, $00, $00, $00, $01, $31, $00

Data_035_49D7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $04, $00, $23, $10, $27, $6F, $90, $00, $0B, $02, $13, $0D
    db $07, $05, $02, $02, $02, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00
    db $03, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $33, $00

Data_035_4A06:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $03, $00, $28, $14, $40, $50, $9D, $00, $11, $01, $14, $10
    db $07, $04, $02, $02, $02, $00, $00, $00, $00, $02, $00, $00, $00, $01, $00, $00
    db $02, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $38, $00

Data_035_4A35:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $03, $00, $23, $10, $4E, $6F, $7E, $00, $0E, $08, $11, $0E
    db $12, $0A, $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00, $01, $00, $00
    db $02, $00, $02, $00, $00, $01, $02, $02, $01, $02, $01, $01, $01, $43, $00

Data_035_4A64:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $05, $00, $23, $13, $6B, $6C, $7A, $00, $13, $00, $15, $05
    db $08, $00, $01, $01, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01
    db $02, $00, $02, $00, $00, $00, $01, $02, $02, $01, $02, $02, $01, $3E, $00

Data_035_4A93:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $01, $00, $04, $01, $23, $11, $51, $5A, $5F, $02, $0E, $02, $11, $10
    db $0F, $05, $02, $02, $02, $02, $02, $00, $00, $02, $00, $00, $00, $01, $00, $00
    db $02, $00, $02, $01, $00, $00, $00, $00, $02, $01, $02, $01, $01, $45, $00

Data_035_4AC2:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $04, $00, $28, $13, $34, $60, $72, $00, $11, $12, $0B, $06
    db $08, $0D, $01, $02, $02, $00, $00, $00, $00, $00, $02, $01, $00, $03, $00, $00
    db $03, $00, $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $3D, $00

Data_035_4AF1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $01, $00, $03, $01, $1E, $10, $04, $27, $40, $00, $0B, $0B, $11, $11
    db $0D, $05, $01, $02, $02, $00, $00, $00, $00, $01, $00, $00, $00, $01, $00, $00
    db $02, $00, $03, $00, $01, $01, $01, $00, $00, $00, $01, $01, $00, $3C, $00

Data_035_4B20:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $05, $00, $32, $16, $0A, $2E, $73, $05, $15, $0F, $13, $11
    db $13, $0C, $02, $02, $02, $00, $00, $00, $00, $02, $02, $02, $00, $02, $00, $00
    db $02, $00, $02, $02, $00, $00, $00, $01, $01, $01, $00, $00, $01, $55, $00

Data_035_4B4F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $03, $00, $28, $14, $5F, $75, $79, $00, $12, $08, $10, $0D
    db $13, $0B, $01, $02, $02, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01, $01
    db $03, $01, $02, $00, $02, $00, $02, $00, $00, $00, $00, $00, $01, $49, $00

Data_035_4B7E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $01, $00, $03, $01, $23, $08, $0A, $4E, $63, $02, $0E, $07, $0A, $08
    db $13, $08, $01, $02, $02, $01, $00, $00, $01, $01, $01, $00, $00, $00, $00, $01
    db $02, $00, $02, $00, $01, $00, $01, $01, $00, $00, $00, $00, $00, $37, $00

Data_035_4BAD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $01, $00, $03, $01, $23, $07, $4B, $8B, $A7, $02, $0A, $09, $15, $0F
    db $09, $08, $02, $02, $02, $01, $01, $00, $00, $02, $00, $00, $01, $00, $00, $00
    db $02, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $38, $00

Data_035_4BDC:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $04, $00, $23, $13, $4B, $6E, $70, $03, $14, $08, $13, $18
    db $01, $02, $02, $02, $02, $00, $00, $00, $00, $01, $01, $00, $00, $01, $00, $00
    db $03, $00, $02, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $45, $00

Data_035_4C0B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $06, $00, $3C, $17, $44, $53, $9D, $02, $15, $05, $17, $0E
    db $10, $0B, $02, $03, $02, $01, $01, $01, $01, $02, $03, $01, $01, $02, $01, $01
    db $03, $00, $03, $01, $01, $03, $01, $01, $01, $01, $01, $01, $01, $64, $00

Data_035_4C3A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $01, $00, $23, $12, $33, $3B, $5F, $00, $0E, $04, $0F, $05
    db $13, $08, $02, $02, $02, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $02, $00, $02, $00, $00, $00, $00, $02, $02, $01, $01, $01, $01, $3B, $00

Data_035_4C69:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $03, $00, $2D, $14, $62, $6A, $73, $00, $0F, $08, $14, $11
    db $0E, $0B, $03, $03, $02, $01, $01, $00, $00, $00, $02, $00, $01, $00, $00, $00
    db $03, $00, $03, $00, $00, $00, $00, $02, $02, $01, $01, $01, $00, $4E, $00

Data_035_4C98:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $05, $00, $3C, $17, $07, $52, $6B, $00, $19, $0E, $14, $16
    db $12, $0E, $02, $02, $02, $01, $01, $01, $01, $02, $02, $01, $01, $01, $01, $01
    db $03, $01, $03, $01, $01, $01, $01, $02, $02, $01, $01, $01, $02, $6C, $00

Data_035_4CC7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $00, $00, $06, $00, $3C, $16, $40, $50, $63, $00, $18, $0D, $18, $15
    db $0B, $08, $02, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01, $03, $01, $01
    db $03, $00, $03, $01, $02, $02, $02, $01, $01, $01, $01, $01, $02, $6C, $00

Data_035_4CF6:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $05, $00, $3C, $16, $40, $5E, $6B, $05, $17, $10, $1A, $14
    db $11, $10, $02, $02, $02, $02, $02, $01, $01, $02, $02, $01, $01, $01, $01, $01
    db $03, $00, $03, $01, $01, $02, $01, $01, $01, $01, $01, $01, $01, $6D, $00

Data_035_4D25:: ; heuristic: target of a monotone pointer table; C0
    db $01, $03, $01, $00, $06, $01, $28, $12, $40, $66, $89, $02, $0F, $0B, $14, $0E
    db $12, $08, $00, $00, $00, $02, $02, $01, $01, $02, $02, $01, $01, $01, $01, $01
    db $03, $00, $03, $01, $01, $02, $01, $02, $02, $02, $02, $02, $01, $61, $00

Data_035_4D54:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $05, $00, $37, $18, $54, $5A, $65, $00, $17, $07, $18, $15
    db $12, $08, $02, $02, $02, $01, $01, $00, $02, $02, $02, $01, $01, $02, $01, $01
    db $03, $00, $02, $00, $01, $01, $01, $01, $01, $01, $02, $02, $02, $67, $00

Data_035_4D83:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $01, $00, $06, $01, $46, $1C, $3E, $44, $9F, $02, $1A, $19, $1C, $18
    db $14, $17, $02, $03, $03, $02, $02, $02, $02, $02, $03, $02, $02, $03, $02, $02
    db $03, $01, $03, $02, $02, $03, $02, $02, $02, $02, $02, $02, $01, $96, $00

Data_035_4DB2:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $00, $00, $06, $00, $4B, $1D, $2D, $6E, $94, $03, $19, $18, $1C, $19
    db $15, $18, $03, $03, $03, $02, $02, $01, $02, $02, $03, $02, $02, $03, $02, $02
    db $03, $00, $03, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $99, $00

Data_035_4DE1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $00, $00, $06, $01, $46, $18, $40, $4B, $6C, $03, $1E, $18, $1D, $0C
    db $06, $0B, $00, $00, $00, $00, $00, $00, $02, $02, $01, $01, $01, $01, $01, $01
    db $03, $01, $02, $00, $03, $02, $02, $01, $01, $02, $02, $02, $01, $7A, $00

Data_035_4E10:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $28, $0C, $61, $71, $8B, $00, $0E, $05, $0F, $0C
    db $0B, $10, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $03, $03
    db $01, $01, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $01, $44, $00

Data_035_4E3F:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $00, $00, $03, $00, $2D, $0D, $2F, $68, $6E, $00, $12, $05, $0E, $09
    db $0F, $04, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $02
    db $01, $00, $01, $00, $00, $00, $00, $02, $02, $02, $02, $02, $01, $3B, $00

Data_035_4E6E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $01, $00, $04, $01, $23, $0A, $2B, $33, $76, $00, $0B, $0A, $0D, $08
    db $12, $0E, $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00, $01, $02, $02
    db $00, $00, $00, $00, $00, $01, $01, $03, $03, $03, $03, $03, $00, $40, $00

Data_035_4E9D:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $23, $0B, $2B, $6F, $7D, $00, $0E, $11, $08, $08
    db $13, $0D, $00, $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $00, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $01, $44, $00

Data_035_4ECC:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $03, $00, $28, $09, $25, $69, $72, $00, $10, $05, $09, $11
    db $00, $0D, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $01, $02, $02
    db $00, $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $01, $3A, $00

Data_035_4EFB:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $2D, $0D, $6C, $6F, $90, $00, $18, $01, $1A, $0D
    db $07, $01, $01, $01, $01, $01, $01, $01, $00, $00, $01, $00, $00, $00, $02, $02
    db $01, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $01, $47, $00

Data_035_4F2A:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $2D, $0C, $68, $78, $A8, $00, $0E, $0A, $0B, $08
    db $10, $02, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $01, $02, $02
    db $01, $00, $00, $00, $01, $01, $01, $02, $02, $02, $02, $02, $01, $3C, $00

Data_035_4F59:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $32, $0C, $0A, $10, $51, $02, $0D, $14, $0D, $0F
    db $0F, $0D, $00, $00, $00, $02, $00, $01, $00, $00, $01, $00, $00, $00, $02, $02
    db $01, $00, $00, $01, $00, $00, $00, $02, $02, $02, $02, $02, $01, $48, $00

Data_035_4F88:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $03, $00, $28, $0E, $10, $68, $91, $00, $16, $08, $08, $15
    db $0A, $07, $00, $00, $00, $01, $00, $02, $00, $00, $00, $00, $00, $00, $02, $02
    db $01, $00, $00, $01, $00, $00, $00, $02, $02, $02, $02, $02, $02, $44, $00

Data_035_4FB7:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $02, $00, $28, $08, $5E, $62, $8B, $00, $0E, $07, $11, $0B
    db $09, $0B, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $01, $38, $00

Data_035_4FE6:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $2D, $09, $79, $7C, $9E, $00, $12, $07, $0D, $0C
    db $0B, $07, $00, $00, $00, $00, $00, $00, $01, $02, $01, $00, $00, $02, $02, $02
    db $00, $00, $00, $00, $01, $01, $01, $02, $02, $02, $02, $02, $01, $43, $00

Data_035_5015:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $2D, $0A, $39, $94, $97, $03, $12, $05, $11, $17
    db $02, $0B, $01, $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $02, $02
    db $01, $00, $02, $02, $00, $00, $00, $02, $02, $02, $02, $02, $01, $47, $00

Data_035_5044:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $03, $00, $23, $09, $7A, $93, $A8, $00, $0E, $0B, $10, $0E
    db $14, $08, $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00, $01, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $03, $03, $01, $48, $00

Data_035_5073:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $03, $00, $32, $0B, $68, $6B, $70, $03, $11, $13, $11, $0B
    db $11, $0A, $00, $00, $00, $01, $01, $00, $00, $00, $00, $02, $02, $00, $02, $02
    db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $01, $4F, $00

Data_035_50A2:: ; heuristic: target of a monotone pointer table; C0
    db $02, $01, $00, $00, $05, $00, $2D, $0E, $62, $63, $8D, $00, $14, $00, $1B, $07
    db $09, $01, $01, $01, $01, $01, $01, $01, $00, $00, $01, $00, $00, $00, $02, $02
    db $01, $00, $00, $00, $00, $00, $00, $03, $02, $02, $03, $02, $01, $42, $00

Data_035_50D1:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $05, $00, $28, $0D, $10, $53, $90, $00, $12, $0B, $0F, $09
    db $0A, $08, $01, $01, $01, $01, $01, $02, $00, $00, $01, $00, $00, $00, $02, $02
    db $01, $00, $00, $03, $00, $00, $00, $02, $02, $02, $02, $02, $01, $48, $00

Data_035_5100:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $01, $00, $04, $01, $28, $05, $01, $4E, $93, $00, $09, $07, $15, $13
    db $0D, $0E, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $02, $02
    db $00, $00, $00, $00, $00, $00, $01, $02, $02, $02, $02, $02, $00, $40, $00

Data_035_512F:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $01, $00, $04, $01, $28, $0D, $2E, $71, $84, $02, $16, $0D, $12, $0F
    db $14, $08, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $02, $02
    db $00, $00, $00, $00, $00, $00, $01, $02, $02, $02, $02, $02, $00, $4B, $00

Data_035_515E:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $05, $00, $28, $08, $2F, $65, $67, $05, $15, $04, $16, $0E
    db $08, $06, $00, $00, $00, $01, $00, $00, $00, $02, $01, $00, $00, $00, $02, $02
    db $01, $00, $00, $01, $00, $00, $00, $02, $02, $02, $02, $02, $00, $43, $00

Data_035_518D:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $03, $00, $28, $0C, $57, $5B, $A6, $00, $0E, $0D, $11, $09
    db $08, $0B, $01, $01, $00, $00, $00, $01, $00, $00, $02, $00, $00, $00, $02, $02
    db $02, $00, $01, $01, $00, $00, $00, $02, $02, $02, $02, $02, $01, $42, $00

Data_035_51BC:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $01, $00, $04, $01, $2D, $0B, $2B, $2E, $54, $00, $0C, $05, $0D, $0E
    db $11, $07, $01, $01, $01, $00, $00, $01, $00, $01, $00, $00, $00, $01, $02, $02
    db $01, $00, $01, $01, $00, $00, $00, $02, $02, $02, $02, $02, $01, $40, $00

Data_035_51EB:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $05, $00, $32, $0E, $16, $1E, $A7, $02, $13, $15, $0E, $0D
    db $0C, $19, $00, $00, $00, $00, $00, $00, $01, $02, $02, $01, $01, $02, $03, $03
    db $01, $01, $00, $02, $00, $01, $01, $03, $02, $02, $03, $02, $02, $63, $00

Data_035_521A:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $28, $0B, $04, $2B, $71, $00, $13, $09, $11, $0D
    db $11, $03, $00, $01, $01, $00, $00, $02, $01, $01, $01, $01, $01, $01, $03, $03
    db $01, $01, $01, $02, $00, $00, $00, $02, $02, $02, $02, $02, $01, $50, $00

Data_035_5249:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $05, $00, $23, $0D, $6D, $7D, $A7, $00, $0D, $01, $14, $0A
    db $08, $04, $00, $00, $00, $01, $01, $00, $00, $00, $01, $00, $00, $00, $02, $02
    db $01, $00, $00, $00, $00, $00, $00, $03, $03, $03, $03, $03, $01, $40, $00

Data_035_5278:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $05, $00, $32, $0E, $6E, $7E, $90, $03, $11, $08, $15, $11
    db $0E, $0D, $00, $01, $01, $01, $01, $01, $00, $00, $02, $00, $00, $01, $02, $03
    db $01, $00, $00, $01, $00, $00, $00, $03, $03, $03, $03, $03, $01, $58, $00

Data_035_52A7:: ; heuristic: target of a monotone pointer table; C0
    db $02, $01, $00, $00, $06, $00, $3C, $0F, $04, $44, $63, $00, $14, $0E, $18, $17
    db $11, $0E, $01, $01, $01, $02, $02, $01, $01, $01, $03, $01, $01, $02, $03, $03
    db $03, $01, $01, $02, $01, $02, $01, $03, $03, $03, $03, $03, $01, $7C, $00

Data_035_52D6:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $05, $00, $32, $0D, $2F, $33, $69, $00, $11, $04, $13, $12
    db $0A, $0C, $01, $01, $00, $00, $00, $01, $01, $02, $03, $01, $03, $01, $03, $03
    db $03, $01, $01, $01, $00, $02, $01, $03, $03, $03, $03, $03, $01, $64, $00

Data_035_5305:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $05, $00, $28, $0C, $51, $62, $8D, $00, $0F, $07, $12, $0E
    db $11, $0B, $01, $01, $01, $00, $00, $01, $00, $01, $03, $00, $00, $00, $02, $02
    db $03, $00, $01, $01, $00, $01, $00, $03, $02, $02, $02, $02, $01, $53, $00

Data_035_5334:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $28, $0B, $10, $44, $A1, $00, $0E, $08, $0E, $0B
    db $07, $09, $01, $01, $01, $01, $01, $01, $00, $01, $03, $00, $02, $00, $02, $02
    db $03, $00, $00, $00, $00, $01, $00, $02, $02, $02, $02, $02, $01, $48, $00

Data_035_5363:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $06, $00, $41, $1D, $07, $6C, $80, $00, $1D, $1C, $1E, $18
    db $18, $06, $02, $02, $02, $01, $01, $02, $02, $02, $02, $02, $02, $01, $03, $03
    db $03, $01, $01, $02, $02, $01, $01, $03, $03, $02, $02, $02, $02, $90, $00

Data_035_5392:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $03, $00, $28, $04, $01, $2E, $3A, $00, $07, $06, $0A, $04
    db $06, $0F, $00, $00, $00, $00, $00, $00, $01, $00, $02, $01, $02, $02, $01, $01
    db $00, $00, $00, $00, $00, $02, $03, $00, $03, $00, $00, $00, $00, $3D, $00

Data_035_53C1:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $00, $00, $04, $00, $2D, $07, $5E, $65, $6D, $05, $0F, $0A, $09, $08
    db $0E, $07, $00, $00, $01, $00, $00, $02, $02, $01, $03, $00, $00, $01, $02, $02
    db $01, $00, $01, $02, $01, $01, $01, $03, $01, $02, $02, $02, $01, $49, $00

Data_035_53F0:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $04, $00, $28, $04, $27, $2E, $58, $00, $0B, $0C, $0E, $08
    db $12, $0D, $00, $00, $00, $02, $02, $00, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $00, $44, $00

Data_035_541F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $04, $01, $2D, $06, $16, $2F, $44, $02, $11, $0D, $13, $0B
    db $10, $14, $01, $01, $01, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $01, $00, $01, $00, $00, $00, $00, $02, $02, $02, $02, $02, $00, $4C, $00

Data_035_544E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $04, $00, $23, $05, $59, $68, $6F, $00, $0E, $08, $11, $09
    db $06, $04, $00, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $01, $01
    db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $03, $03, $00, $3B, $00

Data_035_547D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $03, $01, $32, $05, $29, $56, $A0, $00, $06, $12, $0C, $03
    db $15, $13, $00, $00, $00, $03, $03, $00, $00, $00, $00, $01, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $00, $43, $00

Data_035_54AC:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $05, $01, $1E, $03, $2F, $34, $75, $00, $0B, $0B, $09, $0C
    db $12, $07, $00, $00, $00, $02, $02, $00, $00, $01, $00, $00, $00, $01, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $02, $02, $02, $03, $03, $00, $43, $00

Data_035_54DB:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $04, $00, $28, $04, $0A, $27, $51, $00, $09, $07, $14, $0E
    db $17, $0D, $01, $01, $01, $03, $03, $01, $00, $00, $01, $00, $00, $00, $00, $00
    db $01, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $01, $4B, $00

Data_035_550A:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $04, $01, $28, $05, $6A, $99, $A8, $00, $06, $0E, $11, $0C
    db $12, $05, $00, $00, $00, $02, $02, $00, $01, $01, $01, $00, $00, $01, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $02, $02, $02, $02, $02, $00, $3F, $00

Data_035_5539:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $04, $01, $32, $05, $38, $80, $A6, $02, $0C, $11, $08, $0F
    db $16, $0D, $00, $00, $00, $02, $02, $01, $00, $00, $01, $00, $00, $00, $00, $00
    db $01, $00, $00, $01, $00, $00, $00, $02, $02, $02, $02, $02, $01, $48, $00

Data_035_5568:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $05, $01, $28, $0C, $24, $62, $9B, $00, $07, $08, $06, $0D
    db $0E, $13, $00, $00, $00, $02, $02, $02, $00, $00, $01, $00, $00, $00, $00, $00
    db $01, $00, $00, $02, $00, $00, $00, $02, $02, $02, $02, $02, $02, $41, $00

Data_035_5597:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $02, $01, $32, $02, $21, $2F, $32, $00, $0B, $04, $08, $0D
    db $11, $0B, $00, $00, $00, $02, $02
    ds $10, $00
    db $02, $02, $02, $02, $02, $00, $34, $00

Data_035_55C6:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $04, $01, $28, $05, $39, $75, $99, $02, $0D, $08, $08, $07
    db $09, $01, $00, $00, $00, $02, $02, $00, $01, $01, $01, $00, $00, $01, $00, $00
    db $00, $00, $00, $00, $00, $01, $01, $02, $02, $02, $02, $02, $00, $31, $00

Data_035_55F5:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $03, $01, $28, $03, $51, $7E, $95, $00, $08, $05, $0E, $0C
    db $11, $08, $00, $00, $00, $02, $02
    ds $10, $00
    db $02, $02, $02, $02, $02, $00, $34, $00

Data_035_5624:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $04, $00, $28, $06, $2D, $58, $65, $00, $10, $0C, $14, $14
    db $0E, $0B, $00, $00, $00, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $00, $02, $00, $00, $00, $02, $02, $02, $02, $02, $00, $54, $00

Data_035_5653:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $04, $00, $23, $05, $0A, $52, $7D, $00, $0F, $0A, $15, $0D
    db $0B, $12, $00, $00, $00, $02, $02, $00, $01, $01, $01, $00, $00, $01, $02, $02
    db $01, $00, $00, $00, $00, $01, $01, $03, $03, $03, $03, $03, $01, $51, $00

Data_035_5682:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $03, $01, $1E, $03, $16, $48, $7A, $00, $11, $06, $11, $0F
    db $14, $08, $00, $00, $00, $02, $02, $00, $00, $02, $01, $00, $00, $02, $00, $00
    db $00, $00, $00, $00, $02, $01, $01, $02, $02, $02, $03, $03, $01, $4D, $00

Data_035_56B1:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $04, $01, $2D, $06, $04, $19, $66, $02, $0E, $0B, $12, $0C
    db $11, $0D, $01, $01, $00, $02, $02, $01, $00, $00, $02, $00, $01, $01, $00, $00
    db $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $00, $4E, $00

Data_035_56E0:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $04, $00, $28, $04, $48, $7C, $A7, $00, $09, $0D, $14, $13
    db $17, $1E, $00, $00, $00, $03, $02, $00, $01, $00, $01, $02, $02, $01, $00, $01
    db $00, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $00, $59, $00

Data_035_570F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $01, $01, $00, $05, $01, $32, $07, $13, $44, $53, $02, $14, $07, $0B, $11
    db $13, $0B, $01, $01, $00, $02, $02, $03, $00, $00, $02, $00, $00, $01, $00, $00
    db $01, $00, $01, $03, $00, $01, $00, $02, $02, $02, $02, $02, $01, $54, $00

Data_035_573E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $01, $00, $06, $01, $32, $07, $40, $62, $99, $00, $10, $0D, $13, $08
    db $13, $0C, $02, $02, $02, $01, $01, $00, $00, $00, $00, $01, $01, $01, $00, $00
    db $00, $00, $03, $00, $00, $01, $00, $03, $03, $03, $02, $02, $00, $54, $00

Data_035_576D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $05, $01, $32, $07, $3F, $4A, $52, $02, $14, $07, $13, $11
    db $16, $0C, $01, $01, $01, $03, $03, $01, $00, $00, $01, $02, $00, $02, $00, $00
    db $01, $00, $01, $01, $00, $01, $00, $02, $02, $02, $02, $02, $00, $5A, $00

Data_035_579C:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $05, $01, $32, $08, $0A, $48, $5D, $02, $0A, $07, $08, $0E
    db $16, $09, $01, $01, $01, $02, $02, $01, $03, $00, $03, $00, $02, $00, $00, $00
    db $01, $01, $01, $01, $02, $03, $03, $03, $02, $02, $02, $02, $00, $46, $00

Data_035_57CB:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $06, $01, $3C, $0F, $35, $84, $85, $03, $1B, $13, $0C, $14
    db $17, $17, $01, $01, $01, $02, $02, $01, $01, $01, $02, $00, $00, $01, $00, $00
    db $02, $00, $01, $01, $00, $02, $00, $02, $02, $02, $02, $02, $00, $67, $00

Data_035_57FA:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $05, $00, $32, $05, $78, $7B, $7C, $00, $0E, $14, $08, $09
    db $10, $14, $00, $00, $00, $03, $03, $00, $01, $00, $02, $01, $01, $01, $00, $00
    db $03, $00, $00, $00, $00, $02, $00, $03, $03, $03, $02, $02, $01, $54, $00

Data_035_5829:: ; heuristic: target of a monotone pointer table; C0
    db $03, $01, $00, $00, $06, $00, $46, $18, $3D, $81, $94, $02, $19, $1B, $0F, $18
    db $12, $18, $02, $02, $02, $03, $02, $02, $01, $01, $02, $01, $01, $03, $03, $01
    db $03, $01, $02, $03, $01, $02, $01, $03, $03, $03, $03, $03, $01, $8A, $00

Data_035_5858:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $06, $01, $4B, $1C, $3F, $9F, $A0, $02, $1B, $18, $18, $0C
    db $18, $0C, $02, $02, $02, $03, $03, $02, $01, $01, $02, $02, $02, $03, $02, $02
    db $02, $02, $03, $03, $03, $01, $01, $03, $03, $03, $03, $03, $02, $90, $00

Data_035_5887:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $01, $00, $06, $01, $3C, $16, $19, $40, $9D, $02, $18, $16, $12, $14
    db $18, $16, $01, $01, $01, $02, $02, $02, $01, $01, $02, $02, $02, $02, $02, $02
    db $02, $02, $01, $01, $02, $02, $02, $03, $03, $03, $03, $03, $02, $84, $00

Data_035_58B6:: ; heuristic: target of a monotone pointer table; C0
    db $03, $02, $00, $00, $01, $00, $23, $04, $0A, $34, $A8, $00, $07, $08, $0D, $05
    db $0E, $0B, $00, $00, $00, $00, $00, $03, $01, $01, $01, $01, $01, $01, $01, $00
    db $00, $00, $00, $03, $00, $01, $00, $02, $01, $01, $00, $00, $02, $8A, $00

Data_035_58E5:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $28, $0A, $23, $27, $2B, $00, $0F, $18, $0B, $0D
    db $06, $12, $00, $00, $00, $02, $02, $00, $01, $01, $01, $03, $03, $01, $01, $01
    db $01, $01, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $4C, $00

Data_035_5914:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $03, $00, $2D, $0F, $01, $22, $72, $00, $0E, $1A, $0A, $0C
    db $05, $11, $01, $01, $01, $02, $02, $00, $00, $00, $00, $02, $02, $00, $00, $00
    db $01, $00, $02, $00, $00, $00, $00, $02, $02, $02, $00, $00, $01, $48, $00

Data_035_5943:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $28, $07, $04, $21, $24, $00, $11, $14, $06, $09
    db $02, $13, $00, $00, $00, $02, $02, $00, $00, $00, $00, $02, $02, $00, $01, $01
    db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $02, $44, $00

Data_035_5972:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $01, $00, $04, $01, $23, $07, $20, $5B, $A4, $02, $0C, $14, $06, $0B
    db $0E, $07, $00, $00, $00, $03, $03, $00, $00, $00, $00, $02, $02, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $01, $41, $00

Data_035_59A1:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $01, $00, $1E, $06, $60, $6A, $76, $00, $12, $12, $0C, $0F
    db $09, $05, $00, $00, $00, $02, $02, $00, $00, $01, $00, $02, $02, $01, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $02, $02, $02, $01, $01, $02, $44, $00

Data_035_59D0:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $03, $00, $28, $0B, $61, $6A, $71, $00, $10, $11, $09, $06
    db $02, $0E, $01, $01, $01, $02, $02, $01, $00, $00, $01, $02, $02, $00, $00, $00
    db $01, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $3C, $00

Data_035_59FF:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $03, $00, $2D, $09, $61, $71, $93, $00, $0E, $12, $08, $09
    db $0D, $0D, $00, $00, $00, $02, $02, $00, $01, $01, $01, $02, $02, $01, $00, $00
    db $01, $00, $00, $00, $01, $01, $01, $02, $02, $02, $00, $00, $02, $44, $00

Data_035_5A2E:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $32, $0C, $2D, $38, $39, $00, $0C, $18, $08, $11
    db $0C, $0A, $00, $00, $00, $02, $02, $01, $00, $00, $01, $02, $02, $00, $00, $00
    db $01, $00, $00, $01, $00, $00, $00, $02, $02, $02, $00, $00, $02, $47, $00

Data_035_5A5D:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $28, $03, $2F, $76, $8B, $00, $08, $05, $07, $02
    db $07, $02, $00, $00, $00, $02, $02, $00, $00, $00, $00, $02, $02, $00, $00, $00
    db $01, $00, $00, $00, $01, $01, $01, $02, $02, $02, $00, $00, $02, $2A, $00

Data_035_5A8C:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $05, $00, $28, $08, $2F, $5B, $A4, $00, $11, $0B, $04, $02
    db $09, $0E, $00, $00, $00, $02, $02, $00, $00, $00, $00, $02, $02, $00, $00, $00
    db $00, $00, $00, $00, $00, $02, $03, $02, $02, $02, $00, $00, $02, $33, $00

Data_035_5ABB:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $23, $09, $32, $68, $71, $00, $0D, $14, $0E, $0B
    db $03, $10, $00, $00, $00, $02, $02, $00, $00, $01, $00, $02, $02, $01, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $02, $02, $02, $01, $01, $02, $44, $00

Data_035_5AEA:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $03, $00, $28, $0C, $79, $7A, $7D, $00, $0B, $15, $07, $06
    db $14, $0B, $01, $01, $00, $02, $02, $01, $00, $00, $02, $03, $02, $01, $00, $00
    db $01, $00, $01, $01, $00, $01, $01, $02, $03, $03, $00, $00, $02, $47, $00

Data_035_5B19:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $03, $00, $28, $0B, $1B, $24, $7C, $00, $0F, $12, $08, $03
    db $0C, $0F, $01, $01, $01, $03, $03, $01, $00, $01, $02, $02, $02, $01, $00, $00
    db $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $49, $00

Data_035_5B48:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $28, $0A, $13, $71, $73, $00, $0E, $07, $08, $04
    db $05, $03, $01, $01, $01, $02, $02, $00, $00, $00, $00, $02, $02, $00, $00, $00
    db $01, $00, $01, $00, $01, $00, $00, $02, $02, $02, $00, $00, $02, $34, $00

Data_035_5B77:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $05, $00, $2D, $09, $33, $75, $76, $00, $0C, $14, $0B, $08
    db $0A, $11, $00, $00, $00, $02, $02, $00, $01, $02, $02, $02, $02, $01, $00, $00
    db $03, $00, $00, $00, $01, $02, $02, $02, $02, $02, $00, $00, $02, $51, $00

Data_035_5BA6:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $05, $00, $28, $0D, $75, $8A, $92, $00, $13, $11, $07, $0A
    db $0F, $17, $00, $00, $00, $03, $03, $00, $00, $00, $02, $02, $02, $00, $00, $00
    db $03, $00, $00, $00, $00, $02, $00, $03, $03, $03, $01, $01, $02, $58, $00

Data_035_5BD5:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $23, $0A, $2D, $32, $A9, $00, $0E, $0F, $0C, $0E
    db $0F, $09, $00, $00, $00, $02, $02, $00, $00, $00, $01, $02, $02, $00, $01, $01
    db $01, $00, $00, $00, $00, $00, $00, $03, $03, $03, $02, $02, $01, $4B, $00

Data_035_5C04:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $1E, $06, $5C, $60, $7F, $02, $08, $0B, $08, $05
    db $01, $03, $01, $01, $01, $03, $03, $01, $00, $00, $01, $02, $02, $01, $00, $00
    db $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $32, $00

Data_035_5C33:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $2D, $09, $55, $69, $71, $00, $0E, $0C, $13, $07
    db $0A, $06, $01, $01, $01, $02, $02, $01, $00, $00, $01, $03, $03, $01, $00, $00
    db $02, $00, $00, $00, $00, $00, $00, $03, $03, $03, $00, $00, $01, $47, $00

Data_035_5C62:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $05, $00, $32, $0B, $33, $4E, $65, $00, $11, $0E, $14, $0D
    db $0A, $10, $01, $01, $01, $02, $02, $01, $00, $00, $02, $03, $03, $01, $00, $00
    db $03, $00, $00, $00, $00, $00, $00, $03, $03, $03, $00, $00, $01, $57, $00

Data_035_5C91:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $04, $00, $32, $09, $32, $7A, $80, $00, $08, $0D, $09, $06
    db $07, $0F, $00, $00, $00, $02, $02, $00, $01, $01, $01, $02, $02, $01, $00, $00
    db $02, $00, $00, $00, $01, $01, $01, $02, $02, $02, $00, $00, $01, $3E, $00

Data_035_5CC0:: ; heuristic: target of a monotone pointer table; C0
    db $04, $03, $00, $00, $06, $00, $46, $18, $63, $82, $96, $00, $18, $1E, $17, $15
    db $12, $12, $01, $01, $01, $03, $03, $01, $01, $01, $02, $03, $03, $01, $01, $01
    db $03, $01, $01, $01, $01, $02, $01, $03, $03, $03, $01, $01, $03, $81, $00

Data_035_5CEF:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $06, $00, $46, $18, $1E, $71, $9D, $00, $19, $12, $15, $18
    db $0F, $17, $01, $01, $01, $03, $03, $01, $02, $02, $03, $03, $03, $01, $01, $01
    db $03, $01, $01, $01, $02, $01, $01, $03, $03, $03, $01, $01, $03, $80, $00

Data_035_5D1E:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $06, $00, $50, $0F, $1B, $83, $A3, $00, $16, $07, $0C, $0D
    db $18, $04, $02, $02, $02, $03, $03, $03, $01, $01, $03, $03, $03, $01, $01, $01
    db $03, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $01, $02, $72, $00

Data_035_5D4D:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $06, $00, $50, $00, $3C, $9E, $A2, $00, $0A, $1B, $0B, $0E
    db $18, $1E, $02, $02, $02, $03, $03, $03, $01, $03, $03, $03, $03, $03, $01, $01
    db $03, $01, $02, $03, $03, $03, $03, $03, $03, $03, $01, $01, $02, $8F, $00

Data_035_5D7C:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $00, $00, $02, $00, $1E, $03, $1B, $76, $7A, $00, $08, $0E, $0D, $13
    db $07, $0E, $00, $00, $00, $00, $00, $00, $01, $01, $01, $03, $03, $01, $01, $01
    db $01, $00, $00, $00, $01, $01, $02, $00, $00, $00, $00, $01, $02, $32, $00

Data_035_5DAB:: ; heuristic: target of a monotone pointer table; C0
    db $04, $00, $00, $00, $01, $00, $2D, $10, $0D, $16, $67, $00, $08, $04, $07, $04
    db $09, $07, $00, $00, $00, $00, $00, $00, $00, $01, $02, $03, $03, $02, $02, $01
    db $02, $00, $01, $01, $01, $02, $00, $01, $03, $00, $01, $01, $02, $4D, $00

Data_035_5DDA:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $03, $00, $23, $02, $8B, $95, $A2, $00, $0B, $08, $0E, $09
    db $0B, $07, $00, $00, $00, $00, $00, $00, $01, $03, $01, $01, $01, $03, $01, $01
    db $01, $01, $00, $00, $02, $02, $02, $00, $00, $00, $02, $02, $00, $3C, $00

Data_035_5E09:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $28, $04, $25, $5F, $84, $00, $0D, $05, $0B, $0E
    db $0B, $09, $01, $01, $01, $00, $00, $01, $00, $02, $00, $00, $00, $02, $00, $00
    db $01, $00, $01, $01, $02, $02, $02, $00, $00, $00, $02, $02, $01, $3F, $00

Data_035_5E38:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $1E, $01, $13, $36, $4E, $00, $06, $0B, $0E, $12
    db $08, $07, $00, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $02, $01, $01
    db $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $03, $03, $00, $3E, $00

Data_035_5E67:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $01, $00, $03, $01, $1E, $00, $2E, $4E, $75, $00, $0B, $02, $0D, $07
    db $0C, $08, $00, $00, $00, $01, $01, $00, $00, $02, $00, $00, $00, $02, $00, $00
    db $00, $00, $00, $00, $02, $02, $02, $01, $01, $01, $03, $03, $00, $36, $00

Data_035_5E96:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $28, $04, $32, $38, $39, $00, $11, $0D, $0A, $0C
    db $05, $13, $00, $00, $00, $01, $01, $00, $00, $02, $00, $01, $01, $02, $00, $00
    db $00, $00, $00, $00, $02, $02, $02, $01, $01, $01, $02, $02, $01, $45, $00

Data_035_5EC5:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $23, $06, $56, $76, $A4, $00, $0D, $08, $10, $08
    db $0D, $0E, $01, $01, $01, $01, $01, $01, $00, $02, $01, $00, $00, $02, $00, $00
    db $01, $00, $00, $00, $02, $02, $02, $00, $00, $00, $02, $02, $01, $41, $00

Data_035_5EF4:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $28, $04, $8B, $8F, $A3, $00, $0C, $08, $09, $09
    db $04, $01, $00, $00, $00, $00, $00, $00, $01, $03, $01, $00, $00, $03, $00, $00
    db $01, $00, $00, $00, $03, $03, $03, $00, $00, $00, $02, $02, $01, $33, $00

Data_035_5F23:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $2D, $03, $2F, $40, $8D, $00, $0D, $07, $10, $14
    db $09, $07, $01, $01, $00, $00, $00, $01, $00, $02, $01, $00, $00, $02, $00, $00
    db $01, $00, $01, $01, $02, $02, $02, $00, $00, $00, $02, $02, $01, $40, $00

Data_035_5F52:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $01, $00, $03, $01, $28, $07, $29, $48, $93, $02, $08, $08, $07, $0D
    db $0B, $0E, $00, $00, $00, $00, $00, $00, $01, $02, $01, $00, $00, $02, $00, $00
    db $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $02, $02, $02, $3A, $00

Data_035_5F81:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $02, $00, $23, $02, $4E, $61, $70, $00, $08, $04, $0B, $11
    db $0D, $01, $00, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $02, $00, $00
    db $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $02, $02, $00, $2F, $00

Data_035_5FB0:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $23, $00, $32, $4E, $68, $00, $0B, $04, $08, $0E
    db $0E, $04, $00, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $02, $00, $00
    db $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $02, $02, $00, $30, $00

Data_035_5FDF:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $02, $00, $2D, $05, $53, $73, $7F, $00, $0C, $0A, $10, $0B
    db $0E, $05, $00, $00, $00, $01, $01, $00, $00, $02, $00, $01, $01, $02, $00, $00
    db $00, $00, $00, $00, $02, $02, $02, $01, $02, $02, $02, $02, $01, $40, $00

Data_035_600E:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $05, $00, $23, $06, $25, $2D, $6D, $03, $0F, $0A, $11, $14
    db $0B, $02, $01, $01, $01, $01, $01, $01, $00, $02, $00, $00, $00, $02, $00, $00
    db $00, $00, $01, $01, $02, $02, $02, $01, $01, $01, $03, $03, $00, $4A, $00

Data_035_603D:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $01, $00, $04, $01, $2D, $04, $04, $16, $A9, $02, $09, $0B, $06, $03
    db $0A, $09, $00, $00, $00, $01, $01, $00, $00, $02, $01, $01, $01, $02, $00, $00
    db $01, $00, $00, $00, $02, $02, $02, $01, $01, $01, $02, $02, $01, $36, $00

Data_035_606C:: ; heuristic: target of a monotone pointer table; C0
    db $05, $03, $01, $00, $04, $01, $1E, $02, $48, $60, $7F, $02, $0E, $09, $10, $0C
    db $14, $0C, $00, $00, $00, $00, $00, $00, $00, $03, $01, $00, $00, $02, $01, $01
    db $01, $00, $00, $00, $03, $02, $02, $01, $01, $01, $03, $03, $00, $4C, $00

Data_035_609B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $28, $05, $2B, $59, $A4, $00, $11, $0A, $0F, $10
    db $07, $0E, $00, $00, $00, $00, $00, $00, $01, $03, $01, $01, $00, $03, $00, $00
    db $01, $00, $00, $00, $03, $03, $03, $01, $01, $01, $02, $02, $01, $4C, $00

Data_035_60CA:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $05, $00, $28, $06, $25, $4E, $5E, $01, $10, $08, $0E, $13
    db $05, $01, $00, $00, $00, $00, $00, $00, $01, $03, $01, $00, $00, $03, $00, $00
    db $00, $00, $00, $00, $03, $03, $03, $00, $00, $00, $03, $03, $01, $41, $00

Data_035_60F9:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $01, $00, $04, $01, $28, $07, $5F, $60, $99, $00, $14, $05, $13, $0D
    db $14, $04, $01, $01, $01, $00, $00, $01, $00, $02, $00, $00, $00, $02, $01, $01
    db $00, $00, $01, $01, $02, $02, $02, $01, $01, $01, $03, $03, $00, $4D, $00

Data_035_6128:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $01, $00, $03, $01, $23, $0C, $04, $20, $6F, $00, $17, $13, $08, $07
    db $0E, $03, $00, $00, $00, $00, $00, $00, $00, $02, $03, $00, $00, $03, $00, $00
    db $01, $01, $00, $00, $02, $02, $02, $01, $01, $01, $02, $02, $00, $45, $00

Data_035_6157:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $05, $00, $32, $12, $51, $59, $67, $05, $17, $10, $0C, $09
    db $0B, $08, $01, $00, $00, $01, $00, $01, $01, $02, $03, $01, $01, $02, $01, $01
    db $01, $01, $01, $01, $02, $02, $02, $01, $01, $01, $02, $02, $01, $5A, $00

Data_035_6186:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $05, $00, $32, $07, $4B, $52, $5A, $00, $15, $13, $17, $14
    db $0C, $0E, $02, $02, $02, $00, $00, $02, $00, $02, $01, $00, $00, $02, $00, $00
    db $01, $00, $02, $02, $02, $03, $02, $00, $00, $00, $02, $02, $02, $65, $00

Data_035_61B5:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $2D, $07, $0A, $5A, $62, $00, $13, $0D, $09, $07
    db $0E, $05, $00, $00, $01, $01, $00, $01, $01, $02, $02, $01, $01, $02, $01, $01
    db $01, $01, $00, $00, $02, $02, $02, $01, $01, $01, $02, $02, $01, $49, $00

Data_035_61E4:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $06, $00, $37, $18, $5B, $65, $6B, $03, $16, $14, $18, $17
    db $0F, $12, $01, $02, $02, $01, $00, $02, $01, $03, $02, $01, $01, $03, $01, $01
    db $03, $01, $02, $02, $03, $03, $03, $01, $01, $01, $03, $03, $01, $81, $00

Data_035_6213:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $06, $00, $32, $0B, $20, $94, $9D, $01, $18, $0A, $13, $1A
    db $01, $0F, $01, $01, $01, $00, $00, $01, $01, $02, $02, $00, $00, $02, $00, $00
    db $03, $00, $01, $01, $02, $02, $02, $00, $00, $00, $02, $02, $03, $59, $00

Data_035_6242:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $05, $00, $41, $19, $4A, $63, $73, $00, $12, $17, $19, $18
    db $1E, $15, $03, $03, $03, $02, $01, $03, $01, $03, $02, $01, $01, $01, $01, $01
    db $02, $01, $03, $03, $02, $02, $02, $02, $02, $02, $03, $03, $01, $92, $00

Data_035_6271:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $00, $00, $04, $00, $23, $04, $27, $2D, $72, $00, $0E, $0F, $13, $0D
    db $02, $03, $00, $01, $00, $00, $00, $00, $03, $03, $01, $02, $02, $02, $01, $01
    db $00, $00, $00, $00, $01, $02, $02, $00, $00, $00, $00, $00, $00, $3F, $00

Data_035_62A0:: ; heuristic: target of a monotone pointer table; C0
    db $06, $03, $00, $00, $02, $00, $28, $13, $21, $2D, $9C, $00, $0B, $07, $0F, $08
    db $0F, $04, $02, $02, $01, $01, $01, $02, $01, $01, $03, $02, $02, $02, $01, $01
    db $03, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $3E, $00

Data_035_62CF:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $01, $00, $04, $01, $1E, $13, $27, $2E, $59, $00, $0B, $0D, $0E, $0F
    db $08, $0B, $02, $02, $02, $01, $01, $01, $00, $01, $02, $00, $00, $01, $00, $00
    db $02, $00, $00, $00, $02, $02, $02, $01, $01, $00, $01, $01, $01, $44, $00

Data_035_62FE:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $23, $10, $04, $15, $71, $00, $10, $0B, $12, $0C
    db $10, $13, $01, $01, $02, $02, $02, $02, $00, $00, $02, $00, $00, $00, $01, $01
    db $02, $00, $00, $00, $00, $00, $00, $02, $01, $01, $02, $01, $01, $52, $00

Data_035_632D:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $04, $00, $1E, $0D, $01, $40, $44, $00, $0D, $01, $05, $04
    db $09, $14, $01, $01, $01, $03, $03, $02, $00, $00, $02, $00, $00, $02, $00, $00
    db $02, $00, $00, $00, $00, $01, $01, $01, $02, $02, $02, $01, $00, $37, $00

Data_035_635C:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $01, $00, $04, $01, $28, $12, $5C, $72, $7F, $00, $0B, $12, $0A, $10
    db $09, $0C, $02, $02, $01, $03, $03, $01, $00, $00, $02, $01, $01, $00, $00, $00
    db $02, $00, $00, $00, $00, $00, $00, $02, $02, $01, $00, $00, $01, $44, $00

Data_035_638B:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $04, $00, $23, $10, $36, $90, $A5, $00, $10, $11, $0E, $0E
    db $0D, $08, $02, $02, $02, $02, $02, $02, $00, $01, $02, $00, $00, $01, $00, $00
    db $02, $00, $00, $00, $01, $01, $01, $00, $00, $00, $01, $01, $01, $4A, $00

Data_035_63BA:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $04, $00, $2D, $12, $50, $65, $8D, $00, $11, $0B, $11, $0D
    db $0F, $0C, $02, $02, $02, $01, $01, $02, $01, $01, $03, $00, $00, $01, $00, $00
    db $03, $00, $00, $00, $02, $02, $01, $00, $00, $00, $00, $00, $00, $4C, $00

Data_035_63E9:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $32, $14, $04, $35, $44, $03, $10, $0A, $14, $16
    db $04, $0C, $02, $02, $01, $02, $02, $03, $00, $00, $03, $01, $01, $01, $00, $00
    db $03, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $4A, $00

Data_035_6418:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $04, $00, $2D, $0C, $4C, $53, $96, $01, $0E, $0D, $0F, $07
    db $07, $04, $01, $01, $01, $01, $01, $03, $00, $00, $03, $00, $00, $00, $00, $00
    db $03, $00, $00, $03, $00, $00, $01, $00, $00, $02, $00, $00, $02, $3D, $00

Data_035_6447:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $01, $00, $03, $01, $19, $0D, $01, $04, $10, $00, $0A, $01, $05, $09
    db $09, $11, $01, $01, $01, $02, $02, $02, $00, $00, $03, $00, $01, $00, $00, $00
    db $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $30, $00

Data_035_6476:: ; heuristic: target of a monotone pointer table; C0
    db $06, $01, $01, $00, $03, $01, $19, $0D, $04, $16, $33, $00, $0D, $07, $08, $04
    db $02, $12, $02, $02, $02, $01, $01, $01, $00, $00, $03, $00, $00, $01, $00, $00
    db $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $31, $00

Data_035_64A5:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $2D, $14, $07, $51, $52, $03, $0E, $0D, $11, $0C
    db $07, $15, $02, $03, $02, $02, $02, $02, $00, $00, $03, $00, $01, $00, $00, $00
    db $03, $00, $01, $00, $00, $02, $01, $00, $00, $00, $00, $01, $01, $53, $00

Data_035_64D4:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $2D, $15, $0A, $19, $51, $03, $0F, $0B, $0E, $0F
    db $0C

; LZSS-compressed asset: 241 bytes expand to 275 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_035_64E5:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $13, $01, $03, $02, $02, $02, $02, $02, $02, $03, $01, $01, $01, $00, $00, $03
    db $00, $02, $02, $01, $00, $02, $02, $00, $00, $00, $00, $00, $54, $00

Data_035_6503:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $28, $16, $07, $0A, $10, $03, $14, $0B, $11, $0D
    db $0B, $14, $02, $02, $02, $02, $02, $02, $00, $00, $03, $00, $01, $01, $02, $02
    db $03, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $02, $00, $5F, $00

Data_035_6532:: ; heuristic: target of a monotone pointer table; C0
    db $06, $01, $00, $00, $05, $00, $32, $11, $1E, $27, $57, $00, $13, $07, $13, $0D
    db $0D, $12, $01, $01, $01, $03, $03, $02, $00, $00, $02, $01, $01, $00, $01, $01
    db $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $00, $4F, $00

Data_035_6561:: ; heuristic: target of a monotone pointer table; C0
    db $06, $01, $00, $00, $05, $00, $28, $13, $5E, $69, $6C, $03, $0F, $08, $14, $0C
    db $0A, $0C, $01, $01, $02, $02, $02, $02, $00, $00, $02, $00, $00, $00, $01, $01
    db $02, $00, $00, $00, $00, $00, $00, $02, $02, $02, $02, $01, $00, $4C, $00

Data_035_6590:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $06, $00, $32, $17, $01, $5C, $84, $00, $12, $0C, $12, $0E
    db $0A, $0E, $02, $02, $02, $03, $03, $02, $01, $01, $03, $00, $00, $00, $00, $00
    db $03, $00, $00, $00, $00, $00, $00, $01, $02, $02, $02, $01, $01, $56, $00

Data_035_65BF:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $04, $00, $32, $16, $2D, $51, $62, $00, $11, $0C, $14, $0B
    db $14, $0F, $02, $02, $02, $02, $02

; LZSS-compressed asset: 164 bytes expand to 259 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_035_65D6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $03, $01, $00, $03, $01, $01, $00, $01, $01, $03, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $01, $55, $00

Data_035_65EE:: ; heuristic: target of a monotone pointer table; C0
    db $06, $01, $00, $00, $05, $00, $32, $18, $6C, $6F, $97, $03, $18, $03, $19, $16
    db $04, $01, $01, $01, $01, $01, $01, $01, $00, $00, $03, $00, $00, $00, $00, $00
    db $03, $00, $01, $01, $00, $02, $00, $01, $00, $00, $00, $01, $00, $49, $00

Data_035_661D:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $3C, $14, $50, $55, $97, $05, $17, $01, $12, $18
    db $0C, $0C, $02, $02, $02, $02, $02, $01, $01, $01, $03, $01, $01, $01, $01, $01
    db $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $55, $00

Data_035_664C:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $46, $1E, $07, $44, $8A, $00, $18, $1E, $17, $15
    db $12, $15, $02, $02, $03, $02, $02, $02, $01, $02, $03, $01, $03, $02, $01, $01
    db $03, $00, $02, $01, $00, $02, $00, $01, $00, $00, $00, $00, $01, $7C

; LZSS-compressed asset: 1268 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_035_667A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $00

Data_035_667B:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $37, $17, $56, $67, $6C, $05, $11, $09, $12, $14
    db $0A, $0C, $01, $01, $01, $01, $01, $02, $02, $02, $03, $00, $01, $01, $01, $01
    db $03, $00, $01, $01, $02, $02, $02, $01, $00, $00, $00, $00, $01, $52, $00

Data_035_66AA:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $04, $00, $32, $0F, $01, $68, $90, $00, $17, $0E, $0A, $0F
    db $06, $08, $01, $01, $01, $01, $01, $01, $01, $01, $03, $00, $00, $01, $01, $01
    db $03, $01, $01, $01, $01, $01, $01, $00, $01, $01, $00, $00, $03, $4E, $00

Data_035_66D9:: ; heuristic: target of a monotone pointer table; C0
    db $06, $01, $00, $00, $04, $00, $2D, $16, $54, $68, $6B, $03, $1B, $00, $1B, $07
    db $00, $00, $01, $01, $01, $01, $01, $01, $00, $01, $03, $00, $00, $00, $02, $02
    db $03, $00, $00, $00, $00, $02, $00, $02, $01, $01, $01, $01, $00, $41, $00

Data_035_6708:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $2D, $17, $33, $50, $65, $02, $14, $01, $18, $15
    db $12, $13, $00, $00, $00, $00, $00, $02, $01, $00, $02, $00, $01, $01, $01, $01
    db $03, $00, $00, $01, $01, $02, $01, $02, $00, $00, $00, $00, $01, $5B, $00

Data_035_6737:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $28, $16, $50, $52, $5D, $05, $10, $01, $11, $1D
    db $05, $0D, $00, $02, $00, $02, $00, $00, $00, $01, $03, $00, $00, $01, $00, $00
    db $02, $00, $00, $00, $01, $02, $01, $00, $00, $00, $01, $01, $01, $4C, $00

Data_035_6766:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $05, $00, $3C, $15, $01, $63, $99, $02, $18, $09, $15, $18
    db $17, $12, $02, $02, $02, $03, $03, $01, $01, $01, $03, $01, $01, $01, $01, $01
    db $03, $00, $00, $00, $00, $02, $00, $01, $01, $01, $01, $01, $01, $6D, $00

Data_035_6795:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $06, $00, $46, $1C, $48, $55, $57, $05, $19, $18, $17, $0F
    db $11, $14, $02, $02, $03, $02, $01, $03, $02, $02, $03, $01, $02, $02, $01, $01
    db $03, $01, $01, $01, $03, $03, $02, $02, $00, $00, $00, $00, $02, $7D, $00

Data_035_67C4:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $00, $00, $06, $00, $4B, $1B, $07, $6E, $82, $03, $19, $18, $19, $16
    db $17, $0D, $02, $02, $02, $02, $02, $02, $01, $01, $03, $01, $01, $02, $01, $01
    db $03, $01, $02, $02, $02, $02, $02, $00, $00, $00, $00, $01, $02, $7F, $00

Data_035_67F3:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $01, $00, $05, $01, $3C, $15, $16, $2F, $99, $02, $0A, $0C, $0B, $16
    db $0F, $0A, $01, $01, $01, $01, $00, $00, $01, $01, $03, $01, $01, $01, $01, $01
    db $03, $00, $01, $01, $01, $02, $01, $00, $00, $00, $01, $00, $02, $51, $00

Data_035_6822:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $03, $01, $28, $0B, $7F, $93, $A5, $00, $0B, $0C, $0D, $08
    db $12, $0F, $00, $00, $00, $00, $00, $00, $03, $03, $03, $01, $01, $03, $01, $01
    db $03, $01, $00, $00, $02, $02, $02, $00, $00, $00, $00, $00, $00, $47, $00

Data_035_6851:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $2D, $0D, $44, $53, $6D, $03, $06, $01, $17, $0F
    db $04, $06, $01, $01, $01, $00, $00, $02, $02, $02, $02, $00, $00, $02, $00, $00
    db $03, $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $01, $44, $00

Data_035_6880:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $03, $00, $23, $06, $27, $2B, $36, $00, $11, $0D, $11, $08
    db $0B, $04, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $01, $01
    db $02, $00, $00, $00, $02, $02, $02, $01, $01, $01, $01, $01, $00, $43, $00

Data_035_68AF:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $04, $00, $23, $05, $4A, $52, $70, $00, $0E, $08, $0C, $0B
    db $12, $09, $00, $00, $00, $01, $01, $00, $02, $02, $02, $00, $00, $02, $00, $00
    db $02, $00, $00, $00, $02, $02, $02, $01, $01, $01, $01, $01, $00, $41, $00

Data_035_68DE:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $04, $00, $32, $0A, $4E, $60, $6B, $00, $0F, $11, $0C, $09
    db $04, $08, $00, $00, $00, $01, $01, $00, $02, $02, $02, $01, $01, $02, $00, $00
    db $02, $00, $00, $00, $02, $02, $03, $01, $01, $01, $00, $00, $00, $41, $00

Data_035_690D:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $1E, $08, $35, $39, $A4, $01, $0C, $08, $0F, $14
    db $01, $0B, $00, $00, $00, $00, $00, $00, $02, $03, $02, $00, $00, $03, $00, $00
    db $02, $00, $00, $00, $03, $03, $03, $00, $00, $00, $01, $01, $00, $42, $00

Data_035_693C:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $2D, $0D, $16, $22, $24, $00, $11, $07, $13, $09
    db $0C, $08, $01, $01, $01, $01, $01, $01, $02, $02, $03, $00, $00, $02, $00, $00
    db $03, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $00, $01, $43, $00

Data_035_696B:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $04, $01, $32, $0C, $44, $79, $84, $02, $09, $06, $06, $14
    db $08, $0C, $00, $00, $00, $00, $00, $01, $02, $02, $03, $00, $00, $03, $00, $00
    db $03, $00, $00, $01, $02, $03, $02, $00, $00, $00, $00, $00, $01, $3B, $00

Data_035_699A:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $2D, $09, $13, $5F, $95, $00, $11, $13, $17, $09
    db $0C, $0A, $01, $01, $01, $01, $00, $01, $02, $02, $02, $00, $00, $02, $00, $00
    db $02, $00, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $01, $4D, $00

Data_035_69C9:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $04, $00, $28, $08, $73, $80, $8B, $00, $11, $0D, $10, $08
    db $0B, $0A, $00, $00, $00, $00, $00, $00, $02, $02, $02, $00, $00, $02, $00, $00
    db $02, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $00, $00, $3F, $00

Data_035_69F8:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $04, $00, $1E, $0A, $13, $1B, $1E, $01, $06, $0A, $0B, $11
    db $07, $0E, $00, $00, $00, $00, $00, $00, $02, $03, $02, $00, $00, $03, $01, $01
    db $02, $00, $00, $00, $03, $03, $03, $00, $00, $00, $01, $01, $02, $42, $00

Data_035_6A27:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $03, $01, $23, $0C, $48, $4A, $A6, $00, $11, $04, $0A, $03
    db $0F, $09, $00, $00, $00, $02, $01, $01, $02, $02, $02, $00, $00, $02, $00, $00
    db $02, $00, $00, $00, $02, $02, $02, $01, $01, $01, $01, $01, $01, $3D, $00

Data_035_6A56:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $04, $01, $23, $09, $0A, $24, $57, $02, $10, $13, $13, $0C
    db $0D, $06, $00, $00, $00, $03, $01, $00, $02, $02, $02, $00, $00, $02, $01, $01
    db $02, $00, $00, $00, $02, $02, $02, $01, $01, $01, $01, $01, $00, $4F, $00

Data_035_6A85:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $04, $01, $28, $0A, $5A, $75, $80, $00, $13, $03, $15, $11
    db $13, $06, $00, $00, $00, $01, $01, $00, $02, $03, $02, $01, $01, $03, $00, $00
    db $02, $00, $00, $01, $03, $03, $03, $01, $01, $00, $01, $01, $01, $53, $00

Data_035_6AB4:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $03, $00, $23, $04, $2E, $73, $7D, $00, $07, $02, $0E, $07
    db $04, $01, $00, $00, $00, $01, $00, $01, $02, $02, $02, $00, $00, $02, $00, $00
    db $02, $00, $00, $01, $02, $02, $02, $00, $00, $00, $00, $00, $01, $2C, $00

Data_035_6AE3:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $04, $01, $28, $07, $01, $04, $A5, $00, $09, $0F, $06, $08
    db $0D, $04, $02, $02, $00, $01, $00, $00, $02, $02, $02, $00, $00, $02, $00, $00
    db $02, $00, $02, $00, $02, $02, $02, $01, $01, $00, $00, $00, $00, $3E, $00

Data_035_6B12:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $28, $0D, $4E, $5D, $62, $01, $09, $14, $11, $10
    db $08, $05, $01, $01, $01, $02, $01, $02, $02, $02, $02, $00, $00, $02, $00, $00
    db $02, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00, $00, $03, $4A, $00

Data_035_6B41:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $32, $10, $19, $5D, $85, $00, $15, $02, $1A, $13
    db $0F, $0D, $00, $01, $01, $01, $00, $02, $02, $02, $03, $01, $01, $02, $00, $00
    db $03, $00, $00, $02, $02, $03, $02, $03, $00, $00, $00, $00, $00

; LZSS-compressed asset: 92 bytes expand to 95 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_035_6B6E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $5F, $00

Data_035_6B70:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $06, $00, $3C, $19, $0A, $0D, $3C, $00, $14, $18, $0E, $14
    db $0F, $1B, $01, $01, $02, $03, $01, $03, $02, $02, $03, $01, $01, $03, $01, $01
    db $03, $01, $01, $02, $03, $03, $03, $01, $01, $01, $01, $01, $01, $7A, $00

Data_035_6B9F:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $06, $00, $28, $0A, $07, $52, $63, $00, $0E, $0D, $11, $0C
    db $07, $01, $00, $00, $00, $01, $00, $01, $02, $02, $02, $01, $01, $02, $00, $00
    db $02, $00, $00, $00, $02, $02, $02, $00, $00, $00, $00

; LZSS-compressed asset: 259 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_035_6BCA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $00, $01, $3B, $00

Data_035_6BCE:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $37, $0C, $27, $57, $63, $05, $10, $0B, $12, $0C
    db $10, $13, $00, $00, $01, $02, $00, $02, $02, $02, $03, $01, $01, $02, $00, $00
    db $03, $00, $00, $01, $02, $02, $02, $00, $00, $00, $00, $00, $01, $55, $00

Data_035_6BFD:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $05, $00, $46, $14, $01, $10, $8A, $05, $17, $15, $19, $12
    db $0F, $14, $01, $01, $03, $02, $01, $02, $02, $02, $03, $01, $01, $03, $01, $01
    db $03, $01, $01, $02, $03, $03, $03, $01, $01, $01, $01, $01, $01, $7A, $00

Data_035_6C2C:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $00, $00, $06, $00, $4B, $1A, $31, $79, $7B, $00, $18, $14, $1E, $14
    db $0C, $0E, $02, $02, $02, $02, $01, $02, $02, $02, $03, $01, $01, $03, $01, $01
    db $03, $00, $02, $02, $01, $01, $01, $01, $01, $01, $01, $02, $01, $78, $00

Data_035_6C5B:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $05, $01, $28, $01, $3A, $76, $9E, $00, $0B, $14, $01, $02
    db $15, $05, $00, $00, $00, $00, $00, $00, $02, $02, $03, $00, $00, $02, $00, $00
    db $02, $00, $00, $00, $02, $03, $02, $01, $00, $00, $00, $00, $01, $38, $00

Data_035_6C8A:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $04, $01, $32, $0D, $71, $7F, $84, $02, $0E, $0C, $0F, $0C
    db $10, $0A, $00, $00, $00, $01, $01, $01, $02, $02, $03, $01, $01, $03, $00, $00
    db $03, $00, $00, $00, $02, $02, $02, $01, $01, $01, $00, $00, $01, $4D, $00

Data_035_6CB9:: ; heuristic: target of a monotone pointer table; C0
    db $07, $02, $01, $00, $04, $00, $28, $08, $13, $84, $7B, $00, $05, $15, $0D, $0B
    db $0E, $15, $00, $00

; LZSS-compressed asset: 210 bytes expand to 258 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_035_6CCD:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $02, $01, $01, $00, $03, $03, $03, $00, $01, $02, $00, $00, $02, $00, $00, $01
    db $01, $01, $03, $01, $00, $00, $00, $00, $00, $48, $00

Data_035_6CE8:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $00, $00, $06, $00, $41, $14, $13, $84, $96, $05, $1B, $0D, $18, $17
    db $13, $15, $00, $00, $00, $02, $02, $03, $03, $03, $03, $01, $01, $02, $01, $01
    db $03, $01, $00, $03, $01, $03, $03, $01, $00, $01, $01, $02, $02, $3B, $00

Data_035_6D17:: ; heuristic: target of a monotone pointer table; C0
    db $08, $03, $00, $00, $04, $00, $28, $0C, $04, $33, $34, $00, $0D, $0B, $09, $12
    db $11, $0F, $00, $00, $00, $00, $00, $02, $01, $01, $03, $01, $01, $01, $01, $01
    db $03, $01, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $01, $43, $00

Data_035_6D46:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $04, $00, $32, $0E, $22, $44, $A9, $00, $0E, $0F, $11, $0C
    db $09, $0D, $01, $01, $01, $00, $00, $02, $00, $00, $03, $00, $00, $02, $00, $00
    db $03, $00, $01, $02, $00, $00, $03, $01, $01, $01, $00, $00, $01, $3D, $00

Data_035_6D75:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $03, $00, $23, $0A, $01, $69, $A2, $00, $0C, $0A, $0E, $06
    db $11, $0C, $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $00, $00, $01, $01
    db $02, $00, $02, $00, $00, $00, $00, $01, $01, $01, $01, $01, $00, $37, $00

Data_035_6DA4:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $04, $01, $23, $0A, $22, $23, $9D, $00, $10, $0D, $05, $0E
    db $0E, $07, $00, $00, $00, $01, $01, $02, $02, $00, $02, $00, $00, $00, $00, $00
    db $02, $00, $00, $02, $00, $00, $00, $01, $01, $01, $01, $01, $01, $39, $00

Data_035_6DD3:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $05, $00, $2D, $0C, $0A, $15, $A0, $00, $08, $17, $0B, $0C
    db $03, $13, $00, $00, $00, $01, $01, $02, $00, $00, $02, $01, $01, $00, $00, $00
    db $02, $00, $00, $02, $00, $00, $00, $01, $01, $01, $00, $00, $01, $3C, $00

Data_035_6E02:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $04, $00, $1E, $08, $15, $54, $6A, $00, $09, $0D, $0E, $11
    db $07, $0B, $00, $00, $00, $00, $00, $02, $00, $01, $02, $00, $00, $01, $00, $00
    db $02, $00, $00, $02, $01, $01, $01, $00, $00, $00, $01, $01, $01, $3A, $00

Data_035_6E31:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $05, $00, $2D, $0E, $36, $3A, $A5, $00, $0F, $0B, $08, $06
    db $0B, $13, $01, $01, $01, $01, $01, $02, $00, $00, $03, $00, $00, $00, $00, $00
    db $03, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $02, $3D, $00

Data_035_6E60:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $04, $00, $2D, $0C, $16, $5E, $6B, $00, $0E, $04, $14, $15
    db $0A, $0D, $00, $00, $00, $00, $00, $02, $01, $01, $03, $00, $00, $01, $00, $00
    db $03, $00, $00, $02, $01, $01, $01, $00, $00, $00, $00, $00, $02, $47, $00

Data_035_6E8F:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $04, $01, $23, $06, $76, $7A, $A3, $00, $0D, $09, $07, $04
    db $07, $0B, $00, $00, $00, $00, $00, $02, $01, $01, $02, $01, $01, $02, $00, $00
    db $02, $00, $00, $02, $00, $00, $01, $01, $00, $00, $00, $00, $00, $34, $00

Data_035_6EBE:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $03, $00, $28, $08, $4E, $8D, $95, $00, $08, $0D, $0B, $0E
    db $07, $04, $00, $00, $00, $00, $00, $02, $00, $00, $02, $00, $00, $00, $00, $00
    db $02, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $01, $2C, $00

Data_035_6EED:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $05, $00, $23, $0B, $27, $2E, $34, $00, $0E, $11, $0C, $0C
    db $08, $0E, $00, $00, $00, $00, $00, $02, $00, $01, $02, $00, $00, $01, $00, $00
    db $02, $00, $00, $02, $02, $02, $01, $00, $00, $00, $01, $01, $01, $42, $00

Data_035_6F1C:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $06, $00, $2D, $0F, $40, $6C, $7E, $03, $12, $0D, $14, $17
    db $09, $0A, $01, $01, $01, $00, $00, $02, $01, $00, $03, $00, $00, $02, $00, $00
    db $03, $00, $01, $03, $02, $03, $02, $00, $00, $00, $00, $00, $01, $51, $00

Data_035_6F4B:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $05, $00, $23, $0D, $07, $0D, $66, $03, $15, $0B, $17, $15
    db $12, $13, $00, $00, $00, $00, $00, $02, $01, $01, $02, $01, $01, $01, $01, $01
    db $02, $01, $00, $02, $00, $00, $00, $01, $01, $01, $01, $01, $00, $5D, $00

Data_035_6F7A:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $04, $01, $1E, $0B, $32, $5A, $60, $00, $08, $03, $09, $0B
    db $0C, $06, $00, $00, $01, $01, $00, $02, $00, $01, $02, $01, $01, $01, $00, $00
    db $02, $00, $00, $02, $01, $01, $01, $00, $00, $00, $01, $01, $00, $35, $00

Data_035_6FA9:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $04, $01, $2D, $09, $25, $29, $2D, $02, $0C, $12, $09, $13
    db $0D, $0F, $00, $00, $00, $02, $01, $02, $00, $00, $02, $01, $01, $00, $00, $00
    db $02, $00, $00, $02, $00, $00, $00, $02, $02, $02, $00, $00, $00, $44, $00

Data_035_6FD8:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $04, $00, $1E, $08, $76, $7E, $A1, $00, $07, $06, $0E, $04
    db $04, $03, $00, $00, $00, $00, $00, $02, $00, $00, $02, $01, $01, $00, $00, $00
    db $02, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $02, $28, $00

Data_035_7007:: ; heuristic: target of a monotone pointer table; C0
    db $08, $01, $00, $00, $05, $00, $28, $0D, $62, $63, $65, $05, $0C, $05, $15, $16
    db $18, $11, $01, $01, $01, $01, $01, $02, $01, $02, $03, $00, $00, $00, $00, $00
    db $03, $00, $01, $02, $02, $02, $01, $02, $00, $00, $00, $00, $00, $53, $00

Data_035_7036:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $05, $00, $2D, $16, $52, $5E, $67, $03, $17, $0D, $18, $1A
    db $16, $0C, $02, $02, $02, $02, $02, $03, $02, $03, $03, $00, $00, $00, $00, $00
    db $03, $00, $02, $03, $03, $03, $00, $00, $00, $00, $00, $00, $01, $6F, $00

Data_035_7065:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $04, $01, $28, $0B, $13, $6C, $A5, $00, $12, $13, $0F, $12
    db $09, $13, $00, $00, $00, $00, $00, $02, $02, $02, $03, $01, $01, $01, $01, $01
    db $03, $01, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $01, $4F, $00

Data_035_7094:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $04, $01, $28, $09, $40, $44, $89, $02, $0D, $0F, $0B, $0E
    db $14, $12, $00, $00, $00, $02, $01, $02, $00, $00, $02, $00, $00, $00, $00, $01
    db $02, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $01, $44, $00

Data_035_70C3:: ; heuristic: target of a monotone pointer table; C0
    db $08, $03, $00, $00, $06, $00, $2D, $0D, $01, $40, $97, $00, $12, $0C, $11, $18
    db $04, $07, $03, $03, $01, $02, $00, $01, $00, $00, $03, $00, $00, $01, $00, $00
    db $03, $00, $03, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $4A, $00

Data_035_70F2:: ; heuristic: target of a monotone pointer table; C0
    db $08, $01, $00, $00, $06, $00, $2D, $0D, $10, $44, $94, $00, $10, $06, $12, $18
    db $04, $07, $01, $01, $01, $02, $00, $03, $00, $00, $03, $00, $00, $00, $01, $00
    db $03, $00, $01, $03, $00, $00, $00, $00, $00, $00, $00, $00, $02, $47, $00

Data_035_7121:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $05, $01, $28, $0B, $01, $13, $A8, $00, $19, $0A, $14, $0C
    db $01, $14, $00, $00, $01, $02, $01, $02, $01, $01, $03, $01, $01, $01, $01, $01
    db $03, $01, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $4E, $00

Data_035_7150:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $01, $00, $05, $01, $2D, $0B, $31, $48, $78, $00, $14, $0D, $0F, $06
    db $07, $04, $01, $01, $00, $00, $00, $02, $01, $01, $03, $01, $01, $01, $01, $01
    db $02, $00, $01, $02, $01, $01, $00, $00, $00, $00, $00, $00, $01, $40, $00

Data_035_717F:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $04, $00, $28, $08, $76, $7C, $7D, $00, $0C, $03, $0D, $0E
    db $01, $0F, $00, $00, $01, $01, $00, $03, $01, $00, $03, $00, $00, $00, $00, $00
    db $03, $00, $00, $03, $00, $00, $00, $00, $00, $00, $00, $00, $01, $33, $00

Data_035_71AE:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $04, $00, $2D, $12, $68, $69, $9F, $03, $11, $04, $0C, $15
    db $04, $06, $00, $00, $01, $01, $00, $03, $01, $01, $03, $00, $00, $00, $00, $00
    db $03, $00, $00, $03, $00, $00, $00, $01, $01, $01, $01, $01, $02, $43, $00

Data_035_71DD:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $05, $00, $32, $0F, $94, $97, $9D, $03, $18, $0A, $17, $18
    db $01, $0E, $00, $01, $01, $01, $00, $03, $01, $01, $03, $00, $01, $00, $00, $00
    db $03, $00, $01, $03, $00, $02, $01, $01, $01, $01, $01, $01, $02, $5D, $00

Data_035_720C:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $04, $00, $32, $0E, $15, $20, $4B, $03, $0F, $0B, $11, $14
    db $00, $0D, $01, $01, $00, $00, $00, $02, $00, $01, $03, $01, $01, $01, $01, $01
    db $03, $00, $02, $02, $01, $01, $01, $00, $00, $00, $01, $01, $02, $4D, $00

Data_035_723B:: ; heuristic: target of a monotone pointer table; C0
    db $08, $01, $00, $00, $06, $00, $4B, $12, $3E, $81, $85, $05, $18, $15, $18, $1B
    db $11, $17, $02, $02, $02, $02, $01, $02, $03, $03, $03, $03, $03, $03, $02, $02
    db $03, $01, $02, $02, $03, $03, $03, $02, $02, $02, $01, $01, $02, $92, $00

Data_035_726A:: ; heuristic: target of a monotone pointer table; C0
    db $08, $02, $00, $00, $06, $00, $46, $18, $13, $3F, $80, $00, $18, $15, $0C, $19
    db $15, $0A, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03, $03, $02, $02
    db $03, $02, $02, $02, $03, $03, $03, $01, $01, $03, $01, $01, $02, $88, $00

Data_035_7299:: ; heuristic: target of a monotone pointer table; C0
    db $08, $00, $00, $00, $02, $00, $28, $05, $54, $68, $6F, $00, $03, $02, $06, $03
    db $04, $06, $00, $00, $00, $01, $00, $00, $01, $01, $03, $01, $01, $01, $01, $00
    db $02, $00, $00, $00, $03, $02, $00, $00, $00, $00, $00, $00, $00, $4F, $00

Data_035_72C8:: ; heuristic: target of a monotone pointer table; C0
    db $08, $00, $01, $00, $05, $01, $2D, $08, $0A, $38, $81, $02, $08, $18, $0E, $10
    db $0B, $1A, $01, $00, $00, $01, $03, $01, $00, $02, $03, $02, $02, $01, $00, $00
    db $01, $00, $02, $02, $03, $02, $01, $01, $01, $00, $00, $02, $02, $75, $00

Data_035_72F7:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $03, $02, $23, $03, $29, $2D, $6F, $00, $0F, $11, $0C, $09
    db $0E, $0A, $02, $02, $00, $00, $00, $00, $00, $02, $01, $00, $01, $00, $00, $02
    db $00, $00, $02, $00, $03, $02, $00, $00, $00, $02, $00, $00, $02, $42, $00

Data_035_7326:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $28, $05, $2F, $69, $73, $01, $0C, $11, $12, $13
    db $16, $09, $00, $00, $00, $01, $00, $00, $00, $02, $01, $00, $01, $01, $00, $02
    db $00, $00, $02, $00, $03, $00, $00, $00, $00, $02, $00, $00, $02, $4C, $00

Data_035_7355:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $28, $0D, $58, $6B, $6C, $03, $17, $08, $17, $10
    db $07, $08, $01, $01, $00, $01, $00, $00, $00, $02, $00, $00, $00, $01, $00, $02
    db $01, $00, $02, $00, $01, $02, $02, $01, $01, $02, $00, $00, $02, $4A, $00

Data_035_7384:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $28, $0A, $04, $93, $9B, $02, $16, $09, $18, $13
    db $09, $07, $02, $02, $01, $01, $00, $00, $01, $02, $00, $00, $00, $01, $00, $02
    db $00, $00, $02, $00, $00, $00, $00, $02, $02, $02, $01, $00, $02, $4D, $00

Data_035_73B3:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $28, $04, $04, $60, $73, $00, $09, $0E, $0A, $0D
    db $05, $07, $01, $01, $01, $01, $00, $00, $01, $02, $01, $01, $00, $00, $00, $02
    db $01, $00, $02, $00, $01, $02, $00, $00, $01, $02, $00, $00, $01, $3A, $00

Data_035_73E2:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $2D, $06, $38, $62, $91, $00, $0B, $08, $11, $0E
    db $06, $04, $02, $02, $01, $01, $00, $00, $00, $02, $01, $00, $00, $00, $00, $02
    db $01, $00, $02, $00, $02, $02, $01, $00, $00, $02, $00, $00, $01, $3A, $00

Data_035_7411:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $23, $09, $1E, $27, $71, $01, $10, $11, $0E, $12
    db $14, $13, $02, $02, $02, $01, $00, $00, $00, $02, $00, $01, $01, $01, $00, $02
    db $01, $00, $02, $00, $02, $01, $01, $01, $01, $02, $01, $00, $02, $59, $00

Data_035_7440:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $23, $0A, $16, $1B, $7A, $01, $07, $0F, $07, $0D
    db $11, $15, $01, $01, $01, $01, $00, $00, $01, $02, $01, $01, $01, $00, $00, $02
    db $00, $00, $02, $00, $01, $01, $01, $01, $00, $02, $00, $00, $02, $44, $00

Data_035_746F:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $03, $02, $23, $04, $34, $4C, $6F, $01, $05, $04, $08, $03
    db $0E, $07, $00, $00, $00, $00, $00, $01, $01, $02, $01, $01, $01, $00, $00, $00
    db $00, $00, $01, $01, $02, $01, $01, $00, $00, $00, $00, $00, $03, $3F, $00

Data_035_749E:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $28, $0E, $76, $78, $91, $01, $17, $15, $18, $14
    db $08, $0E, $02, $02, $01, $01, $00, $00, $00, $02, $01, $00, $01, $01, $01, $02
    db $01, $00, $02, $00, $01, $01, $01, $01, $02, $02, $01, $00, $02, $59, $00

Data_035_74CD:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $2D, $0C, $0D, $2E, $71, $01, $11, $10, $17, $14
    db $09, $13, $02, $02, $00, $02, $00, $00, $00, $02, $00, $02, $02, $00, $00, $02
    db $00, $00, $02, $00, $01, $00, $00, $00, $00, $02, $00, $00, $02, $4F, $00

Data_035_74FC:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $32, $0D, $52, $65, $95, $01, $12, $13, $10, $16
    db $0D, $07, $02, $02, $02, $01, $01, $00, $01, $02, $01, $01, $01, $00, $02, $02
    db $01, $00, $02, $00, $00, $00, $02, $00, $00, $02, $01, $01, $02, $55, $00

Data_035_752B:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $28, $08, $25, $70, $7E, $03, $09, $06, $0C, $07
    db $12, $06, $02, $02, $01, $01, $00, $00, $00, $02, $00, $00, $00, $01, $02, $02
    db $00, $00, $02, $00, $00, $01, $01, $01, $00, $02, $01, $00, $02, $3D, $00

Data_035_755A:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $03, $02, $28, $0E, $04, $61, $8B, $00, $0B, $0A, $15, $11
    db $16, $0F, $01, $01, $00, $00, $00, $00, $01, $02, $03, $00, $00, $01, $01, $02
    db $00, $00, $02, $00, $00, $00, $02, $01, $01, $02, $01, $00, $02, $4D, $00

Data_035_7589:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $2D, $0B, $55, $5E, $63, $01, $0C, $14, $18, $12
    db $14, $0E, $02, $02, $02, $01, $00, $01, $00, $03, $02, $01, $01, $00, $00, $02
    db $01, $01, $02, $01, $00, $00, $00, $01, $01, $02, $00, $00, $02, $5B, $00

Data_035_75B8:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $2D, $0F, $52, $56, $65, $05, $17, $0D, $18, $15
    db $0E, $09, $02, $02, $02, $00, $01, $01, $01, $02, $00, $01, $01, $01, $00, $02
    db $01, $00, $02, $00, $01, $01, $00, $00, $00, $02, $01, $01, $02, $5B, $00

Data_035_75E7:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $03, $02, $28, $09, $4C, $73, $9B, $01, $0B, $07, $12, $09
    db $18, $13, $02, $02, $01, $01, $00, $00, $01, $02, $02, $00, $00, $01, $01, $02
    db $01, $00, $02, $01, $00, $01, $01, $01, $02, $02, $00, $01, $02, $4F, $00

Data_035_7616:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $23, $0A, $25, $39, $7F, $01, $11, $13, $09, $17
    db $07, $13, $02, $02, $02, $02, $01, $01, $01, $02, $01, $00, $00, $01, $00, $02
    db $00, $00, $02, $01, $02, $02, $00, $00, $02, $02, $00, $01, $02, $54, $00

Data_035_7645:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $28, $0C, $44, $91, $96, $01, $15, $09, $11, $0E
    db $0F, $08, $02, $02, $01, $00, $00, $00, $00, $03, $01, $00, $00, $01, $00, $02
    db $01, $00, $02, $00, $01, $01, $01, $01, $00, $03, $00, $00, $01, $47, $00

Data_035_7674:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $2D, $11, $4E, $63, $7A, $01, $0B, $15, $10, $0A
    db $0E, $13, $02, $02, $01, $01, $00, $01, $01, $02, $00, $01, $01, $01, $01, $02
    db $01, $00, $02, $00, $00, $00, $01, $02, $02, $02, $01, $02, $02, $59, $00

Data_035_76A3:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $32, $10, $10, $2F, $90, $05, $17, $05, $1A, $18
    db $0A, $0D, $02, $02, $02, $02, $00, $01, $01, $02, $02, $01, $01, $01, $00, $02
    db $02, $00, $02, $01, $01, $02, $02, $01, $00, $02, $01, $02, $01, $63, $00

Data_035_76D2:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $32, $19, $27, $65, $97, $05, $19, $14, $1C, $15
    db $0E, $0D, $01, $01, $01, $01, $00, $00, $02, $02, $03, $02, $02, $02, $02, $02
    db $02, $01, $02, $00, $02, $02, $02, $01, $02, $02, $01, $01, $03, $76, $00

Data_035_7701:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $2D, $13, $1B, $63, $7C, $01, $18, $09, $19, $12
    db $09, $14, $02, $02, $02, $01, $01, $00, $00, $02, $01, $00, $02, $01, $01, $02
    db $02, $00, $02, $00, $02, $01, $01, $01, $02, $02, $01, $01, $03, $64, $00

Data_035_7730:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $06, $02, $37, $18, $1E, $65, $69, $01, $19, $0E, $1A, $17
    db $0C, $15, $02, $02, $02, $02, $01, $01, $01, $02, $00, $02, $02, $01, $01, $03
    db $01, $01, $02, $01, $02, $01, $01, $01, $01, $02, $01, $02, $03, $75, $00

Data_035_775F:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $37, $15, $40, $6F, $73, $03, $12, $17, $19, $0B
    db $0A, $0A, $02, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01, $01, $02, $03
    db $01, $01, $03, $01, $01, $02, $02, $01, $01, $02, $01, $00, $03, $6A, $00

Data_035_778E:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $2D, $1E, $21, $4C, $91, $01, $1D, $15, $17, $12
    db $03, $0A, $02, $02, $01, $01, $02, $01, $02, $02, $03, $01, $01, $01, $00, $02
    db $02, $02, $02, $01, $01, $02, $02, $01, $00, $02, $00, $01, $03, $68, $00

Data_035_77BD:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $06, $02, $32, $18, $32, $48, $6E, $05, $18, $14, $1A, $0A
    db $11, $09, $03, $03, $02, $02, $01, $02, $02, $02, $02, $01, $01, $02, $02, $03
    db $02, $01, $03, $01, $02, $02, $02, $02, $02, $02, $02, $02, $03, $7D, $00

Data_035_77EC:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $06, $02, $32, $1A, $55, $62, $67, $03, $12, $09, $1B, $15
    db $15, $0D, $02, $02, $02, $02, $01, $01, $02, $02, $02, $03, $02, $02, $01, $02
    db $02, $02, $02, $01, $01, $01, $01, $01, $01, $02, $01, $02, $02, $73, $00

Data_035_781B:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $05, $02, $37, $15, $2D, $6A, $7E, $01, $17, $12, $19, $12
    db $10, $0A, $00, $02, $00, $00, $00, $01, $02, $02, $03, $01, $01, $02, $02, $03
    db $01, $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $01, $03, $77, $00

Data_035_784A:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $06, $02, $41, $1E, $0D, $8A, $95, $03, $1C, $16, $17, $18
    db $0D, $09, $03, $03, $03, $03, $01, $01, $02, $02, $03, $02, $02, $02, $03, $02
    db $02, $02, $02, $01, $03, $03, $03, $03, $03, $02, $02, $03, $03, $8E, $00

Data_035_7879:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $04, $02, $23, $0C, $4E, $89, $95, $01, $11, $08, $0D, $16
    db $07, $08, $02, $02, $01, $01, $00, $01, $00, $02, $01, $00, $00, $00, $01, $02
    db $01, $00, $02, $00, $00, $00, $00, $00, $00, $02, $01, $00, $02, $44, $00

Data_035_78A8:: ; heuristic: target of a monotone pointer table; C0
    db $09, $02, $00, $00, $06, $03, $1E, $05, $25, $5F, $76, $01, $07, $13, $05, $09
    db $09, $0F, $01, $01, $01, $01, $00, $00, $01, $02, $00, $02, $00, $00, $01, $00
    db $01, $00, $01, $01, $03, $01, $00, $01, $00, $00, $00, $00, $03, $8E, $00

Data_035_78D7:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $32, $18, $04, $3B, $9F, $02, $14, $1E, $15, $14
    db $17, $17, $01, $01, $00, $00, $00, $01, $03, $03, $03, $02, $03, $03, $03, $03
    db $03, $00, $01, $01, $03, $02, $03, $03, $03, $03, $00, $00, $00, $10, $02

Data_035_7906:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $46, $19, $40, $6C, $81, $02, $15, $1E, $18, $15
    db $17, $15, $02, $02, $01, $01, $01, $02, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $02, $02, $03, $03, $03, $03, $03, $03, $01, $01, $01, $58, $02

Data_035_7935:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $01, $00, $06, $01, $50, $1B, $0D, $3F, $8A, $03, $16, $1F, $18, $16
    db $18, $16, $02, $02, $02, $02, $01, $02, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $02, $02, $03, $03, $03, $03, $03, $03, $02, $02, $02, $84, $02

Data_035_7964:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $3C, $18, $04, $07, $85, $00, $13, $1E, $14, $15
    db $17, $17, $01, $01, $01, $01, $00, $01, $03, $03, $03, $02, $03, $03, $03, $03
    db $03, $01, $00, $00, $03, $02, $03, $03, $03, $03, $02, $00, $01, $1C, $02

Data_035_7993:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $01, $00, $06, $01, $46, $19, $3F, $40, $44, $01, $18, $1E, $18, $15
    db $17, $17, $01, $01, $01, $01, $01, $01, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $00, $00, $03, $03, $03, $03, $03, $03, $02, $01, $01, $44, $02

Data_035_79C2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $01, $00, $06, $01, $50, $1E, $38, $48, $66, $01, $19, $1F, $19, $11
    db $12, $16, $02, $02, $02, $01, $01, $02, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $01, $01, $03, $03, $03, $03, $03, $03, $02, $02, $02, $68, $02

Data_035_79F1:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $3C, $18, $07, $3F, $4B, $00, $14, $1E, $14, $14
    db $16, $15, $01, $01, $01, $02, $00, $02, $03, $03, $03, $02, $03, $03, $02, $02
    db $03, $01, $01, $01, $03, $03, $03, $03, $03, $03, $00, $00, $01, $1C, $02

Data_035_7A20:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $46, $19, $3E, $44, $83, $02, $18, $1E, $1A, $15
    db $17, $17, $01, $02, $03, $03, $01, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $02, $02, $02, $03, $03, $03, $03, $03, $03, $02, $01, $02, $84, $02

Data_035_7A4F:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $50, $1D, $40, $67, $8A, $05, $1A, $1E, $1D, $16
    db $17, $0C, $02, $02, $03, $03, $01, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $02, $02, $02, $03, $03, $03, $03, $03, $03, $02, $02, $02, $90, $02

Data_035_7A7E:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $46, $18, $3F, $40, $63, $03, $15, $1E, $1A, $15
    db $17, $17, $01, $01, $01, $01, $00, $02, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $00, $00, $03, $03, $03, $03, $03, $03, $02, $01, $01, $48, $02

Data_035_7AAD:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $50, $1D, $3E, $44, $83, $05, $1E, $1E, $1B, $12
    db $18, $15, $01, $01, $01, $01, $01, $02, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $02, $01, $01, $03, $03, $03, $03, $03, $03, $02, $01, $02, $74, $02

Data_035_7ADC:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $50, $1F, $63, $65, $67, $05, $1D, $1E, $1A, $18
    db $17, $17, $01, $02, $02, $02, $00, $01, $03, $03, $03, $03, $03, $03, $02, $02
    db $03, $01, $02, $01, $03, $02, $03, $03, $03, $03, $01, $01, $01, $58, $02

Data_035_7B0B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $46, $1E, $01, $07, $0D, $02, $15, $1E, $1A, $15
    db $17, $17, $02, $02, $02, $01, $02, $02, $03, $03, $03, $02, $03, $03, $03, $03
    db $03, $01, $01, $02, $03, $02, $03, $03, $03, $03, $01, $01, $01, $50, $02

Data_035_7B3A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $50, $1F, $40, $83, $89, $02, $1D, $1E, $1A, $15
    db $17, $17, $02, $02, $02, $00, $00, $00, $03, $03, $03, $03, $03, $03, $02, $02
    db $03, $01, $03, $01, $03, $03, $03, $03, $03, $03, $01, $01, $02, $60, $02

Data_035_7B69:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $3C, $1C, $40, $44, $73, $02, $15, $1E, $1A, $18
    db $17, $17, $00, $00, $00, $03, $00, $01, $03, $03, $03, $02, $03, $03, $02, $03
    db $03, $00, $03, $03, $03, $02, $03, $03, $03, $03, $00, $00, $01, $38, $02

Data_035_7B98:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $01, $00, $06, $01, $3C, $1B, $3E, $3F, $85, $02, $15, $1E, $1A, $15
    db $17, $17, $01, $02, $02, $01, $01, $02, $03, $03, $03, $02, $03, $03, $03, $03
    db $03, $01, $01, $02, $03, $02, $03, $03, $03, $03, $01, $00, $02, $48, $02

Data_035_7BC7:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $46, $1D, $40, $6F, $82, $03, $18, $1E, $1A, $15
    db $17, $17, $02, $02, $02, $02, $01, $02, $03, $03, $03, $03, $03, $03, $02, $02
    db $03, $01, $01, $02, $03, $02, $03, $03, $03, $03, $02, $01, $03, $6C, $02

Data_035_7BF6:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $01, $00, $06, $01, $50, $1F, $3E, $83, $8A, $01, $1D, $1E, $1E, $18
    db $17, $17, $03, $03, $03, $03, $02, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $02, $02, $03, $03, $03, $03, $03, $03, $03, $02, $03, $C0, $02

Data_035_7C25:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $50, $1E, $0D, $40, $44, $02, $1F, $1E, $1F, $18
    db $17, $17, $02, $02, $02, $02, $02, $03, $03, $03, $02, $02, $03, $03, $02, $03
    db $03, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03, $03, $02, $AC, $02

Data_035_7C54:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $41, $1E, $07, $6B, $8A, $02, $18, $19, $1A, $17
    db $16, $1F, $02, $02, $02, $02, $02, $02, $03, $03, $03, $02, $03, $03, $02, $02
    db $03, $01, $02, $02, $02, $03, $02, $01, $02, $02, $02, $02, $02, $6C, $02

Data_035_7C83:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $46, $1F, $3D, $83, $A0, $05, $1B, $1F, $1E, $17
    db $18, $1F, $03, $03, $03, $03, $02, $03, $03, $03, $03, $02, $03, $03, $02, $03
    db $03, $02, $02, $03, $03, $03, $03, $02, $01, $01, $01, $01, $02, $20, $03

Data_035_7CB2:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $06, $00, $3C, $1A, $04, $07, $68, $02, $17, $19, $12, $17
    db $0E, $11, $00, $02, $00, $00, $00, $01, $03, $03, $03, $02, $03, $03, $03, $02
    db $03, $02, $00, $01, $03, $03, $03, $03, $03, $03, $01, $00, $01, $24, $02

Data_035_7CE1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $07, $00, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $01, $01, $02, $02, $03, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00

Data_035_7D10:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $07, $00, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $03, $02, $02, $00, $00, $01, $01, $01, $02, $01, $00, $01, $01, $01
    db $00, $00, $03, $00, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00

Data_035_7D3F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $07, $00, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $01, $02, $01, $03, $00, $01, $02, $02, $03, $01, $01, $01, $00, $01
    db $00, $00, $01, $02, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00

Data_035_7D6E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $07, $00, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $01, $02, $02, $01, $02, $03, $03, $03, $03, $02, $02, $02, $02, $02
    db $01, $00, $01, $03, $02, $02, $02, $02, $02, $02, $02, $02, $01, $00, $00

Data_035_7D9D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $07, $00, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $02, $02, $02, $02, $03, $01, $01, $02, $02, $01
    db $01, $00, $03, $03, $02, $03, $02, $02, $01, $01, $02, $02, $01, $00, $00

Data_035_7DCC:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $07, $00, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $01, $01, $00, $00, $00, $00, $02, $02, $02, $02, $02, $02, $03, $03
    db $02, $02, $02, $02, $00, $00, $00, $01, $01, $01, $01, $01, $02, $00, $00

Data_035_7DFB:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $00, $00, $07, $01, $00, $00, $FF, $FF, $FF, $00, $00, $00, $00, $00
    db $00, $00, $02, $02, $02, $02, $01, $02, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $01, $02, $02, $03, $03, $03, $03, $03, $03, $02, $02, $02, $00, $00

Data_035_7E2A:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $02, $01, $00, $07, $01, $63, $1C, $19, $1B, $1E, $00, $14, $18, $13, $15
    db $12, $18, $01, $01, $01, $02, $02, $02, $03, $03, $03, $02, $03, $03, $01, $01
    db $02, $01, $01, $01, $02, $03, $03, $02, $01, $02, $02, $01, $02, $00, $00

Data_035_7E59:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $01, $00, $07, $01, $09, $1D, $40, $3D, $3F, $00, $1F, $1F, $1F, $1F
    db $1F, $1F, $02, $02, $02, $02, $02, $02, $02, $02, $03, $02, $02, $02, $02, $03
    db $02, $01, $02, $01, $03, $03, $03, $03, $03, $01, $02, $01, $01, $00, $00

Data_035_7E88:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $00, $01, $00, $07, $01, $63, $00, $3C, $3E, $85, $00, $17, $0F, $18, $10
    db $18, $09, $00, $00, $00, $00, $00, $00, $00, $03, $03, $01, $01, $03, $03, $01
    db $02, $01, $00, $00, $03, $03, $03, $03, $03, $03, $02
    ds $14D, $00
