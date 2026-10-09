SECTION "Bank 81", ROMX[$4000], BANK[$81]
    db $81

Func_081_4001::
    ld a, [wCA36]
    ld l, a
    ld a, [wCA37]
    ld h, a
    push hl
    ld a, l
    ld [wD2AD], a
    ld a, h
    ld [wD2AE], a
    ld a, [wCA38]
    ld [wD2B3], a
    ld a, [wCA45]
    ld l, a
    ld a, [wCA46]
    ld h, a
    ld a, l
    ld [wD2AF], a
    ld a, h
    ld [wD2B0], a
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    ld hl, Func_035_400A
    ld b, $35
    rst $10
    ld a, [wD008]
    ld [wD2B4], a
    ld a, [wCA47]
    ld l, a
    ld a, [wCA48]
    ld h, a
    ld a, l
    ld [wD2B1], a
    ld a, h
    ld [wD2B2], a
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    ld hl, Func_035_400A
    ld b, $35
    rst $10
    ld a, [wD008]
    ld [wD2B5], a
    ld a, [wD2AD]
    ld l, a
    ld a, [wD2AE]
    ld h, a
    add hl, hl
    ld a, l
    add a, $67
    ld l, a
    ld a, h
    adc a, $41
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld a, [wD2AF]
    ld e, a
    ld a, [wD2B0]
    ld d, a
    ld a, e
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a
    ld a, [wD2B1]
    ld e, a
    ld a, [wD2B2]
    ld d, a
    ld a, e
    ldh [hFFC8], a
    ld a, d
    ldh [hFFC9], a
    ld a, [wD2B4]
    ldh [hFFCA], a
    ld a, [wD2B5]
    ldh [hFFCB], a
    call Func_081_40E2
    pop hl
    ld a, c
    or a, a
    jr z, Jump_081_40D8
    ld a, [wD2B1]
    ld e, a
    ld a, [wD2B2]
    ld d, a
    ld a, e
    ldh [hFFC6], a
    ld a, d
    ldh [hFFC7], a
    ld a, [wD2AF]
    ld e, a
    ld a, [wD2B0]
    ld d, a
    ld a, e
    ldh [hFFC8], a
    ld a, d
    ldh [hFFC9], a
    ld a, [wD2B5]
    ldh [hFFCA], a
    ld a, [wD2B4]
    ldh [hFFCB], a
    call Func_081_40E2
    ld a, c
    or a, a
    jr nz, Jump_081_40D8
    ld a, [wCA38]
    set 4, a
    ld [wCA38], a

Jump_081_40D8::
    pop hl
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    ret

Func_081_40E2::
    ld a, [hl+]
    ld d, [hl]
    inc hl
    cp a, $FF
    jr z, Jump_081_40F4
    cp a, $00
    jr z, Jump_081_4116
    cp a, $01
    jp z, Jump_081_414C
    jr Func_081_40E2

Jump_081_40F4::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, [wD2AD]
    ld c, a
    ld a, [wD2AE]
    ld b, a
    call Func_000_3E7A
    jr nz, Jump_081_4113
    ld a, [wD2B3]
    ld hl, hFFCB
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
    ld a, [wD2B3]
    cp a, c
    jr z, Jump_081_4126

Jump_081_411F::
    inc hl
    inc hl
    dec d
    jr nz, Jump_081_411F
    jr Func_081_40E2

Jump_081_4126::
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    bit 7, b
    jr nz, Jump_081_4136
    ldh a, [hFFCB]
    cp a, c
    jp z, Jump_081_4110
    jr Jump_081_4146

Jump_081_4136::
    res 7, b
    push hl
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    call Func_000_3E7A
    pop hl
    jp z, Jump_081_4110

Jump_081_4146::
    dec d
    jr nz, Jump_081_4126
    jp Func_081_40E2

Jump_081_414C::
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call Func_000_3E7A
    pop hl
    jr z, Jump_081_4165

Jump_081_415D::
    inc hl
    inc hl
    dec d
    jr nz, Jump_081_415D
    jp Func_081_40E2

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

Func_081_5453::
    ld a, [wD0A6]
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
    call Func_000_16AA
    ld a, [wD0E8]
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
    ld de, wD0EA
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $205486, $25F7
    ds $583, $00
