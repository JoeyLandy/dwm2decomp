SECTION "Bank 1B", ROMX[$4000], BANK[$1B]
    db $1B

Func_01B_4001::
    ld a, [wC580]
    bit 7, a
    jr z, Jump_01B_400E
    set 6, a
    ld [wC580], a
    ret

Jump_01B_400E::
    ld a, [wC581]
    and a, a
    jr z, Jump_01B_402A
    ld a, [wC581]
    rst $00
    dw Jump_01B_402A
    dw Jump_01B_43E9
    dw Jump_01B_4420
    dw Jump_01B_4457
    dw Jump_01B_448E
    dw Jump_01B_44C5
    dw Jump_01B_44FC
    dw Jump_01B_4533
    dw Jump_01B_456A

Jump_01B_402A::
    ld a, $FF
    ld [wD784], a
    xor a, a
    ld [wD783], a
    ld [wD784], a
    call Func_000_07D1
    ld a, [wD781]
    ld [wD784], a
    ldh a, [rSB]
    ld b, a
    cp a, $F1
    jp z, Jump_01B_4132
    cp a, $F5
    jr z, Jump_01B_4060
    cp a, $F6
    jr z, Jump_01B_408A
    cp a, $B7
    jr z, Jump_01B_40B4
    cp a, $E0
    jp z, Jump_01B_40DE
    cp a, $DC
    jp z, Jump_01B_4108
    jp Jump_01B_4163

Jump_01B_4060::
    call Func_01B_4394
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wC46B]
    cp a, $02
    jr z, Jump_01B_407D
    ld a, $02
    ld [wC471], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_407D::
    ld a, [wC57F]
    set 0, a
    set 1, a
    ld [wC57F], a
    jp Jump_01B_42A4

Jump_01B_408A::
    call Func_01B_4394
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wC46B]
    cp a, $03
    jr z, Jump_01B_40A7
    ld a, $03
    ld [wC471], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_40A7::
    ld a, [wC57F]
    set 0, a
    set 1, a
    ld [wC57F], a
    jp Jump_01B_42C3

Jump_01B_40B4::
    call Func_01B_4394
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wC46B]
    cp a, $04
    jr z, Jump_01B_40D1
    ld a, $04
    ld [wC471], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_40D1::
    ld a, [wC57F]
    set 0, a
    set 1, a
    ld [wC57F], a
    jp Jump_01B_4301

Jump_01B_40DE::
    call Func_01B_4394
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wC46B]
    cp a, $06
    jr z, Jump_01B_40FB
    ld a, $06
    ld [wC471], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_40FB::
    ld a, [wC57F]
    set 0, a
    set 1, a
    ld [wC57F], a
    jp Jump_01B_4320

Jump_01B_4108::
    call Func_01B_4394
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wC46B]
    cp a, $05
    jr z, Jump_01B_4125
    ld a, $05
    ld [wC471], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_4125::
    ld a, [wC57F]
    set 0, a
    set 1, a
    ld [wC57F], a
    jp Jump_01B_42E2

Jump_01B_4132::
    call Func_01B_4394
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wC46B]
    cp a, $07
    jr z, Jump_01B_4156
    ld a, [wC894]
    or a, a
    jp z, Jump_01B_4357
    ld a, $07
    ld [wC471], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_4156::
    ld a, [wC57F]
    set 0, a
    set 1, a
    ld [wC57F], a
    jp Jump_01B_426F

Jump_01B_4163::
    ld a, [wD06B]
    cp a, $02
    jr z, Jump_01B_416D
    jp Jump_01B_4357

Jump_01B_416D::
    ld a, [wC588]
    cp a, b
    jp z, Jump_01B_4357
    call Func_01B_4388
    ld a, b
    ld [wD780], a
    cp a, $F3
    jr nz, Jump_01B_41A1
    ld a, [wC46B]
    cp a, $07
    jr z, Jump_01B_4194
    ld a, $FF
    ld [wC470], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_4194::
    ld a, [wC57F]
    set 0, a
    res 1, a
    ld [wC57F], a
    jp Jump_01B_426F

Jump_01B_41A1::
    cp a, $FA
    jr nz, Jump_01B_41C7
    ld a, [wC46B]
    cp a, $02
    jr z, Jump_01B_41BA
    ld a, $FF
    ld [wC470], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_41BA::
    ld a, [wC57F]
    set 0, a
    res 1, a
    ld [wC57F], a
    jp Jump_01B_42A4

Jump_01B_41C7::
    cp a, $FB
    jr nz, Jump_01B_41ED
    ld a, [wC46B]
    cp a, $03
    jr z, Jump_01B_41E0
    ld a, $FF
    ld [wC470], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_41E0::
    ld a, [wC57F]
    set 0, a
    res 1, a
    ld [wC57F], a
    jp Jump_01B_42C3

Jump_01B_41ED::
    cp a, $FC
    jr nz, Jump_01B_4213
    ld a, [wC46B]
    cp a, $04
    jr z, Jump_01B_4206
    ld a, $FF
    ld [wC470], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_4206::
    ld a, [wC57F]
    set 0, a
    res 1, a
    ld [wC57F], a
    jp Jump_01B_4301

Jump_01B_4213::
    cp a, $E1
    jr nz, Jump_01B_4239
    ld a, [wC46B]
    cp a, $06
    jr z, Jump_01B_422C
    ld a, $FF
    ld [wC470], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_422C::
    ld a, [wC57F]
    set 0, a
    res 1, a
    ld [wC57F], a
    jp Jump_01B_4320

Jump_01B_4239::
    cp a, $DD
    jr nz, Jump_01B_425F
    ld a, [wC46B]
    cp a, $05
    jr z, Jump_01B_4252
    ld a, $FF
    ld [wC470], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_4252::
    ld a, [wC57F]
    set 0, a
    res 1, a
    ld [wC57F], a
    jp Jump_01B_42E2

Jump_01B_425F::
    ld a, $FF
    ld [wC470], a
    jp Jump_01B_4357
    db $3E, $FF, $EA, $70, $C4, $C3, $57, $43

Jump_01B_426F::
    ld a, $69
    call Func_000_1278
    ld a, $00
    ld [wC55D], a
    ld a, $01
    ld [wC58A], a
    di
    ld hl, Func_002_717D
    ld b, $02
    rst $10
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_01B_4292
    ld hl, Func_060_6CD1
    ld b, $60
    rst $10

Jump_01B_4292::
    ei
    ld hl, wC5DB
    ld a, $05
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $05
    ld [wC581], a
    jp Jump_01B_433F

Jump_01B_42A4::
    ld a, $69
    call Func_000_1278
    ld a, $00
    ld [wC55D], a
    ld a, $01
    ld [wC58A], a
    ld hl, wC5DB
    ld a, $05
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [wC581], a
    jr Jump_01B_433F

Jump_01B_42C3::
    ld a, $69
    call Func_000_1278
    ld a, $00
    ld [wC55D], a
    ld a, $01
    ld [wC58A], a
    ld hl, wC5DB
    ld a, $05
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $03
    ld [wC581], a
    jr Jump_01B_433F

Jump_01B_42E2::
    ld a, $69
    call Func_000_1278
    ld a, $00
    ld [wC55D], a
    ld a, $01
    ld [wC58A], a
    ld hl, wC5DB
    ld a, $05
    ld [hl+], a
    ld a, $07
    ld [hl+], a
    ld a, $08
    ld [wC581], a
    jr Jump_01B_433F

Jump_01B_4301::
    ld a, $69
    call Func_000_1278
    ld a, $00
    ld [wC55D], a
    ld a, $01
    ld [wC58A], a
    ld hl, wC5DB
    ld a, $05
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $04
    ld [wC581], a
    jr Jump_01B_433F

Jump_01B_4320::
    ld a, $69
    call Func_000_1278
    ld a, $00
    ld [wC55D], a
    ld a, $02
    ld [wC58A], a
    ld hl, wC5DB
    ld a, $05
    ld [hl+], a
    ld a, $06
    ld [hl+], a
    ld a, $06
    ld [wC581], a
    jr Jump_01B_433F

Jump_01B_433F::
    xor a, a
    ld [wC5DD], a
    ld [wC5DE], a
    ld [wC582], a
    ld [wC583], a
    ld [wC58B], a
    ld a, $01
    ld [wC5DF], a
    call Func_01B_4362

Jump_01B_4357::
    ld a, $03
    ld [wC580], a
    ld a, $F8
    call Func_000_08BA
    ret

Func_01B_4362::
    xor a, a
    ld [wSoundChannelSlots], a
    ld [wDC01], a
    ld [wDC20], a
    ld [wDC21], a
    ld [wDC40], a
    ld [wDC41], a
    ld [wDC60], a
    ld [wDC61], a
    ld [wDC80], a
    ld [wDC81], a
    ld [wDCA0], a
    ld [wDCA1], a
    ret

Func_01B_4388::
    push bc
    ld bc, $0100

Jump_01B_438C::
    dec bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_438C
    pop bc
    ret

Func_01B_4394::
    ld [wD783], a
    ld c, a
    ld a, [wC588]
    cp a, c
    jr nz, Jump_01B_43A7
    ld a, [wD06B]
    cp a, $01
    jr z, Jump_01B_43A7
    jr Jump_01B_43CC

Jump_01B_43A7::
    ld a, [wC5DB]
    cp a, $05
    jr nz, Jump_01B_43CC
    ld a, [wC5DC]
    cp a, $01
    jr nz, Jump_01B_43CC
    ld a, [wD06A]
    or a, a
    jr nz, Jump_01B_43CC
    ld a, [wD06C]
    or a, a
    jr nz, Jump_01B_43CC
    ld a, [wD06B]
    cp a, $01
    jr z, Jump_01B_43CA
    jr Jump_01B_43CC

Jump_01B_43CA::
    xor a, a
    ret

Jump_01B_43CC::
    ld a, $FF
    ret

Func_01B_43CF:: ; heuristic: follows a terminator; C0
    ld a, [wC471]
    ld de, Data_01B_43E1
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_01B_43DC
    inc d

Jump_01B_43DC::
    ld a, [de]
    call Func_000_08BA
    ret

Data_01B_43E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3

Jump_01B_43E9::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_43F9
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_43F9
    call Func_01B_43FA

Jump_01B_43F9::
    ret

Func_01B_43FA::
    ld a, [wC582]
    rst $00
    dw Jump_01B_4402
    dw Jump_01B_4406

Jump_01B_4402::
    call Func_01B_468A
    ret

Jump_01B_4406::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_031_40CC
    ld b, $31
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_4420::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_4430
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_4430
    call Func_01B_4431

Jump_01B_4430::
    ret

Func_01B_4431::
    ld a, [wC582]
    rst $00
    dw Jump_01B_4439
    dw Jump_01B_443D

Jump_01B_4439::
    call Func_01B_468A
    ret

Jump_01B_443D::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_0F1_4AD0
    ld b, $F1
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_4457::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_4467
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_4467
    call Func_01B_4468

Jump_01B_4467::
    ret

Func_01B_4468::
    ld a, [wC582]
    rst $00
    dw Jump_01B_4470
    dw Jump_01B_4474

Jump_01B_4470::
    call Func_01B_468A
    ret

Jump_01B_4474::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_01B_53CE
    ld b, $1B
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_448E::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_449E
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_449E
    call Func_01B_449F

Jump_01B_449E::
    ret

Func_01B_449F::
    ld a, [wC582]
    rst $00
    dw Jump_01B_44A7
    dw Jump_01B_44AB

Jump_01B_44A7::
    call Func_01B_468A
    ret

Jump_01B_44AB::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_007_6C12
    ld b, $07
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_44C5::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_44D5
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_44D5
    call Func_01B_44D6

Jump_01B_44D5::
    ret

Func_01B_44D6::
    ld a, [wC582]
    rst $00
    dw Jump_01B_44DE
    dw Jump_01B_44E2

Jump_01B_44DE::
    call Func_01B_468A
    ret

Jump_01B_44E2::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_037_4AFD
    ld b, $37
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_44FC::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_450C
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_450C
    call Func_01B_450D

Jump_01B_450C::
    ret

Func_01B_450D::
    ld a, [wC582]
    rst $00
    dw Jump_01B_4515
    dw Jump_01B_4519

Jump_01B_4515::
    call Func_01B_468A
    ret

Jump_01B_4519::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_033_5215
    ld b, $33
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_4533::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_4543
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_4543
    call Func_01B_4544

Jump_01B_4543::
    ret

Func_01B_4544::
    ld a, [wC582]
    rst $00
    dw Jump_01B_454C
    dw Jump_01B_4550

Jump_01B_454C::
    call Func_01B_468A
    ret

Jump_01B_4550::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_0A0_4F8E
    ld b, $A0
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_456A::
    ld a, [wC58A]
    or a, a
    jr z, Jump_01B_457A
    ld a, [wC57F]
    bit 0, a
    jr z, Jump_01B_457A
    call Func_01B_457B

Jump_01B_457A::
    ret

Func_01B_457B::
    ld a, [wC582]
    rst $00
    dw Jump_01B_4583
    dw Jump_01B_4587

Jump_01B_4583::
    call Func_01B_468A
    ret

Jump_01B_4587::
    call Func_01B_4736
    ld hl, wC5ED
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call Func_01B_47CA
    ld hl, Func_0F0_4CA0
    ld b, $F0
    rst $10
    ld hl, wC5ED
    res 1, [hl]
    ret

Func_01B_45A1:: ; heuristic: follows a terminator; C0
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_01B_45B2
    ld a, $01
    ld [wC582], a
    ld a, $F9
    jp Func_000_08BA

Jump_01B_45B2::
    ld a, [wC5ED]
    bit 1, a
    jr nz, Jump_01B_45DB
    ldh a, [rSB]
    ld [wC586], a
    ld a, [wC560]
    ld [wC561], a
    ld a, [wC586]
    ld [wC560], a
    call Func_000_0A17
    call Func_000_0A8D
    ld a, $01
    ld [wC582], a
    ld a, [wC55E]
    jp Func_000_08AD

Jump_01B_45DB::
    ld a, $20

Jump_01B_45DD::
    dec a
    jr nz, Jump_01B_45DD
    ld hl, wC5ED
    set 2, [hl]
    ld a, $01
    ld [wC582], a
    ld a, $F3
    jp Func_000_08AD

Func_01B_45EF:: ; heuristic: follows a terminator; C0
    ld a, [wC57F]
    bit 1, a
    jr nz, Func_01B_465B
    ld a, [wC58C]
    or a, a
    jr nz, Jump_01B_4608
    ldh a, [rSB]
    ld [wC586], a
    cp a, $F3
    jp z, Jump_01B_462E
    jr Jump_01B_460D

Jump_01B_4608::
    ldh a, [rSB]
    ld [wC586], a

Jump_01B_460D::
    ld hl, wC5ED
    set 1, [hl]
    ld a, [wC560]
    ld [wC561], a
    ld a, [wC586]
    ld [wC560], a
    call Func_000_0A8D
    call Func_01B_47CA
    xor a, a
    ld [wC582], a
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_462E::
    ld a, [wC56A]
    ld [wC55E], a
    ld a, [wC56B]
    ld [wC55F], a
    ld a, [wC594]
    cp a, $FF
    jr nz, Jump_01B_4651
    ld a, [wC595]
    sub a, $01
    ld [wC595], a
    ld a, [wC596]
    sbc a, $00
    ld [wC596], a

Jump_01B_4651::
    xor a, a
    ld [wC582], a
    ld hl, wC5ED
    set 7, [hl]
    ret

Func_01B_465B:: ; heuristic: follows a terminator; C0
    ld hl, wC5ED
    bit 2, [hl]
    jr nz, Jump_01B_4676
    set 1, [hl]
    xor a, a
    ld [wC582], a
    ld a, $FA
    call Func_000_08BA
    call Func_01B_47CA
    ld hl, wC5ED
    res 1, [hl]
    ret

Jump_01B_4676::
    ld hl, wC5ED
    res 2, [hl]
    xor a, a
    ld [wC582], a
    ld a, $FB
    call Func_000_08BA
    ld hl, wC5ED
    set 7, [hl]
    ret

Func_01B_468A::
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_01B_469B
    ld a, $01
    ld [wC582], a
    ld a, $F9
    jp Func_000_08BA

Jump_01B_469B::
    ld a, [wC5ED]
    bit 1, a
    jp nz, Jump_01B_45DB
    ld a, [wC594]
    cp a, $FF
    jr z, Jump_01B_46C3
    ldh a, [rSB]
    ld [wC586], a
    ld [wC58F], a
    call Func_000_0A17
    call Func_000_0A8D
    ld a, $01
    ld [wC582], a
    ld a, [wC594]
    jp Func_000_08AD

Jump_01B_46C3::
    ld hl, wC592
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_01B_471E
    ld a, [wC590]
    ld l, a
    ld a, [wC591]
    ld h, a
    ldh a, [rSB]
    ld [hl], a
    call Func_000_0A17
    call Func_000_0A8D
    ld a, [wC590]
    add a, $01
    ld [wC590], a
    ld a, [wC591]
    adc a, $00
    ld [wC591], a
    ld a, [wC592]
    sub a, $01
    ld [wC592], a
    ld a, [wC593]
    sbc a, $00
    ld [wC593], a
    ld a, [wC595]
    ld l, a
    ld a, [wC596]
    ld h, a
    push hl
    ld a, [wC595]
    add a, $01
    ld [wC595], a
    ld a, [wC596]
    adc a, $00
    ld [wC596], a
    pop hl
    ld a, $01
    ld [wC582], a
    ld a, [hl]
    jp Func_000_08AD

Jump_01B_471E::
    ld a, $01
    ld [wC582], a
    ldh a, [rSB]
    ld [wC586], a
    ld [wC58F], a
    call Func_000_0A17
    call Func_000_0A8D
    ld a, $F0
    jp Func_000_08AD

Func_01B_4736::
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_01B_47B6
    ld a, [wC58C]
    or a, a
    jr nz, Jump_01B_474F
    ldh a, [rSB]
    ld [wC586], a
    cp a, $F3
    jp z, Jump_01B_462E
    jr Jump_01B_4754

Jump_01B_474F::
    ldh a, [rSB]
    ld [wC586], a

Jump_01B_4754::
    ld hl, wC5ED
    set 1, [hl]
    ld a, [wC594]
    cp a, $FF
    jr z, Jump_01B_476E
    ld a, [wC586]
    ld [wC58F], a
    call Func_000_0A8D
    xor a, a
    ld [wC582], a
    ret

Jump_01B_476E::
    ld hl, wC592
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_01B_47A8
    ld a, [wC590]
    ld l, a
    ld a, [wC591]
    ld h, a
    ldh a, [rSB]
    ld [hl], a
    call Func_000_0A8D
    ld a, [wC590]
    add a, $01
    ld [wC590], a
    ld a, [wC591]
    adc a, $00
    ld [wC591], a
    ld a, [wC592]
    sub a, $01
    ld [wC592], a
    ld a, [wC593]
    sbc a, $00
    ld [wC593], a
    xor a, a
    ld [wC582], a
    ret

Jump_01B_47A8::
    ld a, [wC586]
    ld [wC58F], a
    call Func_000_0A8D
    xor a, a
    ld [wC582], a
    ret

Jump_01B_47B6::
    ld hl, wC5ED
    bit 2, [hl]
    jp nz, Jump_01B_4676
    set 1, [hl]
    xor a, a
    ld [wC582], a
    ld a, $FA
    call Func_000_08BA
    ret

Func_01B_47CA::
    ld a, [wC52B]
    or a, a
    jr z, Jump_01B_47D3
    call Func_000_2620

Jump_01B_47D3::
    call Func_000_0F4E
    ld a, [wC5F0]
    add a, $01
    ld [wC5F0], a
    ld a, [wC5F1]
    adc a, $00
    ld [wC5F1], a
    xor a, a
    ld [wC58D], a
    ld [wC58E], a
    ret

Func_01B_47EE:: ; heuristic: follows a terminator; C0
    ldh a, [rSC]
    bit 7, a
    jr nz, Jump_01B_47F5
    ret

Jump_01B_47F5::
    ld a, [wD783]
    add a, $01
    ld [wD783], a
    ld a, [wD784]
    adc a, $00
    ld [wD784], a
    cp a, $04
    jr c, Func_01B_47EE
    ld a, $FE
    ret

Func_01B_480C::
    ld de, Data_01B_4821
    call Func_000_25C9
    ret
    db $11, $21, $48, $CD, $FE, $25, $C9

Func_01B_481A::
    call Func_01B_480C
    call Func_000_2611
    ret

Data_01B_4821:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01B_4823

Data_01B_4823:: ; heuristic: target of a monotone pointer table; C0
    dw Data_01B_4873
    dw Data_01B_4873
    dw Data_01B_4889
    dw Data_01B_48A6
    dw Data_01B_48C8
    dw Data_01B_48E4
    dw Data_01B_4900
    dw Data_01B_4920
    dw Data_01B_492D
    dw Data_01B_494C
    dw Data_01B_4964
    dw Data_01B_4984
    dw Data_01B_49A1
    dw Data_01B_49BB
    dw Data_01B_49E1
    dw Data_01B_49EB
    dw Data_01B_4A09
    dw Data_01B_4A09
    dw Data_01B_4A2B
    dw Data_01B_4A41
    dw Data_01B_4A64
    dw Data_01B_4A7D
    dw Data_01B_4ABA
    dw Data_01B_4AD9
    dw Data_01B_4AEF
    dw Data_01B_4AFD
    dw Data_01B_4B0E
    dw Data_01B_4B25
    dw Data_01B_4B41
    dw Data_01B_4B4E
    dw Data_01B_4B4E
    dw Data_01B_4B59
    dw Data_01B_4B69
    dw Data_01B_4B75
    dw Data_01B_4BB4
    dw Data_01B_4BD2
    dw Data_01B_4C17
    dw Data_01B_4C3A
    dw Data_01B_4C4D
    dw Data_01B_4C83

Data_01B_4873:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $37, $2C, $31, $2A, $90, $2E, $28, $3C, $F1, $37, $35, $24
    db $27, $28, $A4, $FA, $F7, $F0

Data_01B_4889:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $35, $28, $29, $38, $36, $28, $27, $90, $37, $32, $F1, $37
    db $35, $24, $27, $28, $90, $2E, $28, $3C, $36, $B5, $FA, $F7, $F0

Data_01B_48A6:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $35, $28, $29, $38, $36, $28, $27
    db $F1, $37, $32, $90, $37, $35, $24, $27, $28, $90, $2E, $28, $3C, $36, $B5, $FA
    db $F7, $F0

Data_01B_48C8:: ; heuristic: target of a monotone pointer table; C0
    db $12, $36, $90, $2C, $37, $90, $18, $14, $90, $37, $32, $90, $37, $35, $24, $27
    db $28, $F1, $37, $2B, $2C, $36, $90, $2E, $28, $3C, $98, $F0

Data_01B_48E4:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $24, $37, $90, $2E, $28, $3C, $90, $26, $24, $31, $31, $32, $37, $90
    db $25, $28, $F1, $37, $35, $24, $27, $28, $27, $B5, $F7, $F0

Data_01B_4900:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $28, $24, $36, $28, $90, $26, $2B, $32, $32, $36, $28, $90, $37, $2B
    db $28, $F1, $2E, $28, $3C, $90, $37, $32, $90, $37, $35, $24, $27, $28, $B5, $F0

Data_01B_4920:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_01B_492D:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $36, $90, $26, $24, $31, $41, $90, $2B, $24, $39, $28, $F1, $37
    db $2B, $28, $90, $36, $24, $30, $28, $90, $31, $24, $30, $28, $B5, $F7, $F0

Data_01B_494C:: ; heuristic: target of a monotone pointer table; C0
    db $12, $36, $90, $2C, $37, $90, $18, $14, $90, $37, $32, $90, $37, $35, $24, $27
    db $28, $F1, $2E, $28, $3C, $36, $98, $F0

Data_01B_4964:: ; heuristic: target of a monotone pointer table; C0
    db $12, $36, $90, $2C, $37, $90, $18, $14, $90, $37, $32, $90, $35, $28, $26, $32
    db $35, $27, $F1, $37, $2B, $28, $90, $35, $28, $36, $38, $2F, $37, $36, $98, $F0

Data_01B_4984:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $24, $27, $3C, $2C, $31, $2A, $90, $37, $35, $24, $27, $28, $A4, $F1
    db $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_01B_49A1:: ; heuristic: target of a monotone pointer table; C0
    db $14, $28, $3C, $36, $90, $3A, $2C, $2F, $2F, $90, $31, $32, $3A, $90, $25, $28
    db $F1, $37, $35, $24, $27, $28, $27, $B5, $F7, $F0

Data_01B_49BB:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $2B, $24, $36, $90, $24, $90, $2E
    db $28, $3C, $F1, $32, $29, $90, $37, $2B, $28, $90, $36, $24, $30, $28, $90, $31
    db $24, $30, $28, $B5, $F7, $F0

Data_01B_49E1:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $35, $24, $27, $28, $0E, $3B, $2C, $37, $F0

Data_01B_49EB:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $26, $24, $31, $41, $90, $2B, $32, $2F, $27, $90, $24, $31
    db $3C, $F1, $30, $32, $35, $28, $90, $2E, $28, $3C, $36, $B5, $F7, $F0

Data_01B_4A09:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $37, $2B, $28, $90, $30, $28, $30, $25, $28
    db $35, $36, $F1, $29, $32, $35, $90, $1F, $1C, $90, $25, $24, $37, $37, $2F, $28
    db $B5, $F0

Data_01B_4A2B:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2C, $26, $2E, $90, $F9, $00, $90, $29, $32, $35, $90, $37, $2B, $28, $F1
    db $37, $28, $24, $30, $98, $F0

Data_01B_4A41:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $32, $32, $36, $28, $90, $32, $31, $28, $90, $30, $32, $35, $28, $F1
    db $30, $28, $30, $25, $28, $35, $90, $29, $32, $35, $90, $25, $24, $37, $37, $2F
    db $28, $98, $F0

Data_01B_4A64:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $33, $38, $37, $90, $38, $33, $90
    db $24, $F1, $33, $35, $2C, $3D, $28, $98, $F0

Data_01B_4A7D:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $2B, $24, $39, $28, $90, $31, $32, $F1, $30, $32, $31, $36
    db $37, $28, $35, $36, $90, $32, $31, $90, $37, $2B, $28, $FA, $F7, $EF, $EE, $29
    db $24, $35, $30, $90, $37, $32, $90, $36, $28, $35, $39, $28, $90, $24, $36, $EF
    db $EE, $37, $2B, $28, $90, $33, $35, $2C, $3D, $28, $B5, $F7, $F0

Data_01B_4ABA:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $28, $2F, $28, $26, $37, $90, $24, $90, $30, $32, $31, $36, $37, $28, $35
    db $F1, $24, $36, $90, $37, $2B, $28, $90, $33, $35, $2C, $3D, $28, $B5, $F0

Data_01B_4AD9:: ; heuristic: target of a monotone pointer table; C0
    db $19, $38, $37, $90, $38, $33, $90, $F9, $00, $90, $24, $36, $90, $24, $F1, $33
    db $35, $2C, $3D, $28, $98, $F0

Data_01B_4AEF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $2A, $2C, $31, $90, $25, $24, $37, $37, $2F, $28, $98, $F0

Data_01B_4AFD:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $37, $2C, $31, $2A, $90, $25, $24, $37, $37, $2F, $28, $A4
    db $F0

Data_01B_4B0E:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $90, $35, $28, $29, $38, $36, $28, $27, $90, $37, $32, $F1, $25
    db $24, $37, $37, $2F, $28, $B5, $F0

Data_01B_4B25:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $90, $35, $28, $29, $38, $36, $28, $27
    db $F1, $37, $32, $90, $25, $24, $37, $37, $2F, $28, $B5, $F0

Data_01B_4B41:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $28, $24, $36, $28, $90, $3A, $24, $2C, $37, $B5, $F0

Data_01B_4B4E:: ; heuristic: target of a monotone pointer table; C0
    db $12, $31, $29, $32, $18, $14, $22, $28, $36, $17, $F0

Data_01B_4B59:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $37, $37, $2F, $28, $19, $35, $2C, $3D, $28, $0E, $3B, $2C, $37, $F0

Data_01B_4B69:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $2A, $2B, $37, $12, $31, $29, $32, $0E, $3B, $F0

Data_01B_4B75:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $31, $36, $37, $28, $35, $90, $2F, $28, $39, $28, $2F, $F1, $2F, $2C
    db $30, $2C, $37, $90, $28, $3B, $26, $28, $28, $27, $28, $27, $B5, $FA, $F7, $EF
    db $EE, $19, $2C, $26, $2E, $90, $24, $31, $32, $37, $2B, $28, $35, $EF, $EE, $30
    db $32, $31, $36, $37, $28, $35, $90, $33, $2F, $28, $24, $36, $28, $B5, $F0

Data_01B_4BB4:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $24, $37, $90, $29, $24, $30, $2C, $2F, $3C, $90, $2C, $36, $90, $31
    db $32, $37, $F1, $33, $28, $35, $30, $2C, $37, $37, $28, $27, $B5, $F0

Data_01B_4BD2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $06CBD2, $45

Data_01B_4C17:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32, $90, $33, $35, $2C, $3D
    db $28, $F1, $29, $32, $35, $90, $37, $2B, $2C, $36, $90, $25, $24, $37, $37, $2F
    db $28, $B5, $F0

Data_01B_4C3A:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $28, $35, $28, $90, $2C, $36, $90, $31, $32, $90, $33, $35, $2C, $3D
    db $28, $B5, $F0

Data_01B_4C4D:: ; heuristic: target of a monotone pointer table; C0
    db $22, $32, $38, $35, $90, $33, $24, $2F, $3E, $90, $2E, $28, $3C, $90, $35, $2C
    db $31, $2A, $F1, $2C, $36, $90, $29, $38, $2F, $2F, $B5, $FA, $F7, $EF, $EE, $14
    db $28, $3C, $36, $90, $26, $24, $31, $41, $90, $25, $28, $EF, $EE, $37, $35, $24
    db $27, $28, $27, $B5, $F7, $F0

Data_01B_4C83:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $F0

Func_01B_4C86::
    ld de, Data_01B_4C9B
    call Func_000_25C9
    ret
    db $11, $9B, $4C, $CD, $FE, $25, $C9

Func_01B_4C94::
    call Func_01B_4C86
    call Func_000_2611
    ret

Data_01B_4C9B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01B_4C9D

Data_01B_4C9D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_01B_4CF1
    dw Data_01B_4CF1
    dw Data_01B_4D12
    dw Data_01B_4D35
    dw Data_01B_4D52
    dw Data_01B_4D6D
    dw Data_01B_4D93
    dw Data_01B_4DB8
    dw Data_01B_4DD6
    dw Data_01B_4DF4
    dw Data_01B_4E17
    dw Data_01B_4E39
    dw Data_01B_4E5B
    dw Data_01B_4E7D
    dw Data_01B_4E9E
    dw Data_01B_4EB9
    dw Data_01B_4EF2
    dw Data_01B_4F13
    dw Data_01B_4F33
    dw Data_01B_4F71
    dw Data_01B_4F93
    dw Data_01B_4FB1
    dw Data_01B_4FD2
    dw Data_01B_4FF5
    dw Data_01B_5018
    dw Data_01B_5039
    dw Data_01B_5056
    dw Data_01B_5073
    dw Data_01B_508E
    dw Data_01B_50B0
    dw Data_01B_50CF
    dw Data_01B_50EA
    dw Data_01B_50EA
    dw Data_01B_5105
    dw Data_01B_5125
    dw Data_01B_5125
    dw Data_01B_5125
    dw Data_01B_5132
    dw Data_01B_5143
    dw Data_01B_515A
    dw Data_01B_517A
    dw Data_01B_5190

Data_01B_4CF1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $B5, $90, $20, $2B, $24, $37
    db $F1, $3A, $32, $38, $2F, $27, $90, $3C, $32, $38, $90, $2F, $2C, $2E, $28, $98
    db $F0

Data_01B_4D12:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $3A, $2C, $2F, $2F, $90, $25, $28
    db $F1, $37, $2B, $28, $90, $25, $24, $36, $28, $90, $30, $32, $31, $36, $37, $28
    db $35, $98, $F0

Data_01B_4D35:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $2C, $36, $90, $2C, $36, $90, $37, $2B, $28, $90, $32
    db $31, $28, $F1, $3C, $32, $38, $90, $3A, $24, $31, $37, $98, $F0

Data_01B_4D52:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $28, $35, $28, $F1, $24, $31, $3C, $37
    db $2B, $2C, $31, $2A, $90, $28, $2F, $36, $28, $98, $F0

Data_01B_4D6D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $3A, $32, $31, $41, $90, $2B, $24, $39, $28
    db $90, $24, $F1, $30, $32, $31, $36, $37, $28, $35, $90, $3A, $2C, $37, $2B, $90
    db $3C, $32, $38, $99, $F7, $F0

Data_01B_4D93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $3E, $90, $37, $32, $32, $90, $2F, $32, $3A
    db $F1, $2C, $31, $90, $2F, $28, $39, $28, $2F, $90, $37, $32, $90, $25, $35, $28
    db $28, $27, $B5, $F7, $F0

Data_01B_4DB8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $31, $27, $90, $3A, $2B, $24, $37, $90, $3A, $2C, $2F, $2F
    db $F1, $2C, $37, $36, $90, $30, $24, $37, $28, $90, $25, $28, $98, $F0

Data_01B_4DD6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $35, $28, $3E, $90, $31, $32, $F1, $33, $32, $37
    db $28, $31, $37, $2C, $24, $2F, $90, $30, $24, $37, $28, $B5, $F7, $F0

Data_01B_4DF4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $F1, $3A, $2C, $2F, $2F, $90, $35, $28, $36, $38, $2F
    db $37, $90, $29, $35, $32, $30, $FA, $F7, $EF, $EE, $37, $2B, $2C, $36, $B5, $EF
    db $EE, $F7, $F0

Data_01B_4E17:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $90, $2A, $35, $28, $24, $37, $90, $30, $32, $31, $36, $37
    db $28, $35, $F1, $3A, $2C, $2F, $2F, $90, $25, $28, $90, $25, $32, $35, $31, $99
    db $F7, $F0

Data_01B_4E39:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $24, $2F, $35, $28, $24, $27, $3C, $90, $2B
    db $24, $27, $F1, $37, $2B, $24, $37, $90, $30, $32, $31, $36, $37, $28, $35, $B5
    db $F7, $F0

Data_01B_4E5B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $42, $28, $90, $31, $28, $39, $28, $35, $90, $2B
    db $24, $27, $F1, $37, $2B, $24, $37, $90, $30, $32, $31, $36, $37, $28, $35, $B5
    db $F7, $F0

Data_01B_4E7D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $18, $14, $90, $37, $32, $90, $35, $28, $26, $32, $35, $27, $90
    db $2C, $31, $F1, $3C, $32, $38, $35, $90, $13, $32, $38, $35, $31, $24, $2F, $98
    db $F0

Data_01B_4E9E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $2C, $31, $28, $AB, $90, $29, $2C, $31, $28, $99, $F1, $12
    db $43, $2F, $90, $27, $32, $90, $2C, $37, $99, $F7, $F0

Data_01B_4EB9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $37, $26, $2B, $2C, $31, $2A, $90, $37, $2B, $24, $37
    db $F1, $3A, $2C, $2F, $2F, $90, $26, $32, $36, $37, $90, $F9, $00, $10, $B5, $FA
    db $F7, $F2, $1C, $2B, $32, $38, $2F, $27, $90, $12, $90, $2B, $24, $37, $26, $2B
    db $90, $2C, $37, $F1, $37, $32, $32, $98, $F0

Data_01B_4EF2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $2B, $24, $37, $26, $2B, $90, $37, $2B, $28
    db $F1, $28, $2A, $2A, $90, $37, $32, $32, $AB, $90, $37, $2B, $28, $31, $B5, $F7
    db $F0

Data_01B_4F13:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $3A, $32, $31, $41, $90, $2B, $24, $37, $26, $2B, $F1
    db $37, $2B, $28, $90, $28, $2A, $2A, $AB, $90, $37, $2B, $28, $31, $B5, $F7, $F0

Data_01B_4F33:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $27, $32, $31, $41, $90, $2B, $24, $39, $28
    db $F1, $28, $31, $32, $38, $2A, $2B, $90, $2A, $32, $2F, $27, $AB, $90, $36, $32
    db $FA, $F7, $F2, $12, $43, $2F, $90, $2D, $38, $36, $37, $90, $27, $32, $90, $37
    db $2B, $28, $F1, $25, $35, $28, $28, $27, $2C, $31, $2A, $B5, $F7, $F0

Data_01B_4F71:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $36, $28, $31, $27, $90, $37, $2B, $28, $F1
    db $28, $2A, $2A, $90, $37, $32, $90, $37, $2B, $28, $90, $29, $24, $35, $30, $B5
    db $F7, $F0

Data_01B_4F93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2C, $2F, $2F, $90, $3C, $32, $38, $90, $37, $24, $2E, $28
    db $F1, $F9, $00, $90, $3A, $2C, $37, $2B, $90, $3C, $32, $38, $98, $F0

Data_01B_4FB1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1B, $24, $2C, $36, $28, $90, $2C, $37, $90, $3A, $2C, $37, $2B
    db $F1, $2F, $32, $39, $28, $90, $24, $31, $27, $90, $26, $24, $35, $28, $99, $F7
    db $F0

Data_01B_4FD2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $36, $28, $31, $27, $90, $F9, $00, $F1, $37
    db $32, $90, $37, $2B, $28, $90, $29, $24, $35, $30, $AB, $90, $37, $2B, $28, $31
    db $B5, $F7, $F0

Data_01B_4FF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $3A, $2C, $2F, $2F, $90, $2A, $32
    db $F1, $25, $24, $26, $2E, $90, $37, $32, $90, $37, $2B, $28, $90, $29, $24, $35
    db $30, $98, $F0

Data_01B_5018:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $36, $90, $37, $2B, $2C, $36, $90, $37, $2B, $28, $90, $32
    db $31, $28, $F1, $37, $32, $90, $36, $28, $31, $27, $90, $2B, $32, $30, $28, $98
    db $F0

Data_01B_5039:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $F9, $00, $90, $2C, $36, $F1, $2A, $32, $2C, $31, $2A, $90, $37
    db $32, $90, $37, $2B, $28, $90, $29, $24, $35, $30, $B5, $F7, $F0

Data_01B_5056:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $28, $2A, $2A, $90, $36, $2B, $32
    db $38, $2F, $27, $F1, $12, $90, $2B, $24, $37, $26, $2B, $98, $F0

Data_01B_5073:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $90, $3A, $2C, $2F, $2F, $90, $26, $32, $36
    db $37, $F1, $F9, $00, $10, $B5, $90, $18, $14, $98, $F0

Data_01B_508E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $28, $35, $28, $90, $2C, $36, $31, $41, $90, $24, $F1
    db $36, $2C, $31, $2A, $2F, $28, $90, $28, $2A, $2A, $90, $2B, $28, $35, $28, $B5
    db $F7, $F0

Data_01B_50B0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $27, $32, $31, $41, $90, $2B, $24, $39, $28
    db $F1, $28, $31, $32, $38, $2A, $2B, $90, $2A, $32, $2F, $27, $B5, $F7, $F0

Data_01B_50CF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $2A, $32, $37, $90, $37, $2B, $28, $90, $28
    db $2A, $2A, $F1, $32, $29, $90, $F9, $00, $B5, $F7, $F0

Data_01B_50EA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0B, $28, $26, $32, $30, $28, $90, $24, $90, $2A, $35, $28, $24
    db $37, $F1, $30, $24, $36, $37, $28, $35, $99, $F7, $F0

Data_01B_5105:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $2C, $31, $28, $AB, $90, $29, $2C, $31, $28, $B5, $F1, $13
    db $38, $36, $37, $90, $3A, $24, $2C, $37, $90, $2B, $28, $35, $28, $B5, $F7, $F0

Data_01B_5125:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $2B, $24, $37, $26, $2B, $28, $27, $99, $F7, $F0

Data_01B_5132:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $28, $24, $36, $28, $90, $31, $24, $30, $28, $90, $2C, $37, $B5, $F7
    db $F0

Data_01B_5143:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $90, $3A, $28, $31, $37, $F1, $24, $3A, $24, $3C, $90, $34, $38, $2C
    db $28, $37, $2F, $3C, $A4, $F7, $F0

Data_01B_515A:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $0E, $1C, $1E, $15, $1D, $1C, $F1, $0D, $12, $1C, $19, $15, $0A, $22, $F1
    db $F1, $1C, $33, $28, $26, $2C, $28, $36, $F1, $10, $28, $31, $27, $28, $35, $F0

Data_01B_517A:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $31, $38, $36, $28, $27, $B5, $F0, $17, $32, $90, $36, $24, $39, $28, $90
    db $27, $24, $37, $24, $B5, $F0

Data_01B_5190:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $06D190, $21F

Func_01B_53AF::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld de, Data_01B_53C6
    ld hl, wC49F
    ld bc, $0008
    call Func_000_1679
    ld a, $7F
    ld [wC526], a
    ret

Data_01B_53C6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $5E, $FF, $7F, $F2, $66, $00, $00

Func_01B_53CE::
    ld a, [wC56C]
    and a, a
    ret nz
    ld a, [wD780]
    rst $00
    dw Jump_01B_53DB
    dw Jump_01B_547D

Jump_01B_53DB::
    ld a, [wD781]
    rst $00
    dw Jump_01B_53E9
    dw Jump_01B_5429
    dw Jump_01B_543E
    dw Jump_01B_5450
    dw Jump_01B_5462

Jump_01B_53E9::
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_01B_62EC
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01B_5407
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_01B_62F5

Jump_01B_5407::
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4330
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5429::
    ld a, $01
    call Func_01B_61F5
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC594], a
    ld hl, wD06A
    inc [hl]
    ret

Jump_01B_543E::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $07
    call Func_01B_61F5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5450::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wC594], a
    ret

Jump_01B_5462::
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld a, $06
    call Func_01B_61F5
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_01B_547D::
    ld a, [wD781]
    rst $00
    dw Jump_01B_54CB
    dw Jump_01B_5538
    dw Jump_01B_5588
    dw Jump_01B_55F3
    dw Jump_01B_5611
    dw Jump_01B_5630
    dw Jump_01B_56B7
    dw Jump_01B_574E
    dw Jump_01B_577C
    dw Jump_01B_57E6
    dw Jump_01B_57F6
    dw Jump_01B_5809
    dw Jump_01B_58E6
    dw Jump_01B_5910
    dw Jump_01B_5931
    dw Jump_01B_5995
    dw Jump_01B_59AB
    dw Jump_01B_5A83
    dw Jump_01B_5B3E
    dw Jump_01B_5B7E
    dw Jump_01B_5BAC
    dw Jump_01B_574E
    dw Jump_01B_5C64
    dw Jump_01B_5CD3
    dw Jump_01B_5CFE
    dw Jump_01B_58E6
    dw Jump_01B_5910
    dw Jump_01B_5D0B
    dw Jump_01B_58F8
    dw Jump_01B_5D18
    dw Jump_01B_5D8B
    dw Jump_01B_5DCF
    dw Jump_01B_5DE7
    dw Jump_01B_5E41
    dw Jump_01B_5F88
    dw Jump_01B_5983
    dw Jump_01B_5FAA

Jump_01B_54CB::
    ld a, [wC52B]
    and a, a
    ret nz
    ld de, Data_01B_6483
    ld hl, wC3B4
    ld bc, $0F09
    call Func_01B_6232
    ld hl, Func_00D_60C3
    ld b, $0D
    rst $10
    ld a, $0E
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, vTiles2 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0801
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, Func_01B_481A
    ld b, $1B
    rst $10
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5538::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1004
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld hl, vTiles2 + $600
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5588::
    ld de, Data_01B_650A
    ld hl, wC3C9
    ld bc, $0D07
    call Func_01B_6232
    ld a, $02
    ld [wD7F5], a
    ld hl, Func_00D_5C87
    ld b, $0D
    rst $10
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01B_55D4
    ld de, $0189
    call Func_01B_632C
    ld hl, wC45D
    call Func_01B_634F
    ld de, $018A
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld hl, Func_01E_7564
    ld b, $1E
    rst $10
    ld hl, wC45E
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    ld hl, Func_01E_759A
    ld b, $1E
    rst $10

Jump_01B_55D4::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_01B_65DD
    call Func_01B_6308
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_55F3::
    ld a, $02
    ld [wD7F5], a
    ld hl, Func_00D_5DED
    ld b, $0D
    rst $10
    ld a, $01
    ld [wD7F5], a
    ld hl, Func_00D_5D26
    ld b, $0D
    rst $10
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5611::
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_01B_65DD
    call Func_01B_6308
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5630::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_5644
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $FD
    ld [wC594], a
    ret

Jump_01B_5644::
    ld a, [wC563]
    bit 2, a
    jr nz, Jump_01B_566C
    ld a, $05
    ld [wD7F9], a
    ld hl, Func_01D_66B6
    ld b, $1D
    rst $10
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01B_5672
    cp a, $FC
    jr z, Jump_01B_5672
    cp a, $FE
    jr z, Jump_01B_567B
    cp a, $FF
    jr z, Jump_01B_5688
    ret

Jump_01B_566C::
    ld hl, Func_0F2_6333
    ld b, $F2
    rst $10

Jump_01B_5672::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01B_567B::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_5688::
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_65DD
    call Func_01B_6308
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $04
    call Func_01B_61F5
    ret

Jump_01B_56B7::
    ld a, [wD782]
    rst $00
    dw Jump_01B_56C5
    dw Jump_01B_56F5
    dw Jump_01B_5707
    dw Jump_01B_5719
    dw Jump_01B_572B

Jump_01B_56C5::
    ld a, [wC58F]
    cp a, $FD
    jr z, Jump_01B_56E3
    cp a, $FE
    ret nz
    ld a, [wC594]
    cp a, $FD
    jr z, Jump_01B_56DF
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_01B_56DF
    jr Jump_01B_56E3

Jump_01B_56DF::
    ld b, $03
    jr Jump_01B_56E5

Jump_01B_56E3::
    ld b, $02

Jump_01B_56E5::
    xor a, a
    ld [wC594], a
    ld a, b
    call Func_01B_61F5
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_56F5::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $07
    call Func_01B_61F5
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5707::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5719::
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_572B::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld hl, wD780
    ld bc, $006F

Jump_01B_5737::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_5737
    ld a, $05
    ld [wC5DB], a
    ld a, $01
    ld [wC5DC], a
    ld a, $01
    ld [wC5DF], a
    ret

Jump_01B_574E::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $6C
    call Func_000_1278
    ld de, Data_01B_65E9
    ld hl, wC412
    ld bc, $0605
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_577C::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_578E
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wC594], a
    ret

Jump_01B_578E::
    ld hl, Func_01D_6540
    ld b, $1D
    rst $10
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_57A2
    cp a, $FF
    jr z, Jump_01B_57C0
    ret

Jump_01B_57A2::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Jump_01B_57C0::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_01B_57A2
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Jump_01B_57E6::
    call Func_01B_6203
    ld a, $06
    call Func_01B_61F5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_57F6::
    ld a, [wC52B]
    and a, a
    ret nz
    ld c, $04
    ld hl, Data_01B_65DD
    call Func_01B_6318
    ld a, $05
    ld [wD781], a
    ret

Jump_01B_5809::
    ld a, [wD782]
    rst $00
    dw Jump_01B_5823
    dw Jump_01B_5811

Jump_01B_5811::
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    sub a, $02
    ld [wD781], a
    ret

Jump_01B_5823::
    call Func_01B_6153
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5850
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $0F
    cp a, $07
    jr nc, Jump_01B_5847
    pop hl

Jump_01B_583A::
    ld a, $05
    call Func_01B_61F5
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5847::
    pop hl
    ldh a, [hFF90]
    cp a, $A8
    jr c, Jump_01B_5864
    jr Jump_01B_5871

Jump_01B_5850::
    pop hl
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_01B_5864
    ld a, [wCC42]
    ld b, a
    ld a, [hl]
    and a, $3F
    cp a, b
    jr nz, Jump_01B_5864
    jr Jump_01B_583A

Jump_01B_5864::
    ld a, $07
    call Func_01B_61F5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5871::
    ld b, $A8
    ld c, $B0
    cp a, c
    jr nc, Jump_01B_587A
    cp a, b
    ccf

Jump_01B_587A::
    jr c, Jump_01B_58B6
    ld b, $B0
    ld c, $B7
    cp a, c
    jr nc, Jump_01B_5885
    cp a, b
    ccf

Jump_01B_5885::
    jr c, Jump_01B_58BE
    ld b, $B8
    ld c, $C6
    cp a, c
    jr nc, Jump_01B_5890
    cp a, b
    ccf

Jump_01B_5890::
    jr c, Jump_01B_58C6
    ld b, $C8
    ld c, $D1
    cp a, c
    jr nc, Jump_01B_589B
    cp a, b
    ccf

Jump_01B_589B::
    jr c, Jump_01B_58CE
    ld b, $D1
    ld c, $DA
    cp a, c
    jr nc, Jump_01B_58A6
    cp a, b
    ccf

Jump_01B_58A6::
    jr c, Jump_01B_58D6
    ld b, $DA
    ld c, $E3
    cp a, c
    jr nc, Jump_01B_58B1
    cp a, b
    ccf

Jump_01B_58B1::
    jr c, Jump_01B_58DE
    jp Jump_01B_5864

Jump_01B_58B6::
    ld a, [hl]
    cp a, $07
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58BE::
    ld a, [hl]
    cp a, $08
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58C6::
    ld a, [hl]
    cp a, $09
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58CE::
    ld a, [hl]
    cp a, $0A
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58D6::
    ld a, [hl]
    cp a, $0B
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58DE::
    ld a, [hl]
    cp a, $0C
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58E6::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wC594], a
    ret

Jump_01B_58F8::
    ld a, [wC52B]
    and a, a
    ret nz
    ld de, Data_01B_6607
    call Func_01B_618C
    ld a, $02
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5910::
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_01B_5925
    cp a, $FE
    ret nz
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wC594], a
    ret

Jump_01B_5925::
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5931::
    ld a, [wD781]
    inc a
    ld [wD781], a
    call Func_01B_6153
    ld de, wC597
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    push de
    call Func_01B_6170
    pop de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld hl, $0006
    ld a, l
    ld [wC592], a
    ld a, h
    ld [wC593], a
    ld hl, wC707
    ld hl, wC597
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wC5B7
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_01B_5983::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $05
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5995::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_59AB::
    call Func_01B_59E8
    cp a, $FF
    jr z, Jump_01B_59D7
    call Func_01B_5A41
    ld a, c
    cp a, $14
    jr z, Jump_01B_59C6
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7B4], a
    ret

Jump_01B_59C6::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $FE
    ld [wD7B4], a
    ret

Jump_01B_59D7::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $FF
    ld [wD7B4], a
    ret

Func_01B_59E8::
    ld hl, wC707
    ld de, wC5B7
    ld b, $20

Jump_01B_59F0::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_5A33
    cp a, $FE
    jr z, Jump_01B_5A33
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5A19
    pop hl
    push hl
    ld a, [wC5BA]
    bit 7, a
    jr z, Jump_01B_5A33
    ld a, [hl]
    and a, $0F
    ld c, a
    ld a, [wC5B7]
    and a, $0F
    cp a, c
    jr nz, Jump_01B_5A33
    jr Jump_01B_5A3D

Jump_01B_5A19::
    pop hl
    push hl
    ld a, [wC5BA]
    bit 7, a
    jr nz, Jump_01B_5A33
    inc hl
    ld a, [hl+]
    ld c, a
    ld a, [wC5B8]
    cp a, c
    jr nz, Jump_01B_5A33
    ld a, [hl+]
    ld c, a
    ld a, [wC5B9]
    cp a, c
    jr nz, Jump_01B_5A33

Jump_01B_5A33::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_01B_59F0
    xor a, a
    ret

Jump_01B_5A3D::
    pop hl
    ld a, $FF
    ret

Func_01B_5A41::
    ld hl, wC707
    ld b, $20
    ld c, $00

Jump_01B_5A48::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_5A5C
    cp a, $FE
    jr z, Jump_01B_5A5B
    inc hl
    inc hl
    inc hl
    ld a, [hl-]
    dec hl
    dec hl
    bit 7, a
    jr nz, Jump_01B_5A5C

Jump_01B_5A5B::
    inc c

Jump_01B_5A5C::
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_01B_5A48
    ld a, c
    cp a, $14
    ret c
    call Func_01B_6153
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_01B_5A7B
    ld a, [wC5BA]
    bit 7, a
    jr nz, Jump_01B_5A79

Jump_01B_5A79::
    dec c
    ret

Jump_01B_5A7B::
    ld a, [wC5BA]
    bit 7, a
    jr nz, Jump_01B_5A79
    ret

Jump_01B_5A83::
    ld a, [wD782]
    rst $00
    dw Jump_01B_5A91
    dw Jump_01B_5AB0
    dw Jump_01B_5ACF
    dw Jump_01B_5B1F
    dw Jump_01B_5B2C

Jump_01B_5A91::
    ld a, [wD7B4]
    and a, a
    jr z, Jump_01B_5AA3
    cp a, $FF
    jr z, Jump_01B_5A9F
    ld a, $04
    jr Jump_01B_5AA5

Jump_01B_5A9F::
    ld a, $03
    jr Jump_01B_5AA5

Jump_01B_5AA3::
    ld a, $02

Jump_01B_5AA5::
    ld [wC594], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5AB0::
    ld a, [wC58F]
    cp a, $02
    jr z, Jump_01B_5AC0
    cp a, $03
    jr z, Jump_01B_5AC0
    cp a, $04
    jr z, Jump_01B_5AC0
    ret

Jump_01B_5AC0::
    ld [wD7B5], a
    xor a, a
    ld [wC594], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5ACF::
    ld a, [wD7B5]
    cp a, $03
    jr z, Jump_01B_5B07
    cp a, $04
    jr z, Jump_01B_5AF8
    ld a, [wD7B4]
    and a, a
    jr nz, Jump_01B_5AEC
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5AEC::
    cp a, $FF
    jr z, Jump_01B_5AF4
    ld a, $0F
    jr Jump_01B_5B14

Jump_01B_5AF4::
    ld a, $08
    jr Jump_01B_5B14

Jump_01B_5AF8::
    ld a, [wD7B4]
    cp a, $FE
    jr z, Jump_01B_5B03
    ld a, $26
    jr Jump_01B_5B14

Jump_01B_5B03::
    ld a, $0F
    jr Jump_01B_5B14

Jump_01B_5B07::
    ld a, [wD7B4]
    cp a, $FF
    jr z, Jump_01B_5B12
    ld a, $0D
    jr Jump_01B_5B14

Jump_01B_5B12::
    ld a, $08

Jump_01B_5B14::
    call Func_01B_61F5
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5B1F::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5B2C::
    call Func_01B_6203
    ld a, $06
    call Func_01B_61F5
    xor a, a
    ld [wD782], a
    ld a, $0A
    ld [wD781], a
    ret

Jump_01B_5B3E::
    call Func_01B_5FF2
    ld de, Data_01B_6483
    ld hl, wC364
    ld bc, $0F01
    call Func_01B_6232
    ld de, Data_01B_65CE
    ld hl, wC378
    ld bc, $0F01
    call Func_01B_6232
    ld de, Data_01B_64FB
    ld hl, wC38C
    ld bc, $0F01
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $09
    call Func_01B_61F5
    ret

Jump_01B_5B7E::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $6C
    call Func_000_1278
    ld de, Data_01B_65A6
    ld hl, wC410
    ld bc, $0805
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5BAC::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_5BD4
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wC594], a
    ret

Jump_01B_5BD4::
    call Func_01B_63CB
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_5BE5
    cp a, $FF
    jr z, Jump_01B_5C06
    ret

Jump_01B_5BE5::
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $06
    ld [wD781], a
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_5C06::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_01B_5BE5
    ld a, [wD7FA]
    ld b, $BC
    ld hl, Data_01B_65E5
    call Func_01B_6308
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $0A
    call Func_01B_61F5
    ret

Func_01B_5C3B:: ; heuristic: follows a terminator; C0
    ld a, [wC52B]
    and a, a
    ret nz
    ld de, Data_01B_65E9
    ld hl, wC412
    ld bc, $0605
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5C64::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_5C76
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wC594], a
    ret

Jump_01B_5C76::
    ld hl, Func_01D_6540
    ld b, $1D
    rst $10
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_5C8A
    cp a, $FF
    jr z, Jump_01B_5CAD
    ret

Jump_01B_5C8A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $09
    call Func_01B_61F5
    ret

Jump_01B_5CAD::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_01B_5C8A
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Jump_01B_5CD3::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $6C
    call Func_000_1278
    ld de, Data_01B_65A6
    ld hl, wC410
    ld bc, $0805
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ret

Jump_01B_5CFE::
    ld a, $07
    call Func_01B_61F5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5D0B::
    ld a, $0B
    call Func_01B_61F5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5D18::
    ld a, [wC58F]
    cp a, $02
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD783], a
    ld [wD785], a
    call Func_01B_6153
    ld a, [hl]
    cp a, $FE
    jr z, Jump_01B_5D70
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_01B_5D70
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5D70
    and a, $3F
    ld bc, $0195
    call Func_000_16AA
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld de, wD580
    ld bc, $0195
    ld a, $0A
    ld [rRAMG2], a
    ld a, $02
    ld [rRAMB], a
    call Func_000_0952
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    jr Jump_01B_5D7A

Jump_01B_5D70::
    ld hl, wD580
    ld bc, $0195
    xor a, a
    call Func_000_0949

Jump_01B_5D7A::
    ld hl, wD580
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld a, $01
    ld [wC594], a
    ret

Jump_01B_5D8B::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    call Func_01B_61A7
    ld hl, $0195
    ld a, $1E
    call Func_000_16D1
    ld [wD09F], a
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    ld hl, $001E
    ld a, l
    ld [wC592], a
    ld a, h
    ld [wC593], a
    ld hl, wD200
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_01B_5DCF::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wC58C], a
    ld a, $01
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5DE7::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld a, [wD09D]
    ld l, a
    ld a, [wD09E]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_01B_5E07
    dec hl
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    ld hl, $001E
    jr Jump_01B_5E14

Jump_01B_5E07::
    ld a, [wD09F]
    or a, a
    jr z, Jump_01B_5E31
    ld l, a
    ld h, $00
    xor a, a
    ld [wD09F], a

Jump_01B_5E14::
    ld a, l
    ld [wC592], a
    ld a, h
    ld [wC593], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    call Func_01B_61A7
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_01B_5E31::
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58C], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5E41::
    ld de, Data_01B_660A
    call Func_01B_618C
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    call Func_01B_6153
    ld a, [hl]
    cp a, $FE
    jr z, Jump_01B_5E67
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_01B_5E6F
    jr Jump_01B_5E77

Jump_01B_5E67::
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    jr Jump_01B_5E96

Jump_01B_5E6F::
    ld a, $FF
    ld [hl-], a
    ld [hl-], a
    ld [hl-], a
    ld [hl-], a
    jr Jump_01B_5E96

Jump_01B_5E77::
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5E67
    ld hl, Func_01D_5DA1
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ldh [hFFC6], a
    ld hl, Func_012_69B0
    ld b, $12
    rst $10

Jump_01B_5E96::
    ld hl, wC707
    ld c, $00

Jump_01B_5E9B::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_5EB6
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_01B_5EA7
    inc h

Jump_01B_5EA7::
    inc c
    ld a, c
    cp a, $20
    jr c, Jump_01B_5E9B
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_01B_5EB6::
    push bc
    ld a, [wC5BA]
    bit 7, a
    jr z, Jump_01B_5EE7
    ld a, [wC5B7]
    and a, $0F
    sub a, $07
    ld de, $0203
    add a, e
    ld e, a
    jr nc, Jump_01B_5ECD
    inc d

Jump_01B_5ECD::
    push hl
    push bc
    call Func_000_181B
    jr c, Jump_01B_5EDB
    ld a, [wC5B7]
    and a, $0F
    jr Jump_01B_5EE2

Jump_01B_5EDB::
    ld a, [wC5B7]
    set 6, a
    and a, $4F

Jump_01B_5EE2::
    pop bc
    pop hl
    ld [wC5B7], a

Jump_01B_5EE7::
    ld de, wC5B7
    ld b, $04

Jump_01B_5EEC::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01B_5EEC
    pop bc
    push bc
    ld l, c
    ld h, $00
    sla l
    rl h
    ld de, wC787
    add hl, de
    ld a, [wC5BB]
    ld [hl+], a
    ld a, [wC5BC]
    ld [hl], a
    pop bc
    ld a, [wC5B7]
    cp a, $FE
    jr z, Jump_01B_5F7D
    ld a, [wC5BA]
    bit 7, a
    jr nz, Jump_01B_5F7D
    ld a, [wC5B7]
    bit 7, a
    jr z, Jump_01B_5F7D
    push bc
    call Func_01B_5FD4
    ld hl, Func_060_6C61
    ld b, $60
    rst $10
    ldh a, [hFFC6]
    and a, $7F
    ld c, a
    ld a, [wD200]
    and a, $50
    or a, c
    ld [wD200], a
    ld a, $0A
    ld [rRAMG2], a
    ld a, $02
    ld [rRAMB], a
    xor a, a
    ldh [rSVBK], a
    ldh a, [hFFC6]
    and a, $7F
    ld bc, $0195
    call Func_000_16AA
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld e, l
    ld d, h
    ld hl, wD200
    ld bc, $0195
    call Func_000_0952
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    pop bc
    ld a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    and a, $80
    ld b, a
    ldh a, [hFFC6]
    or a, b
    ld [hl], a

Jump_01B_5F7D::
    ld a, $0C
    call Func_01B_61F5
    ld a, $80
    ld [wC836], a
    ret

Jump_01B_5F88::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, Func_002_7333
    ld b, $02
    rst $10
    ld a, [wC8C3]
    bit 7, a
    ret z
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD783], a
    ld a, $07
    call Func_01B_61F5
    ret

Jump_01B_5FAA::
    ld a, [wC58F]
    cp a, $05
    ret nz
    xor a, a
    ld [wC594], a
    ld hl, wD780
    ld bc, $006F

Jump_01B_5FBA::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_5FBA
    xor a, a
    ldh [hDecompressLock], a
    ld a, $05
    ld [wC5DB], a
    ld a, $01
    ld [wC5DC], a
    ld a, $01
    ld [wC5DF], a
    ret

Func_01B_5FD4::
    ld a, [wD201]
    res 7, a
    ld [wD201], a
    ld bc, $0177
    ld hl, wD201
    add hl, bc
    ld b, $04

Jump_01B_5FE5::
    xor a, a
    ld [hl], a
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_01B_5FEE
    inc h

Jump_01B_5FEE::
    dec b
    jr nz, Jump_01B_5FE5
    ret

Func_01B_5FF2::
    ld a, [wC5B7]
    cp a, $FE
    jr nz, Jump_01B_6024
    ld hl, wC8CF
    ld a, $16
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $2A
    ld [hl+], a
    ld a, $2C
    ld [hl+], a
    ld a, $26
    ld [hl+], a
    ld a, $90
    ld [hl+], a
    ld a, $14
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $3C
    ld [hl+], a
    ld a, $5B
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ld a, $03
    ld [wD7F5], a
    jr Jump_01B_606E

Jump_01B_6024::
    ld a, [wC5BA]
    bit 7, a
    jp nz, Jump_01B_60D4
    ld a, $09
    ld [wDataBank], a
    ld a, [wC5B8]
    inc a
    call Func_01B_60BA
    ld hl, wC8CF
    ld de, wC130

Jump_01B_603E::
    ld a, [de]
    cp a, $F0
    jr z, Jump_01B_6047
    ld [hl+], a
    inc de
    jr Jump_01B_603E

Jump_01B_6047::
    push hl
    ld a, $09
    ld [wDataBank], a
    ld a, [wC5B9]
    inc a
    add a, $10
    call Func_01B_60BA
    pop hl
    ld de, wC130

Jump_01B_605A::
    ld a, [de]
    cp a, $F0
    jr z, Jump_01B_6063
    ld [hl+], a
    inc de
    jr Jump_01B_605A

Jump_01B_6063::
    ld a, $5B
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ld a, $03
    ld [wD7F5], a

Jump_01B_606E::
    ld hl, wC130
    ld de, wC8CF

Jump_01B_6074::
    ld a, [de]
    cp a, $F0
    jr z, Jump_01B_607D
    ld [hl+], a
    inc de
    jr Jump_01B_6074

Jump_01B_607D::
    ld [hl], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0B01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $27
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, Func_01B_481A
    ld b, $1B
    rst $10
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Func_01B_60BA::
    sla a
    ld hl, $4078
    add a, l
    ld l, a
    jr nc, Jump_01B_60C4
    inc h

Jump_01B_60C4::
    call Func_000_0B6C
    ld e, b
    ld d, c
    ld hl, wC130
    ld b, $09
    ld c, $10
    call Func_000_0B2B
    ret

Jump_01B_60D4::
    ld a, [wC5B7]
    and a, $3F
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, Data_009_4016
    ld a, $0C
    add a, l
    ld l, a
    jr nc, Jump_01B_60F0
    inc h

Jump_01B_60F0::
    call Func_000_0B6C
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call Func_000_0B6C
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [wDataBank], a
    ld hl, wC8CF
    ld b, $09
    ld c, $10
    call Func_000_0B2B
    ld a, $F0
    ld [wC8DC], a
    ld hl, wC8CF

Jump_01B_611B::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_01B_6122
    jr Jump_01B_611B

Jump_01B_6122::
    jp Jump_01B_6063
    db $21, $A1, $5D, $06, $1D, $D7, $FA, $F5, $D7, $67, $FA, $F6, $D7, $6F, $7E, $6F
    db $26, $00, $29, $29, $7D, $C6, $07, $6F, $7C, $CE, $C7, $67, $7E, $E6, $7F, $01
    db $95, $01, $CD, $AA, $16, $7D, $C6, $00, $6F, $7C, $CE, $A0, $67, $C9

Func_01B_6153::
    ld hl, Func_01D_5DA1
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ret

Func_01B_6170::
    ld hl, Func_01D_5DA1
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $87
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ret

Func_01B_618C::
    ld hl, vBGMap0 + $20F
    di
    call Func_000_120A
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    di
    call Func_000_120A
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    di
    call Func_000_120A
    ld a, [de]
    ld [hl], a
    ei
    ret

Func_01B_61A7::
    ld a, [wD783]
    rst $00
    dw Jump_01B_61B7
    dw Jump_01B_61BB
    dw Jump_01B_61B7
    dw Jump_01B_61BB
    dw Jump_01B_61B7
    dw Jump_01B_61D7

Jump_01B_61B7::
    ld b, $C3
    jr Func_01B_61BD

Jump_01B_61BB::
    ld b, $BC

Func_01B_61BD::
    ld hl, vBGMap0 + $20F
    ld a, [wD785]
    add a, l
    ld l, a
    jr nc, Jump_01B_61C8
    inc h

Jump_01B_61C8::
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ld a, [wD783]
    inc a
    ld [wD783], a
    ret

Jump_01B_61D7::
    ld b, $BB
    call Func_01B_61BD
    xor a, a
    ld [wD783], a
    ld a, [wD785]
    inc a
    ld [wD785], a
    cp a, $03
    ret c
    xor a, a
    ld [wD785], a
    ld de, Data_01B_6607
    call Func_01B_618C
    ret

Func_01B_61F5::
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, Func_01B_480C
    ld b, $1B
    rst $10
    ret

Func_01B_6203::
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_01B_6371
    ld de, Data_01B_6565
    ld hl, wC412
    ld bc, $0105
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ret

Func_01B_6232::
    push hl
    push bc

Jump_01B_6234::
    push hl
    push bc

Jump_01B_6236::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01B_6236
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01B_6234
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_01B_625D::
    push hl
    push bc

Jump_01B_625F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_625F
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01B_625D
    ld a, $00
    ldh [rSVBK], a
    ret

Func_01B_6277::
    push de
    push bc
    push hl
    ld hl, wC198
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    push hl
    call Func_000_18A5
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    push de
    call Func_000_120A
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    pop de
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    call Func_000_18A5
    call Func_000_120A
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

Func_01B_62CB::
    ld hl, vBGMap0
    ldh a, [hFFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hFFA1]
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_01B_62EB
    inc h

Jump_01B_62EB::
    ret

Func_01B_62EC::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_01B_62EC
    ret

Func_01B_62F5::
    ld a, $02
    ldh [rSVBK], a

Jump_01B_62F9::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_62F9
    ld a, $00
    ldh [rSVBK], a
    ret

Func_01B_6308::
    push bc
    sla a
    add a, l
    ld l, a
    jr nc, Jump_01B_6310
    inc h

Jump_01B_6310::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

Func_01B_6318::
    ld a, c
    ld b, a
    ld c, $00

Jump_01B_631C::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call Func_01B_6308
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_01B_631C
    ret

Func_01B_632C::
    push de
    call Func_01B_62CB
    pop de
    add hl, de
    di
    call Func_000_120A
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call Func_000_120A
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call Func_000_120A
    ld a, $C6
    ld [hl], a
    ei
    ret

Func_01B_634F::
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

Func_01B_635D:: ; heuristic: follows a terminator; C0
    xor a, a

Jump_01B_635E::
    push af
    di

Jump_01B_6360::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01B_6360
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, Jump_01B_635E
    ret

Func_01B_6371::
    push bc
    push hl
    push de
    ld de, wC198
    add hl, de
    pop de
    push de
    push hl
    ld hl, wC198
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call Func_01B_62EC
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01B_63B6
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call Func_01B_62F5
    pop de
    pop hl

Jump_01B_63B6::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_01B_63BE
    inc h

Jump_01B_63BE::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01B_63C5
    inc d

Jump_01B_63C5::
    inc b
    ld a, b
    cp a, c
    jr c, Func_01B_6371
    ret

Func_01B_63CB::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_01B_63E9
    bit 7, a
    jr nz, Jump_01B_63FF
    ld a, [wC562]
    bit 0, a
    jr nz, Jump_01B_6425
    bit 1, a
    jr nz, Jump_01B_6433
    call Func_01B_6439
    xor a, a
    ld [wD7F9], a
    ret

Jump_01B_63E9::
    call Func_01B_6457
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_01B_63F9
    ld a, $01
    ld [wD7FA], a
    jr Jump_01B_6413

Jump_01B_63F9::
    dec a
    ld [wD7FA], a
    jr Jump_01B_6413

Jump_01B_63FF::
    call Func_01B_6457
    ld a, [wD7FA]
    cp a, $01
    jr c, Jump_01B_640F
    xor a, a
    ld [wD7FA], a
    jr Jump_01B_6413

Jump_01B_640F::
    inc a
    ld [wD7FA], a

Jump_01B_6413::
    xor a, a
    ld [wD783], a
    call Func_01B_6453
    ld a, $69
    call Func_000_1278
    ld a, $FD
    ld [wD7F9], a
    ret

Jump_01B_6425::
    call Func_01B_645B
    ld a, $69
    call Func_000_1278
    ld a, $FF
    ld [wD7F9], a
    ret

Jump_01B_6433::
    ld a, $FE
    ld [wD7F9], a
    ret

Func_01B_6439::
    ld a, [wC564]
    cp a, $14
    jr c, Func_01B_6453
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    jr c, Func_01B_6453
    cp a, $18
    jr c, Func_01B_6457
    xor a, a
    ld [wD783], a

Func_01B_6453::
    ld b, $BB
    jr Jump_01B_645D

Func_01B_6457::
    ld b, $C3
    jr Jump_01B_645D

Func_01B_645B::
    ld b, $BC

Jump_01B_645D::
    ld a, [wD7FA]
    sla a
    ld hl, Data_01B_647F
    add a, l
    ld l, a
    jr nc, Jump_01B_646A
    inc h

Jump_01B_646A::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call Func_01B_62CB
    pop de
    add hl, de
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_01B_647F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

Data_01B_6483:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06E483, $78

Data_01B_64FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_650A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06E50A, $5B

Data_01B_6565:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06E565, $41

Data_01B_65A6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $50, $51, $52, $53, $54, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $55, $56, $57, $58, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_65CE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $C3, $B7

Data_01B_65DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

Data_01B_65E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $25, $C4, $4D, $C4

Data_01B_65E9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $A5, $71, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_01B_6607:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BC, $BC, $BC

Data_01B_660A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A0, $A1, $A2

Func_01B_660D::
    ld hl, wD780
    ld bc, $006F

Jump_01B_6613::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_6613
    ld b, $46
    ld de, Func_01B_4001
    ld hl, vTiles1
    call Func_000_0CF5
    ld hl, Func_0F1_4AA8
    ld b, $F1
    rst $10
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a

Jump_01B_6650::
    ld hl, Func_002_69D0
    ld b, $02
    rst $10
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_01B_6650
    ret

Func_01B_665E::
    ld a, [wD780]
    rst $00
    dw Jump_01B_6682
    dw Jump_01B_6698
    dw Jump_01B_66A6
    dw Jump_01B_671F
    dw Jump_01B_6727
    dw Jump_01B_6C61
    dw Jump_01B_6F8F
    dw Jump_01B_6F8F
    dw Jump_01B_6F8F
    dw Jump_01B_6F8F
    dw Jump_01B_6F8F
    dw Jump_01B_6F8F
    dw Jump_01B_6F8F
    dw Jump_01B_6FAB
    dw Jump_01B_6FC4
    dw Jump_01B_7019

Jump_01B_6682::
    ld a, $C0
    ldh [hFFBA], a
    xor a, a
    ld [wC528], a
    call Func_01B_7439
    call Func_01B_74DC
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_01B_6698::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ret

Jump_01B_66A6::
    ld a, [wD781]
    rst $00
    dw Jump_01B_66B4
    dw Jump_01B_66C6
    dw Jump_01B_66D8
    dw Jump_01B_66EA
    dw Jump_01B_66FC

Jump_01B_66B4::
    ld a, [wC58F]
    cp a, $FE
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_66C6::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $0C
    call Func_01B_7439
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_66D8::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $01
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_66EA::
    ld a, [wC58F]
    cp a, $01
    ret nz
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_66FC::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld hl, wD780
    ld bc, $006F

Jump_01B_6708::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_6708
    ld a, $05
    ld [wC5DB], a
    ld a, $01
    ld [wC5DC], a
    ld a, $01
    ld [wC5DF], a
    ret

Jump_01B_671F::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_01B_6727::
    ld a, [wD781]
    rst $00
    dw Jump_01B_6753
    dw Jump_01B_6747
    dw Func_01B_675F
    dw Jump_01B_6747
    dw Func_01B_67A5
    dw Func_01B_67F0
    dw Func_01B_6814
    dw Jump_01B_683D
    dw Jump_01B_686F
    dw Jump_01B_6940
    dw Jump_01B_69A9
    dw Jump_01B_6A4F
    dw Jump_01B_6A89
    dw Jump_01B_6AB3

Jump_01B_6747::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, Func_015_40FA
    ld b, $15
    rst $10
    ret

Jump_01B_6753::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, Func_015_40FA
    ld b, $15
    rst $10
    ret

Func_01B_675F::
    call Func_01B_7399
    ld hl, Func_01E_7163
    ld b, $1E
    rst $10
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01B_679D
    ld de, $0142
    call Func_01B_632C
    ld hl, wC42E
    call Func_01B_634F
    ld de, $0143
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld hl, Func_01E_7564
    ld b, $1E
    rst $10
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    ld hl, Func_01E_759A
    ld b, $1E
    rst $10

Jump_01B_679D::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_01B_67A5::
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call Func_01B_7460
    ld de, Data_01B_7738
    ld hl, wC434
    ld bc, $0501
    call Func_01B_6232
    ld de, Data_01B_773D
    ld hl, wC440
    ld bc, $0D02
    call Func_01B_6232
    pop af
    ld [wD7F1], a
    ld hl, wC443
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    call Func_01B_7487
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_01B_67F0::
    ld hl, vTiles1 + $780
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    call Func_01B_75B4
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_01B_6814::
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_6829
    ld de, Data_01B_7757
    ld hl, wC36E
    ld bc, $0A07
    call Func_01B_6232
    jr Jump_01B_6835

Jump_01B_6829::
    ld de, Data_01B_779D
    ld hl, wC36E
    ld bc, $0A09
    call Func_01B_6232

Jump_01B_6835::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_683D::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_01B_786F
    call Func_01B_6308
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_01B_786F
    call Func_01B_6308
    call Func_01B_7449
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_686F::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_688D
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_688D::
    xor a, a
    ld [wD7F9], a
    ld hl, Func_01D_66B6
    ld b, $1D
    rst $10
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01B_68B1
    cp a, $FC
    jr z, Jump_01B_68B1
    cp a, $FD
    jr z, Jump_01B_68BA
    cp a, $FE
    jr z, Jump_01B_68C3
    cp a, $FF
    jr z, Jump_01B_690D
    ret

Jump_01B_68B1::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_01B_68BA::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01B_68C3::
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_68F6
    cp a, $03
    jr c, Jump_01B_68DE
    ld a, [wD7B4]
    ld [wD7DC], a
    dec a
    ld [wD7DC], a
    ld a, $01
    call Func_01B_7439
    jr Jump_01B_68E6

Jump_01B_68DE::
    dec a
    ld [wD7DC], a
    xor a, a
    call Func_01B_7439

Jump_01B_68E6::
    call Func_01B_74DC
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld a, $01
    ld [wD781], a
    ret

Jump_01B_68F6::
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_01B_7439
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_690D::
    call Func_01B_75E4
    call Func_01B_7600
    cp a, $FF
    jr z, Jump_01B_6918
    ret

Jump_01B_6918::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_786F
    call Func_01B_6308
    call Func_01B_76E3
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7DC]
    cp a, $03
    jr z, Jump_01B_693A
    ld a, $02
    call Func_01B_7439
    ret

Jump_01B_693A::
    ld a, $07
    call Func_01B_7439
    ret

Jump_01B_6940::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $1E
    ld [wC529], a
    ld hl, Func_01B_481A
    ld b, $1B
    rst $10
    ld a, $6C
    call Func_000_1278
    ld de, Data_01B_7847
    ld hl, wC410
    ld bc, $0805
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_69A9::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_69C7
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_69C7::
    xor a, a
    ld [wD7F5], a
    ld hl, Func_00D_4D24
    ld b, $0D
    rst $10
    ld a, [wD7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_69DF
    cp a, $FF
    jr z, Jump_01B_69E7
    ret

Jump_01B_69DF::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_69E7::
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_01B_6A06
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0C
    ld [wD780], a
    ret

Jump_01B_6A06::
    call Func_01B_75E4
    ld a, [wD7DC]
    cp a, $03
    jr c, Jump_01B_6A46
    call Func_01B_728A
    cp a, $FF
    jr nz, Jump_01B_6A18
    ret

Jump_01B_6A18::
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wC94C], a
    ld a, $04
    ld [wD7DC], a
    call Func_01B_6A5E
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $0C
    call Func_01B_7439
    ret

Jump_01B_6A46::
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_01B_6A4F::
    ld a, [wC52B]
    and a, a
    ret nz
    ld c, $05
    ld hl, Data_01B_786F
    call Func_01B_6318
    jr Jump_01B_6A71

Func_01B_6A5E::
    ld c, $05
    ld hl, Data_01B_786F
    call Func_01B_6318
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_786F
    call Func_01B_6308

Jump_01B_6A71::
    call Func_01B_7377
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ret

Jump_01B_6A89::
    call Func_01B_7600
    cp a, $FF
    ret nz
    call Func_01B_7377
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD7DC]
    inc a
    ld [wD7DC], a
    call Func_01B_74DC
    call Func_01B_7537
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6AB3::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_6AD1
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_6AD1::
    ld a, [wD782]
    rst $00
    dw Jump_01B_6AE5
    dw Jump_01B_6B0B
    dw Jump_01B_6B4B
    dw Jump_01B_6B9E
    dw Jump_01B_6BAB
    dw Jump_01B_6BF7
    dw Jump_01B_6B0B
    dw Jump_01B_6C05

Jump_01B_6AE5::
    ld a, [wD7DC]
    cp a, $03
    jr z, Jump_01B_6B02
    call Func_01B_7399
    ld a, [wD7A9]
    and a, a
    jr z, Jump_01B_6B02
    ld a, $03
    call Func_01B_7439
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_6B02::
    ld a, [wD782]
    add a, $04
    ld [wD782], a
    ret

Jump_01B_6B0B::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, $6C
    call Func_000_1278
    ld de, Data_01B_78CB
    ld hl, wC412
    ld bc, $0605
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ld a, [wD782]
    cp a, $01
    jr z, Jump_01B_6B3F
    ld a, [wD7DC]
    cp a, $03
    jr nz, Jump_01B_6B3F
    ld a, $01
    jr Jump_01B_6B40

Jump_01B_6B3F::
    xor a, a

Jump_01B_6B40::
    ld [wD7FA], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_6B4B::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_6B69
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_6B69::
    ld hl, Func_01D_6540
    ld b, $1D
    rst $10
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_6B7D
    cp a, $FF
    jr z, Jump_01B_6B89
    ret

Jump_01B_6B7D::
    call Func_01B_7349
    ld a, [wD782]
    add a, $02
    ld [wD782], a
    ret

Jump_01B_6B89::
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_01B_6B7D
    call Func_01B_7349
    xor a, a
    call Func_01B_7439
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_6B9E::
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ret

Jump_01B_6BAB::
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_6BBB
    ld a, $0C
    call Func_01B_7439
    call Func_01B_7716
    ret

Jump_01B_6BBB::
    ld hl, Func_01D_5ECE
    ld b, $1D
    rst $10
    ld a, [wD7A9]
    and a, a
    jr nz, Jump_01B_6BD7
    call Func_01B_72AD
    ld a, $05
    call Func_01B_7439
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_6BD7::
    ld a, $04
    call Func_01B_7439
    call Func_01B_72AD
    ld a, [wD7DC]
    ld [wD7B4], a
    ld a, $03
    ld [wD7DC], a
    ld a, [wD782]
    add a, $02
    ld [wD782], a
    xor a, a
    ld [wD7FA], a
    ret

Jump_01B_6BF7::
    ld a, [wC52B]
    and a, a
    ret nz
    call Func_01B_7716
    ld a, $0C
    call Func_01B_7439
    ret

Jump_01B_6C05::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_6C23
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_6C23::
    ld hl, Func_01D_6540
    ld b, $1D
    rst $10
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_6C37
    cp a, $FF
    jr z, Jump_01B_6C4D
    ret

Jump_01B_6C37::
    call Func_01B_7349
    ld a, $04
    ld [wD7DC], a
    ld a, $FF
    ld [wD7E0], a
    ld a, [wD782]
    sub a, $02
    ld [wD782], a
    ret

Jump_01B_6C4D::
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_01B_6C37
    call Func_01B_7349
    ld a, $06
    call Func_01B_7439
    ld a, $03
    ld [wD782], a
    ret

Jump_01B_6C61::
    ld a, [wD781]
    rst $00
    dw Jump_01B_6CB8
    dw Jump_01B_6CC8
    dw Jump_01B_6D11
    dw Jump_01B_6D1E
    dw Jump_01B_6D4B
    dw Jump_01B_6D96
    dw Jump_01B_6DB3
    dw Jump_01B_6E09
    dw Jump_01B_6EB9
    dw Jump_01B_6C9E
    dw Jump_01B_6CAB
    dw Jump_01B_6D11
    dw Jump_01B_6EC6
    dw Jump_01B_6EF3
    dw Jump_01B_6D11
    dw Jump_01B_6F45
    dw Jump_01B_6D7E
    dw Jump_01B_6C91
    dw Jump_01B_6CAB
    dw Jump_01B_6D11
    dw Jump_01B_6D1E
    dw Jump_01B_6F68

Jump_01B_6C91::
    ld a, $09
    call Func_01B_7439
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6C9E::
    ld a, $0C
    call Func_01B_7439
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6CAB::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6CB8::
    ld a, [wC52B]
    and a, a
    ret nz
    call Func_01B_7537
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6CC8::
    ld a, [wD7E0]
    cp a, $FF
    jr nz, Jump_01B_6CEC
    ld hl, wC986
    ld bc, $00A5
    xor a, a
    call Func_000_0949
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA00F
    ld de, wC995
    ld b, $0A
    jr Jump_01B_6D03

Jump_01B_6CEC::
    ld c, $A5
    call Func_000_1682
    ld de, sA000
    add hl, de
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wC986
    ld b, $A5

Jump_01B_6D03::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01B_6D03
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6D11::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wC594], a
    ret

Jump_01B_6D1E::
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_01B_6D3F
    cp a, $FE
    ret nz
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_6D3F::
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6D4B::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, wC986
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, $00A5
    ld a, l
    ld [wC592], a
    ld a, h
    ld [wC593], a
    ld hl, wCA2B
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_01B_6D7E::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wC58C], a
    ld a, $00
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6D96::
    ld a, [wC58F]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wC58C], a
    ld a, $00
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $08
    call Func_01B_7439
    ret

Jump_01B_6DB3::
    ld a, [wC52B]
    and a, a
    ret nz
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0E01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $1F
    ld [wC529], a
    ld hl, Func_01B_481A
    ld b, $1B
    rst $10
    ld a, $6C
    call Func_000_1278
    ld de, Data_01B_78E9
    ld hl, wC3E7
    ld bc, $0907
    call Func_01B_6232
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    call Func_01B_7449
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6E09::
    ld a, [wC58F]
    cp a, $FE
    jr nz, Jump_01B_6E27
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_6E27::
    ld hl, Func_0F1_5842
    ld b, $F1
    rst $10
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_6E3B
    cp a, $FF
    jr z, Jump_01B_6E52
    ret

Jump_01B_6E3B::
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call Func_01B_7439
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_6E52::
    ld a, [wD7FA]
    and a, a
    jr z, Jump_01B_6E5E
    cp a, $01
    jr z, Jump_01B_6E67
    jr Jump_01B_6E3B

Jump_01B_6E5E::
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

Jump_01B_6E67::
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_6E7B
    ld a, $14
    call Func_01B_7439
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6E7B::
    ld a, [wCA2B]
    and a, a
    jr nz, Jump_01B_6E8E
    ld a, $15
    call Func_01B_7439
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6E8E::
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    ld a, $0D
    ld [wD780], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD781], a
    ld [wD782], a
    ret

Jump_01B_6EB9::
    ld a, [wC52B]
    and a, a
    ret nz
    ld a, [wD781]
    dec a
    ld [wD781], a
    ret

Jump_01B_6EC6::
    ld a, [wC58F]
    cp a, $01
    jr z, Jump_01B_6EE7
    cp a, $FE
    ret nz
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call Func_01B_7439
    ld a, $FE
    ld [wC594], a
    ret

Jump_01B_6EE7::
    xor a, a
    ld [wC594], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6EF3::
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_01B_6F1F
    xor a, a
    ld [wC94B], a
    call Func_01B_7152
    ld hl, wD0D5
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wD1BF
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6F1F::
    ld a, $01
    ld [wC94B], a
    call Func_01B_7152
    ld hl, wD1BF
    ld a, l
    ld [wC595], a
    ld a, h
    ld [wC596], a
    ld hl, wD0D5
    ld a, l
    ld [wC590], a
    ld a, h
    ld [wC591], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6F45::
    ld a, [wC58F]
    cp a, $01
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, $00EA
    ld a, l
    ld [wC592], a
    ld a, h
    ld [wC593], a
    ld a, $FF
    ld [wC594], a
    ld a, $01
    ld [wC58C], a
    ret

Jump_01B_6F68::
    ld a, $04
    ld [wC5DB], a
    xor a, a
    ld [wC5DC], a
    ld [wC5DD], a
    ld [wC5DE], a
    ld a, $01
    ld [wC5DF], a
    ld a, $01
    ld [wC581], a
    ld a, $00
    ld [wC582], a
    xor a, a
    ld [wC594], a
    xor a, a
    ld [wC58F], a
    ret

Jump_01B_6F8F::
    ld hl, Func_01E_4069
    ld b, $1E
    rst $10
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    ret

Jump_01B_6FAB::
    ld hl, Func_0F1_4AD0
    ld b, $F1
    rst $10
    ld a, [wD780]
    cp a, $0E
    ret nz
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    ret

Jump_01B_6FC4::
    ld a, [wD781]
    rst $00
    dw Jump_01B_702D
    dw Jump_01B_704F
    dw Jump_01B_707E
    dw Jump_01B_708F
    dw Jump_01B_7093
    dw Jump_01B_7097
    dw Jump_01B_6FD8
    dw Jump_01B_710B

Jump_01B_6FD8::
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0E01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $1F
    ld [wC529], a
    ld hl, Func_01B_481A
    ld b, $1B
    rst $10
    ld de, Data_01B_78E9
    ld hl, wC3E7
    ld bc, $0907
    call Func_01B_6232
    call Func_01B_7449
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_7019::
    ld a, [wD781]
    rst $00
    dw Jump_01B_702D
    dw Jump_01B_704F
    dw Jump_01B_707E
    dw Jump_01B_708F
    dw Jump_01B_7093
    dw Jump_01B_7097
    dw Jump_01B_709B
    dw Jump_01B_710B

Jump_01B_702D::
    call Func_01B_7205
    ld de, Data_01B_7928
    ld hl, wC364
    ld bc, $080B
    call Func_01B_6232
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_786F
    call Func_01B_6308
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_704F::
    call Func_01B_7399
    ld hl, Func_01E_7163
    ld b, $1E
    rst $10
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01B_7076
    ld hl, wC42E
    call Func_01B_634F
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    ld hl, Func_01E_759A
    ld b, $1E
    rst $10

Jump_01B_7076::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_707E::
    ld hl, Func_01F_5C15
    ld b, $1F
    rst $10
    xor a, a
    ld [wD7F1], a
    ld hl, Func_01D_6AA5
    ld b, $1D
    rst $10
    ret

Jump_01B_708F::
    call Func_01B_67A5
    ret

Jump_01B_7093::
    call Func_01B_67F0
    ret

Jump_01B_7097::
    call Func_01B_6814
    ret

Jump_01B_709B::
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, $1E
    ld [wC529], a
    ld hl, Func_01B_481A
    ld b, $1B
    rst $10
    call Func_01B_76E3
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC528], a
    ld a, [wD7DC]
    cp a, $03
    jr c, Jump_01B_70E8
    ld a, $17
    jr Jump_01B_70EA

Jump_01B_70E8::
    ld a, $12

Jump_01B_70EA::
    ld [wC529], a
    ld hl, Func_01B_481A
    ld b, $1B
    rst $10
    ld de, Data_01B_7847
    ld hl, wC410
    ld bc, $0805
    call Func_01B_6232
    xor a, a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_710B::
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    call Func_01B_62CB
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_01B_6277
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Func_01B_7152::
    ld hl, wD0D5
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_01B_715F
    ld hl, wD1BF

Jump_01B_715F::
    ld c, $00

Jump_01B_7161::
    push bc
    push hl
    ld a, c
    ld de, wD7DD
    add a, e
    ld e, a
    jr nc, Jump_01B_716C
    inc d

Jump_01B_716C::
    push de
    ld a, [de]
    cp a, $FF
    jp z, Jump_01B_71DA
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [de]
    ld c, $01
    call Func_000_1FD1
    ld c, l
    ld b, h
    pop de
    pop hl
    push hl
    push de
    ld e, $0E
    call Func_01B_71FE
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $34
    call Func_000_1FD1
    ld c, l
    ld b, h
    pop hl
    ld e, $08
    call Func_01B_71FE
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $55
    call Func_000_1FD1
    ld c, l
    ld b, h
    pop hl
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a
    inc bc
    inc bc
    ld e, $15
    call Func_01B_71FE
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $6F
    call Func_000_1FD1
    ld c, l
    ld b, h
    pop hl
    ld e, $1F
    call Func_01B_71FE
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $A4
    call Func_000_1FD1
    ld c, l
    ld b, h
    pop hl
    ld a, [bc]
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr Jump_01B_71E5

Jump_01B_71DA::
    pop de
    pop hl
    push hl
    push de
    ld bc, $004E
    xor a, a
    call Func_000_0949

Jump_01B_71E5::
    pop de
    pop hl
    pop bc
    inc c
    ld a, $4E
    add a, l
    ld l, a
    jr nc, Jump_01B_71F0
    inc h

Jump_01B_71F0::
    ld a, c
    cp a, $03
    jp c, Jump_01B_7161
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

Func_01B_71FE::
    ld a, [bc]
    ld [hl+], a
    inc bc
    dec e
    jr nz, Func_01B_71FE
    ret

Func_01B_7205::
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld hl, vTiles1 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0501
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld hl, vTiles1 + $780
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call Func_000_290E
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0301
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld hl, vTiles1 + $4E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call Func_000_290E
    ld a, [wD7DC]
    push af
    xor a, a
    ld [wD7DC], a
    call Func_01B_74DC
    pop af
    ld [wD7DC], a
    call Func_01B_7537
    ret

Func_01B_728A::
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld e, a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_01B_72A1::
    ld a, [hl+]
    cp a, e
    jr z, Jump_01B_72AA
    dec b
    jr nz, Jump_01B_72A1
    xor a, a
    ret

Jump_01B_72AA::
    ld a, $FF
    ret

Func_01B_72AD::
    ld a, [wD7DC]
    cp a, $03
    ret z
    ld hl, wD7DD
    add a, l
    ld l, a
    jr nc, Jump_01B_72BB
    inc h

Jump_01B_72BB::
    ld a, [wD7DC]
    ld b, a
    ld a, $03
    sub a, b
    ld b, a

Jump_01B_72C3::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_01B_72C3
    ret

Func_01B_72CA::
    ld hl, wD7DD
    add a, l
    ld l, a
    jr nc, Jump_01B_72D2
    inc h

Jump_01B_72D2::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    call Func_000_1F80
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

Func_01B_72E7::
    ld a, [wD7DC]
    and a, a
    jr nz, Jump_01B_72EF

Jump_01B_72ED::
    xor a, a
    ret

Jump_01B_72EF::
    inc a
    ld b, a
    ld c, $00

Jump_01B_72F3::
    push bc
    ld a, c
    ld c, $0D
    call Func_01B_72CA
    pop bc
    push bc
    ld hl, wD7F1
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_01B_7305
    inc h

Jump_01B_7305::
    ldh a, [hFFC6]
    and a, $0F
    ld [hl], a
    pop bc
    inc c
    dec b
    jr nz, Jump_01B_72F3
    ld a, [wD7DC]
    ld hl, wD7DD
    add a, l
    ld l, a
    jr nc, Jump_01B_731A
    inc h

Jump_01B_731A::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0D
    call Func_000_1F80
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    and a, $0F
    ld d, a
    ld a, [wD7DC]
    ld b, a
    ld hl, wD7F1

Jump_01B_7339::
    push hl
    ld a, [hl]
    cp a, d
    jr z, Jump_01B_7345
    pop hl
    inc hl
    dec b
    jr nz, Jump_01B_7339
    jr Jump_01B_72ED

Jump_01B_7345::
    pop hl
    ld a, $FF
    ret

Func_01B_7349::
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_735E
    ld de, Data_01B_788F
    ld hl, wC412
    ld bc, $0605
    call Func_01B_6232
    jr Jump_01B_736A

Jump_01B_735E::
    ld de, Data_01B_78AD
    ld hl, wC412
    ld bc, $0605
    call Func_01B_6232

Jump_01B_736A::
    call Func_01B_62CB
    ld bc, $140D
    ld de, $01CC
    call Func_01B_6277
    ret

Func_01B_7377::
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_738C
    ld de, Data_01B_77F7
    ld hl, wC410
    ld bc, $0805
    call Func_01B_6232
    jr Jump_01B_7398

Jump_01B_738C::
    ld de, Data_01B_781F
    ld hl, wC410
    ld bc, $0805
    call Func_01B_6232

Jump_01B_7398::
    ret

Func_01B_7399::
    ld hl, wD789
    ld b, $1E

Jump_01B_739E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_739E
    ld hl, wD7BE
    ld b, $1E

Jump_01B_73A8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_73A8
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wD7B9], a
    ld de, sA000
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_01B_73C7::
    ld a, [de]
    and a, a
    jr z, Jump_01B_741D
    cp a, $01
    jr z, Jump_01B_73DD
    ld a, [wD7DC]
    cp a, $03
    jr z, Jump_01B_741D
    ld a, [de]
    cp a, $02
    jr z, Jump_01B_73DD
    jr Jump_01B_741D

Jump_01B_73DD::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01B_73E5
    inc d

Jump_01B_73E5::
    ld a, [de]
    and a, a
    jr nz, Jump_01B_7415
    pop de
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_7410
    cp a, $03
    jr nc, Jump_01B_7410
    push hl
    push de
    push bc
    ld d, b
    ld hl, wD7DD
    ld a, [wD7DC]
    ld b, a

Jump_01B_73FF::
    ld a, [hl+]
    cp a, d
    jr z, Jump_01B_740B
    dec b
    jr nz, Jump_01B_73FF
    pop bc
    pop de
    pop hl
    jr Jump_01B_7410

Jump_01B_740B::
    pop bc
    pop de
    pop hl
    jr Jump_01B_741D

Jump_01B_7410::
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01B_741D

Jump_01B_7415::
    pop de
    ld a, [wD7B9]
    inc a
    ld [wD7B9], a

Jump_01B_741D::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01B_7424
    inc d

Jump_01B_7424::
    inc b
    ld a, b
    cp a, $1E
    jr c, Jump_01B_73C7
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    ld hl, Func_01D_5F9C
    ld b, $1D
    rst $10
    ret

Func_01B_7439::
    add a, $10
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, Func_01B_480C
    ld b, $1B
    rst $10
    ret

Func_01B_7449::
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

Func_01B_7460::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call Func_000_1F80
    ldh a, [hFFC6]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F1]
    ld [wD09E], a
    ld hl, Func_016_7A48
    ld b, $16
    rst $10
    xor a, a
    ld [rRAMG2], a
    ret

Func_01B_7487::
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld l, a
    ld a, [wD7F3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $56
    call Func_000_1F80
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld hl, Func_01E_75B3
    ld b, $1E
    rst $10
    ld a, [wC8C1]
    add a, $E0
    pop hl
    push hl
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl+], a
    pop hl
    pop bc
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    ld a, b
    ld c, $0E
    ld b, $01
    call Func_000_1F80
    ldh a, [hFFC6]
    and a, $01
    add a, $CC
    pop hl
    ld [hl], a
    ret

Func_01B_74DC::
    ld hl, $0601
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_74FB
    cp a, $01
    jr z, Jump_01B_7509
    cp a, $02
    jr z, Jump_01B_7517
    cp a, $03
    jr z, Jump_01B_7525
    jr Jump_01B_7533

Jump_01B_74FB::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call Func_000_290E

Jump_01B_7509::
    ld hl, vTiles2 + $160
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call Func_000_290E

Jump_01B_7517::
    ld hl, vTiles2 + $1C0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call Func_000_290E

Jump_01B_7525::
    ld hl, vTiles2 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call Func_000_290E

Jump_01B_7533::
    call Func_01B_7449
    ret

Func_01B_7537::
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_75A7
    cp a, $01
    jr z, Jump_01B_754D
    cp a, $02
    jr z, Jump_01B_7551
    cp a, $03
    jr z, Jump_01B_7555
    ld b, $04
    jr Jump_01B_7557

Jump_01B_754D::
    ld b, $01
    jr Jump_01B_7557

Jump_01B_7551::
    ld b, $02
    jr Jump_01B_7557

Jump_01B_7555::
    ld b, $03

Jump_01B_7557::
    ld hl, wD7DD
    ld c, $00

Jump_01B_755C::
    push hl
    push bc
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_75A0
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    pop bc
    push bc
    ld a, c
    sla a
    ld hl, Data_01B_75A8
    add a, l
    ld l, a
    jr nc, Jump_01B_7583
    inc h

Jump_01B_7583::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call Func_000_21A1
    pop bc
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld b, a
    ld a, c
    ld hl, Data_01B_75B0
    add a, l
    ld l, a
    jr nc, Jump_01B_7599
    inc h

Jump_01B_7599::
    ld a, [hl]
    ld [wD7F1], a
    call Func_01B_7460

Jump_01B_75A0::
    pop bc
    pop hl
    inc hl
    inc c
    dec b
    jr nz, Jump_01B_755C

Jump_01B_75A7::
    ret

Data_01B_75A8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $91, $70, $91, $D0, $91, $30, $92

Data_01B_75B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $16, $1C, $22

Func_01B_75B4::
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles1 + $780
    call Func_000_21A1
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

Func_01B_75E4::
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld de, wD7DD
    ld a, [wD7DC]
    add a, e
    ld e, a
    jr nc, Jump_01B_75FD
    inc d

Jump_01B_75FD::
    ld a, [hl]
    ld [de], a
    ret

Func_01B_7600::
    ld a, [wD7DC]
    cp a, $03
    jp z, Jump_01B_76E0
    ld a, [wD048]
    bit 7, a
    jr z, Jump_01B_7688
    bit 6, a
    jr nz, Jump_01B_764B
    ld a, [wD7DC]
    inc a
    ld b, a
    ld c, $00
    ld de, $0000

Jump_01B_761D::
    push bc
    push de
    ld a, c
    ld c, $56
    call Func_01B_72CA
    pop de
    ldh a, [hFFC6]
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    inc c
    dec b
    jr nz, Jump_01B_761D
    ld a, [wD048]
    and a, $01
    ld h, a
    ld a, [wD047]
    ld l, a
    ld a, h
    cp a, d
    jr c, Jump_01B_767A
    jr z, Jump_01B_7645
    jr Jump_01B_7688

Jump_01B_7645::
    ld a, l
    cp a, e
    jr c, Jump_01B_767A
    jr Jump_01B_7688

Jump_01B_764B::
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    xor a, a
    ld [rRAMG2], a
    ld [rRAMG], a
    ld a, [wD046]
    ld b, a
    ldh a, [hFFC6]
    cp a, b
    jr c, Jump_01B_7688
    jr z, Jump_01B_7688

Jump_01B_767A::
    ld a, $11
    call Func_01B_7439
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ret

Jump_01B_7688::
    ld a, [wD049]
    bit 7, a
    jr z, Jump_01B_76E0
    ld a, [wD04A]
    bit 0, a
    jr nz, Jump_01B_76CB
    ld a, [wD7DC]
    ld c, $0D
    call Func_01B_72CA
    ldh a, [hFFC6]
    and a, $0F
    sla a
    ld de, Data_01B_7879
    add a, e
    ld e, a
    jr nc, Jump_01B_76AC
    inc d

Jump_01B_76AC::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld bc, wD049
    ld a, [bc]
    and a, h
    jr nz, Jump_01B_76BD
    inc bc
    ld a, [bc]
    and a, l
    jr z, Jump_01B_76E0

Jump_01B_76BD::
    ld a, $12
    call Func_01B_7439
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ret

Jump_01B_76CB::
    call Func_01B_72E7
    cp a, $FF
    jr nz, Jump_01B_76E0
    ld a, $13
    call Func_01B_7439
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ret

Jump_01B_76E0::
    ld a, $FF
    ret

Func_01B_76E3::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, Func_01D_5D84
    ld b, $1D
    rst $10
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld hl, wC8CF
    ld de, wC130
    ld b, $0B

Jump_01B_7708::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01B_7708
    xor a, a
    ld [rRAMB], a
    ld [rRAMG], a
    ret

Func_01B_7716::
    call Func_01B_72AD
    ld a, [wD7DC]
    ld [wD7B4], a
    ld a, $FF
    ld [wD7E0], a
    ld a, $04
    ld [wD7DC], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Data_01B_7738:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B1, $B1, $B1, $B1, $B2

Data_01B_773D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $EA, $ED, $C3, $C3, $F8, $F9, $FA, $FB, $FC, $C3, $C7, $B7, $B3, $B4, $B4
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_7757:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06F757, $46

Data_01B_779D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06F79D, $5A

Data_01B_77F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $10, $C3
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_01B_781F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_01B_7847:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $73, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $74, $75, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_786F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

Data_01B_7879:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $80, $00
    db $40, $00, $20, $00, $10, $00

Data_01B_788F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1E, $C3

Data_01B_78AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B5
    ds $18, $C3

Data_01B_78CB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $76, $77, $78, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $79, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_01B_78E9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $30, $31, $32, $33, $34
    db $35, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $36, $37, $38
    db $39, $3A, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $3B
    db $3C, $3D, $3E, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_7928:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06F928, $58
    ds $680, $00
