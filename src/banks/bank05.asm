SECTION "Bank 05", ROMX[$4000], BANK[$05]
    db $05

Func_005_4001:: ; heuristic: follows a terminator; C0
    ld hl, wD8FF
    jr Jump_005_402E

Func_005_4006::
    ld hl, wD90F
    jr Jump_005_402E

Func_005_400B::
    ld hl, wD8CF
    jr Jump_005_402E

Func_005_4010::
    ld hl, wD8EF
    jr Jump_005_402E

Func_005_4015::
    ld hl, wD8BF
    jr Jump_005_402E

Func_005_401A::
    ld hl, wD8DF
    jr Jump_005_402E

Func_005_401F::
    ld hl, wD91F
    jr Jump_005_402E

Func_005_4024:: ; heuristic: follows a terminator; C0
    ld hl, wDA53
    add a, l
    ld l, a
    jr nc, Jump_005_402C
    inc h

Jump_005_402C::
    ld a, [hl]
    ret

Jump_005_402E::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_4034
    inc h

Jump_005_4034::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_005_4038:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_403E
    inc h

Jump_005_403E::
    ret

Func_005_403F:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_005_4054
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_005_4054
    ld a, [wD8A4]
    cp a, $04
    ccf
    ret

Jump_005_4054::
    ld a, [wD8A4]
    cp a, $04
    ret

Func_005_405A:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_005_406F
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_005_406F
    ld a, [wD8A5]
    cp a, $04
    ccf
    ret

Jump_005_406F::
    ld a, [wD8A5]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $014075, $CA

Func_005_413F::
    ld a, [wD8A4]
    ld hl, wD8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_414B
    inc h

Jump_005_414B::
    ld a, [wCFEE]
    or a, a
    jr z, Jump_005_4166
    cp a, $FF
    jr nz, Jump_005_415B
    ld a, [hl+]
    or a, [hl]
    jr nz, Jump_005_4166
    jr Jump_005_4163

Jump_005_415B::
    ld c, a
    ld a, [hl+]
    sub a, c
    ld a, [hl]
    sbc a, $00
    jr nc, Jump_005_4166

Jump_005_4163::
    ld c, $00
    ret

Jump_005_4166::
    ld c, $FF
    ret

Func_005_4169::
    ld a, [wCFF3]
    bit 6, a
    jr z, Jump_005_4180
    ld a, [wD8A4]
    ld hl, wD80D
    call Func_000_3F25
    bit 0, [hl]
    jr z, Jump_005_4180
    ld c, $00
    ret

Jump_005_4180::
    ld c, $FF
    ret

Func_005_4183:: ; heuristic: follows a terminator; C0
    ld a, [wCFF3]
    bit 4, a
    jr z, Jump_005_419B
    ld a, [wD8A4]
    ld hl, wD80D
    call Func_000_3F25
    bit 7, [hl]
    jp z, Jump_005_419B
    ld c, $00
    ret

Jump_005_419B::
    ld c, $FF
    ret

Func_005_419E:: ; heuristic: follows a terminator; C0
    ld a, [wCFF3]
    bit 5, a
    jr z, Jump_005_41B6
    ld a, [wD8A4]
    ld hl, wD80D
    call Func_000_3F25
    bit 6, [hl]
    jp z, Jump_005_41B6
    ld c, $00
    ret

Jump_005_41B6::
    ld c, $FF
    ret

Func_005_41B9::
    ld hl, wD80A
    ld a, [hl+]
    or a, [hl]
    and a, $08
    jr z, Jump_005_41D3
    ld a, [wCFEC]
    cp a, $84
    jr z, Jump_005_41D0
    ld a, [wCFF3]
    bit 6, a
    jr z, Jump_005_41D3

Jump_005_41D0::
    ld c, $00
    ret

Jump_005_41D3::
    ld c, $FF
    ret

Func_005_41D6::
    ld a, [wCFF6]
    bit 7, a
    jr z, Jump_005_41E8
    ld a, [wCFEC]
    call Func_000_3F47
    jr nz, Jump_005_41E8
    ld c, $00
    ret

Jump_005_41E8::
    ld c, $FF
    ret

Func_005_41EB::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD80E
    ld e, $22
    call Func_005_6FA1
    ret

Func_005_41FD::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD811
    ld e, $C0
    call Func_005_6FA1
    ret

Func_005_420F::
    ld hl, wD80E
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $08
    call Func_005_6FA1
    ret

Func_005_4221::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_422B::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_423E
    ld a, c
    ld hl, wD80F
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    and a, a
    jr z, Jump_005_4244

Jump_005_423E::
    inc c
    dec b
    jr nz, Jump_005_422B
    jr Jump_005_4253

Jump_005_4244::
    ld a, c
    ld hl, wD810
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    and a, a
    jr z, Jump_005_4256
    jr Jump_005_423E

Jump_005_4253::
    ld c, $00
    ret

Jump_005_4256::
    ld c, $FF
    ret

Func_005_4259:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4263::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_427C
    ld hl, wD8DF
    ld a, c
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_4274
    inc h

Jump_005_4274::
    ld a, [hl+]
    and a, a
    jr nz, Jump_005_4283
    ld a, [hl+]
    and a, a
    jr nz, Jump_005_4283

Jump_005_427C::
    inc c
    dec b
    jr nz, Jump_005_4263
    ld c, $00
    ret

Jump_005_4283::
    ld c, $FF
    ret

Func_005_4286:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jp c, Jump_005_4319
    ld a, [wCFEC]
    ld l, a
    ld a, [wCFED]
    ld h, a
    push hl
    ld b, $03
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld e, a

Jump_005_42A4::
    ld a, e
    ld hl, wD988
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_42AF
    inc h

Jump_005_42AF::
    ld a, e
    call Func_000_3E54
    jr c, Jump_005_42F4
    ld c, $00

Jump_005_42B7::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_005_42F4
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    ld a, $07
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    push hl
    push bc
    push de
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall Func_01A_4022
    pop de
    pop bc
    pop hl
    ldh a, [hFFC6]
    bit 0, a
    jr nz, Jump_005_430D
    inc c
    inc hl
    inc hl
    ld a, c
    cp a, $08
    jr c, Jump_005_42B7
    jr Jump_005_42FD

Jump_005_42F4::
    ld a, $08
    sub a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_42FD
    inc h

Jump_005_42FD::
    inc e
    dec b
    jr nz, Jump_005_42A4
    pop hl
    ld a, l
    ld [wCFEC], a
    ld a, h
    ld [wCFED], a
    ld c, $00
    ret

Jump_005_430D::
    pop hl
    ld a, l
    ld [wCFEC], a
    ld a, h
    ld [wCFED], a
    ld c, $FF
    ret

Jump_005_4319::
    ld c, $01
    ret

Func_005_431C:: ; heuristic: follows a terminator; C0
    ld hl, wD80C
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $40
    call Func_005_6FA1
    ret

Func_005_432E:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_4370
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $40

Jump_005_4348::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_435E
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_005_435E
    call Func_005_6C02
    jr nz, Jump_005_4369

Jump_005_435E::
    inc c
    dec b
    jr nz, Jump_005_4348
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_4369::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Jump_005_4370::
    ld c, $01
    ret

Func_005_4373:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_43AA
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

Jump_005_438D::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4398
    call Func_005_6C02
    jr nz, Jump_005_43A3

Jump_005_4398::
    inc c
    dec b
    jr nz, Jump_005_438D
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_43A3::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Jump_005_43AA::
    ld c, $01
    ret

Func_005_43AD:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_43EF
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $20

Jump_005_43C7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_43DD
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_005_43DD
    call Func_005_6C02
    jr nz, Jump_005_43E8

Jump_005_43DD::
    inc c
    dec b
    jr nz, Jump_005_43C7
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_43E8::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Jump_005_43EF::
    ld c, $01
    ret

Func_005_43F2::
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_4438
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_4402
    inc h

Jump_005_4402::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_441C
    inc h

Jump_005_441C::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4429
    call Func_005_6C86
    cp a, $03
    jr nz, Jump_005_4438

Jump_005_4429::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_441C
    ld c, $00
    ret

Jump_005_4438::
    ld c, $FF
    ret

Func_005_443B::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4445::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4457
    call Func_005_4006
    ld a, h
    or a, a
    jr nz, Jump_005_445E
    ld a, l
    cp a, $02
    jr nc, Jump_005_445E

Jump_005_4457::
    inc c
    dec b
    jr nz, Jump_005_4445
    ld c, $00
    ret

Jump_005_445E::
    ld c, $FF
    ret

Func_005_4461:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_446B::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_447D
    call Func_005_401F
    ld a, h
    or a, a
    jr nz, Jump_005_4484
    ld a, l
    cp a, $02
    jr nc, Jump_005_4484

Jump_005_447D::
    inc c
    dec b
    jr nz, Jump_005_446B
    ld c, $00
    ret

Jump_005_4484::
    ld c, $FF
    ret

Func_005_4487:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld hl, wD80E
    ld e, $40
    ld b, $03
    call Func_005_6FA1
    ret

Func_005_4499:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD80C
    ld e, $10
    call Func_005_6FA1
    ret

Func_005_44AB:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld hl, wD80C
    ld e, $02
    ld b, $03
    call Func_005_6FA1
    ret

Func_005_44BD:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD80C
    ld e, $03
    call Func_005_6FA1
    ret

Func_005_44CF::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld e, $CC
    ld hl, wD80C
    call Func_005_6FA1
    ret

Func_005_44E1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_4524
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $08

Jump_005_44FB::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4512
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    ld a, [hl]
    and a, $C1
    jr nz, Jump_005_4512
    call Func_005_6C02
    jr nz, Jump_005_451D

Jump_005_4512::
    inc c
    dec b
    jr nz, Jump_005_44FB
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_451D::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Jump_005_4524::
    ld c, $01
    ret

Func_005_4527:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD811
    ld e, $03
    call Func_005_6FA1
    ret

Func_005_4539:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4543::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4561
    ld a, c
    ld hl, wD811
    call Func_000_3F25
    ld a, [hl]
    and a, $01
    jr nz, Jump_005_4561
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    ld a, [hl]
    and a, $02
    jr z, Jump_005_4568

Jump_005_4561::
    inc c
    dec b
    jr nz, Jump_005_4543
    ld c, $00
    ret

Jump_005_4568::
    ld c, $FF
    ret

Func_005_456B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4575::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4593
    ld a, c
    ld hl, wD811
    call Func_000_3F25
    ld a, [hl]
    and a, $02
    jr nz, Jump_005_4593
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    ld a, [hl]
    and a, $02
    jr z, Jump_005_459A

Jump_005_4593::
    inc c
    dec b
    jr nz, Jump_005_4575
    ld c, $00
    ret

Jump_005_459A::
    ld c, $FF
    ret

Func_005_459D:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_45A7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_45C5
    ld a, c
    ld hl, wD811
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    jr nz, Jump_005_45C5
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    ld a, [hl]
    and a, $02
    jr z, Jump_005_45CC

Jump_005_45C5::
    inc c
    dec b
    jr nz, Jump_005_45A7
    ld c, $00
    ret

Jump_005_45CC::
    ld c, $FF
    ret

Func_005_45CF:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld hl, wD80D
    ld b, $03
    ld e, $01
    call Func_005_6FA1
    ret

Func_005_45E1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld hl, wD80D
    ld b, $03
    ld e, $80
    call Func_005_6FA1
    ret

Func_005_45F3:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld hl, wD80D
    ld b, $03
    ld e, $40
    call Func_005_6FA1
    ret

Func_005_4605::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_460F::
    ld a, c
    call Func_000_3E25
    jr nc, Jump_005_461C
    inc c
    dec b
    jr nz, Jump_005_460F
    ld c, $00
    ret

Jump_005_461C::
    ld c, $FF
    ret

Func_005_461F:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wD8A7
    add a, l
    ld l, a
    jr nc, Jump_005_4631
    inc h

Jump_005_4631::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4659
    bit 4, [hl]
    jr nz, Jump_005_4659
    push hl
    ld a, c
    ld hl, wD80F
    call Func_000_3F25
    ld a, [hl]
    pop hl
    and a, $C0
    and a, a
    jr nz, Jump_005_4659
    push hl
    ld a, c
    ld hl, wD80F
    call Func_000_3F25
    ld a, [hl]
    pop hl
    and a, $0C
    and a, a
    jr z, Jump_005_4661

Jump_005_4659::
    inc hl
    inc c
    dec b
    jr nz, Jump_005_4631
    ld c, $00
    ret

Jump_005_4661::
    ld c, $FF
    ret

Func_005_4664::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld b, $03
    ld hl, wD80F
    ld e, $FF
    call Func_005_6FA1
    ret

Func_005_4676::
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_46B1
    call Func_005_702D
    jr z, Jump_005_46AE
    cp a, $03
    jr nz, Jump_005_46AE
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4693::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_46A5
    ld a, c
    ld hl, wD80E
    call Func_000_3F25
    ld a, [hl]
    and a, $22
    jr nz, Jump_005_46AB

Jump_005_46A5::
    inc c
    dec b
    jr nz, Jump_005_4693
    jr Jump_005_46AE

Jump_005_46AB::
    ld c, $00
    ret

Jump_005_46AE::
    ld c, $FF
    ret

Jump_005_46B1::
    ld c, $01
    ret

Func_005_46B4:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_46F0
    call Func_005_702D
    jr z, Jump_005_46ED
    cp a, $03
    jr nz, Jump_005_46ED
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_46D1::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_46E4
    ld a, c
    ld hl, wD80E
    call Func_000_3F25
    ld a, [hl]
    and a, $40
    and a, a
    jr nz, Jump_005_46EA

Jump_005_46E4::
    inc c
    dec b
    jr nz, Jump_005_46D1
    jr Jump_005_46ED

Jump_005_46EA::
    ld c, $00
    ret

Jump_005_46ED::
    ld c, $FF
    ret

Jump_005_46F0::
    ld c, $01
    ret

Func_005_46F3:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD810
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    jr z, Jump_005_4704
    ld c, $00
    ret

Jump_005_4704::
    ld c, $FF
    ret

Func_005_4707::
    ld a, [wD8A4]
    ld hl, wD810
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    jr z, Jump_005_4718
    ld c, $00
    ret

Jump_005_4718::
    ld c, $FF
    ret

Func_005_471B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80D
    call Func_000_3F25
    bit 2, [hl]
    jr z, Jump_005_472B
    ld c, $00
    ret

Jump_005_472B::
    ld c, $FF
    ret

Func_005_472E:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80D
    call Func_000_3F25
    bit 3, [hl]
    jr z, Jump_005_473E
    ld c, $00
    ret

Jump_005_473E::
    ld c, $FF
    ret

Func_005_4741:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call Func_000_3F25
    bit 0, [hl]
    jr z, Jump_005_4751
    ld c, $00
    ret

Jump_005_4751::
    ld c, $FF
    ret

Func_005_4754:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call Func_000_3F25
    bit 6, [hl]
    jr z, Jump_005_4764
    ld c, $00
    ret

Jump_005_4764::
    ld c, $FF
    ret

Func_005_4767:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld b, $03
    ld e, $40
    ld hl, wD80E
    call Func_005_6FA1
    ret

Func_005_4777::
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_4782::
    ld a, c
    cp a, e
    jr z, Jump_005_4797
    call Func_000_3E54
    jr c, Jump_005_4797
    inc d
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    bit 6, [hl]
    jr z, Jump_005_47A2

Jump_005_4797::
    inc c
    dec b
    jr nz, Jump_005_4782
    ld a, d
    or a, a
    jr z, Jump_005_47A2
    ld c, $00
    ret

Jump_005_47A2::
    ld c, $FF
    ret

Func_005_47A5:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld b, $03
    ld hl, wD80C
    ld e, $03
    call Func_005_6FBD
    ret

Func_005_47B5:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld b, $03
    ld hl, wD80C
    ld e, $CC
    call Func_005_6FBD
    ret

Func_005_47C5:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld b, $03
    ld hl, wD80C
    ld e, $10
    call Func_005_6FBD
    ret

Func_005_47D5:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld b, $03
    ld hl, wD80C
    ld e, $20
    call Func_005_6FBD
    ret

Func_005_47E5:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04

Jump_005_47EA::
    ld c, a
    ld b, $03
    ld hl, wDA76
    call Func_005_6F60

Jump_005_47F3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4800
    ld a, [hl]
    and a, $3C
    cp a, $3C
    jr nz, Jump_005_480F

Jump_005_4800::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_47F3
    ld c, $00
    ret

Jump_005_480F::
    ld c, $FF
    ret

Func_005_4812:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    jp Jump_005_47EA

Func_005_481C::
    ld e, $00
    call Func_005_6FD9
    ret

Func_005_4822::
    ld e, $01
    call Func_005_6FD9
    ret

Func_005_4828::
    ld e, $02
    call Func_005_6FD9
    ret

Func_005_482E::
    ld e, $03
    call Func_005_6FD9
    ret

Func_005_4834::
    ld e, $05
    call Func_005_6FD9
    ret

Func_005_483A::
    ld e, $04
    call Func_005_6FD9
    ret

Func_005_4840::
    ld e, $06
    call Func_005_6FD9
    ret

Func_005_4846::
    ld e, $07
    call Func_005_6FD9
    ret

Func_005_484C::
    ld e, $08
    call Func_005_6FD9
    ret

Func_005_4852::
    ld e, $09
    call Func_005_6FD9
    ret

Func_005_4858:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4862::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4874
    ld hl, wD8A7
    add a, l
    ld l, a
    jr nc, Jump_005_4870
    inc h

Jump_005_4870::
    bit 0, [hl]
    jr nz, Jump_005_487A

Jump_005_4874::
    inc c
    dec b
    jr nz, Jump_005_4862
    jr Jump_005_487D

Jump_005_487A::
    ld c, $00
    ret

Jump_005_487D::
    ld c, $FF
    ret

Func_005_4880:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_488A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_48BF
    ld hl, wDA74
    call Func_005_6F60
    and a, $30
    cp a, $30
    jr z, Jump_005_48BF
    ld a, c
    call Func_005_4006
    ld a, h
    jr nz, Jump_005_48C6
    ld a, l
    cp a, $02
    jr nc, Jump_005_48C6
    ld a, c
    call Func_005_401F
    ld a, h
    jr nz, Jump_005_48C6
    ld a, l
    cp a, $02
    jr nc, Jump_005_48C6
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 1, [hl]
    jr z, Jump_005_48C6

Jump_005_48BF::
    inc c
    dec b
    jr nz, Jump_005_488A
    ld c, $00
    ret

Jump_005_48C6::
    ld c, $FF
    ret

Func_005_48C9::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_48D3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_48FA
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_005_48FA
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_005_48FA
    ld a, c
    ld hl, wDA73
    call Func_005_6F60
    and a, $03
    cp a, $03
    jr nz, Jump_005_4901

Jump_005_48FA::
    inc c
    dec b
    jr nz, Jump_005_48D3
    ld c, $00
    ret

Jump_005_4901::
    ld c, $FF
    ret

Func_005_4904:: ; heuristic: follows a terminator; C0
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $40

Jump_005_4914::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4937
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_005_4937
    call Func_005_6C02
    jr z, Jump_005_4937
    ld a, c
    ld hl, wDA74
    call Func_005_6F60
    and a, $03
    cp a, $03
    jr nz, Jump_005_4942

Jump_005_4937::
    inc c
    dec b
    jr nz, Jump_005_4914
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_4942::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Func_005_4949:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4953::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_496D
    call Func_005_401A
    ld a, h
    or a, l
    jr z, Jump_005_496D
    ld a, c
    ld hl, wDA74
    call Func_005_6F60
    and a, $0C
    cp a, $0C
    jr nz, Jump_005_4974

Jump_005_496D::
    inc c
    dec b
    jr nz, Jump_005_4953
    ld c, $00
    ret

Jump_005_4974::
    ld c, $FF
    ret

Func_005_4977::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4981::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_49A0
    call Func_005_4006
    ld a, h
    or a, a
    jr nz, Jump_005_4993
    ld a, l
    cp a, $02
    jr c, Jump_005_49A0

Jump_005_4993::
    ld a, c
    ld hl, wDA75
    call Func_005_6F60
    and a, $30
    cp a, $30
    jr nz, Jump_005_49A7

Jump_005_49A0::
    inc c
    dec b
    jr nz, Jump_005_4981
    ld c, $00
    ret

Jump_005_49A7::
    ld c, $FF
    ret

Func_005_49AA:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_49B4::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_49D3
    call Func_005_401F
    ld a, h
    or a, a
    jr nz, Jump_005_49C6
    ld a, l
    cp a, $02
    jr c, Jump_005_49D3

Jump_005_49C6::
    ld a, c
    ld hl, wDA75
    call Func_005_6F60
    and a, $0C
    cp a, $0C
    jr nz, Jump_005_49DA

Jump_005_49D3::
    inc c
    dec b
    jr nz, Jump_005_49B4
    ld c, $00
    ret

Jump_005_49DA::
    ld c, $FF
    ret

Func_005_49DD::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_49E7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4A06
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    jr nz, Jump_005_4A06
    ld a, c
    ld hl, wDA76
    call Func_005_6F60
    and a, $03
    cp a, $03
    jr nz, Jump_005_4A0D

Jump_005_4A06::
    inc c
    dec b
    jr nz, Jump_005_49E7
    ld c, $00
    ret

Jump_005_4A0D::
    ld c, $FF
    ret

Func_005_4A10:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4A1A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4A39
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    ld a, [hl]
    and a, $40
    jr nz, Jump_005_4A39
    ld a, c
    ld hl, wDA77
    call Func_005_6F60
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_4A40

Jump_005_4A39::
    inc c
    dec b
    jr nz, Jump_005_4A1A
    ld c, $00
    ret

Jump_005_4A40::
    ld c, $FF
    ret

Func_005_4A43:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4A4D::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4A6C
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    ld a, [hl]
    and a, $20
    jr nz, Jump_005_4A6C
    ld a, c
    ld hl, wDA77
    call Func_005_6F60
    and a, $30
    cp a, $30
    jr nz, Jump_005_4A73

Jump_005_4A6C::
    inc c
    dec b
    jr nz, Jump_005_4A4D
    ld c, $00
    ret

Jump_005_4A73::
    ld c, $FF
    ret

Func_005_4A76:: ; heuristic: follows a terminator; C0
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $20

Jump_005_4A86::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4AA9
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_005_4AA9
    call Func_005_6C02
    jr z, Jump_005_4AA9
    ld a, c
    ld hl, wDA77
    call Func_005_6F60
    and a, $03
    cp a, $03
    jr nz, Jump_005_4AB4

Jump_005_4AA9::
    inc c
    dec b
    jr nz, Jump_005_4A86
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_4AB4::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Func_005_4ABB:: ; heuristic: follows a terminator; C0
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

Jump_005_4ACB::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4AEE
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_005_4AEE
    call Func_005_6C02
    jr z, Jump_005_4AEE
    ld a, c
    ld hl, wDA78
    call Func_005_6F60
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_4AF9

Jump_005_4AEE::
    inc c
    dec b
    jr nz, Jump_005_4ACB
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_4AF9::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Func_005_4B00:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld hl, wDA63
    add a, l
    ld l, a
    jr nc, Jump_005_4B0E
    inc h

Jump_005_4B0E::
    ld b, $03

Jump_005_4B10::
    ld a, [hl+]
    cp a, $01
    jr z, Jump_005_4B3A
    dec b
    jr nz, Jump_005_4B10
    ld b, $03

Jump_005_4B1A::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4B31
    call Func_005_400B
    push hl
    ld a, c
    call Func_005_4015
    add hl, hl
    add hl, hl
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_4B39

Jump_005_4B31::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_4B1A
    ld c, $00
    ret

Jump_005_4B39::
    pop bc

Jump_005_4B3A::
    ld c, $FF
    ret

Func_005_4B3D::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_4B49::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4B50
    inc e

Jump_005_4B50::
    inc c
    dec b
    jr nz, Jump_005_4B49
    ld a, e
    cp a, $02
    jr nc, Jump_005_4B5C
    ld c, $00
    ret

Jump_005_4B5C::
    ld c, $FF
    ret

Func_005_4B5F:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    or a, $03
    ld hl, wDA63
    add a, l
    ld l, a
    jr nc, Jump_005_4B6E
    inc h

Jump_005_4B6E::
    ld a, [hl]
    or a, a
    jr z, Jump_005_4B74
    jr Jump_005_4B77

Jump_005_4B74::
    ld c, $00
    ret

Jump_005_4B77::
    ld c, $FF
    ret

Func_005_4B7A:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld hl, wDA63
    add a, l
    ld l, a
    jr nc, Jump_005_4B87
    inc h

Jump_005_4B87::
    ld b, $03

Jump_005_4B89::
    ld a, [hl+]
    cp a, $01
    jr z, Jump_005_4B94
    dec b
    jr nz, Jump_005_4B89
    ld c, $00
    ret

Jump_005_4B94::
    ld c, $FF
    ret

Func_005_4B97:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_401F
    ld b, h
    ld c, l
    ld a, $1F
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    push hl
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld de, $0000

Jump_005_4BB7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4BCE
    call Func_005_401F
    ld a, h
    cp a, d
    jr z, Jump_005_4BC8
    jr c, Jump_005_4BCE
    jr Jump_005_4BCC

Jump_005_4BC8::
    ld a, l
    cp a, e
    jr c, Jump_005_4BCE

Jump_005_4BCC::
    ld d, h
    ld e, l

Jump_005_4BCE::
    inc c
    dec b
    jr nz, Jump_005_4BB7
    pop hl
    ld b, d
    ld c, e
    call Func_000_3E7A
    jp c, Jump_005_4BDE
    ld c, $00
    ret

Jump_005_4BDE::
    ld c, $FF
    ret

Func_005_4BE1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_4BEB::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4BF8
    call Func_005_6B9E
    jr c, Jump_005_4BFF
    jr z, Jump_005_4BFF

Jump_005_4BF8::
    inc c
    dec b
    jr nz, Jump_005_4BEB
    ld c, $00
    ret

Jump_005_4BFF::
    ld c, $FF
    ret

Func_005_4C02:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_4C0C::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4C19
    call Func_005_6FFD
    jr c, Jump_005_4C20
    jr z, Jump_005_4C20

Jump_005_4C19::
    inc c
    dec b
    jr nz, Jump_005_4C0C
    ld c, $00
    ret

Jump_005_4C20::
    ld c, $FF
    ret

Func_005_4C23:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4C2B::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4C36
    call Func_005_6B20
    jr c, Jump_005_4C3D

Jump_005_4C36::
    inc c
    dec b
    jr nz, Jump_005_4C2B
    ld c, $00
    ret

Jump_005_4C3D::
    ld c, $FF
    ret

Func_005_4C40:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4C48::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4C53
    call Func_005_6B5F
    jr c, Jump_005_4C5A

Jump_005_4C53::
    inc c
    dec b
    jr nz, Jump_005_4C48
    ld c, $00
    ret

Jump_005_4C5A::
    ld c, $FF
    ret

Func_005_4C5D::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_4C69::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4C71
    inc e
    ld d, c

Jump_005_4C71::
    inc c
    dec b
    jr nz, Jump_005_4C69
    ld a, e
    cp a, $02
    jr nc, Jump_005_4C99
    ld a, d
    call Func_005_4015
    push hl
    ld hl, wD2C1
    ld a, d
    and a, $03
    sla a
    add a, l
    ld l, a
    jr nc, Jump_005_4C8C
    inc h

Jump_005_4C8C::
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    pop hl
    call Func_000_3E7A
    jr nc, Jump_005_4C99
    ld c, $00
    ret

Jump_005_4C99::
    ld c, $FF
    ret

Func_005_4C9C:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_4CE2
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a

Jump_005_4CAF::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4CD6
    ld hl, wD958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_4CBE
    inc h

Jump_005_4CBE::
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    push bc
    farcall Func_016_5A7E
    ld a, c
    pop bc
    or a, a
    jr nz, Jump_005_4CD6
    ld hl, hFFC6
    inc [hl]

Jump_005_4CD6::
    inc c
    dec b
    jr nz, Jump_005_4CAF
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_005_4CE2
    ld c, $00
    ret

Jump_005_4CE2::
    ld c, $FF
    ret

Func_005_4CE5::
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_4D17
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4CF9::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4D0B
    ld a, c
    ld hl, wD812
    call Func_000_3F25
    inc hl
    bit 2, [hl]
    jr nz, Jump_005_4D11

Jump_005_4D0B::
    inc c
    dec b
    jr nz, Jump_005_4CF9
    jr Jump_005_4D14

Jump_005_4D11::
    ld c, $00
    ret

Jump_005_4D14::
    ld c, $FF
    ret

Jump_005_4D17::
    ld c, $01
    ret

Func_005_4D1A:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4D22::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4D3C
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr nz, Jump_005_4D3C
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, Jump_005_4D43

Jump_005_4D3C::
    inc c
    dec b
    jr nz, Jump_005_4D22
    ld c, $00
    ret

Jump_005_4D43::
    ld c, $FF
    ret

Func_005_4D46:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld b, $03
    ld e, $40
    ld hl, wD814
    call Func_005_6FA1
    ret

Func_005_4D56:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD811
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr z, Jump_005_4D67
    ld c, $00
    ret

Jump_005_4D67::
    ld c, $FF
    ret

Func_005_4D6A:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_4D72::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4D9B
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    ld a, [hl+]
    or a, a
    jr nz, Jump_005_4DA2
    ld a, [hl+]
    and a, $C3
    jr nz, Jump_005_4DA2
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    and a, $03
    jr nz, Jump_005_4DA2
    ld a, [hl+]
    and a, $80
    jr nz, Jump_005_4DA2
    inc hl
    ld a, [hl]
    and a, $80
    jr nz, Jump_005_4DA2

Jump_005_4D9B::
    inc c
    dec b
    jr nz, Jump_005_4D72
    ld c, $00
    ret

Jump_005_4DA2::
    ld c, $FF
    ret

Func_005_4DA5:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_4DAF::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4DD8
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    ld a, [hl+]
    and a, $3C
    jr nz, Jump_005_4DF2
    ld a, [hl+]
    and a, $6F
    jr nz, Jump_005_4DF2
    inc hl
    inc hl
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_005_4DF2
    ld a, [hl+]
    and a, $40
    jr nz, Jump_005_4DF2
    inc hl
    ld a, [hl]
    and a, $40
    jr nz, Jump_005_4DF2

Jump_005_4DD8::
    inc c
    dec b
    jr nz, Jump_005_4DAF
    ld a, [wD8A4]
    and a, $04
    or a, $03
    ld hl, wDA63
    add a, l
    ld l, a
    jr nc, Jump_005_4DEB
    inc h

Jump_005_4DEB::
    ld a, [hl]
    or a, a
    jr z, Jump_005_4DF2
    ld c, $00
    ret

Jump_005_4DF2::
    ld c, $FF
    ret

Func_005_4DF5::
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld hl, wC984
    add a, l
    ld l, a
    jr nc, Jump_005_4E04
    inc h

Jump_005_4E04::
    ld a, [hl]
    cp a, $01
    jr nz, Jump_005_4E0C
    ld c, $00
    ret

Jump_005_4E0C::
    ld c, $FF
    ret

Func_005_4E0F:: ; heuristic: follows a terminator; C0
    ld a, [wCFC5]
    cp a, $04
    jr z, Jump_005_4E1A
    cp a, $05
    jr nz, Jump_005_4E1D

Jump_005_4E1A::
    ld c, $00
    ret

Jump_005_4E1D::
    ld c, $FF
    ret

Func_005_4E20:: ; heuristic: follows a terminator; C0
    ld a, [wDAAC]
    and a, a
    jr z, Jump_005_4E45
    cp a, $3D
    jr z, Jump_005_4E42
    cp a, $3E
    jr z, Jump_005_4E42
    cp a, $3F
    jr z, Jump_005_4E42
    cp a, $43
    jr z, Jump_005_4E42
    cp a, $47
    jr z, Jump_005_4E42
    cp a, $66
    jr z, Jump_005_4E42
    cp a, $67
    jr nz, Jump_005_4E45

Jump_005_4E42::
    ld c, $00
    ret

Jump_005_4E45::
    ld c, $FF
    ret

Func_005_4E48::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wD2C1

Jump_005_4E55::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_4E70
    push hl
    push bc
    call Func_005_4E7C
    pop bc
    ld d, h
    ld e, l
    pop hl
    inc hl
    ld a, [hl]
    cp a, d
    jr c, Jump_005_4E70
    dec hl
    ld a, [hl+]
    cp a, e
    jr c, Jump_005_4E70
    jr Jump_005_4E76

Jump_005_4E70::
    inc c
    dec b
    jr nz, Jump_005_4E55
    jr Jump_005_4E79

Jump_005_4E76::
    ld c, $00
    ret

Jump_005_4E79::
    ld c, $FF
    ret

Func_005_4E7C::
    ld a, [wCFEC]
    cp a, $48
    jr z, Jump_005_4EBD
    cp a, $49
    jr z, Jump_005_4F01
    cp a, $4A
    jp z, Jump_005_4F44
    cp a, $4E
    jp z, Jump_005_4F9C
    cp a, $4F
    jp z, Jump_005_4FCB
    cp a, $50
    jp z, Jump_005_5010
    cp a, $51
    jp z, Jump_005_5010
    cp a, $52
    jp z, Jump_005_5010
    cp a, $53
    jp z, Jump_005_5010
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF9]
    add a, l
    ld l, a
    ld a, [wCFF8]
    ld h, a
    ld a, [wCFFA]
    adc a, h
    ld h, a
    ret

Jump_005_4EBD::
    ld a, [wD8A4]
    ld hl, wD8B7
    add a, l
    ld l, a
    jr nc, Jump_005_4EC8
    inc h

Jump_005_4EC8::
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4ED9
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_4EE4

Jump_005_4ED9::
    ld a, l
    add a, $0A
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_005_4EE2
    inc h

Jump_005_4EE2::
    jr Jump_005_4EEC

Jump_005_4EE4::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4EEC
    inc h

Jump_005_4EEC::
    ld a, $73
    call Func_005_5029
    ld a, h
    or a, a
    jr nz, Jump_005_4EFB
    ld a, l
    cp a, $B4
    jp c, Jump_005_4FF9

Jump_005_4EFB::
    ld hl, $00B4
    jp Jump_005_4FF9

Jump_005_4F01::
    ld a, [wD8A4]
    ld hl, wD8B7
    add a, l
    ld l, a
    jr nc, Jump_005_4F0C
    inc h

Jump_005_4F0C::
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4F1D
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_4F27

Jump_005_4F1D::
    ld a, $1E
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_005_4F25
    inc h

Jump_005_4F25::
    jr Jump_005_4F2F

Jump_005_4F27::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4F2F
    inc h

Jump_005_4F2F::
    ld a, $6E
    call Func_005_5029
    ld a, h
    or a, a
    jr nz, Jump_005_4F3E
    ld a, l
    cp a, $96
    jp c, Jump_005_4FF9

Jump_005_4F3E::
    ld hl, $0096
    jp Jump_005_4FF9

Jump_005_4F44::
    ld a, [wD8A4]
    ld hl, wD8B7
    add a, l
    ld l, a
    jr nc, Jump_005_4F4F
    inc h

Jump_005_4F4F::
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4F60
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_4F6A

Jump_005_4F60::
    ld a, $14
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_005_4F68
    inc h

Jump_005_4F68::
    jr Jump_005_4F72

Jump_005_4F6A::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4F72
    inc h

Jump_005_4F72::
    ld a, $6E
    push bc
    call Func_005_5029
    pop bc
    push hl
    call Func_005_5034
    pop hl
    jr z, Jump_005_4F8E
    ld a, h
    or a, a
    jr nz, Jump_005_4F89
    ld a, l
    cp a, $B4
    jr c, Jump_005_4FF9

Jump_005_4F89::
    ld hl, $00B4
    jr Jump_005_4FF9

Jump_005_4F8E::
    ld a, h
    or a, a
    jr nz, Jump_005_4F97
    ld a, l
    cp a, $DC
    jr c, Jump_005_4FF9

Jump_005_4F97::
    ld hl, $00DC
    jr Jump_005_4FF9

Jump_005_4F9C::
    ld a, [wD8A4]
    ld hl, wD8B7
    add a, l
    ld l, a
    jr nc, Jump_005_4FA7
    inc h

Jump_005_4FA7::
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4FB8
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_4FC0

Jump_005_4FB8::
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_005_4FBE
    inc h

Jump_005_4FBE::
    jr Jump_005_4FC8

Jump_005_4FC0::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4FC8
    inc h

Jump_005_4FC8::
    add hl, hl
    jr Jump_005_4FF9

Jump_005_4FCB::
    ld a, [wD8A4]
    ld hl, wD8B7
    add a, l
    ld l, a
    jr nc, Jump_005_4FD6
    inc h

Jump_005_4FD6::
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_4FE7
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_4FEF

Jump_005_4FE7::
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_005_4FED
    inc h

Jump_005_4FED::
    jr Jump_005_4FF7

Jump_005_4FEF::
    ld a, l
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_4FF7
    inc h

Jump_005_4FF7::
    add hl, hl
    add hl, hl

Jump_005_4FF9::
    ld a, c
    cp a, $03
    ld c, $00
    jr z, Jump_005_5028
    cp a, $02
    ld c, $32
    jr z, Jump_005_5028
    cp a, $01
    ld c, $55
    jr z, Jump_005_5028
    ld c, $64
    jr Jump_005_5028

Jump_005_5010::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, c
    cp a, $03
    ld c, $1E
    jr z, Jump_005_5028
    cp a, $02
    ld c, $4B
    jr z, Jump_005_5028
    cp a, $01
    ld c, $73
    jr z, Jump_005_5028
    ld c, $82

Jump_005_5028::
    ld a, c

Func_005_5029::
    ld b, h
    ld c, l
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    ret

Func_005_5034::
    ld a, c
    add a, a
    ld hl, wD958
    add a, l
    ld l, a
    jr nc, Jump_005_503E
    inc h

Jump_005_503E::
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    farcall Func_035_4001
    ld a, [wD008]
    cp a, $09
    ret

Func_005_5052::
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_50B4
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_5062
    inc h

Jump_005_5062::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_507C
    inc h

Jump_005_507C::
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_5081::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5095
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    ld d, a
    ldh a, [hFFC7]
    add a, d
    ldh [hFFC7], a

Jump_005_5095::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_5081
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_005_50B1
    ld b, a
    ldh a, [hFFC6]
    call Func_000_16BF
    ld a, b
    cp a, $02
    jr nc, Jump_005_50B4

Jump_005_50B1::
    ld c, $00
    ret

Jump_005_50B4::
    ld c, $FF
    ret

Func_005_50B7:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_50E0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    call Func_005_6DFF
    push hl
    ld a, [wD8A4]
    and a, $04
    call Func_005_6DFF
    pop bc
    call Func_000_3E7A
    jr nc, Jump_005_50DD
    ld c, $00
    ret

Jump_005_50DD::
    ld c, $FF
    ret

Jump_005_50E0::
    ld c, $01
    ret

Func_005_50E3:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jp c, Jump_005_517A
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_50FF::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5117
    ld hl, hFFC6
    inc [hl]
    ld a, c
    call Func_005_4006
    ldh a, [hFFC7]
    add a, l
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, h
    ldh [hFFC8], a

Jump_005_5117::
    inc c
    dec b
    jr nz, Jump_005_50FF
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    ldh a, [hFFC6]
    call Func_000_16D1
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a

Jump_005_513B::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5152
    call Func_005_4001
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ld hl, hFFC9
    inc [hl]

Jump_005_5152::
    inc c
    dec b
    jr nz, Jump_005_513B
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFC9]
    call Func_000_16D1
    sla l
    rl h
    push hl
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_5177
    jr z, Jump_005_5177
    ld c, $00
    ret

Jump_005_5177::
    ld c, $FF
    ret

Jump_005_517A::
    ld c, $01
    ret

Func_005_517D:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_51E7
    ld a, [wD8A4]
    call Func_005_4001
    add hl, hl
    push hl
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_519E::
    ld a, c
    call Func_000_3E54
    jr nc, Jump_005_51AA
    inc c
    dec b
    jr nz, Jump_005_519E
    jr Jump_005_51E0

Jump_005_51AA::
    call Func_005_4006
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    inc c
    dec b
    jr z, Jump_005_51D2

Jump_005_51B7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_51CE
    call Func_005_4006
    ldh a, [hFFC6]
    sub a, l
    ldh a, [hFFC7]
    sbc a, h
    jr nc, Jump_005_51CE
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a

Jump_005_51CE::
    inc c
    dec b
    jr nz, Jump_005_51B7

Jump_005_51D2::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_51E4
    jr Jump_005_51E1

Jump_005_51E0::
    pop bc

Jump_005_51E1::
    ld c, $00
    ret

Jump_005_51E4::
    ld c, $FF
    ret

Jump_005_51E7::
    ld c, $01
    ret

Func_005_51EA:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_5225
    call Func_005_6CC2
    ld a, [wD8A4]
    call Func_005_4001
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    sla c
    rl b
    call Func_000_3E7A
    jr c, Jump_005_5210
    jr z, Jump_005_5210
    jr Jump_005_5222

Jump_005_5210::
    sra b
    rr c
    sra b
    rr c
    call Func_000_3E7A
    jr nc, Jump_005_521F
    jr Jump_005_5222

Jump_005_521F::
    ld c, $00
    ret

Jump_005_5222::
    ld c, $FF
    ret

Jump_005_5225::
    ld c, $01
    ret

Func_005_5228:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_5272
    call Func_005_6CC2
    ld a, [wD8A4]
    and a, $04
    ld e, a
    ld d, $03

Jump_005_523D::
    ld a, e
    call Func_000_3E54
    jr c, Jump_005_5266
    call Func_005_4001
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    sla c
    rl b
    call Func_000_3E7A
    jr c, Jump_005_5259
    jr z, Jump_005_5259
    jr Jump_005_5266

Jump_005_5259::
    sra b
    rr c
    sra b
    rr c
    call Func_000_3E7A
    jr nc, Jump_005_526C

Jump_005_5266::
    inc e
    dec d
    jr nz, Jump_005_523D
    jr Jump_005_526F

Jump_005_526C::
    ld c, $00
    ret

Jump_005_526F::
    ld c, $FF
    ret

Jump_005_5272::
    ld c, $01
    ret

Func_005_5275:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jp c, Jump_005_5314
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_5291::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_52AE
    call Func_005_6D07
    jr nz, Jump_005_52AE
    ld hl, hFFC6
    inc [hl]
    ld a, c
    call Func_005_4001
    ldh a, [hFFC7]
    add a, l
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, h
    ldh [hFFC8], a

Jump_005_52AE::
    inc c
    dec b
    jr nz, Jump_005_5291
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_005_5311
    call Func_000_16D1
    ld a, l
    ldh [hFFC7], a
    ld a, h
    ldh [hFFC8], a
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a

Jump_005_52D5::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_52EC
    call Func_005_4006
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ld hl, hFFC9
    inc [hl]

Jump_005_52EC::
    inc c
    dec b
    jr nz, Jump_005_52D5
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFC9]
    call Func_000_16D1
    sla l
    rl h
    push hl
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_5311
    jr z, Jump_005_5311
    ld c, $00
    ret

Jump_005_5311::
    ld c, $FF
    ret

Jump_005_5314::
    ld c, $01
    ret

Func_005_5317::
    ldh a, [hFFC6]
    call Func_005_400B
    add hl, hl
    ld a, $03
    call Func_000_16D1
    push hl
    ldh a, [hFFC6]
    call Func_005_4015
    pop bc
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_537F
    ldh a, [hFFC6]
    call Func_005_400B
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_5383
    ldh a, [hFFC6]
    call Func_005_400B
    ld a, $03
    call Func_000_16D1
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_5387
    ldh a, [hFFC6]
    call Func_005_400B
    srl h
    rr l
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_538B
    ldh a, [hFFC6]
    call Func_005_400B
    ld a, $0A
    call Func_000_16D1
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_538F
    jr Jump_005_5393

Jump_005_537F::
    pop hl
    ld c, $00
    ret

Jump_005_5383::
    pop hl
    ld c, $01
    ret

Jump_005_5387::
    pop hl
    ld c, $02
    ret

Jump_005_538B::
    pop hl
    ld c, $03
    ret

Jump_005_538F::
    pop hl
    ld c, $04
    ret

Jump_005_5393::
    pop hl
    ld c, $05
    ret

Func_005_5397:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6BF8
    jr nz, Jump_005_53A2
    ld c, $00
    ret

Jump_005_53A2::
    ld c, $FF
    ret

Func_005_53A5:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_53AF::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_53BB
    call Func_005_6BF8
    jr nz, Jump_005_53BB
    inc d

Jump_005_53BB::
    inc c
    dec b
    jr nz, Jump_005_53AF
    ld a, d
    cp a, $02
    jr c, Jump_005_53C7
    ld c, $00
    ret

Jump_005_53C7::
    ld c, $FF
    ret

Func_005_53CA::
    ld a, [wD8A4]
    ld hl, wD80D
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    jr nz, Jump_005_53E0
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, Jump_005_53E3

Jump_005_53E0::
    ld c, $00
    ret

Jump_005_53E3::
    ld c, $FF
    ret

Func_005_53E6:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD810
    call Func_000_3F25
    ld a, [hl]
    and a, $30
    jr z, Jump_005_53F7
    ld c, $00
    ret

Jump_005_53F7::
    ld c, $FF
    ret

Func_005_53FA:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_544C
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_540E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5440
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_005_5440
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_5429
    inc h

Jump_005_5429::
    ld d, $08

Jump_005_542B::
    ld a, [hl+]
    cp a, $42
    jr z, Jump_005_5446
    cp a, $43
    jr z, Jump_005_5446
    cp a, $46
    jr z, Jump_005_5446
    cp a, $47
    jr z, Jump_005_5446
    inc hl
    dec d
    jr nz, Jump_005_542B

Jump_005_5440::
    inc c
    dec b
    jr nz, Jump_005_540E
    jr Jump_005_5449

Jump_005_5446::
    ld c, $00
    ret

Jump_005_5449::
    ld c, $FF
    ret

Jump_005_544C::
    ld c, $01
    ret

Func_005_544F:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jp c, Jump_005_54FA
    ld a, [wD8A4]
    call Func_005_400B
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [wD8A4]
    call Func_005_4010
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, [wD8A4]
    call Func_005_4001
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld a, [wD8A4]
    call Func_005_4006
    ld a, l
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCD], a
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld e, a
    ld d, $03

Jump_005_5494::
    xor a, a
    ldh [hFFCE], a
    ld a, e
    call Func_000_3E54
    jr c, Jump_005_54EE
    call Func_005_400B
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_005_54AF
    ld hl, hFFCE
    inc [hl]

Jump_005_54AF::
    ld a, e
    call Func_005_4010
    ldh a, [hFFC8]
    ld c, a
    ldh a, [hFFC9]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_005_54C2
    ld hl, hFFCE
    inc [hl]

Jump_005_54C2::
    ld a, e
    call Func_005_4001
    ldh a, [hFFCA]
    ld c, a
    ldh a, [hFFCB]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_005_54D5
    ld hl, hFFCE
    inc [hl]

Jump_005_54D5::
    ld a, e
    call Func_005_4006
    ldh a, [hFFCC]
    ld c, a
    ldh a, [hFFCD]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_005_54E8
    ld hl, hFFCE
    inc [hl]

Jump_005_54E8::
    ldh a, [hFFCE]
    cp a, $03
    jr nc, Jump_005_54F4

Jump_005_54EE::
    inc e
    dec d
    jr nz, Jump_005_5494
    jr Jump_005_54F7

Jump_005_54F4::
    ld c, $00
    ret

Jump_005_54F7::
    ld c, $FF
    ret

Jump_005_54FA::
    ld c, $01
    ret

Func_005_54FD::
    ld c, $00
    ret

Func_005_5500:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_557B
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld a, c
    swap a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_551F
    inc h

Jump_005_551F::
    ld d, $08

Jump_005_5521::
    ld a, [hl+]
    cp a, $3D
    jr z, Jump_005_5530
    inc hl
    dec d
    jr nz, Jump_005_5521

Jump_005_552A::
    inc c
    dec b
    jr nz, Jump_005_551F
    jr Jump_005_5578

Jump_005_5530::
    ld a, c
    ld hl, wD8DF
    call Func_005_401A
    add hl, hl
    push hl
    ld a, c
    ld hl, wD8B7
    add a, l
    ld l, a
    jr nc, Jump_005_5542
    inc h

Jump_005_5542::
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    pop hl
    add hl, de
    push bc
    push hl
    ld a, [wD8A4]
    sla a
    ld hl, wD8BF
    add a, l
    ld l, a
    jr nc, Jump_005_555B
    inc h

Jump_005_555B::
    ld a, [hl+]
    ld e, a
    ld b, [hl]
    ld c, e
    pop hl
    call Func_000_3E7A
    jr nc, Jump_005_5574
    pop bc
    ld a, c
    inc a
    sla a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_5572
    inc h

Jump_005_5572::
    jr Jump_005_552A

Jump_005_5574::
    pop bc
    ld c, $00
    ret

Jump_005_5578::
    ld c, $FF
    ret

Jump_005_557B::
    ld c, $01
    ret

Func_005_557E::
    call Func_005_4E48
    ld a, c
    and a, a
    jr z, Jump_005_5588
    ld c, $00
    ret

Jump_005_5588::
    ld c, $FF
    ret

Func_005_558B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_4010
    ld b, h
    ld c, l
    add hl, hl
    add hl, bc
    push hl
    ld a, [wD8A4]
    call Func_005_401A
    add hl, hl
    add hl, hl
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_55A7
    ld c, $00
    ret

Jump_005_55A7::
    ld c, $FF
    ret

Func_005_55AA:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call Func_000_3F25
    ld a, [hl]
    and a, $22
    jr z, Jump_005_55BB
    ld c, $00
    ret

Jump_005_55BB::
    ld c, $FF
    ret

Func_005_55BE::
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_55F0
    cp a, $02
    jr z, Jump_005_55F0
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_55F0
    bit 6, [hl]
    jr z, Jump_005_55F0
    inc hl
    bit 6, [hl]
    jr z, Jump_005_55ED
    ld a, [wD8A4]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_55E9
    inc h

Jump_005_55E9::
    bit 6, [hl]
    jr z, Jump_005_55F0

Jump_005_55ED::
    ld c, $00
    ret

Jump_005_55F0::
    ld c, $FF
    ret

Func_005_55F3:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_5625
    cp a, $02
    jr z, Jump_005_5625
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_5625
    bit 5, [hl]
    jr z, Jump_005_5625
    inc hl
    bit 5, [hl]
    jr z, Jump_005_5622
    ld a, [wD8A4]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_561E
    inc h

Jump_005_561E::
    bit 5, [hl]
    jr z, Jump_005_5625

Jump_005_5622::
    ld c, $00
    ret

Jump_005_5625::
    ld c, $FF
    ret

Func_005_5628:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_565A
    cp a, $02
    jr z, Jump_005_565A
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_565A
    bit 4, [hl]
    jr z, Jump_005_565A
    inc hl
    bit 4, [hl]
    jr z, Jump_005_5657
    ld a, [wD8A4]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_5653
    inc h

Jump_005_5653::
    bit 4, [hl]
    jr z, Jump_005_565A

Jump_005_5657::
    ld c, $00
    ret

Jump_005_565A::
    ld c, $FF
    ret

Func_005_565D:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_568F
    cp a, $02
    jr z, Jump_005_568F
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_568F
    bit 3, [hl]
    jr z, Jump_005_568F
    inc hl
    bit 3, [hl]
    jr z, Jump_005_568C
    ld a, [wD8A4]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_5688
    inc h

Jump_005_5688::
    bit 3, [hl]
    jr z, Jump_005_568F

Jump_005_568C::
    ld c, $00
    ret

Jump_005_568F::
    ld c, $FF
    ret

Func_005_5692:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_56C4
    cp a, $02
    jr z, Jump_005_56C4
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_56C4
    bit 2, [hl]
    jr z, Jump_005_56C4
    inc hl
    bit 2, [hl]
    jr z, Jump_005_56C1
    ld a, [wD8A4]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_56BD
    inc h

Jump_005_56BD::
    bit 2, [hl]
    jr z, Jump_005_56C4

Jump_005_56C1::
    ld c, $00
    ret

Jump_005_56C4::
    ld c, $FF
    ret

Func_005_56C7:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_56F9
    cp a, $02
    jr z, Jump_005_56F9
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_56F9
    bit 1, [hl]
    jr z, Jump_005_56F9
    inc hl
    bit 1, [hl]
    jr z, Jump_005_56F6
    ld a, [wD8A4]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_56F2
    inc h

Jump_005_56F2::
    bit 1, [hl]
    jr z, Jump_005_56F9

Jump_005_56F6::
    ld c, $00
    ret

Jump_005_56F9::
    ld c, $FF
    ret

Func_005_56FC:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_572E
    cp a, $02
    jr z, Jump_005_572E
    ld hl, wD044
    bit 7, [hl]
    jr z, Jump_005_572E
    bit 0, [hl]
    jr z, Jump_005_572E
    inc hl
    bit 0, [hl]
    jr z, Jump_005_572B
    ld a, [wD8A4]
    ld hl, wD057
    and a, $04
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_005_5727
    inc h

Jump_005_5727::
    bit 0, [hl]
    jr z, Jump_005_572E

Jump_005_572B::
    ld c, $00
    ret

Jump_005_572E::
    ld c, $FF
    ret

Func_005_5731::
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_5755
    cp a, $02
    jr z, Jump_005_5755
    ld hl, wD04B
    bit 7, [hl]
    jr z, Jump_005_5755
    ld a, [hl]
    and a, $7F
    ld b, a
    ld a, [wD891]
    sub a, b
    bit 7, a
    jr nz, Jump_005_5752
    cp a, $04
    jr nc, Jump_005_5755

Jump_005_5752::
    ld c, $00
    ret

Jump_005_5755::
    ld c, $FF
    ret

Func_005_5758:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5761::
    ld a, c
    call Func_000_3E54
    jr nc, Jump_005_576D
    ld a, c
    cp a, e
    jr z, Jump_005_577C
    jr Jump_005_5771

Jump_005_576D::
    ld a, c
    cp a, e
    jr nz, Jump_005_577C

Jump_005_5771::
    inc c
    dec b
    jr nz, Jump_005_5761
    call Func_005_577F
    ret
    db $0E, $00, $C9

Jump_005_577C::
    ld c, $FF
    ret

Func_005_577F::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_578B::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5792
    inc e

Jump_005_5792::
    inc c
    dec b
    jr nz, Jump_005_578B
    ld a, e
    cp a, $02
    jr c, Jump_005_579E
    ld c, $00
    ret

Jump_005_579E::
    ld c, $FF
    ret

Func_005_57A1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_57CC
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_57B5::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_57C0
    call Func_005_6D1A
    jr nz, Jump_005_57C6

Jump_005_57C0::
    inc c
    dec b
    jr nz, Jump_005_57B5
    jr Jump_005_57C9

Jump_005_57C6::
    ld c, $00
    ret

Jump_005_57C9::
    ld c, $FF
    ret

Jump_005_57CC::
    ld c, $01
    ret

Func_005_57CF::
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_5800
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_57E3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_57F4
    ld a, c
    ld hl, wD812
    call Func_000_3F25
    bit 3, [hl]
    jr nz, Jump_005_57FA

Jump_005_57F4::
    inc c
    dec b
    jr nz, Jump_005_57E3
    jr Jump_005_57FD

Jump_005_57FA::
    ld c, $00
    ret

Jump_005_57FD::
    ld c, $FF
    ret

Jump_005_5800::
    ld c, $01
    ret

Func_005_5803:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_400B
    ld a, $0A
    call Func_000_16D1
    push hl
    ld a, [wD8A4]
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_581D
    jr Jump_005_585A

Jump_005_581D::
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5826::
    ld a, c
    cp a, e
    jr z, Jump_005_5830
    ld a, c
    call Func_000_3E54
    jr nc, Jump_005_5836

Jump_005_5830::
    inc c
    dec b
    jr nz, Jump_005_5826
    jr Jump_005_585A

Jump_005_5836::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5840::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5853
    ld a, c
    ld hl, wDA75
    call Func_005_6F60
    and a, $03
    cp a, $02
    jr nc, Jump_005_585A

Jump_005_5853::
    inc c
    dec b
    jr nz, Jump_005_5840
    ld c, $00
    ret

Jump_005_585A::
    ld c, $FF
    ret

Func_005_585D:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_586E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5882
    call Func_005_4001
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_5882::
    inc c
    dec b
    jr nz, Jump_005_586E
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call Func_000_16D1
    add hl, hl
    push hl
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_58A1::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_58B5
    call Func_005_4006
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_58B5::
    inc c
    dec b
    jr nz, Jump_005_58A1
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call Func_000_16D1
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E7A
    jr c, Jump_005_5916
    jr z, Jump_005_5916
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    push hl
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_58E3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_58F7
    call Func_005_400B
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_58F7::
    inc c
    dec b
    jr nz, Jump_005_58E3
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    srl h
    rr l
    call Func_000_16D1
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E7A
    jr c, Jump_005_5916
    jr z, Jump_005_5916
    ld c, $00
    ret

Jump_005_5916::
    ld c, $FF
    ret

Func_005_5919:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jp c, Jump_005_59BA
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00

Jump_005_592F::
    ld a, c
    cp a, e
    jr z, Jump_005_595C
    call Func_000_3E54
    jr nc, Jump_005_595C
    jr z, Jump_005_595C
    inc d
    inc c
    dec b
    jr nz, Jump_005_592F
    ld a, d
    cp a, $01
    jr nz, Jump_005_59B7
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    ld l, $00

Jump_005_5951::
    ld a, c
    cp a, e
    jr z, Jump_005_595C
    call Func_000_3E54
    jr c, Jump_005_595C
    inc d
    ld l, c

Jump_005_595C::
    inc c
    dec b
    jr nz, Jump_005_5951
    ld a, d
    cp a, $01
    jr nz, Jump_005_59B7
    ld e, l
    ld a, l
    call Func_005_401A
    ld a, h
    and a, a
    jr nz, Jump_005_59B7
    ld a, l
    cp a, $14
    jr c, Jump_005_5977
    jr z, Jump_005_5977
    jr Jump_005_59B7

Jump_005_5977::
    ld a, e
    swap a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_5982
    inc h

Jump_005_5982::
    ld b, $08

Jump_005_5984::
    ld a, [hl+]
    cp a, $A0
    jr z, Jump_005_59B4
    inc hl
    dec b
    jr nz, Jump_005_5984
    ld a, e
    ld hl, wD80D
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_005_59B7
    ld a, e
    swap a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_59A3
    inc h

Jump_005_59A3::
    ld b, $08

Jump_005_59A5::
    ld a, [hl+]
    cp a, $1E
    jr z, Jump_005_59B4
    cp a, $1F
    jr z, Jump_005_59B4
    inc hl
    dec b
    jr nz, Jump_005_59A5
    jr Jump_005_59B7

Jump_005_59B4::
    ld c, $00
    ret

Jump_005_59B7::
    ld c, $FF
    ret

Jump_005_59BA::
    ld c, $01
    ret

Func_005_59BD:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_5A30
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_59D0::
    ld a, c
    cp a, e
    jr z, Jump_005_59D9
    call Func_000_3E25
    jr nc, Jump_005_59DF

Jump_005_59D9::
    inc c
    dec b
    jr nz, Jump_005_59D0
    jr Jump_005_5A2D

Jump_005_59DF::
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_005_59D9
    ld a, c
    swap a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_59F5
    inc h

Jump_005_59F5::
    ld d, $08

Jump_005_59F7::
    ld a, [hl+]
    cp a, $16
    jr z, Jump_005_5A12
    cp a, $17
    jr z, Jump_005_5A12
    cp a, $18
    jr z, Jump_005_5A12
    cp a, $19
    jr z, Jump_005_5A12
    cp a, $1A
    jr z, Jump_005_5A12
    inc hl
    dec d
    jr nz, Jump_005_59F7
    jr Jump_005_5A2D

Jump_005_5A12::
    ld hl, Func_005_5A33
    sub a, $16
    add a, l
    ld l, a
    jr nc, Jump_005_5A1C
    inc h

Jump_005_5A1C::
    ld a, [hl]
    ld d, a
    ld a, c
    call Func_005_401A
    ld a, h
    and a, a
    jr nz, Jump_005_59D9
    ld a, l
    cp a, d
    jr nc, Jump_005_59D9
    ld c, $00
    ret

Jump_005_5A2D::
    ld c, $FF
    ret

Jump_005_5A30::
    ld c, $01
    ret

Func_005_5A33:: ; heuristic: follows a terminator; C0
    ld [bc], a
    dec b
    rlca
    ld [de], a
    inc h
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_5A70
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5A4B::
    ld a, c
    cp a, e
    jr z, Jump_005_5A54
    call Func_000_3E25
    jr nc, Jump_005_5A5A

Jump_005_5A54::
    inc c
    dec b
    jr nz, Jump_005_5A4B
    jr Jump_005_5A6D

Jump_005_5A5A::
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_005_5A54
    call Func_005_6D1A
    jr z, Jump_005_5A54
    ld c, $00
    ret

Jump_005_5A6D::
    ld c, $FF
    ret

Jump_005_5A70::
    ld c, $01
    ret

Func_005_5A73:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_5AF5
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5A85::
    ld a, [wD8A4]
    ld e, a
    ld a, c
    cp a, e
    jr z, Jump_005_5A92
    call Func_000_3E25
    jr nc, Jump_005_5A98

Jump_005_5A92::
    inc c
    dec b
    jr nz, Jump_005_5A85
    jr Jump_005_5AF2

Jump_005_5A98::
    ld a, c
    swap a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_5AA3
    inc h

Jump_005_5AA3::
    ld d, $08

Jump_005_5AA5::
    ld a, [hl+]
    ld e, $00
    cp a, $4D
    jr z, Jump_005_5ACB
    inc e
    cp a, $3D
    jr z, Jump_005_5ACB
    inc e
    cp a, $3E
    jr z, Jump_005_5ACB
    inc e
    cp a, $3F
    jr z, Jump_005_5ACB
    inc e
    cp a, $66
    jr z, Jump_005_5ACB
    inc e
    cp a, $67
    jr z, Jump_005_5ACB

Jump_005_5AC5::
    inc hl
    dec d
    jr nz, Jump_005_5AA5
    jr Jump_005_5AF2

Jump_005_5ACB::
    push hl
    push bc
    ld hl, Func_005_5AF8
    ld a, e
    add a, l
    ld l, a
    jr nc, Jump_005_5AD6
    inc h

Jump_005_5AD6::
    ld a, [hl]
    push de
    ld d, a
    ld a, c
    call Func_005_401A
    ld a, h
    and a, a
    jr nz, Jump_005_5AEA
    ld a, l
    cp a, d
    jr nc, Jump_005_5AEA
    pop de
    pop bc
    pop hl
    jr Jump_005_5AEF

Jump_005_5AEA::
    pop de
    pop bc
    pop hl
    jr Jump_005_5AC5

Jump_005_5AEF::
    ld c, $00
    ret

Jump_005_5AF2::
    ld c, $FF
    ret

Jump_005_5AF5::
    ld c, $01
    ret

Func_005_5AF8:: ; heuristic: follows a terminator; C0
    rrca
    ld bc, $191E
    inc d
    inc d
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_5B54
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5B11::
    ld a, c
    cp a, e
    jr z, Jump_005_5B1A
    call Func_000_3E25
    jr nc, Jump_005_5B20

Jump_005_5B1A::
    inc c
    dec b
    jr nz, Jump_005_5B11
    jr Jump_005_5B51

Jump_005_5B20::
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_005_5B1A
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_5B35
    inc h

Jump_005_5B35::
    ld d, $08

Jump_005_5B37::
    ld a, [hl+]
    cp a, $42
    jr z, Jump_005_5B4E
    cp a, $43
    jr z, Jump_005_5B4E
    cp a, $46
    jr z, Jump_005_5B4E
    cp a, $47
    jr z, Jump_005_5B4E
    inc hl
    dec d
    jr nz, Jump_005_5B37
    jr Jump_005_5B1A

Jump_005_5B4E::
    ld c, $00
    ret

Jump_005_5B51::
    ld c, $FF
    ret

Jump_005_5B54::
    ld c, $01
    ret

Func_005_5B57:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_5BB9
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5B6A::
    ld a, c
    cp a, e
    jr z, Jump_005_5B73
    call Func_000_3E25
    jr nc, Jump_005_5B79

Jump_005_5B73::
    inc c
    dec b
    jr nz, Jump_005_5B6A
    jr Jump_005_5BB6

Jump_005_5B79::
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 6, [hl]
    jr z, Jump_005_5B73
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_5B8E
    inc h

Jump_005_5B8E::
    ld d, $08

Jump_005_5B90::
    ld a, [hl+]
    cp a, $78
    jr z, Jump_005_5BB3
    cp a, $79
    jr z, Jump_005_5BB3
    cp a, $7A
    jr z, Jump_005_5BB3
    cp a, $7B
    jr z, Jump_005_5BB3
    cp a, $7C
    jr z, Jump_005_5BB3
    cp a, $7D
    jr z, Jump_005_5BB3
    cp a, $92
    jr z, Jump_005_5BB3
    inc hl
    dec d
    jr nz, Jump_005_5B90
    jr Jump_005_5B73

Jump_005_5BB3::
    ld c, $00
    ret

Jump_005_5BB6::
    ld c, $FF
    ret

Jump_005_5BB9::
    ld c, $01
    ret

Func_005_5BBC::
    ld a, [wD8A4]
    call Func_005_400B
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [wD8A4]
    call Func_005_4010
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, [wD8A4]
    call Func_005_4001
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld a, [wD8A4]
    call Func_005_4006
    ld a, l
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCD], a
    ld a, [wD8A4]
    call Func_005_401F
    ld a, l
    ldh [hFFCE], a
    ld a, h
    ldh [hFFCF], a
    ld e, $00
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld bc, $03E7
    call Func_000_3E7A
    jr c, Jump_005_5C09
    inc e

Jump_005_5C09::
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ld bc, $012C
    call Func_000_3E7A
    jr c, Jump_005_5C18
    inc e

Jump_005_5C18::
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ld bc, $012C
    call Func_000_3E7A
    jr c, Jump_005_5C27
    inc e

Jump_005_5C27::
    ldh a, [hFFCC]
    ld l, a
    ldh a, [hFFCD]
    ld h, a
    ld bc, $00C8
    call Func_000_3E7A
    jr c, Jump_005_5C36
    inc e

Jump_005_5C36::
    ldh a, [hFFCE]
    ld l, a
    ldh a, [hFFCF]
    ld h, a
    ld bc, $011E
    call Func_000_3E7A
    jr c, Jump_005_5C45
    inc e

Jump_005_5C45::
    ld a, e
    cp a, $03
    jr c, Jump_005_5C4D
    ld c, $00
    ret

Jump_005_5C4D::
    ld c, $FF
    ret

Func_005_5C50:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    swap a
    ld hl, wD989
    add a, l
    ld l, a
    jr nc, Jump_005_5C5D
    inc h

Jump_005_5C5D::
    ld b, $08

Jump_005_5C5F::
    ld a, [hl+]
    cp a, $83
    jr z, Jump_005_5C89
    inc hl
    dec b
    jr nz, Jump_005_5C5F
    ld a, [wD8A4]
    and a, $04
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5C72::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5C80
    call Func_005_6E30
    ld a, d
    cp a, $01
    jr nc, Jump_005_5C86

Jump_005_5C80::
    inc c
    dec b
    jr nz, Jump_005_5C72
    jr Jump_005_5C89

Jump_005_5C86::
    ld c, $00
    ret

Jump_005_5C89::
    ld c, $FF
    ret

Func_005_5C8C:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5C96::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5CC1
    and a, $03
    ld hl, wD2C1
    sla a
    add a, l
    ld l, a
    jr nc, Jump_005_5CA8
    inc h

Jump_005_5CA8::
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c
    call Func_005_701B
    pop bc
    push bc
    push hl
    ld a, c
    call Func_005_4015
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E7A
    jr nc, Jump_005_5CC7
    pop bc

Jump_005_5CC1::
    inc c
    dec b
    jr nz, Jump_005_5C96
    jr Jump_005_5CCB

Jump_005_5CC7::
    pop bc
    ld c, $00
    ret

Jump_005_5CCB::
    ld c, $FF
    ret

Func_005_5CCE::
    ld a, [wCFC5]
    cp a, $02
    jr z, Jump_005_5CDB
    cp a, $03
    jr z, Jump_005_5CDB
    jr Jump_005_5CDE

Jump_005_5CDB::
    ld c, $00
    ret

Jump_005_5CDE::
    ld c, $FF
    ret

Func_005_5CE1:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    and a, a
    jr z, Jump_005_5CEE
    cp a, $02
    jr z, Jump_005_5CEE
    ld c, $00
    ret

Jump_005_5CEE::
    ld c, $FF
    ret

Func_005_5CF1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_5CFD
    ld a, [wC984]
    jr Jump_005_5D00

Jump_005_5CFD::
    ld a, [wC985]

Jump_005_5D00::
    cp a, $01
    jr z, Jump_005_5D1D
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5D0D::
    ld a, c
    cp a, e
    jr z, Jump_005_5D16
    call Func_000_3E54
    jr nc, Jump_005_5D1D

Jump_005_5D16::
    inc c
    dec b
    jr nz, Jump_005_5D0D
    ld c, $00
    ret

Jump_005_5D1D::
    ld c, $FF
    ret

Func_005_5D20:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wD80E
    ld e, $04
    call Func_005_6FA1
    ret

Func_005_5D31:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wD80E
    ld e, $04
    call Func_005_6FA1
    ret

Func_005_5D44:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_5D86
    ld a, [wD8A4]
    call Func_005_4015
    ld c, l
    ld b, h
    sra h
    rr l
    add hl, bc
    ld d, h
    ld e, l
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5D67::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5D7A
    call Func_005_4015
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    bit 7, h
    jr z, Jump_005_5D80

Jump_005_5D7A::
    inc c
    dec b
    jr nz, Jump_005_5D67
    jr Jump_005_5D83

Jump_005_5D80::
    ld c, $00
    ret

Jump_005_5D83::
    ld c, $FF
    ret

Jump_005_5D86::
    ld c, $01
    ret

Func_005_5D89:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_5D98
    ldh a, [hFF8C]
    bit 3, a
    jr z, Jump_005_5D98
    ld c, $00
    ret

Jump_005_5D98::
    ld c, $FF
    ret

Func_005_5D9B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5DA5::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5DC3
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_005_5DC3
    ld a, c
    ld hl, wDA74
    call Func_005_6F60
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_5DCA

Jump_005_5DC3::
    inc c
    dec b
    jr nz, Jump_005_5DA5
    ld c, $00
    ret

Jump_005_5DCA::
    ld c, $FF
    ret

Func_005_5DCD:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5DD7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5DF5
    ld a, c
    ld hl, wD80F
    call Func_000_3F25
    ld a, [hl]
    and a, a
    jr nz, Jump_005_5DF5
    ld a, c
    ld hl, wDA77
    call Func_005_6F60
    and a, $0C
    cp a, $0C
    jr nz, Jump_005_5DFC

Jump_005_5DF5::
    inc c
    dec b
    jr nz, Jump_005_5DD7
    ld c, $00
    ret

Jump_005_5DFC::
    ld c, $FF
    ret

Func_005_5DFF:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld de, wDA74
    add a, a
    add a, c
    add a, a
    add a, c
    add a, e
    ld e, a
    jr nc, Jump_005_5E15
    inc d

Jump_005_5E15::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5E2D
    ld a, c
    ld hl, wD814
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_005_5E2D
    ld a, [de]
    and a, $30
    cp a, $30
    jr nz, Jump_005_5E3C

Jump_005_5E2D::
    ld a, e
    add a, $07
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc c
    dec b
    jr nz, Jump_005_5E15
    ld c, $00
    ret

Jump_005_5E3C::
    ld c, $FF
    ret

Func_005_5E3F:: ; heuristic: follows a terminator; C0
    ld a, [wD891]
    and a, a
    jr nz, Jump_005_5E48
    ld c, $00
    ret

Jump_005_5E48::
    ld c, $FF
    ret

Func_005_5E4B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld hl, wD810
    ld e, $0C
    call Func_005_6FA1
    ld a, c
    or a, a
    ret z
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld hl, wD80F
    ld e, $C0
    call Func_005_6FA1
    ret

Func_005_5E6F:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5E79::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5E97
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    bit 4, [hl]
    jr nz, Jump_005_5E97
    ld a, c
    ld hl, wDA75
    call Func_005_6F60
    and a, $C0
    cp a, $C0
    jr nz, Jump_005_5E9E

Jump_005_5E97::
    inc c
    dec b
    jr nz, Jump_005_5E79
    ld c, $00
    ret

Jump_005_5E9E::
    ld c, $FF
    ret

Func_005_5EA1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_5EAB::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_5EC4
    ld a, c
    ld hl, wD80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_005_5ECB
    inc hl
    inc hl
    ld a, [hl]
    and a, $3F
    jr nz, Jump_005_5ECB

Jump_005_5EC4::
    inc c
    dec b
    jr nz, Jump_005_5EAB
    ld c, $FF
    ret

Jump_005_5ECB::
    ld c, $00
    ret

Func_005_5ECE::
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $04
    jr c, Jump_005_5F10
    ld a, [wD2CC]
    or a, a
    jr z, Jump_005_5F0A
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld de, wDA5B
    add a, e
    ld e, a
    jr nc, Jump_005_5EED
    inc d

Jump_005_5EED::
    ld c, a
    ld b, $03

Jump_005_5EF0::
    ld a, c
    call Func_000_3E25
    jr c, Jump_005_5F05
    ld a, [de]
    cp a, $02
    jr nz, Jump_005_5F05
    call Func_005_5F13
    jr nz, Jump_005_5F05
    call Func_005_5F2A
    jr nz, Jump_005_5F0D

Jump_005_5F05::
    inc de
    inc c
    dec b
    jr nz, Jump_005_5EF0

Jump_005_5F0A::
    ld c, $FF
    ret

Jump_005_5F0D::
    ld c, $00
    ret

Jump_005_5F10::
    ld c, $01
    ret

Func_005_5F13::
    ld a, c
    ld hl, wDA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_5F1D
    inc h

Jump_005_5F1D::
    ld a, [hl]
    cp a, $9C
    ret z
    cp a, $33
    ret z
    cp a, $92
    ret z
    cp a, $93
    ret

Func_005_5F2A::
    ld a, c
    ld hl, wDA77
    add a, a
    add a, c
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_005_5F37
    inc h

Jump_005_5F37::
    ld a, [hl]
    and a, $0C
    cp a, $0C
    ret

Func_005_5F3D:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $04
    jr c, Jump_005_5F8A
    ld a, [wD2CC]
    or a, a
    jr z, Jump_005_5F84
    ld a, [wD8A4]
    ld d, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5F56::
    ld a, c
    cp a, d
    jr z, Jump_005_5F80
    ld a, c
    call Func_000_3E25
    jr c, Jump_005_5F80
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 2, [hl]
    jr nz, Jump_005_5F80
    ld a, c
    ld hl, wDA5B
    add a, l
    ld l, a
    jr nc, Jump_005_5F74
    inc h

Jump_005_5F74::
    ld a, [hl]
    cp a, $03
    jr nc, Jump_005_5F80
    push de
    call Func_005_5F8D
    pop de
    jr nc, Jump_005_5F87

Jump_005_5F80::
    inc c
    dec b
    jr nz, Jump_005_5F56

Jump_005_5F84::
    ld c, $FF
    ret

Jump_005_5F87::
    ld c, $00
    ret

Jump_005_5F8A::
    ld c, $01
    ret

Func_005_5F8D::
    ld a, c
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_5F98
    inc h

Jump_005_5F98::
    ld e, $08

Jump_005_5F9A::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_5FAB
    cp a, $63
    jr z, Jump_005_5FAD
    cp a, $64
    jr z, Jump_005_5FB1

Jump_005_5FA7::
    inc hl
    dec e
    jr nz, Jump_005_5F9A

Jump_005_5FAB::
    scf
    ret

Jump_005_5FAD::
    ld d, $03
    jr Jump_005_5FB3

Jump_005_5FB1::
    ld d, $06

Jump_005_5FB3::
    push hl
    ld a, c
    ld hl, wD8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_5FBE
    inc h

Jump_005_5FBE::
    ld a, [hl+]
    sub a, d
    ld a, [hl]
    sbc a, $00
    pop hl
    jr c, Jump_005_5FA7
    ret

Func_005_5FC7::
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $04
    jr c, Jump_005_600B
    ld a, [wD2CC]
    or a, a
    jr z, Jump_005_6005
    ld a, [wD8A4]
    ld d, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_5FE0::
    ld a, c
    cp a, d
    jr z, Jump_005_6001
    call Func_000_3E25
    jr c, Jump_005_6001
    ld a, c
    ld hl, wDA5B
    add a, l
    ld l, a
    jr nc, Jump_005_5FF2
    inc h

Jump_005_5FF2::
    ld a, [hl]
    cp a, $03
    jr nc, Jump_005_6001
    call Func_005_600E
    jr c, Jump_005_6001
    call Func_005_6039
    jr nz, Jump_005_6008

Jump_005_6001::
    inc c
    dec b
    jr nz, Jump_005_5FE0

Jump_005_6005::
    ld c, $FF
    ret

Jump_005_6008::
    ld c, $00
    ret

Jump_005_600B::
    ld c, $01
    ret

Func_005_600E::
    ld a, c
    ld hl, wD8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6018
    inc h

Jump_005_6018::
    ld a, [hl+]
    sub a, $03
    ld a, [hl]
    sbc a, $00
    ret c
    ld a, c
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_602A
    inc h

Jump_005_602A::
    ld e, $08

Jump_005_602C::
    ld a, [hl+]
    cp a, $6B
    jr z, Jump_005_6037
    inc hl
    dec e
    jr nz, Jump_005_602C
    dec e
    ret

Jump_005_6037::
    xor a, a
    ret

Func_005_6039::
    ld a, c
    ld hl, wDA77
    add a, a
    add a, c
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_005_6046
    inc h

Jump_005_6046::
    ld a, [hl]
    and a, $0C
    cp a, $0C
    ret

Func_005_604C:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $04
    jr c, Jump_005_60B7
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6060::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6087
    ld a, c
    ld hl, wD8BF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6070
    inc h

Jump_005_6070::
    ld e, [hl]
    inc hl
    ld d, [hl]
    sla e
    rl d
    ld a, c
    ld hl, wD8CF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6081
    inc h

Jump_005_6081::
    ld a, [hl+]
    sub a, e
    ld a, [hl]
    sbc a, d
    jr nc, Jump_005_608D

Jump_005_6087::
    inc c
    dec b
    jr nz, Jump_005_6060
    jr Jump_005_60B1

Jump_005_608D::
    ld a, c
    and a, $04
    ld c, a
    ld b, $03

Jump_005_6093::
    ld a, c
    call Func_000_3E25
    jr c, Jump_005_60AD
    ld hl, wD978
    add a, l
    ld l, a
    jr nc, Jump_005_60A1
    inc h

Jump_005_60A1::
    ld a, [hl]
    cp a, $C0
    jr c, Jump_005_60AD
    push bc
    call Func_005_60BA
    pop bc
    jr nc, Jump_005_60B4

Jump_005_60AD::
    inc c
    dec b
    jr nz, Jump_005_6093

Jump_005_60B1::
    ld c, $FF
    ret

Jump_005_60B4::
    ld c, $00
    ret

Jump_005_60B7::
    ld c, $01
    ret

Func_005_60BA::
    ld a, c
    ld hl, wDA1D
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_60C5
    inc h

Jump_005_60C5::
    ld b, $08

Jump_005_60C7::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_60ED
    ld e, a
    cp a, $16
    jr c, Jump_005_60E9
    ld d, $1B
    cp a, $1B
    jr c, Jump_005_60EF
    ld d, $05
    cp a, $7B
    jr z, Jump_005_60FA
    ld d, $06
    cp a, $7C
    jr z, Jump_005_60FA
    ld d, $07
    cp a, $A1
    jr z, Jump_005_6101

Jump_005_60E9::
    inc hl
    dec b
    jr nz, Jump_005_60C7

Jump_005_60ED::
    scf
    ret

Jump_005_60EF::
    push hl
    call Func_005_6127
    pop hl
    jr nz, Jump_005_60E9
    ld a, e
    sub a, d
    jr Jump_005_6102

Jump_005_60FA::
    push hl
    call Func_005_6141
    pop hl
    jr nz, Jump_005_60E9

Jump_005_6101::
    ld a, d

Jump_005_6102::
    ld d, a
    ld a, [wDAAC]
    cp a, e
    jr z, Jump_005_60E9
    ld a, d
    push hl
    ld hl, Data_005_614B
    add a, l
    ld l, a
    jr nc, Jump_005_6113
    inc h

Jump_005_6113::
    ld d, [hl]
    ld a, c
    ld hl, wD8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_611E
    inc h

Jump_005_611E::
    ld a, [hl+]
    sub a, d
    ld a, [hl]
    sbc a, $00
    pop hl
    jr c, Jump_005_60E9
    ret

Func_005_6127::
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 0, [hl]
    ret nz
    ld a, c
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add a, l
    ld l, a
    jr nc, Jump_005_613E
    inc h

Jump_005_613E::
    bit 3, [hl]
    ret

Func_005_6141::
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 6, [hl]
    ret

Data_005_614B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $05, $07, $12, $24, $01, $0C, $1C

Func_005_6153::
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $04
    jr c, Jump_005_6195
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6167::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_618B
    ld a, c
    ld hl, wD80E
    call Func_000_3F25
    ld a, [hl]
    and a, $2A
    jr nz, Jump_005_618B
    ld a, c
    ld hl, wDA74
    add a, a
    add a, c
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_005_6186
    inc h

Jump_005_6186::
    ld a, [hl]
    and a, $30
    jr z, Jump_005_6192

Jump_005_618B::
    inc c
    dec b
    jr nz, Jump_005_6167
    ld c, $FF
    ret

Jump_005_6192::
    ld c, $00
    ret

Jump_005_6195::
    ld c, $01
    ret

Func_005_6198:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_61AE
    ld a, [wD2CC]
    or a, a
    jr nz, Jump_005_61AB
    ld c, $FF
    ret

Jump_005_61AB::
    ld c, $00
    ret

Jump_005_61AE::
    ld c, $01
    ret

Func_005_61B1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call Func_000_3F25
    bit 3, [hl]
    jr nz, Jump_005_61C1
    ld c, $FF
    ret

Jump_005_61C1::
    ld c, $00
    ret
    INCBIN "dwm2-cobi-us.gbc", $0161C4, $65

Func_005_6229::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld hl, wD80C
    ld e, $20
    ld b, $03
    call Func_005_6FA1
    ret

Func_005_623B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    swap a
    ld hl, wD988
    add a, l
    ld l, a
    jr nc, Jump_005_6248
    inc h

Jump_005_6248::
    ld b, $08
    ld a, [wCFEC]
    push af
    ld d, $02

Jump_005_6250::
    inc hl
    ld a, [hl+]
    ld [wCFEC], a
    call Func_005_6C02
    jr nz, Jump_005_6264
    dec b
    jr nz, Jump_005_6250
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_6264::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Func_005_626B::
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_005_6273::
    ld a, c
    call Func_000_3E54
    jr nc, Jump_005_627F

Jump_005_6279::
    inc c
    dec b
    jr nz, Jump_005_6273
    jr Jump_005_6292

Jump_005_627F::
    push bc
    ld a, c
    call Func_005_6298
    push hl
    ld a, c
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    pop bc
    jr c, Jump_005_6295
    jr Jump_005_6279

Jump_005_6292::
    ld c, $00
    ret

Jump_005_6295::
    ld c, $FF
    ret

Func_005_6298::
    push bc
    call Func_005_400B
    ld a, [wCFEC]
    cp a, $16
    jr z, Jump_005_62BB
    cp a, $17
    jr z, Jump_005_62CC
    cp a, $18
    jr z, Jump_005_62D9
    cp a, $19
    jr z, Jump_005_62CC
    cp a, $1A
    jr z, Jump_005_62D9
    cp a, $7C
    jr z, Jump_005_62CC
    cp a, $A1
    jr z, Jump_005_62CC

Jump_005_62BB::
    push hl
    ld a, $0A
    call Func_000_16D1
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    pop bc
    ret

Jump_005_62CC::
    srl h
    rr l
    ld b, h
    ld c, l
    srl h
    rr l
    add hl, bc
    pop bc
    ret

Jump_005_62D9::
    ld a, $03
    call Func_000_16D1
    add hl, hl
    pop bc
    ret

Func_005_62E1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_62EA::
    ld a, c
    cp a, e
    jr z, Jump_005_62F3
    call Func_000_3E54
    jr nc, Jump_005_62F9

Jump_005_62F3::
    inc c
    dec b
    jr nz, Jump_005_62EA
    jr Jump_005_630C

Jump_005_62F9::
    push bc
    ld a, c
    call Func_005_401A
    push hl
    ld a, c
    call Func_005_4010
    pop bc
    call Func_000_3E7A
    pop bc
    jr c, Jump_005_630F
    jr Jump_005_62F3

Jump_005_630C::
    ld c, $00
    ret

Jump_005_630F::
    ld c, $FF
    ret

Func_005_6312:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    call Func_005_4010
    add hl, hl
    ld a, $03
    call Func_000_16D1
    push hl
    ldh a, [hFFC6]
    call Func_005_401A
    pop bc
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_637A
    ldh a, [hFFC6]
    call Func_005_4010
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_637E
    ldh a, [hFFC6]
    call Func_005_4010
    ld a, $03
    call Func_000_16D1
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_6382
    ldh a, [hFFC6]
    call Func_005_4010
    srl h
    rr l
    srl h
    rr l
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_6386
    ldh a, [hFFC6]
    call Func_005_4010
    ld a, $0A
    call Func_000_16D1
    push hl
    pop bc
    pop hl
    push hl
    call Func_000_3E7A
    jr nc, Jump_005_638A
    jr Jump_005_638E

Jump_005_637A::
    pop hl
    ld c, $00
    ret

Jump_005_637E::
    pop hl
    ld c, $01
    ret

Jump_005_6382::
    pop hl
    ld c, $02
    ret

Jump_005_6386::
    pop hl
    ld c, $03
    ret

Jump_005_638A::
    pop hl
    ld c, $04
    ret

Jump_005_638E::
    pop hl
    ld c, $05
    ret

Func_005_6392:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_63CF
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_63A6::
    ld a, c
    call Func_000_3E54
    jr nc, Jump_005_63B2

Jump_005_63AC::
    inc c
    dec b
    jr nz, Jump_005_63A6
    jr Jump_005_63C9

Jump_005_63B2::
    push bc
    ld a, c
    call Func_005_4015
    push hl
    ld a, c
    call Func_005_4006
    pop bc
    add hl, bc
    ld bc, $0578
    call Func_000_3E7A
    pop bc
    jr nc, Jump_005_63CC
    jr Jump_005_63AC

Jump_005_63C9::
    ld c, $00
    ret

Jump_005_63CC::
    ld c, $FF
    ret

Jump_005_63CF::
    ld c, $01
    ret

Func_005_63D2:: ; heuristic: follows a terminator; C0
    ld a, [wCFEC]
    push af
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld d, $10

Jump_005_63E2::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_63F8
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_005_63F8
    call Func_005_640A
    jr nz, Jump_005_6403

Jump_005_63F8::
    inc c
    dec b
    jr nz, Jump_005_63E2
    pop af
    ld [wCFEC], a
    ld c, $00
    ret

Jump_005_6403::
    pop af
    ld [wCFEC], a
    ld c, $FF
    ret

Func_005_640A::
    push bc
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, c
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_642B
    inc h

Jump_005_642B::
    ld b, $08
    ld c, d

Jump_005_642E::
    ld a, [hl]
    cp a, $89
    jr z, Jump_005_6449
    cp a, $9D
    jr z, Jump_005_6449
    push bc
    push hl
    ld [wCFEC], a
    farcall Func_01A_4022
    pop hl
    pop bc
    ldh a, [hFFC6]
    and a, c
    jr nz, Jump_005_644F

Jump_005_6449::
    inc hl
    inc hl
    dec b
    jr nz, Jump_005_642E
    xor a, a

Jump_005_644F::
    ld d, c
    pop bc
    ret

Func_005_6452:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_645E
    ld a, [wC984]
    jr Jump_005_6461

Jump_005_645E::
    ld a, [wC985]

Jump_005_6461::
    cp a, $01
    jr z, Jump_005_647B
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_646E::
    ld a, c
    cp a, e
    jr z, Jump_005_6477
    call Func_000_3E54
    jr nc, Jump_005_647E

Jump_005_6477::
    inc c
    dec b
    jr nz, Jump_005_646E

Jump_005_647B::
    ld c, $00
    ret

Jump_005_647E::
    ld c, $FF
    ret

Func_005_6481::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_6491
    ld a, [wCFC5]
    cp a, $02
    jr nc, Jump_005_6491
    ld c, $00
    ret

Jump_005_6491::
    ld c, $FF
    ret

Func_005_6494::
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_649E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_64C1
    push bc
    ld a, c
    and a, $03
    ld hl, wD2C1
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_64B1
    inc h

Jump_005_64B1::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, hl
    add hl, hl
    push hl
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    pop bc
    jr c, Jump_005_64C6

Jump_005_64C1::
    dec b
    jr nz, Jump_005_649E
    jr Jump_005_64C9

Jump_005_64C6::
    ld c, $00
    ret

Jump_005_64C9::
    ld c, $FF
    ret

Func_005_64CC::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_005_64DC
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_005_64DC
    ld c, $00
    ret

Jump_005_64DC::
    ld c, $FF
    ret

Func_005_64DF:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_400B
    ld a, $03
    call Func_000_16D1
    add hl, hl
    push hl
    ld a, [wD8A4]
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_64FB
    ld c, $00
    ret

Jump_005_64FB::
    ld c, $FF
    ret

Func_005_64FE:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_6B16
    cp a, $02
    jr c, Jump_005_6553
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6550
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6518
    inc h

Jump_005_6518::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_6532
    inc h

Jump_005_6532::
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6537::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6549
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    cp a, $03
    jr z, Jump_005_654D

Jump_005_6549::
    inc c
    dec b
    jr nz, Jump_005_6537

Jump_005_654D::
    ld c, $00
    ret

Jump_005_6550::
    ld c, $FF
    ret

Jump_005_6553::
    ld c, $01
    ret

Func_005_6556:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_4024
    cp a, $03
    jr c, Jump_005_65A9
    ld a, [wD8A4]
    ld hl, wD988
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_656D
    inc h

Jump_005_656D::
    ld b, $08
    call Func_005_65AC
    jr nz, Jump_005_65A9
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_005_657E::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6599
    ld a, c
    call Func_005_400B
    srl h
    rr l
    push hl
    ld a, c
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    jr nc, Jump_005_6599
    inc e

Jump_005_6599::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_657E
    ld a, e
    cp a, $02
    jr c, Jump_005_65A6
    ld c, $00
    ret

Jump_005_65A6::
    ld c, $FF
    ret

Jump_005_65A9::
    ld c, $01
    ret

Func_005_65AC::
    inc hl
    ld a, [hl+]
    cp a, $19
    ret z
    cp a, $1A
    ret z
    cp a, $7C
    ret z
    cp a, $A1
    ret z
    dec b
    jr nz, Func_005_65AC
    ld a, $01
    or a, a
    ret

Func_005_65C1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_65D0::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_65E4
    call Func_005_4001
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_65E4::
    inc c
    dec b
    jr nz, Jump_005_65D0
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call Func_000_16D1
    add hl, hl
    push hl
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6605::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6619
    call Func_005_4006
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_6619::
    inc c
    dec b
    jr nz, Jump_005_6605
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    call Func_000_16D1
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E7A
    jr c, Jump_005_667C
    jr z, Jump_005_667C
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    push hl
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6649::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_665D
    call Func_005_4015
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    inc e

Jump_005_665D::
    inc c
    dec b
    jr nz, Jump_005_6649
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, e
    srl h
    rr l
    call Func_000_16D1
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E7A
    jr c, Jump_005_667C
    jr z, Jump_005_667C
    ld c, $00
    ret

Jump_005_667C::
    ld c, $FF
    ret

Func_005_667F:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_4024
    cp a, $04
    jp c, Jump_005_671D
    ld a, [wD8A4]
    ld hl, wD988
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6697
    inc h

Jump_005_6697::
    ld b, $08
    call Func_005_6720
    jr nz, Jump_005_671D
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_66AF::
    push bc
    ld a, c
    call Func_000_3E54
    jr nc, Jump_005_66BB
    jr z, Jump_005_66BB
    call Func_005_6741

Jump_005_66BB::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_66AF
    ld a, d
    or a, a
    jr z, Jump_005_6717
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ld a, d
    call Func_000_16E2
    ld a, l
    ldh [hFFC9], a
    ld a, h
    ldh [hFFCA], a
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld d, $00
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_66E8::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_66F2
    call Func_005_6741

Jump_005_66F2::
    pop bc
    inc c
    dec b
    jr nz, Jump_005_66E8
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ld a, d
    call Func_000_16E2
    srl h
    rr l
    srl h
    rr l
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFCA]
    ld b, a
    call Func_000_3E80
    jr c, Jump_005_671A

Jump_005_6717::
    ld c, $00
    ret

Jump_005_671A::
    ld c, $FF
    ret

Jump_005_671D::
    ld c, $01
    ret

Func_005_6720::
    inc hl
    ld a, [hl+]
    cp a, $16
    ret z
    cp a, $17
    ret z
    cp a, $18
    ret z
    cp a, $19
    ret z
    cp a, $1A
    ret z
    cp a, $7C
    ret z
    cp a, $9F
    ret z
    cp a, $A1
    ret z
    dec b
    jr nz, Func_005_6720
    ld a, $01
    or a, a
    ret

Func_005_6741::
    push de
    ld a, c
    call Func_005_400B
    push hl
    ld a, c
    call Func_005_4010
    pop de
    add hl, de
    push hl
    ld a, c
    call Func_005_4001
    pop de
    add hl, de
    push hl
    ld a, c
    call Func_005_4006
    pop de
    add hl, de
    pop de
    ldh a, [hFFC6]
    add a, l
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, h
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, $00
    ldh [hFFC8], a
    inc d
    ret

Func_005_676E:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6778::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_67A6
    push bc
    ld a, c
    and a, $03
    add a, a
    ld hl, wD2C1
    add a, l
    ld l, a
    jr nc, Jump_005_678B
    inc h

Jump_005_678B::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, $78
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    pop bc
    push bc
    push hl
    ld a, c
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    pop bc
    jr c, Jump_005_67AC

Jump_005_67A6::
    inc c
    dec b
    jr nz, Jump_005_6778
    jr Jump_005_67AF

Jump_005_67AC::
    ld c, $00
    ret

Jump_005_67AF::
    ld c, $FF
    ret

Func_005_67B2:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_4024
    cp a, $02
    jr c, Jump_005_681D
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    ld d, $00

Jump_005_67CA::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_67D2
    ld e, c
    inc d

Jump_005_67D2::
    inc c
    dec b
    jr nz, Jump_005_67CA
    ld a, d
    cp a, $02
    jr c, Jump_005_681A
    ld a, [wD8A4]
    call Func_005_401F
    ld a, e
    push de
    push hl
    call Func_005_401F
    ld a, $78
    ld b, h
    ld c, l
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    pop bc
    call Func_000_3E7A
    pop de
    jr nc, Jump_005_681A
    ld a, e
    and a, $03
    add a, a
    ld hl, wD2C1
    add a, l
    ld l, a
    jr nc, Jump_005_6806
    inc h

Jump_005_6806::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, hl
    push hl
    ld a, e
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    jr c, Jump_005_6817
    jr nz, Jump_005_681A

Jump_005_6817::
    ld c, $00
    ret

Jump_005_681A::
    ld c, $FF
    ret

Jump_005_681D::
    ld c, $01
    ret

Func_005_6820:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_4024
    cp a, $02
    jr c, Jump_005_6899
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00
    ld d, $00

Jump_005_6838::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6840
    ld e, c
    inc d

Jump_005_6840::
    inc c
    dec b
    jr nz, Jump_005_6838
    ld a, d
    cp a, $02
    jr c, Jump_005_6896
    ld c, e
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6896
    push de
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_685B
    inc h

Jump_005_685B::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_686E
    inc h

Jump_005_686E::
    call Func_005_6C86
    cp a, $02
    pop de
    jr nc, Jump_005_6896
    ld a, e
    call Func_005_4015
    push hl
    ld a, [wD8A4]
    call Func_005_4015
    ld a, $3C
    ld b, h
    ld c, l
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    pop bc
    call Func_000_3E7A
    jr nc, Jump_005_6896
    ld c, $00
    ret

Jump_005_6896::
    ld c, $FF
    ret

Jump_005_6899::
    ld c, $01
    ret

Func_005_689C:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    call Func_005_4024
    cp a, $03
    jp c, Jump_005_696F
    ld a, [wC58A]
    or a, a
    jp nz, Jump_005_696C
    ld a, [wCFC5]
    cp a, $02
    jp nc, Jump_005_696C
    ld a, [wD2CC]
    or a, a
    jp z, Jump_005_696C
    ld a, [wD8A4]
    ld e, a
    and a, $04
    ld c, a
    ld b, $03

Jump_005_68C6::
    ld a, c
    cp a, e
    jr z, Jump_005_68F5
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_68F5
    ld a, c
    call Func_005_4024
    cp a, $03
    jr c, Jump_005_68F5
    push de
    call Func_005_7058
    pop de
    jr nz, Jump_005_68F5
    ld a, c
    push de
    call Func_000_3E25
    pop de
    jr c, Jump_005_68F5
    ld a, c
    ld hl, wDA5B
    add a, l
    ld l, a
    jr nc, Jump_005_68F0
    inc h

Jump_005_68F0::
    ld a, [hl]
    cp a, $03
    jr c, Jump_005_68FB

Jump_005_68F5::
    inc c
    dec b
    jr nz, Jump_005_68C6
    jr Jump_005_696C

Jump_005_68FB::
    ld a, [wD8A4]
    call Func_005_4015
    srl h
    rr l
    push hl
    ld a, [wD8A4]
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    jr nc, Jump_005_696C
    ld de, $0064
    add hl, de
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6920::
    push hl
    ld a, c
    call Func_000_3E54
    pop hl
    jr c, Jump_005_6963
    push bc
    push hl
    push hl
    ld a, c
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    pop hl
    pop bc
    jr c, Jump_005_6963
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_696C
    push bc
    push hl
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6949
    inc h

Jump_005_6949::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, c
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_695A
    inc h

Jump_005_695A::
    call Func_005_6C86
    pop hl
    pop bc
    cp a, $02
    jr c, Jump_005_6969

Jump_005_6963::
    inc c
    dec b
    jr nz, Jump_005_6920
    jr Jump_005_696C

Jump_005_6969::
    ld c, $00
    ret

Jump_005_696C::
    ld c, $FF
    ret

Jump_005_696F::
    ld c, $01
    ret

Func_005_6972::
    ld a, [wD8A4]
    ld hl, wD810
    call Func_000_3F25
    and a, $03
    jr z, Jump_005_6982
    ld c, $00
    ret

Jump_005_6982::
    ld c, $FF
    ret

Func_005_6985:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC9], a
    ldh [hFFCA], a
    ldh [hFFCB], a

Jump_005_6996::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_69AD
    call Func_005_4006
    ldh a, [hFFCA]
    add a, l
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, h
    ldh [hFFCB], a
    ld hl, hFFC9
    inc [hl]

Jump_005_69AD::
    inc c
    dec b
    jr nz, Jump_005_6996
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFC9]
    call Func_000_16D1
    push hl
    ld a, [wD8A4]
    call Func_005_4001
    ld d, h
    ld e, l
    srl d
    rr e
    srl d
    rr e
    add hl, de
    pop bc
    call Func_000_3E7A
    jr nc, Jump_005_69D7
    ld c, $00
    ret

Jump_005_69D7::
    ld c, $FF
    ret

Func_005_69DA::
    ld a, [wD8A4]
    ld hl, wD80E
    call Func_000_3F25
    ld a, [hl+]
    and a, $02
    jr nz, Jump_005_69EF
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jr z, Jump_005_69F2

Jump_005_69EF::
    ld c, $00
    ret

Jump_005_69F2::
    ld c, $FF
    ret

Func_005_69F5:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_6A03
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_005_6A68

Jump_005_6A03::
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6A65
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6A13
    inc h

Jump_005_6A13::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_6A2D
    inc h

Jump_005_6A2D::
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6A32::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6A46
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    ld d, a
    ldh a, [hFFC7]
    add a, d
    ldh [hFFC7], a

Jump_005_6A46::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_6A32
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_005_6A62
    ld b, a
    ldh a, [hFFC6]
    call Func_000_16BF
    ld a, b
    cp a, $02
    jr nc, Jump_005_6A65

Jump_005_6A62::
    ld c, $00
    ret

Jump_005_6A65::
    ld c, $FF
    ret

Jump_005_6A68::
    ld c, $01
    ret

Func_005_6A6B:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_005_6AE5
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_005_6AE5
    call Func_005_6B16
    cp a, $03
    jr c, Jump_005_6AE5
    ld a, [wCFEF]
    or a, a
    jr z, Jump_005_6AE2
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6A90
    inc h

Jump_005_6A90::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_6AAA
    inc h

Jump_005_6AAA::
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6AAF::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6AC3
    ldh a, [hFFC6]
    inc a
    ldh [hFFC6], a
    call Func_005_6C86
    ld d, a
    ldh a, [hFFC7]
    add a, d
    ldh [hFFC7], a

Jump_005_6AC3::
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_005_6AAF
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_005_6ADF
    ld b, a
    ldh a, [hFFC6]
    call Func_000_16BF
    ld a, b
    cp a, $02
    jr nc, Jump_005_6AE2

Jump_005_6ADF::
    ld c, $00
    ret

Jump_005_6AE2::
    ld c, $FF
    ret

Jump_005_6AE5::
    ld c, $01
    ret

Func_005_6AE8::
    xor a, a
    ld [wDA6E], a
    ld [wDA6F], a
    ld a, $FF
    ld [wDA70], a
    ld [wDA71], a
    ret

Func_005_6AF8:: ; heuristic: follows a terminator; C0
    ld a, [wDA6E]
    add a, c
    ld [wDA6E], a
    ld a, [wDA6F]
    adc a, b
    ld [wDA6F], a
    ret

Func_005_6B07:: ; heuristic: follows a terminator; C0
    ld a, [wDA70]
    add a, c
    ld [wDA70], a
    ld a, [wDA71]
    adc a, b
    ld [wDA71], a
    ret

Func_005_6B16::
    ld hl, wDA53
    add a, l
    ld l, a
    jr nc, Jump_005_6B1E
    inc h

Jump_005_6B1E::
    ld a, [hl]
    ret

Func_005_6B20:: ; heuristic: follows a terminator; C0
    call Func_005_4006
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr nc, Jump_005_6B5B
    push hl
    push bc
    farcall Func_03B_40CD
    pop bc
    pop hl
    inc hl
    ld a, [wDAC4]
    ld e, a
    ld a, [wDAC5]
    ld d, a
    sla e
    rl d
    ld a, [wC58A]
    or a, a
    jr z, Jump_005_6B4C
    cp a, $02
    jr nz, Jump_005_6B51

Jump_005_6B4C::
    ld a, c
    cp a, $04
    jr nc, Jump_005_6B55

Jump_005_6B51::
    sla e
    rl d

Jump_005_6B55::
    ld a, e
    sub a, l
    ld a, d
    sbc a, h
    jr nc, Jump_005_6B5D

Jump_005_6B5B::
    xor a, a
    ret

Jump_005_6B5D::
    scf
    ret

Func_005_6B5F:: ; heuristic: follows a terminator; C0
    call Func_005_401F
    ld a, l
    sub a, $E7
    ld a, h
    sbc a, $03
    jr nc, Jump_005_6B9A
    push hl
    push bc
    farcall Func_03B_4111
    pop bc
    pop hl
    inc hl
    ld a, [wDAC4]
    ld e, a
    ld a, [wDAC5]
    ld d, a
    sla e
    rl d
    ld a, [wC58A]
    or a, a
    jr z, Jump_005_6B8B
    cp a, $02
    jr nz, Jump_005_6B90

Jump_005_6B8B::
    ld a, c
    cp a, $04
    jr nc, Jump_005_6B94

Jump_005_6B90::
    sla e
    rl d

Jump_005_6B94::
    ld a, e
    sub a, l
    ld a, d
    sbc a, h
    jr nc, Jump_005_6B9C

Jump_005_6B9A::
    xor a, a
    ret

Jump_005_6B9C::
    scf
    ret

Func_005_6B9E:: ; heuristic: follows a terminator; C0
    push bc
    ld a, c
    call Func_005_400B
    ld c, l
    ld b, h
    add hl, hl
    add hl, bc
    sra h
    rr l
    sra h
    rr l
    pop bc
    push bc
    push hl
    ld a, c
    call Func_005_4015
    pop bc
    call Func_000_3E7A
    pop bc
    ret

Func_005_6BBC:: ; heuristic: follows a terminator; C0
    push bc
    push af
    call Func_005_400B
    pop af
    push hl
    ld a, c
    call Func_005_4015
    add hl, hl
    pop bc
    call Func_000_3E7A
    pop bc
    ret

Func_005_6BCE:: ; heuristic: follows a terminator; C0
    push bc
    push af
    call Func_005_400B
    pop af
    push hl
    ld a, c
    call Func_005_4015
    add hl, hl
    add hl, hl
    pop bc
    call Func_000_3E7A
    pop bc
    ret

Func_005_6BE1:: ; heuristic: follows a terminator; C0
    push bc
    push af
    call Func_005_400B
    pop af
    push hl
    ld a, c
    call Func_005_4015
    add hl, hl
    ld b, h
    ld c, l
    add hl, hl
    add hl, hl
    add hl, bc
    pop bc
    call Func_000_3E7A
    pop bc
    ret

Func_005_6BF8::
    call Func_005_4015
    ld a, h
    or a, a
    ret nz
    ld a, l
    cp a, $01
    ret

Func_005_6C02:: ; heuristic: follows a terminator; C0
    push bc
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, c
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6C23
    inc h

Jump_005_6C23::
    ld b, $08
    ld c, d

Jump_005_6C26::
    push bc
    push hl
    ld a, [hl]
    ld [wCFEC], a
    farcall Func_01A_4022
    pop hl
    pop bc
    ldh a, [hFFC6]
    and a, c
    jr nz, Jump_005_6C3F
    inc hl
    inc hl
    dec b
    jr nz, Jump_005_6C26
    xor a, a

Jump_005_6C3F::
    ld d, c
    pop bc
    ret

Func_005_6C42:: ; heuristic: follows a terminator; C0
    push bc
    ld a, $01
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, hFFC6
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld a, c
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6C63
    inc h

Jump_005_6C63::
    ld bc, $0800

Jump_005_6C66::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_005_6C7E
    push bc
    push hl
    ld [wCFEC], a
    farcall Func_01A_4022
    pop hl
    pop bc
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_005_6C7E
    inc c

Jump_005_6C7E::
    inc hl
    dec b
    jr nz, Jump_005_6C66
    ld a, c
    or a, a
    pop bc
    ret

Func_005_6C86::
    ld a, e
    or a, a
    jr z, Jump_005_6C97
    cp a, $01
    jr z, Jump_005_6C9A
    cp a, $02
    jr z, Jump_005_6C9F
    ld a, [hl]
    rlca
    rlca
    jr Jump_005_6CA2

Jump_005_6C97::
    ld a, [hl]
    jr Jump_005_6CA2

Jump_005_6C9A::
    ld a, [hl]
    rrca
    rrca
    jr Jump_005_6CA2

Jump_005_6C9F::
    ld a, [hl]
    swap a

Jump_005_6CA2::
    and a, $03
    ret

Func_005_6CA5:: ; heuristic: follows a terminator; C0
    ld hl, wD958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_6CAE
    inc h

Jump_005_6CAE::
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    push bc
    farcall Func_035_400A
    pop bc
    ld a, [wD008]
    ret

Func_005_6CC2:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a

Jump_005_6CD1::
    ld a, c
    call Func_000_3E54
    jr nc, Jump_005_6CDD
    inc c
    dec b
    jr nz, Jump_005_6CD1
    jr Jump_005_6D06

Jump_005_6CDD::
    ld a, c
    call Func_005_4006
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    inc c
    dec b
    jr z, Jump_005_6D06

Jump_005_6CEB::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6D02
    call Func_005_4006
    ldh a, [hFFC6]
    sub a, l
    ldh a, [hFFC7]
    sbc a, h
    jr c, Jump_005_6D02
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a

Jump_005_6D02::
    inc c
    dec b
    jr nz, Jump_005_6CEB

Jump_005_6D06::
    ret

Func_005_6D07:: ; heuristic: follows a terminator; C0
    ld a, c
    ld hl, wD80D
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_005_6D19
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03

Jump_005_6D19::
    ret

Func_005_6D1A::
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6D24
    inc h

Jump_005_6D24::
    push bc
    ld bc, $0800

Jump_005_6D28::
    ld a, [hl+]
    cp a, $03
    jr z, Jump_005_6D4B
    cp a, $06
    jr z, Jump_005_6D4B
    cp a, $09
    jr z, Jump_005_6D4B
    cp a, $0C
    jr z, Jump_005_6D4B
    cp a, $0F
    jr z, Jump_005_6D4B
    cp a, $12
    jr z, Jump_005_6D4B
    cp a, $13
    jr z, Jump_005_6D4B
    cp a, $14
    jr z, Jump_005_6D4B
    jr Jump_005_6D4C

Jump_005_6D4B::
    inc c

Jump_005_6D4C::
    inc hl
    dec b
    jr nz, Jump_005_6D28
    ld a, c
    or a, a
    pop bc
    ret

Func_005_6D54:: ; heuristic: follows a terminator; C0
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6D5E
    inc h

Jump_005_6D5E::
    push bc
    ld bc, $0800

Jump_005_6D62::
    ld a, [hl+]
    cp a, $03
    jr z, Jump_005_6D95
    cp a, $06
    jr z, Jump_005_6D95
    cp a, $09
    jr z, Jump_005_6D95
    cp a, $0C
    jr z, Jump_005_6D95
    cp a, $0F
    jr z, Jump_005_6D95
    cp a, $12
    jr z, Jump_005_6D95
    cp a, $13
    jr z, Jump_005_6D95
    cp a, $14
    jr z, Jump_005_6D95
    cp a, $15
    jr z, Jump_005_6D95
    cp a, $3D
    jr z, Jump_005_6D95
    cp a, $3E
    jr z, Jump_005_6D95
    cp a, $3F
    jr z, Jump_005_6D95
    jr Jump_005_6D96

Jump_005_6D95::
    inc c

Jump_005_6D96::
    inc hl
    dec b
    jr nz, Jump_005_6D62
    ld a, c
    or a, a
    pop bc
    ret

Func_005_6D9E:: ; heuristic: follows a terminator; C0
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6DA8
    inc h

Jump_005_6DA8::
    push bc
    ld bc, $0800

Jump_005_6DAC::
    ld a, [hl+]
    or a, a
    jr z, Jump_005_6DD1
    cp a, $FF
    jr z, Jump_005_6DD1
    cp a, $16
    jr c, Jump_005_6DD1
    cp a, $25
    jr c, Jump_005_6DD0
    cp a, $7B
    jr c, Jump_005_6DD1
    cp a, $7D
    jr c, Jump_005_6DD0
    cp a, $81
    jr z, Jump_005_6DD0
    cp a, $9F
    jr c, Jump_005_6DD1
    cp a, $A1
    jr nc, Jump_005_6DD1

Jump_005_6DD0::
    inc c

Jump_005_6DD1::
    inc hl
    dec b
    jr nz, Jump_005_6DAC
    ld a, c
    pop bc
    or a, a
    ret

Func_005_6DD9:: ; heuristic: follows a terminator; C0
    push bc
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6DE4
    inc h

Jump_005_6DE4::
    ld bc, $0800

Jump_005_6DE7::
    ld a, [hl+]
    cp a, $16
    jr c, Jump_005_6DF9
    cp a, $1B
    jr c, Jump_005_6DF8
    cp a, $1E
    jr c, Jump_005_6DF9
    cp a, $21
    jr nc, Jump_005_6DF9

Jump_005_6DF8::
    inc c

Jump_005_6DF9::
    dec b
    jr nz, Jump_005_6DE7
    ld a, c
    pop bc
    ret

Func_005_6DFF::
    ld c, a
    ld b, $03
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a

Jump_005_6E09::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6E20
    call Func_005_401F
    ldh a, [hFFC7]
    add a, l
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, h
    ldh [hFFC8], a
    ld hl, hFFC6
    inc [hl]

Jump_005_6E20::
    inc c
    dec b
    jr nz, Jump_005_6E09
    ldh a, [hFFC7]
    ld l, a
    ldh a, [hFFC8]
    ld h, a
    ldh a, [hFFC6]
    call Func_000_16D1
    ret

Func_005_6E30:: ; heuristic: follows a terminator; C0
    ld a, c
    ld d, $00
    ld hl, wD80D
    call Func_000_3F25
    bit 2, [hl]
    call nz, Func_005_6E89
    bit 3, [hl]
    call nz, Func_005_6E89
    bit 4, [hl]
    call nz, Func_005_6E89
    bit 5, [hl]
    call nz, Func_005_6E89
    inc hl
    bit 0, [hl]
    call nz, Func_005_6E89
    bit 1, [hl]
    call nz, Func_005_6E89
    bit 2, [hl]
    call nz, Func_005_6E89
    bit 3, [hl]
    call nz, Func_005_6E89
    bit 5, [hl]
    call nz, Func_005_6E89
    bit 6, [hl]
    call nz, Func_005_6E89
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $0C
    call nz, Func_005_6E89
    ld a, [hl]
    and a, $C0
    call nz, Func_005_6E89
    inc hl
    bit 6, [hl]
    call nz, Func_005_6E89
    inc hl
    inc hl
    bit 6, [hl]
    call nz, Func_005_6E89
    ret

Func_005_6E89::
    inc d
    ret

Func_005_6E8B:: ; heuristic: follows a terminator; C0
    push bc
    ld de, $0000
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6E99
    inc h

Jump_005_6E99::
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld a, $C8
    ld [wD86A], a
    ld a, $FF
    ld [wD86B], a
    ld b, $08

Jump_005_6EAF::
    push bc
    ld a, [hl+]
    ld [wCFEC], a
    cp a, $FF
    jr z, Jump_005_6ECA
    push de
    push hl
    farcall Func_01A_4022
    pop hl
    pop de
    inc d
    ldh a, [hFFC8]
    bit 6, [hl]
    jr z, Jump_005_6ECA
    inc e

Jump_005_6ECA::
    pop bc
    inc hl
    dec b
    jr nz, Jump_005_6EAF
    pop bc
    ret

Func_005_6ED1:: ; heuristic: follows a terminator; C0
    push bc
    ld a, c
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6EDD
    inc h

Jump_005_6EDD::
    ld bc, $0800

Jump_005_6EE0::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_6EF9
    or a, a
    jr z, Jump_005_6EF9
    cp a, $16
    jr c, Jump_005_6EF8
    cp a, $2E
    jr c, Jump_005_6EF9
    cp a, $31
    jr z, Jump_005_6EF9
    cp a, $35
    jr nc, Jump_005_6EF9

Jump_005_6EF8::
    inc c

Jump_005_6EF9::
    inc hl
    dec b
    jr nz, Jump_005_6EE0
    ld a, c
    pop bc
    or a, a
    ret

Func_005_6F01:: ; heuristic: follows a terminator; C0
    push bc
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6F0C
    inc h

Jump_005_6F0C::
    ld bc, $0800

Jump_005_6F0F::
    ld a, [hl+]
    cp a, $40
    jr c, Jump_005_6F19
    cp a, $48
    jr nc, Jump_005_6F19
    inc c

Jump_005_6F19::
    inc hl
    dec b
    jr nz, Jump_005_6F0F
    ld a, c
    or a, a
    pop bc
    ret

Func_005_6F21:: ; heuristic: follows a terminator; C0
    push bc
    ld hl, wD989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_005_6F2C
    inc h

Jump_005_6F2C::
    ld bc, $0800

Jump_005_6F2F::
    ld a, [hl+]
    or a, a
    jr z, Jump_005_6F58
    cp a, $FF
    jr z, Jump_005_6F58
    cp a, $16
    jr c, Jump_005_6F57
    cp a, $40
    jr c, Jump_005_6F58
    cp a, $68
    jr c, Jump_005_6F57
    cp a, $6A
    jr c, Jump_005_6F58
    cp a, $71
    jr c, Jump_005_6F57
    cp a, $8B
    jr c, Jump_005_6F58
    cp a, $94
    jr c, Jump_005_6F57
    cp a, $AA
    jr nz, Jump_005_6F58

Jump_005_6F57::
    inc c

Jump_005_6F58::
    inc hl
    dec b
    jr nz, Jump_005_6F2F
    ld a, c
    or a, a
    pop bc
    ret

Func_005_6F60::
    add a, a
    add a, c
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_005_6F69
    inc h

Jump_005_6F69::
    ld a, [hl]
    ret

Data_005_6F6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $02, $00, $01, $00, $00, $01, $03, $01, $02, $01, $01, $01, $00, $02, $03
    db $02, $02, $02, $01, $02, $00, $03, $03, $03, $02, $03, $01, $03, $00, $04, $03
    db $04, $02, $04, $01, $04, $00, $05, $03, $05, $02, $05, $01, $05, $00, $06, $03
    db $06, $02, $06, $01, $00, $03

Func_005_6FA1::
    ld c, a

Jump_005_6FA2::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6FB3
    push hl
    ld a, c
    call Func_000_3F25
    ld a, [hl]
    pop hl
    and a, e
    and a, a
    jr z, Jump_005_6FBA

Jump_005_6FB3::
    inc c
    dec b
    jr nz, Jump_005_6FA2
    ld c, $00
    ret

Jump_005_6FBA::
    ld c, $FF
    ret

Func_005_6FBD:: ; heuristic: follows a terminator; C0
    ld c, a

Jump_005_6FBE::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6FCF
    push hl
    ld a, c
    call Func_000_3F25
    ld a, [hl]
    pop hl
    and a, e
    and a, a
    jr nz, Jump_005_6FD6

Jump_005_6FCF::
    inc c
    dec b
    jr nz, Jump_005_6FBE
    ld c, $00
    ret

Jump_005_6FD6::
    ld c, $FF
    ret

Func_005_6FD9:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_005_6FE3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_005_6FF1
    push de
    call Func_005_6CA5
    pop de
    cp a, e
    jr z, Jump_005_6FF7

Jump_005_6FF1::
    inc c
    dec b
    jr nz, Jump_005_6FE3
    jr Jump_005_6FFA

Jump_005_6FF7::
    ld c, $00
    ret

Jump_005_6FFA::
    ld c, $FF
    ret

Func_005_6FFD:: ; heuristic: follows a terminator; C0
    push bc
    ld a, c
    call Func_005_4010
    ld c, l
    ld b, h
    add hl, hl
    add hl, bc
    sra h
    rr l
    sra h
    rr l
    pop bc
    push bc
    push hl
    ld a, c
    call Func_005_401A
    pop bc
    call Func_000_3E7A
    pop bc
    ret

Func_005_701B:: ; heuristic: follows a terminator; C0
    push de
    push bc
    ld a, $05
    call Func_000_16D1
    sla l
    rl h
    sla l
    rl h
    pop bc
    pop de
    ret

Func_005_702D::
    ld a, [wCFEF]
    or a, a
    ret

Func_005_7032:: ; heuristic: follows a terminator; C0
    dec a
    ld hl, Data_005_6F6B
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_005_703C
    inc h

Jump_005_703C::
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld a, [wD8A4]
    ld hl, wDA72
    add a, a
    add a, c
    add a, a
    add a, c
    add a, d
    add a, l
    ld l, a
    jr nc, Jump_005_704F
    inc h

Jump_005_704F::
    call Func_005_6C86
    ld e, a
    ld a, $01
    or a, a
    ld a, e
    ret

Func_005_7058:: ; heuristic: follows a terminator; C0
    ld e, $00
    ld d, c
    ld hl, wD989
    add hl, de
    ld e, $08

Jump_005_7061::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_005_707A
    cp a, $16
    jr c, Jump_005_7076
    cp a, $1B
    jr c, Jump_005_707E
    cp a, $7C
    jr z, Jump_005_707E
    cp a, $A1
    jr z, Jump_005_707E

Jump_005_7076::
    inc hl
    dec b
    jr nz, Jump_005_7061

Jump_005_707A::
    ld a, $01
    or a, a
    ret

Jump_005_707E::
    xor a, a
    ret

Func_005_7080::
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7088
    ret

Jump_005_7088::
    call Func_005_6AE8
    ret

Func_005_708C:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_4169
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_41B9
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_420F
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_70C5
    ret

Jump_005_70C5::
    call Func_005_6AE8
    ret

Func_005_70C9:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_4169
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_41B9
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7105
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7105
    farcall Func_005_5CCE
    ld a, c
    and a, a
    jr z, Jump_005_7105
    ret

Jump_005_7105::
    call Func_005_6AE8
    ret

Func_005_7109:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_4169
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_41B9
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_4676
    ld a, c
    cp a, $01
    jr z, Jump_005_714C
    and a, a
    jr z, Jump_005_715B

Jump_005_714C::
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_715B
    call Func_005_5CCE
    ld a, c
    and a, a
    jr z, Jump_005_715B
    ret

Jump_005_715B::
    call Func_005_6AE8
    ret

Func_005_715F:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call Func_005_4169
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call Func_005_41B9
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7183
    call Func_005_626B
    ld a, c
    and a, a
    jr z, Jump_005_7183
    ret

Jump_005_7183::
    call Func_005_6AE8
    ret

Func_005_7187:: ; heuristic: follows a terminator; C0
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call Func_005_4777
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call Func_005_54FD
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    call Func_005_62E1
    ld a, c
    and a, a
    jr z, Jump_005_71A8
    ret

Jump_005_71A8::
    call Func_005_6AE8
    ret

Func_005_71AC:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_71BA
    ret

Jump_005_71BA::
    call Func_005_6AE8
    ret

Func_005_71BE:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_71DA
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_71DA
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_71DA
    ret

Jump_005_71DA::
    call Func_005_6AE8
    ret

Func_005_71DE:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_47A5
    ld a, c
    and a, a
    jr z, Jump_005_71EE
    ld c, $FF
    ret

Jump_005_71EE::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_71F4:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_47C5
    ld a, c
    and a, a
    jr z, Jump_005_7204
    ld c, $FF
    ret

Jump_005_7204::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_720A:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_47B5
    ld a, c
    and a, a
    jr z, Jump_005_721A
    ld c, $FF
    ret

Jump_005_721A::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7220:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_47D5
    ld a, c
    and a, a
    jr z, Jump_005_7230
    ld c, $FF
    ret

Jump_005_7230::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7236:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_724B
    call Func_005_4C23
    ld a, c
    and a, a
    jr z, Jump_005_724B
    ret

Jump_005_724B::
    call Func_005_6AE8
    ret

Func_005_724F:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_4977
    ld a, c
    and a, a
    jr z, Jump_005_725D
    ret

Jump_005_725D::
    call Func_005_6AE8
    ret

Func_005_7261::
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_41EB
    ld a, c
    and a, a
    jr z, Jump_005_7276
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7276
    ret

Jump_005_7276::
    call Func_005_6AE8
    ret

Func_005_727A:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_728F
    call Func_005_4C40
    ld a, c
    and a, a
    jr z, Jump_005_728F
    ret

Jump_005_728F::
    call Func_005_6AE8
    ret

Func_005_7293:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_72A8
    call Func_005_49AA
    ld a, c
    and a, a
    jr z, Jump_005_72A8
    ret

Jump_005_72A8::
    call Func_005_6AE8
    ret

Func_005_72AC:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_4D1A
    ld a, c
    and a, a
    jr z, Jump_005_72BA
    ret

Jump_005_72BA::
    call Func_005_6AE8
    ret

Func_005_72BE:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_72DA
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_72DA
    call Func_005_48C9
    ld a, c
    and a, a
    jr z, Jump_005_72DA
    ret

Jump_005_72DA::
    call Func_005_6AE8
    ret

Func_005_72DE:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_72F3
    call Func_005_5D9B
    ld a, c
    and a, a
    jr z, Jump_005_72F3
    ret

Jump_005_72F3::
    call Func_005_6AE8
    ret

Func_005_72F7:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_4286
    ld a, c
    cp a, $01
    jr z, Jump_005_7308
    and a, a
    jr z, Jump_005_731E

Jump_005_7308::
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_731E
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_731E
    call Func_005_4741
    ld a, c
    and a, a
    jr z, Jump_005_731E
    ret

Jump_005_731E::
    call Func_005_6AE8
    ret

Func_005_7322:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_7341
    call Func_005_4949
    ld a, c
    and a, a
    jr z, Jump_005_7341
    farcall Func_005_558B
    ld a, c
    and a, a
    jr z, Jump_005_7341
    ret

Jump_005_7341::
    call Func_005_6AE8
    ret

Func_005_7345:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_736C
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_735D
    and a, a
    jr z, Jump_005_736C

Jump_005_735D::
    call Func_005_45CF
    ld a, c
    and a, a
    jr z, Jump_005_736C
    call Func_005_4904
    ld a, c
    and a, a
    jr z, Jump_005_736C
    ret

Jump_005_736C::
    call Func_005_6AE8
    ret

Func_005_7370:: ; heuristic: follows a terminator; C0
    call Func_005_7261
    ld a, c
    and a, a
    ret z
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_7393
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7393
    call Func_005_4499
    ld a, c
    and a, a
    jr z, Jump_005_7393
    call Func_005_5E6F
    ld a, c
    and a, a
    jr z, Jump_005_7393
    ret

Jump_005_7393::
    call Func_005_6AE8
    ret

Func_005_7397:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call Func_005_4C5D
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_73CB
    and a, a
    jr z, Jump_005_73D3

Jump_005_73CB::
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_73D3
    ret

Jump_005_73D3::
    call Func_005_6AE8
    ret

Func_005_73D7:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_73EF
    and a, a
    jr z, Jump_005_740C

Jump_005_73EF::
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call Func_005_55AA
    ld a, c
    and a, a
    jr z, Jump_005_740C
    call Func_005_55F3
    ld a, c
    and a, a
    jr z, Jump_005_740C
    ret

Jump_005_740C::
    call Func_005_6AE8
    ret

Func_005_7410:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call Func_005_4373
    ld a, c
    cp a, $01
    jr z, Jump_005_7428
    and a, a
    jr z, Jump_005_7445

Jump_005_7428::
    call Func_005_45E1
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_7445
    call Func_005_5D20
    ld a, c
    and a, a
    jr z, Jump_005_7445
    ret

Jump_005_7445::
    call Func_005_6AE8
    ret

Func_005_7449:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_7461
    and a, a
    jr z, Jump_005_747E

Jump_005_7461::
    call Func_005_45CF
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_747E
    call Func_005_4D46
    ld a, c
    and a, a
    jr z, Jump_005_747E
    ret

Jump_005_747E::
    call Func_005_6AE8
    ret

Func_005_7482:: ; heuristic: follows a terminator; C0
    call Func_005_7494
    ld a, c
    and a, a
    ret z
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_7490
    ret

Jump_005_7490::
    call Func_005_6AE8
    ret

Func_005_7494::
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    call Func_005_4169
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    call Func_005_41B9
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_74B1
    ret

Jump_005_74B1::
    call Func_005_6AE8
    ret

Func_005_74B5:: ; heuristic: follows a terminator; C0
    call Func_005_74D1
    ld a, c
    and a, a
    ret z
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_74CD
    farcall Func_005_6481
    ld a, c
    and a, a
    jr z, Jump_005_74CD
    ret

Jump_005_74CD::
    call Func_005_6AE8
    ret

Func_005_74D1::
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call Func_005_420F
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_74F5
    ret

Jump_005_74F5::
    call Func_005_6AE8
    ret

Func_005_74F9:: ; heuristic: follows a terminator; C0
    call Func_005_74D1
    ld a, c
    and a, a
    ret z
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_750E
    call Func_005_4487
    ld a, c
    and a, a
    jr z, Jump_005_750E
    ret

Jump_005_750E::
    call Func_005_6AE8
    ret

Func_005_7512:: ; heuristic: follows a terminator; C0
    call Func_005_74D1
    ld a, c
    and a, a
    ret z
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7520
    ret

Jump_005_7520::
    call Func_005_6AE8
    ret

Func_005_7524:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_481C
    ld a, c
    and a, a
    jr nz, Jump_005_7534
    ld c, $FF
    ret

Jump_005_7534::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_753A:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4822
    ld a, c
    and a, a
    jr nz, Jump_005_754A
    ld c, $FF
    ret

Jump_005_754A::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7550:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4828
    ld a, c
    and a, a
    jr nz, Jump_005_7560
    ld c, $FF
    ret

Jump_005_7560::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7566:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_482E
    ld a, c
    and a, a
    jr nz, Jump_005_7576
    ld c, $FF
    ret

Jump_005_7576::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_757C:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4834
    ld a, c
    and a, a
    jr nz, Jump_005_758C
    ld c, $FF
    ret

Jump_005_758C::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7592:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_483A
    ld a, c
    and a, a
    jr nz, Jump_005_75A2
    ld c, $FF
    ret

Jump_005_75A2::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_75A8:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4840
    ld a, c
    and a, a
    jr nz, Jump_005_75B8
    ld c, $FF
    ret

Jump_005_75B8::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_75BE:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4846
    ld a, c
    and a, a
    jr nz, Jump_005_75CE
    ld c, $FF
    ret

Jump_005_75CE::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_75D4:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_484C
    ld a, c
    and a, a
    jr nz, Jump_005_75E4
    ld c, $FF
    ret

Jump_005_75E4::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_75EA:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4852
    ld a, c
    and a, a
    jr nz, Jump_005_75FA
    ld c, $FF
    ret

Jump_005_75FA::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7600:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4858
    ld a, c
    and a, a
    jr nz, Jump_005_7610
    ld c, $FF
    ret

Jump_005_7610::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7616::
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call Func_005_420F
    ld a, c
    and a, a
    jr z, Jump_005_763A
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_763A
    ret

Jump_005_763A::
    call Func_005_6AE8
    ret

Func_005_763E:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_44BD
    ld a, c
    and a, a
    jr z, Jump_005_7655
    call Func_005_49DD
    ld a, c
    and a, a
    jr z, Jump_005_7655
    ld c, $FF
    ret

Jump_005_7655::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_765B:: ; heuristic: follows a terminator; C0
    call Func_005_7686
    ld a, c
    and a, a
    ret z
    call Func_005_4A10
    ld a, c
    and a, a
    jr z, Jump_005_766B
    ld c, $FF
    ret

Jump_005_766B::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7671:: ; heuristic: follows a terminator; C0
    call Func_005_7686
    ld a, c
    and a, a
    ret z
    call Func_005_5D9B
    ld a, c
    jr z, Jump_005_7680
    ld c, $FF
    ret

Jump_005_7680::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7686::
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_769D
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_769D
    ld c, $FF
    ret

Jump_005_769D::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_76A3:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4461
    ld a, c
    and a, a
    jr z, Jump_005_76CA
    call Func_005_4B97
    ld a, c
    and a, a
    jr z, Jump_005_76CA
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_76CA
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_76C9
    and a, a
    jr z, Jump_005_76CA

Jump_005_76C9::
    ret

Jump_005_76CA::
    call Func_005_6AE8
    ret

Func_005_76CE:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_6985
    ld a, c
    and a, a
    jr z, Jump_005_76DC
    ret

Jump_005_76DC::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_76E2:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_4B3D
    ld a, c
    and a, a
    jr z, Jump_005_76F2
    ld c, $FF
    ret

Jump_005_76F2::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_76F8:: ; heuristic: follows a terminator; C0
    call Func_005_770A
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7706
    ret

Jump_005_7706::
    call Func_005_6AE8
    ret

Func_005_770A::
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7727
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7727
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7727
    call Func_005_420F
    ld a, c
    and a, a
    jr z, Jump_005_7727
    ret

Jump_005_7727::
    call Func_005_6AE8
    ret

Func_005_772B:: ; heuristic: follows a terminator; C0
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_774B
    call Func_005_4C5D
    ld a, c
    and a, a
    jr z, Jump_005_774B
    call Func_005_53CA
    ld a, c
    and a, a
    jr z, Jump_005_774B
    farcall Func_005_6972
    ld a, c
    and a, a
    jr z, Jump_005_774B
    ret

Jump_005_774B::
    call Func_005_6AE8
    ret

Func_005_774F:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call Func_005_420F
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7773
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_7773
    ret

Jump_005_7773::
    call Func_005_6AE8
    ret

Func_005_7777:: ; heuristic: follows a terminator; C0
    call Func_005_770A
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_7782
    ret

Jump_005_7782::
    call Func_005_6AE8
    ret

Func_005_7786:: ; heuristic: follows a terminator; C0
    call Func_005_779F
    ld a, c
    and a, a
    ret z
    call Func_005_443B
    ld a, c
    and a, a
    jr z, Jump_005_779B
    call Func_005_4777
    ld a, c
    and a, a
    jr z, Jump_005_779B
    ret

Jump_005_779B::
    call Func_005_6AE8
    ret

Func_005_779F::
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_77C3
    ret

Jump_005_77C3::
    call Func_005_6AE8
    ret

Func_005_77C7:: ; heuristic: follows a terminator; C0
    call Func_005_779F
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_77DC
    call Func_005_5397
    ld a, c
    and a, a
    jr z, Jump_005_77DC
    ret

Jump_005_77DC::
    call Func_005_6AE8
    ret

Func_005_77E0:: ; heuristic: follows a terminator; C0
    call Func_005_77C7
    ld a, c
    and a, a
    ret z
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_77F5
    call Func_005_4777
    ld a, c
    and a, a
    jr z, Jump_005_77F5
    ret

Jump_005_77F5::
    call Func_005_6AE8
    ret

Func_005_77F9:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_780E
    call Func_005_5D9B
    ld a, c
    and a, a
    jr z, Jump_005_780E
    ret

Jump_005_780E::
    call Func_005_6AE8
    ret

Func_005_7812::
    call Func_005_770A
    ld a, c
    and a, a
    ret z
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_7820
    ret

Jump_005_7820::
    call Func_005_6AE8
    ret

Func_005_7824:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_7843
    call Func_005_4A10
    ld a, c
    and a, a
    jr z, Jump_005_7843
    farcall Func_005_5CCE
    ld a, c
    and a, a
    jr z, Jump_005_7843
    ret

Jump_005_7843::
    call Func_005_6AE8
    ret

Func_005_7847:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call Func_005_44BD
    ld a, c
    and a, a
    jr z, Jump_005_785C
    call Func_005_49DD
    ld a, c
    and a, a
    jr z, Jump_005_785C
    ret

Jump_005_785C::
    call Func_005_6AE8
    ret

Func_005_7860:: ; heuristic: follows a terminator; C0
    call Func_005_7812
    ld a, c
    and a, a
    ret z
    call Func_005_44AB
    ld a, c
    and a, a
    jr z, Jump_005_7875
    call Func_005_49DD
    ld a, c
    and a, a
    jr z, Jump_005_7875
    ret

Jump_005_7875::
    call Func_005_6AE8
    ret

Func_005_7879:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_4A43
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    call Func_005_6229
    ld a, c
    and a, a
    jr z, Jump_005_78A4
    ret

Jump_005_78A4::
    call Func_005_6AE8
    ret

Func_005_78A8:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_78C6
    call Func_005_4949
    ld a, c
    and a, a
    jr z, Jump_005_78C6
    call Func_005_558B
    ld a, c
    and a, a
    jr z, Jump_005_78C6
    ld c, $FF
    ret

Jump_005_78C6::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_78CC:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_78E8
    call Func_005_4499
    ld a, c
    and a, a
    jr z, Jump_005_78E8
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_78E8
    ret

Jump_005_78E8::
    call Func_005_6AE8
    ret

Func_005_78EC::
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7909
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7909
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7909
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7909
    ret

Jump_005_7909::
    call Func_005_6AE8
    ret

Func_005_790D:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_791B
    ret

Jump_005_791B::
    call Func_005_6AE8
    ret

Func_005_791F:: ; heuristic: follows a terminator; C0
    call Func_005_78EC
    ld a, c
    and a, a
    ret z
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7942
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7942
    call Func_005_5DCD
    ld a, c
    and a, a
    jr z, Jump_005_7942
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7942
    ret

Jump_005_7942::
    call Func_005_6AE8
    ret

Func_005_7946:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_7971
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_7971
    ret

Jump_005_7971::
    call Func_005_6AE8
    ret

Func_005_7975:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7992
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7992
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7992
    call Func_005_626B
    ld a, c
    and a, a
    jr z, Jump_005_7992
    ret

Jump_005_7992::
    call Func_005_6AE8
    ret

Func_005_7996:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    call Func_005_4D56
    ld a, c
    and a, a
    jr z, Jump_005_79C1
    ret

Jump_005_79C1::
    call Func_005_6AE8
    ret

Func_005_79C5:: ; heuristic: follows a terminator; C0
    call Func_005_7616
    ld a, c
    and a, a
    ret z
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_79E1
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_79E1
    call Func_005_48C9
    ld a, c
    and a, a
    jr z, Jump_005_79E1
    ret

Jump_005_79E1::
    call Func_005_6AE8
    ret

Func_005_79E5:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    call Func_005_48C9
    ld a, c
    and a, a
    jr z, Jump_005_7A09
    ret

Jump_005_7A09::
    call Func_005_6AE8
    ret

Func_005_7A0D:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7A23
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7A23
    call Func_005_5DFF
    ld a, c
    and a, a
    jr z, Jump_005_7A23
    ret

Jump_005_7A23::
    call Func_005_6AE8
    ret

Func_005_7A27:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7A38
    call Func_005_4D6A
    ld a, c
    and a, a
    jr z, Jump_005_7A38
    ld c, $FF
    ret

Jump_005_7A38::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7A3E:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7A4F
    call Func_005_4880
    ld a, c
    and a, a
    jr z, Jump_005_7A4F
    ld c, $FF
    ret

Jump_005_7A4F::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7A55:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7A66
    call Func_005_4DA5
    ld a, c
    and a, a
    jr z, Jump_005_7A66
    ld c, $FF
    ret

Jump_005_7A66::
    call Func_005_6AE8
    ld c, $00
    ret

Func_005_7A6C:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7A8D
    call Func_005_41B9
    ld a, c
    and a, a
    jr z, Jump_005_7A8D
    call Func_005_432E
    ld a, c
    cp a, $01
    jr z, Jump_005_7A85
    and a, a
    jr z, Jump_005_7A8D

Jump_005_7A85::
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_7A8D
    ret

Jump_005_7A8D::
    call Func_005_6AE8
    ret

Func_005_7A91:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7AA0
    call Func_005_4B5F
    ld a, c
    and a, a
    jr z, Jump_005_7AA0
    ret

Jump_005_7AA0::
    call Func_005_6AE8
    ret

Func_005_7AA4:: ; heuristic: follows a terminator; C0
    call Func_005_4183
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call Func_005_4812
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call Func_005_53E6
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    call Func_005_623B
    ld a, c
    and a, a
    jr z, Jump_005_7AC8
    ret

Jump_005_7AC8::
    call Func_005_6AE8
    ret

Func_005_7ACC:: ; heuristic: follows a terminator; C0
    call Func_005_4707
    ld a, c
    and a, a
    jr z, Jump_005_7AD4
    ret

Jump_005_7AD4::
    call Func_005_6AE8
    ret

Func_005_7AD8:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call Func_005_4664
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    call Func_005_5DCD
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    farcall Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7B0D
    ret

Jump_005_7B0D::
    call Func_005_6AE8
    ret

Func_005_7B11:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call Func_005_4664
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    call Func_005_5DCD
    ld a, c
    and a, a
    jr z, Jump_005_7B3C
    ret

Jump_005_7B3C::
    call Func_005_6AE8
    ret

Func_005_7B40:: ; heuristic: follows a terminator; C0
    call Func_005_7AD8
    ld a, c
    and a, a
    ret z
    call Func_005_461F
    ld a, c
    and a, a
    jr z, Jump_005_7B58
    farcall Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7B58
    ret

Jump_005_7B58::
    call Func_005_6AE8
    ret

Func_005_7B5C:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call Func_005_43F2
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    call Func_005_4664
    ld a, c
    and a, a
    jr z, Jump_005_7B80
    ret

Jump_005_7B80::
    call Func_005_6AE8
    ret

Func_005_7B84:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_419E
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_43AD
    ld a, c
    cp a, $01
    jr z, Jump_005_7BAB
    and a, a
    jr z, Jump_005_7BBA

Jump_005_7BAB::
    call Func_005_45F3
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    call Func_005_4A76
    ld a, c
    and a, a
    jr z, Jump_005_7BBA
    ret

Jump_005_7BBA::
    call Func_005_6AE8
    ret

Func_005_7BBE:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call Func_005_45E1
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    call Func_005_63D2
    ld a, c
    and a, a
    jr z, Jump_005_7BE2
    ret

Jump_005_7BE2::
    call Func_005_6AE8
    ret

Func_005_7BE6:: ; heuristic: follows a terminator; C0
    call Func_005_6452
    ld a, c
    and a, a
    jp z, Func_005_6AE8

Func_005_7BEE::
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call Func_005_4C5D
    ld a, c
    and a, a
    jr z, Jump_005_7C0E
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7C06
    and a, a
    jr z, Jump_005_7C0E

Jump_005_7C06::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7C0E
    ret

Jump_005_7C0E::
    call Func_005_6AE8
    ret

Func_005_7C12:: ; heuristic: follows a terminator; C0
    call Func_005_7BEE
    ld a, c
    and a, a
    ret z
    call Func_005_459D
    ld a, c
    and a, a
    jr z, Jump_005_7C20
    ret

Jump_005_7C20::
    call Func_005_6AE8
    ret

Func_005_7C24::
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_7C41
    ret

Jump_005_7C41::
    call Func_005_6AE8
    ret

Func_005_7C45:: ; heuristic: follows a terminator; C0
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7C65
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7C5D
    and a, a
    jr z, Jump_005_7C65

Jump_005_7C5D::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7C65
    ret

Jump_005_7C65::
    call Func_005_6AE8
    ret

Func_005_7C69:: ; heuristic: follows a terminator; C0
    call Func_005_7C45
    ld a, c
    and a, a
    ret z
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7C7E
    call Func_005_5397
    ld a, c
    and a, a
    jr z, Jump_005_7C7E
    ret

Jump_005_7C7E::
    call Func_005_6AE8
    ret

Func_005_7C82:: ; heuristic: follows a terminator; C0
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7C9E
    call Func_005_4754
    ld a, c
    and a, a
    jr z, Jump_005_7C9E
    call Func_005_63D2
    ld a, c
    and a, a
    jr z, Jump_005_7C9E
    ret

Jump_005_7C9E::
    call Func_005_6AE8
    ret

Func_005_7CA2:: ; heuristic: follows a terminator; C0
    call Func_005_7C24
    ld a, c
    and a, a
    ret z
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7CBE
    call Func_005_4767
    ld a, c
    and a, a
    jr z, Jump_005_7CBE
    call Func_005_63D2
    ld a, c
    and a, a
    jr z, Jump_005_7CBE
    ret

Jump_005_7CBE::
    call Func_005_6AE8
    ret

Func_005_7CC2:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7CE3
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_7CE3
    call Func_005_44E1
    ld a, c
    cp a, $01
    jr z, Jump_005_7CDB
    and a, a
    jr z, Jump_005_7CE3

Jump_005_7CDB::
    call Func_005_61B1
    ld a, c
    and a, a
    jr z, Jump_005_7CE3
    ret

Jump_005_7CE3::
    call Func_005_6AE8
    ret

Func_005_7CE7:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7CEF
    ret

Jump_005_7CEF::
    call Func_005_6AE8
    ret

Func_005_7CF3:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_4221
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_4259
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_431C
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_4373
    ld a, c
    cp a, $01
    jr z, Jump_005_7D21
    and a, a
    jr z, Jump_005_7D57

Jump_005_7D21::
    call Func_005_4499
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_45E1
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_4767
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_5397
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7D48
    and a, a
    jr z, Jump_005_7D57

Jump_005_7D48::
    call Func_005_53E6
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    call Func_005_6452
    ld a, c
    and a, a
    jr z, Jump_005_7D57
    ret

Jump_005_7D57::
    call Func_005_6AE8
    ret

Func_005_7D5B:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7D89
    and a, a
    jr z, Jump_005_7D91

Jump_005_7D89::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7D91
    ret

Jump_005_7D91::
    call Func_005_6AE8
    ret

Func_005_7D95:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7DA4
    call Func_005_64DF
    ld a, c
    and a, a
    jr z, Jump_005_7DA4
    ret

Jump_005_7DA4::
    call Func_005_6AE8
    ret

Func_005_7DA8:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7DBE
    call Func_005_4B7A
    ld a, c
    and a, a
    jr z, Jump_005_7DBE
    call Func_005_4DF5
    ld a, c
    and a, a
    jr z, Jump_005_7DBE
    ret

Jump_005_7DBE::
    call Func_005_6AE8
    ret

Func_005_7DC2:: ; heuristic: follows a terminator; C0
    call Func_005_413F
    ld a, c
    and a, a
    jr z, Jump_005_7DD8
    call Func_005_41D6
    ld a, c
    and a, a
    jr z, Jump_005_7DD8
    call Func_005_626B
    ld a, c
    and a, a
    jr z, Jump_005_7DD8
    ret

Jump_005_7DD8::
    call Func_005_6AE8
    ret

Func_005_7DDC:: ; heuristic: follows a terminator; C0
    call Func_005_54FD
    ld a, c
    and a, a
    jr z, Jump_005_7DE4
    ret

Jump_005_7DE4::
    call Func_005_6AE8
    ret

Func_005_7DE8:: ; heuristic: follows a terminator; C0
    call Func_005_41FD
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    call Func_005_44CF
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    call Func_005_4605
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    call Func_005_6198
    ld a, c
    cp a, $01
    jr z, Jump_005_7E08
    and a, a
    jr z, Jump_005_7E10

Jump_005_7E08::
    call Func_005_5E3F
    ld a, c
    and a, a
    jr z, Jump_005_7E10
    ret

Jump_005_7E10::
    call Func_005_6AE8
    ret
    ds $1EC, $00
