SECTION "Bank 81", ROMX[$4000], BANK[$81]
    db $81

; only called from CallFunc4001InBank81KeepRegs (E-0047)
; 1 call site from 1 routine (e.g. CallFunc4001InBank81KeepRegs)
; reads: wRecordBufB, wSpeciesRecord, wAIWeights
; writes: wAIWeights, wSpeciesIdLo, wSpeciesIdHi, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, ...
CallFunc4001InBank81KeepRegs_Sub01::
Func_081_4001:: ; address name
    ld a, [wRecordBufB + $B]
    ld l, a
    ld a, [wRecordBufB + $C]
    ld h, a
    push hl
    ld a, l
    ld [wAIWeights], a
    ld a, h
    ld [wAIWeights + $1], a
    ld a, [wRecordBufB + $D]
    ld [wAIWeights + $6], a
    ld a, [wRecordBufB + $1A]
    ld l, a
    ld a, [wRecordBufB + $1B]
    ld h, a
    ld a, l
    ld [wAIWeights + $2], a
    ld a, h
    ld [wAIWeights + $3], a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    ld [wAIWeights + $7], a
    ld a, [wRecordBufB + $1C]
    ld l, a
    ld a, [wRecordBufB + $1D]
    ld h, a
    ld a, l
    ld [wAIWeights + $4], a
    ld a, h
    ld [wAIWeights + $5], a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesFamily
    ld a, [wSpeciesRecord]
    ld [wAIWeights + $8], a
    ld a, [wAIWeights]
    ld l, a
    ld a, [wAIWeights + $1]
    ld h, a
    add hl, hl
    ld a, l
    add a, $67
    ld l, a
    ld a, h
    adc a, $41
    ld h, a
    deref_hl
    push hl
    ld a, [wAIWeights + $2]
    ld e, a
    ld a, [wAIWeights + $3]
    ld d, a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ld a, [wAIWeights + $4]
    ld e, a
    ld a, [wAIWeights + $5]
    ld d, a
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a
    ld a, [wAIWeights + $7]
    ldh [hTemp4], a
    ld a, [wAIWeights + $8]
    ldh [hTemp5], a
    call CallFunc4001InBank81KeepRegs_Sub01_Sub01
    pop hl
    ld a, c
    or a, a
    jr z, Jump_081_40D8
    ld a, [wAIWeights + $4]
    ld e, a
    ld a, [wAIWeights + $5]
    ld d, a
    ld a, e
    ldh [hTemp0], a
    ld a, d
    ldh [hTemp1], a
    ld a, [wAIWeights + $2]
    ld e, a
    ld a, [wAIWeights + $3]
    ld d, a
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a
    ld a, [wAIWeights + $8]
    ldh [hTemp4], a
    ld a, [wAIWeights + $7]
    ldh [hTemp5], a
    call CallFunc4001InBank81KeepRegs_Sub01_Sub01
    ld a, c
    or a, a
    jr nz, Jump_081_40D8
    ld a, [wRecordBufB + $D]
    set 4, a
    ld [wRecordBufB + $D], a

Jump_081_40D8::
    pop hl
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    ret

; only called from CallFunc4001InBank81KeepRegs_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. CallFunc4001InBank81KeepRegs_Sub01)
; reads: hTemp0, hTemp1, hTemp5, hTemp2, hTemp3, wAIWeights
; points at: hTemp5
CallFunc4001InBank81KeepRegs_Sub01_Sub01::
Func_081_40E2:: ; address name
    ld a, [hl+]
    ld d, [hl]
    inc hl
    cp a, $FF
    jr z, Jump_081_40F4
    cp a, $00
    jr z, Jump_081_4116
    cp a, $01
    jp z, Jump_081_414C
    jr CallFunc4001InBank81KeepRegs_Sub01_Sub01

Jump_081_40F4::
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ld a, [wAIWeights]
    ld c, a
    ld a, [wAIWeights + $1]
    ld b, a
    call CompareHLToBC
    jr nz, Jump_081_4113
    ld a, [wAIWeights + $6]
    ld hl, hTemp5
    cp a, [hl]
    jr nz, Jump_081_4113

Jump_081_4110::
    ld c, $00
    ret

Jump_081_4113::
    ld c, $FF
    ret

Jump_081_4116::
    ld c, [hl]
    inc hl
    inc hl
    ld a, [wAIWeights + $6]
    cp a, c
    jr z, Jump_081_4126

Jump_081_411F::
    inc hl
    inc hl
    dec d
    jr nz, Jump_081_411F
    jr CallFunc4001InBank81KeepRegs_Sub01_Sub01

Jump_081_4126::
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    bit 7, b
    jr nz, Jump_081_4136
    ldh a, [hTemp5]
    cp a, c
    jp z, Jump_081_4110
    jr Jump_081_4146

Jump_081_4136::
    res 7, b
    push hl
    ldh a, [hTemp2]
    ld l, a
    ldh a, [hTemp3]
    ld h, a
    call CompareHLToBC
    pop hl
    jp z, Jump_081_4110

Jump_081_4146::
    dec d
    jr nz, Jump_081_4126
    jp CallFunc4001InBank81KeepRegs_Sub01_Sub01

Jump_081_414C::
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call CompareHLToBC
    pop hl
    jr z, Jump_081_4165

Jump_081_415D::
    inc hl
    inc hl
    dec d
    jr nz, Jump_081_415D
    jp CallFunc4001InBank81KeepRegs_Sub01_Sub01

Jump_081_4165::
    jr Jump_081_4126
    dw Data_081_43E9
    dw Data_081_43EB
    dw Data_081_43F3
    dw Data_081_43FB
    dw Data_081_4403
    dw Data_081_440B
    dw Data_081_4413
    dw Data_081_441B
    dw Data_081_4427
    dw Data_081_442F
    dw Data_081_4431
    dw Data_081_4433
    dw Data_081_4441
    dw Data_081_4453
    dw Data_081_4463
    dw Data_081_44A3
    dw Data_081_44AB
    dw Data_081_44D5
    dw Data_081_44DD
    dw Data_081_44E5
    dw Data_081_4525
    dw Data_081_4527
    dw Data_081_4529
    dw Data_081_452B
    dw Data_081_453F
    dw Data_081_4555
    dw Data_081_4557
    dw Data_081_4559
    dw Data_081_455B
    dw Data_081_455D
    dw Data_081_455F
    dw Data_081_4561
    dw Data_081_4569
    dw Data_081_4571
    dw Data_081_4579
    dw Data_081_4581
    dw Data_081_4589
    dw Data_081_4591
    dw Data_081_4599
    dw Data_081_45A1
    dw Data_081_45A3
    dw Data_081_45AB
    dw Data_081_45B3
    dw Data_081_45C1
    dw Data_081_45DD
    dw Data_081_45E5
    dw Data_081_45ED
    dw Data_081_466B
    dw Data_081_4673
    dw Data_081_4675
    dw Data_081_4677
    dw Data_081_4681
    dw Data_081_46A5
    dw Data_081_46AD
    dw Data_081_46B5
    dw Data_081_46F9
    dw Data_081_470D
    dw Data_081_471D
    dw Data_081_4725
    dw Data_081_4727
    dw Data_081_472F
    dw Data_081_4731
    dw Data_081_4739
    dw Data_081_4741
    dw Data_081_4749
    dw Data_081_4751
    dw Data_081_4759
    dw Data_081_480D
    dw Data_081_4815
    dw Data_081_4823
    dw Data_081_4825
    dw Data_081_482D
    dw Data_081_4867
    dw Data_081_486F
    dw Data_081_4877
    dw Data_081_487F
    dw Data_081_4893
    dw Data_081_48DB
    dw Data_081_48DD
    dw Data_081_48DF
    dw Data_081_48E1
    dw Data_081_48E9
    dw Data_081_48F1
    dw Data_081_4923
    dw Data_081_492D
    dw Data_081_493B
    dw Data_081_4987
    dw Data_081_49A5
    dw Data_081_49AD
    dw Data_081_49B5
    dw Data_081_49BD
    dw Data_081_49BF
    dw Data_081_49C7
    dw Data_081_49CF
    dw Data_081_49D7
    dw Data_081_49DF
    dw Data_081_49E7
    dw Data_081_49EF
    dw Data_081_49F7
    dw Data_081_49FF
    dw Data_081_4A01
    dw Data_081_4A09
    dw Data_081_4A0B
    dw Data_081_4A0D
    dw Data_081_4A15
    dw Data_081_4A1D
    dw Data_081_4A45
    dw Data_081_4A53
    dw Data_081_4A55
    dw Data_081_4A73
    dw Data_081_4A89
    dw Data_081_4AA3
    dw Data_081_4AA5
    dw Data_081_4AFD
    dw Data_081_4B05
    dw Data_081_4B0D
    dw Data_081_4B0F
    dw Data_081_4B11
    dw Data_081_4B13
    dw Data_081_4B15
    dw Data_081_4B17
    dw Data_081_4B19
    dw Data_081_4B21
    dw Data_081_4B29
    dw Data_081_4B31
    dw Data_081_4B39
    dw Data_081_4B41
    dw Data_081_4B49
    dw Data_081_4B51
    dw Data_081_4B59
    dw Data_081_4B5B
    dw Data_081_4B63
    dw Data_081_4B6B
    dw Data_081_4B79
    dw Data_081_4B81
    dw Data_081_4B83
    dw Data_081_4B91
    dw Data_081_4B9F
    dw Data_081_4BA7
    dw Data_081_4BBD
    dw Data_081_4BC5
    dw Data_081_4BCD
    dw Data_081_4BCF
    dw Data_081_4BD7
    dw Data_081_4BD9
    dw Data_081_4BDB
    dw Data_081_4BDD
    dw Data_081_4BDF
    dw Data_081_4BE1
    dw Data_081_4BE3
    dw Data_081_4BE5
    dw Data_081_4BE7
    dw Data_081_4BEF
    dw Data_081_4BF7
    dw Data_081_4BFF
    dw Data_081_4C07
    dw Data_081_4C0F
    dw Data_081_4C17
    dw Data_081_4C1F
    dw Data_081_4C27
    dw Data_081_4C29
    dw Data_081_4C31
    dw Data_081_4C33
    dw Data_081_4C41
    dw Data_081_4C55
    dw Data_081_4C63
    dw Data_081_4C71
    dw Data_081_4C9D
    dw Data_081_4CA5
    dw Data_081_4CB9
    dw Data_081_4CBB
    dw Data_081_4CBD
    dw Data_081_4CCB
    dw Data_081_4CCD
    dw Data_081_4CD5
    dw Data_081_4CDD
    dw Data_081_4CDF
    dw Data_081_4CE1
    dw Data_081_4CE3
    dw Data_081_4CE5
    dw Data_081_4CE7
    dw Data_081_4CE9
    dw Data_081_4CF1
    dw Data_081_4D59
    dw Data_081_4D73
    dw Data_081_4D7B
    dw Data_081_4D83
    dw Data_081_4D8B
    dw Data_081_4D93
    dw Data_081_4D9B
    dw Data_081_4D9D
    dw Data_081_4DB1
    dw Data_081_4DB9
    dw Data_081_4DD3
    dw Data_081_4DE1
    dw Data_081_4DEF
    dw Data_081_4DF7
    dw Data_081_4E29
    dw Data_081_4E7F
    dw Data_081_4E87
    dw Data_081_4E89
    dw Data_081_4EA9
    dw Data_081_4EB7
    dw Data_081_4EBF
    dw Data_081_4EC1
    dw Data_081_4EDB
    dw Data_081_4EEF
    dw Data_081_4F09
    dw Data_081_4F17
    dw Data_081_4F25
    dw Data_081_4F27
    dw Data_081_4F29
    dw Data_081_4F31
    dw Data_081_4F6F
    dw Data_081_4F77
    dw Data_081_4F7F
    dw Data_081_4F87
    dw Data_081_4F8F
    dw Data_081_4F97
    dw Data_081_4F9F
    dw Data_081_4FA1
    dw Data_081_4FA9
    dw Data_081_4FC3
    dw Data_081_4FD7
    dw Data_081_4FE5
    dw Data_081_4FF9
    dw Data_081_4FFB
    dw Data_081_4FFD
    dw Data_081_4FFF
    dw Data_081_504D
    dw Data_081_50B5
    dw Data_081_50F3
    dw Data_081_5159
    dw Data_081_5167
    dw Data_081_5169
    dw Data_081_516B
    dw Data_081_5197
    dw Data_081_5199
    dw Data_081_519B
    dw Data_081_519D
    dw Data_081_519F
    dw Data_081_51A1
    dw Data_081_51A9
    dw Data_081_51B1
    dw Data_081_51B9
    dw Data_081_51C1
    dw Data_081_51C9
    dw Data_081_51D1
    dw Data_081_51D9
    dw Data_081_51E1
    dw Data_081_51E3
    dw Data_081_51EB
    dw Data_081_520B
    dw Data_081_5255
    dw Data_081_5269
    dw Data_081_52A1
    dw Data_081_52AF
    dw Data_081_52B1
    dw Data_081_52D5
    dw Data_081_52D7
    dw Data_081_52E5
    dw Data_081_5317
    dw Data_081_5327
    dw Data_081_5337
    dw Data_081_5345
    dw Data_081_5347
    dw Data_081_534F
    dw Data_081_5357
    dw Data_081_5367
    dw Data_081_5375
    dw Data_081_537D
    dw Data_081_537F
    dw Data_081_5381
    dw Data_081_5383
    dw Data_081_5385
    dw Data_081_5387
    dw Data_081_5389
    dw Data_081_538B
    dw Data_081_538D
    dw Data_081_538F
    dw Data_081_5391
    dw Data_081_5393
    dw Data_081_5395
    dw Data_081_5397
    dw Data_081_5399
    dw Data_081_539B
    dw Data_081_539D
    dw Data_081_539F
    dw Data_081_53A1
    dw Data_081_53A3
    dw Data_081_53A5
    dw Data_081_53A7
    dw Data_081_53A9
    dw Data_081_53AB
    dw Data_081_53AD
    dw Data_081_53AF
    dw Data_081_53B1
    dw Data_081_53B3
    dw Data_081_53B5
    dw Data_081_53B7
    dw Data_081_53B9
    dw Data_081_53BB
    dw Data_081_53C5
    dw Data_081_53CD
    dw Data_081_53CF
    dw Data_081_53D7
    dw Data_081_53DF
    dw Data_081_53E1
    dw Data_081_53E9
    dw Data_081_53F7
    dw Data_081_53F9
    dw Data_081_5401
    dw Data_081_5403
    dw Data_081_540B
    dw Data_081_5413
    dw Data_081_541B
    dw Data_081_5423
    dw Data_081_5439
    dw Data_081_5441
    dw Data_081_5449
    dw Data_081_5451

Data_081_43E9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_081_43EB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $01, $00, $FF, $00

Data_081_43F3:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $02, $00, $FF, $00

Data_081_43FB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $03, $00, $FF, $00

Data_081_4403:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $04, $00, $FF, $00

Data_081_440B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $05, $00, $FF, $00

Data_081_4413:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $06, $00, $FF, $00

Data_081_441B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $03, $00, $00, $07, $00, $BE, $80, $2A, $80, $FF, $00

Data_081_4427:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $08, $00, $FF, $00

Data_081_442F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_4431:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_4433:: ; heuristic: target of a monotone pointer table; C0
    db $00, $04, $00, $00, $4A, $80, $80, $80, $8D, $80, $0D, $81, $FF, $00

Data_081_4441:: ; heuristic: target of a monotone pointer table; C0
    db $00, $06, $00, $00, $48, $80, $62, $80, $60, $80, $4C, $80, $61, $80, $5F, $80
    db $FF, $00

Data_081_4453:: ; heuristic: target of a monotone pointer table; C0
    db $00, $05, $00, $00, $33, $81, $32, $81, $FC, $80, $C7, $80, $34, $81, $FF, $00

Data_081_4463:: ; heuristic: target of a monotone pointer table; C0
    db $01, $05, $0D, $00, $38, $80, $3E, $80, $2B, $80, $37, $80, $3D, $80, $01, $05
    db $06, $00, $38, $80, $3E, $80, $2B, $80, $37, $80, $3D, $80, $01, $05, $01, $00
    db $38, $80, $3E, $80, $2B, $80, $37, $80, $3D, $80, $01, $05, $12, $00, $38, $80
    db $3E, $80, $2B, $80, $37, $80, $3D, $80, $00, $01, $00, $00, $29, $81, $FF, $00

Data_081_44A3:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $4D, $80, $FF, $00

Data_081_44AB:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $0A, $00, $0A, $80, $00, $01, $00, $00, $0A, $00, $01, $0C, $0E, $00
    db $EA, $80, $60, $80, $38, $80, $7D, $80, $07, $81, $40, $80, $EB, $80, $3D, $80
    db $79, $80, $5C, $80, $7F, $80, $08, $81, $FF, $00

Data_081_44D5:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $00, $00, $24, $81, $FF, $00

Data_081_44DD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $11, $00, $11, $80, $FF, $00

Data_081_44E5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0C, $10, $00, $EA, $80, $60, $80, $38, $80, $7D, $80, $07, $81, $40, $80
    db $EB, $80, $3D, $80, $79, $80, $5C, $80, $7F, $80, $08, $81, $01, $0C, $17, $00
    db $EA, $80, $60, $80, $38, $80, $7D, $80, $07, $81, $40, $80, $EB, $80, $3D, $80
    db $79, $80, $5C, $80, $7F, $80, $08, $81, $01, $01, $02, $00, $02, $80, $FF, $00

Data_081_4525:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_4527:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_4529:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_452B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $10, $00, $24, $81, $01, $01, $13, $00, $24, $81, $01, $01, $12, $00
    db $12, $80, $FF, $00

Data_081_453F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $10, $00, $35, $81, $01, $01, $13, $00, $35, $81, $01, $02, $17, $00
    db $35, $81, $17, $80, $FF, $00

Data_081_4555:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_4557:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_4559:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_455B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_455D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_455F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $00

Data_081_4561:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $00, $00, $FF, $01

Data_081_4569:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $02, $00, $FF, $01

Data_081_4571:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $03, $00, $FF, $01

Data_081_4579:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $04, $00, $FF, $01

Data_081_4581:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $05, $00, $FF, $01

Data_081_4589:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $06, $00, $FF, $01

Data_081_4591:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $07, $00, $FF, $01

Data_081_4599:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $08, $00, $FF, $01

Data_081_45A1:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $01

Data_081_45A3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $1F, $00, $24, $80, $FF, $01

Data_081_45AB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $6A, $80, $FF, $01

Data_081_45B3:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $4C, $80, $01, $01, $22, $00, $02, $00, $FF, $01

Data_081_45C1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $79, $80, $01, $08, $24, $00, $E0, $80, $EA, $80, $62, $80
    db $E3, $80, $9B, $80, $5F, $80, $03, $80, $DF, $80, $FF, $01

Data_081_45DD:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $23, $81, $FF, $01

Data_081_45E5:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $BA, $80, $FF, $01

Data_081_45ED:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2045ED, $7E

Data_081_466B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $07, $80, $FF, $01

Data_081_4673:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $01

Data_081_4675:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $01

Data_081_4677:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $01, $00, $C0, $80, $C7, $80, $FF, $01

Data_081_4681:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $28, $00, $2D, $80, $01, $01, $1F, $00, $24, $80, $00, $09, $01, $00
    db $EA, $80, $10, $80, $7D, $80, $EB, $80, $3D, $80, $13, $80, $17, $80, $5C, $80
    db $7F, $80, $FF, $01

Data_081_46A5:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $75, $80, $FF, $01

Data_081_46AD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $34, $00, $39, $80, $FF, $01

Data_081_46B5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2046B5, $44

Data_081_46F9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $2E, $00, $D4, $80, $01, $01, $33, $00, $D4, $80, $00, $01, $01, $00
    db $0A, $00, $FF, $01

Data_081_470D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $05, $01, $00, $E8, $80, $E2, $80, $60, $80, $EC, $80, $DF, $80, $FF, $01

Data_081_471D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $01, $00, $7C, $80, $FF, $01

Data_081_4725:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $01

Data_081_4727:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $39, $00, $3C, $80, $FF, $01

Data_081_472F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $01

Data_081_4731:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $00, $00, $FF, $02

Data_081_4739:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $01, $00, $FF, $02

Data_081_4741:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $03, $00, $FF, $02

Data_081_4749:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $04, $00, $FF, $02

Data_081_4751:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $05, $00, $FF, $02

Data_081_4759:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $204759, $B4

Data_081_480D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $07, $00, $FF, $02

Data_081_4815:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $3F, $00, $03, $00, $00, $01, $02, $00, $08, $00, $FF, $02

Data_081_4823:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02

Data_081_4825:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $41, $00, $01, $00, $FF, $02

Data_081_482D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0C, $42, $00, $19, $81, $DD, $80, $9B, $80, $04, $80, $0C, $80, $2F, $80
    db $80, $80, $D6, $80, $8D, $80, $0D, $81, $2F, $81, $B6, $80, $01, $0C, $3D, $00
    db $19, $81, $DD, $80, $9B, $80, $04, $80, $0C, $80, $2F, $80, $80, $80, $D6, $80
    db $8D, $80, $0D, $81, $2F, $81, $B6, $80, $FF, $02

Data_081_4867:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $25, $80, $FF, $02

Data_081_486F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $6E, $80, $FF, $02

Data_081_4877:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $96, $80, $FF, $02

Data_081_487F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $07, $02, $00, $33, $81, $29, $81, $32, $81, $2E, $81, $24, $81, $2D, $81
    db $06, $00, $FF, $02

Data_081_4893:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $204893, $48

Data_081_48DB:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02

Data_081_48DD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02

Data_081_48DF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02

Data_081_48E1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $26, $81, $FF, $02

Data_081_48E9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $32, $80, $FF, $02

Data_081_48F1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $4C, $00, $00, $00, $01, $01, $54, $00, $00, $00, $01, $01, $4B, $00
    db $00, $00, $01, $01, $53, $00, $00, $00, $01, $01, $42, $00, $00, $00, $01, $01
    db $55, $00, $00, $00, $01, $01, $3D, $00, $00, $00, $00, $01, $02, $00, $0C, $80
    db $FF, $02

Data_081_4923:: ; heuristic: target of a monotone pointer table; C0
    db $00, $02, $02, $00, $01, $80, $29, $80, $FF, $02

Data_081_492D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $3E, $00, $01, $00, $00, $01, $02, $00, $6F, $80, $FF, $02

Data_081_493B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20493B, $4C

Data_081_4987:: ; heuristic: target of a monotone pointer table; C0
    db $01, $06, $01, $01, $62, $80, $51, $80, $4C, $80, $61, $80, $5F, $80, $5C, $80
    db $01, $04, $55, $00, $35, $81, $5F, $80, $25, $81, $24, $81, $FF, $02

Data_081_49A5:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $0A, $00, $FF, $02

Data_081_49AD:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $2D, $80, $FF, $02

Data_081_49B5:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $02, $00, $D8, $80, $FF, $02

Data_081_49BD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02

Data_081_49BF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $00, $00, $FF, $03

Data_081_49C7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $01, $00, $FF, $03

Data_081_49CF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $02, $00, $FF, $03

Data_081_49D7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $04, $00, $FF, $03

Data_081_49DF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $05, $00, $FF, $03

Data_081_49E7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $06, $00, $FF, $03

Data_081_49EF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $07, $00, $FF, $03

Data_081_49F7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $08, $00, $FF, $03

Data_081_49FF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4A01:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $5B, $00, $00, $00, $FF, $03

Data_081_4A09:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4A0B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4A0D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $0D, $80, $FF, $03

Data_081_4A15:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $5D, $00, $02, $00, $FF, $03

Data_081_4A1D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $5C, $00, $07, $00, $01, $00, $01, $02, $6D, $00, $07, $00, $01, $00
    db $01, $02, $6A, $00, $07, $00, $01, $00, $01, $02, $69, $00, $07, $00, $01, $00
    db $00, $01, $03, $00, $BF, $80, $FF, $03

Data_081_4A45:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $68, $00, $06, $00, $00, $01, $03, $00, $1C, $81, $FF, $03

Data_081_4A53:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4A55:: ; heuristic: target of a monotone pointer table; C0
    db $00, $0C, $03, $00, $56, $80, $0A, $81, $5D, $80, $07, $81, $51, $80, $F7, $80
    db $5F, $80, $12, $80, $2E, $81, $0B, $81, $11, $80, $08, $81, $FF, $03

Data_081_4A73:: ; heuristic: target of a monotone pointer table; C0
    db $00, $08, $03, $00, $DE, $80, $52, $80, $2C, $81, $55, $80, $4C, $80, $01, $80
    db $0D, $81, $2D, $81, $FF, $03

Data_081_4A89:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $6D, $00, $2C, $81, $01, $01, $6A, $00, $2C, $81, $01, $01, $70, $00
    db $2C, $81, $00, $01, $03, $00, $0A, $00, $FF, $03

Data_081_4AA3:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4AA5:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $204AA5, $58

Data_081_4AFD:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $03, $00, $98, $80, $FF, $03

Data_081_4B05:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $6C, $00, $7C, $80, $FF, $03

Data_081_4B0D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4B0F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4B11:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4B13:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4B15:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4B17:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $03

Data_081_4B19:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $00, $00, $FF, $04

Data_081_4B21:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $01, $00, $FF, $04

Data_081_4B29:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $03, $00, $FF, $04

Data_081_4B31:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $02, $00, $FF, $04

Data_081_4B39:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $05, $00, $FF, $04

Data_081_4B41:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $06, $00, $FF, $04

Data_081_4B49:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $07, $00, $FF, $04

Data_081_4B51:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $08, $00, $FF, $04

Data_081_4B59:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4B5B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $80, $00, $02, $00, $FF, $04

Data_081_4B63:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $B2, $80, $FF, $04

Data_081_4B6B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $79, $00, $02, $00, $00, $01, $04, $00, $1D, $81, $FF, $04

Data_081_4B79:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $D3, $80, $FF, $04

Data_081_4B81:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4B83:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $88, $00, $01, $00, $00, $01, $04, $00, $01, $81, $FF, $04

Data_081_4B91:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $84, $00, $06, $00, $00, $01, $04, $00, $80, $80, $FF, $04

Data_081_4B9F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $4A, $80, $FF, $04

Data_081_4BA7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $08, $04, $00, $1F, $81, $D8, $80, $B3, $80, $D7, $80, $0D, $80, $6E, $80
    db $63, $80, $BD, $80, $FF, $04

Data_081_4BBD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $8A, $00, $9E, $80, $FF, $04

Data_081_4BC5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $8B, $00, $9F, $80, $FF, $04

Data_081_4BCD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BCF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $04, $00, $0A, $00, $FF, $04

Data_081_4BD7:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BD9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BDB:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BDD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BDF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BE1:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BE3:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BE5:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $04

Data_081_4BE7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $00, $00, $FF, $05

Data_081_4BEF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $01, $00, $FF, $05

Data_081_4BF7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $02, $00, $FF, $05

Data_081_4BFF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $03, $00, $FF, $05

Data_081_4C07:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $04, $00, $FF, $05

Data_081_4C0F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $06, $00, $FF, $05

Data_081_4C17:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $07, $00, $FF, $05

Data_081_4C1F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $08, $00, $FF, $05

Data_081_4C27:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4C29:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $97, $00, $00, $00, $FF, $05

Data_081_4C31:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4C33:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $9B, $00, $04, $00, $00, $01, $05, $00, $8F, $80, $FF, $05

Data_081_4C41:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $9C, $00, $08, $00, $01, $01, $A6, $00, $01, $00, $00, $01, $05, $00
    db $52, $80, $FF, $05

Data_081_4C55:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $98, $00, $02, $00, $00, $01, $05, $00, $94, $80, $FF, $05

Data_081_4C63:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $9A, $00, $06, $00, $00, $01, $05, $00, $4B, $80, $FF, $05

Data_081_4C71:: ; heuristic: target of a monotone pointer table; C0
    db $01, $03, $9A, $00, $B3, $80, $BB, $80, $BD, $80, $01, $03, $A2, $00, $B3, $80
    db $BB, $80, $BD, $80, $01, $03, $A4, $00, $B3, $80, $BB, $80, $BD, $80, $01, $01
    db $9D, $00, $00, $00, $00, $01, $05, $00, $F6, $80, $FF, $05

Data_081_4C9D:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $FB, $80, $FF, $05

Data_081_4CA5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $A6, $00, $07, $00, $01, $01, $A4, $00, $07, $00, $00, $01, $05, $00
    db $5B, $80, $FF, $05

Data_081_4CB9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CBB:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CBD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $9E, $00, $B7, $80, $01, $01, $A3, $00, $06, $00, $FF, $05

Data_081_4CCB:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CCD:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $AB, $00, $C4, $80, $FF, $05

Data_081_4CD5:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $05, $00, $0A, $00, $FF, $05

Data_081_4CDD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CDF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CE1:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CE3:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CE5:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CE7:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $05

Data_081_4CE9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $00, $00, $FF, $06

Data_081_4CF1:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $204CF1, $68

Data_081_4D59:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $BF, $00, $01, $00, $01, $01, $BB, $00, $01, $00, $01, $01, $BC, $00
    db $01, $00, $01, $01, $C0, $00, $01, $00, $FF, $06

Data_081_4D73:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $03, $00, $FF, $06

Data_081_4D7B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $04, $00, $FF, $06

Data_081_4D83:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $05, $00, $FF, $06

Data_081_4D8B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $07, $00, $FF, $06

Data_081_4D93:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $08, $00, $FF, $06

Data_081_4D9B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $06

Data_081_4D9D:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $BA, $00, $00, $00, $01, $01, $B5, $00, $00, $00, $01, $01, $B8, $00
    db $00, $00, $FF, $06

Data_081_4DB1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $02, $00, $FF, $06

Data_081_4DB9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $BF, $00, $07, $00, $01, $01, $B9, $00, $07, $00, $01, $01, $BE, $00
    db $07, $00, $00, $01, $06, $00, $01, $00, $FF, $06

Data_081_4DD3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $B6, $00, $07, $00, $00, $01, $06, $00, $29, $80, $FF, $06

Data_081_4DE1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $B6, $00, $02, $00, $00, $01, $06, $00, $61, $80, $FF, $06

Data_081_4DEF:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $9D, $80, $FF, $06

Data_081_4DF7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $04, $CC, $00, $29, $81, $4C, $80, $C7, $80, $5C, $80, $01, $04, $C8, $00
    db $29, $81, $4C, $80, $C7, $80, $5C, $80, $01, $04, $B7, $00, $29, $81, $4C, $80
    db $C7, $80, $5C, $80, $01, $01, $C5, $00, $01, $00, $00, $01, $06, $00, $54, $80
    db $FF, $06

Data_081_4E29:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $204E29, $56

Data_081_4E7F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $BE, $00, $DC, $80, $FF, $06

Data_081_4E87:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $06

Data_081_4E89:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $BF, $00, $02, $00, $01, $01, $BB, $00, $02, $00, $01, $01, $BC, $00
    db $02, $00, $01, $01, $C0, $00, $02, $00, $00, $01, $06, $00, $2F, $80, $FF, $06

Data_081_4EA9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $B6, $00, $E3, $80, $01, $01, $C8, $00, $E6, $80, $FF, $06

Data_081_4EB7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $06, $00, $20, $81, $FF, $06

Data_081_4EBF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $06

Data_081_4EC1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $BB, $00, $07, $00, $01, $01, $BC, $00, $07, $00, $01, $01, $C0, $00
    db $07, $00, $00, $01, $06, $00, $63, $80, $FF, $06

Data_081_4EDB:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $B6, $00, $01, $00, $01, $01, $C4, $00, $02, $00, $01, $01, $C5, $00
    db $02, $00, $FF, $06

Data_081_4EEF:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $B6, $00, $08, $00, $01, $01, $C4, $00, $08, $00, $01, $01, $C5, $00
    db $08, $00, $00, $01, $06, $00, $BC, $80, $FF, $06

Data_081_4F09:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $C9, $00, $81, $80, $01, $01, $72, $00, $E6, $80, $FF, $06

Data_081_4F17:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $0D, $01, $EB, $80, $01, $01, $CD, $00, $35, $81, $FF, $06

Data_081_4F25:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $06

Data_081_4F27:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $06

Data_081_4F29:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $00, $00, $FF, $07

Data_081_4F31:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $E7, $00, $01, $00, $01, $01, $E4, $00, $01, $00, $01, $01, $D4, $00
    db $01, $00, $01, $01, $E6, $00, $01, $00, $01, $01, $E5, $00, $01, $00, $00, $07
    db $07, $00, $33, $80, $38, $80, $40, $80, $2B, $80, $3D, $80, $3C, $80, $30, $80
    db $00, $04, $01, $00, $07, $81, $F7, $80, $0B, $81, $08, $81, $FF, $07

Data_081_4F6F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $02, $00, $FF, $07

Data_081_4F77:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $03, $00, $FF, $07

Data_081_4F7F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $04, $00, $FF, $07

Data_081_4F87:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $05, $00, $FF, $07

Data_081_4F8F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $06, $00, $FF, $07

Data_081_4F97:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $08, $00, $FF, $07

Data_081_4F9F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_4FA1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $D3, $00, $02, $00, $FF, $07

Data_081_4FA9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $0A, $07, $00, $56, $80, $B0, $80, $0C, $80, $98, $80, $BF, $80, $80, $80
    db $47, $80, $08, $80, $8D, $80, $B6, $80, $FF, $07

Data_081_4FC3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $EB, $00, $06, $00, $01, $01, $D8, $00, $06, $00, $00, $01, $07, $00
    db $71, $80, $FF, $07

Data_081_4FD7:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $07, $00, $4E, $80, $01, $01, $D6, $00, $03, $00, $FF, $07

Data_081_4FE5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $DC, $00, $06, $00, $01, $01, $D3, $00, $06, $00, $00, $01, $07, $00
    db $B4, $80, $FF, $07

Data_081_4FF9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_4FFB:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_4FFD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_4FFF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $204FFF, $4E

Data_081_504D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20504D, $68

Data_081_50B5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $DC, $00, $78, $80, $DD, $80, $0D, $80, $0E, $80, $8F, $80, $C4, $80
    db $77, $80, $01, $07, $D9, $00, $78, $80, $DD, $80, $0D, $80, $0E, $80, $8F, $80
    db $C4, $80, $77, $80, $01, $07, $D7, $00, $78, $80, $DD, $80, $0D, $80, $0E, $80
    db $8F, $80, $C4, $80, $77, $80, $01, $01, $DC, $00, $FF, $80, $FF, $07

Data_081_50F3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $2050F3, $66

Data_081_5159:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $E7, $00, $0A, $81, $01, $01, $E5, $00, $06, $00, $FF, $07

Data_081_5167:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_5169:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_516B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $E7, $00, $03, $00, $01, $01, $E4, $00, $03, $00, $01, $01, $D9, $00
    db $03, $00, $01, $01, $D4, $00, $03, $00, $01, $01, $E6, $00, $03, $00, $01, $01
    db $DD, $00, $03, $00, $00, $01, $07, $00, $01, $00, $FF, $07

Data_081_5197:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_5199:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_519B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_519D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_519F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $07

Data_081_51A1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $00, $00, $FF, $08

Data_081_51A9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $01, $00, $FF, $08

Data_081_51B1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $02, $00, $FF, $08

Data_081_51B9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $03, $00, $FF, $08

Data_081_51C1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $04, $00, $FF, $08

Data_081_51C9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $05, $00, $FF, $08

Data_081_51D1:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $06, $00, $FF, $08

Data_081_51D9:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $08, $00, $07, $00, $FF, $08

Data_081_51E1:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $08

Data_081_51E3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $F1, $00, $00, $00, $FF, $08

Data_081_51EB:: ; heuristic: target of a monotone pointer table; C0
    db $01, $04, $0B, $01, $0D, $80, $05, $80, $06, $80, $01, $80, $01, $04, $0A, $01
    db $0D, $80, $05, $80, $06, $80, $01, $80, $00, $01, $08, $00, $B6, $80, $FF, $08

Data_081_520B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $20520B, $4A

Data_081_5255:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $06, $01, $06, $00, $01, $01, $05, $01, $06, $00, $00, $01, $08, $00
    db $0A, $00, $FF, $08

Data_081_5269:: ; heuristic: target of a monotone pointer table; C0
    db $01, $04, $0B, $01, $78, $80, $7C, $80, $80, $80, $77, $80, $01, $04, $F2, $00
    db $78, $80, $7C, $80, $80, $80, $77, $80, $01, $04, $0A, $01, $78, $80, $7C, $80
    db $80, $80, $77, $80, $01, $04, $FB, $00, $78, $80, $7C, $80, $80, $80, $77, $80
    db $00, $01, $08, $00, $B5, $80, $FF, $08

Data_081_52A1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $01, $01, $03, $00, $00, $01, $08, $00, $90, $80, $FF, $08

Data_081_52AF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $08

Data_081_52B1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $08, $FE, $00, $E2, $80, $0A, $81, $38, $80, $E6, $80, $07, $81, $0E, $80
    db $EC, $80, $5C, $80, $00, $05, $08, $00, $60, $80, $55, $80, $D9, $80, $4C, $80
    db $5F, $80, $FF, $08

Data_081_52D5:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $08

Data_081_52D7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $04, $01, $06, $00, $00, $01, $08, $00, $05, $80, $FF, $08

Data_081_52E5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $06, $F7, $00, $9E, $80, $8E, $80, $6B, $80, $01, $80, $7C, $80, $71, $80
    db $01, $06, $F3, $00, $9E, $80, $8E, $80, $6B, $80, $01, $80, $7C, $80, $71, $80
    db $01, $06, $FA, $00, $9E, $80, $8E, $80, $6B, $80, $01, $80, $7C, $80, $71, $80
    db $FF, $08

Data_081_5317:: ; heuristic: target of a monotone pointer table; C0
    db $01, $05, $FC, $00, $DE, $80, $60, $80, $7D, $80, $EB, $80, $3C, $80, $FF, $08

Data_081_5327:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $01, $01, $60, $80, $01, $02, $FC, $00, $F7, $80, $08, $81, $FF, $08

Data_081_5337:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $01, $01, $07, $00, $00, $01, $08, $00, $08, $80, $FF, $08

Data_081_5345:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $08

Data_081_5347:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $FA, $00, $22, $81, $FF, $08

Data_081_534F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $09, $01, $31, $81, $FF, $08

Data_081_5357:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $0A, $01, $32, $81, $00, $02, $08, $00, $C7, $80, $C4, $80, $FF, $08

Data_081_5367:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $01, $01, $05, $00, $01, $01, $F6, $00, $1E, $81, $FF, $08

Data_081_5375:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $06, $01, $2D, $81, $FF, $08

Data_081_537D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $08

Data_081_537F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5381:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5383:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5385:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5387:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5389:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_538B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_538D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_538F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5391:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5393:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5395:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5397:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_5399:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_539B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_539D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_539F:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53A1:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53A3:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53A5:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53A7:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53A9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53AB:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53AD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53AF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53B1:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53B3:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53B5:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53B7:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53B9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $09

Data_081_53BB:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $E8, $00, $33, $80, $38, $80, $FF, $0A

Data_081_53C5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $2D, $01, $40, $80, $FF, $0A

Data_081_53CD:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $0A

Data_081_53CF:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $E5, $00, $17, $80, $FF, $0A

Data_081_53D7:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $CF, $00, $A2, $80, $FF, $0A

Data_081_53DF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $0A

Data_081_53E1:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $30, $01, $3C, $80, $FF, $0A

Data_081_53E9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $2D, $01, $65, $81, $01, $01, $2E, $01, $65, $81, $FF, $0A

Data_081_53F7:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $0A

Data_081_53F9:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $D0, $00, $40, $80, $FF, $0A

Data_081_5401:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $0A

Data_081_5403:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $36, $01, $60, $80, $FF, $0A

Data_081_540B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $38, $01, $18, $80, $FF, $0A

Data_081_5413:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $39, $01, $37, $80, $FF, $0A

Data_081_541B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $33, $01, $61, $80, $FF, $0A

Data_081_5423:: ; heuristic: target of a monotone pointer table; C0
    db $01, $02, $34, $01, $6B, $81, $6C, $81, $01, $01, $39, $01, $66, $81, $01, $01
    db $3A, $01, $66, $81, $FF, $0A

Data_081_5439:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $3C, $01, $C6, $80, $FF, $0A

Data_081_5441:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $3D, $01, $6D, $81, $FF, $0A

Data_081_5449:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $3E, $01, $A5, $80, $FF, $0A

Data_081_5451:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $0A

; copies three bytes of table $555D entry ($5486[wD0A6] * $129 + 3 * (wD0E8 - 1)) to wD0EA (E-0121)
; 1 call site from 1 routine (e.g. UnpackLinkRecordToWorkBuf)
; reads: wWorkBuf, wLinkMenuEntry
; points at: wLinkMenuEntryBytes
LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes::
Func_081_5453:: ; address name
    ld a, [wWorkBuf + $9]
    ld l, a
    ld h, $00
    ld a, l
    add a, $86
    ld l, a
    ld a, h
    adc a, $54
    ld h, a
    ld a, [hl]
    ld bc, $0129
    call Multiply8By16
    ld a, [wLinkMenuEntry]
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, l
    add a, $5D
    ld l, a
    ld a, h
    adc a, $55
    ld h, a
    ld de, wLinkMenuEntryBytes
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret

; E-0151 (C1: LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes reads the byte $5486 + wWorkBuf+9 and uses it as the row of the $129-byte table at $555D; 215 bytes up to that table, values 0-31).
; record: row of ExpTable81 (0-31)
ExpCurveIndex81::
Data_081_5486:: ; heuristic: start of a structured table; C0
    db $0D ; id 0
    db $0A ; id 1
    db $0A ; id 2
    db $0B ; id 3
    db $08 ; id 4
    db $0F ; id 5
    db $0C ; id 6
    db $0B ; id 7
    db $10 ; id 8
    db $0B ; id 9
    db $0A ; id 10
    db $0B ; id 11
    db $0B ; id 12
    db $0A ; id 13
    db $09 ; id 14
    db $0C ; id 15
    db $19 ; id 16
    db $1B ; id 17
    db $1D ; id 18
    db $1F ; id 19
    db $07 ; id 20
    db $11 ; id 21
    db $10 ; id 22
    db $12 ; id 23
    db $0F ; id 24
    db $14 ; id 25
    db $13 ; id 26
    db $14 ; id 27
    db $14 ; id 28
    db $10 ; id 29
    db $13 ; id 30
    db $11 ; id 31
    db $13 ; id 32
    db $10 ; id 33
    db $16 ; id 34
    db $14 ; id 35
    db $13 ; id 36
    db $17 ; id 37
    db $12 ; id 38
    db $14 ; id 39
    db $17 ; id 40
    db $16 ; id 41
    db $16 ; id 42
    db $12 ; id 43
    db $1C ; id 44
    db $0C ; id 45
    db $0D ; id 46
    db $0A ; id 47
    db $0B ; id 48
    db $09 ; id 49
    db $0D ; id 50
    db $0C ; id 51
    db $0C ; id 52
    db $08 ; id 53
    db $09 ; id 54
    db $0A ; id 55
    db $09 ; id 56
    db $0B ; id 57
    db $0E ; id 58
    db $0D ; id 59
    db $0C ; id 60
    db $0B ; id 61
    db $0E ; id 62
    db $0B ; id 63
    db $0D ; id 64
    db $0E ; id 65
    db $0F ; id 66
    db $0D ; id 67
    db $0C ; id 68
    db $0B ; id 69
    db $04 ; id 70
    db $06 ; id 71
    db $05 ; id 72
    db $05 ; id 73
    db $03 ; id 74
    db $04 ; id 75
    db $05 ; id 76
    db $05 ; id 77
    db $02 ; id 78
    db $03 ; id 79
    db $06 ; id 80
    db $05 ; id 81
    db $03 ; id 82
    db $06 ; id 83
    db $07 ; id 84
    db $07 ; id 85
    db $07 ; id 86
    db $0F ; id 87
    db $05 ; id 88
    db $18 ; id 89
    db $0A ; id 90
    db $0F ; id 91
    db $07 ; id 92
    db $07 ; id 93
    db $06 ; id 94
    db $0B ; id 95
    db $09 ; id 96
    db $0C ; id 97
    db $08 ; id 98
    db $09 ; id 99
    db $0C ; id 100
    db $0B ; id 101
    db $09 ; id 102
    db $0D ; id 103
    db $0A ; id 104
    db $06 ; id 105
    db $09 ; id 106
    db $0B ; id 107
    db $18 ; id 108
    db $00 ; id 109
    db $02 ; id 110
    db $04 ; id 111
    db $01 ; id 112
    db $00 ; id 113
    db $04 ; id 114
    db $06 ; id 115
    db $04 ; id 116
    db $03 ; id 117
    db $02 ; id 118
    db $00 ; id 119
    db $05 ; id 120
    db $06 ; id 121
    db $04 ; id 122
    db $02 ; id 123
    db $05 ; id 124
    db $06 ; id 125
    db $07 ; id 126
    db $07 ; id 127
    db $18 ; id 128
    db $0B ; id 129
    db $13 ; id 130
    db $14 ; id 131
    db $10 ; id 132
    db $0D ; id 133
    db $12 ; id 134
    db $10 ; id 135
    db $12 ; id 136
    db $14 ; id 137
    db $0D ; id 138
    db $0D ; id 139
    db $13 ; id 140
    db $15 ; id 141
    db $16 ; id 142
    db $11 ; id 143
    db $13 ; id 144
    db $17 ; id 145
    db $16 ; id 146
    db $14 ; id 147
    db $1E ; id 148
    db $17 ; id 149
    db $16 ; id 150
    db $17 ; id 151
    db $16 ; id 152
    db $15 ; id 153
    db $1C ; id 154
    db $0B ; id 155
    db $0D ; id 156
    db $06 ; id 157
    db $05 ; id 158
    db $0A ; id 159
    db $08 ; id 160
    db $0D ; id 161
    db $0C ; id 162
    db $08 ; id 163
    db $0A ; id 164
    db $0C ; id 165
    db $0D ; id 166
    db $09 ; id 167
    db $0A ; id 168
    db $10 ; id 169
    db $19 ; id 170
    db $0A ; id 171
    db $0C ; id 172
    db $14 ; id 173
    db $01 ; id 174
    db $0C ; id 175
    db $0E ; id 176
    db $0A ; id 177
    db $0A ; id 178
    db $0C ; id 179
    db $08 ; id 180
    db $0E ; id 181
    db $0C ; id 182
    db $08 ; id 183
    db $0B ; id 184
    db $0F ; id 185
    db $0D ; id 186
    db $0B ; id 187
    db $09 ; id 188
    db $0D ; id 189
    db $0B ; id 190
    db $09 ; id 191
    db $0D ; id 192
    db $0D ; id 193
    db $0B ; id 194
    db $08 ; id 195
    db $12 ; id 196
    db $0F ; id 197
    db $0E ; id 198
    db $12 ; id 199
    db $18 ; id 200
    db $19 ; id 201
    db $18 ; id 202
    db $19 ; id 203
    db $18 ; id 204
    db $19 ; id 205
    db $18 ; id 206
    db $1F ; id 207
    db $1E ; id 208
    db $1F ; id 209
    db $1C ; id 210
    db $1B ; id 211
    db $1D ; id 212
    db $1F ; id 213
    db $1E ; id 214

; E-0151 (C1: LoadTable555DEntryForWD0A6ToLinkMenuEntryBytes copies the 3 bytes at $555D + $129 * row + 3 * (wLinkMenuEntry - 1) to wLinkMenuEntryBytes; the layout of ExpTable (E-0148) with different values; 31 of the 32 rows rise from 0).
; record: 24-bit values for levels 1-99
ExpTable81::
Data_081_555D:: ; heuristic: start of a structured table; C0
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 0
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 12900, 15700, 18900, 22500, 26500, 30900, 35700, 40900, 46500, 52500, 58900
    d24 65700, 72900, 80500, 88500, 96900, 105700, 114900, 124500, 134500, 145500, 157500
    d24 170500, 184500, 199500, 215500, 232500, 250500, 269500, 289500, 310500, 332500, 355500
    d24 379500, 404500, 429500, 454500, 479500, 504500, 529500, 554500, 579500, 604500, 629500
    d24 654500, 679500, 704500, 729500, 754500, 779500, 804500, 829500, 854500, 879500, 904500
    d24 929500, 954500, 979500, 1004500, 1029500, 1054500, 1079500, 1104500, 1129500, 1154500, 1179500
    d24 1204500, 1229500, 1254500, 1279500, 1304500, 1329500, 1354500, 1379500, 1404500, 1429500, 1454500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 1
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 12900, 15700, 18900, 22500, 26500, 30900, 35700, 40900, 46500, 52500, 58900
    d24 65700, 72900, 80500, 88500, 96900, 105700, 114900, 124500, 134500, 146500, 160500
    d24 176500, 194500, 214500, 236500, 260500, 286500, 314500, 344500, 374500, 404500, 434500
    d24 464500, 494500, 524500, 554500, 584500, 614500, 644500, 674500, 704500, 734500, 764500
    d24 794500, 824500, 854500, 884500, 914500, 944500, 974500, 1004500, 1034500, 1064500, 1094500
    d24 1124500, 1154500, 1184500, 1214500, 1244500, 1274500, 1304500, 1334500, 1364500, 1394500, 1424500
    d24 1454500, 1484500, 1514500, 1544500, 1574500, 1604500, 1634500, 1664500, 1694500, 1724500, 1754500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 2
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13100, 16300, 20100, 24500, 29500, 35100, 41300, 48100, 55500, 63500, 72100
    d24 81300, 91100, 101500, 112500, 124100, 136300, 149100, 162500, 176500, 191500, 207500
    d24 224500, 242500, 261500, 281500, 302500, 324500, 347500, 371500, 396500, 421500, 446500
    d24 471500, 496500, 521500, 546500, 571500, 596500, 621500, 646500, 671500, 696500, 721500
    d24 746500, 771500, 796500, 821500, 846500, 871500, 896500, 921500, 946500, 971500, 996500
    d24 1021500, 1046500, 1071500, 1096500, 1121500, 1146500, 1171500, 1196500, 1221500, 1246500, 1271500
    d24 1296500, 1321500, 1346500, 1371500, 1396500, 1421500, 1446500, 1471500, 1496500, 1521500, 1546500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 3
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13100, 16300, 20100, 24500, 29500, 35100, 41300, 48100, 55500, 63500, 72100
    d24 81300, 91100, 101500, 112500, 124100, 136300, 149100, 162500, 176500, 192500, 210500
    d24 230500, 252500, 276500, 302500, 330500, 360500, 390500, 420500, 450500, 480500, 510500
    d24 540500, 570500, 600500, 630500, 660500, 690500, 720500, 750500, 780500, 810500, 840500
    d24 870500, 900500, 930500, 960500, 990500, 1020500, 1050500, 1080500, 1110500, 1140500, 1170500
    d24 1200500, 1230500, 1260500, 1290500, 1320500, 1350500, 1380500, 1410500, 1440500, 1470500, 1500500
    d24 1530500, 1560500, 1590500, 1620500, 1650500, 1680500, 1710500, 1740500, 1770500, 1800500, 1830500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 4
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13300, 16900, 21300, 26500, 32500, 39300, 46900, 55300, 64500, 74500, 85300
    d24 96900, 109300, 122500, 136500, 151300, 166900, 183300, 200500, 218500, 237500, 257500
    d24 278500, 300500, 323500, 347500, 372500, 397500, 422500, 447500, 472500, 497500, 522500
    d24 547500, 572500, 597500, 622500, 647500, 672500, 697500, 722500, 747500, 772500, 797500
    d24 822500, 847500, 872500, 897500, 922500, 947500, 972500, 997500, 1022500, 1047500, 1072500
    d24 1097500, 1122500, 1147500, 1172500, 1197500, 1222500, 1247500, 1272500, 1297500, 1322500, 1347500
    d24 1372500, 1397500, 1422500, 1447500, 1472500, 1497500, 1522500, 1547500, 1572500, 1597500, 1622500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 5
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13300, 16900, 21300, 26500, 32500, 39300, 46900, 55300, 64500, 74500, 85300
    d24 96900, 109300, 122500, 136500, 151300, 166900, 183300, 200500, 218500, 238500, 260500
    d24 284500, 310500, 338500, 368500, 398500, 428500, 458500, 488500, 518500, 548500, 578500
    d24 608500, 638500, 668500, 698500, 728500, 758500, 788500, 818500, 848500, 878500, 908500
    d24 938500, 968500, 998500, 1028500, 1058500, 1088500, 1118500, 1148500, 1178500, 1208500, 1238500
    d24 1268500, 1298500, 1328500, 1358500, 1388500, 1418500, 1448500, 1478500, 1508500, 1538500, 1568500
    d24 1598500, 1628500, 1658500, 1688500, 1718500, 1748500, 1778500, 1808500, 1838500, 1868500, 1898500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 6
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13500, 17500, 22500, 28500, 35500, 43500, 52500, 62500, 73500, 85500, 98500
    d24 112500, 127500, 143500, 160500, 178500, 197500, 217500, 238500, 260500, 283500, 307500
    d24 332500, 357500, 382500, 407500, 432500, 457500, 482500, 507500, 532500, 557500, 582500
    d24 607500, 632500, 657500, 682500, 707500, 732500, 757500, 782500, 807500, 832500, 857500
    d24 882500, 907500, 932500, 957500, 982500, 1007500, 1032500, 1057500, 1082500, 1107500, 1132500
    d24 1157500, 1182500, 1207500, 1232500, 1257500, 1282500, 1207500, 1332500, 1357500, 1382500, 1407500
    d24 1432500, 1457500, 1482500, 1507500, 1532500, 1557500, 1582500, 1607500, 1632500, 1657500, 1682500
    d24 0, 2, 7, 15, 30, 50, 90, 140, 215, 330, 500 ; id 7
    d24 760, 1080, 1480, 1980, 2600, 3380, 4360, 5580, 6950, 8500, 10500
    d24 13500, 17500, 22500, 28500, 35500, 43500, 52500, 62500, 73500, 85500, 98500
    d24 112500, 127500, 143500, 160500, 178500, 197500, 217500, 238500, 260500, 284500, 310500
    d24 338500, 368500, 398500, 428500, 458500, 488500, 518500, 548500, 578500, 608500, 638500
    d24 668500, 698500, 728500, 758500, 788500, 818500, 848500, 878500, 908500, 938500, 968500
    d24 998500, 1028500, 1058500, 1088500, 1118500, 1148500, 1178500, 1208500, 1238500, 1268500, 1298500
    d24 1328500, 1358500, 1388500, 1418500, 1448500, 1478500, 1508500, 1538500, 1568500, 1598500, 1628500
    d24 1658500, 1688500, 1718500, 1748500, 1778500, 1808500, 1838500, 1868500, 1898500, 1928500, 1958500
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 8
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 25800, 31400, 37800, 45000, 53000, 61800, 71400, 81800, 93000, 105000, 117800
    d24 131400, 145800, 161000, 177000, 193800, 211400, 229800, 249000, 269000, 290250, 312750
    d24 336500, 361500, 387750, 415250, 444000, 474000, 506000, 540000, 576000, 614000, 654000
    d24 695000, 737000, 780000, 824000, 869000, 915000, 962000, 1010000, 1059000, 1109000, 1159000
    d24 1209000, 1259000, 1309000, 1338520, 1409000, 1459000, 1509000, 1559000, 1609000, 1659000, 1709000
    d24 1759000, 1809000, 1859000, 1909000, 1959000, 2009000, 2059000, 2109000, 2159000, 2209000, 2259000
    d24 2309000, 2359000, 2409000, 2459000, 2509000, 2559000, 2609000, 2659000, 2709000, 2759000, 2809000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 9
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 25800, 31400, 37800, 45000, 53000, 61800, 71400, 81800, 93000, 105000, 117800
    d24 131400, 145800, 161000, 177000, 193800, 211400, 229800, 249000, 269000, 292100, 318300
    d24 347600, 380000, 415500, 454100, 495900, 540900, 586900, 633900, 681900, 730900, 780900
    d24 831900, 883900, 936900, 990900, 1045900, 1101900, 1158900, 1216900, 1275900, 1335900, 1395900
    d24 1455900, 1515900, 1575900, 1635900, 1695900, 1755900, 1815900, 1875900, 1935900, 1995900, 2055900
    d24 2115900, 2175900, 2235900, 2295900, 2355900, 2415900, 2475900, 2535900, 2595900, 2655900, 2715900
    d24 2775900, 2835900, 2895900, 2955900, 3015900, 3075900, 3135900, 3195900, 3255900, 3315900, 3375900
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 10
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26200, 32600, 40200, 49000, 59000, 70200, 82600, 96200, 111000, 127000, 144200
    d24 162600, 182200, 203000, 225000, 248200, 272600, 298200, 325000, 353000, 382500, 413500
    d24 446256, 480000, 515500, 552500, 591000, 631000, 671600, 712800, 754600, 797000, 840000
    d24 883600, 927800, 972600, 1018000, 1064000, 1110800, 1158400, 1206800, 1256000, 1306000, 1356000
    d24 1406000, 1456000, 1506000, 1556000, 1606000, 1656000, 1706000, 1756000, 1806000, 1856000, 1906000
    d24 1956000, 2006000, 2056000, 2106000, 2156000, 2206000, 2256000, 2306000, 2356000, 2406000, 2456000
    d24 2506000, 2556000, 2606000, 2656000, 2706000, 2756000, 2806000, 2856000, 2906000, 2956000, 3006000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 11
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26200, 32600, 40200, 49000, 59000, 70200, 82600, 96200, 111000, 127000, 144200
    d24 162600, 182200, 203000, 225000, 248200, 272600, 298200, 325000, 353000, 383750, 417250
    d24 453500, 492500, 534250, 578750, 626000, 676000, 726600, 777800, 829600, 882000, 935000
    d24 988600, 1042800, 1097600, 1153000, 1209000, 1265800, 1323400, 1381800, 1441000, 1501000, 1561000
    d24 1621000, 1681000, 1741000, 1801000, 1861000, 1921000, 1981000, 2041000, 2101000, 2161000, 2221000
    d24 2281000, 2341000, 2401000, 2461000, 2521000, 2581000, 2641000, 2701000, 2761000, 2821000, 2881000
    d24 2941000, 3001000, 3061000, 3121000, 3181000, 3241000, 3301000, 3361000, 3421000, 3481000, 3541000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 12
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26600, 33800, 42600, 53000, 65000, 78600, 93800, 110600, 129000, 149000, 170600
    d24 193800, 218600, 245000, 273000, 302600, 333800, 366600, 401000, 435550, 470250, 505100
    d24 540100, 575600, 611600, 648100, 685100, 722600, 760600, 799100, 838100, 877600, 917600
    d24 957600, 997600, 1037600, 1077600, 1117600, 1157600, 1197600, 1237600, 1277600, 1317600, 1357600
    d24 1397600, 1437600, 1477600, 1517600, 1557600, 1597600, 1637600, 1677600, 1717600, 1757600, 1797600
    d24 1837600, 1877600, 1917600, 1957600, 1997600, 2037600, 2077600, 2117600, 2157600, 2197600, 2237600
    d24 2277600, 2317600, 2357600, 2397600, 2437600, 2477600, 2517600, 2557600, 2597600, 2637600, 2677600
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 13
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 26600, 33800, 42600, 53000, 65000, 78600, 93800, 110600, 129000, 149000, 170600
    d24 193800, 218600, 245000, 273000, 302600, 333800, 366600, 401000, 436800, 474000, 512600
    d24 552600, 593600, 635600, 678600, 722600, 767600, 813600, 860600, 908600, 957600, 1007600
    d24 1057600, 1107600, 1157600, 1207600, 1257600, 1307600, 1357600, 1407600, 1457600, 1507600, 1557600
    d24 1607600, 1657600, 1707600, 1757600, 1807600, 1857600, 1907600, 1957600, 2007600, 2057600, 2107600
    d24 2157600, 2207600, 2257600, 2307600, 2357600, 2407600, 2457600, 2507600, 2557600, 2607600, 2657600
    d24 2707600, 2757600, 2807600, 2857600, 2907605, 2957600, 3007600, 3057600, 3107600, 3157600, 3207600
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 14
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 27000, 35000, 45000, 57000, 71000, 87000, 105000, 125000, 147000, 171000, 197000
    d24 225000, 255000, 287000, 321000, 357000, 395000, 435000, 477000, 519750, 563250, 607500
    d24 652500, 697000, 741000, 784500, 827500, 870000, 912000, 953500, 994500, 1035000, 1075000
    d24 1115000, 1155000, 1195000, 1235000, 1275000, 1315000, 1355000, 1395000, 1435000, 1475000, 1515000
    d24 1555000, 1595000, 1635000, 1675000, 1715000, 1755000, 1795000, 1835000, 1875000, 1915000, 1955000
    d24 1995000, 2035000, 2075000, 2115000, 2155000, 2195000, 2235000, 2275000, 2315000, 2355000, 2395000
    d24 2435000, 2475000, 2515000, 2555000, 2595000, 2635000, 2675000, 2715000, 2755000, 2795000, 2835000
    d24 0, 5, 15, 30, 60, 100, 180, 280, 430, 660, 1000 ; id 15
    d24 1520, 2160, 2960, 3960, 5200, 6760, 8760, 11160, 13900, 17000, 21000
    d24 27000, 35000, 45000, 57000, 71000, 87000, 105000, 125000, 147000, 171000, 197000
    d24 225000, 255000, 285500, 316500, 348000, 380000, 412500, 445500, 479000, 513000, 547500
    d24 582500, 619000, 657000, 696500, 737500, 780000, 824000, 869500, 916500, 965000, 1015000
    d24 1066000, 1118000, 1171000, 1225000, 1280000, 1336000, 1393000, 1451000, 1510000, 1570000, 1630000
    d24 1690000, 1750000, 1809744, 1870000, 1930000, 1990000, 2050000, 2110000, 2170000, 2230000, 2290000
    d24 2350000, 2410000, 2470000, 2530000, 2590000, 2650000, 2710000, 2770000, 2830000, 2890000, 2950000
    d24 3010000, 3070000, 3130000, 3190000, 3250000, 3310000, 3370000, 3430000, 3490000, 3550000, 3610000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 16
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 51000, 61000, 72000, 84000, 97000, 111000, 126000, 142000, 159800, 179400, 200800
    d24 224000, 249000, 275000, 302000, 330000, 359000, 389000, 420000, 452000, 485000, 519000
    d24 554000, 590500, 628500, 668000, 709000, 751500, 795500, 841000, 888000, 936500, 986500
    d24 1038500, 1092500, 1148500, 1206500, 1266500, 1328500, 1392500, 1458500, 1526500, 1596500, 1666500
    d24 1736500, 1806500, 1876500, 1946500, 2016500, 2086500, 2156500, 2226500, 2296500, 2366500, 2436500
    d24 2506500, 2576500, 2646500, 2716500, 2786500, 2856500, 2926500, 2996500, 3066500, 3136500, 3206500
    d24 3276500, 3346500, 3416500, 3486500, 3556500, 3626500, 3696500, 3766500, 3836500, 3906500, 3976500
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 17
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 51000, 61000, 72000, 84000, 97000, 111000, 126000, 142000, 159800, 179400, 200800
    d24 224000, 249000, 275500, 303500, 333000, 364000, 396500, 430500, 466000, 503000, 541500
    d24 581500, 623500, 667500, 713500, 761500, 811500, 863500, 917500, 973500, 1031500, 1091500
    d24 1152500, 1214500, 1277500, 1341500, 1406500, 1472500, 1539500, 1607500, 1676500, 1746500, 1816500
    d24 1886500, 1956500, 2026500, 2096500, 2166516, 2236500, 2306500, 2376500, 2446500, 2516500, 2586500
    d24 2656500, 2726500, 2796500, 2866500, 2936500, 3006500, 3076500, 3146500, 3216500, 3286500, 3356500
    d24 3426500, 3496500, 3566500, 3636500, 3706500, 3776500, 3846500, 3916500, 3986500, 4056500, 4126500
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 18
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 52400, 65200, 80400, 98000, 118000, 140400, 165200, 192400, 222000, 254000, 288400
    d24 325200, 364400, 405600, 448400, 492400, 537200, 582800, 629200, 676400, 724400, 773400
    d24 823400, 874400, 926400, 979400, 1033400, 1088400, 1144400, 1201400, 1259400, 1318400, 1378400
    d24 1439400, 1501400, 1564400, 1628400, 1693400, 1759400, 1826400, 1894400, 1963400, 2033400, 2103400
    d24 2173400, 2243400, 2313400, 2383400, 2453400, 2523400, 2593400, 2663400, 2733400, 2803400, 2873400
    d24 2943400, 3013400, 3083400, 3153400, 3223400, 3293400, 3363400, 3433400, 3503400, 3573400, 3643400
    d24 3713400, 3783400, 3853400, 3923400, 3993400, 4063400, 4133400, 4203400, 4273400, 4343400, 4413400
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 19
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 52400, 65200, 80400, 98000, 118000, 140400, 165200, 192400, 222000, 254000, 288400
    d24 325200, 364400, 406000, 450000, 496400, 545200, 596400, 650000, 706000, 770000, 842000
    d24 922000, 1010000, 1106000, 1210000, 1322000, 1442000, 1562000, 1682000, 1802000, 1922000, 2042000
    d24 2162000, 2282000, 2402000, 2522000, 2642000, 2762000, 2882000, 3002000, 3122000, 3242000, 3362000
    d24 3482000, 3602000, 3722000, 3842000, 3962000, 4082000, 4202000, 4322000, 4442000, 4562000, 4682000
    d24 4802000, 4922000, 5042000, 5162000, 5282000, 5402000, 5522000, 5642000, 5762000, 5882000, 6002000
    d24 6122000, 6242000, 6362000, 6482000, 6602000, 6722000, 6842000, 6962000, 7082000, 7202000, 7322000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 20
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 52500, 65500, 81000, 99000, 120000, 144000, 171000, 201000, 233000, 267000, 303000
    d24 341000, 381000, 422000, 464000, 507000, 551000, 596000, 642000, 689000, 737000, 786000
    d24 836000, 887000, 939000, 992000, 1046000, 1101000, 1157000, 1214000, 1272000, 1331000, 1391000
    d24 1452000, 1514000, 1577000, 1641000, 1706000, 1772000, 1839000, 1907000, 1976000, 2046000, 2116000
    d24 2186000, 2256000, 2326000, 2396000, 2466000, 2536000, 2606000, 2676000, 2746000, 2816000, 2886000
    d24 2956000, 3026000, 3096000, 3166000, 3236000, 3306000, 3376000, 3446000, 3516000, 3586000, 3656000
    d24 3726000, 3796000, 3866000, 3936000, 4006000, 4076000, 4146000, 4216000, 4286000, 4356000, 4426000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 21
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 53200, 67600, 85200, 106000, 130000, 156000, 184000, 214000, 246000, 280000, 316000
    d24 354000, 394000, 436000, 480000, 526000, 574000, 624000, 676000, 730000, 786000, 844000
    d24 904000, 965000, 1027000, 1090000, 1154000, 1219000, 1285000, 1352000, 1420000, 1489000, 1559000
    d24 1630000, 1702000, 1775000, 1849000, 1924000, 2000000, 2077000, 2155000, 2234000, 2314000, 2394000
    d24 2474000, 2554000, 2634000, 2714000, 2794000, 2874000, 2954000, 3034000, 3114000, 3194000, 3274000
    d24 3354000, 3434000, 3514000, 3594000, 3674000, 3754000, 3834000, 3914000, 3994000, 4074000, 4154000
    d24 4234000, 4314000, 4394000, 4474000, 4554000, 4634000, 4714000, 4794000, 4874000, 4954000, 5034000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 22
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 54000, 70000, 90000, 112000, 136000, 162000, 190000, 220000, 252000, 286000, 322000
    d24 360000, 400000, 441000, 483000, 526000, 570000, 615000, 661000, 708000, 756000, 805000
    d24 855000, 906000, 958000, 1011000, 1065000, 1120000, 1176000, 1233000, 1291000, 1350000, 1410000
    d24 1470000, 1530000, 1590000, 1650000, 1710000, 1770000, 1830000, 1890000, 1950000, 2010000, 2070000
    d24 2130000, 2190000, 2250000, 2310000, 2370000, 2430000, 2490000, 2550000, 2610000, 2670000, 2730000
    d24 2790000, 2850000, 2910000, 2970000, 3030000, 3090000, 3150000, 3210000, 3270000, 3330000, 3390000
    d24 3450000, 3510000, 3570000, 3630000, 3690000, 3750000, 3810000, 3870000, 3930000, 3990000, 4050000
    d24 0, 10, 30, 60, 120, 220, 360, 560, 860, 1320, 2000 ; id 23
    d24 3040, 4320, 5920, 7920, 10400, 13520, 17520, 22320, 27800, 34000, 42000
    d24 54000, 70000, 90000, 113000, 139000, 168000, 200000, 235000, 273000, 314000, 358000
    d24 405000, 455000, 506000, 558000, 611000, 665000, 720000, 776000, 833000, 891000, 950000
    d24 1010000, 1070000, 1130000, 1190000, 1250000, 1310000, 1370000, 1430000, 1490000, 1550000, 1610000
    d24 1671000, 1733000, 1796000, 1860000, 1925000, 1991000, 2058000, 2126000, 2195000, 2265000, 2335000
    d24 2405000, 2475000, 2545000, 2615000, 2685000, 2755000, 2825000, 2895000, 2965000, 3035000, 3105000
    d24 3175000, 3245000, 3315000, 3385000, 3455000, 3525000, 3595000, 3665000, 3735000, 3805000, 3875000
    d24 3945000, 4015000, 4085000, 4155000, 4225000, 4295000, 4365000, 4435000, 4505000, 4575000, 4645000
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 24
    d24 30400, 43200, 59200, 79200, 101700, 126700, 152700, 180700, 210700, 242700, 276700
    d24 312700, 350700, 390700, 431700, 473700, 516700, 560700, 605700, 651700, 698700, 746700
    d24 795700, 845700, 895700, 945700, 995700, 1045700, 1095700, 1145700, 1195700, 1245700, 1295700
    d24 1345700, 1396200, 1447200, 1498700, 1550700, 1603200, 1656200, 1709700, 1763700, 1818200, 1873200
    d24 1929700, 1987700, 2047200, 2108200, 2170700, 2234700, 2300200, 2367200, 2435700, 2505700, 2575700
    d24 2645700, 2715700, 2785700, 2855700, 2925700, 2995700, 3065700, 3135700, 3205700, 3275700, 3345700
    d24 3415700, 3485700, 3555700, 3625700, 3695700, 3776992, 3835700, 3905700, 3975700, 4045700, 4115700
    d24 4185700, 4255700, 4325700, 4395700, 4465700, 4535700, 4605700, 4675700, 4745700, 4815700, 4885700
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 25
    d24 30400, 43200, 59200, 79200, 104200, 134200, 168200, 205200, 245200, 287200, 330200
    d24 374200, 418700, 463700, 509200, 555200, 601700, 648700, 696200, 744200, 792700, 841700
    d24 891200, 941200, 991700, 1042700, 1094200, 1146200, 1198700, 1251700, 1305200, 1359200, 1413700
    d24 1468700, 1524200, 1580200, 1636700, 1693700, 1751200, 1809200, 1867700, 1926700, 1986200, 2046200
    d24 2108200, 2172200, 2238200, 2306200, 2376200, 2448200, 2522200, 2598200, 2676200, 2756200, 2836200
    d24 2916200, 2996200, 3076200, 3156200, 3236200, 3316200, 3396200, 3476200, 3556200, 3636200, 3716200
    d24 3796200, 3876200, 3956200, 4036200, 4116200, 4196200, 4276200, 4356200, 4436200, 4516200, 4596200
    d24 4676200, 4756200, 4836200, 4916200, 4996200, 5076200, 5156200, 5236200, 5316200, 5396200, 5476200
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 26
    d24 30400, 43200, 59200, 79200, 104200, 134200, 168200, 205200, 245200, 288200, 333200
    d24 380200, 429200, 479200, 529700, 580700, 632200, 684200, 736700, 789700, 843200, 897200
    d24 951700, 1006700, 1062200, 1118200, 1174700, 1231700, 1289200, 1347200, 1405700, 1464700, 1524200
    d24 1584200, 1644200, 1704200, 1764200, 1824200, 1884200, 1944200, 2004200, 2064200, 2124200, 2184200
    d24 2245200, 2307200, 2370200, 2434200, 2499200, 2565200, 2632200, 2700200, 2769200, 2839200, 2909200
    d24 2979200, 3049200, 3119200, 3189200, 3259200, 3329200, 3399200, 3469200, 3539200, 3609208, 3679200
    d24 3749200, 3819200, 3889200, 3959200, 4029200, 4099200, 4169200, 4239200, 4309200, 4379200, 4449200
    d24 4519200, 4589200, 4659200, 4729200, 4799200, 4869200, 4939200, 5009200, 5079200, 5149200, 5219200
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 27
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 575900, 626900, 678400, 730400, 782900, 835900, 889400, 943400
    d24 997900, 1052900, 1108400, 1164400, 1220900, 1277900, 1335400, 1393400, 1451900, 1510900, 1570400
    d24 1630400, 1690900, 1751900, 1813400, 1875400, 1937900, 2000900, 2064400, 2128400, 2192900, 2257900
    d24 2324400, 2392400, 2461900, 2532900, 2605400, 2679400, 2754900, 2831900, 2910400, 2990400, 3070400
    d24 3150400, 3230400, 3310400, 3390400, 3470400, 3550400, 3630400, 3710400, 3790400, 3870400, 3950400
    d24 4030400, 4110400, 4190400, 4270400, 4350400, 4430400, 4510400, 4590400, 4670400, 4750400, 4830400
    d24 4910400, 4990400, 5070400, 5150400, 5230400, 5310400, 5390400, 5470400, 5550400, 5630400, 5710400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 28
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 575900, 626900, 678400, 730400, 782900, 835900, 889400, 943400
    d24 997900, 1052900, 1108400, 1164400, 1220900, 1277900, 1335400, 1393400, 1451900, 1510900, 1570400
    d24 1630400, 1691400, 1753400, 1816400, 1880400, 1945400, 2011400, 2078400, 2146400, 2215400, 2285400
    d24 2356400, 2428400, 2501400, 2575400, 2650400, 2726400, 2803400, 2881400, 2960400, 3040400, 3120400
    d24 3200400, 3280400, 3360400, 3440400, 3520400, 3600400, 3680400, 3760400, 3840400, 3920400, 4000400
    d24 4080400, 4160400, 4240400, 4320400, 4400400, 4480400, 4560400, 4640400, 4720400, 4800400, 4880400
    d24 4960400, 5040400, 5120400, 5200400, 5280400, 5360400, 5440400, 5520400, 5600400, 5680400, 5760400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 29
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 575900, 626900, 678400, 730400, 782900, 835900, 889400, 943400
    d24 997900, 1052900, 1108400, 1164400, 1220900, 1277900, 1335400, 1393400, 1451900, 1510900, 1570400
    d24 1630400, 1692400, 1756400, 1822400, 1890400, 1960400, 2032400, 2106400, 2182400, 2260400, 2340400
    d24 2422400, 2506400, 2592400, 2680400, 2770400, 2862400, 2956400, 3052400, 3150400, 3250400, 3350400
    d24 3450400, 3550400, 3650400, 3750400, 3850400, 3950400, 4050400, 4150400, 4250400, 4350400, 4450400
    d24 4550400, 4650400, 4750400, 4850400, 4950400, 5050400, 5150400, 5250400, 5350400, 5450400, 5550400
    d24 5650400, 5750400, 5850400, 5950400, 6050400, 6150400, 6250400, 6350400, 6450400, 6550400, 6650400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 30
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 325400, 375400
    d24 425400, 475400, 525400, 576400, 628400, 681400, 735392, 790400, 846400, 903400, 961400
    d24 1020400, 1080400, 1141400, 1203400, 1266400, 1330400, 1395400, 1461400, 1528400, 1596400, 1665400
    d24 1735400, 1806400, 1878400, 1951400, 2025400, 2100400, 2176400, 2253400, 2331400, 2410400, 2490400
    d24 2572400, 2656400, 2742400, 2830400, 2920400, 3012400, 3106400, 3202400, 3300400, 3400400, 3500400
    d24 3600400, 3700400, 3800400, 3900400, 4000400, 4100400, 4200400, 4300400, 4400400, 4500400, 4600400
    d24 4700400, 4800400, 4900400, 5000400, 5100400, 5200400, 5300400, 5400400, 5500400, 5600400, 5700400
    d24 5800400, 5900400, 6000400, 6100400, 6200400, 6300400, 6400400, 6500400, 6600400, 6700400, 6800400
    d24 0, 100, 300, 600, 1200, 2200, 3600, 5600, 8600, 13200, 20000 ; id 31
    d24 30400, 44400, 62400, 84400, 111400, 143400, 181400, 225400, 275400, 327400, 381400
    d24 437400, 495400, 555400, 616400, 678400, 741400, 805400, 870400, 936400, 1003400, 1071400
    d24 1140400, 1210400, 1281400, 1353400, 1426400, 1500400, 1575400, 1651400, 1728400, 1806400, 1885400
    d24 1965400, 2046400, 2128400, 2211400, 2295400, 2380400, 2466400, 2553400, 2641400, 2730400, 2820400
    d24 2911400, 3003400, 3096400, 3190400, 3285400, 3381400, 3478400, 3576400, 3675400, 3775400, 3875400
    d24 3975400, 4075400, 4175400, 4275400, 4375400, 4475400, 4575400, 4675400, 4775400, 4875400, 4975400
    d24 5075400, 5175400, 5275400, 5375400, 5475400, 5575400, 5675400, 5775400, 5875400, 5975400, 6075400
    d24 6175400, 6275400, 6375400, 6475400, 6575400, 6675400, 6775400, 6875400, 6975400, 7075400, 7175400
    ds $583, $00
