SECTION "Bank 10", ROMX[$4000], BANK[$10]
    db $10

; 1 call site from 1 routine (e.g. Func_002_4AE0)
Func_010_4001::
    call Func_010_4008
    call Func_010_46E9
    ret

; 5 call sites from 5 routines (e.g. Func_010_4001, Func_002_4745, Func_002_6CD4, Func_007_6ADC, ...)
; reads: wC56C, wC919, wC91A, wC91B, wD7FD, wCC44
; writes: wC919, wC91F, wC920, wD7FD, wC5DC
Func_010_4008::
    ld a, [wC56C]
    or a, a
    ret nz
    ld a, [wC919]
    bit 7, a
    ret z
    and a, $7F
    ld [wC919], a
    ld a, $01
    ld [wC91F], a

Jump_010_401D::
    ld a, [wC91A]
    ld l, a
    ld a, [wC91B]
    ld h, a
    ld a, [wD7FD]
    and a, a
    jr z, Jump_010_4032
    call ReadWordFromDataBank
    ld a, b
    inc hl
    jr Jump_010_4033

Jump_010_4032::
    ld a, [hl+]

Jump_010_4033::
    cp a, $FF
    jr nz, Jump_010_4054
    xor a, a
    ld [wC91F], a
    ld [wC920], a
    ld [wD7FD], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_010_404E
    ld a, $00
    ld [wC5DC], a
    ret

Jump_010_404E::
    ld a, $05
    ld [wC5DC], a
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

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4248:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC923, wC924, wC925, wC926, wC91A, wC91B
Func_010_4252:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $81
    ld [wC920], a
    xor a, a
    ld [wC923], a
    ld [wC924], a
    ld [wC925], a
    ld [wC926], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC195, hFF8C
; writes: wC920, wC922
Func_010_426E:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $83
    ld [wC920], a
    call Func_010_46CD
    ld a, [wC195]
    and a, $03
    dec a
    jr nz, Jump_010_4291
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_010_428B
    ld a, $01
    ld [wC922], a
    ret

Jump_010_428B::
    ld a, $03
    ld [wC922], a
    ret

Jump_010_4291::
    ld a, $02
    ld [wC922], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC923, wC924, wC925, wC926, wC91A, wC91B
Func_010_4297:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $86
    ld [wC920], a
    xor a, a
    ld [wC923], a
    ld [wC924], a
    ld [wC925], a
    ld [wC926], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

Jump_010_42B3::
    pop hl
    ld a, [wD7FD]
    and a, a
    jr z, Jump_010_42CE
    ld a, $01
    ld [wC920], a
    call ReadWordFromDataBank
    ld a, b
    ld [wC921], a
    ld a, c
    ld [wC922], a
    inc hl
    inc hl
    jr Jump_010_42DB

Jump_010_42CE::
    ld a, $01
    ld [wC920], a
    ld a, [hl+]
    ld [wC921], a
    ld a, [hl+]
    ld [wC922], a

Jump_010_42DB::
    xor a, a
    ld [wC923], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

Jump_010_42E8::
    ld a, $02
    ld [wC920], a
    jr Jump_010_42F4

Jump_010_42EF::
    ld a, $03
    ld [wC920], a

Jump_010_42F4::
    pop hl
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    swap a
    or a, c
    ld [wC921], a
    ld a, [hl+]
    ld [wC922], a
    xor a, a
    ld [wC923], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

Jump_010_430F::
    pop hl
    ld a, $04
    ld [wC920], a
    ld a, [hl+]
    ld [wC921], a
    ld a, [hl+]
    ld [wC922], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

Jump_010_4326::
    pop hl
    ld a, $05
    ld [wC920], a
    ld a, [hl+]
    ld [wC921], a
    ld a, [hl+]
    ld [wC922], a
    xor a, a
    ld [wC923], a
    ldh [hFF9A], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

Jump_010_4343::
    pop hl
    ld a, $06
    ld [wC920], a
    ld a, [hl+]
    ld [wC921], a
    ld a, [hl+]
    ld [wC922], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

; 2 call sites from 1 routine (e.g. Func_010_435A)
; reads: rSTAT
Func_010_435A::
    ldh a, [rSTAT]
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
    ld hl, wC89E
    ld de, vTiles1 + $6E0
    ld c, $10
    call Func_010_435A
    ld hl, wC8AE
    ld de, vTiles1 + $6F0
    ld c, $10
    call Func_010_435A
    pop de
    pop bc
    pop hl
    ld a, [wD7FD]
    and a, a
    jr z, Jump_010_43A6
    ld a, [wC552]
    or a, a
    jr nz, Jump_010_43A3
    call ReadWordFromDataBank
    inc hl
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_010_4398
    inc h

Jump_010_4398::
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    jp Jump_010_401D

Jump_010_43A3::
    inc hl
    jr Jump_010_4398

Jump_010_43A6::
    ld a, [wC552]
    or a, a
    jr nz, Jump_010_43BD
    ld a, [hl+]
    add_a_to_hl
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    jp Jump_010_401D

Jump_010_43BD::
    inc hl
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    jp Jump_010_401D

Jump_010_43C9::
    pop hl
    ld a, [wD7FD]
    and a, a
    jr z, Jump_010_43DF
    call ReadWordFromDataBank
    ld a, b
    ld [wC91A], a
    ld a, c
    ld [wC91B], a
    inc hl
    jp Jump_010_401D

Jump_010_43DF::
    ld a, [hl+]
    ld [wC91A], a
    ld a, [hl]
    ld [wC91B], a
    jp Jump_010_401D
    db $E1, $2A, $5F, $2A, $57, $7D, $EA, $1A, $C9, $7C, $EA, $1B, $C9, $CD, $45, $18
    db $C3, $1D, $40

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC922, wC921, wC91A, wC91B
Func_010_43FD:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $0C
    ld [wC920], a
    ld a, [hl+]
    ld [wC922], a
    xor a, a
    ld [wC921], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC91A, wC91B, wD7FD, wCC44
; writes: wC91A, wC91B, wC91F, wC920, wD7FD, wC5DC
; points at: wCB8B
Func_010_4414:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    swap a
    ld de, wCB8B
    add a, e
    ld e, a
    jr nc, Jump_010_4420
    inc d

Jump_010_4420::
    ld a, $E0
    ld [de], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    jp Jump_010_401D

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC921, wC923, wC91A, wC91B
Func_010_442E:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $0E
    ld [wC920], a
    ld a, [hl+]
    ld [wC921], a
    xor a, a
    ld [wC923], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC91A, wC91B, wD7FD, wCC44
; writes: hFFC6, hFFC7, wC91A, wC91B, wC91F, wC920, wD7FD, wC5DC
Func_010_4445:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl+]
    ldh [hFFC7], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    farcall Func_012_7EC2
    jp Jump_010_401D

; no direct call (reached through a table, a jump or a vector)
; reads: wC91A, wC91B, wD7FD, wCC44
; writes: wC91A, wC91B, wC91F, wC920, wD7FD, wC5DC
Func_010_445D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [hl+]
    push af
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    pop af
    cp a, $FF
    jr z, Jump_010_447D
    cp a, $60
    jr c, Jump_010_4477
    call StoreWC60B
    jp Jump_010_401D

Jump_010_4477::
    call Func_000_122D
    jp Jump_010_401D

Jump_010_447D::
    farcall Func_002_604B
    jp Jump_010_401D

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4486:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFF98
; writes: wC8EF, wC920, wC924, wC925, wC926
Func_010_4490:: ; heuristic: target of a pointer table; C0
    pop hl
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wC8EF], a
    ld a, $1C
    ld [wC920], a
    call Func_010_46CD
    ld de, $0000
    call TestFlagBit
    jr c, Jump_010_44BA
    ld hl, $0088
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

Jump_010_44BA::
    ld hl, $0087
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC924, wC925, wC926
Func_010_44CA:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $1D
    ld [wC920], a
    call Func_010_46CD
    ld de, $0000
    call TestFlagBit
    jr c, Jump_010_44EB
    ld hl, $4097
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

Jump_010_44EB::
    ld hl, $408D
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCC38
; writes: wCC38, wC920
Func_010_44FB:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [wCC38]
    set 2, a
    ld [wCC38], a
    ld a, $23
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC922
; writes: wC920, wC922
Func_010_450D:: ; heuristic: target of a pointer table; C0
    pop hl
    dec hl
    ld a, [hl+]
    ld [wC920], a
    ld a, [wC922]
    push af
    call Func_010_46CD
    pop af
    ld [wC922], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_451F:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E0
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4529:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E1
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4533:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E2
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_453D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E3
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4547:: ; heuristic: follows a terminator; C0
    pop hl
    ld a, $E5
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4551:: ; heuristic: follows a terminator; C0
    pop hl
    ld a, $E6
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_455B:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E8
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4565:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $E9
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_456F:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EB
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4579:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EC
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4583:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $ED
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_458D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EE
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4597:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $EF
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_45A1:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F0
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_45AB:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F1
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_45B5:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F2
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_45BF:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F3
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_45C9:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F4
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7FD, wD7FB, wC921
; writes: wC920, wC921, wC922, wC923, wC91A, wC91B
Func_010_45D3:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [wD7FD]
    and a, a
    jr z, Jump_010_45EE
    ld a, $01
    ld [wC920], a
    call ReadWordFromDataBank
    ld a, b
    ld [wC921], a
    ld a, c
    ld [wC922], a
    inc hl
    inc hl
    jr Jump_010_45FB

Jump_010_45EE::
    ld a, $01
    ld [wC920], a
    ld a, [hl+]
    ld [wC921], a
    ld a, [hl+]
    ld [wC922], a

Jump_010_45FB::
    push hl
    ld a, [wD7FB]
    add a, a
    add a, a
    add a, a
    add a, a
    ld b, a
    ld a, [wC921]
    add a, b
    ld [wC921], a
    pop hl
    xor a, a
    ld [wC923], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4619:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F6
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_4623:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F7
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC920
Func_010_462D:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, $F8
    ld [wC920], a
    call Func_010_46CD
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7FD, wC921
; writes: wC920, wC921, wC922, wC923, wC91A, wC91B
Func_010_4637:: ; heuristic: target of a pointer table; C0
    pop hl
    ld a, [wD7FD]
    and a, a
    jr z, Jump_010_4652
    ld a, $01
    ld [wC920], a
    call ReadWordFromDataBank
    ld a, b
    ld [wC921], a
    ld a, c
    ld [wC922], a
    inc hl
    inc hl
    jr Jump_010_465F

Jump_010_4652::
    ld a, $01
    ld [wC920], a
    ld a, [hl+]
    ld [wC921], a
    ld a, [hl+]
    ld [wC922], a

Jump_010_465F::
    push hl
    ld de, $0000
    call TestFlagBit
    jr c, Jump_010_4670
    ld a, [wC921]
    add a, $20
    ld [wC921], a

Jump_010_4670::
    pop hl
    xor a, a
    ld [wC923], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $04067E, $4F

; 28 call sites from 28 routines (e.g. Func_010_462D, Func_010_4623, Func_010_4619, Func_010_45C9, ...)
; writes: wC921, wC922, wC923, wC924, wC925, wC926, wC91A, wC91B
Func_010_46CD::
    xor a, a
    ld [wC921], a
    ld [wC922], a
    ld [wC923], a
    ld [wC924], a
    ld [wC925], a
    ld [wC926], a
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4001)
; reads: wC56C, wC920
Func_010_46E9::
    ld a, [wC56C]
    or a, a
    ret nz
    ld a, [wC920]
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

; no direct call (reached through a table, a jump or a vector)
Func_010_48E5:: ; heuristic: target of a pointer table; C0
    farcall Func_012_59AC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_48EC:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_48F3:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4013
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_48FA:: ; heuristic: target of a pointer table; C0
    farcall Func_012_550E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4901:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4030
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4908:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4064
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_490F:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4210
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4916:: ; heuristic: target of a pointer table; C0
    farcall Func_012_44DB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_491D:: ; heuristic: target of a pointer table; C0
    farcall Func_012_43DA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4924:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4F1E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_492B:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4EF9
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4932:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4ECE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4939:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4E55
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4940:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4E4B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4947:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4A1E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_494E:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4A9A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4955:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4C07
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_495C:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4965
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4963:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4919
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_496A:: ; heuristic: target of a pointer table; C0
    farcall Func_012_4FEA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4971:: ; heuristic: target of a pointer table; C0
    farcall Func_012_50B3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4978:: ; heuristic: target of a pointer table; C0
    farcall Func_012_50E5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_497F:: ; heuristic: target of a pointer table; C0
    farcall Func_012_51F4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4986:: ; heuristic: target of a pointer table; C0
    farcall Func_012_63A1
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_498D:: ; heuristic: target of a pointer table; C0
    farcall Func_012_630E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4994:: ; heuristic: target of a pointer table; C0
    farcall Func_012_6211
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_499B:: ; heuristic: target of a pointer table; C0
    farcall Func_073_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49A2:: ; heuristic: target of a pointer table; C0
    farcall Func_012_5CE5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49A9:: ; heuristic: target of a pointer table; C0
    farcall Func_012_5A2F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49B0:: ; heuristic: target of a pointer table; C0
    farcall Func_012_5854
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49B7:: ; heuristic: target of a pointer table; C0
    farcall Func_012_5728
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49BE:: ; heuristic: target of a pointer table; C0
    farcall Func_012_55E8
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49C5:: ; heuristic: target of a pointer table; C0
    farcall Func_012_5534
    ret

Jump_010_49CC::
    farcall Func_05F_78CE
    ret

Jump_010_49D3::
    farcall Func_05F_787C
    ret

Jump_010_49DA::
    farcall Func_05F_785C
    ret

Jump_010_49E1::
    farcall Func_05F_77D8

Jump_010_49E7::
    farcall Func_05F_77D8
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_49EE:: ; heuristic: follows a terminator; C0
    farcall Func_05F_7969
    ret
    db $FA, $23, $C9, $C7, $27, $4A, $67, $4A, $84, $4A, $01, $4A, $FA, $CB, $C8, $E6
    db $03, $C0, $21, $9F, $44, $06, $04, $D7, $AF, $EA, $20, $C9, $AF, $EA, $1F, $C9
    db $3E, $00, $EA, $DC, $C5, $C9

Jump_010_4A1B::
    ld a, [wC923]
    rst $00
    dw Jump_010_4A27
    dw Jump_010_4A67
    dw Jump_010_4A84
    dw Jump_010_4AB3

Jump_010_4A27::
    ld a, [wC922]
    bit 7, a
    jr nz, Jump_010_4A62
    farcall Func_004_4470
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call StoreWC60B
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_010_4A62
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_010_4A62::
    ld hl, wC923
    inc [hl]
    ret

Jump_010_4A67::
    ld a, [wC922]
    bit 7, a
    jr nz, Jump_010_4A74
    ld a, [wC8CB]
    and a, $03
    ret nz

Jump_010_4A74::
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    ld h, a
    call Func_010_4AD0
    ld hl, wC923
    inc [hl]
    ret

Jump_010_4A84::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC922]
    bit 6, a
    jr nz, Jump_010_4AAE
    ld a, $69
    call StoreWC60B
    xor a, a
    ldh [hFFB9], a
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_010_4AAE
    ld a, $82
    ld [wC8CB], a

Jump_010_4AAE::
    ld hl, wC923
    inc [hl]
    ret

Jump_010_4AB3::
    ld a, [wC922]
    bit 6, a
    jr nz, Jump_010_4AC6
    ld a, [wC8CB]
    and a, $03
    ret nz
    farcall Func_004_449F

Jump_010_4AC6::
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_49EE)
; reads: wD7F0, wCC44
; writes: wStringIndex, wStringCategory
Func_010_4AD0::
    ld a, h
    and a, $3F
    ld h, a
    push hl
    ld a, [wD7F0]
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
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
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
    ld a, [wCC44]
    cp a, $80
    jr z, Jump_010_4B2D
    bit 7, a
    jp nz, Jump_010_4BA7

Jump_010_4B2D::
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
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
    farcall BeginStringDisplay_Bank28
    ret

Jump_010_4B5A::
    farcall Func_029_4001
    ret

Jump_010_4B61::
    farcall Func_02A_4001
    ret

Jump_010_4B68::
    farcall Func_02B_4001
    ret

Jump_010_4B6F::
    farcall Func_02C_4001
    ret

Jump_010_4B76::
    farcall Func_02D_4001
    ret

Jump_010_4B7D::
    farcall Func_02E_4001
    ret

Jump_010_4B84::
    farcall Func_07C_4001
    ret

Jump_010_4B8B::
    farcall Func_080_4001
    ret

Jump_010_4B92::
    farcall Func_082_4001
    ret

Jump_010_4B99::
    farcall BeginStringDisplay_Bank86
    ret

Jump_010_4BA0::
    farcall Func_089_4001
    ret

Jump_010_4BA7::
    ld a, h
    or a, a
    jr nz, Jump_010_4BBE
    ld a, l
    cp a, $20
    jr c, Jump_010_4BBE
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall Func_083_4001
    ret

Jump_010_4BBE::
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank8A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BCD:: ; heuristic: follows a terminator; C0
    farcall Func_05F_7907
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BD4:: ; heuristic: follows a terminator; C0
    farcall Func_05F_7AB2
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BDB:: ; heuristic: follows a terminator; C0
    farcall Func_073_79F4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BE2:: ; heuristic: follows a terminator; C0
    farcall Func_073_77CC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BE9:: ; heuristic: follows a terminator; C0
    farcall Func_073_765D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BF0:: ; heuristic: follows a terminator; C0
    farcall Func_073_75DD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BF7:: ; heuristic: follows a terminator; C0
    farcall Func_073_73A0
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4BFE:: ; heuristic: follows a terminator; C0
    farcall Func_073_7024
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C05:: ; heuristic: follows a terminator; C0
    farcall Func_073_758C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C0C:: ; heuristic: follows a terminator; C0
    farcall Func_085_567B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C13:: ; heuristic: follows a terminator; C0
    farcall Func_073_6F5B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C1A:: ; heuristic: follows a terminator; C0
    farcall Func_073_6F14
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C21:: ; heuristic: follows a terminator; C0
    farcall Func_085_4617
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C28:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7A2D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C2F:: ; heuristic: follows a terminator; C0
    farcall Func_00F_786F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C36:: ; heuristic: follows a terminator; C0
    farcall Func_073_6E5F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C3D:: ; heuristic: follows a terminator; C0
    farcall Func_00F_772E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C44:: ; heuristic: follows a terminator; C0
    farcall Func_073_6F7C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C4B:: ; heuristic: follows a terminator; C0
    farcall Func_073_6EE7
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C52:: ; heuristic: follows a terminator; C0
    farcall Func_085_55F5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C59:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7625
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C60:: ; heuristic: follows a terminator; C0
    farcall Func_085_546F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C67:: ; heuristic: follows a terminator; C0
    farcall Func_073_6EBA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C6E:: ; heuristic: follows a terminator; C0
    farcall Func_073_6E17
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C75:: ; heuristic: follows a terminator; C0
    farcall Func_00F_72D9
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C7C:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7271
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C83:: ; heuristic: follows a terminator; C0
    farcall Func_00F_70EC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C8A:: ; heuristic: follows a terminator; C0
    farcall Func_085_4047
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C91:: ; heuristic: follows a terminator; C0
    farcall Func_073_6B98
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C98:: ; heuristic: follows a terminator; C0
    farcall Func_073_6B5B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4C9F:: ; heuristic: follows a terminator; C0
    farcall Func_073_6AFF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CA6:: ; heuristic: follows a terminator; C0
    farcall Func_073_6AEF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CAD:: ; heuristic: follows a terminator; C0
    farcall Func_073_6ABE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CB4:: ; heuristic: follows a terminator; C0
    farcall Func_073_6A91
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CBB:: ; heuristic: follows a terminator; C0
    farcall Func_085_5421
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CC2:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7093
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CC9:: ; heuristic: follows a terminator; C0
    farcall Func_073_6969
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CD0:: ; heuristic: follows a terminator; C0
    farcall Func_073_6941
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CD7:: ; heuristic: follows a terminator; C0
    farcall Func_073_679F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CDE:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7049
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CE5:: ; heuristic: follows a terminator; C0
    farcall Func_00F_6F65
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CEC:: ; heuristic: follows a terminator; C0
    farcall Func_00F_6D2B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CF3:: ; heuristic: follows a terminator; C0
    farcall Func_00F_67BA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4CFA:: ; heuristic: follows a terminator; C0
    farcall Func_073_65B0
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D01:: ; heuristic: follows a terminator; C0
    farcall Func_00F_67BA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D08:: ; heuristic: follows a terminator; C0
    farcall Func_073_630F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D0F:: ; heuristic: follows a terminator; C0
    farcall Func_073_61A7
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D16:: ; heuristic: follows a terminator; C0
    farcall Func_073_6126
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D1D:: ; heuristic: follows a terminator; C0
    farcall Func_073_60FE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D24:: ; heuristic: follows a terminator; C0
    farcall Func_00F_6681
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D2B:: ; heuristic: follows a terminator; C0
    farcall Func_00F_60E6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D32:: ; heuristic: follows a terminator; C0
    farcall Func_00F_64F3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D39:: ; heuristic: follows a terminator; C0
    farcall Func_00F_631F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D40:: ; heuristic: follows a terminator; C0
    farcall Func_073_6079
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D47:: ; heuristic: follows a terminator; C0
    farcall Func_00F_6277
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D4E:: ; heuristic: follows a terminator; C0
    farcall Func_00F_5F06
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D55:: ; heuristic: follows a terminator; C0
    farcall Func_073_6038
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D5C:: ; heuristic: follows a terminator; C0
    farcall Func_00F_5D9D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D63:: ; heuristic: follows a terminator; C0
    farcall Func_00F_5C3B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D6A:: ; heuristic: follows a terminator; C0
    farcall Func_00F_59E6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D71:: ; heuristic: follows a terminator; C0
    farcall Func_00F_57EA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D78:: ; heuristic: follows a terminator; C0
    farcall Func_073_5FBC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D7F:: ; heuristic: follows a terminator; C0
    farcall Func_085_4207
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D86:: ; heuristic: follows a terminator; C0
    farcall Func_00F_56CD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D8D:: ; heuristic: follows a terminator; C0
    farcall Func_073_5F39
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D94:: ; heuristic: follows a terminator; C0
    farcall Func_073_5EB3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4D9B:: ; heuristic: follows a terminator; C0
    farcall Func_073_5DDD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DA2:: ; heuristic: follows a terminator; C0
    farcall Func_073_5DAF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DA9:: ; heuristic: follows a terminator; C0
    farcall Func_073_5C5F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DB0:: ; heuristic: follows a terminator; C0
    farcall Func_073_5AE4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DB7:: ; heuristic: follows a terminator; C0
    farcall Func_073_5AD6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DBE:: ; heuristic: follows a terminator; C0
    farcall Func_073_5ABB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DC5:: ; heuristic: follows a terminator; C0
    farcall Func_073_5A16
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DCC:: ; heuristic: follows a terminator; C0
    farcall Func_00F_5404
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DD3:: ; heuristic: follows a terminator; C0
    farcall Func_073_5987
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DDA:: ; heuristic: follows a terminator; C0
    farcall Func_073_5987
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DE1:: ; heuristic: follows a terminator; C0
    farcall Func_085_5248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DE8:: ; heuristic: follows a terminator; C0
    farcall Func_073_5919
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DEF:: ; heuristic: follows a terminator; C0
    farcall Func_073_58FE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DF6:: ; heuristic: follows a terminator; C0
    farcall Func_00F_4595
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4DFD:: ; heuristic: follows a terminator; C0
    farcall Func_00F_40E9
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E04:: ; heuristic: follows a terminator; C0
    farcall Func_073_587A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E0B:: ; heuristic: follows a terminator; C0
    farcall Func_073_5761
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E12:: ; heuristic: follows a terminator; C0
    farcall Func_00F_409A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E19:: ; heuristic: follows a terminator; C0
    farcall Func_073_572F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E20:: ; heuristic: follows a terminator; C0
    farcall Func_073_571D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E27:: ; heuristic: follows a terminator; C0
    farcall Func_085_5065
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E2E:: ; heuristic: follows a terminator; C0
    farcall Func_00F_5AF3
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E35:: ; heuristic: follows a terminator; C0
    farcall Func_073_5D71
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E3C:: ; heuristic: follows a terminator; C0
    farcall Func_073_5A57
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E43:: ; heuristic: follows a terminator; C0
    ld hl, $532C
    ld b, $85
    rst $10
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E4A:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7D97
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E51:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7D62
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E58:: ; heuristic: follows a terminator; C0
    farcall Func_085_4D8D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E5F:: ; heuristic: follows a terminator; C0
    farcall Func_085_4C24
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E66:: ; heuristic: follows a terminator; C0
    farcall Func_085_4B0F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E6D:: ; heuristic: follows a terminator; C0
    farcall Func_085_4AEE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E74:: ; heuristic: follows a terminator; C0
    farcall Func_085_4A6D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E7B:: ; heuristic: follows a terminator; C0
    farcall Func_085_494D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E82:: ; heuristic: follows a terminator; C0
    farcall Func_085_48A0
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E89:: ; heuristic: follows a terminator; C0
    farcall Func_085_505A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E90:: ; heuristic: follows a terminator; C0
    farcall Func_085_4858
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E97:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7CFB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4E9E:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7CA5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EA5:: ; heuristic: follows a terminator; C0
    farcall Func_00F_7AC6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EAC:: ; heuristic: follows a terminator; C0
    farcall Func_085_4717
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EB3:: ; heuristic: follows a terminator; C0
    farcall Func_085_4DA6
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EBA:: ; heuristic: follows a terminator; C0
    farcall Func_085_46E4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EC1:: ; heuristic: follows a terminator; C0
    farcall Func_085_49FA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EC8:: ; heuristic: follows a terminator; C0
    farcall Func_085_4A2B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4ECF:: ; heuristic: follows a terminator; C0
    farcall Func_085_4755
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4ED6:: ; heuristic: follows a terminator; C0
    farcall Func_085_481C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EDD:: ; heuristic: follows a terminator; C0
    farcall Func_085_479B
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EE4:: ; heuristic: follows a terminator; C0
    farcall Func_073_568E
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EEB:: ; heuristic: follows a terminator; C0
    farcall Func_073_55C5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EF2:: ; heuristic: follows a terminator; C0
    farcall Func_085_4F14
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4EF9:: ; heuristic: follows a terminator; C0
    farcall Func_073_55A4
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F00:: ; heuristic: follows a terminator; C0
    farcall Func_073_5577
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F07:: ; heuristic: follows a terminator; C0
    farcall Func_085_50F2
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F0E:: ; heuristic: follows a terminator; C0
    farcall Func_073_5449
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F15:: ; heuristic: follows a terminator; C0
    farcall Func_00F_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F1C:: ; heuristic: follows a terminator; C0
    farcall Func_073_541D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F23:: ; heuristic: follows a terminator; C0
    farcall Func_073_53AB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F2A:: ; heuristic: follows a terminator; C0
    farcall Func_073_5378
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F31:: ; heuristic: follows a terminator; C0
    farcall Func_073_51BD
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F38:: ; heuristic: follows a terminator; C0
    farcall Func_073_5546
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F3F:: ; heuristic: follows a terminator; C0
    farcall Func_085_501A
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F46:: ; heuristic: follows a terminator; C0
    farcall Func_085_403D
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_4F4D:: ; heuristic: follows a terminator; C0
    farcall Func_085_4001
    ret
    INCBIN "dwm2-cobi-us.gbc", $040F54, $3EA

Data_010_533E:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $0D, $42, $E7, $59, $66, $FF

Data_010_5345:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $0E, $42, $E7, $59, $66, $FF

Data_010_534C:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $89, $4D, $E7, $59, $66, $FF

Data_010_5353:: ; heuristic: bank from RAM variable $D7FE; C0
    db $0A, $03, $01, $00, $1C, $41, $E7, $B5, $67, $FF, $00, $1D, $41, $E7, $B5, $67
    db $FF

Data_010_5364:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041364, $2E7

Data_010_564B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04164B, $1A2

Data_010_57ED:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0417ED, $1D4

Data_010_59C1:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0419C1, $1CB

Data_010_5B8C:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $09, $48, $E7, $07, $67, $FF, $FF, $00, $BB, $41, $E7, $0B, $69, $FF, $00
    db $18, $48, $06, $04, $00, $1A, $88, $FF, $00, $19, $88, $FF, $00, $20, $48, $E7
    db $D4, $77, $FF

Data_010_5BAF:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041BAF, $1B9

Data_010_5D68:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041D68, $48

Data_010_5DB0:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $31, $43, $E7, $59, $66, $FF

Data_010_5DB7:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $32, $43, $E7, $07, $67, $FF

Data_010_5DBE:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041DBE, $D0

Data_010_5E8E:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041E8E, $7D

Data_010_5F0B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $041F0B, $F8

Data_010_6003:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $BB, $41, $E7, $0B, $69, $FF, $00, $12, $04, $00, $E6, $0D, $50, $0A, $A4
    db $00, $FF, $00, $1D, $04, $01, $00, $01, $01, $05, $80, $03, $FF, $00, $26, $44
    db $06, $04, $00, $28, $84, $FF, $00, $27, $84, $FF, $00, $26, $44, $06, $04, $00
    db $28, $84, $FF, $00, $29, $84, $FF, $00, $2E, $44, $E7, $D4, $77, $FF

Data_010_6041:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $2D, $44, $E7, $07, $67, $FF

Data_010_6048:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $32, $44, $E7, $0B, $69, $FF, $00, $33, $04, $51, $0D, $05, $0A, $A8, $00
    db $FF, $00, $33, $04, $0D, $05, $0A, $A8, $00, $FF, $00, $39, $44, $06, $04, $00
    db $3B, $84, $FF, $00, $3A, $84, $FF, $00, $47, $44, $06, $04, $00, $49, $84, $FF
    db $00, $48, $84, $FF

Data_010_607C:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04207C, $2FF

Data_010_637B:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04237B, $C3

Data_010_643E:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $04243E, $16C

Data_010_65AA:: ; heuristic: bank from RAM variable $D7FE; C0
    db $00, $24, $41, $E7, $0B, $69, $FF, $00, $28, $41, $E7, $0B, $69, $FF, $00, $27
    db $41, $E7, $D4, $77, $FF

; no direct call (reached through a table, a jump or a vector)
Func_010_65BF:: ; heuristic: target of a pointer table; C0
    farcall Func_01C_4075
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65C6:: ; heuristic: target of a pointer table; C0
    farcall Func_01C_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65CD:: ; heuristic: target of a pointer table; C0
    farcall Func_01C_4696
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65D4:: ; heuristic: target of a pointer table; C0
    farcall Func_01C_4605
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65DB:: ; heuristic: follows a terminator; C0
    farcall Func_01C_6CEF
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65E2:: ; heuristic: follows a terminator; C0
    farcall Func_01C_6CEB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65E9:: ; heuristic: follows a terminator; C0
    farcall Func_01E_4069
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65F0:: ; heuristic: follows a terminator; C0
    farcall Func_01E_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65F7:: ; heuristic: target of a pointer table; C0
    farcall Func_014_40CC
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_65FE:: ; heuristic: target of a pointer table; C0
    farcall Func_014_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6605:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_660C:: ; heuristic: target of a pointer table; C0
    farcall Func_015_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6613:: ; heuristic: target of a pointer table; C0
    ld hl, $45D1
    ld b, $0D
    rst $10
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_661A:: ; heuristic: target of a pointer table; C0
    farcall Func_00D_5159
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6621:: ; heuristic: target of a pointer table; C0
    farcall Func_00D_50E5
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6628:: ; heuristic: target of a pointer table; C0
    farcall Func_00D_55BE
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_662F:: ; heuristic: target of a pointer table; C0
    farcall Func_00D_6310
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6636:: ; heuristic: target of a pointer table; C0
    farcall Func_00D_711C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_663D:: ; heuristic: follows a terminator; C0
    farcall Func_00D_7115
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6644:: ; heuristic: follows a terminator; C0
    farcall Func_00C_4001
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_664B:: ; heuristic: follows a terminator; C0
    farcall Func_00C_659F
    ret

; no direct call (reached through a table, a jump or a vector)
Func_010_6652:: ; heuristic: follows a terminator; C0
    farcall Func_024_60DB
    ret
    INCBIN "dwm2-cobi-us.gbc", $042659, $2CF
    ds $16D8, $00
