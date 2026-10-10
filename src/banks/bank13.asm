SECTION "Bank 13", ROMX[$4000], BANK[$13]
    db $13

; HL is stored in wC921 (low) and wC922 (high); then wC5DC = 1, wC920 = 9, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 to wC919 is overwritten)
; 697 call sites from 48 routines (e.g. Func_013_5EF4, Func_013_5C0B, Func_013_5922, Func_013_49D5, ...)
; writes: wC921, wC922, wC919, wModeState, wC920, wC91F, wC923
SetRequestPtrC921_B13::
Func_013_4001:: ; address name
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wModeState], a
    ld a, $09
    ld [wC920], a
    ld a, $01
    ld [wC91F], a
    xor a, a
    ld [wC919], a
    ld [wC923], a
    ret

; DE is stored in wC924 (low) and wC925 (high); then wC5DC = 1, wC920 = $0A, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 is overwritten)
; 33 call sites from 18 routines (e.g. Func_013_5EF4, Func_013_49D5, Func_013_405C, Func_013_7DEC, ...)
; writes: wC924, wC925, wC919, wModeState, wC920, wC91F, wC923
SetRequestPtrC924FromDE_B13::
Func_013_4025:: ; address name
    ld a, e
    ld [wC924], a
    ld a, d
    ld [wC925], a
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wModeState], a
    ld a, $0A
    ld [wC920], a
    ld a, $01
    ld [wC91F], a
    xor a, a
    ld [wC919], a
    ld [wC923], a
    ret

; HL is stored in wC91A (low) and wC91B (high); then wC919 = $80 and wC5DC = 1
; 215 call sites from 22 routines (e.g. Func_013_5922, Func_013_5EF4, Func_013_5C0B, Func_013_49D5, ...)
; writes: wC91A, wC91B, wC919, wModeState
SetRequestPtrC91A_B13::
Func_013_4049:: ; address name
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wModeState], a
    ret

; 39 call sites from 23 routines (e.g. Func_002_4745, Func_002_4E9E, Func_002_4ED6, Func_002_5B2A, ...)
; reads: wCC44, wC917, wCC45, wC916
; writes: wC919, wModeState, wC917, wC916, wC921, wC922, wC920, wC91F, ...
; points at: wCD89, wCDAE
Func_013_405C::
    ld a, [wCC44]
    bit 7, a
    jp z, Jump_013_40E9
    ld a, [wC917]
    cp a, $09
    jp z, Jump_013_40E9
    ld a, [wCC44]
    cp a, $80
    jp z, Jump_013_40E9
    cp a, $82
    jp z, Jump_013_40E9
    cp a, $84
    jp z, Jump_013_40E9
    cp a, $85
    jp z, Jump_013_40E9
    cp a, $86
    jp z, Jump_013_40E9
    cp a, $83
    jr nz, Jump_013_409E
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    cp a, $06
    jr z, Jump_013_40E9

Jump_013_409E::
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wModeState], a
    ld a, [wCC45]
    swap a
    ld hl, wCDAE
    add_a_to_hl
    ld a, [wC916]
    cp a, $FD
    jr nz, Jump_013_40C8
    ld a, $09
    ld [wC917], a
    ld a, $01
    ld [wC916], a
    jr Jump_013_40E9

Jump_013_40C8::
    push af
    pop af
    add_a_to_hl
    ld a, [hl]
    ld [wC921], a
    xor a, a
    ld [wC922], a
    ld a, $09
    ld [wC920], a
    ld a, $01
    ld [wC91F], a
    xor a, a
    ld [wC919], a
    ld [wC923], a
    ret

Jump_013_40E9::
    ld a, [wC917]
    rst $00
    dw Jump_013_4103
    dw Jump_013_5941
    dw Jump_013_4126
    dw Jump_013_412D
    dw Jump_013_4A23
    dw Jump_013_4134
    dw Jump_013_411F
    dw Jump_013_4111
    dw Jump_013_593A
    dw Jump_013_4118
    dw Jump_013_410A

Jump_013_4103::
    farcall Func_004_6892
    ret

Jump_013_410A::
    farcall Func_004_5616
    ret

Jump_013_4111::
    farcall Func_004_6A35
    ret

Jump_013_4118::
    farcall Func_004_7B29
    ret

Jump_013_411F::
    farcall Func_004_6827
    ret

Jump_013_4126::
    farcall Func_004_612B
    ret

Jump_013_412D::
    farcall Func_004_58C2
    ret

Jump_013_4134::
    ld a, [wC916]
    rst $00
    dw Jump_013_421E
    dw Jump_013_4225
    dw Jump_013_422C
    dw Jump_013_4233
    dw Jump_013_423A
    dw Jump_013_4241
    dw Jump_013_4257
    dw Jump_013_425E
    dw Jump_013_4265
    dw Jump_013_427B
    dw Jump_013_4282
    dw Jump_013_42A7
    dw Jump_013_42B3
    dw Jump_013_42BA
    dw Jump_013_42D0
    dw Jump_013_42DC
    dw Jump_013_42FB
    dw Jump_013_430C
    dw Jump_013_4313
    dw Jump_013_4324
    dw Jump_013_4335
    dw Jump_013_433C
    dw Jump_013_4375
    dw Jump_013_43B0
    dw Jump_013_43B7
    dw Jump_013_43BE
    dw Jump_013_43C5
    dw Jump_013_43CC
    dw Jump_013_43E2
    dw Jump_013_43F8
    dw Jump_013_440E
    dw Jump_013_4424
    dw Jump_013_443C
    dw Jump_013_4443
    dw Jump_013_444A
    dw Jump_013_4451
    dw Jump_013_445D
    dw Jump_013_446E
    dw Jump_013_4475
    dw Jump_013_447C
    dw Jump_013_4483
    dw Jump_013_448F
    dw Jump_013_44A7
    dw Jump_013_44C3
    dw Jump_013_44CA
    dw Jump_013_44DB
    dw Jump_013_44E2
    dw Jump_013_44F8
    dw Jump_013_44FF
    dw Jump_013_4524
    dw Jump_013_452B
    dw Jump_013_4532
    dw Jump_013_4548
    dw Jump_013_45A6
    dw Jump_013_4619
    dw Jump_013_462F
    dw Jump_013_4645
    dw Jump_013_464C
    dw Jump_013_4653
    dw Jump_013_4664
    dw Jump_013_4670
    dw Jump_013_4695
    dw Jump_013_469C
    dw Jump_013_46A3
    dw Jump_013_46AF
    dw Jump_013_46B6
    dw Jump_013_46BD
    dw Jump_013_46C4
    dw Jump_013_46DA
    dw Jump_013_46E1
    dw Jump_013_46E8
    dw Jump_013_46EF
    dw Jump_013_4712
    dw Jump_013_4723
    dw Jump_013_4734
    dw Jump_013_474A
    dw Jump_013_475B
    dw Jump_013_4774
    dw Jump_013_477B
    dw Jump_013_4782
    dw Jump_013_4789
    dw Jump_013_4790
    dw Jump_013_4797
    dw Jump_013_479E
    dw Jump_013_47A5
    dw Jump_013_47BB
    dw Jump_013_47D1
    dw Jump_013_47E2
    dw Jump_013_47F8
    dw Jump_013_47FF
    dw Jump_013_4806
    dw Jump_013_4864
    dw Jump_013_4875
    dw Jump_013_487C
    dw Jump_013_4883
    dw Jump_013_488A
    dw Jump_013_4891
    dw Jump_013_4898
    dw Jump_013_489F
    dw Jump_013_48B0
    dw Jump_013_48B7
    dw Jump_013_48C8
    dw Jump_013_48D9
    dw Jump_013_48EA
    dw Jump_013_4969
    dw Jump_013_4970
    dw Jump_013_4977
    dw Jump_013_4987
    dw Jump_013_498E
    dw Jump_013_4995
    dw Jump_013_499C
    dw Jump_013_49B5
    dw Jump_013_49CE
    db $00, $00, $D5, $49

Jump_013_421E::
    ld hl, $0400
    call SetRequestPtrC921_B13
    ret

Jump_013_4225::
    ld hl, $0401
    call SetRequestPtrC921_B13
    ret

Jump_013_422C::
    ld hl, $0402
    call SetRequestPtrC921_B13
    ret

Jump_013_4233::
    ld hl, $0403
    call SetRequestPtrC921_B13
    ret

Jump_013_423A::
    ld hl, $0404
    call SetRequestPtrC921_B13
    ret

Jump_013_4241::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4250
    ld hl, $0405
    call SetRequestPtrC921_B13
    ret

Jump_013_4250::
    ld hl, $0492
    call SetRequestPtrC921_B13
    ret

Jump_013_4257::
    ld hl, $0407
    call SetRequestPtrC921_B13
    ret

Jump_013_425E::
    ld hl, $0406
    call SetRequestPtrC921_B13
    ret

Jump_013_4265::
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_4274
    ld hl, $0408
    call SetRequestPtrC921_B13
    ret

Jump_013_4274::
    ld hl, $0D2C
    call SetRequestPtrC921_B13
    ret

Jump_013_427B::
    ld hl, $0409
    call SetRequestPtrC921_B13
    ret

Jump_013_4282::
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_42A0
    ld de, $00A4
    call TestFlagBit
    jr c, Jump_013_4299
    ld hl, $040A
    call SetRequestPtrC921_B13
    ret

Jump_013_4299::
    ld hl, $0414
    call SetRequestPtrC921_B13
    ret

Jump_013_42A0::
    ld hl, $0D2D
    call SetRequestPtrC921_B13
    ret

Jump_013_42A7::
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_5FE8
    call SetRequestPtrC91A_B13
    ret

Jump_013_42B3::
    ld hl, $040E
    call SetRequestPtrC921_B13
    ret

Jump_013_42BA::
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_013_42C9
    ld hl, $5FEF
    call SetRequestPtrC91A_B13
    ret

Jump_013_42C9::
    ld hl, $5FF7
    call SetRequestPtrC91A_B13
    ret

Jump_013_42D0::
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6003
    call SetRequestPtrC91A_B13
    ret

Jump_013_42DC::
    ld a, [wC26A]
    cp a, $68
    ret z
    farcall Func_085_5840
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_42F4
    ld hl, $0410
    call SetRequestPtrC921_B13
    ret

Jump_013_42F4::
    ld hl, $5FFC
    call SetRequestPtrC91A_B13
    ret

Jump_013_42FB::
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $00A1
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_430C::
    ld hl, $0413
    call SetRequestPtrC921_B13
    ret

Jump_013_4313::
    ld a, $00
    ld [wC921], a
    ld a, $61
    ld [wC922], a
    ld de, $00A2
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_4324::
    ld a, $03
    ld [wC921], a
    ld a, $00
    ld [wC922], a
    ld de, $00A3
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_4335::
    ld hl, $600A
    call SetRequestPtrC91A_B13
    ret

Jump_013_433C::
    ld de, $00A6
    call TestFlagBit
    ret nc
    ld de, $00A7
    call TestFlagBit
    jr c, Jump_013_436E
    call Func_013_7F94
    jr nc, Jump_013_4367
    ld [hl], $35
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $041A
    call SetRequestPtrC921_B13
    ld de, $00A7
    call SetFlagBit
    ret

Jump_013_4367::
    ld hl, $041B
    call SetRequestPtrC921_B13
    ret

Jump_013_436E::
    ld hl, $04A2
    call SetRequestPtrC921_B13
    ret

Jump_013_4375::
    ld de, $0209
    call TestFlagBit
    jr c, Jump_013_43A9
    ldh a, [hFF93]
    bit 7, a
    jr z, Jump_013_4387
    and a, $01
    jr z, Jump_013_438E

Jump_013_4387::
    ld hl, $041C
    call SetRequestPtrC921_B13
    ret

Jump_013_438E::
    ld a, [wCB8A]
    cp a, $50
    jr z, Jump_013_43A2
    ld hl, $6015
    call SetRequestPtrC91A_B13
    ld de, $0209
    call SetFlagBit
    ret

Jump_013_43A2::
    ld hl, $041D
    call SetRequestPtrC921_B13
    ret

Jump_013_43A9::
    ld hl, $0DF8
    call SetRequestPtrC921_B13
    ret

Jump_013_43B0::
    ld hl, $041E
    call SetRequestPtrC921_B13
    ret

Jump_013_43B7::
    ld hl, $041F
    call SetRequestPtrC921_B13
    ret

Jump_013_43BE::
    ld hl, $0420
    call SetRequestPtrC921_B13
    ret

Jump_013_43C5::
    ld hl, $0421
    call SetRequestPtrC921_B13
    ret

Jump_013_43CC::
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_43DB
    ld hl, $0422
    call SetRequestPtrC921_B13
    ret

Jump_013_43DB::
    ld hl, $0D2E
    call SetRequestPtrC921_B13
    ret

Jump_013_43E2::
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_43F1
    ld hl, $0423
    call SetRequestPtrC921_B13
    ret

Jump_013_43F1::
    ld hl, $0D2F
    call SetRequestPtrC921_B13
    ret

Jump_013_43F8::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4407
    ld hl, $0424
    call SetRequestPtrC921_B13
    ret

Jump_013_4407::
    ld hl, $0494
    call SetRequestPtrC921_B13
    ret

Jump_013_440E::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_441D
    ld hl, $0425
    call SetRequestPtrC921_B13
    ret

Jump_013_441D::
    ld hl, $0495
    call SetRequestPtrC921_B13
    ret

Jump_013_4424::
    ldh a, [hFF93]
    bit 7, a
    jr z, Jump_013_442E
    and a, $01
    jr z, Jump_013_4435

Jump_013_442E::
    ld hl, $6020
    call SetRequestPtrC91A_B13
    ret

Jump_013_4435::
    ld hl, $602D
    call SetRequestPtrC91A_B13
    ret

Jump_013_443C::
    ld hl, $042A
    call SetRequestPtrC921_B13
    ret

Jump_013_4443::
    ld hl, $042B
    call SetRequestPtrC921_B13
    ret

Jump_013_444A::
    ld hl, $042C
    call SetRequestPtrC921_B13
    ret

Jump_013_4451::
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_603A
    call SetRequestPtrC91A_B13
    ret

Jump_013_445D::
    ld a, $0D
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6041
    call SetRequestPtrC91A_B13
    ret

Jump_013_446E::
    ld hl, $0430
    call SetRequestPtrC921_B13
    ret

Jump_013_4475::
    ld hl, $04AA
    call SetRequestPtrC921_B13
    ret

Jump_013_447C::
    ld hl, $0DD3
    call SetRequestPtrC921_B13
    ret

Jump_013_4483::
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6048
    call SetRequestPtrC91A_B13
    ret

Jump_013_448F::
    ld de, $00A4
    call TestFlagBit
    ret nc
    farcall Func_085_5882
    ldh a, [hFFC6]
    or a, a
    ret z
    ld hl, $604F
    call SetRequestPtrC91A_B13
    ret

Jump_013_44A7::
    ld de, $00A9
    call TestFlagBit
    jr c, Jump_013_44BC
    ld hl, $0434
    call SetRequestPtrC921_B13
    ld de, $00A9
    call SetFlagBit
    ret

Jump_013_44BC::
    ld hl, $0435
    call SetRequestPtrC921_B13
    ret

Jump_013_44C3::
    ld hl, $0436
    call SetRequestPtrC921_B13
    ret

Jump_013_44CA::
    ld a, $00
    ld [wC921], a
    ld a, $03
    ld [wC922], a
    ld de, $00AA
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_44DB::
    ld hl, $0437
    call SetRequestPtrC921_B13
    ret

Jump_013_44E2::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_44F1
    ld hl, $0438
    call SetRequestPtrC921_B13
    ret

Jump_013_44F1::
    ld hl, $0496
    call SetRequestPtrC921_B13
    ret

Jump_013_44F8::
    ld hl, $6062
    call SetRequestPtrC91A_B13
    ret

Jump_013_44FF::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_451D
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_4516
    ld hl, $043C
    call SetRequestPtrC921_B13
    ret

Jump_013_4516::
    ld hl, $043D
    call SetRequestPtrC921_B13
    ret

Jump_013_451D::
    ld hl, $0497
    call SetRequestPtrC921_B13
    ret

Jump_013_4524::
    ld hl, $043E
    call SetRequestPtrC921_B13
    ret

Jump_013_452B::
    ld hl, $043F
    call SetRequestPtrC921_B13
    ret

Jump_013_4532::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4541
    ld hl, $0440
    call SetRequestPtrC921_B13
    ret

Jump_013_4541::
    ld hl, $0498
    call SetRequestPtrC921_B13
    ret

Jump_013_4548::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_459F
    ld a, $39
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4582
    ld a, $3A
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4582
    ld a, $3B
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4582
    jr Jump_013_4598

Jump_013_4582::
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_4591
    ld hl, $0441
    call SetRequestPtrC921_B13
    ret

Jump_013_4591::
    ld hl, $0442
    call SetRequestPtrC921_B13
    ret

Jump_013_4598::
    ld hl, $6119
    call SetRequestPtrC91A_B13
    ret

Jump_013_459F::
    ld hl, $0499
    call SetRequestPtrC921_B13
    ret

Jump_013_45A6::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4612
    ld de, $00B7
    call TestFlagBit
    jr c, Jump_013_460B
    ld a, $39
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_45E8
    ld a, $3A
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_45E8
    ld a, $3B
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_45E8
    jr Jump_013_45FE

Jump_013_45E8::
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_45F7
    ld hl, $0443
    call SetRequestPtrC921_B13
    ret

Jump_013_45F7::
    ld hl, $0444
    call SetRequestPtrC921_B13
    ret

Jump_013_45FE::
    ld hl, $046B
    call SetRequestPtrC921_B13
    ld de, $00B7
    call SetFlagBit
    ret

Jump_013_460B::
    ld hl, $046C
    call SetRequestPtrC921_B13
    ret

Jump_013_4612::
    ld hl, $049A
    call SetRequestPtrC921_B13
    ret

Jump_013_4619::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_4628
    ld hl, $0445
    call SetRequestPtrC921_B13
    ret

Jump_013_4628::
    ld hl, $04A3
    call SetRequestPtrC921_B13
    ret

Jump_013_462F::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_463E
    ld hl, $0446
    call SetRequestPtrC921_B13
    ret

Jump_013_463E::
    ld hl, $049B
    call SetRequestPtrC921_B13
    ret

Jump_013_4645::
    ld hl, $606F
    call SetRequestPtrC91A_B13
    ret

Jump_013_464C::
    ld hl, $044A
    call SetRequestPtrC921_B13
    ret

Jump_013_4653::
    ld a, $0E
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_607C
    call SetRequestPtrC91A_B13
    ret

Jump_013_4664::
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_6083
    call SetRequestPtrC91A_B13
    ret

Jump_013_4670::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_468E
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_4687
    ld hl, $044D
    call SetRequestPtrC921_B13
    ret

Jump_013_4687::
    ld hl, $044E
    call SetRequestPtrC921_B13
    ret

Jump_013_468E::
    ld hl, $049C
    call SetRequestPtrC921_B13
    ret

Jump_013_4695::
    ld hl, $0450
    call SetRequestPtrC921_B13
    ret

Jump_013_469C::
    ld hl, $0314
    call SetRequestPtrC921_B13
    ret

Jump_013_46A3::
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_6048
    call SetRequestPtrC91A_B13
    ret

Jump_013_46AF::
    ld hl, $0452
    call SetRequestPtrC921_B13
    ret

Jump_013_46B6::
    ld hl, $0453
    call SetRequestPtrC921_B13
    ret

Jump_013_46BD::
    ld hl, $0454
    call SetRequestPtrC921_B13
    ret

Jump_013_46C4::
    ld de, $00A8
    call TestFlagBit
    jr c, Jump_013_46D3
    ld hl, $0455
    call SetRequestPtrC921_B13
    ret

Jump_013_46D3::
    ld hl, $0456
    call SetRequestPtrC921_B13
    ret

Jump_013_46DA::
    ld hl, $0457
    call SetRequestPtrC921_B13
    ret

Jump_013_46E1::
    ld hl, $0458
    call SetRequestPtrC921_B13
    ret

Jump_013_46E8::
    ld hl, $0459
    call SetRequestPtrC921_B13
    ret

Jump_013_46EF::
    farcall Func_085_594E
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_4701
    ld hl, $045B
    call SetRequestPtrC921_B13
    ret

Jump_013_4701::
    dec a
    jr nz, Jump_013_470B
    ld hl, $045C
    call SetRequestPtrC921_B13
    ret

Jump_013_470B::
    ld hl, $6091
    call SetRequestPtrC91A_B13
    ret

Jump_013_4712::
    ld a, $00
    ld [wC921], a
    ld a, $4E
    ld [wC922], a
    ld de, $00AB
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_4723::
    ld a, $00
    ld [wC921], a
    ld a, $39
    ld [wC922], a
    ld de, $00AC
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_4734::
    ld de, $00AD
    call TestFlagBit
    jr c, Jump_013_4743
    ld hl, $6096
    call SetRequestPtrC91A_B13
    ret

Jump_013_4743::
    ld hl, $60B0
    call SetRequestPtrC91A_B13
    ret

Jump_013_474A::
    ld a, $00
    ld [wC921], a
    ld a, $3A
    ld [wC922], a
    ld de, $00AF
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_475B::
    farcall Func_085_5A75
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_476D
    ld hl, $60C7
    call SetRequestPtrC91A_B13
    ret

Jump_013_476D::
    ld hl, $0461
    call SetRequestPtrC921_B13
    ret

Jump_013_4774::
    ld hl, $0462
    call SetRequestPtrC921_B13
    ret

Jump_013_477B::
    ld hl, $60CE
    call SetRequestPtrC91A_B13
    ret

Jump_013_4782::
    ld hl, $04A8
    call SetRequestPtrC921_B13
    ret

Jump_013_4789::
    ld hl, $04A9
    call SetRequestPtrC921_B13
    ret

Jump_013_4790::
    ld hl, $60D0
    call SetRequestPtrC91A_B13
    ret

Jump_013_4797::
    ld hl, $0463
    call SetRequestPtrC921_B13
    ret

Jump_013_479E::
    ld hl, $040E
    call SetRequestPtrC921_B13
    ret

Jump_013_47A5::
    ld de, $00B2
    call TestFlagBit
    jr c, Jump_013_47B4
    ld hl, $60D4
    call SetRequestPtrC91A_B13
    ret

Jump_013_47B4::
    ld hl, $040E
    call SetRequestPtrC921_B13
    ret

Jump_013_47BB::
    ld de, $00B3
    call TestFlagBit
    jr c, Jump_013_47CA
    ld hl, $60EA
    call SetRequestPtrC91A_B13
    ret

Jump_013_47CA::
    ld hl, $6103
    call SetRequestPtrC91A_B13
    ret

Jump_013_47D1::
    ld a, $00
    ld [wC921], a
    ld a, $3B
    ld [wC922], a
    ld de, $00B5
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_47E2::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_47F1
    ld hl, $046D
    call SetRequestPtrC921_B13
    ret

Jump_013_47F1::
    ld hl, $049D
    call SetRequestPtrC921_B13
    ret

Jump_013_47F8::
    ld hl, $046E
    call SetRequestPtrC921_B13
    ret

Jump_013_47FF::
    ld hl, $046F
    call SetRequestPtrC921_B13
    ret

Jump_013_4806::
    ld de, $00C2
    call TestFlagBit
    jr c, Jump_013_485D
    ld de, $00B8
    call TestFlagBit
    jr c, Jump_013_4856
    ld a, $39
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4848
    ld a, $3A
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4848
    ld a, $3B
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4848
    jr Jump_013_484F

Jump_013_4848::
    ld hl, $0470
    call SetRequestPtrC921_B13
    ret

Jump_013_484F::
    ld hl, $6126
    call SetRequestPtrC91A_B13
    ret

Jump_013_4856::
    ld hl, $0472
    call SetRequestPtrC921_B13
    ret

Jump_013_485D::
    ld hl, $049E
    call SetRequestPtrC921_B13
    ret

Jump_013_4864::
    ld a, $01
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $0200
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_4875::
    ld hl, $6131
    call SetRequestPtrC91A_B13
    ret

Jump_013_487C::
    ld hl, $6059
    call SetRequestPtrC91A_B13
    ret

Jump_013_4883::
    ld hl, $0DE2
    call SetRequestPtrC921_B13
    ret

Jump_013_488A::
    ld hl, $0476
    call SetRequestPtrC921_B13
    ret

Jump_013_4891::
    ld hl, $0477
    call SetRequestPtrC921_B13
    ret

Jump_013_4898::
    ld hl, $0478
    call SetRequestPtrC921_B13
    ret

Jump_013_489F::
    ld a, $00
    ld [wC921], a
    ld a, $03
    ld [wC922], a
    ld de, $00BC
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_48B0::
    ld hl, $0450
    call SetRequestPtrC921_B13
    ret

Jump_013_48B7::
    ld a, $00
    ld [wC921], a
    ld a, $60
    ld [wC922], a
    ld de, $00BD
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_48C8::
    ld a, $00
    ld [wC921], a
    ld a, $25
    ld [wC922], a
    ld de, $00BE
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_48D9::
    ld a, $00
    ld [wC921], a
    ld a, $45
    ld [wC922], a
    ld de, $00BF
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_48EA::
    ld de, $00C0
    call TestFlagBit
    jr c, Jump_013_4962
    ld a, $39
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4924
    ld a, $3A
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4924
    ld a, $3B
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_4924
    jr Jump_013_492B

Jump_013_4924::
    ld hl, $0479
    call SetRequestPtrC921_B13
    ret

Jump_013_492B::
    ld a, $39
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld a, $3A
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld a, $3B
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld hl, $6133
    call SetRequestPtrC91A_B13
    ret

Jump_013_4962::
    ld hl, $614A
    call SetRequestPtrC91A_B13
    ret

Jump_013_4969::
    ld hl, $6152
    call SetRequestPtrC91A_B13
    ret

Jump_013_4970::
    ld hl, $6198
    call SetRequestPtrC91A_B13
    ret

Jump_013_4977::
    xor a, a
    ld [wCB96], a
    ldh a, [hPlayerY]
    cp a, $70
    ret z
    ld hl, $618B
    call SetRequestPtrC91A_B13
    ret

Jump_013_4987::
    ld hl, $04A6
    call SetRequestPtrC921_B13
    ret

Jump_013_498E::
    ld hl, $04A4
    call SetRequestPtrC921_B13
    ret

Jump_013_4995::
    ld hl, $04A5
    call SetRequestPtrC921_B13
    ret

Jump_013_499C::
    farcall Func_085_5A75
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_49AE
    ld hl, $60C7
    call SetRequestPtrC91A_B13
    ret

Jump_013_49AE::
    ld hl, $04A0
    call SetRequestPtrC921_B13
    ret

Jump_013_49B5::
    farcall Func_085_5A75
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_49C7
    ld hl, $60C7
    call SetRequestPtrC91A_B13
    ret

Jump_013_49C7::
    ld hl, $04A1
    call SetRequestPtrC921_B13
    ret

Jump_013_49CE::
    ld hl, $0413
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC955, hMapId
; writes: wC955, hMapId, wC8C8, wC8C9, wJoypadHeld, wJoypadPressed, wC8CA, wC914, ...
Func_013_49D5:: ; heuristic: follows a terminator; C0
    ld a, [wC955]
    or a, a
    ret z
    xor a, a
    ld [wC955], a
    ldh a, [hMapId]
    cp a, $7F
    jr nz, Jump_013_49F4
    ld a, $92
    ldh [hMapId], a
    ld a, $40
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    jr Jump_013_4A02

Jump_013_49F4::
    ld a, $7F
    ldh [hMapId], a
    ld a, $40
    ld [wC8C8], a
    ld a, $10
    ld [wC8C9], a

Jump_013_4A02::
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    xor a, a
    ld [wC8CA], a
    xor a, a
    ld [wC914], a
    ld a, $06
    ld [wModeState], a
    xor a, a
    ld [wC46B], a
    ld [wC46C], a
    ld a, $01
    ld [wC8C6], a
    ret

Jump_013_4A23::
    ld a, [wC916]
    rst $00
    dw Jump_013_4B7D
    dw Jump_013_4B84
    dw Jump_013_4B8B
    dw Jump_013_4B92
    dw Jump_013_4B99
    dw Jump_013_4BAF
    dw Jump_013_4BC5
    dw Jump_013_4BDB
    dw Jump_013_4BF1
    dw Jump_013_4BF8
    dw Jump_013_4C0E
    dw Jump_013_4C24
    dw Jump_013_4C51
    dw Jump_013_4C67
    dw Jump_013_4C78
    dw Jump_013_4C7F
    dw Jump_013_4C90
    dw Jump_013_4C97
    dw Jump_013_4C9E
    dw Jump_013_4CAA
    dw Jump_013_4CB1
    dw Jump_013_4CF7
    dw Jump_013_4D2B
    dw Jump_013_4D41
    dw Jump_013_4D57
    dw Jump_013_4D9A
    dw Jump_013_4DA1
    dw Jump_013_4DA8
    dw Jump_013_4DAF
    dw Jump_013_4DC5
    dw Jump_013_4DCC
    dw Jump_013_4DE2
    dw Jump_013_4DF8
    dw Jump_013_4DFF
    dw Jump_013_4E15
    dw Jump_013_4E1C
    dw Jump_013_4E32
    dw Jump_013_4E48
    dw Jump_013_4E5E
    dw Jump_013_4E65
    dw Jump_013_4E7B
    dw Jump_013_4E82
    dw Jump_013_4E93
    dw Jump_013_4EA4
    dw Jump_013_4EB5
    dw Jump_013_4EC1
    dw Jump_013_4EC8
    dw Jump_013_4ECF
    dw Jump_013_4ED6
    dw Jump_013_4EDD
    dw Jump_013_4EF3
    dw Jump_013_4EFA
    dw Jump_013_4F10
    dw Jump_013_4F43
    dw Jump_013_4F4A
    dw Jump_013_4F56
    dw Jump_013_4F5D
    dw Jump_013_4F73
    dw Jump_013_4F98
    dw Jump_013_4FBD
    dw Jump_013_4FD3
    dw Jump_013_4FF8
    dw Jump_013_501D
    dw Jump_013_5033
    dw Jump_013_503A
    dw Jump_013_5041
    dw Jump_013_5048
    dw Jump_013_504F
    dw Jump_013_5056
    dw Jump_013_505D
    dw Jump_013_5064
    dw Jump_013_506B
    dw Jump_013_507C
    dw Jump_013_5114
    dw Jump_013_5130
    dw Jump_013_5137
    dw Jump_013_513E
    dw Jump_013_5145
    dw Jump_013_51AF
    dw Jump_013_51B6
    dw Jump_013_51CC
    dw Jump_013_51E2
    dw Jump_013_51E9
    dw Jump_013_51FF
    dw Jump_013_5215
    dw Jump_013_523A
    dw Jump_013_5250
    dw Jump_013_5257
    dw Jump_013_525E
    dw Jump_013_5274
    dw Jump_013_528A
    dw Jump_013_52A0
    dw Jump_013_52A7
    dw Jump_013_52B8
    dw Jump_013_52BF
    dw Jump_013_52CB
    dw Jump_013_52DC
    dw Jump_013_52F2
    dw Jump_013_52F9
    dw Jump_013_5300
    dw Jump_013_5307
    dw Jump_013_530E
    dw Jump_013_5315
    dw Jump_013_533A
    dw Jump_013_535F
    dw Jump_013_5384
    dw Jump_013_538B
    dw Jump_013_53A1
    dw Jump_013_53A8
    dw Jump_013_53BE
    dw Jump_013_53D4
    dw Jump_013_53E8
    dw Jump_013_544B
    dw Jump_013_5452
    dw Jump_013_5477
    dw Jump_013_54CA
    dw Jump_013_54D1
    dw Jump_013_54E7
    dw Jump_013_54FD
    dw Jump_013_5513
    dw Jump_013_5529
    dw Jump_013_5530
    dw Jump_013_5546
    dw Jump_013_555C
    dw Jump_013_5563
    dw Jump_013_559D
    dw Jump_013_55AE
    dw Jump_013_55C4
    dw Data_013_55CB
    dw Data_013_55D7
    dw Data_013_55DE
    dw Data_013_55EA
    dw Data_013_55F6
    dw Data_013_55FD
    dw Data_013_5604
    dw Data_013_5610
    dw Data_013_5617
    dw Data_013_561E
    dw Data_013_5625
    dw Data_013_564A
    dw Func_013_5660
    dw Func_013_5685
    dw Func_013_56EF
    dw Func_013_570D
    dw Func_013_5732
    dw Data_013_5777
    dw Data_013_577E
    dw Data_013_5794
    dw Data_013_579B
    dw Data_013_579B
    dw Data_013_57A2
    dw Data_013_57A9
    dw Data_013_57B0
    dw Data_013_57B7
    dw Data_013_5803
    dw Data_013_581F
    dw Data_013_5826
    dw Data_013_585A
    dw Data_013_586B
    dw Data_013_5870
    dw Data_013_5877
    dw Data_013_5894
    dw Func_013_58AB
    dw Func_013_58BC
    dw Func_013_58CD
    dw Func_013_58DE
    dw Func_013_58EF
    dw Func_013_5900
    dw Func_013_5911
    dw Func_013_5922
    db $33, $59

Jump_013_4B7D::
    ld hl, $0300
    call SetRequestPtrC921_B13
    ret

Jump_013_4B84::
    ld hl, $0301
    call SetRequestPtrC921_B13
    ret

Jump_013_4B8B::
    ld hl, $0302
    call SetRequestPtrC921_B13
    ret

Jump_013_4B92::
    ld hl, $0303
    call SetRequestPtrC921_B13
    ret

Jump_013_4B99::
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BA8
    ld hl, $0304
    call SetRequestPtrC921_B13
    ret

Jump_013_4BA8::
    ld hl, $0355
    call SetRequestPtrC921_B13
    ret

Jump_013_4BAF::
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BBE
    ld hl, $0305
    call SetRequestPtrC921_B13
    ret

Jump_013_4BBE::
    ld hl, $0356
    call SetRequestPtrC921_B13
    ret

Jump_013_4BC5::
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4BD4
    ld hl, $0306
    call SetRequestPtrC921_B13
    ret

Jump_013_4BD4::
    ld hl, $0357
    call SetRequestPtrC921_B13
    ret

Jump_013_4BDB::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4BEA
    ld hl, $0307
    call SetRequestPtrC921_B13
    ret

Jump_013_4BEA::
    ld hl, $0A0B
    call SetRequestPtrC921_B13
    ret

Jump_013_4BF1::
    ld hl, $5D5B
    call SetRequestPtrC91A_B13
    ret

Jump_013_4BF8::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4C07
    ld hl, $030B
    call SetRequestPtrC921_B13
    ret

Jump_013_4C07::
    ld hl, $0D21
    call SetRequestPtrC921_B13
    ret

Jump_013_4C0E::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4C1D
    ld hl, $030C
    call SetRequestPtrC921_B13
    ret

Jump_013_4C1D::
    ld hl, $0DF2
    call SetRequestPtrC921_B13
    ret

Jump_013_4C24::
    ld de, $0081
    call TestFlagBit
    jr c, Jump_013_4C4A
    ld a, $32
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_4C43
    ld hl, $030E
    call SetRequestPtrC921_B13
    ret

Jump_013_4C43::
    ld hl, $5D8A
    call SetRequestPtrC91A_B13
    ret

Jump_013_4C4A::
    ld hl, $031D
    call SetRequestPtrC921_B13
    ret

Jump_013_4C51::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4C60
    ld hl, $030F
    call SetRequestPtrC921_B13
    ret

Jump_013_4C60::
    ld hl, $037A
    call SetRequestPtrC921_B13
    ret

Jump_013_4C67::
    ld a, $07
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5D68
    call SetRequestPtrC91A_B13
    ret

Jump_013_4C78::
    ld hl, $0311
    call SetRequestPtrC921_B13
    ret

Jump_013_4C7F::
    ld a, $01
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $01E6
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_4C90::
    ld hl, $0313
    call SetRequestPtrC921_B13
    ret

Jump_013_4C97::
    ld hl, $0314
    call SetRequestPtrC921_B13
    ret

Jump_013_4C9E::
    ld hl, $5D6F
    call SetRequestPtrC91A_B13
    ld a, $10
    ld [wDataBank], a
    ret

Jump_013_4CAA::
    ld hl, $0315
    call SetRequestPtrC921_B13
    ret

Jump_013_4CB1::
    ld de, $01E4
    call TestFlagBit
    jr c, Jump_013_4CED
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_4CD7
    ld de, $01E8
    call TestFlagBit
    jr c, Jump_013_4CD0
    ld hl, $5D76
    call SetRequestPtrC91A_B13
    ret

Jump_013_4CD0::
    ld hl, $031B
    call SetRequestPtrC921_B13
    ret

Jump_013_4CD7::
    ld de, $01E3
    call TestFlagBit
    jr c, Jump_013_4CE6
    ld hl, $5FCD
    call SetRequestPtrC91A_B13
    ret

Jump_013_4CE6::
    ld hl, $5FD2
    call SetRequestPtrC91A_B13
    ret

Jump_013_4CED::
    xor a, a
    set 0, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

Jump_013_4CF7::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D24
    ld de, $0087
    call TestFlagBit
    jr c, Jump_013_4D1D
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4D16
    ld hl, $031E
    call SetRequestPtrC921_B13
    ret

Jump_013_4D16::
    ld hl, $0358
    call SetRequestPtrC921_B13
    ret

Jump_013_4D1D::
    ld hl, $0ABA
    call SetRequestPtrC921_B13
    ret

Jump_013_4D24::
    ld hl, $0379
    call SetRequestPtrC921_B13
    ret

Jump_013_4D2B::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D3A
    ld hl, $031F
    call SetRequestPtrC921_B13
    ret

Jump_013_4D3A::
    ld hl, $0377
    call SetRequestPtrC921_B13
    ret

Jump_013_4D41::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D50
    ld hl, $0320
    call SetRequestPtrC921_B13
    ret

Jump_013_4D50::
    ld hl, $0378
    call SetRequestPtrC921_B13
    ret

Jump_013_4D57::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4D93
    ld de, $0087
    call TestFlagBit
    jr c, Jump_013_4D8C
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4D85
    ld de, $0082
    call TestFlagBit
    jr c, Jump_013_4D7E
    ld hl, $5D97
    call SetRequestPtrC91A_B13
    ret

Jump_013_4D7E::
    ld hl, $0323
    call SetRequestPtrC921_B13
    ret

Jump_013_4D85::
    ld hl, $5DA6
    call SetRequestPtrC91A_B13
    ret

Jump_013_4D8C::
    ld hl, $0ABB
    call SetRequestPtrC921_B13
    ret

Jump_013_4D93::
    ld hl, $0376
    call SetRequestPtrC921_B13
    ret

Jump_013_4D9A::
    ld hl, $0ABD
    call SetRequestPtrC921_B13
    ret

Jump_013_4DA1::
    ld hl, $0ABE
    call SetRequestPtrC921_B13
    ret

Jump_013_4DA8::
    ld hl, $0ABC
    call SetRequestPtrC921_B13
    ret

Jump_013_4DAF::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DBE
    ld hl, $0324
    call SetRequestPtrC921_B13
    ret

Jump_013_4DBE::
    ld hl, $0AC3
    call SetRequestPtrC921_B13
    ret

Jump_013_4DC5::
    ld hl, $0325
    call SetRequestPtrC921_B13
    ret

Jump_013_4DCC::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DDB
    ld hl, $0326
    call SetRequestPtrC921_B13
    ret

Jump_013_4DDB::
    ld hl, $0A0C
    call SetRequestPtrC921_B13
    ret

Jump_013_4DE2::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4DF1
    ld hl, $0327
    call SetRequestPtrC921_B13
    ret

Jump_013_4DF1::
    ld hl, $0AC4
    call SetRequestPtrC921_B13
    ret

Jump_013_4DF8::
    ld hl, $0328
    call SetRequestPtrC921_B13
    ret

Jump_013_4DFF::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E0E
    ld hl, $0329
    call SetRequestPtrC921_B13
    ret

Jump_013_4E0E::
    ld hl, $0A0D
    call SetRequestPtrC921_B13
    ret

Jump_013_4E15::
    ld hl, $032A
    call SetRequestPtrC921_B13
    ret

Jump_013_4E1C::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E2B
    ld hl, $032B
    call SetRequestPtrC921_B13
    ret

Jump_013_4E2B::
    ld hl, $0A0E
    call SetRequestPtrC921_B13
    ret

Jump_013_4E32::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4E41
    ld hl, $032C
    call SetRequestPtrC921_B13
    ret

Jump_013_4E41::
    ld hl, $037B
    call SetRequestPtrC921_B13
    ret

Jump_013_4E48::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E57
    ld hl, $032D
    call SetRequestPtrC921_B13
    ret

Jump_013_4E57::
    ld hl, $0DF5
    call SetRequestPtrC921_B13
    ret

Jump_013_4E5E::
    ld hl, $032E
    call SetRequestPtrC921_B13
    ret

Jump_013_4E65::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4E74
    ld hl, $032F
    call SetRequestPtrC921_B13
    ret

Jump_013_4E74::
    ld hl, $0DF6
    call SetRequestPtrC921_B13
    ret

Jump_013_4E7B::
    ld hl, $0330
    call SetRequestPtrC921_B13
    ret

Jump_013_4E82::
    ld a, $0A
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5DB0
    call SetRequestPtrC91A_B13
    ret

Jump_013_4E93::
    ld a, $08
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5DB7
    call SetRequestPtrC91A_B13
    ret

Jump_013_4EA4::
    ld a, $09
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5DBE
    call SetRequestPtrC91A_B13
    ret

Jump_013_4EB5::
    ld a, $1F
    ld [wDataBank], a
    ld hl, $5DCC
    call SetRequestPtrC91A_B13
    ret

Jump_013_4EC1::
    ld hl, $0312
    call SetRequestPtrC921_B13
    ret

Jump_013_4EC8::
    ld hl, $0D3B
    call SetRequestPtrC921_B13
    ret

Jump_013_4ECF::
    ld hl, $0314
    call SetRequestPtrC921_B13
    ret

Jump_013_4ED6::
    ld hl, $0313
    call SetRequestPtrC921_B13
    ret

Jump_013_4EDD::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4EEC
    ld hl, $0334
    call SetRequestPtrC921_B13
    ret

Jump_013_4EEC::
    ld hl, $0A0F
    call SetRequestPtrC921_B13
    ret

Jump_013_4EF3::
    ld hl, $0335
    call SetRequestPtrC921_B13
    ret

Jump_013_4EFA::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_4F09
    ld hl, $0336
    call SetRequestPtrC921_B13
    ret

Jump_013_4F09::
    ld hl, $0A10
    call SetRequestPtrC921_B13
    ret

Jump_013_4F10::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_4F1F
    ld hl, $0337
    call SetRequestPtrC921_B13
    ret

Jump_013_4F1F::
    ld a, $34
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_4F3C
    ld hl, $0AE6
    call SetRequestPtrC921_B13
    ld de, $009E
    call SetFlagBit
    ret

Jump_013_4F3C::
    ld hl, $0D20
    call SetRequestPtrC921_B13
    ret

Jump_013_4F43::
    ld hl, $0ABF
    call SetRequestPtrC921_B13
    ret

Jump_013_4F4A::
    ld hl, $5DC5
    call SetRequestPtrC91A_B13
    ld a, $10
    ld [wDataBank], a
    ret

Jump_013_4F56::
    ld hl, $0338
    call SetRequestPtrC921_B13
    ret

Jump_013_4F5D::
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4F6C
    ld hl, $0339
    call SetRequestPtrC921_B13
    ret

Jump_013_4F6C::
    ld hl, $034E
    call SetRequestPtrC921_B13
    ret

Jump_013_4F73::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4F91
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4F8A
    ld hl, $033A
    call SetRequestPtrC921_B13
    ret

Jump_013_4F8A::
    ld hl, $034F
    call SetRequestPtrC921_B13
    ret

Jump_013_4F91::
    ld hl, $037C
    call SetRequestPtrC921_B13
    ret

Jump_013_4F98::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4FB6
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4FAF
    ld hl, $033B
    call SetRequestPtrC921_B13
    ret

Jump_013_4FAF::
    ld hl, $0350
    call SetRequestPtrC921_B13
    ret

Jump_013_4FB6::
    ld hl, $037D
    call SetRequestPtrC921_B13
    ret

Jump_013_4FBD::
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4FCC
    ld hl, $033C
    call SetRequestPtrC921_B13
    ret

Jump_013_4FCC::
    ld hl, $0351
    call SetRequestPtrC921_B13
    ret

Jump_013_4FD3::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_4FF1
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_4FEA
    ld hl, $033D
    call SetRequestPtrC921_B13
    ret

Jump_013_4FEA::
    ld hl, $0352
    call SetRequestPtrC921_B13
    ret

Jump_013_4FF1::
    ld hl, $0D1C
    call SetRequestPtrC921_B13
    ret

Jump_013_4FF8::
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_5016
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_500F
    ld hl, $033E
    call SetRequestPtrC921_B13
    ret

Jump_013_500F::
    ld hl, $0353
    call SetRequestPtrC921_B13
    ret

Jump_013_5016::
    ld hl, $0D1D
    call SetRequestPtrC921_B13
    ret

Jump_013_501D::
    ld de, $0086
    call TestFlagBit
    jr c, Jump_013_502C
    ld hl, $033F
    call SetRequestPtrC921_B13
    ret

Jump_013_502C::
    ld hl, $0354
    call SetRequestPtrC921_B13
    ret

Jump_013_5033::
    ld hl, $0340
    call SetRequestPtrC921_B13
    ret

Jump_013_503A::
    ld hl, $0345
    call SetRequestPtrC921_B13
    ret

Jump_013_5041::
    ld hl, $0341
    call SetRequestPtrC921_B13
    ret

Jump_013_5048::
    ld hl, $0342
    call SetRequestPtrC921_B13
    ret

Jump_013_504F::
    ld hl, $0344
    call SetRequestPtrC921_B13
    ret

Jump_013_5056::
    ld hl, $0343
    call SetRequestPtrC921_B13
    ret

Jump_013_505D::
    ld hl, $5DD3
    call SetRequestPtrC91A_B13
    ret

Jump_013_5064::
    ld hl, $5E02
    call SetRequestPtrC91A_B13
    ret

Jump_013_506B::
    ld a, $00
    ld [wC921], a
    ld a, $40
    ld [wC922], a
    ld de, $0084
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_507C::
    ld de, $01E5
    call TestFlagBit
    jp c, Jump_013_510D
    ld de, $0094
    call TestFlagBit
    jr c, Jump_013_5106
    ld de, $0093
    call TestFlagBit
    jr c, Jump_013_50FF
    ld de, $008E
    call TestFlagBit
    jr c, Jump_013_50F8
    ld de, $008D
    call TestFlagBit
    jr c, Jump_013_50EB
    ld de, $008C
    call TestFlagBit
    jr c, Jump_013_50DE
    ld de, $008B
    call TestFlagBit
    jr c, Jump_013_50D1
    ld de, $0088
    call TestFlagBit
    jr c, Jump_013_50CA
    ld hl, $035C
    call SetRequestPtrC921_B13
    ld de, $0088
    call SetFlagBit
    ret

Jump_013_50CA::
    ld hl, $035D
    call SetRequestPtrC921_B13
    ret

Jump_013_50D1::
    ld hl, $0367
    call SetRequestPtrC921_B13
    ld de, $008C
    call SetFlagBit
    ret

Jump_013_50DE::
    ld hl, $0368
    call SetRequestPtrC921_B13
    ld de, $008D
    call SetFlagBit
    ret

Jump_013_50EB::
    ld hl, $0369
    call SetRequestPtrC921_B13
    ld de, $008E
    call SetFlagBit
    ret

Jump_013_50F8::
    ld hl, $036A
    call SetRequestPtrC921_B13
    ret

Jump_013_50FF::
    ld hl, $0373
    call SetRequestPtrC921_B13
    ret

Jump_013_5106::
    ld hl, $0375
    call SetRequestPtrC921_B13
    ret

Jump_013_510D::
    ld hl, $0AC2
    call SetRequestPtrC921_B13
    ret

Jump_013_5114::
    ld de, $0089
    call TestFlagBit
    jr c, Jump_013_5129
    ld hl, $035E
    call SetRequestPtrC921_B13
    ld de, $0089
    call SetFlagBit
    ret

Jump_013_5129::
    ld hl, $035F
    call SetRequestPtrC921_B13
    ret

Jump_013_5130::
    ld hl, $5E2F
    call SetRequestPtrC91A_B13
    ret

Jump_013_5137::
    ld hl, $5E37
    call SetRequestPtrC91A_B13
    ret

Jump_013_513E::
    ld hl, $5E5A
    call SetRequestPtrC91A_B13
    ret

Jump_013_5145::
    ld de, $0093
    call TestFlagBit
    jr c, Jump_013_51A8
    ld de, $0092
    call TestFlagBit
    jr c, Jump_013_51A1
    ld de, $0091
    call TestFlagBit
    jr c, Jump_013_5194
    ld de, $0090
    call TestFlagBit
    jr c, Jump_013_5187
    ld de, $008F
    call TestFlagBit
    jr c, Jump_013_517A
    ld hl, $036C
    call SetRequestPtrC921_B13
    ld de, $008F
    call SetFlagBit
    ret

Jump_013_517A::
    ld hl, $036D
    call SetRequestPtrC921_B13
    ld de, $0090
    call SetFlagBit
    ret

Jump_013_5187::
    ld hl, $036E
    call SetRequestPtrC921_B13
    ld de, $0091
    call SetFlagBit
    ret

Jump_013_5194::
    ld hl, $036F
    call SetRequestPtrC921_B13
    ld de, $0092
    call SetFlagBit
    ret

Jump_013_51A1::
    ld hl, $5E67
    call SetRequestPtrC91A_B13
    ret

Jump_013_51A8::
    ld hl, $5E77
    call SetRequestPtrC91A_B13
    ret

Jump_013_51AF::
    ld hl, $037E
    call SetRequestPtrC921_B13
    ret

Jump_013_51B6::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_51C5
    ld hl, $037F
    call SetRequestPtrC921_B13
    ret

Jump_013_51C5::
    ld hl, $0D3D
    call SetRequestPtrC921_B13
    ret

Jump_013_51CC::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_51DB
    ld hl, $0380
    call SetRequestPtrC921_B13
    ret

Jump_013_51DB::
    ld hl, $0A11
    call SetRequestPtrC921_B13
    ret

Jump_013_51E2::
    ld hl, $0381
    call SetRequestPtrC921_B13
    ret

Jump_013_51E9::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_51F8
    ld hl, $0382
    call SetRequestPtrC921_B13
    ret

Jump_013_51F8::
    ld hl, $0DC8
    call SetRequestPtrC921_B13
    ret

Jump_013_51FF::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_520E
    ld hl, $0383
    call SetRequestPtrC921_B13
    ret

Jump_013_520E::
    ld hl, $0A12
    call SetRequestPtrC921_B13
    ret

Jump_013_5215::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5233
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_522C
    ld hl, $0384
    call SetRequestPtrC921_B13
    ret

Jump_013_522C::
    ld hl, $0AE0
    call SetRequestPtrC921_B13
    ret

Jump_013_5233::
    ld hl, $0D22
    call SetRequestPtrC921_B13
    ret

Jump_013_523A::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5249
    ld hl, $0385
    call SetRequestPtrC921_B13
    ret

Jump_013_5249::
    ld hl, $0DF3
    call SetRequestPtrC921_B13
    ret

Jump_013_5250::
    ld hl, $0386
    call SetRequestPtrC921_B13
    ret

Jump_013_5257::
    ld hl, $0387
    call SetRequestPtrC921_B13
    ret

Jump_013_525E::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_526D
    ld hl, $0388
    call SetRequestPtrC921_B13
    ret

Jump_013_526D::
    ld hl, $0AE1
    call SetRequestPtrC921_B13
    ret

Jump_013_5274::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5283
    ld hl, $0389
    call SetRequestPtrC921_B13
    ret

Jump_013_5283::
    ld hl, $0AE2
    call SetRequestPtrC921_B13
    ret

Jump_013_528A::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5299
    ld hl, $038A
    call SetRequestPtrC921_B13
    ret

Jump_013_5299::
    ld hl, $0D23
    call SetRequestPtrC921_B13
    ret

Jump_013_52A0::
    ld hl, $0312
    call SetRequestPtrC921_B13
    ret

Jump_013_52A7::
    ld a, $02
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $01E7
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_52B8::
    ld hl, $0313
    call SetRequestPtrC921_B13
    ret

Jump_013_52BF::
    ld hl, $5E87
    call SetRequestPtrC91A_B13
    ld a, $10
    ld [wDataBank], a
    ret

Jump_013_52CB::
    ld a, $0B
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5E8E
    call SetRequestPtrC91A_B13
    ret

Jump_013_52DC::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_52EB
    ld hl, $038C
    call SetRequestPtrC921_B13
    ret

Jump_013_52EB::
    ld hl, $0A13
    call SetRequestPtrC921_B13
    ret

Jump_013_52F2::
    ld hl, $038D
    call SetRequestPtrC921_B13
    ret

Jump_013_52F9::
    ld hl, $038E
    call SetRequestPtrC921_B13
    ret

Jump_013_5300::
    ld hl, $038F
    call SetRequestPtrC921_B13
    ret

Jump_013_5307::
    ld hl, $0390
    call SetRequestPtrC921_B13
    ret

Jump_013_530E::
    ld hl, $0391
    call SetRequestPtrC921_B13
    ret

Jump_013_5315::
    ld de, $0096
    call TestFlagBit
    jr c, Jump_013_5333
    ld de, $0095
    call TestFlagBit
    jr c, Jump_013_532C
    ld hl, $0392
    call SetRequestPtrC921_B13
    ret

Jump_013_532C::
    ld hl, $0AB9
    call SetRequestPtrC921_B13
    ret

Jump_013_5333::
    ld hl, $0ACB
    call SetRequestPtrC921_B13
    ret

Jump_013_533A::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5358
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_5351
    ld hl, $0393
    call SetRequestPtrC921_B13
    ret

Jump_013_5351::
    ld hl, $0D1E
    call SetRequestPtrC921_B13
    ret

Jump_013_5358::
    ld hl, $0ADE
    call SetRequestPtrC921_B13
    ret

Jump_013_535F::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_537D
    ld de, $0095
    call TestFlagBit
    jr c, Jump_013_5376
    ld hl, $5E95
    call SetRequestPtrC91A_B13
    ret

Jump_013_5376::
    ld hl, $0394
    call SetRequestPtrC921_B13
    ret

Jump_013_537D::
    ld hl, $0ADF
    call SetRequestPtrC921_B13
    ret

Jump_013_5384::
    ld hl, $0397
    call SetRequestPtrC921_B13
    ret

Jump_013_538B::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_539A
    ld hl, $0398
    call SetRequestPtrC921_B13
    ret

Jump_013_539A::
    ld hl, $0AD8
    call SetRequestPtrC921_B13
    ret

Jump_013_53A1::
    ld hl, $0399
    call SetRequestPtrC921_B13
    ret

Jump_013_53A8::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_53B7
    ld hl, $039A
    call SetRequestPtrC921_B13
    ret

Jump_013_53B7::
    ld hl, $0DE1
    call SetRequestPtrC921_B13
    ret

Jump_013_53BE::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_53CD
    ld hl, $039B
    call SetRequestPtrC921_B13
    ret

Jump_013_53CD::
    ld hl, $0AD9
    call SetRequestPtrC921_B13
    ret

Jump_013_53D4::
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_013_53E1
    ld hl, $0ADA
    call SetRequestPtrC921_B13
    ret

Jump_013_53E1::
    ld hl, $039C
    call SetRequestPtrC921_B13
    ret

Jump_013_53E8::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5444
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_543D
    ld de, $0096
    call TestFlagBit
    jr c, Jump_013_5436
    ld a, [wCB8A]
    cp a, $50
    jr nz, Jump_013_540E
    ld hl, $039D
    call SetRequestPtrC921_B13
    ret

Jump_013_540E::
    ld a, [wC6FD]
    cp a, $03
    jr nz, Jump_013_542F
    farcall Func_05F_6CA9
    ld a, [wC92C]
    or a, a
    jr nz, Jump_013_5428
    ld hl, $5EE6
    call SetRequestPtrC91A_B13
    ret

Jump_013_5428::
    ld hl, $039E
    call SetRequestPtrC921_B13
    ret

Jump_013_542F::
    ld hl, $039F
    call SetRequestPtrC921_B13
    ret

Jump_013_5436::
    ld hl, $03A5
    call SetRequestPtrC921_B13
    ret

Jump_013_543D::
    ld hl, $0ACD
    call SetRequestPtrC921_B13
    ret

Jump_013_5444::
    ld hl, $0ADB
    call SetRequestPtrC921_B13
    ret

Jump_013_544B::
    ld hl, $5EF5
    call SetRequestPtrC91A_B13
    ret

Jump_013_5452::
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5470
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_5469
    ld hl, $03A4
    call SetRequestPtrC921_B13
    ret

Jump_013_5469::
    ld hl, $0ACC
    call SetRequestPtrC921_B13
    ret

Jump_013_5470::
    ld hl, $0ADC
    call SetRequestPtrC921_B13
    ret

Jump_013_5477::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54C3
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_54BC
    ld de, $009C
    call TestFlagBit
    jr c, Jump_013_54B5
    ld de, $009B
    call TestFlagBit
    jr c, Jump_013_549E

Jump_013_5497::
    ld hl, $03A3
    call SetRequestPtrC921_B13
    ret

Jump_013_549E::
    ld a, $33
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_5497
    ld hl, $5FA5
    call SetRequestPtrC91A_B13
    ret

Jump_013_54B5::
    ld hl, $5FAD
    call SetRequestPtrC91A_B13
    ret

Jump_013_54BC::
    ld hl, $0AD7
    call SetRequestPtrC921_B13
    ret

Jump_013_54C3::
    ld hl, $0AC5
    call SetRequestPtrC921_B13
    ret

Jump_013_54CA::
    ld hl, $03A6
    call SetRequestPtrC921_B13
    ret

Jump_013_54D1::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54E0
    ld hl, $03A7
    call SetRequestPtrC921_B13
    ret

Jump_013_54E0::
    ld hl, $0AC6
    call SetRequestPtrC921_B13
    ret

Jump_013_54E7::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_54F6
    ld hl, $03A8
    call SetRequestPtrC921_B13
    ret

Jump_013_54F6::
    ld hl, $0A14
    call SetRequestPtrC921_B13
    ret

Jump_013_54FD::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_550C
    ld hl, $03A9
    call SetRequestPtrC921_B13
    ret

Jump_013_550C::
    ld hl, $0AC7
    call SetRequestPtrC921_B13
    ret

Jump_013_5513::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5522
    ld hl, $03AA
    call SetRequestPtrC921_B13
    ret

Jump_013_5522::
    ld hl, $0DF4
    call SetRequestPtrC921_B13
    ret

Jump_013_5529::
    ld hl, $03AB
    call SetRequestPtrC921_B13
    ret

Jump_013_5530::
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_553F
    ld hl, $03AE
    call SetRequestPtrC921_B13
    ret

Jump_013_553F::
    ld hl, $0A00
    call SetRequestPtrC921_B13
    ret

Jump_013_5546::
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_5555
    ld hl, $03AD
    call SetRequestPtrC921_B13
    ret

Jump_013_5555::
    ld hl, $0AFF
    call SetRequestPtrC921_B13
    ret

Jump_013_555C::
    ld hl, $03AF
    call SetRequestPtrC921_B13
    ret

Jump_013_5563::
    ld de, $0097
    call TestFlagBit
    jr c, Jump_013_5596
    ld a, $32
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_5582
    ld hl, $03B0
    call SetRequestPtrC921_B13
    ret

Jump_013_5582::
    ldh a, [hPlayerX]
    cp a, $41
    jr nc, Jump_013_558F
    ld hl, $5F26
    call SetRequestPtrC91A_B13
    ret

Jump_013_558F::
    ld hl, $5F38
    call SetRequestPtrC91A_B13
    ret

Jump_013_5596::
    ld hl, $03B2
    call SetRequestPtrC921_B13
    ret

Jump_013_559D::
    ld a, $0C
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5F0B
    call SetRequestPtrC91A_B13
    ret

Jump_013_55AE::
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_55BD
    ld hl, $03B4
    call SetRequestPtrC921_B13
    ret

Jump_013_55BD::
    ld hl, $0A15
    call SetRequestPtrC921_B13
    ret

Jump_013_55C4::
    ld hl, $5F12
    call SetRequestPtrC91A_B13
    ret

Data_013_55CB:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $1F, $EA, $FE, $D7, $21, $D6, $5F, $CD, $49, $40, $C9

Data_013_55D7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $E6, $5F, $CD, $49, $40, $C9

Data_013_55DE:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $1F, $EA, $FE, $D7, $21, $D6, $5F, $CD, $49, $40, $C9

Data_013_55EA:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $1F, $EA, $FE, $D7, $21, $D6, $5F, $CD, $49, $40, $C9

Data_013_55F6:: ; heuristic: target of a monotone pointer table; C0
    db $21, $13, $03, $CD, $01, $40, $C9

Data_013_55FD:: ; heuristic: target of a monotone pointer table; C0
    db $21, $12, $03, $CD, $01, $40, $C9

Data_013_5604:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1F, $5F, $CD, $49, $40, $3E, $10, $EA, $FE, $D7, $C9

Data_013_5610:: ; heuristic: target of a monotone pointer table; C0
    db $21, $B8, $03, $CD, $01, $40, $C9

Data_013_5617:: ; heuristic: target of a monotone pointer table; C0
    db $21, $AC, $03, $CD, $01, $40, $C9

Data_013_561E:: ; heuristic: target of a monotone pointer table; C0
    db $21, $96, $03, $CD, $01, $40, $C9

Data_013_5625:: ; heuristic: target of a monotone pointer table; C0
    db $11, $E2, $01, $CD, $1B, $18, $38, $16, $11, $9D, $00, $CD, $1B, $18, $38, $07
    db $21, $B9, $03, $CD, $01, $40, $C9, $21, $E3, $0A, $CD, $01, $40, $C9, $21, $FB
    db $0A, $CD, $01, $40, $C9

Data_013_564A:: ; heuristic: target of a monotone pointer table; C0
    db $11, $E2, $01, $CD, $1B, $18, $38, $07, $21, $D6, $0D, $CD, $01, $40, $C9, $21
    db $FC, $0A, $CD, $01, $40, $C9

; no direct call (reached through a table, a jump or a vector)
Func_013_5660:: ; heuristic: target of a pointer table; C0
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_567E
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5677
    ld hl, $0DD7
    call SetRequestPtrC921_B13
    ret

Jump_013_5677::
    ld hl, $0DC9
    call SetRequestPtrC921_B13
    ret

Jump_013_567E::
    ld hl, $0AFD
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6
Func_013_5685:: ; heuristic: target of a pointer table; C0
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_56E8
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_013_56E1
    ld de, $01F1
    call TestFlagBit
    jr c, Jump_013_56DA
    ld de, $009F
    call TestFlagBit
    jr c, Jump_013_56BB
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_56B4

Jump_013_56AD::
    ld hl, $0DD8
    call SetRequestPtrC921_B13
    ret

Jump_013_56B4::
    ld hl, $0AE4
    call SetRequestPtrC921_B13
    ret

Jump_013_56BB::
    ld de, $009D
    call TestFlagBit
    jr nc, Jump_013_56AD
    ld a, $34
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_56B4
    ld hl, $5FB8
    call SetRequestPtrC91A_B13
    ret

Jump_013_56DA::
    ld hl, $0AF8
    call SetRequestPtrC921_B13
    ret

Jump_013_56E1::
    ld hl, $0AF9
    call SetRequestPtrC921_B13
    ret

Jump_013_56E8::
    ld hl, $0AFA
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_56EF:: ; heuristic: target of a pointer table; C0
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_56FF
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5706

Jump_013_56FF::
    ld hl, $0DD9
    call SetRequestPtrC921_B13
    ret

Jump_013_5706::
    ld hl, $0AE5
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_570D:: ; heuristic: target of a pointer table; C0
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_572B
    ld de, $009D
    call TestFlagBit
    jr c, Jump_013_5724
    ld hl, $0DDA
    call SetRequestPtrC921_B13
    ret

Jump_013_5724::
    ld hl, $0D1F
    call SetRequestPtrC921_B13
    ret

Jump_013_572B::
    ld hl, $0AFE
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wCB86
Func_013_5732:: ; heuristic: target of a pointer table; C0
    ld de, $01E5
    call TestFlagBit
    jr c, Jump_013_5770
    ld de, $01E2
    call TestFlagBit
    jr c, Jump_013_5769
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_013_575E
    ld de, $01F1
    call TestFlagBit
    jr c, Jump_013_5759
    ld hl, $0DDB
    call SetRequestPtrC921_B13
    ret

Jump_013_5759::
    xor a, a
    ld [wCB86], a
    ret

Jump_013_575E::
    xor a, a
    ld [wCB86], a
    ld hl, $5FCB
    call SetRequestPtrC91A_B13
    ret

Jump_013_5769::
    ld hl, $0AF7
    call SetRequestPtrC921_B13
    ret

Jump_013_5770::
    ld hl, $0DE0
    call SetRequestPtrC921_B13
    ret

Data_013_5777:: ; heuristic: target of a monotone pointer table; C0
    db $21, $FF, $00, $CD, $01, $40, $C9

Data_013_577E:: ; heuristic: target of a monotone pointer table; C0
    db $11, $E5, $01, $CD, $1B, $18, $38, $07, $21, $DC, $0D, $CD, $01, $40, $C9, $21
    db $24, $0D, $CD, $01, $40, $C9

Data_013_5794:: ; heuristic: target of a monotone pointer table; C0
    db $21, $DD, $0D, $CD, $01, $40, $C9

Data_013_579B:: ; heuristic: target of a monotone pointer table; C0
    db $21, $C0, $0A, $CD, $01, $40, $C9

Data_013_57A2:: ; heuristic: target of a monotone pointer table; C0
    db $21, $C1, $0A, $CD, $01, $40, $C9

Data_013_57A9:: ; heuristic: target of a monotone pointer table; C0
    db $21, $BC, $0A, $CD, $01, $40, $C9

Data_013_57B0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $4A, $5F, $CD, $49, $40, $C9

Data_013_57B7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04D7B7, $4C

Data_013_5803:: ; heuristic: target of a monotone pointer table; C0
    db $FA, $9A, $CB, $FE, $80, $20, $0E, $FA, $9B, $CB, $FE, $10, $20, $07, $21, $CE
    db $0A, $CD, $01, $40, $C9, $21, $AD, $5F, $CD, $49, $40, $C9

Data_013_581F:: ; heuristic: target of a monotone pointer table; C0
    db $21, $16, $0A, $CD, $01, $40, $C9

Data_013_5826:: ; heuristic: target of a monotone pointer table; C0
    db $11, $9F, $00, $CD, $1B, $18, $38, $02, $18, $07, $21, $E8, $0A, $CD, $01, $40
    db $C9, $CD, $94, $7F, $30, $17, $36, $34, $FA, $36, $C8, $CB, $F7, $EA, $36, $C8
    db $21, $E7, $0A, $CD, $01, $40, $11, $9F, $00, $CD, $45, $18, $C9, $21, $E9, $0A
    db $CD, $01, $40, $C9

Data_013_585A:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $03, $EA, $21, $C9, $3E, $00, $EA, $22, $C9, $11, $E0, $01, $CD, $25, $40
    db $C9

Data_013_586B:: ; heuristic: target of a monotone pointer table; C0
    db $AF, $EA, $A6, $CB, $C9

Data_013_5870:: ; heuristic: target of a monotone pointer table; C0
    db $21, $D2, $5F, $CD, $49, $40, $C9

Data_013_5877:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $94, $7F, $38, $07, $21, $27, $0D, $CD, $01, $40, $C9, $36, $32, $FA, $36
    db $C8, $CB, $F7, $EA, $36, $C8, $21, $DD, $5F, $CD, $49, $40, $C9

Data_013_5894:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $32, $E0, $C6, $21, $CE, $7D, $06, $12, $D7, $21, $F1, $7D, $06, $12, $D7
    db $21, $D4, $5F, $CD, $49, $40, $C9

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_58AB:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $25
    ld [wC922], a
    ld de, $01E9
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_58BC:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $41
    ld [wC922], a
    ld de, $01EA
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_58CD:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $52
    ld [wC922], a
    ld de, $01EB
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_58DE:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $17
    ld [wC922], a
    ld de, $01EC
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_58EF:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $23
    ld [wC922], a
    ld de, $01ED
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_5900:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5D
    ld [wC922], a
    ld de, $01EE
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_5911:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5B
    ld [wC922], a
    ld de, $01EF
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_5922:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $1E
    ld [wC922], a
    ld de, $01F0
    call SetRequestPtrC924FromDE_B13
    ret
    db $21, $C9, $5F, $CD, $49, $40, $C9

Jump_013_593A::
    ld hl, $512D
    call SetRequestPtrC91A_B13
    ret

Jump_013_5941::
    ld a, [wC916]
    rst $00
    dw Jump_013_5B33
    dw Jump_013_5B34
    dw Jump_013_5B3B
    dw Jump_013_5D43
    dw Jump_013_5D4A
    dw Jump_013_5D6F
    dw Jump_013_5D76
    dw Jump_013_5D7D
    dw Jump_013_5F63
    dw Jump_013_5F8E
    dw Jump_013_5FD2
    dw Jump_013_6048
    dw Jump_013_60AF
    dw Jump_013_6110
    dw Jump_013_6127
    dw Jump_013_616A
    dw Jump_013_618F
    dw Jump_013_621D
    dw Jump_013_62A9
    dw Jump_013_62FB
    dw Jump_013_6302
    dw Jump_013_6327
    dw Jump_013_6397
    dw Jump_013_6407
    dw Jump_013_645F
    dw Jump_013_647B
    dw Jump_013_65EC
    dw Jump_013_664D
    dw Jump_013_66ED
    dw Jump_013_678D
    dw Jump_013_67A3
    dw Jump_013_67C9
    dw Jump_013_67D0
    dw Jump_013_6832
    dw Jump_013_685D
    dw Jump_013_6873
    dw Jump_013_6898
    dw Jump_013_68BD
    dw Jump_013_68DB
    dw Jump_013_68E2
    dw Jump_013_6947
    dw Jump_013_694E
    dw Jump_013_6955
    dw Jump_013_695C
    dw Jump_013_6963
    dw Jump_013_696A
    dw Jump_013_6971
    dw Jump_013_6978
    dw Jump_013_699B
    dw Jump_013_69A2
    dw Jump_013_69B8
    dw Jump_013_69DA
    dw Jump_013_69DA
    dw Jump_013_69DA
    dw Jump_013_6A14
    dw Jump_013_6A1B
    dw Jump_013_6A22
    dw Jump_013_6A47
    dw Jump_013_6A6C
    dw Jump_013_6A82
    dw Jump_013_6A89
    dw Jump_013_6A90
    dw Jump_013_6A97
    dw Jump_013_6ABC
    dw Jump_013_6AC3
    dw Jump_013_6ACA
    dw Jump_013_6AD1
    dw Jump_013_6B32
    dw Jump_013_6B39
    dw Jump_013_6B40
    dw Jump_013_6B4E
    dw Jump_013_6B6F
    dw Jump_013_6B76
    dw Jump_013_6B7D
    dw Jump_013_6B84
    dw Jump_013_6B8B
    dw Jump_013_6BD4
    dw Jump_013_6BFA
    dw Jump_013_6C01
    dw Jump_013_6C08
    dw Jump_013_6C0F
    dw Jump_013_6C16
    dw Jump_013_6C1D
    dw Jump_013_6C24
    dw Jump_013_6C2B
    dw Jump_013_6C32
    dw Jump_013_6C48
    dw Jump_013_6C5E
    dw Jump_013_6C65
    dw Jump_013_6C6C
    dw Jump_013_6C73
    dw Jump_013_6C7A
    dw Jump_013_6C81
    dw Jump_013_6C88
    dw Jump_013_6C8F
    dw Jump_013_6CA5
    dw Jump_013_6CAC
    dw Jump_013_6CB3
    dw Jump_013_6D3A
    dw Jump_013_6D41
    dw Jump_013_6D52
    dw Jump_013_6D68
    dw Jump_013_6DD1
    dw Jump_013_6E09
    dw Jump_013_6E3D
    dw Jump_013_6E71
    dw Jump_013_6EA3
    dw Jump_013_6EDE
    dw Jump_013_6EE5
    dw Jump_013_6EEC
    dw Jump_013_6EF3
    dw Jump_013_6EFA
    dw Jump_013_6F01
    dw Jump_013_6F08
    dw Jump_013_6F0F
    dw Jump_013_6F41
    dw Jump_013_6F48
    dw Jump_013_6F4F
    dw Jump_013_6F56
    dw Jump_013_6F5D
    dw Jump_013_6FC5
    dw Jump_013_6FCC
    dw Jump_013_6FDD
    dw Jump_013_6FE4
    dw Jump_013_6FEB
    dw Jump_013_7002
    dw Jump_013_7019
    dw Jump_013_7030
    db $D2, $70
    dw Func_013_70D9
    dw Func_013_727A
    dw Func_013_72EE
    dw Func_013_731B
    db $39, $73, $40, $73, $56, $73, $5D, $73
    dw Func_013_7364
    dw Func_013_73BF
    dw Func_013_73E5
    dw Func_013_73F6
    dw Func_013_741C
    dw Func_013_7441
    dw Func_013_746A
    dw Func_013_74F1
    db $1F, $75, $26, $75, $72, $75, $79, $75, $80, $75, $80, $75, $80, $75
    dw Func_013_7581
    dw Func_013_7598
    dw Func_013_76BD
    dw Func_013_76CE
    dw Func_013_76DF
    dw Func_013_7708
    dw Func_013_772E
    dw Data_013_7727
    dw Data_013_774B
    dw Data_013_7752
    dw Data_013_7759
    dw Data_013_7760
    dw Data_013_7767
    dw Data_013_7788
    dw Data_013_778F
    dw Data_013_77A0
    dw Data_013_77B6
    dw Func_013_77BD
    dw Func_013_77D3
    dw Func_013_780F
    dw Func_013_781C
    dw Func_013_782D
    dw Data_013_7852
    dw Data_013_7859
    dw Data_013_7860
    dw Data_013_7876
    dw Data_013_787D
    dw Data_013_78A2
    dw Data_013_78B9
    dw Data_013_78D0
    dw Data_013_78D7
    dw Func_013_78DE
    dw Func_013_7910
    dw Func_013_7942
    dw Func_013_7958
    dw Func_013_796E
    dw Func_013_7984
    dw Data_013_799A
    dw Data_013_79A1
    dw Data_013_79A8
    dw Data_013_79AF
    dw Data_013_79B6
    dw Data_013_79BD
    dw Data_013_79C4
    dw Data_013_79DA
    dw Data_013_79F0
    dw Data_013_79F7
    dw Data_013_79FE
    dw Data_013_7A0F
    dw Data_013_7A16
    dw Data_013_7A1D
    dw Data_013_7A2E
    dw Data_013_7A35
    dw Data_013_7A4A
    dw Data_013_7A93
    dw Func_013_7A9A
    dw Func_013_7AA7
    dw Func_013_7ABD
    dw Func_013_7ACB
    dw Func_013_7ADC
    dw Func_013_7AED
    db $04, $7B
    dw Func_013_7B0B
    dw Func_013_7B21
    dw Func_013_7B46
    dw Func_013_7B64
    dw Data_013_7B8A
    dw Data_013_7B91
    dw Data_013_7CF7
    dw Data_013_7CFE
    dw Data_013_7D05
    dw Data_013_7D0C
    dw Data_013_7D13
    dw Data_013_7D1A
    dw Data_013_7D21
    dw Data_013_7D28
    dw Data_013_7D2F
    dw Data_013_7D45
    dw Data_013_7D65
    dw Data_013_7D8C
    db $00, $00
    dw Func_013_7D91
    dw Func_013_7DA7
    dw Func_013_7DC5
    dw Func_013_7DDB
    dw Func_013_7DEC
    db $FD, $7D, $00, $00
    dw Func_013_7E05
    dw Func_013_7E9F
    dw Func_013_7F02
    dw Func_013_7F31
    dw Func_013_7F4E
    dw Func_013_7F6A
    dw Func_013_7F86

Jump_013_5B33::
    ret

Jump_013_5B34::
    ld hl, $5895
    call SetRequestPtrC91A_B13
    ret

Jump_013_5B3B::
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_5BDF
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_5BD8
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_5BD6
    ld de, $0022
    call TestFlagBit
    jp c, Jump_013_5BD4
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_5BD0
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_5BB3
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5B8D
    ld de, $0003
    call TestFlagBit
    jr c, Jump_013_5B86
    ld hl, $4FA4
    call SetRequestPtrC91A_B13
    ret

Jump_013_5B86::
    ld hl, $0022
    call SetRequestPtrC921_B13
    ret

Jump_013_5B8D::
    ld de, $000D
    call TestFlagBit
    jr c, Jump_013_5BAC
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld hl, $4FAF
    call SetRequestPtrC91A_B13
    ld de, $000D
    call SetFlagBit
    ret

Jump_013_5BAC::
    ld hl, $006C
    call SetRequestPtrC921_B13
    ret

Jump_013_5BB3::
    ld de, $01A7
    call TestFlagBit
    jr c, Jump_013_5BC0
    call Func_013_7F94
    jr c, Jump_013_5BC7

Jump_013_5BC0::
    ld hl, $0102
    call SetRequestPtrC921_B13
    ret

Jump_013_5BC7::
    ld [hl], $01
    ld hl, $5175
    call SetRequestPtrC91A_B13
    ret

Jump_013_5BD0::
    call Func_013_5C0B
    ret

Jump_013_5BD4::
    jr Jump_013_5BD0

Jump_013_5BD6::
    jr Jump_013_5BD0

Jump_013_5BD8::
    ld hl, $0500
    call SetRequestPtrC921_B13
    ret

Jump_013_5BDF::
    ld de, $018A
    call TestFlagBit
    jr c, Jump_013_5C04
    ld de, $0180
    call TestFlagBit
    jr nc, Jump_013_5C04
    ld de, $0181
    call TestFlagBit
    jr c, Jump_013_5C04
    ld hl, $0D91
    call SetRequestPtrC921_B13
    ld de, $018A
    call SetFlagBit
    ret

Jump_013_5C04::
    ld hl, $0B00
    call SetRequestPtrC921_B13
    ret

; 1 call site from 1 routine (e.g. Func_013_5922)
; reads: hFFC6
; writes: hFFC6
Func_013_5C0B::
    ld de, $0182
    call TestFlagBit
    jr c, Jump_013_5C6D
    ld de, $0181
    call TestFlagBit
    jr c, Jump_013_5C60
    ld de, $0180
    call TestFlagBit
    jr c, Jump_013_5C36
    ld hl, $517F
    call SetRequestPtrC91A_B13
    ld de, $0104
    call SetFlagBit
    ld de, $0180
    call SetFlagBit
    ret

Jump_013_5C36::
    ld a, $02
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_5C4D
    ld hl, $0202
    call SetRequestPtrC921_B13
    ret

Jump_013_5C4D::
    farcall Func_012_7DF1
    ld hl, $522B
    call SetRequestPtrC91A_B13
    ld de, $0181
    call SetFlagBit
    ret

Jump_013_5C60::
    ld hl, $0214
    call SetRequestPtrC921_B13
    ld de, $0182
    call SetFlagBit
    ret

Jump_013_5C6D::
    ld de, $0184
    call TestFlagBit
    jr c, Jump_013_5CA8
    ld de, $0183
    call TestFlagBit
    jr c, Jump_013_5C84
    ld hl, $5189
    call SetRequestPtrC91A_B13
    ret

Jump_013_5C84::
    ld a, $04
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_5C9B
    ld hl, $08A5
    call SetRequestPtrC921_B13
    ret

Jump_013_5C9B::
    ld hl, $519F
    call SetRequestPtrC91A_B13
    farcall Func_012_7DF1
    ret

Jump_013_5CA8::
    ld de, $0186
    call TestFlagBit
    jr c, Jump_013_5CE3
    ld de, $0185
    call TestFlagBit
    jr c, Jump_013_5CBF
    ld hl, $51A9
    call SetRequestPtrC91A_B13
    ret

Jump_013_5CBF::
    ld a, $1B
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_5CD6
    ld hl, $08AA
    call SetRequestPtrC921_B13
    ret

Jump_013_5CD6::
    ld hl, $51BF
    call SetRequestPtrC91A_B13
    farcall Func_012_7DF1
    ret

Jump_013_5CE3::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_5CF2
    ld hl, $0205
    call SetRequestPtrC921_B13
    ret

Jump_013_5CF2::
    ld de, $018C
    call TestFlagBit
    jr c, Jump_013_5D3C
    ld de, $018B
    call TestFlagBit
    jr c, Jump_013_5D18
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5D11
    ld hl, $51F5
    call SetRequestPtrC91A_B13
    ret

Jump_013_5D11::
    ld hl, $520B
    call SetRequestPtrC91A_B13
    ret

Jump_013_5D18::
    ld a, $1C
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_5D2F
    ld hl, $0A27
    call SetRequestPtrC921_B13
    ret

Jump_013_5D2F::
    farcall Func_012_7DF1
    ld hl, $5221
    call SetRequestPtrC91A_B13
    ret

Jump_013_5D3C::
    ld hl, $0A2A
    call SetRequestPtrC921_B13
    ret

Jump_013_5D43::
    ld hl, $0023
    call SetRequestPtrC921_B13
    ret

Jump_013_5D4A::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_5D59
    ld hl, $001B
    call SetRequestPtrC921_B13
    ret

Jump_013_5D59::
    ld de, $012A
    call TestFlagBit
    jr c, Jump_013_5D68
    ld hl, $596B
    call SetRequestPtrC91A_B13
    ret

Jump_013_5D68::
    ld hl, $597B
    call SetRequestPtrC91A_B13
    ret

Jump_013_5D6F::
    ld hl, $0026
    call SetRequestPtrC921_B13
    ret

Jump_013_5D76::
    ld hl, $0027
    call SetRequestPtrC921_B13
    ret

Jump_013_5D7D::
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_5E7A
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_5E73
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_5E6C
    ld de, $0022
    call TestFlagBit
    jp c, Jump_013_5E68
    ld de, $0021
    call TestFlagBit
    jp c, Jump_013_5E61
    ld de, $0002
    call TestFlagBit
    jp c, Jump_013_5E14
    ld de, $000E
    call TestFlagBit
    jr c, Jump_013_5E0D
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5DF7
    ld de, $0014
    call TestFlagBit
    jr c, Jump_013_5DF0
    ld de, $0003
    call TestFlagBit
    jr c, Jump_013_5DDA
    ld hl, $0016
    call SetRequestPtrC921_B13
    ret

Jump_013_5DDA::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5DE9
    ld hl, $4FB7
    call SetRequestPtrC91A_B13
    ret

Jump_013_5DE9::
    ld hl, $4FD0
    call SetRequestPtrC91A_B13
    ret

Jump_013_5DF0::
    ld hl, $002E
    call SetRequestPtrC921_B13
    ret

Jump_013_5DF7::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_5E06
    ld hl, $4FE8
    call SetRequestPtrC91A_B13
    ret

Jump_013_5E06::
    ld hl, $4FF7
    call SetRequestPtrC91A_B13
    ret

Jump_013_5E0D::
    ld hl, $0064
    call SetRequestPtrC921_B13
    ret

Jump_013_5E14::
    ld de, $0100
    call TestFlagBit
    jr c, Jump_013_5E37
    call Func_013_7F94
    jr c, Jump_013_5E28
    ld hl, $0107
    call SetRequestPtrC921_B13
    ret

Jump_013_5E28::
    ld [hl], $1A
    ld hl, $52DC
    call SetRequestPtrC91A_B13
    ld de, $0100
    call SetFlagBit
    ret

Jump_013_5E37::
    ld a, [wC6FD]
    cp a, $02
    jr nc, Jump_013_5E45
    ld hl, $0107
    call SetRequestPtrC921_B13
    ret

Jump_013_5E45::
    ld de, $0101
    call TestFlagBit
    jr c, Jump_013_5E5A
    ld hl, $0108
    call SetRequestPtrC921_B13
    ld de, $0101
    call SetFlagBit
    ret

Jump_013_5E5A::
    ld hl, $0109
    call SetRequestPtrC921_B13
    ret

Jump_013_5E61::
    ld hl, $0204
    call SetRequestPtrC921_B13
    ret

Jump_013_5E68::
    call Func_013_5EF4
    ret

Jump_013_5E6C::
    ld hl, $0A2B
    call SetRequestPtrC921_B13
    ret

Jump_013_5E73::
    ld hl, $0501
    call SetRequestPtrC921_B13
    ret

Jump_013_5E7A::
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jp nz, Jump_013_5EE7
    ldh a, [hFFC6]
    cp a, $14
    jr nc, Jump_013_5E93
    ld hl, $0B01
    call SetRequestPtrC921_B13
    ret

Jump_013_5E93::
    cp a, $1E
    jr nc, Jump_013_5E9E
    ld hl, $0DE7
    call SetRequestPtrC921_B13
    ret

Jump_013_5E9E::
    cp a, $28
    jr nc, Jump_013_5EA9
    ld hl, $0DE8
    call SetRequestPtrC921_B13
    ret

Jump_013_5EA9::
    cp a, $32
    jr nc, Jump_013_5EB4
    ld hl, $0DE9
    call SetRequestPtrC921_B13
    ret

Jump_013_5EB4::
    cp a, $64
    jr nc, Jump_013_5EBF
    ld hl, $0DEA
    call SetRequestPtrC921_B13
    ret

Jump_013_5EBF::
    cp a, $96
    jr nc, Jump_013_5ECA
    ld hl, $0DEB
    call SetRequestPtrC921_B13
    ret

Jump_013_5ECA::
    cp a, $C8
    jr nc, Jump_013_5ED5
    ld hl, $0DEC
    call SetRequestPtrC921_B13
    ret

Jump_013_5ED5::
    cp a, $FA
    jr nc, Jump_013_5EE0
    ld hl, $0DED
    call SetRequestPtrC921_B13
    ret

Jump_013_5EE0::
    ld hl, $0DEE
    call SetRequestPtrC921_B13
    ret

Jump_013_5EE7::
    ldh a, [hFFC6]
    cp a, $38
    jr c, Jump_013_5EE0
    ld hl, $0DEF
    call SetRequestPtrC921_B13
    ret

; 1 call site from 1 routine (e.g. Func_013_5C0B)
; reads: hFFC6, wC6FD, wC634
; writes: hFFC6, hFFC7
Func_013_5EF4::
    ld de, $0191
    call TestFlagBit
    jp c, Jump_013_5F5C
    ld de, $0190
    call TestFlagBit
    jr c, Jump_013_5F0C
    ld hl, $52E3
    call SetRequestPtrC91A_B13
    ret

Jump_013_5F0C::
    ld hl, $005A
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_5F28
    ld hl, $52E3
    call SetRequestPtrC91A_B13
    ret

Jump_013_5F28::
    ld a, [wC6FD]
    dec a
    jr z, Jump_013_5F55
    ld de, $0134
    call TestFlagBit
    jr c, Jump_013_5F4E
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_013_5F47
    or a, a
    jr z, Jump_013_5F47
    ld hl, $530D
    call SetRequestPtrC91A_B13
    ret

Jump_013_5F47::
    ld hl, $5324
    call SetRequestPtrC91A_B13
    ret

Jump_013_5F4E::
    ld hl, $52F3
    call SetRequestPtrC91A_B13
    ret

Jump_013_5F55::
    ld hl, $08B2
    call SetRequestPtrC921_B13
    ret

Jump_013_5F5C::
    ld hl, $08B6
    call SetRequestPtrC921_B13
    ret

Jump_013_5F63::
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5F87
    ld de, $0004
    call TestFlagBit
    jr c, Jump_013_5F80
    ld hl, $0017
    call SetRequestPtrC921_B13
    ld de, $0004
    call SetFlagBit
    ret

Jump_013_5F80::
    ld hl, $0018
    call SetRequestPtrC921_B13
    ret

Jump_013_5F87::
    ld hl, $0065
    call SetRequestPtrC921_B13
    ret

Jump_013_5F8E::
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_5FCB
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_5FC4
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_5FBD
    ld de, $0003
    call TestFlagBit
    jr c, Jump_013_5FB6
    ld hl, $0019
    call SetRequestPtrC921_B13
    ret

Jump_013_5FB6::
    ld hl, $002F
    call SetRequestPtrC921_B13
    ret

Jump_013_5FBD::
    ld hl, $0066
    call SetRequestPtrC921_B13
    ret

Jump_013_5FC4::
    ld hl, $010A
    call SetRequestPtrC921_B13
    ret

Jump_013_5FCB::
    ld hl, $0B08
    call SetRequestPtrC921_B13
    ret

Jump_013_5FD2::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6041
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_603A
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6033
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_602C
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6025
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6009
    ld hl, $0032
    call SetRequestPtrC921_B13
    ret

Jump_013_6009::
    ld de, $0010
    call TestFlagBit
    jr c, Jump_013_601E
    ld hl, $0068
    call SetRequestPtrC921_B13
    ld de, $0010
    call SetFlagBit
    ret

Jump_013_601E::
    ld hl, $0069
    call SetRequestPtrC921_B13
    ret

Jump_013_6025::
    ld hl, $010C
    call SetRequestPtrC921_B13
    ret

Jump_013_602C::
    ld hl, $020B
    call SetRequestPtrC921_B13
    ret

Jump_013_6033::
    ld hl, $0505
    call SetRequestPtrC921_B13
    ret

Jump_013_603A::
    ld hl, $053F
    call SetRequestPtrC921_B13
    ret

Jump_013_6041::
    ld hl, $0B0D
    call SetRequestPtrC921_B13
    ret

Jump_013_6048::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_60A8
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_60A1
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_609A
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6093
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6086
    ld de, $0007
    call TestFlagBit
    jr c, Jump_013_607F
    ld hl, $003C
    call SetRequestPtrC921_B13
    ret

Jump_013_607F::
    ld hl, $4F66
    call SetRequestPtrC91A_B13
    ret

Jump_013_6086::
    ld hl, $0073
    call SetRequestPtrC921_B13
    ld de, $000F
    call SetFlagBit
    ret

Jump_013_6093::
    ld hl, $011B
    call SetRequestPtrC921_B13
    ret

Jump_013_609A::
    ld hl, $0D0D
    call SetRequestPtrC921_B13
    ret

Jump_013_60A1::
    ld hl, $0D30
    call SetRequestPtrC921_B13
    ret

Jump_013_60A8::
    ld hl, $0D88
    call SetRequestPtrC921_B13
    ret

Jump_013_60AF::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6109
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_6102
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_60FB
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_60F4
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_60ED
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_60E6
    ld hl, $0040
    call SetRequestPtrC921_B13
    ret

Jump_013_60E6::
    ld hl, $0072
    call SetRequestPtrC921_B13
    ret

Jump_013_60ED::
    ld hl, $011A
    call SetRequestPtrC921_B13
    ret

Jump_013_60F4::
    ld hl, $08CE
    call SetRequestPtrC921_B13
    ret

Jump_013_60FB::
    ld hl, $050C
    call SetRequestPtrC921_B13
    ret

Jump_013_6102::
    ld hl, $0541
    call SetRequestPtrC921_B13
    ret

Jump_013_6109::
    ld hl, $0B11
    call SetRequestPtrC921_B13
    ret

Jump_013_6110::
    call Func_013_7F94
    jr c, Jump_013_6116
    ret

Jump_013_6116::
    ld [hl], $2C
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $00FD
    call SetRequestPtrC921_B13
    ret

Jump_013_6127::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6163
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_615C
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6155
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_614E
    ld hl, $0034
    call SetRequestPtrC921_B13
    ret

Jump_013_614E::
    ld hl, $0074
    call SetRequestPtrC921_B13
    ret

Jump_013_6155::
    ld hl, $0114
    call SetRequestPtrC921_B13
    ret

Jump_013_615C::
    ld hl, $020C
    call SetRequestPtrC921_B13
    ret

Jump_013_6163::
    ld hl, $0B19
    call SetRequestPtrC921_B13
    ret

Jump_013_616A::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6188
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6181
    ld hl, $020F
    call SetRequestPtrC921_B13
    ret

Jump_013_6181::
    ld hl, $0507
    call SetRequestPtrC921_B13
    ret

Jump_013_6188::
    ld hl, $0B18
    call SetRequestPtrC921_B13
    ret

Jump_013_618F::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_61FD
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_61F6
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_61DA
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_61B6
    ld hl, $003A
    call SetRequestPtrC921_B13
    ret

Jump_013_61B6::
    ld de, $0011
    call TestFlagBit
    jr c, Jump_013_61D3
    ld a, [wCC37]
    set 0, a
    ld [wCC37], a
    ld hl, $0077
    call SetRequestPtrC921_B13
    ld de, $0011
    call SetFlagBit
    ret

Jump_013_61D3::
    ld hl, $0078
    call SetRequestPtrC921_B13
    ret

Jump_013_61DA::
    ld de, $010B
    call TestFlagBit
    jr c, Jump_013_61EF
    ld hl, $08C1
    call SetRequestPtrC921_B13
    ld de, $010B
    call SetFlagBit
    ret

Jump_013_61EF::
    ld hl, $08C2
    call SetRequestPtrC921_B13
    ret

Jump_013_61F6::
    ld hl, $0506
    call SetRequestPtrC921_B13
    ret

Jump_013_61FD::
    ld a, $02
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld de, $012C
    call TestFlagBit
    jr c, Jump_013_6216
    ld hl, Data_010_57ED
    call SetRequestPtrC91A_B13
    ret

Jump_013_6216::
    ld hl, $57F7
    call SetRequestPtrC91A_B13
    ret

Jump_013_621D::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_628A
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6252
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_624B
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6244
    ld hl, $0035
    call SetRequestPtrC921_B13
    ret

Jump_013_6244::
    ld hl, $0075
    call SetRequestPtrC921_B13
    ret

Jump_013_624B::
    ld hl, $0115
    call SetRequestPtrC921_B13
    ret

Jump_013_6252::
    ld de, $0106
    call TestFlagBit
    jr c, Jump_013_6279
    ld de, $0104
    call TestFlagBit
    jr nc, Jump_013_624B
    ld a, $00
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_533E
    call SetRequestPtrC91A_B13
    ld de, $0106
    call SetFlagBit
    ret

Jump_013_6279::
    ld a, $00
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5345
    call SetRequestPtrC91A_B13
    ret

Jump_013_628A::
    ld de, $00CE
    call TestFlagBit
    jr c, Jump_013_6279
    ld a, $00
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_534C
    call SetRequestPtrC91A_B13
    ld de, $00CE
    call SetFlagBit
    ret

Jump_013_62A9::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_62F4
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_62ED
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_62E6
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_62DF
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_62D8
    ld hl, $003B
    call SetRequestPtrC921_B13
    ret

Jump_013_62D8::
    ld hl, $006D
    call SetRequestPtrC921_B13
    ret

Jump_013_62DF::
    ld hl, $0116
    call SetRequestPtrC921_B13
    ret

Jump_013_62E6::
    ld hl, $0D0E
    call SetRequestPtrC921_B13
    ret

Jump_013_62ED::
    ld hl, $0540
    call SetRequestPtrC921_B13
    ret

Jump_013_62F4::
    ld hl, $0B0F
    call SetRequestPtrC921_B13
    ret

Jump_013_62FB::
    ld hl, $0038
    call SetRequestPtrC921_B13
    ret

Jump_013_6302::
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_6320
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6319
    ld hl, $0041
    call SetRequestPtrC921_B13
    ret

Jump_013_6319::
    ld hl, $0070
    call SetRequestPtrC921_B13
    ret

Jump_013_6320::
    ld hl, $0119
    call SetRequestPtrC921_B13
    ret

Jump_013_6327::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6390
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_6389
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6382
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_637B
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6374
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_636D
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6366
    ld hl, $003D
    call SetRequestPtrC921_B13
    ret

Jump_013_6366::
    ld hl, $006E
    call SetRequestPtrC921_B13
    ret

Jump_013_636D::
    ld hl, $0117
    call SetRequestPtrC921_B13
    ret

Jump_013_6374::
    ld hl, $0210
    call SetRequestPtrC921_B13
    ret

Jump_013_637B::
    ld hl, $08C3
    call SetRequestPtrC921_B13
    ret

Jump_013_6382::
    ld hl, $0508
    call SetRequestPtrC921_B13
    ret

Jump_013_6389::
    ld hl, $0542
    call SetRequestPtrC921_B13
    ret

Jump_013_6390::
    ld hl, $0B1A
    call SetRequestPtrC921_B13
    ret

Jump_013_6397::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6400
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_63F9
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_63F2
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_63EB
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_63E4
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_63DD
    ld de, $000A
    call TestFlagBit
    jr c, Jump_013_63D6
    ld hl, $003F
    call SetRequestPtrC921_B13
    ret

Jump_013_63D6::
    ld hl, $0052
    call SetRequestPtrC921_B13
    ret

Jump_013_63DD::
    ld hl, $006F
    call SetRequestPtrC921_B13
    ret

Jump_013_63E4::
    ld hl, $0118
    call SetRequestPtrC921_B13
    ret

Jump_013_63EB::
    ld hl, $0211
    call SetRequestPtrC921_B13
    ret

Jump_013_63F2::
    ld hl, $08C4
    call SetRequestPtrC921_B13
    ret

Jump_013_63F9::
    ld hl, $0509
    call SetRequestPtrC921_B13
    ret

Jump_013_6400::
    ld hl, $0B1B
    call SetRequestPtrC921_B13
    ret

Jump_013_6407::
    ld de, $0009
    call TestFlagBit
    jr c, Jump_013_641C
    ld hl, $004A
    call SetRequestPtrC921_B13
    ld de, $0009
    call SetFlagBit
    ret

Jump_013_641C::
    ld de, $0008
    call TestFlagBit
    jr c, Jump_013_6438
    ldh a, [hMapScreenX]
    cp a, $02
    jr z, Jump_013_6431

Jump_013_642A::
    ld hl, $004B
    call SetRequestPtrC921_B13
    ret

Jump_013_6431::
    ld hl, $004F
    call SetRequestPtrC921_B13
    ret

Jump_013_6438::
    ldh a, [hMapScreenX]
    cp a, $02
    jr nz, Jump_013_642A
    ld hl, $4F8D
    call SetRequestPtrC91A_B13
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $20
    ld [wCBD3], a
    ld a, $50
    ld [wCBD4], a
    ld de, $000A
    call SetFlagBit
    ret

Jump_013_645F::
    ld de, $0008
    call TestFlagBit
    jr c, Jump_013_6474
    ld hl, $0048
    call SetRequestPtrC921_B13
    ld de, $0008
    call SetFlagBit
    ret

Jump_013_6474::
    ld hl, $0049
    call SetRequestPtrC921_B13
    ret

Jump_013_647B::
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_659E
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_6577
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_6553
    ld de, $0022
    call TestFlagBit
    jp c, Jump_013_652F
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6504
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $001A
    call TestFlagBit
    jr c, Jump_013_64F6
    ld de, $000D
    call TestFlagBit
    jr nc, Jump_013_64CF
    ld de, $000F
    call TestFlagBit
    jr nc, Jump_013_64CF
    ld de, $0011
    call TestFlagBit
    jr c, Jump_013_64D6

Jump_013_64CF::
    ld hl, $005F
    call SetRequestPtrC921_B13
    ret

Jump_013_64D6::
    ld a, $02
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld de, $0016
    call TestFlagBit
    jr c, Jump_013_64EF
    ld hl, $5006
    call SetRequestPtrC91A_B13
    ret

Jump_013_64EF::
    ld hl, $5029
    call SetRequestPtrC91A_B13
    ret

Jump_013_64F6::
    ld hl, $0082
    call SetRequestPtrC921_B13
    ret

Jump_013_64FD::
    ld hl, $536E
    call SetRequestPtrC91A_B13
    ret

Jump_013_6504::
    ld de, $01A0
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $012F
    call TestFlagBit
    jr c, Jump_013_651B
    ld hl, $029E
    call SetRequestPtrC921_B13
    ret

Jump_013_651B::
    ld hl, $02A4
    call SetRequestPtrC921_B13
    ld de, $01A0
    call SetFlagBit
    ret
    db $21, $7B, $53, $CD, $49, $40, $C9

Jump_013_652F::
    ld de, $01A1
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $0135
    call TestFlagBit
    jr c, Jump_013_6546
    ld hl, $0D1A
    call SetRequestPtrC921_B13
    ret

Jump_013_6546::
    ld hl, $0D1B
    call SetRequestPtrC921_B13
    ld de, $01A1
    call SetFlagBit
    ret

Jump_013_6553::
    ld de, $01A2
    call TestFlagBit
    jr c, Jump_013_64FD
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_656A
    ld hl, $0D2A
    call SetRequestPtrC921_B13
    ret

Jump_013_656A::
    ld hl, $0D2B
    call SetRequestPtrC921_B13
    ld de, $01A2
    call SetFlagBit
    ret

Jump_013_6577::
    ld de, $013B
    call TestFlagBit
    jr c, Jump_013_6597
    ld a, [wC632]
    or a, a
    jr z, Jump_013_6590
    cp a, $FF
    jr z, Jump_013_6590
    ld hl, $53AD
    call SetRequestPtrC91A_B13
    ret

Jump_013_6590::
    ld hl, $53BA
    call SetRequestPtrC91A_B13
    ret

Jump_013_6597::
    ld hl, $0532
    call SetRequestPtrC921_B13
    ret

Jump_013_659E::
    ld de, $002A
    call TestFlagBit
    jr c, Jump_013_65DE
    ld de, $002B
    call TestFlagBit
    jr c, Jump_013_65E5
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_013_65CA
    cp a, $01
    jr nz, Jump_013_65C3
    ldh a, [hFFC6]
    cp a, $22
    jr c, Jump_013_65D0

Jump_013_65C3::
    ld hl, $53D0
    call SetRequestPtrC91A_B13
    ret

Jump_013_65CA::
    ldh a, [hFFC6]
    cp a, $FA
    jr c, Jump_013_65D7

Jump_013_65D0::
    ld hl, $53CE
    call SetRequestPtrC91A_B13
    ret

Jump_013_65D7::
    ld hl, $0B26
    call SetRequestPtrC921_B13
    ret

Jump_013_65DE::
    ld hl, $0B2D
    call SetRequestPtrC921_B13
    ret

Jump_013_65E5::
    ld hl, $0BA8
    call SetRequestPtrC921_B13
    ret

Jump_013_65EC::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6646
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6621
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_661A
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_6613
    ld hl, $001A
    call SetRequestPtrC921_B13
    ret

Jump_013_6613::
    ld hl, $0067
    call SetRequestPtrC921_B13
    ret

Jump_013_661A::
    ld hl, $010B
    call SetRequestPtrC921_B13
    ret

Jump_013_6621::
    ld de, $0181
    call TestFlagBit
    jr c, Jump_013_6630
    ld hl, $0203
    call SetRequestPtrC921_B13
    ret

Jump_013_6630::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_663F
    ld hl, $0215
    call SetRequestPtrC921_B13
    ret

Jump_013_663F::
    ld hl, $08AE
    call SetRequestPtrC921_B13
    ret

Jump_013_6646::
    ld hl, $0B04
    call SetRequestPtrC921_B13
    ret

Jump_013_664D::
    ld a, $1F
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_66DE
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_66CF
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_66C0
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_66B1
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_66A2
    ld de, $0020
    call TestFlagBit
    jr c, Jump_013_668C
    ld hl, $0103
    call SetRequestPtrC921_B13
    ret

Jump_013_668C::
    ld de, $0102
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5256
    call SetRequestPtrC91A_B13
    ret

Jump_013_669B::
    ld hl, $5260
    call SetRequestPtrC91A_B13
    ret

Jump_013_66A2::
    ld de, $0105
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5267
    call SetRequestPtrC91A_B13
    ret

Jump_013_66B1::
    ld de, $0109
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5271
    call SetRequestPtrC91A_B13
    ret

Jump_013_66C0::
    ld de, $0115
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $527B
    call SetRequestPtrC91A_B13
    ret

Jump_013_66CF::
    ld de, $0121
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $5285
    call SetRequestPtrC91A_B13
    ret

Jump_013_66DE::
    ld de, $0131
    call TestFlagBit
    jr c, Jump_013_669B
    ld hl, $528F
    call SetRequestPtrC91A_B13
    ret

Jump_013_66ED::
    ld a, $1F
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_677E
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_676F
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_6760
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_6751
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6742
    ld de, $0020
    call TestFlagBit
    jr c, Jump_013_672C
    ld hl, $0104
    call SetRequestPtrC921_B13
    ret

Jump_013_672C::
    ld de, $0102
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $5299
    call SetRequestPtrC91A_B13
    ret

Jump_013_673B::
    ld hl, $52A3
    call SetRequestPtrC91A_B13
    ret

Jump_013_6742::
    ld de, $0105
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52AA
    call SetRequestPtrC91A_B13
    ret

Jump_013_6751::
    ld de, $0109
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52B4
    call SetRequestPtrC91A_B13
    ret

Jump_013_6760::
    ld de, $0115
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52BE
    call SetRequestPtrC91A_B13
    ret

Jump_013_676F::
    ld de, $0121
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52C8
    call SetRequestPtrC91A_B13
    ret

Jump_013_677E::
    ld de, $0131
    call TestFlagBit
    jr c, Jump_013_673B
    ld hl, $52D2
    call SetRequestPtrC91A_B13
    ret

Jump_013_678D::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_679C
    ld hl, $011E
    call SetRequestPtrC921_B13
    ret

Jump_013_679C::
    ld hl, $0B1D
    call SetRequestPtrC921_B13
    ret

Jump_013_67A3::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_67C2
    ld de, $0023
    call TestFlagBit
    jp c, Jump_013_67BB
    ld hl, $021F
    call SetRequestPtrC921_B13
    ret

Jump_013_67BB::
    ld hl, $0DE5
    call SetRequestPtrC921_B13
    ret

Jump_013_67C2::
    ld hl, $0B14
    call SetRequestPtrC921_B13
    ret

Jump_013_67C9::
    ld hl, $04D0
    call SetRequestPtrC921_B13
    ret

Jump_013_67D0::
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6823
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_680D
    ld de, $0021
    call TestFlagBit
    jr c, Jump_013_6806
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_67F8
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_67FF

Jump_013_67F8::
    ld hl, $003E
    call SetRequestPtrC921_B13
    ret

Jump_013_67FF::
    ld hl, $0071
    call SetRequestPtrC921_B13
    ret

Jump_013_6806::
    ld hl, $021B
    call SetRequestPtrC921_B13
    ret

Jump_013_680D::
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_681C
    ld hl, $53D2
    call SetRequestPtrC91A_B13
    ret

Jump_013_681C::
    ld hl, $0A3D
    call SetRequestPtrC921_B13
    ret

Jump_013_6823::
    ld de, $0117
    call TestFlagBit
    jr c, Jump_013_681C
    ld hl, $53FA
    call SetRequestPtrC91A_B13
    ret

Jump_013_6832::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6856
    ld de, $0107
    call TestFlagBit
    jr c, Jump_013_684F
    ld hl, $5418
    call SetRequestPtrC91A_B13
    ld de, $0107
    call SetFlagBit
    ret

Jump_013_684F::
    ld hl, $021E
    call SetRequestPtrC921_B13
    ret

Jump_013_6856::
    ld hl, $0B10
    call SetRequestPtrC921_B13
    ret

Jump_013_685D::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_686C
    ld hl, $021C
    call SetRequestPtrC921_B13
    ret

Jump_013_686C::
    ld hl, $0B0E
    call SetRequestPtrC921_B13
    ret

Jump_013_6873::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6891
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_688A
    ld hl, $0221
    call SetRequestPtrC921_B13
    ret

Jump_013_688A::
    ld hl, $0521
    call SetRequestPtrC921_B13
    ret

Jump_013_6891::
    ld hl, $0B2F
    call SetRequestPtrC921_B13
    ret

Jump_013_6898::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_68B6
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_68AF
    ld hl, $0222
    call SetRequestPtrC921_B13
    ret

Jump_013_68AF::
    ld hl, $0522
    call SetRequestPtrC921_B13
    ret

Jump_013_68B6::
    ld hl, $0B30
    call SetRequestPtrC921_B13
    ret

Jump_013_68BD::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_68CD
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_68D4

Jump_013_68CD::
    ld hl, $0223
    call SetRequestPtrC921_B13
    ret

Jump_013_68D4::
    ld hl, $0543
    call SetRequestPtrC921_B13
    ret

Jump_013_68DB::
    ld hl, $0224
    call SetRequestPtrC921_B13
    ret

Jump_013_68E2::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6940
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_692A
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6923
    ld a, [wC6FD]
    dec a
    jr z, Jump_013_6915
    ld hl, $0002
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_691C

Jump_013_6915::
    ld hl, $0263
    call SetRequestPtrC921_B13
    ret

Jump_013_691C::
    ld hl, $5422
    call SetRequestPtrC91A_B13
    ret

Jump_013_6923::
    ld hl, $0267
    call SetRequestPtrC921_B13
    ret

Jump_013_692A::
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6939
    ld hl, $0D32
    call SetRequestPtrC921_B13
    ret

Jump_013_6939::
    ld hl, $0528
    call SetRequestPtrC921_B13
    ret

Jump_013_6940::
    ld hl, $5433
    call SetRequestPtrC91A_B13
    ret

Jump_013_6947::
    ld hl, $0D8C
    call SetRequestPtrC921_B13
    ret

Jump_013_694E::
    ld hl, $0D8D
    call SetRequestPtrC921_B13
    ret

Jump_013_6955::
    ld hl, $022D
    call SetRequestPtrC921_B13
    ret

Jump_013_695C::
    ld hl, $5476
    call SetRequestPtrC91A_B13
    ret

Jump_013_6963::
    ld hl, $022C
    call SetRequestPtrC921_B13
    ret

Jump_013_696A::
    ld hl, $0005
    call SetRequestPtrC921_B13
    ret

Jump_013_6971::
    ld hl, $0006
    call SetRequestPtrC921_B13
    ret

Jump_013_6978::
    ld de, $0013
    call TestFlagBit
    jr c, Jump_013_6988
    ld l, $04
    ld h, $00
    call SetRequestPtrC921_B13
    ret

Jump_013_6988::
    ld a, $01
    or a, a
    jr z, Jump_013_6994
    ld hl, $50DB
    call SetRequestPtrC91A_B13
    ret

Jump_013_6994::
    ld hl, $50F6
    call SetRequestPtrC91A_B13
    ret

Jump_013_699B::
    ld hl, $5120
    call SetRequestPtrC91A_B13
    ret

Jump_013_69A2::
    ld de, $0013
    call TestFlagBit
    jr c, Jump_013_69B1
    ld hl, $000A
    call SetRequestPtrC921_B13
    ret

Jump_013_69B1::
    ld hl, $000E
    call SetRequestPtrC921_B13
    ret

Jump_013_69B8::
    ld de, $0013
    call TestFlagBit
    jr c, Jump_013_69D3
    ld a, $02
    and a, $01
    add a, $0B
    ld l, a
    ld h, $00
    call SetRequestPtrC921_B13
    ld de, $0013
    call SetFlagBit
    ret

Jump_013_69D3::
    ld hl, $000D
    call SetRequestPtrC921_B13
    ret

Jump_013_69DA::
    farcall Func_05F_6D78
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_013_69EE
    ld hl, $0D62
    call SetRequestPtrC921_B13
    ret

Jump_013_69EE::
    ld a, [wC916]
    sub a, $33
    add a, $63
    ld l, a
    ld h, $0D
    call SetRequestPtrC921_B13
    ld a, [wC916]
    sub a, $33
    add a, $06
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $01
    ldh [hFFC9], a
    farcall Func_001_6E46
    ret

Jump_013_6A14::
    ld hl, $0BAC
    call SetRequestPtrC921_B13
    ret

Jump_013_6A1B::
    ld hl, $0D84
    call SetRequestPtrC921_B13
    ret

Jump_013_6A22::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6A40
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6A39
    ld hl, $023F
    call SetRequestPtrC921_B13
    ret

Jump_013_6A39::
    ld hl, $0523
    call SetRequestPtrC921_B13
    ret

Jump_013_6A40::
    ld hl, $0D8B
    call SetRequestPtrC921_B13
    ret

Jump_013_6A47::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6A65
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6A5E
    ld hl, $0240
    call SetRequestPtrC921_B13
    ret

Jump_013_6A5E::
    ld hl, $0524
    call SetRequestPtrC921_B13
    ret

Jump_013_6A65::
    ld hl, $0B31
    call SetRequestPtrC921_B13
    ret

Jump_013_6A6C::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6A7B
    ld hl, $0241
    call SetRequestPtrC921_B13
    ret

Jump_013_6A7B::
    ld hl, $0B32
    call SetRequestPtrC921_B13
    ret

Jump_013_6A82::
    ld hl, $0243
    call SetRequestPtrC921_B13
    ret

Jump_013_6A89::
    ld hl, $0244
    call SetRequestPtrC921_B13
    ret

Jump_013_6A90::
    ld hl, $0245
    call SetRequestPtrC921_B13
    ret

Jump_013_6A97::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6AB5
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6AAE
    ld hl, $5483
    call SetRequestPtrC91A_B13
    ret

Jump_013_6AAE::
    ld hl, $0526
    call SetRequestPtrC921_B13
    ret

Jump_013_6AB5::
    ld hl, $0B42
    call SetRequestPtrC921_B13
    ret

Jump_013_6ABC::
    ld hl, $0249
    call SetRequestPtrC921_B13
    ret

Jump_013_6AC3::
    ld hl, $0256
    call SetRequestPtrC921_B13
    ret

Jump_013_6ACA::
    ld hl, $02B0
    call SetRequestPtrC921_B13
    ret

Jump_013_6AD1::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6AEF
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6AE8
    ld hl, $5490
    call SetRequestPtrC91A_B13
    ret

Jump_013_6AE8::
    ld hl, $0525
    call SetRequestPtrC921_B13
    ret

Jump_013_6AEF::
    ld de, $00CD
    call TestFlagBit
    jr c, Jump_013_6B2B
    farcall Func_05F_6D78
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_013_6B0B
    ld hl, $0B44
    call SetRequestPtrC921_B13
    ret

Jump_013_6B0B::
    ld a, $02
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $01
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld hl, $0B43
    call SetRequestPtrC921_B13
    ld de, $00CD
    call SetFlagBit
    ret

Jump_013_6B2B::
    ld hl, $0B45
    call SetRequestPtrC921_B13
    ret

Jump_013_6B32::
    ld hl, $025A
    call SetRequestPtrC921_B13
    ret

Jump_013_6B39::
    ld hl, $025B
    call SetRequestPtrC921_B13
    ret

Jump_013_6B40::
    ld de, $0134
    call TestFlagBit
    ret nc
    ld hl, $0314
    call SetRequestPtrC921_B13
    ret

Jump_013_6B4E::
    ld a, $96
    ld [wDataBank], a
    ld de, $0111
    call TestFlagBit
    jr c, Jump_013_6B68
    ld hl, Data_096_549D
    call SetRequestPtrC91A_B13
    ld de, $0111
    call SetFlagBit
    ret

Jump_013_6B68::
    ld hl, $54A4
    call SetRequestPtrC91A_B13
    ret

Jump_013_6B6F::
    ld hl, $04C5
    call SetRequestPtrC921_B13
    ret

Jump_013_6B76::
    ld hl, $04C6
    call SetRequestPtrC921_B13
    ret

Jump_013_6B7D::
    ld hl, $04C7
    call SetRequestPtrC921_B13
    ret

Jump_013_6B84::
    ld hl, $08C0
    call SetRequestPtrC921_B13
    ret

Jump_013_6B8B::
    ld de, $01A3
    call TestFlagBit
    jr nc, Jump_013_6BBE
    ld de, $01A4
    call TestFlagBit
    jr c, Jump_013_6BBE
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_013_6BAC
    or a, a
    jr z, Jump_013_6BAC
    ld hl, $0D4A
    call SetRequestPtrC921_B13
    ret

Jump_013_6BAC::
    ld hl, $599F
    call SetRequestPtrC91A_B13
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_013_6BBE::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6BCD
    ld hl, $08BB
    call SetRequestPtrC921_B13
    ret

Jump_013_6BCD::
    ld hl, $0D87
    call SetRequestPtrC921_B13
    ret

Jump_013_6BD4::
    ld de, $010A
    call TestFlagBit
    jr c, Jump_013_6BEE
    ld hl, $54AB
    call SetRequestPtrC91A_B13
    ld a, $1D
    ld [wDataBank], a
    ld de, $010A
    call SetFlagBit
    ret

Jump_013_6BEE::
    ld hl, $54B2
    call SetRequestPtrC91A_B13
    ld a, $1D
    ld [wDataBank], a
    ret

Jump_013_6BFA::
    ld hl, $0A50
    call SetRequestPtrC921_B13
    ret

Jump_013_6C01::
    ld hl, $0A52
    call SetRequestPtrC921_B13
    ret

Jump_013_6C08::
    ld hl, $0A53
    call SetRequestPtrC921_B13
    ret

Jump_013_6C0F::
    ld hl, $0A59
    call SetRequestPtrC921_B13
    ret

Jump_013_6C16::
    ld hl, $54B9
    call SetRequestPtrC91A_B13
    ret

Jump_013_6C1D::
    ld hl, $54C0
    call SetRequestPtrC91A_B13
    ret

Jump_013_6C24::
    ld hl, $0A5D
    call SetRequestPtrC921_B13
    ret

Jump_013_6C2B::
    ld hl, $54C7
    call SetRequestPtrC91A_B13
    ret

Jump_013_6C32::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C41
    ld hl, $0292
    call SetRequestPtrC921_B13
    ret

Jump_013_6C41::
    ld hl, $0B79
    call SetRequestPtrC921_B13
    ret

Jump_013_6C48::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C57
    ld hl, $027D
    call SetRequestPtrC921_B13
    ret

Jump_013_6C57::
    ld hl, $0B75
    call SetRequestPtrC921_B13
    ret

Jump_013_6C5E::
    ld hl, $027E
    call SetRequestPtrC921_B13
    ret

Jump_013_6C65::
    ld hl, $028C
    call SetRequestPtrC921_B13
    ret

Jump_013_6C6C::
    ld hl, $028D
    call SetRequestPtrC921_B13
    ret

Jump_013_6C73::
    ld hl, $028E
    call SetRequestPtrC921_B13
    ret

Jump_013_6C7A::
    ld hl, $0287
    call SetRequestPtrC921_B13
    ret

Jump_013_6C81::
    ld hl, $0286
    call SetRequestPtrC921_B13
    ret

Jump_013_6C88::
    ld hl, $028F
    call SetRequestPtrC921_B13
    ret

Jump_013_6C8F::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6C9E
    ld hl, $0294
    call SetRequestPtrC921_B13
    ret

Jump_013_6C9E::
    ld hl, $0B7A
    call SetRequestPtrC921_B13
    ret

Jump_013_6CA5::
    ld hl, $0290
    call SetRequestPtrC921_B13
    ret

Jump_013_6CAC::
    ld hl, $0291
    call SetRequestPtrC921_B13
    ret

Jump_013_6CB3::
    ld a, [wC82C]
    or a, a
    jr nz, Jump_013_6CCF
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CC8
    ld hl, $54CE
    call SetRequestPtrC91A_B13
    ret

Jump_013_6CC8::
    ld hl, $550F
    call SetRequestPtrC91A_B13
    ret

Jump_013_6CCF::
    dec a
    jr nz, Jump_013_6CE8
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CE1
    ld hl, $54DB
    call SetRequestPtrC91A_B13
    ret

Jump_013_6CE1::
    ld hl, $551C
    call SetRequestPtrC91A_B13
    ret

Jump_013_6CE8::
    dec a
    jr nz, Jump_013_6D01
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6CFA
    ld hl, $54E8
    call SetRequestPtrC91A_B13
    ret

Jump_013_6CFA::
    ld hl, $5529
    call SetRequestPtrC91A_B13
    ret

Jump_013_6D01::
    dec a
    jr nz, Jump_013_6D1A
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6D13
    ld hl, $54F5
    call SetRequestPtrC91A_B13
    ret

Jump_013_6D13::
    ld hl, $5536
    call SetRequestPtrC91A_B13
    ret

Jump_013_6D1A::
    dec a
    jr nz, Jump_013_6D33
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_6D2C
    ld hl, $5502
    call SetRequestPtrC91A_B13
    ret

Jump_013_6D2C::
    ld hl, $5543
    call SetRequestPtrC91A_B13
    ret

Jump_013_6D33::
    ld hl, $0B78
    call SetRequestPtrC921_B13
    ret

Jump_013_6D3A::
    ld hl, $0296
    call SetRequestPtrC921_B13
    ret

Jump_013_6D41::
    ld a, $01
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $010C
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_6D52::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6D61
    ld hl, $027A
    call SetRequestPtrC921_B13
    ret

Jump_013_6D61::
    ld hl, $0B67
    call SetRequestPtrC921_B13
    ret

Jump_013_6D68::
    ld a, $0C
    ld [wDataBank], a
    xor a, a
    ld [wD7FB], a
    farcall Func_0F2_6692
    ld a, [wC82C]
    or a, a
    jr z, Jump_013_6DAD
    cp a, $01
    jr z, Jump_013_6DB4
    cp a, $05
    jr z, Jump_013_6DCA
    ld a, [wC892]
    or a, a
    jr nz, Jump_013_6DA7
    farcall Func_012_689A
    ldh a, [hFFC6]
    ld [wC892], a
    or a, a
    jr nz, Jump_013_6DA0
    ld hl, $5578
    call SetRequestPtrC91A_B13
    ret

Jump_013_6DA0::
    ld hl, $557F
    call SetRequestPtrC91A_B13
    ret

Jump_013_6DA7::
    ld a, [wC82C]
    or a, a
    jr nz, Jump_013_6DB4

Jump_013_6DAD::
    ld hl, $5550
    call SetRequestPtrC91A_B13
    ret

Jump_013_6DB4::
    ld de, $0189
    call TestFlagBit
    jr c, Jump_013_6DC3
    ld hl, $5560
    call SetRequestPtrC91A_B13
    ret

Jump_013_6DC3::
    ld hl, $556A
    call SetRequestPtrC91A_B13
    ret

Jump_013_6DCA::
    ld hl, $5571
    call SetRequestPtrC91A_B13
    ret

Jump_013_6DD1::
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld de, $010E
    call TestFlagBit
    jr c, Jump_013_6E02
    ld a, $00
    ld [wD7FB], a
    ld a, $0E
    ld [wDataBank], a
    ld de, $010D
    call TestFlagBit
    jr c, Jump_013_6DFB
    ld hl, Data_00E_5586
    call SetRequestPtrC91A_B13
    ret

Jump_013_6DFB::
    ld hl, $558B
    call SetRequestPtrC91A_B13
    ret

Jump_013_6E02::
    ld hl, $04B4
    call SetRequestPtrC921_B13
    ret

Jump_013_6E09::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6E36
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_6E2F
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_6E28
    ld hl, $04B5
    call SetRequestPtrC921_B13
    ret

Jump_013_6E28::
    ld hl, $04BB
    call SetRequestPtrC921_B13
    ret

Jump_013_6E2F::
    ld hl, $04C1
    call SetRequestPtrC921_B13
    ret

Jump_013_6E36::
    ld hl, $0B6E
    call SetRequestPtrC921_B13
    ret

Jump_013_6E3D::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6E6A
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_6E63
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_6E5C
    ld hl, $04B6
    call SetRequestPtrC921_B13
    ret

Jump_013_6E5C::
    ld hl, $04BC
    call SetRequestPtrC921_B13
    ret

Jump_013_6E63::
    ld hl, $04C2
    call SetRequestPtrC921_B13
    ret

Jump_013_6E6A::
    ld hl, $0B6F
    call SetRequestPtrC921_B13
    ret

Jump_013_6E71::
    ld a, $96
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6E94
    ld de, $010F
    call TestFlagBit
    jr c, Jump_013_6E8D
    ld hl, Data_096_5598
    call SetRequestPtrC91A_B13
    ret

Jump_013_6E8D::
    ld hl, $55A2
    call SetRequestPtrC91A_B13
    ret

Jump_013_6E94::
    ld de, $0028
    call TestFlagBit
    jr c, Jump_013_6E8D
    ld hl, $55A9
    call SetRequestPtrC91A_B13
    ret

Jump_013_6EA3::
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld a, $15
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6ECF
    ld de, $0110
    call TestFlagBit
    jr c, Jump_013_6EC8
    ld hl, $55B3
    call SetRequestPtrC91A_B13
    ret

Jump_013_6EC8::
    ld hl, $55BD
    call SetRequestPtrC91A_B13
    ret

Jump_013_6ECF::
    ld de, $002C
    call TestFlagBit
    jr c, Jump_013_6EC8
    ld hl, $55C4
    call SetRequestPtrC91A_B13
    ret

Jump_013_6EDE::
    ld hl, $55CE
    call SetRequestPtrC91A_B13
    ret

Jump_013_6EE5::
    ld hl, $08D8
    call SetRequestPtrC921_B13
    ret

Jump_013_6EEC::
    ld hl, $08D9
    call SetRequestPtrC921_B13
    ret

Jump_013_6EF3::
    ld hl, $08CD
    call SetRequestPtrC921_B13
    ret

Jump_013_6EFA::
    ld hl, $02DC
    call SetRequestPtrC921_B13
    ret

Jump_013_6F01::
    ld hl, $0DD4
    call SetRequestPtrC921_B13
    ret

Jump_013_6F08::
    ld hl, $02DD
    call SetRequestPtrC921_B13
    ret

Jump_013_6F0F::
    ld a, $0C
    ld [wDataBank], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6F32
    ld de, $0112
    call TestFlagBit
    jr c, Jump_013_6F2B
    ld hl, Data_00C_55DB
    call SetRequestPtrC91A_B13
    ret

Jump_013_6F2B::
    ld hl, $55E5
    call SetRequestPtrC91A_B13
    ret

Jump_013_6F32::
    ld de, $0031
    call TestFlagBit
    jr c, Jump_013_6F2B
    ld hl, $55EC
    call SetRequestPtrC91A_B13
    ret

Jump_013_6F41::
    ld hl, $0A6F
    call SetRequestPtrC921_B13
    ret

Jump_013_6F48::
    ld hl, $0A75
    call SetRequestPtrC921_B13
    ret

Jump_013_6F4F::
    ld hl, $0A76
    call SetRequestPtrC921_B13
    ret

Jump_013_6F56::
    ld hl, $0A77
    call SetRequestPtrC921_B13
    ret

Jump_013_6F5D::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_6FBE
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_6FA8
    ld de, $012E
    call TestFlagBit
    jr c, Jump_013_6FA1
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6F84
    ld hl, $025E
    call SetRequestPtrC921_B13
    ret

Jump_013_6F84::
    call Func_013_7F94
    jr c, Jump_013_6F90
    ld hl, $0261
    call SetRequestPtrC921_B13
    ret

Jump_013_6F90::
    ld [hl], $11
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $55F6
    call SetRequestPtrC91A_B13
    ret

Jump_013_6FA1::
    ld hl, $0262
    call SetRequestPtrC921_B13
    ret

Jump_013_6FA8::
    ld de, $012D
    call TestFlagBit
    jr c, Jump_013_6FB7
    ld hl, $0D31
    call SetRequestPtrC921_B13
    ret

Jump_013_6FB7::
    ld hl, $0527
    call SetRequestPtrC921_B13
    ret

Jump_013_6FBE::
    ld hl, $0B46
    call SetRequestPtrC921_B13
    ret

Jump_013_6FC5::
    ld hl, $0269
    call SetRequestPtrC921_B13
    ret

Jump_013_6FCC::
    ld a, $01
    ld [wC921], a
    ld a, $2E
    ld [wC922], a
    ld de, $0114
    call SetRequestPtrC924FromDE_B13
    ret

Jump_013_6FDD::
    ld hl, $026A
    call SetRequestPtrC921_B13
    ret

Jump_013_6FE4::
    ld hl, $0A32
    call SetRequestPtrC921_B13
    ret

Jump_013_6FEB::
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_6FFB
    ld hl, $0A33
    call SetRequestPtrC921_B13
    ret

Jump_013_6FFB::
    ld hl, $0B06
    call SetRequestPtrC921_B13
    ret

Jump_013_7002::
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7012
    ld hl, $020A
    call SetRequestPtrC921_B13
    ret

Jump_013_7012::
    ld hl, $0B0B
    call SetRequestPtrC921_B13
    ret

Jump_013_7019::
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7029
    ld hl, $08BF
    call SetRequestPtrC921_B13
    ret

Jump_013_7029::
    ld hl, $0B0C
    call SetRequestPtrC921_B13
    ret

Jump_013_7030::
    ld de, $0134
    call TestFlagBit
    jr c, Jump_013_7096
    ld de, $0133
    call TestFlagBit
    jr c, Jump_013_704D
    ld de, $0133
    call SetFlagBit

Jump_013_7046::
    ld hl, $08C5
    call SetRequestPtrC921_B13
    ret

Jump_013_704D::
    ld hl, $00B9
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_013_7046
    ld a, [wC6FD]
    dec a
    jr z, Jump_013_708F
    ld de, $0191
    call TestFlagBit
    jr c, Jump_013_7088
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_013_7081
    or a, a
    jr z, Jump_013_7081
    ld hl, $561A
    call SetRequestPtrC91A_B13
    ret

Jump_013_7081::
    ld hl, $5631
    call SetRequestPtrC91A_B13
    ret

Jump_013_7088::
    ld hl, $5600
    call SetRequestPtrC91A_B13
    ret

Jump_013_708F::
    ld hl, $08C7
    call SetRequestPtrC921_B13
    ret

Jump_013_7096::
    ld a, $01
    ld [wD7FB], a
    ld de, $0023
    call TestFlagBit
    jr c, Jump_013_70AA

Jump_013_70A3::
    ld hl, $0D25
    call SetRequestPtrC921_B13
    ret

Jump_013_70AA::
    ld a, [wCB9A]
    cp a, $10
    jr nz, Jump_013_70A3
    ld a, $10
    ld [wDataBank], a
    ld de, $0116
    call TestFlagBit
    jr c, Jump_013_70CB
    ld hl, Data_010_564B
    call SetRequestPtrC91A_B13
    ld de, $0116
    call SetFlagBit
    ret

Jump_013_70CB::
    ld hl, $5652
    call SetRequestPtrC91A_B13
    ret
    db $21, $39, $0A, $CD, $01, $40, $C9

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC7, hFFC6
; writes: hFFC6, hFFC7
Func_013_70D9:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7122
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_711B
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_70F9
    ld hl, $0A3C
    call SetRequestPtrC921_B13
    ret

Jump_013_70F9::
    ld de, $0122
    call TestFlagBit
    jr c, Jump_013_7114
    ld hl, $050E
    call SetRequestPtrC921_B13
    ld de, $0117
    call SetFlagBit
    ld de, $0122
    call SetFlagBit
    ret

Jump_013_7114::
    ld hl, $050F
    call SetRequestPtrC921_B13
    ret

Jump_013_711B::
    ld hl, $053D
    call SetRequestPtrC921_B13
    ret

Jump_013_7122::
    ld de, $0194
    call TestFlagBit
    jr c, Jump_013_7176
    ld de, $0193
    call TestFlagBit
    jr c, Jump_013_7160
    ld de, $0192
    call TestFlagBit
    jr c, Jump_013_7159
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_7152
    ldh a, [hFFC6]
    cp a, $64
    jr nc, Jump_013_7152
    ld hl, $0B7B
    call SetRequestPtrC921_B13
    ret

Jump_013_7152::
    ld hl, $5903
    call SetRequestPtrC91A_B13
    ret

Jump_013_7159::
    ld hl, $0B7F
    call SetRequestPtrC921_B13
    ret

Jump_013_7160::
    ld hl, $2710
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ld hl, $5913
    call SetRequestPtrC91A_B13
    ret

Jump_013_7176::
    ld de, $0197
    call TestFlagBit
    jr c, Jump_013_71CA
    ld de, $0196
    call TestFlagBit
    jr c, Jump_013_71B4
    ld de, $0195
    call TestFlagBit
    jr c, Jump_013_71AD
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_71A6
    ldh a, [hFFC6]
    cp a, $78
    jr nc, Jump_013_71A6
    ld hl, $0B82
    call SetRequestPtrC921_B13
    ret

Jump_013_71A6::
    ld hl, $591D
    call SetRequestPtrC91A_B13
    ret

Jump_013_71AD::
    ld hl, $0B85
    call SetRequestPtrC921_B13
    ret

Jump_013_71B4::
    ld hl, $4E20
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ld hl, $592D
    call SetRequestPtrC91A_B13
    ret

Jump_013_71CA::
    ld de, $019A
    call TestFlagBit
    jr c, Jump_013_721E
    ld de, $0199
    call TestFlagBit
    jr c, Jump_013_7208
    ld de, $0198
    call TestFlagBit
    jr c, Jump_013_7201
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_71FA
    ldh a, [hFFC6]
    cp a, $8C
    jr nc, Jump_013_71FA
    ld hl, $0B82
    call SetRequestPtrC921_B13
    ret

Jump_013_71FA::
    ld hl, $5937
    call SetRequestPtrC91A_B13
    ret

Jump_013_7201::
    ld hl, $0B88
    call SetRequestPtrC921_B13
    ret

Jump_013_7208::
    ld hl, $7530
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ld hl, $5947
    call SetRequestPtrC91A_B13
    ret

Jump_013_721E::
    ld de, $019D
    call TestFlagBit
    jp c, Jump_013_7273
    ld de, $019C
    call TestFlagBit
    jr c, Jump_013_725D
    ld de, $019B
    call TestFlagBit
    jr c, Jump_013_7256
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_724F
    ldh a, [hFFC6]
    cp a, $A0
    jr nc, Jump_013_724F
    ld hl, $0B82
    call SetRequestPtrC921_B13
    ret

Jump_013_724F::
    ld hl, $5951
    call SetRequestPtrC91A_B13
    ret

Jump_013_7256::
    ld hl, $0B8B
    call SetRequestPtrC921_B13
    ret

Jump_013_725D::
    ld hl, vBGMap1 + $40
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ld hl, $5961
    call SetRequestPtrC91A_B13
    ret

Jump_013_7273::
    ld hl, $0B8D
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_727A:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7299
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7292
    ld hl, $0A3E
    call SetRequestPtrC921_B13
    ret

Jump_013_7292::
    ld hl, $0510
    call SetRequestPtrC921_B13
    ret

Jump_013_7299::
    ld de, $0192
    call TestFlagBit
    jr c, Jump_013_72A8
    ld hl, $0D93
    call SetRequestPtrC921_B13
    ret

Jump_013_72A8::
    ld de, $019C
    call TestFlagBit
    jr c, Jump_013_72E7
    ld de, $019B
    call TestFlagBit
    jr c, Jump_013_72E0
    ld de, $0199
    call TestFlagBit
    jr c, Jump_013_72E7
    ld de, $0198
    call TestFlagBit
    jr c, Jump_013_72E0
    ld de, $0196
    call TestFlagBit
    jr c, Jump_013_72E7
    ld de, $0195
    call TestFlagBit
    jr c, Jump_013_72E0
    ld de, $0193
    call TestFlagBit
    jr c, Jump_013_72E7

Jump_013_72E0::
    ld hl, $0B8E
    call SetRequestPtrC921_B13
    ret

Jump_013_72E7::
    ld hl, $0D94
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_72EE:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_730D
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7314
    ld de, $0122
    call TestFlagBit
    jr c, Jump_013_730D
    ld hl, $0A3F
    call SetRequestPtrC921_B13
    ret

Jump_013_730D::
    ld hl, $0511
    call SetRequestPtrC921_B13
    ret

Jump_013_7314::
    ld hl, $0544
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_731B:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_732B
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7332

Jump_013_732B::
    ld hl, $0A41
    call SetRequestPtrC921_B13
    ret

Jump_013_7332::
    ld hl, $0545
    call SetRequestPtrC921_B13
    ret
    db $21, $42, $0A, $CD, $01, $40, $C9, $11, $25, $00, $CD, $1B, $18, $38, $07, $21
    db $43, $0A, $CD, $01, $40, $C9, $21, $52, $0B, $CD, $01, $40, $C9, $21, $44, $0A
    db $CD, $01, $40, $C9, $21, $45, $0A, $CD, $01, $40, $C9

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Func_013_7364:: ; heuristic: target of a pointer table; C0
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7396
    ld de, $0118
    call TestFlagBit
    jr c, Jump_013_738F
    ld a, $01
    ld [wD7FB], a
    ld hl, $5660
    call SetRequestPtrC91A_B13
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_738F::
    ld hl, $0A49
    call SetRequestPtrC921_B13
    ret

Jump_013_7396::
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld de, $0125
    call TestFlagBit
    jr c, Jump_013_73B8
    ld a, $03
    ld [wD7FB], a
    ld hl, $5670
    call SetRequestPtrC91A_B13
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_73B8::
    ld hl, $0516
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_73BF:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_73DE
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_73D7
    ld hl, $0A4A
    call SetRequestPtrC921_B13
    ret

Jump_013_73D7::
    ld hl, $0517
    call SetRequestPtrC921_B13
    ret

Jump_013_73DE::
    ld hl, $0BB9
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_73E5:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wC921], a
    ld a, $47
    ld [wC922], a
    ld de, $0126
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_73F6:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7415
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_740E
    ld hl, $0A4C
    call SetRequestPtrC921_B13
    ret

Jump_013_740E::
    ld hl, $051F
    call SetRequestPtrC921_B13
    ret

Jump_013_7415::
    ld hl, $0BBB
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_741C:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_743A
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7433
    ld hl, $0A4D
    call SetRequestPtrC921_B13
    ret

Jump_013_7433::
    ld hl, $0520
    call SetRequestPtrC921_B13
    ret

Jump_013_743A::
    ld hl, $0BBC
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Func_013_7441:: ; heuristic: target of a pointer table; C0
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld de, $011A
    call TestFlagBit
    jr c, Jump_013_7463
    ld hl, $5680
    call SetRequestPtrC91A_B13
    ld a, $02
    ld [wD7FB], a
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_7463::
    ld hl, $04BA
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
Func_013_746A:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7488
    ld de, $011D
    call TestFlagBit
    jr c, Jump_013_7481
    ld hl, $5690
    call SetRequestPtrC91A_B13
    ret

Jump_013_7481::
    ld hl, $04CB
    call SetRequestPtrC921_B13
    ret

Jump_013_7488::
    ld de, $00C8
    call TestFlagBit
    jr c, Jump_013_74EA
    ld de, $003D
    call TestFlagBit
    jr c, Jump_013_74C6
    ld de, $002E
    call TestFlagBit
    jr c, Jump_013_74AD
    ld hl, $0B4A
    call SetRequestPtrC921_B13
    ld de, $002E
    call SetFlagBit
    ret

Jump_013_74AD::
    farcall Func_085_5A9D
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_74BF
    ld hl, $0B4B
    call SetRequestPtrC921_B13
    ret

Jump_013_74BF::
    ld hl, $56A0
    call SetRequestPtrC91A_B13
    ret

Jump_013_74C6::
    ld de, $0206
    call TestFlagBit
    jr nc, Jump_013_74D6
    ld de, $0207
    call TestFlagBit
    jr c, Jump_013_74DD

Jump_013_74D6::
    ld hl, $0B4D
    call SetRequestPtrC921_B13
    ret

Jump_013_74DD::
    ld hl, $56A8
    call SetRequestPtrC91A_B13
    ld de, $003E
    call SetFlagBit
    ret

Jump_013_74EA::
    ld hl, $0BB4
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
Func_013_74F1:: ; heuristic: target of a pointer table; C0
    ld de, $011E
    call TestFlagBit
    jr c, Jump_013_7518
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_750B
    ld hl, $04CE
    call SetRequestPtrC921_B13
    ret

Jump_013_750B::
    ld hl, $04CD
    call SetRequestPtrC921_B13
    ld de, $011E
    call SetFlagBit
    ret

Jump_013_7518::
    ld hl, $04CC
    call SetRequestPtrC921_B13
    ret
    INCBIN "dwm2-cobi-us.gbc", $04F51F, $62

; no direct call (reached through a table, a jump or a vector)
Func_013_7581:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7591
    ld hl, $0504
    call SetRequestPtrC921_B13
    ret

Jump_013_7591::
    ld hl, $0B05
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC7, hFFC6
; writes: hFFC6, hFFC7
Func_013_7598:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_75B6
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_75AF
    ld hl, $0512
    call SetRequestPtrC921_B13
    ret

Jump_013_75AF::
    ld hl, $053E
    call SetRequestPtrC921_B13
    ret

Jump_013_75B6::
    ld de, $003A
    call TestFlagBit
    jr c, Jump_013_7636
    ld de, $0039
    call TestFlagBit
    jr c, Jump_013_75E5
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_75DE
    ldh a, [hFFC6]
    cp a, $32
    jr nc, Jump_013_75DE
    ld hl, $0D92
    call SetRequestPtrC921_B13
    ret

Jump_013_75DE::
    ld hl, $58B5
    call SetRequestPtrC91A_B13
    ret

Jump_013_75E5::
    ld a, $07
    ldh [hFFC6], a
    farcall Func_085_5B23
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_7624
    farcall Func_012_6990
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_7607

Jump_013_7600::
    ld hl, $0B96
    call SetRequestPtrC921_B13
    ret

Jump_013_7607::
    ld a, $07
    ldh [hFFC7], a
    ld de, $0203
    call TestFlagBit
    jr nc, Jump_013_7617
    ld a, $47
    ldh [hFFC7], a

Jump_013_7617::
    farcall Func_012_6955
    ld hl, $58C3
    call SetRequestPtrC91A_B13
    ret

Jump_013_7624::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_013_7600
    ld hl, $58CD
    call SetRequestPtrC91A_B13
    ret

Jump_013_7636::
    ld de, $003C
    call TestFlagBit
    jr c, Jump_013_76B6
    ld de, $003B
    call TestFlagBit
    jr c, Jump_013_7665
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_765E
    ldh a, [hFFC6]
    cp a, $96
    jr nc, Jump_013_765E
    ld hl, $0B98
    call SetRequestPtrC921_B13
    ret

Jump_013_765E::
    ld hl, $58E1
    call SetRequestPtrC91A_B13
    ret

Jump_013_7665::
    ld a, $09
    ldh [hFFC6], a
    farcall Func_085_5B23
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_013_76A4
    farcall Func_012_6990
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_013_7687

Jump_013_7680::
    ld hl, $0B96
    call SetRequestPtrC921_B13
    ret

Jump_013_7687::
    ld a, $09
    ldh [hFFC7], a
    ld de, $0205
    call TestFlagBit
    jr nc, Jump_013_7697
    ld a, $49
    ldh [hFFC7], a

Jump_013_7697::
    farcall Func_012_6955
    ld hl, $58EF
    call SetRequestPtrC91A_B13
    ret

Jump_013_76A4::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_013_7680
    ld hl, $58F9
    call SetRequestPtrC91A_B13
    ret

Jump_013_76B6::
    ld hl, $0B98
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_76BD:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $11
    ld [wC922], a
    ld de, $011B
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_76CE:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $13
    ld [wC922], a
    ld de, $011C
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Func_013_76DF:: ; heuristic: target of a pointer table; C0
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld de, $0129
    call TestFlagBit
    jr c, Jump_013_7701
    ld hl, $56C8
    call SetRequestPtrC91A_B13
    ld a, $04
    ld [wD7FB], a
    ld a, $0E
    ld [wDataBank], a
    ret

Jump_013_7701::
    ld hl, $04C0
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC82C
Func_013_7708:: ; heuristic: target of a pointer table; C0
    ld a, [wC82C]
    cp a, $05
    jr z, Jump_013_7720
    or a, a
    jr nz, Jump_013_7719
    ld hl, $0276
    call SetRequestPtrC921_B13
    ret

Jump_013_7719::
    ld hl, $56D8
    call SetRequestPtrC91A_B13
    ret

Jump_013_7720::
    ld hl, $56E5
    call SetRequestPtrC91A_B13
    ret

Data_013_7727:: ; heuristic: target of a monotone pointer table; C0
    db $21, $F2, $56, $CD, $49, $40, $C9

; no direct call (reached through a table, a jump or a vector)
Func_013_772E:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld de, $0000
    call TestFlagBit
    jr c, Jump_013_7744
    ld hl, $5709
    call SetRequestPtrC91A_B13
    ret

Jump_013_7744::
    ld hl, $56F5
    call SetRequestPtrC91A_B13
    ret

Data_013_774B:: ; heuristic: target of a monotone pointer table; C0
    db $21, $24, $00, $CD, $01, $40, $C9

Data_013_7752:: ; heuristic: target of a monotone pointer table; C0
    db $21, $25, $00, $CD, $01, $40, $C9

Data_013_7759:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1D, $00, $CD, $01, $40, $C9

Data_013_7760:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1C, $00, $CD, $01, $40, $C9

Data_013_7767:: ; heuristic: target of a monotone pointer table; C0
    db $21, $F8, $64, $06, $12, $D7, $21, $85, $5E, $06, $02, $D7, $21, $85, $5E, $06
    db $02, $D7, $CD, $2B, $22, $21, $A8, $4A, $06, $04, $D7, $3E, $7F, $EA, $27, $C5
    db $C9

Data_013_7788:: ; heuristic: target of a monotone pointer table; C0
    db $21, $37, $00, $CD, $01, $40, $C9

Data_013_778F:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $17, $EA, $FB, $D7, $3E, $10, $EA, $FE, $D7, $21, $B3, $59, $CD, $49, $40
    db $C9

Data_013_77A0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $10, $27, $7D, $E0, $C6, $7C, $E0, $C7, $21, $C2, $7E, $06, $12, $D7, $21
    db $FE, $00, $CD, $01, $40, $C9

Data_013_77B6:: ; heuristic: target of a monotone pointer table; C0
    db $21, $4E, $0D, $CD, $01, $40, $C9

; no direct call (reached through a table, a jump or a vector)
Func_013_77BD:: ; heuristic: target of a pointer table; C0
    ld de, $000B
    call TestFlagBit
    jr nc, Jump_013_77CC
    ld de, $0025
    call TestFlagBit
    ret nc

Jump_013_77CC::
    ld hl, $0043
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_77D3:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_77F3
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7808
    ld de, $0002
    call TestFlagBit
    jr c, Jump_013_7801
    ld de, $000C
    call TestFlagBit
    jr c, Jump_013_77FA

Jump_013_77F3::
    ld hl, $0036
    call SetRequestPtrC921_B13
    ret

Jump_013_77FA::
    ld hl, $0076
    call SetRequestPtrC921_B13
    ret

Jump_013_7801::
    ld hl, $0D00
    call SetRequestPtrC921_B13
    ret

Jump_013_7808::
    ld hl, $050A
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC26A
Func_013_780F:: ; heuristic: target of a pointer table; C0
    ld a, [wC26A]
    cp a, $1A
    ret nz
    ld hl, $0037
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Func_013_781C:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7FB], a
    ld hl, $5660
    call SetRequestPtrC91A_B13
    ld a, $0E
    ld [wDataBank], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_782D:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_784B
    ld de, $0024
    call TestFlagBit
    jr c, Jump_013_7844
    ld hl, $0268
    call SetRequestPtrC921_B13
    ret

Jump_013_7844::
    ld hl, $0529
    call SetRequestPtrC921_B13
    ret

Jump_013_784B::
    ld hl, $0B48
    call SetRequestPtrC921_B13
    ret

Data_013_7852:: ; heuristic: target of a monotone pointer table; C0
    db $21, $2E, $02, $CD, $01, $40, $C9

Data_013_7859:: ; heuristic: target of a monotone pointer table; C0
    db $21, $2F, $02, $CD, $01, $40, $C9

Data_013_7860:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $21, $42, $02, $CD, $01, $40, $C9, $21
    db $33, $0B, $CD, $01, $40, $C9

Data_013_7876:: ; heuristic: target of a monotone pointer table; C0
    db $21, $B1, $02, $CD, $01, $40, $C9

Data_013_787D:: ; heuristic: target of a monotone pointer table; C0
    db $11, $22, $00, $CD, $1B, $18, $38, $16, $11, $21, $00, $CD, $1B, $18, $38, $07
    db $21, $1D, $57, $CD, $49, $40, $C9, $21, $2A, $57, $CD, $49, $40, $C9, $21, $37
    db $57, $CD, $49, $40, $C9

Data_013_78A2:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $DA, $B2, $78, $21, $A6, $02, $CD, $01, $40, $C9
    db $21, $07, $0B, $CD, $01, $40, $C9

Data_013_78B9:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $DA, $C9, $78, $21, $09, $02, $CD, $01, $40, $C9
    db $21, $09, $0B, $CD, $01, $40, $C9

Data_013_78D0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $51, $0A, $CD, $01, $40, $C9

Data_013_78D7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $44, $57, $CD, $49, $40, $C9

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5
Func_013_78DE:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_78ED

Jump_013_78E6::
    ld hl, $08D1
    call SetRequestPtrC921_B13
    ret

Jump_013_78ED::
    ld de, $0029
    call TestFlagBit
    jr c, Jump_013_78E6
    farcall Func_05F_6D78
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_013_7909
    ld hl, $57FE
    call SetRequestPtrC91A_B13
    ret

Jump_013_7909::
    ld hl, $580B
    call SetRequestPtrC91A_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC82C
Func_013_7910:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_793B
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_7934
    ld a, [wC82C]
    or a, a
    jr nz, Jump_013_792D
    ld hl, $04D2
    call SetRequestPtrC921_B13
    ret

Jump_013_792D::
    ld hl, $0D0C
    call SetRequestPtrC921_B13
    ret

Jump_013_7934::
    ld hl, $08D2
    call SetRequestPtrC921_B13
    ret

Jump_013_793B::
    ld hl, $0B25
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7942:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7951
    ld hl, $021F
    call SetRequestPtrC921_B13
    ret

Jump_013_7951::
    ld hl, $0B12
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7958:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7967
    ld hl, $0220
    call SetRequestPtrC921_B13
    ret

Jump_013_7967::
    ld hl, $0B13
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_796E:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_797D
    ld hl, $027F
    call SetRequestPtrC921_B13
    ret

Jump_013_797D::
    ld hl, $0B76
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7984:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7993
    ld hl, $0280
    call SetRequestPtrC921_B13
    ret

Jump_013_7993::
    ld hl, $0B77
    call SetRequestPtrC921_B13
    ret

Data_013_799A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $84, $02, $CD, $01, $40, $C9

Data_013_79A1:: ; heuristic: target of a monotone pointer table; C0
    db $21, $85, $02, $CD, $01, $40, $C9

Data_013_79A8:: ; heuristic: target of a monotone pointer table; C0
    db $21, $88, $02, $CD, $01, $40, $C9

Data_013_79AF:: ; heuristic: target of a monotone pointer table; C0
    db $21, $52, $57, $CD, $49, $40, $C9

Data_013_79B6:: ; heuristic: target of a monotone pointer table; C0
    db $21, $93, $02, $CD, $01, $40, $C9

Data_013_79BD:: ; heuristic: target of a monotone pointer table; C0
    db $21, $95, $02, $CD, $01, $40, $C9

Data_013_79C4:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $21, $7B, $02, $CD, $01, $40, $C9, $21
    db $68, $0B, $CD, $01, $40, $C9

Data_013_79DA:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $21, $7C, $02, $CD, $01, $40, $C9, $21
    db $69, $0B, $CD, $01, $40, $C9

Data_013_79F0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $9C, $02, $CD, $01, $40, $C9

Data_013_79F7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $9D, $02, $CD, $01, $40, $C9

Data_013_79FE:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $EA, $21, $C9, $3E, $2C, $EA, $22, $C9, $11, $32, $01, $CD, $25, $40
    db $C9

Data_013_7A0F:: ; heuristic: target of a monotone pointer table; C0
    db $21, $B1, $02, $CD, $01, $40, $C9

Data_013_7A16:: ; heuristic: target of a monotone pointer table; C0
    db $21, $25, $02, $CD, $01, $40, $C9

Data_013_7A1D:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $EA, $21, $C9, $3E, $2C, $EA, $22, $C9, $11, $30, $01, $CD, $25, $40
    db $C9

Data_013_7A2E:: ; heuristic: target of a monotone pointer table; C0
    db $21, $4A, $02, $CD, $01, $40, $C9

Data_013_7A35:: ; heuristic: target of a monotone pointer table; C0
    db $21, $80, $7E, $06, $12, $D7, $F0, $C7, $CB, $7F, $C0, $EA, $34, $C9, $21, $5F
    db $57, $CD, $49, $40, $C9

Data_013_7A4A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04FA4A, $49

Data_013_7A93:: ; heuristic: target of a monotone pointer table; C0
    db $21, $45, $02, $CD, $01, $40, $C9

; no direct call (reached through a table, a jump or a vector)
Func_013_7A9A:: ; heuristic: target of a pointer table; C0
    farcall Func_085_5DB9
    ld hl, $00FC
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7AA7:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7AB6
    ld hl, $0A74
    call SetRequestPtrC921_B13
    ret

Jump_013_7AB6::
    ld hl, $0B51
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7ABD:: ; heuristic: target of a pointer table; C0
    ld de, $0023
    call TestFlagBit
    ret nc
    ld hl, $57A2
    call SetRequestPtrC91A_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_7ACB:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $013C
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_7ADC:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wC921], a
    ld a, $1C
    ld [wC922], a
    ld de, $013D
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7AED:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jp c, Jump_013_7AFD
    ld hl, $0A35
    call SetRequestPtrC921_B13
    ret

Jump_013_7AFD::
    ld hl, $0B0A
    call SetRequestPtrC921_B13
    ret
    db $21, $34, $0A, $CD, $01, $40, $C9

; no direct call (reached through a table, a jump or a vector)
Func_013_7B0B:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B1A
    ld hl, $0A68
    call SetRequestPtrC921_B13
    ret

Jump_013_7B1A::
    ld hl, $0BBD
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7B21:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B3F
    ld de, $0136
    call TestFlagBit
    jr c, Jump_013_7B38
    ld hl, $0A6B
    call SetRequestPtrC921_B13
    ret

Jump_013_7B38::
    ld hl, $0A6C
    call SetRequestPtrC921_B13
    ret

Jump_013_7B3F::
    ld hl, $0BBE
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7B46:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B56
    ld de, $00D1
    call TestFlagBit
    jr c, Jump_013_7B5D

Jump_013_7B56::
    ld hl, $0A40
    call SetRequestPtrC921_B13
    ret

Jump_013_7B5D::
    ld hl, $0545
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7B64:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7B83
    ld de, $0024
    call TestFlagBit
    jp c, Jump_013_7B7C
    ld hl, $0A4B
    call SetRequestPtrC921_B13
    ret

Jump_013_7B7C::
    ld hl, $0518
    call SetRequestPtrC921_B13
    ret

Jump_013_7B83::
    ld hl, $0BBA
    call SetRequestPtrC921_B13
    ret

Data_013_7B8A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $D1, $04, $CD, $01, $40, $C9

Data_013_7B91:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $04FB91, $166

Data_013_7CF7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $19, $05, $CD, $01, $40, $C9

Data_013_7CFE:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1A, $05, $CD, $01, $40, $C9

Data_013_7D05:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1B, $05, $CD, $01, $40, $C9

Data_013_7D0C:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1C, $05, $CD, $01, $40, $C9

Data_013_7D13:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1D, $05, $CD, $01, $40, $C9

Data_013_7D1A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $1E, $05, $CD, $01, $40, $C9

Data_013_7D21:: ; heuristic: target of a monotone pointer table; C0
    db $21, $5E, $05, $CD, $01, $40, $C9

Data_013_7D28:: ; heuristic: target of a monotone pointer table; C0
    db $21, $D5, $0D, $CD, $01, $40, $C9

Data_013_7D2F:: ; heuristic: target of a monotone pointer table; C0
    db $FA, $CE, $CE, $FE, $01, $C0, $FA, $CF, $CB, $B7, $C0, $3E, $14, $E0, $C6, $21
    db $98, $6B, $06, $12, $D7, $C9

Data_013_7D45:: ; heuristic: target of a monotone pointer table; C0
    db $FA, $CE, $CE, $FE, $01, $C0, $FA, $C1, $CE, $B7, $20, $07, $21, $E3, $57, $CD
    db $49, $40, $C9, $11, $52, $C1, $CD, $31, $24, $21, $E8, $57, $CD, $49, $40, $C9

Data_013_7D65:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $8E, $FE, $30, $20, $07, $21, $66, $0D, $0E, $00, $18, $10, $FE, $40, $20
    db $07, $21, $67, $0D, $0E, $01, $18, $05, $21, $68, $0D, $0E, $02, $CD, $01, $40
    db $21, $F5, $5D, $06, $85, $D7, $C9

Data_013_7D8C:: ; heuristic: target of a monotone pointer table; C0
    db $AF, $EA, $68, $C9, $C9

; no direct call (reached through a table, a jump or a vector)
Func_013_7D91:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DA0
    ld hl, $029B
    call SetRequestPtrC921_B13
    ret

Jump_013_7DA0::
    ld hl, $0B1F
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7DA7:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DB7
    ld de, $0022
    call TestFlagBit
    jr c, Jump_013_7DBE

Jump_013_7DB7::
    ld hl, $0DE3
    call SetRequestPtrC921_B13
    ret

Jump_013_7DBE::
    ld hl, $0DE4
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7DC5:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_013_7DD4
    ld hl, $0220
    call SetRequestPtrC921_B13
    ret

Jump_013_7DD4::
    ld hl, $0B13
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_7DDB:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $26
    ld [wC922], a
    ld de, $013E
    call SetRequestPtrC924FromDE_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_013_7DEC:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $42
    ld [wC922], a
    ld de, $013F
    call SetRequestPtrC924FromDE_B13
    ret
    db $21, $5F, $05, $CD, $01, $40, $C9, $C9

; no direct call (reached through a table, a jump or a vector)
; reads: wCB81, hFFC7, hFFC6
; writes: wDataBank, wD7FB
Func_013_7E05:: ; heuristic: target of a pointer table; C0
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld a, $0E
    ld [wDataBank], a
    ld a, [wCB81]
    cp a, $17
    jr z, Jump_013_7E6C
    cp a, $13
    jr z, Jump_013_7E39
    ld de, $0032
    call TestFlagBit
    jr c, Jump_013_7E32
    ld a, $05
    ld [wD7FB], a
    ld hl, $581C
    call SetRequestPtrC91A_B13
    ret

Jump_013_7E32::
    ld hl, $0B56
    call SetRequestPtrC921_B13
    ret

Jump_013_7E39::
    ld de, $0033
    call TestFlagBit
    jr c, Jump_013_7E65
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_7E59
    ldh a, [hFFC6]
    cp a, $64
    jr nc, Jump_013_7E59
    ld hl, $0D8E
    call SetRequestPtrC921_B13
    ret

Jump_013_7E59::
    ld a, $06
    ld [wD7FB], a
    ld hl, $582C
    call SetRequestPtrC91A_B13
    ret

Jump_013_7E65::
    ld hl, $0B5A
    call SetRequestPtrC921_B13
    ret

Jump_013_7E6C::
    ld de, $0034
    call TestFlagBit
    jr c, Jump_013_7E98
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_7E8C
    ldh a, [hFFC6]
    cp a, $96
    jr nc, Jump_013_7E8C
    ld hl, $0D8F
    call SetRequestPtrC921_B13
    ret

Jump_013_7E8C::
    ld a, $07
    ld [wD7FB], a
    ld hl, $583C
    call SetRequestPtrC91A_B13
    ret

Jump_013_7E98::
    ld hl, $0B5E
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCB81, hFFC7, hFFC6
; writes: wDataBank, wD7FB
Func_013_7E9F:: ; heuristic: target of a pointer table; C0
    farcall Func_002_5EEE
    call Func_013_7FB0
    ld a, $0E
    ld [wDataBank], a
    ld a, [wCB81]
    cp a, $14
    jr z, Jump_013_7ECF
    ld de, $0035
    call TestFlagBit
    jr c, Jump_013_7EC8
    ld a, $08
    ld [wD7FB], a
    ld hl, $584C
    call SetRequestPtrC91A_B13
    ret

Jump_013_7EC8::
    ld hl, $0B6D
    call SetRequestPtrC921_B13
    ret

Jump_013_7ECF::
    ld de, $0036
    call TestFlagBit
    jr c, Jump_013_7EFB
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_7EEF
    ldh a, [hFFC6]
    cp a, $64
    jr nc, Jump_013_7EEF
    ld hl, $0D85
    call SetRequestPtrC921_B13
    ret

Jump_013_7EEF::
    ld a, $09
    ld [wD7FB], a
    ld hl, $585C
    call SetRequestPtrC91A_B13
    ret

Jump_013_7EFB::
    ld hl, $0B73
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC7, hFFC6
Func_013_7F02:: ; heuristic: target of a pointer table; C0
    ld de, $0038
    call TestFlagBit
    jr c, Jump_013_7F2A
    farcall Func_085_5B04
    ldh a, [hFFC7]
    cp a, $01
    jr z, Jump_013_7F23
    ldh a, [hFFC6]
    cp a, $96
    jr nc, Jump_013_7F23
    ld hl, $0D90
    call SetRequestPtrC921_B13
    ret

Jump_013_7F23::
    ld hl, $5899
    call SetRequestPtrC91A_B13
    ret

Jump_013_7F2A::
    ld hl, $0BB3
    call SetRequestPtrC921_B13
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC7, hFFC6
; writes: wCB8A
Func_013_7F31:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    ret nc
    farcall Func_085_5B04
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_013_7F48
    ldh a, [hFFC6]
    cp a, $32
    ret c

Jump_013_7F48::
    ld a, $30
    ld [wCB8A], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7F4E:: ; heuristic: target of a pointer table; C0
    ld de, $0032
    call TestFlagBit
    jr nc, Jump_013_7F5C
    ld de, $00C9
    call SetFlagBit

Jump_013_7F5C::
    ld de, $0033
    call TestFlagBit
    ret nc
    ld de, $00CA
    call SetFlagBit
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7F6A:: ; heuristic: target of a pointer table; C0
    ld de, $0035
    call TestFlagBit
    jr nc, Jump_013_7F78
    ld de, $00CB
    call SetFlagBit

Jump_013_7F78::
    ld de, $0036
    call TestFlagBit
    ret nc
    ld de, $00CC
    call SetFlagBit
    ret

; no direct call (reached through a table, a jump or a vector)
Func_013_7F86:: ; heuristic: target of a pointer table; C0
    ld de, $0021
    call TestFlagBit
    ret nc
    ld hl, $5988
    call SetRequestPtrC91A_B13
    ret

; 5 call sites from 4 routines (e.g. Func_013_5EF4, Func_013_5C0B, Func_013_5922, Func_013_405C)
; reads: wC634
; points at: wInventory
Func_013_7F94::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_013_7FA0
    or a, a
    jr z, Jump_013_7FA0
    sub a, a
    ret

Jump_013_7FA0::
    ld hl, wInventory

Jump_013_7FA3::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_013_7FAE
    or a, a
    jr z, Jump_013_7FAE
    inc hl
    jr Jump_013_7FA3

Jump_013_7FAE::
    scf
    ret

; 8 call sites from 6 routines (e.g. Func_013_5EF4, Func_013_7E9F, Func_013_7E05, Func_013_76DF, ...)
; reads: wCB86, hPlayerX, hPlayerY, hPlayerFacing, wC8EF, wC8F0, wC8F1, wC8F4, ...
; writes: wC937, wC938, wC939, wC93A, wC93B, wC93C, wC93D, wC93E, ...
Func_013_7FB0::
    ld a, [wCB86]
    ld [wC937], a
    ldh a, [hPlayerX]
    ld [wC938], a
    ldh a, [hPlayerY]
    ld [wC939], a
    ldh a, [hPlayerFacing]
    ld [wC93A], a
    ld a, [wC8EF]
    ld [wC93B], a
    ld a, [wC8F0]
    ld [wC93C], a
    ld a, [wC8F1]
    ld [wC93D], a
    ld a, [wC8F4]
    ld [wC93E], a
    ld a, [wC8F5]
    ld [wC93F], a
    ld a, [wC8F6]
    ld [wC940], a
    ld a, [wC8F9]
    ld [wC941], a
    ld a, [wC8FA]
    ld [wC942], a
    ld a, [wC8FB]
    ld [wC943], a
    ret
    db $00, $00, $00, $00
