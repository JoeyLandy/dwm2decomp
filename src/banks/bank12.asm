SECTION "Bank 12", ROMX[$4000], BANK[$12]
    db $12

Func_012_4001::
    ld a, [wC923]
    rst $00
    dw Jump_012_4009
    dw Jump_012_401B

Jump_012_4009::
    ld a, $10
    call Func_012_6820
    ld hl, wC923
    inc [hl]
    ret

Func_012_4013::
    ld a, [wC923]
    rst $00
    dw Jump_012_4026
    dw Jump_012_401B

Jump_012_401B::
    xor a, a
    call Func_012_683C
    ret nc
    ld a, $80
    ld [wC919], a
    ret

Jump_012_4026::
    ld a, $0F
    call Func_012_6820
    ld hl, wC923
    inc [hl]
    ret

Func_012_4030::
    ld a, [wC923]
    or a, a
    jr z, Jump_012_403C
    ld a, $80
    ld [wC919], a
    ret

Jump_012_403C::
    xor a, a
    ld [wC903], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_404C
    ld a, $01
    ld [wC903], a

Jump_012_404C::
    call Func_000_09F3
    ld a, [wCD03]
    and a, $01
    sla a
    ld [wC905], a
    farcall Func_05F_6C71
    ld hl, wC923
    inc [hl]
    ret

Func_012_4064::
    ld a, [wC923]
    rst $00
    dw Func_012_41ED
    dw Func_012_41CC
    dw Func_012_41AA
    dw Func_012_4177
    dw Func_012_413C
    dw Func_012_4115
    dw Func_012_40FC
    dw Func_012_40E1
    dw Func_012_40B8
    dw Func_012_4092
    dw Func_012_4080
    dw Func_012_422C

Func_012_4080:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wC8F9], a
    ld a, [wC8FB]
    inc a
    ld [wC8FB], a
    ld de, wC8FB
    call Func_012_42B5
    ret

Func_012_4092:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wC8F4], a
    ld de, wC8F6
    call Func_012_42B5
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a
    ld hl, wC8FB
    inc [hl]
    ld a, [wC921]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $0B
    ld [wC923], a
    ret

Func_012_40B8:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wC8EF], a
    ld de, wC8F1
    call Func_012_42B5
    ld a, [wC8F1]
    inc a
    ld [wC8F1], a
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8FB
    inc [hl]
    ld a, [wC921]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $0B
    ld [wC923], a
    ret

Func_012_40E1:: ; heuristic: target of a pointer table; C0
    xor a, a
    ldh [hFF98], a
    ld de, hFF91
    call Func_012_42B5
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    ld hl, wC8F1
    inc [hl]
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8FB
    inc [hl]
    ret

Func_012_40FC:: ; heuristic: target of a pointer table; C0
    ld hl, wC8FB
    inc [hl]

Func_012_4100:: ; heuristic: target of a pointer table; C0
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8F1
    inc [hl]
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $20
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_4115:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $E0
    ld [wC8F1], a
    ld a, $D0
    ld [wC8F6], a
    ld a, $C0
    ld [wC8FB], a
    ld hl, hFF8C
    call Func_012_65F5
    ld hl, wC923
    inc [hl]
    ret

Func_012_413C:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wC8F9], a
    ld hl, hFF91
    inc [hl]
    ld hl, wC8F1
    inc [hl]
    ld hl, wC8F6
    inc [hl]
    ld a, [wC8FB]
    inc a
    ld [wC8FB], a
    cp a, $B0
    ret nz
    ld a, $00
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ld a, $02
    ldh [hFF92], a
    ld a, $70
    ld [wC8C8], a
    ld a, $F0
    ld [wC8C9], a
    xor a, a
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Func_012_4177:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wC8F9], a
    ld hl, hFF91
    inc [hl]
    ld hl, wC8F1
    inc [hl]
    ld hl, wC8F6
    inc [hl]
    ld a, $02
    ld [wC8EF], a
    ld a, $02
    ld [wC8F4], a
    ld hl, wC8FA
    inc [hl]
    ld de, wC8FB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    jp Jump_012_43C6

Func_012_41AA:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ld a, $02
    ld [wC8EF], a
    ld hl, hFF91
    inc [hl]
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    jp Jump_012_43C6

Func_012_41CC:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ld a, $02
    ldh [hFF98], a
    ld hl, hFF91
    inc [hl]
    ld de, wC8F1
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    jp Jump_012_43C6

Func_012_41ED:: ; heuristic: target of a pointer table; C0
    ld hl, hFF8C
    call Func_012_65F5
    ldh a, [hFF8E]
    call Func_012_65FF
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld hl, hFF8E
    inc [hl]
    jp Jump_012_43C6

Func_012_4210::
    ld a, [wC923]
    rst $00
    dw Func_012_43A6
    dw Func_012_438A
    dw Func_012_436E
    dw Func_012_4346
    dw Func_012_4310
    dw Func_012_42E9
    dw Func_012_42D7
    dw Func_012_4299
    dw Func_012_426F
    dw Func_012_424B
    dw Func_012_4238
    dw Func_012_422C

Func_012_422C:: ; heuristic: target of a pointer table; C0
    ld hl, hFF8C
    call Func_012_65FA
    ld a, $80
    ld [wC919], a
    ret

Func_012_4238:: ; heuristic: target of a pointer table; C0
    ld a, $03
    ld [wC8F9], a
    ld a, [wC8FA]
    dec a
    ld [wC8FA], a
    ld de, wC8FB
    call Func_012_42B5
    ret

Func_012_424B:: ; heuristic: target of a pointer table; C0
    ld a, $03
    ld [wC8F4], a
    ld de, wC8F6
    call Func_012_42B5
    ld hl, wC8F5
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ld a, [wC921]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $0B
    ld [wC923], a
    ret

Func_012_426F:: ; heuristic: target of a pointer table; C0
    ld a, $03
    ld [wC8EF], a
    ld de, wC8F1
    call Func_012_42B5
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ld a, [wC921]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $0B
    ld [wC923], a
    ret

Func_012_4299:: ; heuristic: target of a pointer table; C0
    ld a, $03
    ldh [hFF98], a
    ld de, hFF91
    call Func_012_42B5
    ldh a, [hFF8E]
    dec a
    ldh [hFF8E], a
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ret

Func_012_42B5::
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_42D7:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ldh a, [hFF91]
    dec a
    ldh [hFF91], a
    cp a, $50
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_42E9:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $C0
    ld [wC8F1], a
    ld a, $D0
    ld [wC8F6], a
    ld a, $E0
    ld [wC8FB], a
    ld hl, hFF8C
    call Func_012_65F5
    ld hl, wC923
    inc [hl]
    ret

Func_012_4310:: ; heuristic: target of a pointer table; C0
    ld hl, hFF91
    dec [hl]
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld a, [wC8FB]
    dec a
    ld [wC8FB], a
    cp a, $F0
    ret nz
    ld a, $1A
    ldh [hFF90], a
    ld a, $02
    ldh [hFF8F], a
    xor a, a
    ldh [hFF92], a
    ld a, $60
    ld [wC8C8], a
    ld a, $B0
    ld [wC8C9], a
    xor a, a
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Func_012_4346:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wC8F9], a
    ld hl, hFF91
    dec [hl]
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ld de, wC8FB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    jr Jump_012_43C6

Func_012_436E:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ld hl, hFF91
    dec [hl]
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    jr Jump_012_43C6

Func_012_438A:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ld hl, hFF91
    dec [hl]
    ld de, wC8F1
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    jr Jump_012_43C6

Func_012_43A6:: ; heuristic: target of a pointer table; C0
    ld hl, hFF8C
    call Func_012_65F5
    ldh a, [hFF91]
    call Func_012_65FF
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld hl, hFF91
    dec [hl]

Jump_012_43C6::
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_43DA::
    ld a, [wC923]
    rst $00
    dw Func_012_44AF
    dw Func_012_447A
    dw Func_012_474A
    dw Func_012_473C
    dw Func_012_4705
    dw Func_012_444D
    dw Func_012_473C
    dw Func_012_469E
    dw Func_012_461A
    dw Func_012_45D6
    dw Func_012_45CC
    dw Func_012_473C
    dw Func_012_4705
    dw Func_012_4420
    dw Func_012_473C
    dw Func_012_469E
    dw Func_012_461A
    dw Func_012_45D6
    dw Func_012_4595
    dw Func_012_473C
    dw Func_012_4705
    dw Func_012_4412
    dw Func_012_473C
    dw Func_012_456A
    dw Func_012_4546
    dw $4515

Func_012_4412:: ; heuristic: target of a pointer table; C0
    ld a, $07
    call Func_012_488B
    ld hl, wC923
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ret

Func_012_4420:: ; heuristic: target of a pointer table; C0
    ld hl, wD7FF
    dec [hl]
    ld a, [wD7FF]
    cp a, $02
    jr nz, Jump_012_4437
    ld a, $07
    call Func_012_488B
    ld a, $16
    ld [wC923], a
    jr Jump_012_4440

Jump_012_4437::
    ld a, $05
    call Func_012_488B
    ld hl, wC923
    inc [hl]

Jump_012_4440::
    farcall Func_00C_703D
    farcall Func_00C_73F5
    ret

Func_012_444D:: ; heuristic: target of a pointer table; C0
    ld hl, wD7FF
    dec [hl]
    ld a, [wD7FF]
    cp a, $02
    jr nz, Jump_012_4464
    ld a, $07

Func_012_445A:: ; heuristic: target of a pointer table; C0
    call Func_012_488B
    ld a, $16
    ld [wC923], a
    jr Jump_012_446D

Jump_012_4464::
    ld a, $03
    call Func_012_488B
    ld hl, wC923
    inc [hl]

Jump_012_446D::
    farcall Func_00C_703D
    farcall Func_00C_73F5
    ret

Func_012_447A:: ; heuristic: target of a pointer table; C0
    ld a, $0E
    ldh [hFF8D], a
    xor a, a
    call Func_012_684A
    ret nc
    ld hl, hFF8C
    call Func_012_65F5
    xor a, a
    ldh [hFF98], a
    ld [wC8F1], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $40
    ldh [hFF8E], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld hl, wC94A
    inc [hl]
    xor a, a
    ld [wC924], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_44AF:: ; heuristic: target of a pointer table; C0
    ld a, $0B
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $00
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, [wD7FC]
    add a, $05
    call Func_012_6820
    ld a, $80
    ld [wC94A], a
    ret

Func_012_44DB::
    ld a, [wC923]
    rst $00
    dw Func_012_4863
    dw Func_012_4850
    dw Func_012_4814
    dw Func_012_474A
    dw Func_012_473C
    dw Func_012_4705
    dw Func_012_46D8
    dw Func_012_473C
    dw Func_012_469E
    dw Func_012_461A
    dw Func_012_45D6
    dw Func_012_45CC
    dw Func_012_473C
    dw Func_012_4705
    dw Func_012_459F
    dw Func_012_473C
    dw Func_012_469E
    dw Func_012_461A
    dw Func_012_45D6
    dw Func_012_4595
    dw Func_012_473C
    dw Func_012_4705
    dw Func_012_4587
    dw Func_012_473C
    dw Func_012_456A
    dw Func_012_4546
    dw $4515

Func_012_4515:: ; heuristic: target of a pointer table; C0
    dw $4B21

Func_012_4517:: ; heuristic: follows a terminator; C0
    ld h, b
    ld b, $02
    rst $10
    ld a, $01
    ld [wC917], a
    ld a, $65
    ld [wC916], a
    ld a, [wC91C]
    ld [wC919], a
    ld a, [wC91D]
    ld [wC91A], a
    ld a, [wC91E]
    ld [wC91B], a
    ld a, $02
    ldh [hFFB9], a
    ld a, $F7
    ld [wC920], a
    ld a, $01
    ld [wD7FD], a
    ret

Func_012_4546:: ; heuristic: target of a pointer table; C0
    call Func_012_64F8
    ld a, $04
    ldh [hFF90], a
    ld a, $01
    ldh [hFF8F], a
    xor a, a
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Func_012_456A:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $01
    jr nz, Jump_012_457B
    ld a, $6D
    call Func_000_1278
    ret

Jump_012_457B::
    cp a, $3C
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4587:: ; heuristic: target of a pointer table; C0
    ld a, $07
    call Func_012_488B
    ld hl, wC923
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ret

Func_012_4595:: ; heuristic: target of a pointer table; C0
    ld a, $06
    call Func_012_488B
    ld hl, wC923
    inc [hl]
    ret

Func_012_459F:: ; heuristic: target of a pointer table; C0
    ld a, $05
    call Func_012_488B
    ld hl, wC923
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ld a, [wC82C]
    or a, a
    jr nz, Jump_012_45BF
    farcall Func_00C_704B
    farcall Func_00C_744D
    ret

Jump_012_45BF::
    farcall Func_00C_704B
    farcall Func_00C_74A6
    ret

Func_012_45CC:: ; heuristic: target of a pointer table; C0
    ld a, $04
    call Func_012_488B
    ld hl, wC923
    inc [hl]
    ret

Func_012_45D6:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wCB86], a
    ld a, [wCB8B]
    dec a
    ld [wCB8B], a
    cp a, $30
    ret nz
    ld a, $07
    ld [wC90D], a
    ld a, $03
    ld [wCB86], a
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    db $21, $8C

Func_012_45FA:: ; heuristic: target of a pointer table; C0
    set 1, l
    ld a, [$2165]
    sbc a, h
    set 1, l
    ld a, [$2165]
    xor a, h
    set 1, l
    ld a, [$2165]
    cp a, h
    set 1, l
    ld a, [$3E65]
    nop
    call Func_000_1278
    ld hl, wC923
    inc [hl]
    ret

Func_012_461A:: ; heuristic: target of a pointer table; C0
    ld a, [wC924]
    cp a, $60
    jr z, Jump_012_4644
    inc a
    ld [wC924], a
    cp a, $10
    jr nz, Jump_012_4630
    ld a, $02
    ld [wCB7D], a
    jr Jump_012_4644

Jump_012_4630::
    cp a, $20
    jr nz, Jump_012_463B
    ld a, $03
    ld [wCB7D], a
    jr Jump_012_4644

Jump_012_463B::
    cp a, $30
    jr nz, Jump_012_4644
    ld a, $04
    ld [wCB7D], a

Jump_012_4644::
    ld hl, wCB8B
    ld b, $04

Jump_012_4649::
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_4653
    cp a, $20
    jr nc, Jump_012_4659

Jump_012_4653::
    ld a, [hl]
    inc a
    ld [hl], a
    jp Jump_012_4692

Jump_012_4659::
    dec hl
    ld a, [hl]
    cp a, $60
    jr nc, Jump_012_466B
    ld a, [hl]
    inc a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $01
    jp Jump_012_4692

Jump_012_466B::
    inc hl
    ld a, [hl]
    cp a, $40
    jr nc, Jump_012_467E
    ld a, [hl]
    inc a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $00
    jp Jump_012_4692

Jump_012_467E::
    dec hl
    ld a, [hl]
    inc a
    ld [hl], a
    push af
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $01
    pop af
    cp a, $70
    jr nz, Jump_012_4692
    ld hl, wC923
    inc [hl]

Jump_012_4692::
    pop hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_012_469A
    inc h

Jump_012_469A::
    dec b
    jr nz, Jump_012_4649
    ret

Func_012_469E:: ; heuristic: target of a pointer table; C0
    farcall Func_085_5B53
    ld a, $7F
    ld [wC527], a
    ld a, $01
    ld [wCB7D], a
    ld hl, wCB8C
    call Func_012_65F5
    ld hl, wCB9C
    call Func_012_65F5
    ld hl, wCBAC
    call Func_012_65F5
    ld hl, wCBBC
    call Func_012_65F5
    xor a, a
    ld [wC90D], a
    ld a, $6D
    call Func_000_1278
    xor a, a
    ld [wC924], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_46D8:: ; heuristic: target of a pointer table; C0
    ld a, $03
    call Func_012_488B
    ld hl, wC923
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ld a, [wC82C]
    or a, a
    jr nz, Jump_012_46F8
    farcall Func_00C_704B
    farcall Func_00C_744D
    ret

Jump_012_46F8::
    farcall Func_00C_704B
    farcall Func_00C_74A6
    ret

Func_012_4705:: ; heuristic: target of a pointer table; C0
    ld hl, wC8F0
    inc [hl]
    ld hl, wC8F5
    inc [hl]
    ld hl, wC8FA
    inc [hl]
    ld hl, wCB9A
    dec [hl]
    ld hl, wCBAA
    dec [hl]
    ld hl, wCBBA
    dec [hl]
    ld b, $10
    call Func_012_65A4
    ret nc
    ld hl, wC923
    inc [hl]
    ld hl, wD7FF
    inc [hl]
    ld a, $04
    ld [wC903], a
    ld a, $01
    ld [wC905], a
    farcall Func_05F_6C71
    ret

Func_012_473C:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_684A
    ret nc
    xor a, a
    ld [wC924], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_474A:: ; heuristic: target of a pointer table; C0
    ld hl, hFF8C
    call Func_012_65F5
    ld a, [wC924]
    cp a, $60
    jr z, Jump_012_4776
    inc a
    ld [wC924], a
    cp a, $10
    jr nz, Jump_012_4765
    ld a, $0C
    ldh [hFF8D], a
    jr Jump_012_4776

Jump_012_4765::
    cp a, $20
    jr nz, Jump_012_476F
    ld a, $08
    ldh [hFF8D], a
    jr Jump_012_4776

Jump_012_476F::
    cp a, $30
    jr nz, Jump_012_4776
    xor a, a
    ldh [hFF8D], a

Jump_012_4776::
    ld a, [wC921]
    or a, a
    jr nz, Jump_012_478E
    ldh a, [hFF91]
    call Func_012_65FF
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $20
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_012_478E::
    dec a
    jr nz, Jump_012_47A7
    ldh a, [hFF8E]
    call Func_012_65FF
    ld a, $03
    ldh [hFF98], a
    ldh a, [hFF8E]
    dec a
    ldh [hFF8E], a
    cp a, $30
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_012_47A7::
    dec a
    jr nz, Jump_012_47BF
    ldh a, [hFF91]
    call Func_012_65FF
    xor a, a
    ldh [hFF98], a
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $40
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_012_47BF::
    dec a
    jr nz, Jump_012_47D8
    ldh a, [hFF8E]
    call Func_012_65FF
    ld a, $03
    ldh [hFF98], a
    ldh a, [hFF8E]
    dec a
    ldh [hFF8E], a
    cp a, $20
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_012_47D8::
    ld a, $02
    ldh [hFF98], a
    ldh a, [hFF91]
    dec a
    ldh [hFF91], a
    cp a, $30
    ret nz
    ld hl, hFF8C
    call Func_012_65FA
    ld a, $01
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $02
    call Func_012_488B
    ld a, [wC922]
    ld [wC90D], a
    ld a, $00
    call Func_000_1278
    xor a, a
    ld [wC921], a
    xor a, a
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4814:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_684A
    ret nc
    ld hl, hFF8C
    call Func_012_65F5
    xor a, a
    ldh [hFF98], a
    ld [wC8F1], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $40
    ldh [hFF8E], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld a, $6D
    call Func_000_1278
    ld a, [wC90D]
    ld [wC922], a
    xor a, a
    ld [wC90D], a
    xor a, a
    ld [wC924], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4850:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_684A
    ret nc
    ld a, $01
    call Func_012_488B
    ld a, $0E
    db $E0

Func_012_485D:: ; heuristic: target of a pointer table; C0
    adc a, l
    ld hl, wC923
    inc [hl]
    ret

Func_012_4863:: ; heuristic: target of a pointer table; C0
    ld a, $0B
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $00
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $00
    call Func_012_488B
    xor a, a
    ld [wC94A], a
    ret

Func_012_488B::
    ld de, Data_012_48B9
    sla a
    add a, e
    ld e, a
    jr nc, Jump_012_4895
    inc d

Jump_012_4895::
    ld a, [wC94A]
    bit 7, a
    jr nz, Jump_012_48AB
    ld a, [wC82C]
    swap a
    add a, e
    ld e, a
    jr nc, Jump_012_48A6
    inc d

Jump_012_48A6::
    ld a, [de]
    call Func_012_6820
    ret

Jump_012_48AB::
    ld a, $05
    swap a
    add a, e
    ld e, a
    jr nc, Jump_012_48B4
    inc d

Jump_012_48B4::
    ld a, [de]
    call Func_012_6820
    ret

Data_012_48B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0488B9, $60

Func_012_4919::
    ld a, [wC923]
    rst $00
    dw Func_012_4D6B
    dw Func_012_4D56
    dw Func_012_4D46
    dw Func_012_4D3B
    dw Func_012_4D15
    dw Func_012_4D05
    dw Func_012_4D3B
    dw Func_012_4CDF
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CB4
    dw Func_012_4CAA
    dw Func_012_4CA0
    dw Func_012_4D56
    dw Func_012_4D3B
    dw Func_012_4C97
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_494B

Func_012_494B:: ; heuristic: target of a pointer table; C0
    ld a, [wC965]
    ld [wC88D], a
    ld a, $08
    ld [wC5DB], a
    ld a, $00
    ld [wC5DC], a
    ld a, $01
    ld [wC5DF], a
    xor a, a
    ld [wC91F], a
    ret

Func_012_4965::
    ld a, [wC923]
    rst $00
    dw Func_012_4DDC
    dw Func_012_4D6B
    dw Func_012_4D56
    dw Func_012_4D46
    dw Func_012_4D3B
    dw Func_012_4D15
    dw Func_012_4D05
    dw Func_012_4D3B
    dw Func_012_4CDF
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CB4
    dw Func_012_4CAA
    dw Func_012_4CA0
    dw Func_012_4D56
    dw Func_012_4D3B
    dw Func_012_4C97
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_49C8
    dw Func_012_499B

Func_012_499B:: ; heuristic: target of a pointer table; C0
    ld a, [wC937]
    ld [wCB86], a
    ld a, $01
    ld [wC917], a
    ld a, $89
    ld [wC916], a
    ld a, [wC91C]
    ld [wC919], a
    ld a, [wC91D]
    ld [wC91A], a
    ld a, [wC91E]
    ld [wC91B], a
    ld a, $F4
    ld [wC920], a
    ld a, $01
    ld [wD7FD], a
    ret

Func_012_49C8:: ; heuristic: target of a pointer table; C0
    ld a, [wD7FB]
    ld hl, Data_012_4A14
    add a, l
    ld l, a
    jr nc, Jump_012_49D3
    inc h

Jump_012_49D3::
    ld a, [hl]
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, [wD7FB]
    cp a, $01
    jr z, Jump_012_49F6
    cp a, $03
    jr z, Jump_012_49F6
    cp a, $05
    jr z, Jump_012_49F6
    cp a, $06
    jr z, Jump_012_49F6
    cp a, $07
    jr z, Jump_012_49F6
    ld a, $02
    ldh [hFF8F], a

Jump_012_49F6::
    ld a, $40
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $00
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $01
    ld [wC936], a
    ret

Data_012_4A14:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $17, $04, $17, $04, $17, $17, $17, $04, $04

Func_012_4A1E::
    ld a, [wC923]
    rst $00
    dw Func_012_4DDC
    dw Func_012_4D6B
    dw Func_012_4D56
    dw Func_012_4D46
    dw Func_012_4D3B
    dw Func_012_4D15
    dw Func_012_4D05
    dw Func_012_4D3B
    dw Func_012_4CDF
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CB4
    dw Func_012_4CAA
    dw Func_012_4CA0
    dw Func_012_4A5A
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4B9B
    dw Func_012_4B77
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4B19
    dw Func_012_4B0A
    dw Func_012_4AC0

Func_012_4A5A:: ; heuristic: target of a pointer table; C0
    ld a, $0B
    ld hl, wCAD0
    add a, l
    ld l, a
    jr nc, Jump_012_4A64
    inc h

Jump_012_4A64::
    ld a, [hl+]
    ld [wCB91], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCB92], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $06
    ldh [hFFC9], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld a, $0D
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $7F
    ld [wC527], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4A9A::
    ld a, [wC923]
    rst $00
    dw Func_012_4DDC
    dw Func_012_4BB4
    dw Func_012_4D56
    dw Func_012_4D3B
    dw Func_012_4BAA
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4B9B
    dw Func_012_4B77
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4B19
    dw Func_012_4B0A
    dw Func_012_4AC0

Func_012_4AC0:: ; heuristic: target of a pointer table; C0
    ld a, $0D
    ldh [hFF90], a
    ld a, $01
    ldh [hFF8F], a
    xor a, a
    ldh [hFF92], a
    ld a, $40
    ldh [hFF8E], a
    ld a, $40
    ldh [hFF91], a
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wCB7D], a
    xor a, a
    ld [wC90D], a
    ld a, $01
    ld [wC917], a
    ld a, $6A
    ld [wC916], a
    ld a, [wC91C]
    ld [wC919], a
    ld a, [wC91D]
    ld [wC91A], a
    ld a, [wC91E]
    ld [wC91B], a
    ld a, $02
    ldh [hFFB9], a
    ld a, $ED
    ld [wC920], a
    ld a, $01
    ld [wD7FD], a
    ret

Func_012_4B0A:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_683C
    ret nc
    ld hl, wC923
    inc [hl]
    ld a, [wC921]
    ldh [hFFB9], a
    ret

Func_012_4B19:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    ld hl, wCAD0
    ld a, $0B
    add a, l
    ld l, a
    jr nc, Jump_012_4B27
    inc h

Jump_012_4B27::
    ld a, [hl+]
    ld [wC529], a
    ld a, [hl]
    inc a
    inc a
    ld [wC528], a
    ld de, wC151
    ld a, e
    ld [wC53D], a
    ld a, d
    ld [wC53E], a
    farcall Func_008_4016
    ld hl, wCAD0
    ld a, $6D
    add a, l
    ld l, a
    jr nc, Jump_012_4B4C
    inc h

Jump_012_4B4C::
    ld a, [hl]
    or a, a
    jr nz, Jump_012_4B56
    ld a, $17
    call Func_012_6820
    ret

Jump_012_4B56::
    ld b, a
    ld a, $0A
    call Func_000_16BF
    ld hl, wC17E
    push af
    ld a, b
    or a, a
    jr z, Jump_012_4B65
    ld [hl+], a

Jump_012_4B65::
    pop af
    ld [hl+], a
    ld [hl], $F0
    ld a, $18
    call Func_012_6820
    ldh a, [hFFB9]
    ld [wC921], a
    xor a, a
    ldh [hFFB9], a
    ret

Func_012_4B77:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    cp a, $C2
    jr nz, Jump_012_4B83
    ld a, $74
    call Func_000_1278

Jump_012_4B83::
    ld b, $E0
    call Func_012_65A4
    ret nc
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wCB96], a
    ld a, $3C
    ld [wCB9B], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4B9B:: ; heuristic: target of a pointer table; C0
    ld a, $0E
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld hl, wC923
    inc [hl]
    ret

Func_012_4BAA:: ; heuristic: target of a pointer table; C0
    ld a, $80
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4BB4:: ; heuristic: target of a pointer table; C0
    xor a, a
    ldh [hFFB9], a
    ldh a, [hFF8D]
    or a, $0F
    ldh [hFF8D], a
    ld a, $0B
    ld hl, wCAD0
    add a, l
    ld l, a
    jr nc, Jump_012_4BC7
    inc h

Jump_012_4BC7::
    ld a, [hl+]
    ld [wCB91], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCB92], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $06
    ldh [hFFC9], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld a, $0D
    ldh [hFFC6], a
    farcall Func_012_6B98
    xor a, a
    ld [wCBCF], a
    ld a, $7F
    ld [wC527], a
    ld hl, wCB8C
    call Func_012_65F5
    ld hl, wC923
    inc [hl]
    ret

Func_012_4C07::
    ld a, [wC923]
    rst $00
    dw Func_012_4DDC
    dw Func_012_4D6B
    dw Func_012_4D56
    dw Func_012_4D46
    dw Func_012_4D3B
    dw Func_012_4D15
    dw Func_012_4D05
    dw Func_012_4D3B
    dw Func_012_4CDF
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_4D3B
    dw Func_012_4CB4
    dw Func_012_4CAA
    dw Func_012_4CA0
    dw Func_012_4D56
    dw Func_012_4D3B
    dw Func_012_4C97
    dw Func_012_4D3B
    dw Func_012_4CBC
    dw Func_012_4D3B
    dw Func_012_4C69
    dw Func_012_4C3D

Func_012_4C3D:: ; heuristic: target of a pointer table; C0
    ld a, [wC56C]
    or a, a
    ret nz
    ld a, $01
    ld [wC917], a
    ld a, $6A
    ld [wC916], a
    ld a, [wC91C]
    ld [wC919], a
    ld a, [wC91D]
    ld [wC91A], a
    ld a, [wC91E]
    ld [wC91B], a
    ld a, $ED
    ld [wC920], a
    ld a, $01
    ld [wD7FD], a
    ret

Func_012_4C69:: ; heuristic: target of a pointer table; C0
    ld a, $0D
    ldh [hFF90], a
    ld a, $01
    ldh [hFF8F], a
    ldh [hFF8F], a
    xor a, a
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $00
    ld [wC8C6], a
    ld a, $0F
    call Func_000_0DF2
    ld a, $01
    ld [wC936], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4C97:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4CA0:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_683C
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Func_012_4CAA:: ; heuristic: target of a pointer table; C0
    ld a, $0E
    call Func_012_6820
    ld hl, wC923
    inc [hl]
    ret

Func_012_4CB4:: ; heuristic: target of a pointer table; C0
    ld a, $8D
    ld [wC927], a
    jp Func_012_4DDC

Func_012_4CBC:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wCB86], a
    ld hl, wCB8C
    call Func_012_65F5
    ld a, [wCB8B]
    inc a
    ld [wCB8B], a
    cp a, $C8
    ret nz
    ld a, $01
    ld [wCB96], a
    ld a, $03
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4CDF:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wCBA6], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    cp a, $58
    ret nz
    xor a, a
    ld [wCBA6], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4D05:: ; heuristic: target of a pointer table; C0
    ld b, $3C
    call Func_012_65A4
    ret nc
    ld a, $40
    ld [wCBAB], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4D15:: ; heuristic: target of a pointer table; C0
    ld a, $03
    ld [wCB96], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $48
    ret nz
    xor a, a
    ld [wCB96], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4D3B:: ; heuristic: target of a pointer table; C0
    ld b, $1E
    call Func_012_65A4
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Func_012_4D46:: ; heuristic: target of a pointer table; C0
    ld b, $3C
    call Func_012_65A4
    ret nc
    ld a, $40
    ld [wCB9B], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_4D56:: ; heuristic: target of a pointer table; C0
    ld a, [wCB8B]
    dec a
    ld [wCB8B], a
    cp a, $58
    ret nz
    ld hl, wCB8C
    call Func_012_65FA
    ld hl, wC923
    inc [hl]
    ret

Func_012_4D6B:: ; heuristic: target of a pointer table; C0
    xor a, a
    ldh [hFFB9], a
    ldh a, [hFF8D]
    or a, $0F
    ldh [hFF8D], a
    ld a, $0B
    ld hl, wC986
    add a, l
    ld l, a
    jr nc, Jump_012_4D7E
    inc h

Jump_012_4D7E::
    ld a, [hl+]
    ld [wCB91], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCB92], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $06
    ldh [hFFC9], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld a, $0B
    ld hl, wCA2B
    add a, l
    ld l, a
    jr nc, Jump_012_4DAA
    inc h

Jump_012_4DAA::
    ld a, [hl+]
    ld [wCBA1], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCBA2], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $07
    ldh [hFFC9], a
    ld hl, vTiles0 + $700
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld a, $7F
    ld [wC527], a
    ld hl, wCB8C
    call Func_012_65F5
    ld hl, wC923
    inc [hl]
    ret

Func_012_4DDC:: ; heuristic: target of a pointer table; C0
    ld a, $14
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $00
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Func_012_4DFB:: ; heuristic: follows a terminator; C0
    ld a, [wCB86]
    ld [wC937], a
    ldh a, [hFF8E]
    ld [wC938], a
    ldh a, [hFF91]
    ld [wC939], a
    ldh a, [hFF98]
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
    ld hl, wC923
    inc [hl]
    ret

Func_012_4E4B::
    ld a, [wC923]
    rst $00
    dw Func_012_4FD7
    dw Func_012_4FBC
    dw Func_012_4F2E

Func_012_4E55::
    ld a, [wC923]
    rst $00
    dw Func_012_4FD7
    dw Func_012_4FBC
    dw Func_012_4EAD
    dw Func_012_4E63
    dw Func_012_4F2E

Func_012_4E63:: ; heuristic: target of a pointer table; C0
    ld hl, hFF8C
    call Func_012_65EB
    xor a, a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F6]
    cp a, $E0
    jr nc, Jump_012_4E82
    ld a, [wC8FB]
    inc a
    inc a
    ld [wC8FB], a

Jump_012_4E82::
    ld a, [wC8F1]
    cp a, $E0
    jr nc, Jump_012_4E91
    ld a, [wC8F6]
    inc a
    inc a
    ld [wC8F6], a

Jump_012_4E91::
    ldh a, [hFF91]
    cp a, $E0
    jr nc, Jump_012_4E9F
    ld a, [wC8F1]
    inc a
    inc a
    ld [wC8F1], a

Jump_012_4E9F::
    ldh a, [hFF91]
    inc a
    inc a
    ldh [hFF91], a
    cp a, $50
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_4EAD:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ldh [hFF90], a
    ld a, $01
    ldh [hFF8F], a
    xor a, a
    ldh [hFF92], a
    ldh a, [hFF8E]
    ld [wC8C8], a
    ld a, $F0
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Func_012_4ECE::
    ld a, [wC923]
    rst $00
    dw Func_012_4FD7
    dw Func_012_4FBC
    dw Func_012_4F8E
    dw Func_012_4F77
    dw Func_012_4EDE
    dw Func_012_4F2E

Func_012_4EDE:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ld hl, hFF91
    inc [hl]
    ldh a, [hFF91]
    call Func_012_65FF
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $20
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_4EF9::
    ld a, [wC923]
    rst $00
    dw Func_012_4FD7
    dw Jump_012_4F03
    dw Func_012_4F2E

Jump_012_4F03::
    ldh a, [hFF91]
    call Func_012_65FF
    ld hl, hFF91
    inc [hl]
    ldh a, [hFF91]
    call Func_012_65FF
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $60
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_4F1E::
    ld a, [wC923]
    rst $00
    dw Func_012_4FD7
    dw Func_012_4FBC
    dw Func_012_4F8E
    dw Func_012_4F77
    dw Func_012_4F5C
    dw Func_012_4F2E

Func_012_4F2E:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ldh a, [hFF91]
    call Func_012_65FF
    ld a, [wC6FD]
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8F1
    add a, l
    ld l, a
    jr nc, Jump_012_4F4A
    inc h

Jump_012_4F4A::
    ld a, [hl]
    ld c, a
    ldh a, [hFF91]
    cp a, c
    ret nz
    ld hl, hFF8C
    call Func_012_65F0
    ld a, $80
    ld [wC919], a
    ret

Func_012_4F5C:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ld hl, hFF91
    inc [hl]
    ldh a, [hFF91]
    call Func_012_65FF
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $50
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_4F77:: ; heuristic: target of a pointer table; C0
    farcall Func_002_541B
    farcall Func_002_5BD7
    ld a, [wC468]
    bit 7, a
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_4F8E:: ; heuristic: target of a pointer table; C0
    ld a, $80
    ld [wC468], a
    ld a, $08
    ld [wC46A], a
    ld hl, hFF92
    inc [hl]
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, hFF80
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall Func_002_541B
    farcall Func_002_5BD7
    ld hl, wC923
    inc [hl]
    ret

Func_012_4FBC:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    call Func_012_65FF
    ld hl, hFF91
    inc [hl]
    ldh a, [hFF91]
    call Func_012_65FF
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $80
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Func_012_4FD7:: ; heuristic: target of a pointer table; C0
    xor a, a
    ldh [hFF98], a
    ld hl, hFF8C
    call Func_012_65EB
    ld a, $65
    call Func_000_1278
    ld hl, wC923
    inc [hl]
    ret

Func_012_4FEA::
    ld a, [wC923]
    rst $00
    dw Func_012_5097
    dw Func_012_5090
    dw Func_012_5038
    dw Func_012_501E
    dw Func_012_5007
    dw Func_012_501E
    dw Func_012_501E
    dw Func_012_4FFE

Func_012_4FFE:: ; heuristic: target of a pointer table; C0
    xor a, a
    ldh [hFFB9], a
    ld a, $80
    ld [wC919], a
    ret

Func_012_5007:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    or a, a
    jr nz, Func_012_501E
    ldh a, [hFF93]
    or a, $80
    ldh [hFF93], a
    farcall Func_004_4B2D
    ld a, $7F
    ld [wC527], a

Func_012_501E:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $03
    ret nz
    ldh a, [hFF98]
    inc a
    and a, $03
    ldh [hFF98], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5038:: ; heuristic: target of a pointer table; C0
    xor a, a
    ldh [hFF98], a
    ld a, [wCB7D]
    ld c, a

Jump_012_503F::
    call Func_000_09F3
    ld a, [wCD04]
    and a, $07
    cp a, c
    jr nc, Jump_012_503F
    swap a
    ld hl, wCB8A
    add a, l
    ld l, a
    jr nc, Jump_012_5054
    inc h

Jump_012_5054::
    ld a, [hl+]
    cp a, $A0
    jr nc, Jump_012_503F
    ld a, [hl]
    cp a, $90
    jr nc, Jump_012_503F
    ld a, l
    sub a, $0B
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl+]
    ldh [hFF93], a
    ld a, [hl+]
    ldh [hFF94], a
    ld a, [hl]
    ldh [hFF95], a
    ldh a, [hFF93]
    cp a, $01
    jr nz, Jump_012_5080
    ldh a, [hFF94]
    cp a, $5E
    jr nz, Jump_012_5080
    ldh a, [hFF95]
    or a, a
    jr z, Jump_012_503F

Jump_012_5080::
    ld a, $64
    ldh [hFF96], a
    xor a, a
    ldh [hFF97], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5090:: ; heuristic: target of a pointer table; C0
    farcall Func_012_653F
    ret

Func_012_5097:: ; heuristic: target of a pointer table; C0
    ld a, $7A
    call Func_000_1278
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_50AE
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call Func_000_0952

Jump_012_50AE::
    ld hl, wC923
    inc [hl]
    ret

Func_012_50B3::
    ld a, [wC923]
    rst $00
    dw Jump_012_50DB
    dw Jump_012_50D1
    dw Jump_012_50BD

Jump_012_50BD::
    xor a, a
    ldh [hFF93], a
    farcall Func_004_4B2D
    ld a, $7F
    ld [wC527], a
    ld a, $80
    ld [wC919], a
    ret

Jump_012_50D1::
    xor a, a
    call Func_012_683C
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_012_50DB::
    ld a, $12
    call Func_012_6820
    ld hl, wC923
    inc [hl]
    ret

Func_012_50E5::
    ld a, [wC923]
    rst $00
    dw Func_012_557C
    dw Jump_012_50ED

Jump_012_50ED::
    ld a, $80
    ld [wC919], a
    ld a, [wCC44]
    bit 7, a
    jp nz, Jump_012_5181
    ldh a, [hFF90]
    ld c, a
    ld hl, Data_012_5130

Jump_012_5100::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_012_5108
    ld c, $00
    ret

Jump_012_5108::
    cp a, c
    jr z, Jump_012_5112
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_012_5100

Jump_012_5112::
    ld e, l
    ld d, h
    inc de
    ld a, [de]
    inc de
    ldh [hFF90], a
    ld a, [de]
    inc de
    ld b, a
    ld a, [wC88E]
    or a, a
    jr z, Jump_012_512C
    ld a, [wC891]
    dec a
    cp a, b
    jr nz, Jump_012_512C
    ld de, wC88F

Jump_012_512C::
    call Func_012_51B1
    ret

Data_012_5130:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $049130, $51

Jump_012_5181::
    ld a, [wC88E]
    or a, a
    jr z, Jump_012_519E
    ld a, [wC891]
    bit 7, a
    jr z, Jump_012_519E
    and a, $7F
    ld c, a
    ld a, [wCC42]
    cp a, c
    jr nz, Jump_012_519E
    ld de, wC88F
    call Func_012_51B1
    ret

Jump_012_519E::
    ld a, [wCD09]
    ld [wC8C8], a
    ld a, [wCD0A]
    ld [wC8C9], a
    ld de, wCD08
    call Func_012_51C0
    ret

Func_012_51B1::
    ld a, [de]
    and a, $F0
    ld [wC8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wC8C9], a
    inc de

Func_012_51C0::
    ld a, [de]
    swap a
    and a, $0F
    ldh [hFF8F], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [hFF92], a
    ld a, $80
    ld [wC8C5], a
    ld a, $01
    ld [wC8C6], a
    ld a, $04
    call Func_000_0DF2
    ld hl, wC5E0
    inc [hl]
    ld a, $04
    ld [wC5DC], a
    ldh a, [hFF8C]
    and a, $F7
    ldh [hFF8C], a
    ldh a, [hFF8C]
    or a, $20
    and a, $7F
    ldh [hFF8C], a
    ret

Func_012_51F4::
    ld a, [wC923]
    rst $00
    dw Func_012_557C
    dw Jump_012_51FC

Jump_012_51FC::
    ld a, $80
    ld [wC919], a
    ldh a, [hFF8C]
    or a, $80
    and a, $DF
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $80
    ld [wC8C5], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_5258
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD88
    add a, l
    ld l, a
    jr nc, Jump_012_522D
    inc h

Jump_012_522D::
    ld a, [hl]
    push af
    swap a
    and a, $0F
    ldh [hFF8F], a
    pop af
    and a, $0F
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    db $EA, $C9

Func_012_5241:: ; heuristic: target of a pointer table; C0
    ret z
    xor a, a
    ld [wC8CA], a
    ld a, [wCD0D]
    ld [wC190], a
    ld a, [wCD0E]
    ld [wC191], a
    ld a, $80
    ld [wCC44], a
    ret

Jump_012_5258::
    ldh a, [hFF90]
    ld c, a
    ld hl, Data_012_52AD

Jump_012_525E::
    ld a, [hl]
    cp a, c
    jr z, Jump_012_526B
    ld a, $07
    add a, l
    ld l, a
    jr nc, Jump_012_5269
    inc h

Jump_012_5269::
    jr Jump_012_525E

Jump_012_526B::
    ld a, [wC88B]
    dec a
    dec a
    jr nz, Jump_012_5275
    inc hl
    inc hl
    inc hl

Jump_012_5275::
    inc hl
    ld a, [hl+]
    ldh [hFF90], a
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hFF8F], a
    ld a, [hl+]
    and a, $0F
    ldh [hFF92], a
    ld a, [hl]
    and a, $F0
    ld [wC8C8], a
    ld a, [hl]
    and a, $0F
    swap a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ldh a, [hFF90]
    cp a, $52
    jr z, Jump_012_52A6
    cp a, $89
    jr z, Jump_012_52A6
    cp a, $BB
    jr z, Jump_012_52A6
    ret

Jump_012_52A6::
    ldh a, [hFF8C]
    and a, $7F
    ldh [hFF8C], a
    ret

Data_012_52AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0492AD, $5E
    dw Func_012_5241
    dw Func_012_4100
    dw Func_012_485D
    dw Func_012_445A
    INCBIN "dwm2-cobi-us.gbc", $049313, $1FB

Func_012_550E::
    ld a, [wC923]
    rst $00
    dw Jump_012_5520
    dw Func_012_5548
    dw Func_012_5668
    dw Func_012_653F
    dw Jump_012_5689
    dw Jump_012_56E8
    dw Jump_012_571D

Jump_012_5520::
    ld hl, wC923
    inc [hl]
    ld a, $03
    ldh [hFF98], a
    ld de, $0025
    call Func_000_181B
    ret nc
    ld a, $02
    ldh [hFF98], a
    ret

Func_012_5534::
    ld a, [wC923]
    rst $00
    dw Func_012_557C
    dw Func_012_5573
    dw Func_012_5548
    dw Func_012_5668
    db $3F, $65, $89, $56, $E8, $56, $1D, $57

Func_012_5548:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    ld de, $002B
    call Func_000_181B
    jr c, Jump_012_555B
    ld a, $0D
    call Func_012_6820
    jr Jump_012_5560

Jump_012_555B::
    ld a, $15
    call Func_012_6820

Jump_012_5560::
    ld de, $0025
    call Func_000_181B
    jr c, Jump_012_556E
    ld a, $01
    ld [wCB86], a
    ret

Jump_012_556E::
    xor a, a
    ld [wCB96], a
    ret

Func_012_5573:: ; heuristic: target of a pointer table; C0
    call Func_012_55F8
    ld a, $80
    ld [wC8C5], a
    ret

Func_012_557C:: ; heuristic: target of a pointer table; C0
    ldh a, [hFF91]
    cp a, $E0
    jr z, Jump_012_558F
    sub a, $04
    ldh [hFF91], a
    ld a, [wC921]
    srl a
    and a, $03
    ldh [hFF98], a

Jump_012_558F::
    ld a, [wC921]
    cp a, $08
    jr c, Jump_012_55A7
    ld a, [wC8F1]
    cp a, $E0
    jr z, Jump_012_55A7
    sub a, $04
    ld [wC8F1], a
    ldh a, [hFF98]
    ld [wC8EF], a

Jump_012_55A7::
    ld a, [wC921]
    cp a, $10
    jr c, Jump_012_55BF
    ld a, [wC8F6]
    cp a, $E0
    jr z, Jump_012_55BF
    sub a, $04
    ld [wC8F6], a
    ldh a, [hFF98]
    ld [wC8F4], a

Jump_012_55BF::
    ld a, [wC921]
    cp a, $18
    jr c, Jump_012_55D7
    ld a, [wC8FB]
    cp a, $E0
    jr z, Jump_012_55D7
    sub a, $04
    ld [wC8FB], a
    ldh a, [hFF98]
    ld [wC8F9], a

Jump_012_55D7::
    ld b, $5A
    call Func_012_65A4
    ret nc
    ldh a, [hFF8C]
    and a, $B7
    ldh [hFF8C], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_55E8::
    ld a, [wC923]
    rst $00
    dw Jump_012_5633
    dw Func_012_5668
    dw Func_012_653F
    dw Jump_012_5689
    dw Jump_012_56E8
    dw Jump_012_571D

Func_012_55F8::
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_5605
    farcall Func_060_6C96

Jump_012_5605::
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld de, $0025
    call Func_000_181B
    jr c, Jump_012_5622
    ld a, $04
    ld [wC8C6], a
    jr Jump_012_5627

Jump_012_5622::
    ld a, $03
    ld [wC8C6], a

Jump_012_5627::
    ld a, $01
    ld [wC957], a
    farcall Func_05F_6C5A
    ret

Jump_012_5633::
    ld hl, wC923
    inc [hl]
    farcall Func_012_7F05
    ld de, $0025
    call Func_000_181B
    jr c, Jump_012_5650
    ld a, $0C
    call Func_012_6820
    ld a, $01
    ld [wCB86], a
    ret

Jump_012_5650::
    xor a, a
    ld [wCB96], a
    ld de, $002B
    call Func_000_181B
    jr c, Jump_012_5662
    ld a, $13
    call Func_012_6820
    ret

Jump_012_5662::
    ld a, $14
    call Func_012_6820
    ret

Func_012_5668:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_683C
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_567F
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call Func_000_0952

Jump_012_567F::
    ld hl, wC923
    inc [hl]
    ld a, $7A
    call Func_000_1278
    ret

Jump_012_5689::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_5695::
    ld a, [hl+]
    ld c, $55
    call Func_000_1F80
    bit 7, a
    jr nz, Jump_012_56A8
    dec b
    jr nz, Jump_012_5695
    xor a, a
    ld [wC921], a
    jr Jump_012_56AD

Jump_012_56A8::
    ld a, $01
    ld [wC921], a

Jump_012_56AD::
    xor a, a
    ld [rRAMG], a
    call Func_012_64F8
    ld a, [wC921]
    or a, a
    jr nz, Jump_012_56DB
    ld de, $002B
    call Func_000_181B
    jr c, Jump_012_56C9
    ld a, $11
    call Func_012_6820
    jr Jump_012_56CE

Jump_012_56C9::
    ld a, $16
    call Func_012_6820

Jump_012_56CE::
    xor a, a
    ld [wC921], a
    ld a, [wC923]
    inc a
    inc a
    ld [wC923], a
    ret

Jump_012_56DB::
    ld a, $0E
    ldh [hFF8D], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_012_56E8::
    farcall Func_002_5E85
    farcall Func_002_5E85
    call Func_000_222B
    ld hl, Func_004_4AA8

Func_012_56FA:: ; heuristic: target of a pointer table; C0
    ld b, $04
    rst $10
    ld a, $7F
    ld [wC527], a
    xor a, a
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ld de, $002B
    call Func_000_181B
    jr c, Jump_012_5717
    ld a, $11
    call Func_012_6820
    ret

Jump_012_5717::
    ld a, $16
    call Func_012_6820
    ret

Jump_012_571D::
    xor a, a
    call Func_012_683C
    ret nc
    ld a, $80
    ld [wC919], a
    ret

Func_012_5728::
    ld a, [wC923]
    rst $00
    dw Func_012_5834
    dw Func_012_57C7
    dw Func_012_57AD
    dw Func_012_5797
    db $B6, $65
    dw Func_012_5766
    dw Func_012_575B
    dw Func_012_574E
    dw Func_012_573E

Func_012_573E:: ; heuristic: target of a pointer table; C0
    ld a, $05
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    ret

Func_012_574E:: ; heuristic: target of a pointer table; C0
    call Func_012_55F8
    xor a, a
    ld [wC8C7], a
    ld a, $80
    ld [wC8C5], a
    ret

Func_012_575B:: ; heuristic: target of a pointer table; C0
    ld b, $B4
    call Func_012_65A4
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Func_012_5766:: ; heuristic: target of a pointer table; C0
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_5772::
    ld a, [hl+]
    ld c, $55
    call Func_000_1F80
    bit 7, a
    jr z, Jump_012_578D
    dec b
    jr nz, Jump_012_5772
    xor a, a
    ld [rRAMG], a
    ld a, $42
    call Func_000_122D
    ld hl, wC923
    inc [hl]
    ret

Jump_012_578D::
    xor a, a
    ld [rRAMG], a
    ld a, $80
    ld [wC919], a
    ret

Func_012_5797:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    dec [hl]
    ld de, wC00B
    ld a, [wC921]
    dec a
    ld [wC921], a
    or a, a
    jr nz, Jump_012_57DB
    ld de, vTiles0 + $B
    jr Jump_012_57DB

Func_012_57AD:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_683C
    ret nc
    ld a, [wC921]
    or a, a
    jr nz, Jump_012_57C2
    xor a, a
    ld [wC921], a
    ld a, $04
    ld [wC923], a
    ret

Jump_012_57C2::
    ld hl, wC923
    inc [hl]
    ret

Func_012_57C7:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    ld de, $400A
    ld a, [wC921]
    dec a
    ld [wC921], a
    or a, a
    jr nz, Jump_012_57DB
    ld de, $000A

Jump_012_57DB::
    ld a, e
    ld [wC924], a
    ld a, d
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ld a, [wC922]
    sra a
    jr nc, Jump_012_57FB
    ld a, [wC922]
    and a, $FE
    ld [wC922], a
    ld a, [wC6FE]
    jr Jump_012_5817

Jump_012_57FB::
    sra a
    jr nc, Jump_012_580C
    ld a, [wC922]
    and a, $FC
    ld [wC922], a
    ld a, [wC6FF]
    jr Jump_012_5817

Jump_012_580C::
    ld a, [wC922]
    and a, $F7
    ld [wC922], a
    ld a, [wC700]

Jump_012_5817::
    ld c, $01
    push af
    ld a, $0A
    ld [rRAMG], a
    pop af
    call Func_000_1FA4
    xor a, a
    ld [rRAMG], a
    ld hl, wC8CF
    ld de, wC147
    ld bc, $000B
    call Func_000_0952
    ret

Func_012_5834:: ; heuristic: target of a pointer table; C0
    ld a, [wC6FD]
    ld b, a
    ld c, $00
    ld a, [wC915]

Jump_012_583D::
    sra a
    jr nc, Jump_012_5842
    inc c

Jump_012_5842::
    dec b
    jr nz, Jump_012_583D
    ld a, c
    ld [wC921], a
    ld a, [wC915]
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5854::
    ld a, [wC923]
    rst $00
    dw Func_012_5994
    dw Func_012_590D
    dw Func_012_58F6
    dw Func_012_58EF
    dw Func_012_58E4
    dw Func_012_58D6
    dw Func_012_589B
    dw Func_012_5868

Func_012_5868:: ; heuristic: target of a pointer table; C0
    ld a, [wCD07]
    or a, $80
    ld [wCD07], a
    ld hl, wCE7E
    ld b, $04

Jump_012_5875::
    ld [hl], $01
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_012_587E
    inc h

Jump_012_587E::
    dec b
    jr nz, Jump_012_5875
    ld a, [wC833]
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
    set 6, a
    ld [hl], a
    ld a, $80
    ld [wC919], a
    ret

Func_012_589B:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_012_58A8
    bit 3, a
    jr z, Jump_012_58B8
    jr Jump_012_58BF

Jump_012_58A8::
    cp a, $3C
    jr nc, Jump_012_58B2
    bit 2, a
    jr z, Jump_012_58B8
    jr Jump_012_58BF

Jump_012_58B2::
    bit 1, a
    jr z, Jump_012_58B8
    jr Jump_012_58BF

Jump_012_58B8::
    ld a, $01
    ld [wCB7D], a
    jr Jump_012_58C3

Jump_012_58BF::
    xor a, a
    ld [wCB7D], a

Jump_012_58C3::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_58D6:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_684F
    ret nc
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_58E4:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    ld hl, $0129
    call Func_012_6813
    ret

Func_012_58EF:: ; heuristic: target of a pointer table; C0
    farcall Func_012_653F
    ret

Func_012_58F6:: ; heuristic: target of a pointer table; C0
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_5908
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call Func_000_0952

Jump_012_5908::
    ld hl, wC923
    inc [hl]
    ret

Func_012_590D:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_6828
    ret nc
    ld hl, wC923
    inc [hl]
    ld a, $03
    ld [wC903], a
    ld a, [wCE75]
    ld c, a
    ld a, [wCE76]
    or a, c
    jr nz, Jump_012_5941
    ld a, [wCE72]
    ld l, a
    ld a, [wCE73]
    ld h, a
    ld a, l
    ld [wCFDD], a
    ld a, h
    ld [wCFDE], a
    ld a, [wCE74]
    ld [wCFE3], a
    xor a, a
    ld [wCFDC], a
    jr Jump_012_5988

Jump_012_5941::
    ld a, [wCE75]
    ld l, a
    ld a, [wCE76]
    ld h, a
    ld a, l
    ld [wCFDD], a
    ld a, h
    ld [wCFDE], a
    ld a, [wCE77]
    ld [wCFE3], a
    ld a, [wCE72]
    ld l, a
    ld a, [wCE73]
    ld h, a
    ld a, l
    ld [wCFDF], a
    ld a, h
    ld [wCFE0], a
    ld a, [wCE74]
    ld [wCFE4], a
    ld a, [wCE78]
    ld l, a
    ld a, [wCE79]
    ld h, a
    ld a, l
    ld [wCFE1], a
    ld a, h
    ld [wCFE2], a
    ld a, [wCE7A]
    ld [wCFE5], a
    ld a, $02
    ld [wCFDC], a

Jump_012_5988::
    ld a, $01
    ld [wC905], a
    farcall Func_05F_6C71
    ret

Func_012_5994:: ; heuristic: target of a pointer table; C0
    call Func_000_09F3
    ld a, [wCD04]
    and a, $0F
    ld hl, $00D0
    add a, l
    ld l, a
    jr nc, Jump_012_59A4
    inc h

Jump_012_59A4::
    call Func_012_6813
    ld hl, wC923
    inc [hl]
    ret

Func_012_59AC::
    ld a, [wC923]
    rst $00
    dw Func_012_5A17
    dw Func_012_59DE
    dw Func_012_59D3
    dw Func_012_58D6
    dw Func_012_589B
    dw $59BC

Func_012_59BC:: ; heuristic: target of a pointer table; C0
    dw Func_012_45FA
    db $CC, $E6, $7F, $87, $87, $21, $7E, $CE, $85, $6F, $30, $01, $24, $36, $01, $3E
    db $80, $EA, $19, $C9, $C9

Func_012_59D3:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    ld hl, $012A
    call Func_012_6813
    ret

Func_012_59DE:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_6828
    ret nc
    ld hl, wC923
    inc [hl]
    ld a, $03
    ld [wC903], a
    ld a, [wCC45]
    and a, $7F
    add a, a
    add a, a
    ld hl, wCE7B
    add a, l
    ld l, a
    jr nc, Jump_012_59FB
    inc h

Jump_012_59FB::
    ld a, [hl+]
    ld [wCFDD], a
    ld a, [hl+]
    ld [wCFDE], a
    ld a, [hl]
    ld [wCFE3], a
    xor a, a
    ld [wCFDC], a
    ld a, $01
    ld [wC905], a
    farcall Func_05F_6C71
    ret

Func_012_5A17:: ; heuristic: target of a pointer table; C0
    call Func_000_09F3
    ld a, [wCD04]
    and a, $0F
    ld hl, $00E0
    add a, l
    ld l, a
    jr nc, Jump_012_5A27
    inc h

Jump_012_5A27::
    call Func_012_6813
    ld hl, wC923
    inc [hl]
    ret

Func_012_5A2F::
    ld a, [wC923]
    cp a, $07
    jr z, Jump_012_5A3D
    xor a, a
    ld [wC55E], a
    ld [wC562], a

Jump_012_5A3D::
    ld a, [wC923]
    rst $00
    dw Func_012_5C31
    dw Func_012_5C27
    dw Func_012_5B9A
    dw Func_012_5AF0
    dw Func_012_5AE9
    dw Func_012_5AC4
    dw Func_012_5A89
    dw Func_012_5A7A
    dw $5A53

Func_012_5A53:: ; heuristic: target of a pointer table; C0
    dw Func_012_56FA
    db $C9, $E6, $7F, $28, $0A, $E0, $C6, $AF, $E0, $C7, $CD, $C2, $7E, $18, $0C, $FA
    db $22, $C9, $EA, $28, $C9, $21, $8C, $6C, $06, $5F, $D7, $AF, $EA, $56, $C9, $3E
    db $80, $EA, $19, $C9, $C9

Func_012_5A7A:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_683C
    ret nc
    ld a, $FF
    ld [wC8FE], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5A89:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    ld a, [wC956]
    and a, $7F
    jr z, Jump_012_5AB1
    ld [wC8C0], a
    xor a, a
    ld [wC8C1], a
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC17E
    call Func_000_23CA
    ld a, $05
    call Func_012_6820
    xor a, a
    ld [wC925], a
    ret

Jump_012_5AB1::
    ld a, [wC922]
    ld de, wC152
    call Func_000_2431
    ld a, $06
    call Func_012_6820
    xor a, a
    ld [wC925], a
    ret

Func_012_5AC4:: ; heuristic: target of a pointer table; C0
    ld de, wC900
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5AE9:: ; heuristic: target of a pointer table; C0
    farcall Func_085_5C92
    ret

Func_012_5AF0:: ; heuristic: target of a pointer table; C0
    ld a, [wC925]
    swap a
    and a, $0F
    add a, a
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    ld a, [wC924]
    swap a
    and a, $0F
    sla a
    add a, l
    ld l, a
    jr nc, Jump_012_5B11
    inc h

Jump_012_5B11::
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    push hl
    ld [hl], $40
    inc hl
    ld [hl], $41
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_012_5B26
    inc h

Jump_012_5B26::
    ld [hl], $50
    inc hl
    ld [hl], $51
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_5B8C
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld c, $01
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_5B77
    ldh a, [hFF90]
    cp a, $63
    jr z, Jump_012_5B6D
    cp a, $64
    jr z, Jump_012_5B6D
    cp a, $65
    jr z, Jump_012_5B6D
    cp a, $66
    jr z, Jump_012_5B6D
    cp a, $53
    jr z, Jump_012_5B6D
    cp a, $54
    jr z, Jump_012_5B6D
    cp a, $55
    jr z, Jump_012_5B6D
    cp a, $56
    jr nz, Jump_012_5B71

Jump_012_5B6D::
    ld c, $03
    jr Jump_012_5B77

Jump_012_5B71::
    cp a, $57
    jr nz, Jump_012_5B77
    ld c, $03

Jump_012_5B77::
    ld a, $02
    ldh [rSVBK], a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_012_5B85
    inc h

Jump_012_5B85::
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

Jump_012_5B8C::
    farcall Func_05F_6DDB
    xor a, a
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5B9A::
    ld a, [wC921]
    cp a, $06
    jr nc, Jump_012_5BA7
    xor a, a
    ld [wC922], a
    jr Jump_012_5BCB

Jump_012_5BA7::
    cp a, $0C
    jr nc, Jump_012_5BB2
    ld a, $01
    ld [wC922], a
    jr Jump_012_5BCB

Jump_012_5BB2::
    cp a, $12
    jr nc, Jump_012_5BBB
    ld a, $02
    ld [wC922], a

Jump_012_5BBB::
    cp a, $18
    jr nc, Jump_012_5BC6
    ld a, $03
    ld [wC922], a
    jr Jump_012_5BCB

Jump_012_5BC6::
    ld a, $04
    ld [wC922], a

Jump_012_5BCB::
    call Func_012_5BD9
    ld b, $1E
    call Func_012_65A4
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Func_012_5BD9::
    ld a, [wC195]
    ld a, $10
    swap a
    and a, $0F
    dec a
    add a, $23
    ldh [hFFAD], a
    ld a, [wC922]
    ldh [hFFAE], a
    ld a, $07
    ldh [hFFB0], a
    ld a, $70
    ldh [hFFAF], a
    ldh a, [hFFA1]
    ld l, a
    ldh a, [hFFA2]
    ld h, a
    ld a, [wC924]
    add a, $08
    add a, l
    ld l, a
    jr nc, Jump_012_5C04
    inc h

Jump_012_5C04::
    ld a, l
    ldh [hFFA9], a
    ld a, h
    ldh [hFFAA], a
    ldh a, [hFFA5]
    ld l, a
    ldh a, [hFFA6]
    ld h, a
    ld a, [wC925]
    add a, $10
    add a, l
    ld l, a
    jr nc, Jump_012_5C1A
    inc h

Jump_012_5C1A::
    ld a, l
    ldh [hFFAB], a
    ld a, h
    ldh [hFFAC], a
    farcall Func_07F_700A
    ret

Func_012_5C27::
    ld a, $83
    call Func_000_1278
    ld hl, wC923
    inc [hl]
    ret

Func_012_5C31::
    ld a, [wC195]
    swap a
    and a, $0F
    ld de, Func_012_5994
    ld b, $7E
    jr Jump_012_5C4E

Func_012_5C3F:: ; heuristic: follows a terminator; C0
    dec a
    jr nz, Jump_012_5C49
    ld de, $5A15
    ld b, $7E
    jr Jump_012_5C4E

Jump_012_5C49::
    ld de, $5A9A
    ld b, $7E

Jump_012_5C4E::
    ld hl, vTiles0 + $700
    call Func_000_0CF5
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_5C92
    ld a, [wC195]
    ld a, $10
    swap a
    and a, $0F
    add a, $22
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_012_5C88
    inc h

Jump_012_5C88::
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [wC527], a

Jump_012_5C92::
    ldh a, [hFF8E]
    ld d, a
    ldh a, [hFF91]
    ld e, a
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_5CAF
    dec a
    jr z, Jump_012_5CBB
    dec a
    jr z, Jump_012_5CC7
    ld a, d
    sub a, $10
    ld [wC924], a
    ld a, e
    ld [wC925], a
    jr Jump_012_5CD1

Jump_012_5CAF::
    ld a, d
    ld [wC924], a
    ld a, e
    add a, $10
    ld [wC925], a
    jr Jump_012_5CD1

Jump_012_5CBB::
    ld a, d
    add a, $10
    ld [wC924], a
    ld a, e
    ld [wC925], a
    jr Jump_012_5CD1

Jump_012_5CC7::
    ld a, d
    ld [wC924], a
    ld a, e
    sub a, $10
    ld [wC925], a

Jump_012_5CD1::
    ldh a, [hFF98]
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5CE5:: ; heuristic: follows a terminator; C0
    ld a, [wC922]
    dec a
    jr nz, Jump_012_5CEF
    call Func_012_5DB6
    ret

Jump_012_5CEF::
    dec a
    jr nz, Jump_012_5CF6
    call Func_012_5EE7
    ret

Jump_012_5CF6::
    call Func_012_5CFA
    ret

Func_012_5CFA::
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ld a, [wC923]
    rst $00
    dw Jump_012_5D09
    dw Jump_012_5D25

Jump_012_5D09::
    ldh a, [hFF8C]
    and a, $F7
    ldh [hFF8C], a
    ld a, $0E
    ldh [hFF8D], a
    xor a, a
    ldh [hFF8B], a
    ldh a, [hFF91]
    sub a, $08
    ldh [hFF91], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_012_5D25::
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    and a, $03
    jr nz, Jump_012_5D41
    ld hl, hFF91
    inc [hl]

Jump_012_5D41::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    jr nz, Jump_012_5D91
    ldh a, [hFF8E]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hFF91]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ldh a, [hFF98]
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $80
    ld [wC919], a
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, $0000
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall Func_002_6050
    ret

Jump_012_5D91::
    ld a, [wC921]
    and a, $01
    ret z
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_5DA7
    dec a
    jr z, Jump_012_5DAC
    dec a
    jr z, Jump_012_5DB1
    ld hl, hFF8E
    dec [hl]
    ret

Jump_012_5DA7::
    ld hl, hFF91
    inc [hl]
    ret

Jump_012_5DAC::
    ld hl, hFF8E
    inc [hl]
    ret

Jump_012_5DB1::
    ld hl, hFF91
    dec [hl]
    ret

Func_012_5DB6::
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ld a, [wC923]
    rst $00
    dw Func_012_61EF
    dw Func_012_61EF
    dw Func_012_61EF
    dw Jump_012_5E64
    dw Jump_012_5F06
    dw Jump_012_5F11
    dw Jump_012_60DB
    dw Jump_012_5E3C
    dw Jump_012_5DD3

Jump_012_5DD3::
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    and a, $03
    jr nz, Jump_012_5DEF
    ld hl, hFF91
    dec [hl]

Jump_012_5DEF::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    jr nz, Jump_012_5E14
    ldh a, [hFF91]
    add a, $08
    and a, $F0
    ldh [hFF91], a
    ldh a, [hFF8C]
    or a, $08
    and a, $5F
    ldh [hFF8C], a
    ld a, $02
    ldh [hFF8B], a
    ld a, $80
    ld [wC919], a
    ret

Jump_012_5E14::
    call Func_012_6114
    ld a, [wC921]
    and a, $01
    ret z
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_5E2D
    dec a
    jr z, Jump_012_5E32
    dec a
    jr z, Jump_012_5E37
    ld hl, hFF8E
    dec [hl]
    ret

Jump_012_5E2D::
    ld hl, hFF91
    inc [hl]
    ret

Jump_012_5E32::
    ld hl, hFF8E
    inc [hl]
    ret

Jump_012_5E37::
    ld hl, hFF91
    dec [hl]
    ret

Jump_012_5E3C::
    call Func_012_6114
    ld hl, wC923
    inc [hl]
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_5E4F
    cp a, $80
    jr z, Jump_012_5E5C
    ret

Jump_012_5E4F::
    ldh a, [hFF90]
    ld c, a
    ld hl, Data_012_5E62

Jump_012_5E55::
    ld a, [hl+]
    cp a, $FF
    ret z
    cp a, c
    jr nz, Jump_012_5E55

Jump_012_5E5C::
    ld a, $2B
    call Func_000_122D
    ret

Data_012_5E62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $FF

Jump_012_5E64::
    ld de, $58FF
    ld b, $7E
    ld hl, vTiles0 + $700
    call Func_000_0CF5
    ld de, $0108
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_012_5E86
    inc h

Jump_012_5E86::
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [wC527], a
    ldh a, [hFF8E]
    ld d, a
    ldh a, [hFF91]
    ld e, a
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_5EAD
    dec a
    jr z, Jump_012_5EB9
    dec a
    jr z, Jump_012_5EC5
    ld a, d
    sub a, $10
    ld [wC924], a
    ld a, e
    ld [wC925], a
    jr Jump_012_5ECF

Jump_012_5EAD::
    ld a, d
    ld [wC924], a
    ld a, e
    add a, $10
    ld [wC925], a
    jr Jump_012_5ECF

Jump_012_5EB9::
    ld a, d
    add a, $10
    ld [wC924], a
    ld a, e
    ld [wC925], a
    jr Jump_012_5ECF

Jump_012_5EC5::
    ld a, d
    ld [wC924], a
    ld a, e
    sub a, $10
    ld [wC925], a

Jump_012_5ECF::
    ld a, $0E
    ldh [hFF8D], a
    ldh a, [hFF98]
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_5EE7::
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ld a, [wC923]
    rst $00
    dw Func_012_61EF
    dw Func_012_61EF
    dw Func_012_61EF
    dw Jump_012_616C
    dw Jump_012_5F06
    dw Jump_012_5F11
    dw Jump_012_60DB
    dw Jump_012_6077
    dw Jump_012_5FC9
    dw Jump_012_5F4D

Jump_012_5F06::
    ld b, $1E
    call Func_012_65A4
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_012_5F11::
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    and a, $01
    jr nz, Jump_012_5F30
    ldh a, [hFF98]
    inc a
    and a, $03
    ldh [hFF98], a

Jump_012_5F30::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, [wC8EF]
    ldh [hFF98], a
    ld a, $7A
    call Func_000_1278
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_012_5F4D::
    ld a, $01
    ld [wC951], a
    ldh a, [hFF8C]
    or a, $A0
    ldh [hFF8C], a
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    and a, $03
    jr nz, Jump_012_5F74
    ld hl, hFF91
    inc [hl]

Jump_012_5F74::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    jr nz, Jump_012_5FC8
    ldh a, [hFF8C]
    and a, $5F
    ldh [hFF8C], a
    ldh a, [hFF8E]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hFF91]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ldh a, [hFF98]
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $80
    ld [wC919], a
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, $0000
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    xor a, a
    ld [wC951], a
    ret

Jump_012_5FC8::
    ret

Jump_012_5FC9::
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ldh a, [hFF8E]
    ld b, a
    ldh a, [hFF91]
    ld c, a
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_5FF5
    dec a
    jr z, Jump_012_6006
    dec a
    jr z, Jump_012_6017
    ld a, [wC55E]
    set 5, a
    ld [wC55E], a
    ld a, b
    or a, a
    ret z
    sub a, $10
    ld b, a
    jr Jump_012_6025

Jump_012_5FF5::
    ld a, [wC55E]
    set 7, a
    ld [wC55E], a
    ld a, c
    cp a, $80
    ret z
    add a, $10
    ld c, a
    jr Jump_012_6025

Jump_012_6006::
    ld a, [wC55E]
    set 4, a
    ld [wC55E], a
    ld a, b
    cp a, $90
    ret z
    add a, $10
    ld b, a
    jr Jump_012_6025

Jump_012_6017::
    ld a, [wC55E]
    set 6, a
    ld [wC55E], a
    ld a, c
    or a, a
    ret z
    sub a, $10
    ld c, a

Jump_012_6025::
    ld a, [wCB7D]
    or a, a
    jr z, Jump_012_6037
    ld a, [wCB8A]
    cp a, b
    jr nz, Jump_012_6037
    ld a, [wCB8B]
    cp a, c
    jr z, Jump_012_606A

Jump_012_6037::
    call Func_012_6854
    ld b, $04
    ld hl, wC910
    ld b, $02
    ld a, [wC192]
    ld e, a
    ld a, [wC196]
    ld d, a

Jump_012_6049::
    ld a, [hl+]
    cp a, d
    jr z, Jump_012_6066
    jr c, Jump_012_6066
    cp a, e
    jr z, Jump_012_606A
    jr c, Jump_012_606A
    xor a, a
    ldh [hFF8B], a
    ldh a, [hFF91]
    sub a, $08
    ldh [hFF91], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_012_6066::
    dec b
    jr nz, Jump_012_6049
    ret

Jump_012_606A::
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ldh [hFF98], a
    xor a, a
    ld [wC55E], a
    ret

Jump_012_6077::
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    and a, $03
    jr nz, Jump_012_6093
    ld hl, hFF91
    dec [hl]

Jump_012_6093::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    jr nz, Jump_012_60B3
    ldh a, [hFF91]
    add a, $08
    and a, $F0
    ldh [hFF91], a
    ld a, $02
    ldh [hFF8B], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_012_60B3::
    call Func_012_6114
    ld a, [wC921]
    and a, $01
    ret z
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_60CC
    dec a
    jr z, Jump_012_60D1
    dec a
    jr z, Jump_012_60D6
    ld hl, hFF8E
    dec [hl]
    ret

Jump_012_60CC::
    ld hl, hFF91
    inc [hl]
    ret

Jump_012_60D1::
    ld hl, hFF8E
    inc [hl]
    ret

Jump_012_60D6::
    ld hl, hFF91
    dec [hl]
    ret

Jump_012_60DB::
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_012_60E8
    bit 1, a
    jr z, Jump_012_60F8
    jr Jump_012_60FD

Jump_012_60E8::
    cp a, $3C
    jr nc, Jump_012_60F2
    bit 2, a
    jr z, Jump_012_60F8
    jr Jump_012_60FD

Jump_012_60F2::
    bit 3, a
    jr z, Jump_012_60F8
    jr Jump_012_60FD

Jump_012_60F8::
    call Func_012_6114
    jr Jump_012_60FD

Jump_012_60FD::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld a, $0E
    ldh [hFF8D], a
    ret

Func_012_6114::
    ld a, $21
    ldh [hFFAD], a
    ld a, [wC195]
    and a, $0F
    dec a
    jr z, Jump_012_6124
    ld hl, hFFAD
    inc [hl]

Jump_012_6124::
    ld a, $07
    ldh [hFFB0], a
    ldh a, [hFF98]
    cp a, $01
    jr nz, Jump_012_6132
    ld a, $27
    ldh [hFFB0], a

Jump_012_6132::
    xor a, a
    ldh [hFFAE], a
    ld a, $70
    ldh [hFFAF], a
    ldh a, [hFFA1]
    ld l, a
    ldh a, [hFFA2]
    ld h, a
    ld a, [wC924]
    add a, $08
    add a, l
    ld l, a
    jr nc, Jump_012_6149
    inc h

Jump_012_6149::
    ld a, l
    ldh [hFFA9], a
    ld a, h
    ldh [hFFAA], a
    ldh a, [hFFA5]
    ld l, a
    ldh a, [hFFA6]
    ld h, a
    ld a, [wC925]
    add a, $10
    add a, l
    ld l, a
    jr nc, Jump_012_615F
    inc h

Jump_012_615F::
    ld a, l
    ldh [hFFAB], a
    ld a, h
    ldh [hFFAC], a
    farcall Func_07F_700A
    ret

Jump_012_616C::
    ld de, $594A
    ld b, $7E
    ld hl, vTiles0 + $700
    call Func_000_0CF5
    ld de, $0108
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_012_618E
    inc h

Jump_012_618E::
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [wC527], a
    ldh a, [hFF8E]
    ld d, a
    ldh a, [hFF91]
    ld e, a
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_61B5
    dec a
    jr z, Jump_012_61C1
    dec a
    jr z, Jump_012_61CD
    ld a, d
    sub a, $10
    ld [wC924], a
    ld a, e
    ld [wC925], a
    jr Jump_012_61D7

Jump_012_61B5::
    ld a, d
    ld [wC924], a
    ld a, e
    add a, $10
    ld [wC925], a
    jr Jump_012_61D7

Jump_012_61C1::
    ld a, d
    add a, $10
    ld [wC924], a
    ld a, e
    ld [wC925], a
    jr Jump_012_61D7

Jump_012_61CD::
    ld a, d
    ld [wC924], a
    ld a, e
    sub a, $10
    ld [wC925], a

Jump_012_61D7::
    ld a, $0E
    ldh [hFF8D], a
    ldh a, [hFF98]
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_61EF::
    ld a, [wC921]
    or a, a
    jr nz, Jump_012_6200
    farcall Func_002_5923
    ld hl, wC921
    inc [hl]
    ret

Jump_012_6200::
    farcall Func_002_5946
    ld b, $11
    call Func_012_65A4
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Func_012_6211::
    ld a, [wC923]
    rst $00
    dw Func_012_6295
    dw Func_012_628B
    dw Func_012_6247
    dw Func_012_628B
    dw Func_012_621F

Func_012_621F:: ; heuristic: target of a pointer table; C0
    farcall Func_0F0_7D0A
    ld a, [wCC45]
    swap a
    ld hl, wCDAF
    add a, l
    ld l, a
    jr nc, Jump_012_6232
    inc h

Jump_012_6232::
    ld a, $FF
    ld [hl], a
    farcall Func_061_44DB
    farcall Func_05F_6DDB
    ld a, $80
    ld [wC919], a
    ret

Func_012_6247:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    or a, l
    jr nz, Jump_012_6257
    ld a, $80
    ld [wC919], a
    ret

Jump_012_6257::
    push hl
    ld a, [wCC45]
    swap a
    ld hl, wCDAF
    add a, l
    ld l, a
    jr nc, Jump_012_6265
    inc h

Jump_012_6265::
    ld a, $FF
    ld [hl], a
    pop hl
    ld a, l
    bit 7, a
    jr nz, Jump_012_6279
    ld [wC928], a
    farcall Func_05F_6C8C
    jr Jump_012_6279

Jump_012_6279::
    farcall Func_061_44DB
    farcall Func_05F_6DDB
    ld a, $80
    ld [wC919], a
    ret

Func_012_628B:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_683C
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Func_012_6295:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    or a, l
    jr nz, Jump_012_62A9
    ld a, $00
    call Func_012_6820
    ret

Jump_012_62A9::
    ld a, l
    cp a, $80
    jr z, Jump_012_62DA
    cp a, $81
    jr z, Jump_012_62FC
    ld de, wC152
    call Func_000_2431
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_62C3
    cp a, $00
    jr nz, Jump_012_62C9

Jump_012_62C3::
    ld a, $02
    call Func_012_6820
    ret

Jump_012_62C9::
    ld a, $03
    call Func_012_6820
    ld hl, $0000
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ret

Jump_012_62DA::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_012_62EB
    ld a, $08
    call Func_012_6820
    ret

Jump_012_62EB::
    ld a, $09
    call Func_012_6820
    ld hl, $0000
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ret

Jump_012_62FC::
    ld a, [wCECE]
    cp a, $01
    jr z, Jump_012_62DA
    ld a, $19
    call Func_012_6820
    ld a, $03
    ld [wC923], a
    ret

Func_012_630E::
    ld a, [wC923]
    rst $00
    dw Jump_012_635B
    dw Jump_012_6351
    dw Jump_012_6318

Jump_012_6318::
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    or a, l
    jr nz, Jump_012_6328
    ld a, $80
    ld [wC919], a
    ret

Jump_012_6328::
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    ld h, a
    inc hl
    ld a, [hl]
    ld [wC928], a
    inc hl
    inc hl
    ld [hl], $01
    farcall Func_05F_6C8C
    farcall Func_061_45E8
    farcall Func_05F_6DDB
    ld a, $80
    ld [wC919], a
    ret

Jump_012_6351::
    xor a, a
    call Func_012_683C
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_012_635B::
    ld hl, wC923
    inc [hl]
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr z, Jump_012_6374
    ld a, $00
    call Func_012_6820
    ret

Jump_012_6374::
    dec hl
    dec hl
    ld a, [hl]
    and a, $7F
    ld de, wC152
    call Func_000_2431
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_638A
    cp a, $00
    jr nz, Jump_012_6390

Jump_012_638A::
    ld a, $02
    call Func_012_6820
    ret

Jump_012_6390::
    ld a, $03
    call Func_012_6820
    ld hl, $0000
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ret

Func_012_63A1::
    ld a, [wC923]
    rst $00
    dw Func_012_642B
    dw Func_012_641F
    dw Func_012_63F2
    dw Func_012_63D4
    dw Func_012_63B7

Func_012_63AF:: ; heuristic: follows a terminator; C0
    or a, c
    ld h, e
    ld a, $80
    ld [wC919], a
    ret

Func_012_63B7:: ; heuristic: target of a pointer table; C0
    ld a, $05
    ld [wC903], a
    ld a, $01
    ld [wC905], a
    farcall Func_05F_6C71
    call Func_012_64D5
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $80
    ld [wC919], a
    ret

Func_012_63D4:: ; heuristic: target of a pointer table; C0
    call Func_012_64D5
    inc hl
    ld a, [hl]
    ld [wC928], a
    dec hl
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $FF
    ld [wC8FE], a
    farcall Func_05F_6C8C
    ld a, $80
    ld [wC919], a
    ret

Func_012_63F2:: ; heuristic: target of a pointer table; C0
    call Func_012_64D5
    inc hl
    ld a, [hl]
    push hl
    ld l, a
    ld h, $00
    ld e, a
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    pop hl
    dec hl
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $FF
    ld [wC8FE], a
    ld a, $80
    ld [wC919], a
    ret

Func_012_641F:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_012_683C
    ret nc
    ld a, [wC921]
    ld [wC923], a
    ret

Func_012_642B:: ; heuristic: target of a pointer table; C0
    ld hl, wC923
    inc [hl]
    call Func_012_64D5
    ld a, [hl]
    or a, a
    jr nz, Jump_012_6467
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_6441
    cp a, $00
    jr nz, Jump_012_6454

Jump_012_6441::
    inc hl
    ld a, [hl]
    ld de, wC152
    call Func_000_2431
    ld a, $06
    call Func_012_6820
    ld a, $03
    ld [wC921], a
    ret

Jump_012_6454::
    inc hl
    ld a, [hl]
    ld de, wC152
    call Func_000_2431
    ld a, $07
    call Func_012_6820
    ld a, $05
    ld [wC921], a
    ret

Jump_012_6467::
    dec a
    jr nz, Jump_012_6496
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    ld e, a
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC17E
    call Func_000_23CA
    ld a, $05
    call Func_012_6820
    ld a, $02
    ld [wC921], a
    ret

Jump_012_6496::
    dec a
    jr nz, Jump_012_64CA
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_64A4
    cp a, $00
    jr nz, Jump_012_64B7

Jump_012_64A4::
    inc hl
    ld a, [hl]
    ld de, wC152
    call Func_000_2431
    ld a, $02
    call Func_012_6820
    ld a, $03
    ld [wC921], a
    ret

Jump_012_64B7::
    inc hl
    ld a, [hl]
    ld de, wC152
    call Func_000_2431
    ld a, $03
    call Func_012_6820
    ld a, $05
    ld [wC921], a
    ret

Jump_012_64CA::
    ld a, $04
    call Func_012_6820
    ld a, $04
    ld [wC921], a
    ret

Func_012_64D5::
    ld a, [wCCE9]
    or a, a
    jr nz, Jump_012_64EA
    ld a, [wC900]
    add a, a
    add a, a
    add a, a
    ld hl, wCC48
    add a, l
    ld l, a
    jr nc, Jump_012_64E9
    inc h

Jump_012_64E9::
    ret

Jump_012_64EA::
    ld a, [wC900]
    add a, a
    add a, a
    ld hl, wCCEB
    add a, l
    ld l, a
    jr nc, Jump_012_64F7
    inc h

Jump_012_64F7::
    ret

Func_012_64F8::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_6504::
    push hl
    ld a, [hl]
    push af
    ld c, $5D
    call Func_000_1F89
    pop af
    push af
    ld c, $5B
    call Func_000_1FD1
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl], a
    pop af
    push af
    ld c, $61
    call Func_000_1F89
    pop af
    push af
    ld c, $5F
    call Func_000_1FD1
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl], a
    pop af
    ld c, $55
    call Func_000_1FD1
    xor a, a
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_012_6504
    xor a, a
    ld [rRAMG], a
    ret

Func_012_653F:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    srl a
    srl a
    and a, $01
    jr z, Jump_012_656A
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6591
    ld hl, wC0F0
    ld de, wC49F
    ld bc, $0040
    call Func_000_0952
    jr Jump_012_658C

Jump_012_656A::
    ld hl, wC5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6591
    ld b, $40
    ld hl, wC0F0
    ld de, wC49F

Jump_012_6584::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_012_6584

Jump_012_658C::
    ld a, $7F
    ld [wC526], a

Jump_012_6591::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $1E
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_65A4:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, b
    jr z, Jump_012_65B0
    sub a, a
    ret

Jump_012_65B0::
    xor a, a
    ld [wC921], a
    scf
    ret

Func_012_65B6:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    or a, a
    jr nz, Jump_012_65C5
    inc a
    ld [wC921], a
    ld a, $0E
    ldh [hFF8D], a
    ret

Jump_012_65C5::
    farcall Func_002_5E85
    farcall Func_002_5E85
    call Func_000_222B
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Func_012_65EB:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

Func_012_65F0:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

Func_012_65F5:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

Func_012_65FA:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

Func_012_65FF:: ; heuristic: follows a terminator; C0
    and a, $0F
    jr nz, Jump_012_6609
    farcall Func_002_5923

Jump_012_6609::
    farcall Func_002_5946
    ret

Func_012_6610:: ; heuristic: follows a terminator; C0
    push af
    ld a, [wC926]
    cp a, $FF
    jr nz, Jump_012_661A
    pop af
    ret

Jump_012_661A::
    rst $00
    dw Jump_012_6623
    dw Jump_012_666D
    dw Jump_012_668A
    dw Jump_012_66C1

Jump_012_6623::
    pop af
    or a, a
    jr nz, Jump_012_662D
    farcall Func_004_4470

Jump_012_662D::
    ld a, [wC925]
    bit 7, a
    jr nz, Jump_012_6668
    ld hl, vTiles1
    ld de, $1202
    call Func_000_2E98
    call Func_000_290E
    ld a, $69
    call Func_000_1278
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ldh a, [hFF90]
    cp a, $14
    jr z, Jump_012_6659
    ld a, $02
    ldh [hFFB9], a

Jump_012_6659::
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_012_6668
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_012_6668::
    ld hl, wC926
    inc [hl]
    ret

Jump_012_666D::
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC924]
    ld [wC529], a
    ld a, $01
    ld [wC528], a
    farcall Func_009_4001
    ld hl, wC926
    inc [hl]
    ret

Jump_012_668A::
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC925]
    bit 6, a
    jr z, Jump_012_669E
    ld a, $FF
    ld [wC926], a
    ret

Jump_012_669E::
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_012_66BC
    ld a, $82
    ld [wC8CB], a

Jump_012_66BC::
    ld hl, wC926
    inc [hl]
    ret

Jump_012_66C1::
    ld a, [wC8CB]
    and a, $03
    jr z, Jump_012_66CA
    pop af
    ret

Jump_012_66CA::
    pop af
    or a, a
    jr nz, Jump_012_66D4
    farcall Func_004_449F

Jump_012_66D4::
    ld a, $FF
    ld [wC926], a
    ret

Func_012_66DA:: ; heuristic: follows a terminator; C0
    push af
    ld a, [wC926]
    cp a, $FF
    jr nz, Jump_012_66E4
    pop af
    ret

Jump_012_66E4::
    rst $00
    dw Jump_012_66ED
    dw Jump_012_6731
    dw Jump_012_6750
    dw Jump_012_66C1

Jump_012_66ED::
    pop af
    or a, a
    jr nz, Jump_012_66F7
    farcall Func_004_4470

Jump_012_66F7::
    ld a, [wC924]
    bit 7, a
    jr nz, Jump_012_672C
    ld hl, vTiles1
    ld de, $1202
    call Func_000_2E98
    call Func_000_290E
    ld a, $69
    call Func_000_1278
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_012_672C
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_012_672C::
    ld hl, wC926
    inc [hl]
    ret

Jump_012_6731::
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC924]
    and a, $3F
    ld [wC529], a
    ld a, $09
    ld [wC528], a
    farcall Func_009_4001
    ld hl, wC926
    inc [hl]
    ret

Jump_012_6750::
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC924]
    bit 6, a
    jr z, Jump_012_6764
    ld a, $FF
    ld [wC926], a
    ret

Jump_012_6764::
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_012_6782
    ld a, $82
    ld [wC8CB], a

Jump_012_6782::
    ld hl, wC926
    inc [hl]
    ret

Func_012_6787:: ; heuristic: follows a terminator; C0
    push af
    ld a, [wC926]
    cp a, $FF
    jr nz, Jump_012_6791
    pop af
    ret

Jump_012_6791::
    rst $00
    dw Jump_012_679A
    dw Jump_012_67D2
    dw Jump_012_67EE
    dw Jump_012_66C1

Jump_012_679A::
    pop af
    or a, a
    jr nz, Jump_012_67A4
    farcall Func_004_4470

Jump_012_67A4::
    ld hl, vTiles1
    ld de, $1202
    call Func_000_2E98
    call Func_000_290E
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_012_67CD
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_012_67CD::
    ld hl, wC926
    inc [hl]
    ret

Jump_012_67D2::
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC924]
    ld [wC529], a
    xor a, a
    ld [wC528], a
    farcall Func_08A_4001
    ld hl, wC926
    inc [hl]
    ret

Jump_012_67EE::
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_012_680E
    ld a, $82
    ld [wC8CB], a

Jump_012_680E::
    ld hl, wC926
    inc [hl]
    ret

Func_012_6813::
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

Func_012_6820::
    ld [wC924], a
    xor a, a
    ld [wC926], a
    ret

Func_012_6828::
    ld [wC928], a
    farcall Func_05F_6936
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_012_683A
    sub a, a
    ret

Jump_012_683A::
    scf
    ret

Func_012_683C::
    call Func_012_6610

Jump_012_683F::
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_012_6848
    sub a, a
    ret

Jump_012_6848::
    scf
    ret

Func_012_684A::
    call Func_012_66DA
    jr Jump_012_683F

Func_012_684F::
    call Func_012_6787
    jr Jump_012_683F

Func_012_6854::
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_012_6865
    inc h

Jump_012_6865::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_012_6873
    inc h

Jump_012_6873::
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wC910], a
    ld a, [hl-]
    ld [wC911], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_012_688A
    inc h

Jump_012_688A::
    ld a, [hl+]
    ld [wC912], a
    ld a, [hl]
    ld [wC913], a
    ret

Func_012_6893::
    call Func_012_722A
    call Func_012_6EB7
    ret

Func_012_689A::
    xor a, a
    ld [wC966], a

Jump_012_689E::
    call Func_012_691F
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_012_68AB
    xor a, a
    ldh [hFFC6], a
    ret

Jump_012_68AB::
    push af
    ld a, $FE
    ldh [hFFC7], a
    call Func_012_6955
    pop af
    or a, a
    jr z, Jump_012_68FF
    ldh [hFFD0], a
    ld b, a
    ld hl, wC70A

Jump_012_68BD::
    push hl
    ld a, [hl-]
    bit 7, a
    jr nz, Jump_012_68F7
    ld a, [hl-]
    ld c, a
    ldh a, [hFFC8]
    cp a, c
    jr nz, Jump_012_68F7
    ld a, [hl]
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_012_68E9
    pop hl

Jump_012_68D2::
    ldh a, [hFFD0]
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
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    jr Jump_012_689E

Jump_012_68E9::
    pop hl
    ld a, [wC966]
    inc a
    ld [wC966], a
    cp a, $14
    jr c, Jump_012_68D2
    jr Jump_012_68FF

Jump_012_68F7::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_012_68BD

Jump_012_68FF::
    ld a, $01
    ldh [hFFC6], a
    ldh a, [hFFD0]
    add a, a
    ld hl, wC787
    add a, l
    ld l, a
    jr nc, Jump_012_690E
    inc h

Jump_012_690E::
    ld a, [wCD03]
    ld [hl+], a
    ld a, [wCD04]
    ld [hl], a
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ret

Func_012_691F::
    ld b, $00
    ld d, $00
    ld hl, wC707

Jump_012_6926::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_012_6948
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_6935
    inc d

Jump_012_6935::
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_012_693D
    inc h

Jump_012_693D::
    inc b
    ld a, b
    cp a, $20
    jr nz, Jump_012_6926
    ld a, $80
    ldh [hFFC6], a
    ret

Jump_012_6948::
    pop hl
    ld a, b
    ldh [hFFC6], a
    ld a, d
    cp a, $14
    ret nz
    ld a, $80
    ldh [hFFC6], a
    ret

Func_012_6955::
    ldh a, [hFFC6]
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
    push hl
    ldh a, [hFFC7]
    ld [hl], a
    cp a, $FE
    jr z, Jump_012_6973
    pop hl
    inc hl
    inc hl
    inc hl
    ld [hl], $80
    ret

Jump_012_6973::
    farcall Func_061_40B4
    ld a, [wCD05]
    ldh [hFFC6], a
    farcall Func_060_6916
    pop hl
    inc hl
    ldh a, [hFFC7]
    ld [hl+], a
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl], a
    ret

Func_012_6990:: ; heuristic: follows a terminator; C0
    ld b, $00
    ld hl, wC707

Jump_012_6995::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_012_69AC
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_012_69A1
    inc h

Jump_012_69A1::
    inc b
    ld a, b
    cp a, $20
    jr nz, Jump_012_6995
    ld a, $80
    ldh [hFFC6], a
    ret

Jump_012_69AC::
    ld a, b
    ldh [hFFC6], a
    ret

Func_012_69B0::
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    and a, $7F
    cp a, $06
    jr c, Jump_012_69C9
    bit 7, a
    ret nz

Jump_012_69C9::
    push hl
    farcall Func_084_4C84
    pop hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_012_6A03
    bit 7, a
    jr z, Jump_012_6A03
    and a, $1F
    push af
    ld a, $02
    ld [rRAMB], a
    pop af
    ld bc, $0195
    call Func_000_16AA
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, $0A
    ld [rRAMG], a
    ld a, $FF
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a

Jump_012_6A03::
    ldh a, [hFFC6]
    cp a, $1F
    jr nz, Jump_012_6A0E
    ld hl, wC783
    jr Jump_012_6A37

Jump_012_6A0E::
    push af
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
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    pop af
    ld c, a
    ld a, $1F
    sub a, c
    ld b, a

Jump_012_6A28::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_012_6A28

Jump_012_6A37::
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ldh a, [hFFC6]
    cp a, $1F
    jr z, Jump_012_6A5D
    ld c, a
    add a, a
    ld hl, wC787
    add a, l
    ld l, a
    jr nc, Jump_012_6A4D
    inc h

Jump_012_6A4D::
    ld a, $1F
    sub a, c
    ld b, a

Jump_012_6A51::
    ld e, l
    ld d, h
    inc de
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    dec b
    jr nz, Jump_012_6A51

Jump_012_6A5D::
    ld a, [wC833]
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    ret nc
    ld hl, wC833
    dec [hl]
    ret

Func_012_6A6A::
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_6ABC
    ldh a, [hFF90]
    cp a, $7F
    jr nz, Jump_012_6A98
    ldh a, [hFF8F]
    or a, a
    jr nz, Jump_012_6A98
    ldh a, [hFF92]
    or a, a
    jr nz, Jump_012_6A98
    ld a, $12
    ldh [hFFC6], a
    call Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $10
    ld [wCBD4], a
    ld a, $40
    ld [wCBCF], a
    ret

Jump_012_6A98::
    ldh a, [hFF90]
    cp a, $92
    ret nz
    ldh a, [hFF8F]
    or a, a
    ret nz
    ldh a, [hFF92]
    or a, a
    ret nz
    ld a, $12
    ldh [hFFC6], a
    call Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    ld a, $40
    ld [wCBCF], a
    ret

Jump_012_6ABC::
    ld a, [wCC44]
    cp a, $82
    ret nz
    ld a, $12
    ldh [hFFC6], a
    call Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $40
    ld [wCBCF], a
    ret

Func_012_6AD9:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_012_6AE3
    ld hl, vTiles0 + $300
    jr Jump_012_6AE6

Jump_012_6AE3::
    ld hl, vTiles0 + $700

Jump_012_6AE6::
    ld de, $5595
    ld b, $7E
    call Func_000_0CF5
    ld a, $30
    ld [wC949], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_012_6B01
    ld a, $18
    jr Jump_012_6B03

Jump_012_6B01::
    ld a, $38

Jump_012_6B03::
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_012_6B0B
    inc h

Jump_012_6B0B::
    ld a, $D8
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_012_6B15
    inc d

Jump_012_6B15::
    ld b, $7E
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [wC527], a
    ret

Func_012_6B22:: ; heuristic: follows a terminator; C0
    ld a, [wC949]
    dec a
    dec a
    ld [wC949], a
    cp a, $C0
    ret c
    ld a, $30
    ld [wC949], a
    ret

Func_012_6B33:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_012_6B42
    ld a, $30
    ldh [hFFAF], a
    ld a, $03
    ldh [hFFB0], a
    jr Jump_012_6B4A

Jump_012_6B42::
    ld a, $70
    ldh [hFFAF], a
    ld a, $07
    ldh [hFFB0], a

Jump_012_6B4A::
    ld a, [wC5F0]
    ld l, a
    ld a, [wC5F1]
    ld h, a
    ld a, $1E
    call Func_000_16D1
    ld hl, Data_012_6B7A
    add a, l
    ld l, a
    jr nc, Jump_012_6B5F
    inc h

Jump_012_6B5F::
    ld a, [hl]
    ldh [hFFAE], a
    ld a, $1B
    ldh [hFFAD], a
    ld a, $40
    add a, $08
    ldh [hFFA9], a
    ld a, [wC949]
    add a, $10
    ldh [hFFAB], a
    farcall Func_07F_700A
    ret

Data_012_6B7A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

Func_012_6B98::
    ldh a, [hFFC6]
    rst $00
    dw Jump_012_6DF0
    dw Jump_012_6DDC
    dw Jump_012_6DC2
    dw Jump_012_6DAE
    dw Jump_012_6D94
    dw Jump_012_6D79
    dw Jump_012_6D53
    dw Jump_012_6D38
    dw Jump_012_6D1E
    dw Jump_012_6D03
    dw Jump_012_6CE9
    dw Jump_012_6CC2
    dw Jump_012_6C9B
    dw Jump_012_6C73
    dw Jump_012_6C73
    dw Jump_012_6C59
    dw Jump_012_6C3F
    dw Jump_012_6C20
    dw Jump_012_6C01
    dw Jump_012_6BED
    dw Jump_012_6BC7
    dw Jump_012_6BC7

Jump_012_6BC7::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $40
    ld a, $80
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

Jump_012_6BED::
    call Func_012_6E61
    push af
    ld hl, wCBD0
    ld [hl], $30
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $03
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6C01::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

Jump_012_6C20::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

Jump_012_6C3F::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $40
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6C59::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $E0
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6C73::
    call Func_012_6E61
    push af
    ld hl, wCBD0
    ld [hl], $30
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $03
    inc hl
    ld a, $50
    ld [hl], a
    inc hl
    ld a, $3C
    ld [hl], a
    ld a, $80
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

Jump_012_6C9B::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld a, $78
    ld [hl], a
    inc hl
    ld a, $50
    ld [hl], a
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

Jump_012_6CC2::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ldh a, [hFF8E]
    ld [hl], a
    inc hl
    ldh a, [hFF91]
    ld [hl], a
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

Jump_012_6CE9::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $E0
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6D03::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $E0
    ld a, $80
    ld [wCBCF], a
    ret

Jump_012_6D1E::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $50
    inc hl
    ld [hl], $30
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6D38::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $E0
    ld a, $80
    ld [wCBCF], a
    ret

Jump_012_6D53::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $70
    ld a, $80
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

Jump_012_6D79::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $00
    ld a, $80
    ld [wCBCF], a
    ret

Jump_012_6D94::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $50
    inc hl
    ld [hl], $30
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6DAE::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6DC2::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $30
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6DDC::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ret

Jump_012_6DF0::
    call Func_012_6E0B
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $60
    inc hl
    ld [hl], $40
    ld a, $80
    ld [wCBCF], a
    ret

Func_012_6E0B::
    ldh a, [hFFC6]
    and a, $7F
    add a, a
    add a, a
    ld hl, Data_012_704C
    add a, l
    ld l, a
    jr nc, Jump_012_6E19
    inc h

Jump_012_6E19::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $7E
    ld hl, vTiles0 + $400
    call Func_000_0CF5
    pop hl
    push hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6E5E
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $20
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_012_6E54
    inc h

Jump_012_6E54::
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [wC527], a

Jump_012_6E5E::
    pop hl
    ld a, [hl]
    ret

Func_012_6E61::
    ldh a, [hFFC6]
    and a, $7F
    add a, a
    add a, a
    ld hl, Data_012_704C
    add a, l
    ld l, a
    jr nc, Jump_012_6E6F
    inc h

Jump_012_6E6F::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $7E
    ld hl, vTiles0 + $300
    call Func_000_0CF5
    pop hl
    push hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6EB4
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $18
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_012_6EAA
    inc h

Jump_012_6EAA::
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [wC527], a

Jump_012_6EB4::
    pop hl
    ld a, [hl]
    ret

Func_012_6EB7::
    ld a, [wC468]
    bit 7, a
    ret nz
    ld de, wCBCF
    ld a, [de]
    bit 6, a
    ret z
    jr Jump_012_6ED3

Func_012_6EC6::
    ld a, [wC468]
    bit 7, a
    ret nz
    ld de, wCBCF
    ld a, [de]
    bit 7, a
    ret z

Jump_012_6ED3::
    inc de
    ld a, [de]
    ldh [hFFAF], a
    inc de
    ld a, [de]
    and a, $7F
    ldh [hFFAD], a
    ld a, [de]
    bit 7, a
    jr z, Jump_012_6EE7
    call Func_012_6F17
    jr Jump_012_6EEA

Jump_012_6EE7::
    xor a, a
    ldh [hFFAE], a

Jump_012_6EEA::
    inc de
    ld a, [de]
    ldh [hFFB0], a
    ld l, e
    ld h, d
    inc hl
    ld a, [hl]
    add a, $08
    ld d, a
    ldh a, [hFFA1]
    add a, d
    ldh [hFFA9], a
    ldh a, [hFFA2]
    adc a, $00
    ldh [hFFAA], a
    inc hl
    ld a, [hl]
    add a, $10
    ld d, a
    ldh a, [hFFA5]
    add a, d
    ldh [hFFAB], a
    ldh a, [hFFA6]
    adc a, $00
    ldh [hFFAC], a
    farcall Func_07F_700A
    ret

Func_012_6F17::
    push af
    ld hl, wCBD5
    inc [hl]
    pop af
    and a, $7F
    cp a, $13
    jr nz, Jump_012_6F2F
    ld hl, Data_012_6FF2
    call Func_012_6F96
    ld a, [wCBD6]
    ldh [hFFAE], a
    ret

Jump_012_6F2F::
    cp a, $1A
    jr nz, Jump_012_6F3F
    ld hl, Data_012_6FF7
    call Func_012_6F96
    ld a, [wCBD6]
    ldh [hFFAE], a
    ret

Jump_012_6F3F::
    cp a, $17
    jr nz, Jump_012_6F4F
    ld hl, Data_012_6FFA
    call Func_012_6F96
    ld a, [wCBD6]
    ldh [hFFAE], a
    ret

Jump_012_6F4F::
    cp a, $1F
    jr nz, Jump_012_6F68
    ld hl, Data_012_6FFE
    call Func_012_6F96
    ld a, [wCBD6]
    ld hl, Data_012_700E
    add a, l
    ld l, a
    jr nc, Jump_012_6F64
    inc h

Jump_012_6F64::
    ld a, [hl]
    ldh [hFFAE], a
    ret

Jump_012_6F68::
    cp a, $1E
    jr nz, Jump_012_6F78
    ld hl, Data_012_701E
    call Func_012_6F96
    ld a, [wCBD6]
    ldh [hFFAE], a
    ret

Jump_012_6F78::
    cp a, $18
    jr nz, Jump_012_6F88
    ld hl, Data_012_7023
    call Func_012_6F96
    ld a, [wCBD6]
    ldh [hFFAE], a
    ret

Jump_012_6F88::
    cp a, $20
    jr nz, Jump_012_6F95
    ld hl, Data_012_7026
    call Func_012_6FBE
    ldh [hFFAE], a
    ret

Jump_012_6F95::
    ret

Func_012_6F96::
    ld a, [wCBD6]
    add a, l
    ld l, a
    jr nc, Jump_012_6F9E
    inc h

Jump_012_6F9E::
    ld a, [hl]
    ld c, a
    ld a, [wCBD5]
    cp a, c
    jr nz, Jump_012_6FBD
    xor a, a
    ld [wCBD5], a
    inc hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_012_6FB6
    xor a, a
    ld [wCBD6], a
    jr Jump_012_6FBD

Jump_012_6FB6::
    ld a, [wCBD6]
    inc a
    ld [wCBD6], a

Jump_012_6FBD::
    ret

Func_012_6FBE::
    push hl
    ld a, [wCBD6]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_012_6FC8
    inc h

Jump_012_6FC8::
    inc hl
    ld a, [hl]
    ld c, a
    ld a, [wCBD5]
    cp a, c
    jr nz, Jump_012_6FD9
    xor a, a
    ld [wCBD5], a
    ld hl, wCBD6
    inc [hl]

Jump_012_6FD9::
    ld a, [wCBD6]
    add a, a
    pop hl
    add a, l
    ld l, a
    jr nc, Jump_012_6FE3
    inc h

Jump_012_6FE3::
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, [wCBD6]
    dec a
    ld [wCBD6], a
    dec hl
    dec hl
    ld a, [hl]
    ret

Data_012_6FF2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $08, $08, $08, $FF

Data_012_6FF7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $08, $FF

Data_012_6FFA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $07, $07, $09, $FF

Data_012_6FFE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $0E, $0E, $0E, $0E, $0E, $0E, $36, $0E, $0E, $0E, $40, $FF, $FF, $FF, $FF

Data_012_700E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $01, $02, $01, $02, $00, $03, $04, $05, $06, $FF, $FF, $FF, $FF

Data_012_701E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $07, $07, $04, $FF

Data_012_7023:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $20, $FF

Data_012_7026:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $1E, $00, $05, $01, $04, $02, $05, $01, $04, $00, $05, $01, $04, $02, $05
    db $03, $04, $04, $05, $03, $04, $02, $05, $05, $04, $06, $05, $05, $04, $02, $05
    db $01, $04, $00, $05, $FF, $FF

Data_012_704C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04B04C, $58

Func_012_70A4::
    ld a, $FF
    ld [wC8FE], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_70CF
    ldh a, [hFF90]
    cp a, $20
    jr z, Jump_012_70D5
    cp a, $30
    jr z, Jump_012_70D5
    cp a, $48
    jr z, Jump_012_70D5
    cp a, $70
    jr z, Jump_012_70D5
    cp a, $A8
    jr z, Jump_012_70D5
    cp a, $B0
    jr z, Jump_012_70D5
    cp a, $B8
    jr z, Jump_012_70D5
    ret

Jump_012_70CF::
    ld a, [wCC44]
    and a, $07
    ret nz

Jump_012_70D5::
    ldh a, [hFF8F]
    swap a
    ld c, a
    ldh a, [hFF92]
    or a, c
    ld c, a
    ld a, [wCC47]
    or a, a
    ret z
    ld b, a
    ld hl, wCC48

Jump_012_70E7::
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_70F5
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr z, Jump_012_7101

Jump_012_70F5::
    pop hl
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_012_70FD
    inc h

Jump_012_70FD::
    dec b
    jr nz, Jump_012_70E7
    ret

Jump_012_7101::
    ld a, [wCC47]
    sub a, b
    ld [wC900], a
    jr Jump_012_715E

Func_012_710A::
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_711C
    ldh a, [hFF90]
    cp a, $30
    jr nc, Jump_012_712A
    xor a, a
    ld [wCCE9], a
    ret

Jump_012_711C::
    cp a, $85
    ret nz
    ld a, [wCCE9]
    or a, a
    ret z
    ld b, a
    ld hl, wCCEB
    jr Jump_012_7134

Jump_012_712A::
    ld a, [wCCE9]
    or a, a
    ret z
    ld b, $03
    ld hl, wCCEB

Jump_012_7134::
    ldh a, [hFF8F]
    swap a
    ld c, a
    ldh a, [hFF92]
    or a, c
    ld c, a

Jump_012_713D::
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_7149
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr z, Jump_012_7155

Jump_012_7149::
    pop hl
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_012_7151
    inc h

Jump_012_7151::
    dec b
    jr nz, Jump_012_713D
    ret

Jump_012_7155::
    ld a, [wCCE9]
    sub a, b
    ld [wC900], a
    jr Jump_012_715E

Jump_012_715E::
    inc hl
    ld a, [hl]
    ld [wC8FF], a
    pop hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_012_7174
    inc hl
    ld a, [hl]
    ld hl, Data_012_71BB
    add a, l
    ld l, a
    jr nc, Jump_012_7173
    inc h

Jump_012_7173::
    ld a, [hl]

Jump_012_7174::
    or a, a
    ret z
    ld [wC8FE], a

Func_012_7179::
    ld a, [wC8FE]
    ld c, a
    add a, a
    add a, c
    add a, a
    ld hl, Data_012_71E8
    add a, l
    ld l, a
    jr nc, Jump_012_7188
    inc h

Jump_012_7188::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles0 + $400
    call Func_000_0CF5
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [hl]
    ld de, $4BBD
    add a, e
    ld e, a
    jr nc, Jump_012_71A4
    inc d

Jump_012_71A4::
    ld b, $7E
    ld a, $20
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_012_71B0
    inc h

Jump_012_71B0::
    ld c, $08
    call Func_000_0B18
    ld a, $7F
    ld [wC527], a
    ret

Data_012_71BB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0A, $06, $00, $01

Data_012_71E8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04B1E8, $42

Func_012_722A::
    ld a, [wC468]
    bit 7, a
    ret nz
    ld a, [wC8FE]
    cp a, $FF
    ret z
    ld hl, Data_012_7308
    add a, l
    ld l, a
    jr nc, Jump_012_723E
    inc h

Jump_012_723E::
    ld a, [hl+]
    ldh [hFFAD], a
    xor a, a
    ldh [hFFAE], a
    ld a, $40
    ldh [hFFAF], a
    ld a, $04
    ldh [hFFB0], a
    ld a, [wC956]
    bit 7, a
    jp nz, Jump_012_72D5
    ld a, [wCCE9]
    or a, a
    jr nz, Jump_012_7261
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_729A

Jump_012_7261::
    ldh a, [hFFA1]
    ld e, a
    ldh a, [hFFA2]
    ld d, a
    ld a, [wC8FF]
    and a, $F0
    add a, $08
    add a, e
    ld e, a
    jr nc, Jump_012_7273
    inc d

Jump_012_7273::
    ld a, e
    ldh [hFFA9], a
    ld a, d
    ldh [hFFAA], a
    ldh a, [hFFA5]
    ld e, a
    ldh a, [hFFA6]
    ld d, a
    ld a, [wC8FF]
    and a, $0F
    swap a
    add a, $10
    add a, e
    ld e, a
    jr nc, Jump_012_728D
    inc d

Jump_012_728D::
    ld a, e
    ldh [hFFAB], a
    ld a, d
    ldh [hFFAC], a
    farcall Func_07F_700A
    ret

Jump_012_729A::
    ld a, [wC8FF]
    add a, a
    ld hl, Data_012_7313
    add a, l
    ld l, a
    jr nc, Jump_012_72A6
    inc h

Jump_012_72A6::
    ldh a, [hFFA1]
    ld e, a
    ldh a, [hFFA2]
    ld d, a
    ld a, [hl+]
    add a, $08
    add a, e
    ld e, a
    jr nc, Jump_012_72B4
    inc d

Jump_012_72B4::
    ld a, e
    ldh [hFFA9], a
    ld a, d
    ldh [hFFAA], a
    ldh a, [hFFA5]
    ld e, a
    ldh a, [hFFA6]
    ld d, a
    ld a, [hl+]
    add a, $10
    add a, e
    ld e, a
    jr nc, Jump_012_72C8
    inc d

Jump_012_72C8::
    ld a, e
    ldh [hFFAB], a
    ld a, d
    ldh [hFFAC], a
    farcall Func_07F_700A
    ret

Jump_012_72D5::
    ldh a, [hFFA1]
    ld e, a
    ldh a, [hFFA2]
    ld d, a
    ld a, [wC8FF]
    add a, $08
    add a, e
    ld e, a
    jr nc, Jump_012_72E5
    inc d

Jump_012_72E5::
    ld a, e
    ldh [hFFA9], a
    ld a, d
    ldh [hFFAA], a
    ldh a, [hFFA5]
    ld e, a
    ldh a, [hFFA6]
    ld d, a
    ld a, [wC900]
    add a, $10
    add a, e
    ld e, a
    jr nc, Jump_012_72FB
    inc d

Jump_012_72FB::
    ld a, e
    ldh [hFFAB], a
    ld a, d
    ldh [hFFAC], a
    farcall Func_07F_700A
    ret

Data_012_7308:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $09, $01, $01, $02, $03, $04, $05, $06, $07, $08

Data_012_7313:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $20, $10, $70, $20, $10, $20, $40, $20, $60, $30, $30, $40, $50, $40, $70
    db $50, $10, $50, $30, $60, $50, $70, $20, $70, $40, $70, $70, $80, $10, $80, $60

Func_012_7333::
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wC562]
    bit 0, a
    ret z
    ld a, [wC8FE]
    cp a, $02
    jr z, Jump_012_7356
    cp a, $03
    jr z, Jump_012_7356
    ret

Jump_012_7356::
    ldh a, [hFF8E]
    ld b, a
    ldh a, [hFF91]
    ld c, a
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_736A
    dec a
    jr z, Jump_012_7370
    dec a
    jr z, Jump_012_7376
    dec b
    jr Jump_012_7377

Jump_012_736A::
    ld a, c
    add a, $11
    ld c, a
    jr Jump_012_7377

Jump_012_7370::
    ld a, b
    add a, $11
    ld b, a
    jr Jump_012_7377

Jump_012_7376::
    dec c

Jump_012_7377::
    call Func_012_7536
    or a, a
    jr z, Jump_012_73A0
    ld a, $0F
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ld a, [wC8CD]
    bit 7, a
    ret z
    farcall Func_002_5B9E
    ret

Jump_012_73A0::
    ret

Func_012_73A1::
    ld a, [wC951]
    dec a
    ret z
    ld a, [wC8BF]
    cp a, $C0
    ret z
    ld a, [wC8FE]
    cp a, $FF
    ret z
    cp a, $02
    ret z
    cp a, $03
    ret z
    ldh a, [hFF8E]
    ld b, a
    ldh a, [hFF91]
    ld c, a
    call Func_012_7536
    or a, a
    jr z, Jump_012_73F2
    ld a, [wC91F]
    or a, a
    jr z, Jump_012_73DC
    ld a, [wC917]
    or a, a
    jr nz, Jump_012_73DC
    ld a, [wC916]
    cp a, $1D
    jr nz, Jump_012_73DC
    ld a, $01
    ld [wD091], a

Jump_012_73DC::
    ld a, $0F
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    xor a, a
    ld [wC55E], a
    ld [wC562], a

Jump_012_73F2::
    ret

Func_012_73F3::
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wC562]
    bit 0, a
    ret z
    ld a, [wCC44]
    bit 7, a
    ret z
    cp a, $85
    jr z, Jump_012_7417
    cp a, $86
    ret nz

Jump_012_7417::
    ldh a, [hFF8E]
    ld b, a
    ldh a, [hFF91]
    ld c, a
    ldh a, [hFF98]
    or a, a
    jr z, Jump_012_742E
    dec a
    jr z, Jump_012_7434
    dec a
    jr z, Jump_012_743A
    ld a, b
    sub a, $10
    ld b, a
    jr Jump_012_7440

Jump_012_742E::
    ld a, c
    add a, $10
    ld c, a
    jr Jump_012_7440

Jump_012_7434::
    ld a, b
    add a, $10
    ld b, a
    jr Jump_012_7440

Jump_012_743A::
    ld a, c
    sub a, $10
    ld c, a
    jr Jump_012_7440

Jump_012_7440::
    call Func_012_75A1
    ld a, [wCC44]
    cp a, $86
    jp z, Jump_012_74FB
    ld a, [wC910]
    cp a, $2C
    jr z, Jump_012_7479
    cp a, $2E
    jr z, Jump_012_7457
    ret

Jump_012_7457::
    ld hl, $0000
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, $0E
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ret

Jump_012_7479::
    ldh a, [hFF8F]
    swap a
    ld b, a
    ldh a, [hFF92]
    or a, b
    ld b, a
    ld a, [wCC45]
    swap a
    ld hl, wCDB0
    add a, l
    ld l, a
    jr nc, Jump_012_748F
    inc h

Jump_012_748F::
    ld a, [wCC43]
    ld c, a
    ld a, [hl]
    cp a, c
    jr nz, Jump_012_74C7
    inc hl
    inc hl
    ld a, [hl]
    ld de, Data_012_752E
    add a, e
    ld e, a
    jr nc, Jump_012_74A2
    inc d

Jump_012_74A2::
    ld a, [de]
    cp a, b
    jr nz, Jump_012_74C9
    dec hl
    dec hl
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, $0E
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ret

Jump_012_74C7::
    inc hl
    inc hl

Jump_012_74C9::
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld de, Data_012_752E
    add a, e
    ld e, a
    jr nc, Jump_012_74D6
    inc d

Jump_012_74D6::
    ld a, [de]
    cp a, b
    jr nz, Jump_012_74FA
    dec hl
    dec hl
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, $0E
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    xor a, a
    ld [wC55E], a
    ld [wC562], a

Jump_012_74FA::
    ret

Jump_012_74FB::
    ld a, [wC910]
    cp a, $1A
    jr z, Jump_012_7508
    cp a, $1C
    jp z, Jump_012_7457
    ret

Jump_012_7508::
    ld a, [wCC45]
    ld hl, wCE8B
    add a, l
    ld l, a
    jr nc, Jump_012_7513
    inc h

Jump_012_7513::
    ld a, [hl]
    ld [wC921], a
    ld a, $0D
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ret

Data_012_752E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $10, $12, $13, $20, $21, $23, $32

Func_012_7536::
    push bc
    jr Jump_012_753C

Jump_012_7539::
    xor a, a
    pop bc
    ret

Jump_012_753C::
    ld a, b
    swap a
    and a, $0F
    ld b, a
    ld a, c
    swap a
    and a, $0F
    ld c, a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_7565

Jump_012_754F::
    ld a, [wC8FF]
    swap a
    and a, $0F
    cp a, b
    jr nz, Jump_012_7539
    ld a, [wC8FF]
    and a, $0F
    cp a, c
    jr nz, Jump_012_7539
    ld a, $01
    pop bc
    ret

Jump_012_7565::
    cp a, $85
    jr z, Jump_012_754F
    ld a, [wC8FF]
    add a, a
    ld hl, Data_012_7581
    add a, l
    ld l, a
    jr nc, Jump_012_7575
    inc h

Jump_012_7575::
    ld a, [hl+]
    cp a, b
    jr nz, Jump_012_7539
    ld a, [hl]
    cp a, c
    jr nz, Jump_012_7539
    ld a, $01
    pop bc
    ret

Data_012_7581:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

Func_012_75A1::
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add a, l
    ld l, a
    jr nc, Jump_012_75B2
    inc h

Jump_012_75B2::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_012_75C0
    inc h

Jump_012_75C0::
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wC910], a
    ld a, [hl-]
    ld [wC911], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_012_75D7
    inc h

Jump_012_75D7::
    ld a, [hl+]
    ld [wC912], a
    ld a, [hl]
    ld [wC913], a
    ret

Func_012_75E0::
    ld a, [wC91F]
    or a, a
    ret nz
    ld a, [wC935]
    bit 7, a
    ret nz
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_7615
    ldh a, [hFF90]
    cp a, $20
    jr z, Jump_012_7618
    cp a, $30
    jr z, Jump_012_7618
    cp a, $48
    jr z, Jump_012_7618
    cp a, $70
    jr z, Jump_012_7618
    cp a, $A8
    jr z, Jump_012_7618
    cp a, $B0
    jr z, Jump_012_7618
    cp a, $B8
    jr z, Jump_012_7618
    cp a, $C8
    jr z, Jump_012_7618
    ret

Jump_012_7615::
    and a, $7F
    ret nz

Jump_012_7618::
    ld a, [wC832]
    cp a, $63
    jr z, Jump_012_7624
    inc a
    ld [wC832], a
    ret

Jump_012_7624::
    xor a, a
    ld [wC832], a
    call Func_012_7662
    ret c
    call Func_012_7693
    ret c
    call Func_012_76F1
    ret c
    call Func_012_774F
    ret c
    call Func_012_7B45
    ret c
    call Func_012_7AD0
    ret c
    call Func_012_7A4D
    ret c
    call Func_012_79DC
    ret c
    call Func_012_797C
    ret c
    call Func_012_781E
    ret c
    call Func_012_7934
    ret c
    call Func_012_789E
    ret c
    call Func_012_77AC
    ret c
    call Func_012_79A7
    ret c
    sub a, a
    ret

Func_012_7662::
    ld de, $0192
    call Func_000_181B
    jr nc, Jump_012_7691
    ld de, $0193
    call Func_000_181B
    jr c, Jump_012_7691
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_768A
    ld a, [wC618]
    cp a, $27
    jr z, Jump_012_7683
    jr nc, Jump_012_768A
    jr Jump_012_7691

Jump_012_7683::
    ld a, [wC617]
    cp a, $10
    jr c, Jump_012_7691

Jump_012_768A::
    ld a, $CC
    ld [wC935], a
    scf
    ret

Jump_012_7691::
    sub a, a
    ret

Func_012_7693::
    ld de, $0195
    call Func_000_181B
    jr nc, Jump_012_76EF
    ld de, $0196
    call Func_000_181B
    jr c, Jump_012_76EF
    ld a, [wC6FD]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_76B8::
    push bc
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1F89
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_76B8
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_012_76EF
    ldh a, [hFFC8]
    cp a, $64
    jr nc, Jump_012_76EF
    ld a, $CD
    ld [wC935], a
    scf
    ret

Jump_012_76EF::
    sub a, a
    ret

Func_012_76F1::
    ld de, $0198
    call Func_000_181B
    jr nc, Jump_012_774D
    ld de, $0199
    call Func_000_181B
    jr c, Jump_012_774D
    ld a, [wC6FD]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_7716::
    push bc
    push hl
    ld a, [hl]
    ld c, $5F
    call Func_000_1F89
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_7716
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_012_774D
    ldh a, [hFFC8]
    cp a, $64
    jr nc, Jump_012_774D
    ld a, $CE
    ld [wC935], a
    scf
    ret

Jump_012_774D::
    sub a, a
    ret

Func_012_774F::
    ld de, $019B
    call Func_000_181B
    jr nc, Jump_012_77AA
    ld de, $019C
    call Func_000_181B
    jr c, Jump_012_77AA
    ld a, [wC6FD]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_7774::
    push bc
    push hl
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_7774
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_012_77AA
    ldh a, [hFFC8]
    cp a, $64
    jr nc, Jump_012_77AA
    ld a, $CF
    ld [wC935], a
    scf
    ret

Jump_012_77AA::
    sub a, a
    ret

Func_012_77AC::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_77C4
    ld a, [wC618]
    cp a, $03
    jr z, Jump_012_77BD
    jr nc, Jump_012_77C4
    jr Jump_012_7818

Jump_012_77BD::
    ld a, [wC617]
    cp a, $E8
    jr c, Jump_012_7818

Jump_012_77C4::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_77D0::
    push bc
    push hl
    ld a, [hl]
    ld c, $58
    call Func_000_1F95
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    ldh a, [hFFC8]
    ld [wC8C2], a
    call Func_000_173A
    ldh a, [hFFC6]
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    swap a
    and a, $0F
    cp a, c
    jr nz, Jump_012_7803
    ldh a, [hFFC7]
    and a, $0F
    cp a, c
    jr z, Jump_012_780B

Jump_012_7803::
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_77D0
    jr Jump_012_7818

Jump_012_780B::
    pop hl
    pop bc
    xor a, a
    ld [rRAMG], a
    ld a, $C9
    ld [wC935], a
    scf
    ret

Jump_012_7818::
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

Func_012_781E::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_7836
    ld a, [wC618]
    cp a, $03
    jr z, Jump_012_782F
    jr nc, Jump_012_7836
    jr Jump_012_7898

Jump_012_782F::
    ld a, [wC617]
    cp a, $E8
    jr c, Jump_012_7898

Jump_012_7836::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_7842::
    push hl
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_012_785E
    bit 2, a
    jr nz, Jump_012_785E
    bit 0, a
    jr nz, Jump_012_785E

Jump_012_7857::
    pop hl
    inc hl
    dec b
    jr nz, Jump_012_7842
    jr Jump_012_7898

Jump_012_785E::
    ld a, [hl]
    ld c, $5D
    call Func_000_1F89
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    srl d
    rr e
    ld a, e
    ldh [hFFC8], a
    ld a, d
    ldh [hFFC9], a
    ld a, [hl]
    ld c, $5D
    call Func_000_1F89
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr c, Jump_012_7857
    jr nz, Jump_012_788C
    ldh a, [hFFC8]
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr c, Jump_012_7857

Jump_012_788C::
    pop hl
    xor a, a
    ld [rRAMG], a
    ld a, $CB
    ld [wC935], a
    scf
    ret

Jump_012_7898::
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

Func_012_789E::
    ld a, [wC627]
    cp a, $FF
    jr z, Jump_012_78A9
    or a, a
    jp nz, Jump_012_7932

Jump_012_78A9::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_78C1
    ld a, [wC618]
    cp a, $03
    jr z, Jump_012_78BA
    jr nc, Jump_012_78C1
    jr Jump_012_7932

Jump_012_78BA::
    ld a, [wC617]
    cp a, $E8
    jr c, Jump_012_7932

Jump_012_78C1::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, $0000

Jump_012_78D0::
    ld a, [hl+]
    ld c, $5D
    call Func_000_1F89
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    dec b
    jr nz, Jump_012_78D0
    xor a, a
    ld [rRAMG], a
    ld l, e
    ld h, d
    ld a, $64
    call Func_000_16D1
    ld c, l
    ld b, h
    ld a, $1E
    call Func_000_16AA
    push hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, $0000

Jump_012_7906::
    ld a, [hl+]
    ld c, $5B
    call Func_000_1F89
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    dec b
    jr nz, Jump_012_7906
    xor a, a
    ld [rRAMG], a
    pop hl
    ld a, d
    cp a, h
    jr c, Jump_012_792B
    jr nz, Jump_012_7932
    ld a, e
    cp a, l
    jr c, Jump_012_792B
    jr nz, Jump_012_7932

Jump_012_792B::
    ld a, $C8
    ld [wC935], a
    scf
    ret

Jump_012_7932::
    sub a, a
    ret

Func_012_7934::
    ld a, [wC627]
    cp a, $FF
    jr z, Jump_012_793E
    or a, a
    jr nz, Jump_012_797A

Jump_012_793E::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_7956
    ld a, [wC618]
    cp a, $03
    jr z, Jump_012_794F
    jr nc, Jump_012_7956
    jr Jump_012_797A

Jump_012_794F::
    ld a, [wC617]
    cp a, $E8
    jr c, Jump_012_797A

Jump_012_7956::
    ld hl, wC61D

Jump_012_7959::
    ld a, [hl+]
    or a, a
    jr z, Jump_012_7973
    cp a, $FF
    jr z, Jump_012_7973
    cp a, $19
    jr z, Jump_012_797A
    cp a, $1A
    jr z, Jump_012_797A
    cp a, $1B
    jr z, Jump_012_797A
    cp a, $1C
    jr z, Jump_012_797A
    jr Jump_012_7959

Jump_012_7973::
    ld a, $C7
    ld [wC935], a
    scf
    ret

Jump_012_797A::
    sub a, a
    ret

Func_012_797C::
    ld a, [wC627]
    cp a, $FF
    jr z, Jump_012_7986
    or a, a
    jr nz, Jump_012_79A5

Jump_012_7986::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_799E
    ld a, [wC618]
    cp a, $13
    jr z, Jump_012_7997
    jr nc, Jump_012_799E
    jr Jump_012_79A5

Jump_012_7997::
    ld a, [wC617]
    cp a, $88
    jr c, Jump_012_79A5

Jump_012_799E::
    ld a, $C6
    ld [wC935], a
    scf
    ret

Jump_012_79A5::
    sub a, a
    ret

Func_012_79A7::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_79BF
    ld a, [wC618]
    cp a, $03
    jr z, Jump_012_79B8
    jr nc, Jump_012_79BF
    jr Jump_012_79CB

Jump_012_79B8::
    ld a, [wC617]
    cp a, $E8
    jr c, Jump_012_79CB

Jump_012_79BF::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_79C9
    or a, a
    jr nz, Jump_012_79CB

Jump_012_79C9::
    jr Jump_012_79CD

Jump_012_79CB::
    sub a, a
    ret

Jump_012_79CD::
    call Func_000_095B
    ld a, [wC5E8]
    and a, $01
    add a, $C4
    ld [wC935], a
    scf
    ret

Func_012_79DC::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_79F4
    ld a, [wC618]
    cp a, $13
    jr z, Jump_012_79ED
    jr nc, Jump_012_79F4
    jr Jump_012_7A44

Jump_012_79ED::
    ld a, [wC617]
    cp a, $88
    jr c, Jump_012_7A44

Jump_012_79F4::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_79FD
    or a, a
    ret nz

Jump_012_79FD::
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Func_000_173A
    ldh a, [hFFC6]
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC9]
    and a, $0F
    add a, c
    cp a, $1E
    jr nc, Jump_012_7A46

Jump_012_7A44::
    sub a, a
    ret

Jump_012_7A46::
    ld a, $C3
    ld [wC935], a
    scf
    ret

Func_012_7A4D::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_7A66
    ld a, [wC618]
    cp a, $03
    jr z, Jump_012_7A5F
    jr nc, Jump_012_7A66
    jp Jump_012_7ACE

Jump_012_7A5F::
    ld a, [wC617]
    cp a, $E8
    jr c, Jump_012_7ACE

Jump_012_7A66::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    dec a
    jr z, Jump_012_7ABF
    ld a, [wC6FE]
    ld c, $5B
    call Func_000_1F89
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call Func_000_16F5
    ld a, [wC8C2]
    ld b, a
    ld a, [wC6FF]
    ld c, $5B
    call Func_000_1F89
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    push bc
    call Func_000_16F5
    pop bc
    ld a, [wC8C2]
    cp a, b
    jr nz, Jump_012_7ACA
    ld a, [wC6FD]
    dec a
    dec a
    jr z, Jump_012_7ABF
    ld a, [wC700]
    ld c, $5B
    call Func_000_1F89
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    push bc
    call Func_000_16F5
    pop bc
    ld a, [wC8C2]
    cp a, b
    jr nz, Jump_012_7ACA

Jump_012_7ABF::
    xor a, a
    ld [rRAMG], a
    ld a, $C2
    ld [wC935], a
    scf
    ret

Jump_012_7ACA::
    xor a, a
    ld [rRAMG], a

Jump_012_7ACE::
    sub a, a
    ret

Func_012_7AD0::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_7ADA
    or a, a
    jr nz, Jump_012_7B3C

Jump_012_7ADA::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_7AF3
    ld a, [wC618]
    cp a, $03
    jr z, Jump_012_7AEC
    jr nc, Jump_012_7AF3
    jp Jump_012_7B3C

Jump_012_7AEC::
    ld a, [wC617]
    cp a, $E8
    jr c, Jump_012_7B3C

Jump_012_7AF3::
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Func_000_173A
    ldh a, [hFFC6]
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC9]
    and a, $0F
    add a, c
    cp a, $0C
    jr z, Jump_012_7B3E
    jr c, Jump_012_7B3E

Jump_012_7B3C::
    sub a, a
    ret

Jump_012_7B3E::
    ld a, $C1
    ld [wC935], a
    scf
    ret

Func_012_7B45::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_7B51::
    push bc
    push hl
    ld a, [hl]
    ld c, $5B
    call Func_000_1F89
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call Func_000_16F5
    ld a, [wC8C0]
    or a, a
    jr z, Jump_012_7B77
    ld c, a
    ld a, [wC8C1]
    cp a, c
    jr nz, Jump_012_7B86
    ld a, [wC8C2]
    cp a, c
    jr nz, Jump_012_7B86
    jr Jump_012_7B92

Jump_012_7B77::
    ld a, [wC8C1]
    or a, a
    jr z, Jump_012_7B92
    ld c, a
    ld a, [wC8C2]
    cp a, c
    jr nz, Jump_012_7B86
    jr Jump_012_7B92

Jump_012_7B86::
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_7B51
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

Jump_012_7B92::
    pop hl
    pop bc
    xor a, a
    ld [rRAMG], a
    ld a, $C0
    ld [wC935], a
    scf
    ret

Func_012_7B9F::
    ld a, [wC935]
    bit 7, a
    ret z
    bit 6, a
    ret nz
    xor a, a
    ld [wC935], a
    ld [wC832], a
    ret

Func_012_7BB0::
    call Func_012_7D5E
    or a, a
    ret nz
    ld a, [wC8FE]
    cp a, $FF
    ret nz
    ld a, [wC91F]
    or a, a
    ret nz
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_7BFC
    xor a, a
    ld [wC935], a
    ret

Func_012_7BCC:: ; heuristic: follows a terminator; C0
    ld a, [wC935]
    and a, $0F
    cp a, $08
    jr z, Jump_012_7BF7
    ldh a, [hFF90]
    cp a, $20
    jr z, Jump_012_7BFF
    cp a, $30
    jr z, Jump_012_7BFF
    cp a, $48
    jr z, Jump_012_7BFF
    cp a, $70
    jr z, Jump_012_7BFF
    cp a, $A8
    jr z, Jump_012_7BFF
    cp a, $B0
    jr z, Jump_012_7BFF
    cp a, $B8
    jr z, Jump_012_7BFF
    cp a, $C8
    jr z, Jump_012_7BFF

Jump_012_7BF7::
    xor a, a
    ld [wC935], a
    ret

Jump_012_7BFC::
    and a, $7F
    ret nz

Jump_012_7BFF::
    ld a, [wC935]
    bit 7, a
    ret z
    bit 6, a
    jp z, Jump_012_7CA1
    ld a, [wC935]
    and a, $0F
    cp a, $01
    jr z, Jump_012_7C25
    cp a, $03
    jr z, Jump_012_7C25
    cp a, $04
    jr z, Jump_012_7C25
    cp a, $05
    jr z, Jump_012_7C25
    cp a, $07
    jr z, Jump_012_7C25
    jr Jump_012_7C3B

Jump_012_7C25::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_7C3B
    or a, a
    jr z, Jump_012_7C3B
    xor a, a
    ld [wC935], a
    ld a, $63
    ld [wC832], a
    call Func_012_75E0

Jump_012_7C3B::
    call Func_000_095B
    ld a, [wC5E8]
    and a, $03
    add a, a
    ld hl, Data_012_7D56
    add a, l
    ld l, a
    jr nc, Jump_012_7C4C
    inc h

Jump_012_7C4C::
    ld a, [hl+]
    ld [wCB83], a
    ld [wCB8A], a
    ld a, [hl]
    ld [wCB84], a
    ld [wCB8B], a
    ld a, [wCB83]
    ld b, a
    ld a, [wCB84]
    ld c, a
    call Func_012_75A1
    call Func_012_7CD9
    cp a, $01
    ret z
    ld a, $03
    ld [wCB7F], a
    ld a, $01
    ld [wCB80], a
    xor a, a
    ld [wCB82], a
    ld a, $05
    ld [wCB85], a
    ld a, $00
    ld [wCB86], a
    ld a, $50
    ld [wCB87], a
    xor a, a
    ld [wCB88], a
    xor a, a
    ld [wCB89], a
    xor a, a
    ld [wCB8C], a
    ld a, $FF
    ld [wCB8E], a
    ld a, [wC935]
    and a, $BF
    ld [wC935], a

Jump_012_7CA1::
    ld a, $01
    ld [wCB7D], a
    ld a, [wC935]
    and a, $0F
    ld hl, Data_012_7D46
    add a, l
    ld l, a
    jr nc, Jump_012_7CB3
    inc h

Jump_012_7CB3::
    ld a, [hl]
    ld [wCB81], a
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC8], a
    ld a, $05
    ldh [hFFC9], a
    ld hl, vTiles0 + $500
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld a, $7F
    ld [wC527], a
    ret

Func_012_7CD9::
    ld a, [wC195]
    and a, $0F
    dec a
    jr nz, Jump_012_7D2F
    ld b, $04
    ld hl, wC910

Jump_012_7CE6::
    ld a, [hl+]
    ld c, a
    ld a, [wC196]
    cp a, c
    jr c, Jump_012_7D2C
    call Func_000_09F3
    ld a, [wCD04]
    and a, $07
    jr nz, Jump_012_7D2F
    ld a, $2C
    ldh [hFFC6], a
    call Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_012_7D2F
    ld a, [wC634]
    or a, a
    jr z, Jump_012_7D0F
    cp a, $FF
    jr nz, Jump_012_7D2F

Jump_012_7D0F::
    ld a, [wC619]
    ld c, a
    ld a, [wC618]
    or a, c
    jr nz, Jump_012_7D20
    ld a, [wC617]
    cp a, $64
    jr c, Jump_012_7D2F

Jump_012_7D20::
    ld a, [wC935]
    and a, $F0
    or a, $0A
    ld [wC935], a
    xor a, a
    ret

Jump_012_7D2C::
    dec b
    jr nz, Jump_012_7CE6

Jump_012_7D2F::
    ld b, $04
    ld hl, wC910

Jump_012_7D34::
    ld a, [hl+]
    ld c, a
    ld a, [wC192]
    cp a, c
    jr c, Jump_012_7D3E
    jr Jump_012_7D43

Jump_012_7D3E::
    dec b
    jr nz, Jump_012_7D34
    xor a, a
    ret

Jump_012_7D43::
    ld a, $01
    ret

Data_012_7D46:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $12, $15, $3D, $3E, $10, $11, $17, $15, $14, $13, $57, $12, $15, $12, $14, $10

Data_012_7D56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $20, $70, $60, $20, $60, $70, $20

Func_012_7D5E::
    ld a, [wCC44]
    bit 7, a
    jp nz, Jump_012_7D93
    ldh a, [hFF90]
    cp a, $30
    jp nz, Jump_012_7D93
    ldh a, [hFF8F]
    cp a, $05
    jp nz, Jump_012_7D93
    ldh a, [hFF92]
    cp a, $05
    jp nz, Jump_012_7D93
    ld de, $0076
    call Func_000_181B
    jr c, Jump_012_7D93
    ld de, $0070
    call Func_000_181B
    jr nc, Jump_012_7D93
    ld a, $00
    ld [wC935], a
    ld a, $01
    ret

Jump_012_7D93::
    xor a, a
    ret

Func_012_7D95::
    ld a, $0A
    ld [rRAMG], a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_7DA7::
    ld a, [hl+]
    ld c, $0B
    call Func_000_1F89
    ldh a, [hFFC6]
    cp a, e
    jr nz, Jump_012_7DB7
    ldh a, [hFFC7]
    cp a, d
    jr z, Jump_012_7DC3

Jump_012_7DB7::
    dec b
    jr nz, Jump_012_7DA7
    ld a, $80
    ldh [hFFC6], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_012_7DC3::
    ld a, [wC6FD]
    sub a, b
    ldh [hFFC6], a
    xor a, a
    ld [rRAMG], a
    ret

Func_012_7DCE::
    ldh a, [hFFC6]
    ld c, a
    ld b, $00
    ld hl, wC61D

Jump_012_7DD6::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_012_7DE8
    or a, a
    jr z, Jump_012_7DE8
    cp a, c
    jr z, Jump_012_7DED
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr nz, Jump_012_7DD6

Jump_012_7DE8::
    ld a, $FF
    ldh [hFFC6], a
    ret

Jump_012_7DED::
    ld a, b
    ldh [hFFC6], a
    ret

Func_012_7DF1::
    ldh a, [hFFC6]
    cp a, $17
    jr z, Jump_012_7E09
    ld b, a
    ld hl, wC61D
    add a, l
    ld l, a
    jr nc, Jump_012_7E00
    inc h

Jump_012_7E00::
    inc hl
    ld a, [hl-]
    ld [hl+], a
    inc b
    ld a, b
    cp a, $17
    jr nz, Jump_012_7E00

Jump_012_7E09::
    ld a, $FF
    ld [wC634], a
    ret

Func_012_7E0F::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    xor a, a
    ldh [hFFC7], a

Jump_012_7E1B::
    push bc
    ldh a, [hFFC7]
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_012_7E26
    inc h

Jump_012_7E26::
    ld b, $08
    ld c, $34

Jump_012_7E2A::
    ld a, [hl]
    call Func_000_1F80
    ldh a, [hFFC6]
    cp a, $FF
    jr z, Jump_012_7E65
    ld e, $76
    cp a, e
    jr z, Jump_012_7E77
    ld e, $77
    cp a, e
    jr z, Jump_012_7E77
    ld e, $78
    cp a, e
    jr z, Jump_012_7E77
    ld e, $79
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7A
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7B
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7C
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7D
    cp a, e
    jr z, Jump_012_7E77
    ld e, $92
    cp a, e
    jr z, Jump_012_7E77
    inc c
    dec b
    jr nz, Jump_012_7E2A

Jump_012_7E65::
    ldh a, [hFFC7]
    inc a
    ldh [hFFC7], a
    pop bc
    dec b
    jr nz, Jump_012_7E1B
    ld a, $80
    ldh [hFFC7], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_012_7E77::
    ld a, e
    ldh [hFFC8], a
    pop bc
    xor a, a
    ld [rRAMG], a
    ret
    db $AF, $E0, $C7, $C9

Func_012_7E84::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, [wC619]
    or a, a
    jr z, Jump_012_7EA0
    ld a, [wC618]
    cp a, h
    jr c, Jump_012_7EB7
    jr z, Jump_012_7E9A
    jr Jump_012_7EA0

Jump_012_7E9A::
    ld a, [wC617]
    cp a, l
    jr c, Jump_012_7EB7

Jump_012_7EA0::
    ld a, [wC617]
    sub a, l
    ld [wC617], a
    ld a, [wC618]
    sbc a, h
    ld [wC618], a
    ld a, [wC619]
    sbc a, $00
    ld [wC619], a
    ret

Jump_012_7EB7::
    xor a, a
    ld [wC617], a
    ld [wC618], a
    ld [wC619], a
    ret

Func_012_7EC2::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, [wC617]
    add a, l
    ld [wC617], a
    ld a, [wC618]
    adc a, h
    ld [wC618], a
    ld a, [wC619]
    adc a, $00
    ld [wC619], a
    cp a, $01
    ret c
    jr z, Jump_012_7EE5
    jr Jump_012_7EF5

Jump_012_7EE5::
    ld a, [wC618]
    cp a, $86
    ret c
    jr z, Jump_012_7EEF
    jr Jump_012_7EF5

Jump_012_7EEF::
    ld a, [wC617]
    cp a, $9F
    ret c

Jump_012_7EF5::
    ld a, $9F
    ld [wC617], a
    ld a, $86
    ld [wC618], a
    ld a, $01
    ld [wC619], a
    ret

Func_012_7F05::
    ld a, [wC619]
    srl a
    ld [wC619], a
    ld a, [wC618]
    rra
    ld [wC618], a
    ld a, [wC617]
    rra
    ld [wC617], a
    ret

Func_012_7F1C::
    ld a, [wC619]
    or a, a
    jr nz, Jump_012_7F49
    ld a, [wC618]
    or a, a
    jr nz, Jump_012_7F34
    ld a, [wC617]
    cp a, $96
    jr nc, Jump_012_7F34
    ld l, a
    ld h, $00
    jr Jump_012_7F5A

Jump_012_7F34::
    ld a, [wC618]
    cp a, $05
    jr c, Jump_012_7F44
    jr nz, Jump_012_7F49
    ld a, [wC617]
    cp a, $DC
    jr nc, Jump_012_7F49

Jump_012_7F44::
    ld hl, $0096
    jr Jump_012_7F5A

Jump_012_7F49::
    ld a, [wC617]
    ld l, a
    ld a, [wC618]
    ld h, a
    ld a, [wC619]
    ld e, a
    ld a, $0A
    call Func_000_16E2

Jump_012_7F5A::
    ld a, [wC617]
    sub a, l
    ld [wC617], a
    ld a, [wC618]
    sbc a, h
    ld [wC618], a
    ld a, [wC619]
    sbc a, $00
    ld [wC619], a
    ret
    ds $8F, $00
