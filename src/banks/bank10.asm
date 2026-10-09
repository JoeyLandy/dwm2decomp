SECTION "Bank 10", ROMX[$4000], BANK[$10]
    db $10

Func_010_4001::
    call Func_010_4008
    call Func_010_46E9
    ret

Func_010_4008::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C919]
    bit 7, a
    ret z
    and a, $7F
    ld [$C919], a
    ld a, $01
    ld [$C91F], a

Jump_010_401D::
    ld a, [$C91A]
    ld l, a
    ld a, [$C91B]
    ld h, a
    ld a, [$D7FD]
    and a, a
    jr z, Jump_010_4032
    call Func_000_0B6C
    ld a, b
    inc hl
    jr Jump_010_4033

Jump_010_4032::
    ld a, [hl+]

Jump_010_4033::
    cp a, $FF
    jr nz, Jump_010_4054
    xor a, a
    ld [$C91F], a
    ld [$C920], a
    ld [$D7FD], a
    ld a, [$CC44]
    bit 7, a
    jr nz, Jump_010_404E
    ld a, $00
    ld [$C5DC], a
    ret

Jump_010_404E::
    ld a, $05
    ld [$C5DC], a
    ret

Jump_010_4054::
    push hl
    rst $00
    dw Jump_010_42B3
    dw Jump_010_42E8
    dw Jump_010_42EF
    dw Jump_010_430F
    dw Jump_010_4326
    dw Jump_010_4343
    dw Jump_010_4367
    dw Jump_010_43C9
    db $00, $00, $00, $00, $EA, $43
    dw Func_010_43FD
    dw Func_010_4414
    dw Func_010_442E
    dw Func_010_4445
    dw Func_010_445D
    db $00, $00
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4490
    dw Func_010_44CA
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_44FB
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_450D
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4248
    dw Func_010_4252
    dw Func_010_4248
    dw Func_010_426E
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4297
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    db $00, $00
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    dw Func_010_4248
    ds $3C, $00
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    dw Func_010_4486
    ds $20, $00
    dw Func_010_451F
    dw Func_010_4529
    dw Func_010_4533
    dw Func_010_453D
    db $94, $46, $47, $45, $51, $45, $7E, $46
    dw Func_010_455B
    dw Func_010_4565
    dw Func_010_4637
    dw Func_010_456F
    dw Func_010_4579
    dw Func_010_4583
    dw Func_010_458D
    dw Func_010_4597
    dw Func_010_45A1
    dw Func_010_45AB
    dw Func_010_45B5
    dw Func_010_45BF
    dw Func_010_45C9
    dw Func_010_45D3
    dw Func_010_4619
    dw Func_010_4623
    dw Func_010_462D

Func_010_4248:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4252:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $81
    ld [$C920], a
    xor a, a
    ld [$C923], a
    ld [$C924], a
    ld [$C925], a
    ld [$C926], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Func_010_426E:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $83
    ld [$C920], a
    call Func_010_46CD
    ld a, [$C195]
    and a, $03
    dec a
    jr nz, Jump_010_4291
    ldh a, [$FF8C]
    bit 3, a
    jr nz, Jump_010_428B
    ld a, $01
    ld [$C922], a
    ret

Jump_010_428B::
    ld a, $03
    ld [$C922], a
    ret

Jump_010_4291::
    ld a, $02
    ld [$C922], a
    ret

Func_010_4297:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $86
    ld [$C920], a
    xor a, a
    ld [$C923], a
    ld [$C924], a
    ld [$C925], a
    ld [$C926], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Jump_010_42B3::
    pop hl
    ld a, [$D7FD]
    and a, a
    jr z, Jump_010_42CE
    ld a, $01
    ld [$C920], a
    call Func_000_0B6C
    ld a, b
    ld [$C921], a
    ld a, c
    ld [$C922], a
    inc hl
    inc hl
    jr Jump_010_42DB

Jump_010_42CE::
    ld a, $01
    ld [$C920], a
    ld a, [hl+]
    ld [$C921], a
    ld a, [hl+]
    ld [$C922], a

Jump_010_42DB::
    xor a, a
    ld [$C923], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Jump_010_42E8::
    ld a, $02
    ld [$C920], a
    jr Jump_010_42F4

Jump_010_42EF::
    ld a, $03
    ld [$C920], a

Jump_010_42F4::
    pop hl
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    swap a
    or a, c
    ld [$C921], a
    ld a, [hl+]
    ld [$C922], a
    xor a, a
    ld [$C923], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Jump_010_430F::
    pop hl
    ld a, $04
    ld [$C920], a
    ld a, [hl+]
    ld [$C921], a
    ld a, [hl+]
    ld [$C922], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Jump_010_4326::
    pop hl
    ld a, $05
    ld [$C920], a
    ld a, [hl+]
    ld [$C921], a
    ld a, [hl+]
    ld [$C922], a
    xor a, a
    ld [$C923], a
    ldh [$FF9A], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Jump_010_4343::
    pop hl
    ld a, $06
    ld [$C920], a
    ld a, [hl+]
    ld [$C921], a
    ld a, [hl+]
    ld [$C922], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Func_010_435A::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Func_010_435A
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Func_010_435A
    ret

Jump_010_4367::
    push bc
    push de
    ld hl, $C89E
    ld de, $8EE0
    ld c, $10
    call Func_010_435A
    ld hl, $C8AE
    ld de, $8EF0
    ld c, $10
    call Func_010_435A
    pop de
    pop bc
    pop hl
    ld a, [$D7FD]
    and a, a
    jr z, Jump_010_43A6
    ld a, [$C552]
    or a, a
    jr nz, Jump_010_43A3
    call Func_000_0B6C
    inc hl
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_010_4398
    inc h

Jump_010_4398::
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    jp Jump_010_401D

Jump_010_43A3::
    inc hl
    jr Jump_010_4398

Jump_010_43A6::
    ld a, [$C552]
    or a, a
    jr nz, Jump_010_43BD
    ld a, [hl+]
    add a, l
    ld l, a
    jr nc, Jump_010_43B2
    inc h

Jump_010_43B2::
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    jp Jump_010_401D

Jump_010_43BD::
    inc hl
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    jp Jump_010_401D

Jump_010_43C9::
    pop hl
    ld a, [$D7FD]
    and a, a
    jr z, Jump_010_43DF
    call Func_000_0B6C
    ld a, b
    ld [$C91A], a
    ld a, c
    ld [$C91B], a
    inc hl
    jp Jump_010_401D

Jump_010_43DF::
    ld a, [hl+]
    ld [$C91A], a
    ld a, [hl]
    ld [$C91B], a
    jp Jump_010_401D
    db $E1, $2A, $5F, $2A, $57, $7D, $EA, $1A, $C9, $7C, $EA, $1B, $C9, $CD, $45, $18
    db $C3, $1D, $40

Func_010_43FD:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $0C
    ld [$C920], a
    ld a, [hl+]
    ld [$C922], a
    xor a, a
    ld [$C921], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Func_010_4414:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    swap a
    ld de, $CB8B
    add a, e
    ld e, a
    jr nc, Jump_010_4420
    inc d

Jump_010_4420::
    ld a, $E0
    ld [de], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    jp Jump_010_401D

Func_010_442E:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $0E
    ld [$C920], a
    ld a, [hl+]
    ld [$C921], a
    xor a, a
    ld [$C923], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Func_010_4445:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, [hl+]
    ldh [$FFC7], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ld hl, Func_012_7EC2
    ld b, $12
    rst $10
    jp Jump_010_401D

Func_010_445D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    push af
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    pop af
    cp a, $FF
    jr z, Jump_010_447D
    cp a, $60
    jr c, Jump_010_4477
    call Func_000_1278
    jp Jump_010_401D

Jump_010_4477::
    call Func_000_122D
    jp Jump_010_401D

Jump_010_447D::
    ld hl, Func_002_604B
    ld b, $02
    rst $10
    jp Jump_010_401D

Func_010_4486:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4490:: ; heuristic: target of a pointer table; C0
    pop hl
    ldh a, [$FF98]
    inc a
    inc a
    and a, $03
    ld [$C8EF], a
    ld a, $1C
    ld [$C920], a
    call Func_010_46CD
    ld de, $0000
    call Func_000_181B
    jr c, Jump_010_44BA
    ld hl, $0088
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Jump_010_44BA::
    ld hl, $0087
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Func_010_44CA:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $1D
    ld [$C920], a
    call Func_010_46CD
    ld de, $0000
    call Func_000_181B
    jr c, Jump_010_44EB
    ld hl, $4097
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Jump_010_44EB::
    ld hl, $408D
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Func_010_44FB:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [$CC38]
    set 2, a
    ld [$CC38], a
    ld a, $23
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_450D:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [$C920], a
    ld a, [$C922]
    push af
    call Func_010_46CD
    pop af
    ld [$C922], a
    ret

Func_010_451F:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E0
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4529:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E1
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4533:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E2
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_453D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E3
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4547:: ; heuristic: follows a terminator; C0
    pop hl
    ld a, $E5
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4551:: ; heuristic: follows a terminator; C0
    pop hl
    ld a, $E6
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_455B:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E8
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4565:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E9
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_456F:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EB
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4579:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EC
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4583:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $ED
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_458D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EE
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4597:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EF
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_45A1:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F0
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_45AB:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F1
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_45B5:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F2
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_45BF:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F3
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_45C9:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F4
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_45D3:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [$D7FD]
    and a, a
    jr z, Jump_010_45EE
    ld a, $01
    ld [$C920], a
    call Func_000_0B6C
    ld a, b
    ld [$C921], a
    ld a, c
    ld [$C922], a
    inc hl
    inc hl
    jr Jump_010_45FB

Jump_010_45EE::
    ld a, $01
    ld [$C920], a
    ld a, [hl+]
    ld [$C921], a
    ld a, [hl+]
    ld [$C922], a

Jump_010_45FB::
    push hl
    ld a, [$D7FB]
    add a, a
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, [$C921]
    add a, b
    ld [$C921], a
    pop hl
    xor a, a
    ld [$C923], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Func_010_4619:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F6
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4623:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F7
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_462D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F8
    ld [$C920], a
    call Func_010_46CD
    ret

Func_010_4637:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [$D7FD]
    and a, a
    jr z, Jump_010_4652
    ld a, $01
    ld [$C920], a
    call Func_000_0B6C
    ld a, b
    ld [$C921], a
    ld a, c
    ld [$C922], a
    inc hl
    inc hl
    jr Jump_010_465F

Jump_010_4652::
    ld a, $01
    ld [$C920], a
    ld a, [hl+]
    ld [$C921], a
    ld a, [hl+]
    ld [$C922], a

Jump_010_465F::
    push hl
    ld de, $0000
    call Func_000_181B
    jr c, Jump_010_4670
    ld a, [$C921]
    add a, $20
    ld [$C921], a

Jump_010_4670::
    pop hl
    xor a, a
    ld [$C923], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $04067E, $4F

Func_010_46CD::
    xor a, a
    ld [$C921], a
    ld [$C922], a
    ld [$C923], a
    ld [$C924], a
    ld [$C925], a
    ld [$C926], a
    ld a, l
    ld [$C91A], a
    ld a, h
    ld [$C91B], a
    ret

Func_010_46E9::
    ld a, [$C56C]
    or a, a
    ret nz
    ld a, [$C920]
    or a, a
    ret z
    dec a
    rst $00
    dw Jump_010_4A1B
    dw Jump_010_49E7
    dw Jump_010_49E1
    dw Jump_010_49DA
    dw Jump_010_49D3
    dw Jump_010_49CC
    INCBIN "dwm2-cobi-us.gbc", $040701, $F2
    dw Func_010_4986
    dw Func_010_498D
    dw Func_010_499B
    dw Func_010_49A2
    dw Func_010_49A9
    dw Func_010_49B0
    dw Func_010_4994
    dw Func_010_49B7
    dw Func_010_49BE
    dw Func_010_49C5
    dw Func_010_497F
    dw Func_010_4955
    dw Func_010_494E
    dw Func_010_4947
    dw Func_010_4978
    dw Func_010_495C
    dw Func_010_4924
    dw Func_010_492B
    dw Func_010_4932
    dw Func_010_4939
    dw Func_010_4940
    dw Func_010_4916
    dw Func_010_491D
    db $00, $00
    dw Func_010_490F
    dw Func_010_4908
    dw Func_010_4901
    dw Func_010_48FA
    dw Func_010_48F3
    dw Func_010_48EC
    dw Func_010_48E5
    dw Func_010_4963
    dw Func_010_496A
    dw Func_010_4971
    ds $3C, $00
    db $E4, $4E, $EB, $4E, $F2, $4E, $F9, $4E, $07, $4F, $0E, $4F, $00, $4F, $15, $4F
    db $1C, $4F, $23, $4F, $2A, $4F, $31, $4F, $38, $4F, $3F, $4F, $46, $4F, $4D, $4F
    ds $20, $00
    dw Func_010_65BF
    dw Func_010_65C6
    dw Func_010_65CD
    dw Func_010_65D4
    db $00, $00, $DB, $65, $E2, $65, $00, $00, $E9, $65, $F0, $65, $1B, $4A
    dw Func_010_65F7
    dw Func_010_65FE
    dw Func_010_6605
    dw Func_010_660C
    dw Func_010_6613
    dw Func_010_661A
    dw Func_010_6621
    dw Func_010_6628
    dw Func_010_662F
    dw Func_010_6636
    db $1B, $4A, $44, $66, $4B, $66, $52, $66

Func_010_48E5:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_59AC
    ld b, $12
    rst $10
    ret

Func_010_48EC:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4001
    ld b, $12
    rst $10
    ret

Func_010_48F3:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4013
    ld b, $12
    rst $10
    ret

Func_010_48FA:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_550E
    ld b, $12
    rst $10
    ret

Func_010_4901:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4030
    ld b, $12
    rst $10
    ret

Func_010_4908:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4064
    ld b, $12
    rst $10
    ret

Func_010_490F:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4210
    ld b, $12
    rst $10
    ret

Func_010_4916:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_44DB
    ld b, $12
    rst $10
    ret

Func_010_491D:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_43DA
    ld b, $12
    rst $10
    ret

Func_010_4924:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4F1E
    ld b, $12
    rst $10
    ret

Func_010_492B:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4EF9
    ld b, $12
    rst $10
    ret

Func_010_4932:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4ECE
    ld b, $12
    rst $10
    ret

Func_010_4939:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4E55
    ld b, $12
    rst $10
    ret

Func_010_4940:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4E4B
    ld b, $12
    rst $10
    ret

Func_010_4947:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4A1E
    ld b, $12
    rst $10
    ret

Func_010_494E:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4A9A
    ld b, $12
    rst $10
    ret

Func_010_4955:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4C07
    ld b, $12
    rst $10
    ret

Func_010_495C:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4965
    ld b, $12
    rst $10
    ret

Func_010_4963:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4919
    ld b, $12
    rst $10
    ret

Func_010_496A:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_4FEA
    ld b, $12
    rst $10
    ret

Func_010_4971:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_50B3
    ld b, $12
    rst $10
    ret

Func_010_4978:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_50E5
    ld b, $12
    rst $10
    ret

Func_010_497F:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_51F4
    ld b, $12
    rst $10
    ret

Func_010_4986:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_63A1
    ld b, $12
    rst $10
    ret

Func_010_498D:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_630E
    ld b, $12
    rst $10
    ret

Func_010_4994:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_6211
    ld b, $12
    rst $10
    ret

Func_010_499B:: ; heuristic: target of a pointer table; C0
    ld hl, Func_073_4001
    ld b, $73
    rst $10
    ret

Func_010_49A2:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_5CE5
    ld b, $12
    rst $10
    ret

Func_010_49A9:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_5A2F
    ld b, $12
    rst $10
    ret

Func_010_49B0:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_5854
    ld b, $12
    rst $10
    ret

Func_010_49B7:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_5728
    ld b, $12
    rst $10
    ret

Func_010_49BE:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_55E8
    ld b, $12
    rst $10
    ret

Func_010_49C5:: ; heuristic: target of a pointer table; C0
    ld hl, Func_012_5534
    ld b, $12
    rst $10
    ret

Jump_010_49CC::
    ld hl, Func_05F_78CE
    ld b, $5F
    rst $10
    ret

Jump_010_49D3::
    ld hl, Func_05F_787C
    ld b, $5F
    rst $10
    ret

Jump_010_49DA::
    ld hl, Func_05F_785C
    ld b, $5F
    rst $10
    ret

Jump_010_49E1::
    ld hl, Func_05F_77D8
    ld b, $5F
    rst $10

Jump_010_49E7::
    ld hl, Func_05F_77D8
    ld b, $5F
    rst $10
    ret

Func_010_49EE:: ; heuristic: follows a terminator; C0
    ld hl, Func_05F_7969
    ld b, $5F
    rst $10
    ret
    db $FA, $23, $C9, $C7, $27, $4A, $67, $4A, $84, $4A, $01, $4A, $FA, $CB, $C8, $E6
    db $03, $C0, $21, $9F, $44, $06, $04, $D7, $AF, $EA, $20, $C9, $AF, $EA, $1F, $C9
    db $3E, $00, $EA, $DC, $C5, $C9

Jump_010_4A1B::
    ld a, [$C923]
    rst $00
    dw Jump_010_4A27
    dw Jump_010_4A67
    dw Jump_010_4A84
    dw Jump_010_4AB3

Jump_010_4A27::
    ld a, [$C922]
    bit 7, a
    jr nz, Jump_010_4A62
    ld hl, Func_004_4470
    ld b, $04
    rst $10
    ld hl, $8800
    ld de, $1202
    call Func_000_2E98
    call Func_000_290E
    ld a, $69
    call Func_000_1278
    ld a, $01
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $02
    ldh [$FFB9], a
    ldh a, [$FF91]
    cp a, $48
    jr c, Jump_010_4A62
    ld a, $81
    ld [$C8CB], a
    ld a, $01
    ldh [$FFB9], a

Jump_010_4A62::
    ld hl, $C923
    inc [hl]
    ret

Jump_010_4A67::
    ld a, [$C922]
    bit 7, a
    jr nz, Jump_010_4A74
    ld a, [$C8CB]
    and a, $03
    ret nz

Jump_010_4A74::
    ld a, [$C921]
    ld l, a
    ld a, [$C922]
    ld h, a
    call Func_010_4AD0
    ld hl, $C923
    inc [hl]
    ret

Jump_010_4A84::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld a, [$C922]
    bit 6, a
    jr nz, Jump_010_4AAE
    ld a, $69
    call Func_000_1278
    xor a, a
    ldh [$FFB9], a
    ld a, $02
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ldh a, [$FF91]
    cp a, $48
    jr c, Jump_010_4AAE
    ld a, $82
    ld [$C8CB], a

Jump_010_4AAE::
    ld hl, $C923
    inc [hl]
    ret

Jump_010_4AB3::
    ld a, [$C922]
    bit 6, a
    jr nz, Jump_010_4AC6
    ld a, [$C8CB]
    and a, $03
    ret nz
    ld hl, Func_004_449F
    ld b, $04
    rst $10

Jump_010_4AC6::
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_010_4AD0::
    ld a, h
    and a, $3F
    ld h, a
    push hl
    ld a, [$D7F0]
    and a, a
    jr z, Jump_010_4B20
    dec a
    ld c, a
    sla a
    add a, c
    ld de, Data_010_4AFF
    add a, e
    ld e, a
    jr nc, Jump_010_4AE8
    inc d

Jump_010_4AE8::
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld d, a
    pop hl
    ld a, l
    ld [$C529], a
    ld a, $00
    ld [$C528], a
    ld l, c
    ld h, b
    ld b, d
    rst $10
    ret

Data_010_4AFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $F0, $01, $40, $F0, $0E, $52, $1F, $01, $40, $1D, $86, $4C, $1B, $D0
    db $43, $F2, $01, $40, $0D, $01, $40, $0E, $01, $40, $0B, $90, $64, $33, $10, $5D
    db $24

Jump_010_4B20::
    pop hl
    ld a, [$CC44]
    cp a, $80
    jr z, Jump_010_4B2D
    bit 7, a
    jp nz, Jump_010_4BA7

Jump_010_4B2D::
    ld a, l
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld a, h
    rst $00
    dw Jump_010_4B53
    dw Jump_010_4B5A
    dw Jump_010_4B61
    dw Jump_010_4B68
    dw Jump_010_4B6F
    dw Jump_010_4B76
    dw Jump_010_4B7D
    dw Jump_010_4B7D
    dw Jump_010_4B84
    dw Jump_010_4B8B
    dw Jump_010_4B8B
    dw Jump_010_4B92
    dw Jump_010_4B99
    dw Jump_010_4BA0

Jump_010_4B53::
    ld hl, Func_028_4001
    ld b, $28
    rst $10
    ret

Jump_010_4B5A::
    ld hl, Func_029_4001
    ld b, $29
    rst $10
    ret

Jump_010_4B61::
    ld hl, Func_02A_4001
    ld b, $2A
    rst $10
    ret

Jump_010_4B68::
    ld hl, Func_02B_4001
    ld b, $2B
    rst $10
    ret

Jump_010_4B6F::
    ld hl, Func_02C_4001
    ld b, $2C
    rst $10
    ret

Jump_010_4B76::
    ld hl, Func_02D_4001
    ld b, $2D
    rst $10
    ret

Jump_010_4B7D::
    ld hl, Func_02E_4001
    ld b, $2E
    rst $10
    ret

Jump_010_4B84::
    ld hl, Func_07C_4001
    ld b, $7C
    rst $10
    ret

Jump_010_4B8B::
    ld hl, Func_080_4001
    ld b, $80
    rst $10
    ret

Jump_010_4B92::
    ld hl, Func_082_4001
    ld b, $82
    rst $10
    ret

Jump_010_4B99::
    ld hl, Func_086_4001
    ld b, $86
    rst $10
    ret

Jump_010_4BA0::
    ld hl, Func_089_4001
    ld b, $89
    rst $10
    ret

Jump_010_4BA7::
    ld a, h
    or a, a
    jr nz, Jump_010_4BBE
    ld a, l
    cp a, $20
    jr c, Jump_010_4BBE
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, Func_083_4001
    ld b, $83
    rst $10
    ret

Jump_010_4BBE::
    ld a, l
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, Func_08A_4001
    ld b, $8A
    rst $10
    ret

Func_010_4BCD:: ; heuristic: follows a terminator; C0
    ld hl, Func_05F_7907
    ld b, $5F
    rst $10
    ret

Func_010_4BD4:: ; heuristic: follows a terminator; C0
    ld hl, Func_05F_7AB2
    ld b, $5F
    rst $10
    ret

Func_010_4BDB:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_79F4
    ld b, $73
    rst $10
    ret

Func_010_4BE2:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_77CC
    ld b, $73
    rst $10
    ret

Func_010_4BE9:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_765D
    ld b, $73
    rst $10
    ret

Func_010_4BF0:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_75DD
    ld b, $73
    rst $10
    ret

Func_010_4BF7:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_73A0
    ld b, $73
    rst $10
    ret

Func_010_4BFE:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_7024
    ld b, $73
    rst $10
    ret

Func_010_4C05:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_758C
    ld b, $73
    rst $10
    ret

Func_010_4C0C:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_567B
    ld b, $85
    rst $10
    ret

Func_010_4C13:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6F5B
    ld b, $73
    rst $10
    ret

Func_010_4C1A:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6F14
    ld b, $73
    rst $10
    ret

Func_010_4C21:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4617
    ld b, $85
    rst $10
    ret

Func_010_4C28:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7A2D
    ld b, $0F
    rst $10
    ret

Func_010_4C2F:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_786F
    ld b, $0F
    rst $10
    ret

Func_010_4C36:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6E5F
    ld b, $73
    rst $10
    ret

Func_010_4C3D:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_772E
    ld b, $0F
    rst $10
    ret

Func_010_4C44:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6F7C
    ld b, $73
    rst $10
    ret

Func_010_4C4B:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6EE7
    ld b, $73
    rst $10
    ret

Func_010_4C52:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_55F5
    ld b, $85
    rst $10
    ret

Func_010_4C59:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7625
    ld b, $0F
    rst $10
    ret

Func_010_4C60:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_546F
    ld b, $85
    rst $10
    ret

Func_010_4C67:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6EBA
    ld b, $73
    rst $10
    ret

Func_010_4C6E:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6E17
    ld b, $73
    rst $10
    ret

Func_010_4C75:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_72D9
    ld b, $0F
    rst $10
    ret

Func_010_4C7C:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7271
    ld b, $0F
    rst $10
    ret

Func_010_4C83:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_70EC
    ld b, $0F
    rst $10
    ret

Func_010_4C8A:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4047
    ld b, $85
    rst $10
    ret

Func_010_4C91:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6B98
    ld b, $73
    rst $10
    ret

Func_010_4C98:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6B5B
    ld b, $73
    rst $10
    ret

Func_010_4C9F:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6AFF
    ld b, $73
    rst $10
    ret

Func_010_4CA6:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6AEF
    ld b, $73
    rst $10
    ret

Func_010_4CAD:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6ABE
    ld b, $73
    rst $10
    ret

Func_010_4CB4:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6A91
    ld b, $73
    rst $10
    ret

Func_010_4CBB:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_5421
    ld b, $85
    rst $10
    ret

Func_010_4CC2:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7093
    ld b, $0F
    rst $10
    ret

Func_010_4CC9:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6969
    ld b, $73
    rst $10
    ret

Func_010_4CD0:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6941
    ld b, $73
    rst $10
    ret

Func_010_4CD7:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_679F
    ld b, $73
    rst $10
    ret

Func_010_4CDE:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7049
    ld b, $0F
    rst $10
    ret

Func_010_4CE5:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_6F65
    ld b, $0F
    rst $10
    ret

Func_010_4CEC:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_6D2B
    ld b, $0F
    rst $10
    ret

Func_010_4CF3:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_67BA
    ld b, $0F
    rst $10
    ret

Func_010_4CFA:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_65B0
    ld b, $73
    rst $10
    ret

Func_010_4D01:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_67BA
    ld b, $0F
    rst $10
    ret

Func_010_4D08:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_630F
    ld b, $73
    rst $10
    ret

Func_010_4D0F:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_61A7
    ld b, $73
    rst $10
    ret

Func_010_4D16:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6126
    ld b, $73
    rst $10
    ret

Func_010_4D1D:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_60FE
    ld b, $73
    rst $10
    ret

Func_010_4D24:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_6681
    ld b, $0F
    rst $10
    ret

Func_010_4D2B:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_60E6
    ld b, $0F
    rst $10
    ret

Func_010_4D32:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_64F3
    ld b, $0F
    rst $10
    ret

Func_010_4D39:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_631F
    ld b, $0F
    rst $10
    ret

Func_010_4D40:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6079
    ld b, $73
    rst $10
    ret

Func_010_4D47:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_6277
    ld b, $0F
    rst $10
    ret

Func_010_4D4E:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_5F06
    ld b, $0F
    rst $10
    ret

Func_010_4D55:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_6038
    ld b, $73
    rst $10
    ret

Func_010_4D5C:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_5D9D
    ld b, $0F
    rst $10
    ret

Func_010_4D63:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_5C3B
    ld b, $0F
    rst $10
    ret

Func_010_4D6A:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_59E6
    ld b, $0F
    rst $10
    ret

Func_010_4D71:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_57EA
    ld b, $0F
    rst $10
    ret

Func_010_4D78:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5FBC
    ld b, $73
    rst $10
    ret

Func_010_4D7F:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4207
    ld b, $85
    rst $10
    ret

Func_010_4D86:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_56CD
    ld b, $0F
    rst $10
    ret

Func_010_4D8D:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5F39
    ld b, $73
    rst $10
    ret

Func_010_4D94:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5EB3
    ld b, $73
    rst $10
    ret

Func_010_4D9B:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5DDD
    ld b, $73
    rst $10
    ret

Func_010_4DA2:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5DAF
    ld b, $73
    rst $10
    ret

Func_010_4DA9:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5C5F
    ld b, $73
    rst $10
    ret

Func_010_4DB0:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5AE4
    ld b, $73
    rst $10
    ret

Func_010_4DB7:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5AD6
    ld b, $73
    rst $10
    ret

Func_010_4DBE:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5ABB
    ld b, $73
    rst $10
    ret

Func_010_4DC5:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5A16
    ld b, $73
    rst $10
    ret

Func_010_4DCC:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_5404
    ld b, $0F
    rst $10
    ret

Func_010_4DD3:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5987
    ld b, $73
    rst $10
    ret

Func_010_4DDA:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5987
    ld b, $73
    rst $10
    ret

Func_010_4DE1:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_5248
    ld b, $85
    rst $10
    ret

Func_010_4DE8:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5919
    ld b, $73
    rst $10
    ret

Func_010_4DEF:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_58FE
    ld b, $73
    rst $10
    ret

Func_010_4DF6:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_4595
    ld b, $0F
    rst $10
    ret

Func_010_4DFD:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_40E9
    ld b, $0F
    rst $10
    ret

Func_010_4E04:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_587A
    ld b, $73
    rst $10
    ret

Func_010_4E0B:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5761
    ld b, $73
    rst $10
    ret

Func_010_4E12:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_409A
    ld b, $0F
    rst $10
    ret

Func_010_4E19:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_572F
    ld b, $73
    rst $10
    ret

Func_010_4E20:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_571D
    ld b, $73
    rst $10
    ret

Func_010_4E27:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_5065
    ld b, $85
    rst $10
    ret

Func_010_4E2E:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_5AF3
    ld b, $0F
    rst $10
    ret

Func_010_4E35:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5D71
    ld b, $73
    rst $10
    ret

Func_010_4E3C:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5A57
    ld b, $73
    rst $10
    ret

Func_010_4E43:: ; heuristic: follows a terminator; C0
    ld hl, $532C
    ld b, $85
    rst $10
    ret

Func_010_4E4A:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7D97
    ld b, $0F
    rst $10
    ret

Func_010_4E51:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7D62
    ld b, $0F
    rst $10
    ret

Func_010_4E58:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4D8D
    ld b, $85
    rst $10
    ret

Func_010_4E5F:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4C24
    ld b, $85
    rst $10
    ret

Func_010_4E66:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4B0F
    ld b, $85
    rst $10
    ret

Func_010_4E6D:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4AEE
    ld b, $85
    rst $10
    ret

Func_010_4E74:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4A6D
    ld b, $85
    rst $10
    ret

Func_010_4E7B:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_494D
    ld b, $85
    rst $10
    ret

Func_010_4E82:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_48A0
    ld b, $85
    rst $10
    ret

Func_010_4E89:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_505A
    ld b, $85
    rst $10
    ret

Func_010_4E90:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4858
    ld b, $85
    rst $10
    ret

Func_010_4E97:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7CFB
    ld b, $0F
    rst $10
    ret

Func_010_4E9E:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7CA5
    ld b, $0F
    rst $10
    ret

Func_010_4EA5:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_7AC6
    ld b, $0F
    rst $10
    ret

Func_010_4EAC:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4717
    ld b, $85
    rst $10
    ret

Func_010_4EB3:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4DA6
    ld b, $85
    rst $10
    ret

Func_010_4EBA:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_46E4
    ld b, $85
    rst $10
    ret

Func_010_4EC1:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_49FA
    ld b, $85
    rst $10
    ret

Func_010_4EC8:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4A2B
    ld b, $85
    rst $10
    ret

Func_010_4ECF:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4755
    ld b, $85
    rst $10
    ret

Func_010_4ED6:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_481C
    ld b, $85
    rst $10
    ret

Func_010_4EDD:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_479B
    ld b, $85
    rst $10
    ret

Func_010_4EE4:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_568E
    ld b, $73
    rst $10
    ret

Func_010_4EEB:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_55C5
    ld b, $73
    rst $10
    ret

Func_010_4EF2:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4F14
    ld b, $85
    rst $10
    ret

Func_010_4EF9:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_55A4
    ld b, $73
    rst $10
    ret

Func_010_4F00:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5577
    ld b, $73
    rst $10
    ret

Func_010_4F07:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_50F2
    ld b, $85
    rst $10
    ret

Func_010_4F0E:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5449
    ld b, $73
    rst $10
    ret

Func_010_4F15:: ; heuristic: follows a terminator; C0
    ld hl, Func_00F_4001
    ld b, $0F
    rst $10
    ret

Func_010_4F1C:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_541D
    ld b, $73
    rst $10
    ret

Func_010_4F23:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_53AB
    ld b, $73
    rst $10
    ret

Func_010_4F2A:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5378
    ld b, $73
    rst $10
    ret

Func_010_4F31:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_51BD
    ld b, $73
    rst $10
    ret

Func_010_4F38:: ; heuristic: follows a terminator; C0
    ld hl, Func_073_5546
    ld b, $73
    rst $10
    ret

Func_010_4F3F:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_501A
    ld b, $85
    rst $10
    ret

Func_010_4F46:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_403D
    ld b, $85
    rst $10
    ret

Func_010_4F4D:: ; heuristic: follows a terminator; C0
    ld hl, Func_085_4001
    ld b, $85
    rst $10
    ret
    INCBIN "dwm2-cobi-us.gbc", $040F54, $166B

Func_010_65BF:: ; heuristic: target of a pointer table; C0
    ld hl, Func_01C_4075
    ld b, $1C
    rst $10
    ret

Func_010_65C6:: ; heuristic: target of a pointer table; C0
    ld hl, Func_01C_4001
    ld b, $1C
    rst $10
    ret

Func_010_65CD:: ; heuristic: target of a pointer table; C0
    ld hl, Func_01C_4696
    ld b, $1C
    rst $10
    ret

Func_010_65D4:: ; heuristic: target of a pointer table; C0
    ld hl, Func_01C_4605
    ld b, $1C
    rst $10
    ret

Func_010_65DB:: ; heuristic: follows a terminator; C0
    ld hl, Func_01C_6CEF
    ld b, $1C
    rst $10
    ret

Func_010_65E2:: ; heuristic: follows a terminator; C0
    ld hl, Func_01C_6CEB
    ld b, $1C
    rst $10
    ret

Func_010_65E9:: ; heuristic: follows a terminator; C0
    ld hl, Func_01E_4069
    ld b, $1E
    rst $10
    ret

Func_010_65F0:: ; heuristic: follows a terminator; C0
    ld hl, Func_01E_4001
    ld b, $1E
    rst $10
    ret

Func_010_65F7:: ; heuristic: target of a pointer table; C0
    ld hl, Func_014_40CC
    ld b, $14
    rst $10
    ret

Func_010_65FE:: ; heuristic: target of a pointer table; C0
    ld hl, Func_014_4001
    ld b, $14
    rst $10
    ret

Func_010_6605:: ; heuristic: target of a pointer table; C0
    ld hl, Func_015_40FA
    ld b, $15
    rst $10
    ret

Func_010_660C:: ; heuristic: target of a pointer table; C0
    ld hl, Func_015_4001
    ld b, $15
    rst $10
    ret

Func_010_6613:: ; heuristic: target of a pointer table; C0
    ld hl, $45D1
    ld b, $0D
    rst $10
    ret

Func_010_661A:: ; heuristic: target of a pointer table; C0
    ld hl, Func_00D_5159
    ld b, $0D
    rst $10
    ret

Func_010_6621:: ; heuristic: target of a pointer table; C0
    ld hl, Func_00D_50E5
    ld b, $0D
    rst $10
    ret

Func_010_6628:: ; heuristic: target of a pointer table; C0
    ld hl, Func_00D_55BE
    ld b, $0D
    rst $10
    ret

Func_010_662F:: ; heuristic: target of a pointer table; C0
    ld hl, Func_00D_6310
    ld b, $0D
    rst $10
    ret

Func_010_6636:: ; heuristic: target of a pointer table; C0
    ld hl, Func_00D_711C
    ld b, $0D
    rst $10
    ret

Func_010_663D:: ; heuristic: follows a terminator; C0
    ld hl, Func_00D_7115
    ld b, $0D
    rst $10
    ret

Func_010_6644:: ; heuristic: follows a terminator; C0
    ld hl, Func_00C_4001
    ld b, $0C
    rst $10
    ret

Func_010_664B:: ; heuristic: follows a terminator; C0
    ld hl, Func_00C_659F
    ld b, $0C
    rst $10
    ret

Func_010_6652:: ; heuristic: follows a terminator; C0
    ld hl, Func_024_60DB
    ld b, $24
    rst $10
    ret
    INCBIN "dwm2-cobi-us.gbc", $042659, $2CF
    ds $16D8, $00
