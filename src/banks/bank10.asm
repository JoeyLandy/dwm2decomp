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
    db $00, $00, $00

Data_010_4069:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $EA, $43
    dw Func_010_43FD
    dw Func_010_4414
    dw Func_010_442E
    dw Func_010_4445
    db $5D

Data_010_4075:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $44, $00, $00
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
    ds $11, $00

Data_010_4207:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_010_4210:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00
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
    ld hl, Data_010_7EC2
    ld b, $12
    rst $10
    jp Jump_010_401D
    db $E1, $2A, $F5, $7D, $EA, $1A, $C9, $7C, $EA, $1B, $C9, $F1, $FE, $FF, $28, $10
    db $FE, $60, $38

Data_010_4470:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $06, $CD, $78, $12, $C3, $1D, $40, $CD, $2D, $12, $C3, $1D, $40, $21, $4B, $60
    db $06, $02, $D7, $C3, $1D, $40

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
    db $E1, $3E, $01, $EA, $FD, $D7, $2A, $4F, $7E, $67, $69, $7D, $EA, $1A, $C9, $7C
    db $EA, $1B, $C9, $C3, $1D, $40, $E1, $FA

Data_010_4696:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FA, $D7, $4F, $79, $A7, $28, $04, $23, $0D, $18, $F8, $FA, $FD, $D7, $A7, $28
    db $15, $CD, $6C, $0B, $23, $78, $85, $6F, $30, $01, $24, $7D, $EA, $1A, $C9, $7C
    db $EA, $1B, $C9, $C3, $1D, $40, $2A, $85, $6F, $30, $01, $24, $7D, $EA, $1A, $C9
    db $7C, $EA, $1B, $C9, $C3, $1D, $40

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
    db $00, $00, $00, $00, $F5, $49, $EE, $49, $00, $00, $CD, $4B, $00, $00, $D4, $4B
    db $00, $00, $00, $00, $DB, $4B

Data_010_4717:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E2, $4B, $E9, $4B, $F0, $4B, $F7, $4B, $FE, $4B, $05, $4C, $0C, $4C, $13, $4C
    db $1A, $4C, $21, $4C, $28, $4C, $2F, $4C, $36, $4C, $3D, $4C, $44, $4C, $4B, $4C
    db $52, $4C, $59, $4C, $60, $4C, $67, $4C, $6E, $4C, $75, $4C, $7C, $4C, $83, $4C
    db $8A, $4C, $91, $4C, $98, $4C, $9F, $4C, $A6, $4C, $AD, $4C, $B4, $4C

Data_010_4755:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $040755, $46

Data_010_479B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04079B, $58
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
    ds $21, $00

Data_010_4858:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1B, $00
    db $E4, $4E, $EB, $4E, $F2, $4E, $F9, $4E, $07, $4F, $0E, $4F, $00, $4F, $15, $4F
    db $1C, $4F, $23, $4F, $2A, $4F, $31, $4F, $38, $4F, $3F, $4F, $46, $4F, $4D, $4F
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_010_48A0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13, $00
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
    ld hl, Data_010_59AC
    ld b, $12
    rst $10
    ret

Func_010_48EC:: ; heuristic: target of a pointer table; C0
    ld hl, Func_010_4001
    ld b, $12
    rst $10
    ret

Func_010_48F3:: ; heuristic: target of a pointer table; C0
    ld hl, $4013
    ld b, $12
    rst $10
    ret

Func_010_48FA:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_550E
    ld b, $12
    rst $10
    ret

Func_010_4901:: ; heuristic: target of a pointer table; C0
    ld hl, $4030
    ld b, $12
    rst $10
    ret

Func_010_4908:: ; heuristic: target of a pointer table; C0
    ld hl, $4064
    ld b, $12
    rst $10
    ret

Func_010_490F:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_4210
    ld b, $12
    rst $10
    ret

Func_010_4916:: ; heuristic: target of a pointer table; C0
    ld hl, $44DB
    ld b, $12
    rst $10
    ret

Func_010_491D:: ; heuristic: target of a pointer table; C0
    ld hl, $43DA
    ld b, $12
    rst $10
    ret

Func_010_4924:: ; heuristic: target of a pointer table; C0
    ld hl, $4F1E
    ld b, $12
    rst $10
    ret

Func_010_492B:: ; heuristic: target of a pointer table; C0
    ld hl, Func_010_4EF9
    ld b, $12
    rst $10
    ret

Func_010_4932:: ; heuristic: target of a pointer table; C0
    ld hl, $4ECE
    ld b, $12
    rst $10
    ret

Func_010_4939:: ; heuristic: target of a pointer table; C0
    ld hl, $4E55
    ld b, $12
    rst $10
    ret

Func_010_4940:: ; heuristic: target of a pointer table; C0
    ld hl, $4E4B
    ld b, $12
    rst $10
    ret

Func_010_4947:: ; heuristic: target of a pointer table; C0
    ld hl, $4A1E
    ld b, $12
    rst $10
    ret

Func_010_494E:: ; heuristic: target of a pointer table; C0
    ld hl, $4A9A
    ld b, $12
    rst $10
    ret

Func_010_4955:: ; heuristic: target of a pointer table; C0
    ld hl, $4C07
    ld b, $12
    rst $10
    ret

Func_010_495C:: ; heuristic: target of a pointer table; C0
    ld hl, $4965
    ld b, $12
    rst $10
    ret

Func_010_4963:: ; heuristic: target of a pointer table; C0
    ld hl, $4919
    ld b, $12
    rst $10
    ret

Func_010_496A:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_4FEA
    ld b, $12
    rst $10
    ret

Func_010_4971:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_50B3
    ld b, $12
    rst $10
    ret

Func_010_4978:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_50E5
    ld b, $12
    rst $10
    ret

Func_010_497F:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_51F4
    ld b, $12
    rst $10
    ret

Func_010_4986:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_63A1
    ld b, $12
    rst $10
    ret

Func_010_498D:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_630E
    ld b, $12
    rst $10
    ret

Func_010_4994:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_6211
    ld b, $12
    rst $10
    ret

Func_010_499B:: ; heuristic: target of a pointer table; C0
    ld hl, Func_010_4001
    ld b, $73
    rst $10
    ret

Func_010_49A2:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_5CE5
    ld b, $12
    rst $10
    ret

Func_010_49A9:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_5A2F
    ld b, $12
    rst $10
    ret

Func_010_49B0:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_5854
    ld b, $12
    rst $10
    ret

Func_010_49B7:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_5728
    ld b, $12
    rst $10
    ret

Func_010_49BE:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_55E8
    ld b, $12
    rst $10
    ret

Func_010_49C5:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_5534
    ld b, $12
    rst $10
    ret

Jump_010_49CC::
    ld hl, Data_010_78CE
    ld b, $5F
    rst $10
    ret

Jump_010_49D3::
    ld hl, Data_010_787C
    ld b, $5F
    rst $10
    ret

Jump_010_49DA::
    ld hl, Data_010_785C
    ld b, $5F
    rst $10
    ret

Jump_010_49E1::
    ld hl, Data_010_77D8
    ld b, $5F
    rst $10

Jump_010_49E7::
    ld hl, Data_010_77D8
    ld b, $5F
    rst $10
    ret

Func_010_49EE:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7969
    ld b, $5F
    rst $10
    ret
    db $FA, $23, $C9, $C7, $27

Data_010_49FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4A, $67, $4A, $84, $4A, $01, $4A, $FA, $CB, $C8, $E6, $03, $C0, $21, $9F, $44
    db $06, $04, $D7, $AF, $EA, $20, $C9, $AF, $EA, $1F, $C9, $3E, $00, $EA, $DC, $C5
    db $C9

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
    ld hl, Data_010_4470
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
    ld hl, $449F
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

Data_010_4B0F:: ; heuristic: pointer load in the same bank (bank assumed); C0
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
    ld hl, Func_010_4001
    ld b, $28
    rst $10
    ret

Jump_010_4B5A::
    ld hl, Func_010_4001
    ld b, $29
    rst $10
    ret

Jump_010_4B61::
    ld hl, Func_010_4001
    ld b, $2A
    rst $10
    ret

Jump_010_4B68::
    ld hl, Func_010_4001
    ld b, $2B
    rst $10
    ret

Jump_010_4B6F::
    ld hl, Func_010_4001
    ld b, $2C
    rst $10
    ret

Jump_010_4B76::
    ld hl, Func_010_4001
    ld b, $2D
    rst $10
    ret

Jump_010_4B7D::
    ld hl, Func_010_4001
    ld b, $2E
    rst $10
    ret

Jump_010_4B84::
    ld hl, Func_010_4001
    ld b, $7C
    rst $10
    ret

Jump_010_4B8B::
    ld hl, Func_010_4001
    ld b, $80
    rst $10
    ret

Jump_010_4B92::
    ld hl, Func_010_4001
    ld b, $82
    rst $10
    ret

Jump_010_4B99::
    ld hl, Func_010_4001
    ld b, $86
    rst $10
    ret

Jump_010_4BA0::
    ld hl, Func_010_4001
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
    ld hl, Func_010_4001
    ld b, $83
    rst $10
    ret

Jump_010_4BBE::
    ld a, l
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, Func_010_4001
    ld b, $8A
    rst $10
    ret

Func_010_4BCD:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7907
    ld b, $5F
    rst $10
    ret

Func_010_4BD4:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7AB2
    ld b, $5F
    rst $10
    ret

Func_010_4BDB:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_79F4
    ld b, $73
    rst $10
    ret

Func_010_4BE2:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_77CC
    ld b, $73
    rst $10
    ret

Func_010_4BE9:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_765D
    ld b, $73
    rst $10
    ret

Func_010_4BF0:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_75DD
    ld b, $73
    rst $10
    ret

Func_010_4BF7:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_73A0
    ld b, $73
    rst $10
    ret

Func_010_4BFE:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7024
    ld b, $73
    rst $10
    ret

Func_010_4C05:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_758C
    ld b, $73
    rst $10
    ret

Func_010_4C0C:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_567B
    ld b, $85
    rst $10
    ret

Func_010_4C13:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6F5B
    ld b, $73
    rst $10
    ret

Func_010_4C1A:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6F14
    ld b, $73
    rst $10
    ret

Func_010_4C21:: ; heuristic: follows a terminator; C0
    ld hl, $4617
    ld b, $85
    rst $10
    ret

Func_010_4C28:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7A2D
    ld b, $0F
    rst $10
    ret

Func_010_4C2F:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_786F
    ld b, $0F
    rst $10
    ret

Func_010_4C36:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6E5F
    ld b, $73
    rst $10
    ret

Func_010_4C3D:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_772E
    ld b, $0F
    rst $10
    ret

Func_010_4C44:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6F7C
    ld b, $73
    rst $10
    ret

Func_010_4C4B:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6EE7
    ld b, $73
    rst $10
    ret

Func_010_4C52:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_55F5
    ld b, $85
    rst $10
    ret

Func_010_4C59:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7625
    ld b, $0F
    rst $10
    ret

Func_010_4C60:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_546F
    ld b, $85
    rst $10
    ret

Func_010_4C67:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6EBA
    ld b, $73
    rst $10
    ret

Func_010_4C6E:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6E17
    ld b, $73
    rst $10
    ret

Func_010_4C75:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_72D9
    ld b, $0F
    rst $10
    ret

Func_010_4C7C:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7271
    ld b, $0F
    rst $10
    ret

Func_010_4C83:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_70EC
    ld b, $0F
    rst $10
    ret

Func_010_4C8A:: ; heuristic: follows a terminator; C0
    ld hl, $4047
    ld b, $85
    rst $10
    ret

Func_010_4C91:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6B98
    ld b, $73
    rst $10
    ret

Func_010_4C98:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6B5B
    ld b, $73
    rst $10
    ret

Func_010_4C9F:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6AFF
    ld b, $73
    rst $10
    ret

Func_010_4CA6:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6AEF
    ld b, $73
    rst $10
    ret

Func_010_4CAD:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6ABE
    ld b, $73
    rst $10
    ret

Func_010_4CB4:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6A91
    ld b, $73
    rst $10
    ret

Func_010_4CBB:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5421
    ld b, $85
    rst $10
    ret

Func_010_4CC2:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7093
    ld b, $0F
    rst $10
    ret

Func_010_4CC9:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6969
    ld b, $73
    rst $10
    ret

Func_010_4CD0:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6941
    ld b, $73
    rst $10
    ret

Func_010_4CD7:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_679F
    ld b, $73
    rst $10
    ret

Func_010_4CDE:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7049
    ld b, $0F
    rst $10
    ret

Func_010_4CE5:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6F65
    ld b, $0F
    rst $10
    ret

Func_010_4CEC:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6D2B
    ld b, $0F
    rst $10
    ret

Func_010_4CF3:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_67BA
    ld b, $0F
    rst $10
    ret

Func_010_4CFA:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_65B0
    ld b, $73
    rst $10
    ret

Func_010_4D01:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_67BA
    ld b, $0F
    rst $10
    ret

Func_010_4D08:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_630F
    ld b, $73
    rst $10
    ret

Func_010_4D0F:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_61A7
    ld b, $73
    rst $10
    ret

Func_010_4D16:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6126
    ld b, $73
    rst $10
    ret

Func_010_4D1D:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_60FE
    ld b, $73
    rst $10
    ret

Func_010_4D24:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6681
    ld b, $0F
    rst $10
    ret

Func_010_4D2B:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_60E6
    ld b, $0F
    rst $10
    ret

Func_010_4D32:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_64F3
    ld b, $0F
    rst $10
    ret

Func_010_4D39:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_631F
    ld b, $0F
    rst $10
    ret

Func_010_4D40:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6079
    ld b, $73
    rst $10
    ret

Func_010_4D47:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6277
    ld b, $0F
    rst $10
    ret

Func_010_4D4E:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5F06
    ld b, $0F
    rst $10
    ret

Func_010_4D55:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6038
    ld b, $73
    rst $10
    ret

Func_010_4D5C:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5D9D
    ld b, $0F
    rst $10
    ret

Func_010_4D63:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5C3B
    ld b, $0F
    rst $10
    ret

Func_010_4D6A:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_59E6
    ld b, $0F
    rst $10
    ret

Func_010_4D71:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_57EA
    ld b, $0F
    rst $10
    ret

Func_010_4D78:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5FBC
    ld b, $73
    rst $10
    ret

Func_010_4D7F:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_4207
    ld b, $85
    rst $10
    ret

Func_010_4D86:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_56CD
    ld b, $0F
    rst $10
    ret

Func_010_4D8D:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5F39
    ld b, $73
    rst $10
    ret

Func_010_4D94:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5EB3
    ld b, $73
    rst $10
    ret

Func_010_4D9B:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5DDD
    ld b, $73
    rst $10
    ret

Func_010_4DA2:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5DAF
    ld b, $73
    rst $10
    ret

Func_010_4DA9:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5C5F
    ld b, $73
    rst $10
    ret

Func_010_4DB0:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5AE4
    ld b, $73
    rst $10
    ret

Func_010_4DB7:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5AD6
    ld b, $73
    rst $10
    ret

Func_010_4DBE:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5ABB
    ld b, $73
    rst $10
    ret

Func_010_4DC5:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5A16
    ld b, $73
    rst $10
    ret

Func_010_4DCC:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5404
    ld b, $0F
    rst $10
    ret

Func_010_4DD3:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5987
    ld b, $73
    rst $10
    ret

Func_010_4DDA:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5987
    ld b, $73
    rst $10
    ret

Func_010_4DE1:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5248
    ld b, $85
    rst $10
    ret

Func_010_4DE8:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5919
    ld b, $73
    rst $10
    ret

Func_010_4DEF:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_58FE
    ld b, $73
    rst $10
    ret

Func_010_4DF6:: ; heuristic: follows a terminator; C0
    ld hl, $4595
    ld b, $0F
    rst $10
    ret

Func_010_4DFD:: ; heuristic: follows a terminator; C0
    ld hl, $40E9
    ld b, $0F
    rst $10
    ret

Func_010_4E04:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_587A
    ld b, $73
    rst $10
    ret

Func_010_4E0B:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5761
    ld b, $73
    rst $10
    ret

Func_010_4E12:: ; heuristic: follows a terminator; C0
    ld hl, $409A
    ld b, $0F
    rst $10
    ret

Func_010_4E19:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_572F
    ld b, $73
    rst $10
    ret

Func_010_4E20:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_571D
    ld b, $73
    rst $10
    ret

Func_010_4E27:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5065
    ld b, $85
    rst $10
    ret

Func_010_4E2E:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5AF3
    ld b, $0F
    rst $10
    ret

Func_010_4E35:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5D71
    ld b, $73
    rst $10
    ret

Func_010_4E3C:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5A57
    ld b, $73
    rst $10
    ret

Func_010_4E43:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_532C
    ld b, $85
    rst $10
    ret

Func_010_4E4A:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7D97
    ld b, $0F
    rst $10
    ret

Func_010_4E51:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7D62
    ld b, $0F
    rst $10
    ret

Func_010_4E58:: ; heuristic: follows a terminator; C0
    ld hl, Func_010_4D8D
    ld b, $85
    rst $10
    ret

Func_010_4E5F:: ; heuristic: follows a terminator; C0
    ld hl, $4C24
    ld b, $85
    rst $10
    ret

Func_010_4E66:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_4B0F
    ld b, $85
    rst $10
    ret

Func_010_4E6D:: ; heuristic: follows a terminator; C0
    ld hl, $4AEE
    ld b, $85
    rst $10
    ret

Func_010_4E74:: ; heuristic: follows a terminator; C0
    ld hl, $4A6D
    ld b, $85
    rst $10
    ret

Func_010_4E7B:: ; heuristic: follows a terminator; C0
    ld hl, $494D
    ld b, $85
    rst $10
    ret

Func_010_4E82:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_48A0
    ld b, $85
    rst $10
    ret

Func_010_4E89:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_505A
    ld b, $85
    rst $10
    ret

Func_010_4E90:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_4858
    ld b, $85
    rst $10
    ret

Func_010_4E97:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7CFB
    ld b, $0F
    rst $10
    ret

Func_010_4E9E:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7CA5
    ld b, $0F
    rst $10
    ret

Func_010_4EA5:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7AC6
    ld b, $0F
    rst $10
    ret

Func_010_4EAC:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_4717
    ld b, $85
    rst $10
    ret

Func_010_4EB3:: ; heuristic: follows a terminator; C0
    ld hl, $4DA6
    ld b, $85
    rst $10
    ret

Func_010_4EBA:: ; heuristic: follows a terminator; C0
    ld hl, $46E4
    ld b, $85
    rst $10
    ret

Func_010_4EC1:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_49FA
    ld b, $85
    rst $10
    ret

Func_010_4EC8:: ; heuristic: follows a terminator; C0
    ld hl, $4A2B
    ld b, $85
    rst $10
    ret

Func_010_4ECF:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_4755
    ld b, $85
    rst $10
    ret

Func_010_4ED6:: ; heuristic: follows a terminator; C0
    ld hl, $481C
    ld b, $85
    rst $10
    ret

Func_010_4EDD:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_479B
    ld b, $85
    rst $10
    ret

Func_010_4EE4:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_568E
    ld b, $73
    rst $10
    ret

Func_010_4EEB:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_55C5
    ld b, $73
    rst $10
    ret

Func_010_4EF2:: ; heuristic: follows a terminator; C0
    ld hl, $4F14
    ld b, $85
    rst $10
    ret

Func_010_4EF9:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_55A4
    ld b, $73
    rst $10
    ret

Func_010_4F00:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5577
    ld b, $73
    rst $10
    ret

Func_010_4F07:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_50F2
    ld b, $85
    rst $10
    ret

Func_010_4F0E:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5449
    ld b, $73
    rst $10
    ret

Func_010_4F15:: ; heuristic: follows a terminator; C0
    ld hl, Func_010_4001
    ld b, $0F
    rst $10
    ret

Func_010_4F1C:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_541D
    ld b, $73
    rst $10
    ret

Func_010_4F23:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_53AB
    ld b, $73
    rst $10
    ret

Func_010_4F2A:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5378
    ld b, $73
    rst $10
    ret

Func_010_4F31:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_51BD
    ld b, $73
    rst $10
    ret

Func_010_4F38:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_5546
    ld b, $73
    rst $10
    ret

Func_010_4F3F:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_501A
    ld b, $85
    rst $10
    ret

Func_010_4F46:: ; heuristic: follows a terminator; C0
    ld hl, $403D
    ld b, $85
    rst $10
    ret

Func_010_4F4D:: ; heuristic: follows a terminator; C0
    ld hl, Func_010_4001
    ld b, $85
    rst $10
    ret
    INCBIN "dwm2-cobi-us.gbc", $040F54, $96

Data_010_4FEA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $0B, $01, $00, $63, $00, $00, $62, $00, $0A, $0E, $00, $FF, $00, $60, $00
    db $0B, $01, $00, $61, $00, $00, $62, $00, $0A, $0E, $00, $FF, $00, $7A, $00, $0B
    db $01, $00, $7B, $40, $06, $07, $00, $7C, $80, $0A, $16, $00, $FF, $00, $7F, $80

Data_010_501A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $19, $00, $80, $00, $1A, $00, $81, $00, $00, $82, $00, $0A, $1A, $00, $FF, $00
    db $7D, $40, $06, $08, $00, $7E, $C0, $06, $03, $07, $2E, $50, $07, $17, $50, $0A
    db $11, $00, $0A, $17, $00, $18, $00, $85, $00, $00, $86, $00, $1C, $01, $00, $02
    db $03, $01, $00, $01, $02, $05, $80, $02, $05, $00, $00, $05, $01, $00, $00, $8C

Data_010_505A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $05, $00, $01, $05, $01, $03, $1D, $FF, $03, $1E

Data_010_5065:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041065, $4E

Data_010_50B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $81, $00, $01, $03, $03, $03, $03, $3C, $00, $01, $02, $01, $06, $01, $02
    db $02, $01, $05, $82, $01, $05, $00, $03, $0B, $82, $00, $01, $00, $01, $02, $03
    db $01, $05, $82, $01, $0A, $12, $00, $FF, $00, $13, $00, $05, $80, $01, $0B, $80
    db $00, $12

Data_010_50E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $05, $81, $01, $05, $82, $01, $05, $00, $01, $0B, $82, $03

Data_010_50F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0410F2, $67

Data_010_5159:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041159, $64

Data_010_51BD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $FF, $00, $A6, $08, $00, $AC, $08, $0A, $86, $01, $FF, $00, $01, $43, $06
    db $04, $00, $04, $83, $FF, $00, $02, $83, $00, $03, $03, $0E, $B0, $04, $0A, $87
    db $01, $FF, $00, $01, $43, $06, $04, $00, $04, $83, $FF, $00, $07, $83, $00, $08
    db $03, $0E, $B0, $04, $0A, $89, $01

Data_010_51F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0411F4, $54

Data_010_5248:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041248, $E4

Data_010_532C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04132C, $4C

Data_010_5378:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $81, $FF, $00, $9E, $42, $06, $04, $00, $A2, $82, $FF, $00, $9F, $82, $FF
    db $00, $9E, $42, $06, $04, $00, $A2, $82, $FF, $00, $A0, $82, $FF, $00, $A3, $02
    db $3B, $0A, $2F, $01, $FF, $00, $A3, $02, $3B, $0A, $35, $01, $FF, $00, $A3, $02
    db $3B, $0A, $39

Data_010_53AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0413AB, $59

Data_010_5404:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $85, $5A, $00, $07, $05, $0A, $22, $01, $FF, $00, $05, $85, $5A, $00, $07, $05
    db $0A, $22, $01, $FF, $00, $1D, $02, $0F, $65

Data_010_541D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $00, $03

Data_010_5421:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $64, $42, $06, $04, $00, $66, $82, $FF, $00, $65, $82, $3A, $0A, $2D
    db $01, $FF, $00, $47, $4B, $06, $04, $00, $81, $8D, $FF, $00, $80, $8D, $7B, $FF
    db $00, $27, $42, $06, $04, $00, $29, $82

Data_010_5449:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $28, $82, $FF, $0A, $08, $01, $00, $2A, $42, $E7, $7B, $78, $FF, $00
    db $2B, $42, $E7, $7B, $78, $FF, $0A, $2D, $00, $00, $49, $4B, $E7, $7B, $78, $FF
    db $0A, $9E, $01, $00, $F0, $4D

Data_010_546F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04146F, $9F

Data_010_550E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $81, $42, $06, $04, $00, $83, $82, $FF, $00, $16, $82, $FF, $00, $60
    db $4A, $06, $04, $00, $83, $82, $FF, $00, $7F, $8A, $FF, $00, $62, $4A, $06, $04
    db $00, $83, $82, $FF, $00, $80

Data_010_5534:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8A, $FF, $00, $64, $4A, $06, $04, $00, $83, $82, $FF, $00, $81, $8A, $FF, $00
    db $66, $4A

Data_010_5546:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $06, $04, $00, $83, $82, $FF, $00, $82, $8A, $FF, $00, $6B, $42, $06, $04, $00
    db $6D, $82, $FF, $00, $6C, $C2, $E7, $51, $7A, $FF, $0A, $89, $01, $00, $70, $42
    db $E7, $51, $7A, $FF, $00, $71, $42, $E7, $51, $7A, $FF, $00, $86, $4D, $E7, $51
    db $7A

Data_010_5577:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $75, $42, $00, $74, $82, $FF, $00, $75, $02, $00, $73, $02, $FF, $00
    db $B0, $04, $FF, $FF, $00, $B3, $44, $06, $04, $00, $B2, $84, $FF, $00, $B1, $C4
    db $FF, $00, $CF, $48, $0A, $0F, $01, $E7, $F7, $6E, $FF, $00, $D0

Data_010_55A4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $48, $E7, $F7, $6E, $FF, $0A, $28, $00, $00, $20, $4B, $E7, $F7, $6E, $FF, $00
    db $D3, $48, $0A, $10, $01, $E7, $4B, $76, $FF, $00

Data_010_55BE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D4, $48, $E7, $4B, $76, $FF, $0A

Data_010_55C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2C, $00, $00, $2E, $4B, $E7, $4B, $76, $FF, $00, $D5, $48, $06, $04, $00, $D7
    db $88, $FF, $00, $D6, $88, $FF, $0A, $12, $01, $00, $6D, $4A, $E7, $A9, $7B, $FF
    db $00, $6E, $4A

Data_010_55E8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E7, $A9, $7B, $FF, $0A, $31, $00, $00, $50, $4B, $E7, $A9, $7B

Data_010_55F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0415F5, $86

Data_010_567B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C5, $E7, $8B, $7F, $FF, $00, $B7, $44, $06, $04, $00, $B9, $84, $FF, $00, $B8
    db $C4, $E7, $8B

Data_010_568E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $FF, $00, $C8, $44, $06, $07, $00, $CA, $84, $0A, $1D, $01, $FF, $00, $C9
    db $84, $FF, $00, $4C, $0B, $CF, $0A, $2F, $00, $FF, $00, $BF, $0B, $CF, $FF, $0A
    db $1F, $01, $00, $97, $42, $E7, $B8, $62, $FF, $00, $98, $42, $E7, $B8, $62, $FF
    db $0A, $13, $01, $00, $1E, $4B, $E7, $B8, $62, $FF, $00, $BD, $44, $06, $04

Data_010_56CD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0416CD, $50

Data_010_571D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $11, $41, $06, $04, $00, $13, $81, $FF, $00, $12

Data_010_5728:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $FF, $00, $11, $41, $06, $04

Data_010_572F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $13, $81, $FF, $00, $55, $82, $FF, $00, $11, $41, $06, $04, $00, $13, $81
    db $FF, $00, $BE, $88, $FF, $00, $54, $4A, $06, $04, $00, $58, $8A, $FF, $65, $00
    db $57, $8A, $FF, $00, $89, $42, $06, $04, $00, $8B, $82, $FF, $00, $8A, $82, $FF
    db $3E, $0A

Data_010_5761:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041761, $89

Data_010_57EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0417EA, $6A

Data_010_5854:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $6B, $CB, $E7, $8B, $7F, $FF, $00, $70, $4B, $06, $04, $00, $72, $8B
    db $FF, $00, $71, $CB, $E7, $8B, $7F, $FF, $00, $C3, $0B, $6F, $00, $4E, $0B, $0A
    db $3D, $00, $FF, $00, $C3, $0B

Data_010_587A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04187A, $84

Data_010_58FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $0A, $3C, $00, $FF, $00, $7C, $4B, $06, $04, $00, $7E, $8B, $FF, $00, $7D
    db $8B, $0A, $92, $01, $FF, $00, $80, $0B, $00, $81, $0B

Data_010_5919:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041919, $6E

Data_010_5987:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $01, $02, $01, $06, $05, $00, $03, $00, $D4, $01, $0B, $82, $00, $DE, $0D
    db $01, $02, $03, $06, $0A, $87, $01, $FF, $00, $49, $0D, $00, $41, $0D, $0A, $A4
    db $01, $FF, $00, $44, $0D

Data_010_59AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $41, $0D, $0A, $A6, $01, $FF, $00, $FA, $40, $E7, $59, $66, $FF, $00, $BB
    db $41, $E7, $0B, $69, $FF, $00, $44, $41, $E7, $07, $67, $FF, $00, $45, $41, $E7
    db $07, $67, $FF, $00, $46, $41, $E7, $D4, $77, $FF, $00, $47, $41, $E7, $D4, $77
    db $FF, $00, $48, $41, $06, $04, $00, $4C, $81, $FF

Data_010_59E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $49, $81, $0A, $42, $00, $1F, $05, $83, $02, $00, $53, $01, $0A, $43, $00
    db $FF, $00, $48, $41, $06, $04, $00, $4C, $81, $FF, $00, $4B, $81, $0A, $42, $00
    db $FF, $00, $48, $41, $06, $04, $00, $4C, $81, $FF, $00, $4A, $81, $0A, $42, $00

Data_010_5A16:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $4D, $01, $1F, $05, $83, $02, $00, $53, $01, $0A, $43, $00, $FF, $00
    db $BB, $41, $E7, $0B, $69, $FF, $00, $60, $41

Data_010_5A2F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $06, $04, $00, $01, $8D, $FF, $0A, $44, $00, $00, $02, $8D, $21, $00, $61, $41
    db $06, $04, $00, $63, $81, $FF, $00, $62, $81, $0A, $45, $00, $FF, $00, $65, $41
    db $06, $04, $00, $63, $81, $FF, $00, $62

Data_010_5A57:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041A57, $64

Data_010_5ABB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $81, $00, $00, $78, $01, $0C, $01, $0A, $53, $00, $25, $0A, $54, $00, $00
    db $79, $01, $01, $00, $00, $03, $FF, $4D, $FF, $4D, $FF

Data_010_5AD6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $81, $01, $0A, $55, $00, $01, $01, $00, $08, $23, $02, $00, $01

Data_010_5AE4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $05, $80, $02, $00, $82, $01, $05, $81, $00, $00, $83, $01, $0B, $80

Data_010_5AF3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041AF3, $148

Data_010_5C3B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2C, $00, $16, $08, $FF, $00, $10, $48, $06, $04, $00, $17, $88, $FF, $00, $11
    db $88, $2B, $FF, $00, $10, $48, $06, $04, $00, $17, $88, $FF, $00, $11, $88, $2D
    db $FF, $00, $10, $48

Data_010_5C5F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041C5F, $86

Data_010_5CE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041CE5, $8C

Data_010_5D71:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $41, $E7, $0B, $69, $FF, $00, $16, $03, $00, $17, $43, $06, $04, $00, $1A, $83
    db $FF, $00, $18, $83, $3F, $0A, $E8, $01, $FF, $00, $1C, $03, $01, $00, $02, $01
    db $0C, $00, $0A, $81, $00, $FF, $00, $21, $03, $0A, $83, $00

Data_010_5D9D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $01, $01, $00, $02, $0A, $82, $00, $FF, $00, $59, $03, $42, $0F, $28, $0A
    db $87, $00

Data_010_5DAF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $31, $43, $E7, $59, $66, $FF, $00, $32, $43, $E7, $07, $67, $FF, $00
    db $33, $43, $E7, $07, $67, $FF, $00, $BB, $41, $E7, $0B, $69, $FF, $00, $20, $48
    db $E7, $D4, $77, $FF, $0F, $65, $41, $02, $01, $03, $04, $02, $02, $01

Data_010_5DDD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041DDD, $D6

Data_010_5EB3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041EB3, $53

Data_010_5F06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $0A, $96, $00, $FF, $00, $B3, $43, $E7, $07, $67, $FF, $00, $B5, $43, $06
    db $04, $00, $B7, $83, $FF, $00, $B6, $83, $FF, $00, $BB, $41, $E7, $0B, $69, $FF
    db $00, $B0, $03, $0B, $80, $00, $B1, $03, $01, $00, $02, $01, $0C, $00, $0A, $97
    db $00, $FF, $00

Data_010_5F39:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041F39, $83

Data_010_5FBC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $041FBC, $7C

Data_010_6038:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $042038, $41

Data_010_6079:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $042079, $62

Data_010_60DB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $84, $FF, $0F, $66, $03, $3C, $00, $00, $65, $84, $55

Data_010_60E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $B2, $00, $FF, $00, $66, $04, $0A, $B3, $00, $0D, $08, $00, $68, $04, $56
    db $0A, $B4, $00, $0A, $C5, $00, $0A, $C6

Data_010_60FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $0A, $C7, $00, $FF, $00, $67, $04, $0D, $08, $00, $68, $04, $56, $0A, $B4
    db $00, $0A, $C5, $00, $0A, $C6, $00, $0A, $C7, $00, $FF, $00, $69, $04, $01, $00
    db $02, $01, $0C, $00, $0A, $B6, $00, $FF

Data_010_6126:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $042126, $81

Data_010_61A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0421A7, $6A

Data_010_6211:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $042211, $66

Data_010_6277:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $042277, $97

Data_010_630E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03

Data_010_630F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00

Data_010_6310:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $41, $07, $FF, $00, $3A, $07, $0D, $0B, $00, $3B, $07, $C3, $00, $3C, $07

Data_010_631F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04231F, $82

Data_010_63A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0423A1, $152

Data_010_64F3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0424F3, $AC

Data_010_659F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $49, $0C, $CD, $FF, $00, $23, $41, $E7, $07, $67, $FF, $00, $24, $41, $E7, $0B
    db $69

Data_010_65B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $28, $41, $E7, $0B, $69, $FF, $00, $27, $41, $E7, $D4, $77, $FF

Func_010_65BF:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_4075
    ld b, $1C
    rst $10
    ret

Func_010_65C6:: ; heuristic: target of a pointer table; C0
    ld hl, Func_010_4001
    ld b, $1C
    rst $10
    ret

Func_010_65CD:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_4696
    ld b, $1C
    rst $10
    ret

Func_010_65D4:: ; heuristic: target of a pointer table; C0
    ld hl, $4605
    ld b, $1C
    rst $10
    ret

Func_010_65DB:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6CEF
    ld b, $1C
    rst $10
    ret

Func_010_65E2:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_6CEB
    ld b, $1C
    rst $10
    ret

Func_010_65E9:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_4069
    ld b, $1E
    rst $10
    ret

Func_010_65F0:: ; heuristic: follows a terminator; C0
    ld hl, Func_010_4001
    ld b, $1E
    rst $10
    ret

Func_010_65F7:: ; heuristic: target of a pointer table; C0
    ld hl, $40CC
    ld b, $14
    rst $10
    ret

Func_010_65FE:: ; heuristic: target of a pointer table; C0
    ld hl, Func_010_4001
    ld b, $14
    rst $10
    ret

Func_010_6605:: ; heuristic: target of a pointer table; C0
    ld hl, $40FA
    ld b, $15
    rst $10
    ret

Func_010_660C:: ; heuristic: target of a pointer table; C0
    ld hl, Func_010_4001
    ld b, $15
    rst $10
    ret

Func_010_6613:: ; heuristic: target of a pointer table; C0
    ld hl, $45D1
    ld b, $0D
    rst $10
    ret

Func_010_661A:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_5159
    ld b, $0D
    rst $10
    ret

Func_010_6621:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_50E5
    ld b, $0D
    rst $10
    ret

Func_010_6628:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_55BE
    ld b, $0D
    rst $10
    ret

Func_010_662F:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_6310
    ld b, $0D
    rst $10
    ret

Func_010_6636:: ; heuristic: target of a pointer table; C0
    ld hl, Data_010_711C
    ld b, $0D
    rst $10
    ret

Func_010_663D:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_7115
    ld b, $0D
    rst $10
    ret

Func_010_6644:: ; heuristic: follows a terminator; C0
    ld hl, Func_010_4001
    ld b, $0C
    rst $10
    ret

Func_010_664B:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_659F
    ld b, $0C
    rst $10
    ret

Func_010_6652:: ; heuristic: follows a terminator; C0
    ld hl, Data_010_60DB
    ld b, $24
    rst $10
    ret
    db $E2, $E2, $E2, $E4, $1F, $1B, $14, $01, $09, $00, $07, $C0, $00, $08, $C0, $07
    db $5B, $66, $00, $0F, $C0, $00, $08, $C0, $07, $5B, $66, $E3, $00, $12, $80, $E3
    db $FF, $07, $C9, $66, $00, $06, $C0, $E2

Data_010_6681:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $042681, $11E

Data_010_679F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $67, $00, $37, $C0, $E2, $E4, $05, $00, $E2, $07, $77, $67, $00, $3B, $C0, $00
    db $34, $C0, $E2, $07, $09, $67, $E5, $E5, $E5, $E4, $02

Data_010_67BA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0427BA, $16E
    ds $19, $00

Data_010_6941:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $28, $00

Data_010_6969:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $128, $00

Data_010_6A91:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2D, $00

Data_010_6ABE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $31, $00

Data_010_6AEF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $10, $00

Data_010_6AFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $5C, $00

Data_010_6B5B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3D, $00

Data_010_6B98:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $153, $00

Data_010_6CEB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00

Data_010_6CEF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3C, $00

Data_010_6D2B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $EC, $00

Data_010_6E17:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $48, $00

Data_010_6E5F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $5B, $00

Data_010_6EBA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2D, $00

Data_010_6EE7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2D, $00

Data_010_6F14:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $47, $00

Data_010_6F5B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_010_6F65:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $17, $00

Data_010_6F7C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $A8, $00

Data_010_7024:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $25, $00

Data_010_7049:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $4A, $00

Data_010_7093:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $59, $00

Data_010_70EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $29, $00

Data_010_7115:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00

Data_010_711C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $155, $00

Data_010_7271:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $68, $00

Data_010_72D9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $C7, $00

Data_010_73A0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1EC, $00

Data_010_758C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $51, $00

Data_010_75DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $48, $00

Data_010_7625:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $38, $00

Data_010_765D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $D1, $00

Data_010_772E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $9E, $00

Data_010_77CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_010_77D8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $84, $00

Data_010_785C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13, $00

Data_010_786F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_010_787C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $52, $00

Data_010_78CE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $39, $00

Data_010_7907:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $62, $00

Data_010_7969:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $8B, $00

Data_010_79F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $39, $00

Data_010_7A2D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $85, $00

Data_010_7AB2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $14, $00

Data_010_7AC6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1DF, $00

Data_010_7CA5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $56, $00

Data_010_7CFB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $67, $00

Data_010_7D62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $35, $00

Data_010_7D97:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $12B, $00

Data_010_7EC2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $13E, $00
