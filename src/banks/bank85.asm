SECTION "Bank 85", ROMX[$4000], BANK[$85]
    db $85

Func_085_4001::
    ld a, [$C923]
    rst $00
    dw Jump_085_402D
    dw Jump_085_4009

Jump_085_4009::
    ld a, $00
    ld [$C929], a
    ld a, $01
    ld [$C92A], a
    ld a, $60
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB86], a
    ld a, $80
    ld [$C919], a
    ret

Jump_085_402D::
    ld hl, $C923
    inc [hl]
    ld a, [$CB8A]
    cp a, $50
    ret z
    ld a, $80
    ld [$C919], a
    ret

Func_085_403D::
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Func_085_4047::
    ld a, [$C923]
    rst $00
    dw Jump_085_41CC
    dw Jump_085_57E9
    dw Jump_085_4174
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_43CA
    dw Jump_085_57E9
    dw Jump_085_4159
    dw Jump_085_43AB
    dw Jump_085_4390
    dw Jump_085_437D
    dw Jump_085_437D
    dw Jump_085_437D
    dw Jump_085_412F
    dw Jump_085_40C3
    dw Jump_085_4093
    dw Jump_085_4071
    dw Jump_085_423C
    dw Jump_085_4231

Jump_085_4071::
    ld a, $05
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $01
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld hl, $4D52
    call Func_085_57C8
    ld hl, $CB7D
    dec [hl]
    ld hl, $C923
    dec [hl]
    ret

Jump_085_4093::
    xor a, a
    call Func_085_57D5
    ret nc
    ld hl, $5F22
    ld b, $02
    rst $10
    ld hl, $CB7D
    dec [hl]
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld hl, $449F
    ld b, $04
    rst $10
    xor a, a
    ldh [$FFB9], a
    ld hl, $6050
    ld b, $02
    rst $10
    ld de, $0078
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Jump_085_40C3::
    ld a, $05
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $02
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld hl, $C6FD
    inc [hl]
    ld a, [$C92E]
    dec a
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, $C8EF
    add a, l
    ld l, a
    jr nc, Jump_085_40EA
    inc h

Jump_085_40EA::
    ld a, [$CB86]
    ld [hl+], a
    ld a, [$CB8A]
    ld [hl+], a
    ld a, [$CB8B]
    ld [hl], a
    ld a, [$C92E]
    dec a
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_085_4102
    inc h

Jump_085_4102::
    ld a, [$D7F5]
    ld [hl], a
    ld hl, $5E85
    ld b, $02
    rst $10
    ld hl, $5E85
    ld b, $02
    rst $10
    call Func_000_222B
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld hl, $CB7D
    dec [hl]
    ld hl, $4D51
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_412F::
    ld hl, $5F22
    ld b, $02
    rst $10
    call Func_085_4555
    ld a, [$C92E]
    cp a, $03
    jr nz, Jump_085_4145
    ld a, $10
    ld [$C923], a
    ret

Jump_085_4145::
    push af
    call Func_085_45CB
    pop af
    ld hl, $C92E
    inc [hl]
    ld hl, $C6FD
    dec [hl]
    ld hl, $C923
    inc [hl]
    jp Jump_085_40C3

Jump_085_4159::
    ld de, $8EE0
    call Func_000_21A1
    xor a, a
    ld [$C92D], a
    ld [$C92E], a
    call Func_085_4505
    ld hl, $4470
    ld b, $04
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4174::
    ld a, [$C552]
    or a, a
    jr nz, Jump_085_41C1
    ld hl, $6D78
    ld b, $5F
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr nz, Jump_085_4192
    ld hl, $8D57
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4192::
    ld a, [$C6FD]
    cp a, $03
    jr z, Jump_085_41B2
    ld hl, $81B8
    call Func_085_57C8
    ld hl, $5EEE
    ld b, $02
    rst $10
    ld a, [$C6FD]
    inc a
    ld [$C92E], a
    ld a, $11
    ld [$C923], a
    ret

Jump_085_41B2::
    ld hl, $8D11
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_085_41C1::
    ld hl, $8D12
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_41CC::
    ld a, $1C
    ld [$C8CF], a
    ld [$C147], a
    ld a, $34
    ld [$C8D0], a
    ld [$C148], a
    ld a, $38
    ld [$C8D1], a
    ld [$C149], a
    ld a, $2C
    ld [$C8D2], a
    ld [$C14A], a
    ld a, $3D
    ld [$C8D3], a
    ld [$C14B], a
    ld a, $F0
    ld [$C8D4], a
    ld [$C14C], a
    ld hl, $4D0F
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Func_085_4207::
    ld a, [$C923]
    rst $00
    dw Func_085_442D
    dw Jump_085_57E9
    dw Func_085_43D5
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_43CA
    dw Jump_085_57E9
    dw Func_085_43AF
    dw Jump_085_43AB
    dw Jump_085_4390
    dw Jump_085_437D
    dw Jump_085_437D
    dw Jump_085_437D
    dw Func_085_4307
    dw Func_085_429B
    dw Func_085_426B
    dw Func_085_4249
    dw Jump_085_423C
    dw Jump_085_4231

Jump_085_4231::
    xor a, a
    call Func_085_57D5
    ret nc
    ld a, $0E
    ld [$C923], a
    ret

Jump_085_423C::
    ld hl, $CB96
    call Func_085_4339
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Func_085_4249:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $01
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld hl, $4D52
    call Func_085_57C8
    ld hl, $CB7D
    dec [hl]
    ld hl, $C923
    dec [hl]
    ret

Func_085_426B:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_085_57D5
    ret nc
    ld hl, $5F22
    ld b, $02
    rst $10
    ld hl, $CB7D
    dec [hl]
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld hl, $449F
    ld b, $04
    rst $10
    xor a, a
    ldh [$FFB9], a
    ld hl, $6050
    ld b, $02
    rst $10
    ld de, $005C
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Func_085_429B:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $02
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld hl, $C6FD
    inc [hl]
    ld a, [$C92E]
    dec a
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, $C8EF
    add a, l
    ld l, a
    jr nc, Jump_085_42C2
    inc h

Jump_085_42C2::
    ld a, [$CB96]
    ld [hl+], a
    ld a, [$CB9A]
    ld [hl+], a
    ld a, [$CB9B]
    ld [hl], a
    ld a, [$C92E]
    dec a
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_085_42DA
    inc h

Jump_085_42DA::
    ld a, [$D7F5]
    ld [hl], a
    ld hl, $5E85
    ld b, $02
    rst $10
    ld hl, $5E85
    ld b, $02
    rst $10
    call Func_000_222B
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld hl, $CB7D
    dec [hl]
    ld hl, $4D51
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Func_085_4307:: ; heuristic: follows a terminator; C0
    ld hl, $CB96
    call Func_085_4339
    or a, a
    ret z
    ld hl, $5F22
    ld b, $02
    rst $10
    call Func_085_4555
    ld a, [$C92E]
    cp a, $03
    jr nz, Jump_085_4325
    ld a, $10
    ld [$C923], a
    ret

Jump_085_4325::
    push af
    call Func_085_45CB
    pop af
    ld hl, $C92E
    inc [hl]
    ld hl, $C6FD
    dec [hl]
    ld hl, $C923
    inc [hl]
    jp Func_085_429B

Func_085_4339::
    ld a, [hl]
    or a, a
    jr nz, Jump_085_4347
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_085_4344
    inc h

Jump_085_4344::
    inc [hl]
    jr Jump_085_4369

Jump_085_4347::
    dec a
    jr nz, Jump_085_4354
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_085_4351
    inc h

Jump_085_4351::
    inc [hl]
    jr Jump_085_4369

Jump_085_4354::
    dec a
    jr nz, Jump_085_4361
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_085_435E
    inc h

Jump_085_435E::
    dec [hl]
    jr Jump_085_4369

Jump_085_4361::
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_085_4368
    inc h

Jump_085_4368::
    dec [hl]

Jump_085_4369::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $10
    jr z, Jump_085_4376
    xor a, a
    ret

Jump_085_4376::
    xor a, a
    ld [$C921], a
    ld a, $01
    ret

Jump_085_437D::
    ld a, [$C92E]
    cp a, $03
    jr nz, Jump_085_4389
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4389::
    ld hl, $61EF
    ld b, $12
    rst $10
    ret

Jump_085_4390::
    ld hl, $5F22
    ld b, $02
    rst $10
    call Func_085_4555
    ld hl, $CD56
    call Func_085_57C8
    ld hl, $449F
    ld b, $04
    rst $10
    ld a, $01
    ld [$C923], a
    ret

Jump_085_43AB::
    call Func_085_446D
    ret

Func_085_43AF:: ; heuristic: follows a terminator; C0
    ld de, $8EE0
    call Func_000_21A1
    xor a, a
    ld [$C92D], a
    ld [$C92E], a
    call Func_085_4505
    ld hl, $4470
    ld b, $04
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_085_43CA::
    ld hl, $4D50
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Func_085_43D5:: ; heuristic: follows a terminator; C0
    ld a, [$C552]
    or a, a
    jr nz, Jump_085_4422
    ld hl, $6D78
    ld b, $5F
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr nz, Jump_085_43F3
    ld hl, $8D55
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_43F3::
    ld a, [$C6FD]
    cp a, $03
    jr z, Jump_085_4413
    ld hl, $81B8
    call Func_085_57C8
    ld hl, $5EEE
    ld b, $02
    rst $10
    ld a, [$C6FD]
    inc a
    ld [$C92E], a
    ld a, $11
    ld [$C923], a
    ret

Jump_085_4413::
    ld hl, $81B9
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4422::
    ld hl, $81BA
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Func_085_442D:: ; heuristic: follows a terminator; C0
    ld a, $0B
    ld [$C8CF], a
    ld [$C147], a
    ld a, $2C
    ld [$C8D0], a
    ld [$C148], a
    ld a, $2C
    ld [$C8D1], a
    ld [$C149], a
    ld a, $31
    ld [$C8D2], a
    ld [$C14A], a
    ld a, $32
    ld [$C8D3], a
    ld [$C14B], a
    ld a, $90
    ld [$C8D4], a
    ld a, $F0
    ld [$C8D5], a
    ld [$C14C], a
    ld hl, $41B7
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Func_085_446D::
    ld a, [$C562]
    bit 1, a
    jr z, Jump_085_4479
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4479::
    bit 0, a
    jr z, Jump_085_4493
    call Func_085_44D2
    ld a, $BC
    call Func_000_1211
    ld a, $69
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4493::
    bit 6, a
    jr z, Jump_085_44AA
    call Func_085_44D2
    ld a, $C3
    call Func_000_1211
    ld hl, $C92E
    dec [hl]
    ld a, $69
    call Func_000_1278
    jr Jump_085_44BF

Jump_085_44AA::
    bit 7, a
    jr z, Jump_085_44BF
    call Func_085_44D2
    ld a, $C3
    call Func_000_1211
    ld hl, $C92E
    inc [hl]
    ld a, $69
    call Func_000_1278

Jump_085_44BF::
    call Func_085_44D2
    ld c, $BB
    ld a, [$C5F0]
    bit 3, a
    jr z, Jump_085_44CD
    ld c, $C3

Jump_085_44CD::
    ld a, c
    call Func_000_1211
    ret

Func_085_44D2::
    ld a, [$C92E]
    and a, $03
    ld [$C92E], a
    swap a
    add a, $08
    ld c, a
    ldh a, [$FFA5]
    add a, c
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    ldh a, [$FFA1]
    add a, $08
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_085_4504
    inc h

Jump_085_4504::
    ret

Func_085_4505::
    ld hl, $5EEE
    ld b, $02
    rst $10
    ld hl, $C198
    ld de, $4583
    ld b, $09

Jump_085_4513::
    push hl
    ld c, $08

Jump_085_4516::
    ld a, [de]
    inc de
    ld [hl+], a
    dec c
    jr nz, Jump_085_4516
    pop hl
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_085_4524
    inc h

Jump_085_4524::
    dec b
    jr nz, Jump_085_4513
    ld a, [$C525]
    or a, a
    jr z, Jump_085_454C
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    ld b, $09

Jump_085_4536::
    push hl
    ld c, $08

Jump_085_4539::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_085_4539
    pop hl
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_085_4546
    inc h

Jump_085_4546::
    dec b
    jr nz, Jump_085_4536
    xor a, a
    ldh [$FF70], a

Jump_085_454C::
    call Func_085_4555
    ld a, $6C
    call Func_000_1278
    ret

Func_085_4555::
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_085_457D
    inc d

Jump_085_457D::
    ld l, e
    ld h, d
    call Func_000_1EA5
    ret
    INCBIN "dwm2-cobi-us.gbc", $214583, $48

Func_085_45CB::
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_085_45D3
    inc h

Jump_085_45D3::
    ld a, $0A
    ld [$0100], a
    ld a, [hl]
    push af
    ld c, $5D
    call Func_000_1F89
    pop af
    push af
    ld c, $5B
    call Func_000_1FD1
    ldh a, [$FFC6]
    ld [hl+], a
    ldh a, [$FFC7]
    ld [hl], a
    pop af
    push af
    ld c, $61
    call Func_000_1F89
    pop af
    push af
    ld c, $5F
    call Func_000_1FD1
    ldh a, [$FFC6]
    ld [hl+], a
    ldh a, [$FFC7]
    ld [hl], a
    pop af
    push af
    ld c, $55
    call Func_000_1FD1
    xor a, a
    ld [hl], a
    pop af
    ld c, $00
    call Func_000_1FD1
    ld a, $01
    ld [hl], a
    xor a, a
    ld [$0100], a
    ret

Func_085_4617::
    ld a, [$C923]
    rst $00
    dw Jump_085_46B0
    dw Jump_085_4684
    dw Jump_085_4658
    dw Jump_085_4623

Jump_085_4623::
    ld a, $01
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $80
    ld [$C919], a
    ret

Jump_085_4658::
    ld a, $01
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $E0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    jr Jump_085_46DA

Jump_085_4684::
    ld a, $02
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    jr Jump_085_46DA

Jump_085_46B0::
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $03
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10

Jump_085_46DA::
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Func_085_46E4:: ; heuristic: follows a terminator; C0
    ld a, [$C923]
    or a, a
    jr nz, Jump_085_4703
    ld a, $05
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $50
    ld [$CBD3], a
    ld a, $10
    ld [$CBD4], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4703::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $28
    ret nz
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret

Func_085_4717::
    ld a, [$C923]
    rst $00
    dw Jump_085_4725
    dw Jump_085_471F

Jump_085_471F::
    ld a, $80
    ld [$C919], a
    ret

Jump_085_4725::
    ld hl, $5EEE
    ld b, $02
    rst $10
    ld a, $01
    ld [$C8C7], a
    ld a, $02
    ld [$C5DB], a
    ld a, $0C
    ld [$C5DC], a
    xor a, a
    ld [$C5DD], a
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    xor a, a
    ld [$C91F], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_4755:: ; heuristic: follows a terminator; C0
    ld a, $80
    ld [$C919], a
    ldh a, [$FF92]
    cp a, $02
    ret z
    ld de, $4783
    or a, a
    jr z, Jump_085_4768
    ld de, $478F

Jump_085_4768::
    ldh a, [$FF8F]
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_085_4771
    inc d

Jump_085_4771::
    ld hl, $CB86

Jump_085_4774::
    ld a, [de]
    cp a, $FF
    ret z
    ld [hl], a
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_085_4780
    inc h

Jump_085_4780::
    inc de
    jr Jump_085_4774
    db $00, $00, $01, $FF, $00, $FF, $FF, $FF, $03, $01, $00, $FF, $01, $03, $02, $FF
    db $01, $FF, $FF, $FF, $02, $02, $01, $FF

Func_085_479B::
    ld a, [$C923]
    rst $00
    dw Jump_085_480A
    dw Jump_085_47E3
    dw Jump_085_47E3
    dw Jump_085_47E3
    dw Jump_085_47B1
    dw Jump_085_47AB

Jump_085_47AB::
    ld a, $80
    ld [$C919], a
    ret

Jump_085_47B1::
    ld a, $E0
    ldh [$FF8E], a
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    xor a, a
    ldh [$FF8D], a
    ld a, $48
    ldh [$FF90], a
    ld a, $08
    ldh [$FF8F], a
    ld a, $07
    ldh [$FF92], a
    ld a, $40
    ld [$C8C8], a
    ld a, $40
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ret

Jump_085_47E3::
    ld a, [$C921]
    swap a
    ld c, a
    ld a, $10
    sub a, c
    ld [$C928], a
    ld hl, $6AEB
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ldh a, [$FF8D]
    add a, a
    or a, $01
    ldh [$FF8D], a
    ld hl, $C921
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_085_480A::
    ld a, $65
    call Func_000_1278
    ld a, $01
    ldh [$FF8D], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_481C::
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_085_4829
    bit 3, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4829::
    cp a, $3C
    jr nc, Jump_085_4833
    bit 2, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4833::
    bit 1, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4839::
    ld a, $80
    ld [$CBCF], a
    jr Jump_085_4844

Jump_085_4840::
    xor a, a
    ld [$CBCF], a

Jump_085_4844::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret

Func_085_4858::
    ld b, $00
    ldh a, [$FF8E]
    ld c, a
    ldh a, [$FF98]
    cp a, $01
    jr z, Jump_085_4869
    cp a, $03
    jr z, Jump_085_486F
    jr Jump_085_4873

Jump_085_4869::
    ld a, c
    add a, $10
    ld c, a
    jr Jump_085_4873

Jump_085_486F::
    ld a, c
    sub a, $10
    ld c, a

Jump_085_4873::
    ld hl, $489C

Jump_085_4876::
    ld a, [hl]
    cp a, c
    jr z, Jump_085_487E
    inc hl
    inc b
    jr Jump_085_4876

Jump_085_487E::
    ld de, $01CF
    ld a, b
    add a, e
    ld e, a
    jr nc, Jump_085_4887
    inc d

Jump_085_4887::
    call Func_000_1845
    ld hl, $43B8
    ld b, $84
    rst $10
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld a, $80
    ld [$C919], a
    ret
    db $20, $40, $50, $80

Func_085_48A0::
    ld a, [$C923]
    rst $00
    dw Jump_085_493E
    dw Jump_085_48C2
    dw Jump_085_57E9
    dw Jump_085_48AE
    dw Func_085_57F3

Jump_085_48AE::
    ld hl, $0B9D
    ld a, [$C921]
    or a, a
    jr nz, Jump_085_48BA
    ld hl, $0BC2

Jump_085_48BA::
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_48C2::
    ld a, [$D092]
    or a, a
    jr nz, Jump_085_4932
    ld de, $003B
    call Func_000_1845
    ld a, $09
    ldh [$FFC6], a
    ld hl, $5B23
    ld b, $85
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_085_4912
    ld hl, $6990
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_085_48F5

Jump_085_48E9::
    ld hl, $0B9E
    call Func_085_57C8
    ld a, $04
    ld [$C923], a
    ret

Jump_085_48F5::
    ld a, $09
    ldh [$FFC7], a
    ld de, $0205
    call Func_000_181B
    jr nc, Jump_085_4905
    ld a, $49
    ldh [$FFC7], a

Jump_085_4905::
    ld hl, $6955
    ld b, $12
    rst $10
    ld a, $01
    ld [$C921], a
    jr Jump_085_4921

Jump_085_4912::
    ld hl, $689A
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_085_48E9
    xor a, a
    ld [$C921], a

Jump_085_4921::
    ld de, $003C
    call Func_000_1845
    ld hl, $0B9C
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4932::
    ld hl, $0B97
    call Func_085_57C8
    ld a, $04
    ld [$C923], a
    ret

Jump_085_493E::
    ld a, $30
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_085_494D::
    ld a, [$C923]
    rst $00
    dw Jump_085_49EB
    dw Jump_085_496F
    dw Jump_085_57E9
    dw Jump_085_495B
    dw Func_085_57F3

Jump_085_495B::
    ld hl, $0B93
    ld a, [$C921]
    or a, a
    jr nz, Jump_085_4967
    ld hl, $0BC2

Jump_085_4967::
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_496F::
    ld a, [$D092]
    or a, a
    jr nz, Jump_085_49DF
    ld de, $0039
    call Func_000_1845
    ld a, $07
    ldh [$FFC6], a
    ld hl, $5B23
    ld b, $85
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_085_49BF
    ld hl, $6990
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_085_49A2

Jump_085_4996::
    ld hl, $0B94
    call Func_085_57C8
    ld a, $04
    ld [$C923], a
    ret

Jump_085_49A2::
    ld a, $07
    ldh [$FFC7], a
    ld de, $0203
    call Func_000_181B
    jr nc, Jump_085_49B2
    ld a, $47
    ldh [$FFC7], a

Jump_085_49B2::
    ld hl, $6955
    ld b, $12
    rst $10
    ld a, $01
    ld [$C921], a
    jr Jump_085_49CE

Jump_085_49BF::
    ld hl, $689A
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_085_4996
    xor a, a
    ld [$C921], a

Jump_085_49CE::
    ld de, $003A
    call Func_000_1845
    ld hl, $0B92
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_49DF::
    ld hl, $0B97
    call Func_085_57C8
    ld a, $04
    ld [$C923], a
    ret

Jump_085_49EB::
    ld a, $2F
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_085_49FA::
    ld a, [$C923]
    rst $00
    dw Jump_085_4A1C
    dw Jump_085_4A04
    dw Func_085_57F3

Jump_085_4A04::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_085_4A15
    ld hl, $0D82
    call Func_085_57C8
    ret

Jump_085_4A15::
    ld hl, $0D83
    call Func_085_57C8
    ret

Jump_085_4A1C::
    ld a, $15
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_085_4A2B::
    ld a, [$C923]
    rst $00
    dw Jump_085_4A58
    dw Jump_085_4A35
    dw Func_085_57F3

Jump_085_4A35::
    ld hl, $C923
    inc [hl]
    ld a, [$D092]
    or a, a
    jr nz, Jump_085_4A51
    ld hl, $0BB1
    call Func_085_57C8
    ld a, $01
    ld [$C894], a
    ld de, $0038
    call Func_000_1845
    ret

Jump_085_4A51::
    ld hl, $0BB2
    call Func_085_57C8
    ret

Jump_085_4A58::
    ld de, $0037
    call Func_000_1845
    ld a, $14
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_085_4A6D::
    ld a, [$C923]
    or a, a
    jr z, Jump_085_4A79
    ld a, $80
    ld [$C919], a
    ret

Jump_085_4A79::
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $80
    ld [$C8C9], a
    ld a, $03
    ld [$C8C6], a
    ldh a, [$FF8E]
    cp a, $20
    jr nz, Jump_085_4ABC
    ld a, $0F
    ldh [$FF90], a
    ld de, $0025
    call Func_000_181B
    jr c, Jump_085_4AAB
    ld a, $20
    ld [$C8C8], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ld a, $04
    call Func_000_0DF2
    ret

Jump_085_4AAB::
    ld a, $20
    ld [$C8C8], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ld a, $04
    call Func_000_0DF2
    ret

Jump_085_4ABC::
    ld de, $0025
    call Func_000_181B
    jr c, Jump_085_4AD9
    ld a, $10
    ldh [$FF90], a
    ld a, $70
    ld [$C8C8], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ld a, $04
    call Func_000_0DF2
    ret

Jump_085_4AD9::
    ld a, $0F
    ldh [$FF90], a
    ld a, $70
    ld [$C8C8], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ld a, $04
    call Func_000_0DF2
    ret

Func_085_4AEE::
    ld a, [$C923]
    or a, a
    jr nz, Jump_085_4B09
    ld hl, $CB9B
    inc [hl]
    ld de, $CB9B
    call Func_085_5780
    ret nc
    ld a, $01
    ld [$CB7D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4B09::
    ld a, $80
    ld [$C919], a
    ret

Func_085_4B0F::
    ld a, [$C923]
    rst $00
    dw Jump_085_4C00
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_4BC7
    dw Jump_085_57E9
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4CC6
    dw Jump_085_4BBD
    dw Jump_085_4BBD
    dw Jump_085_57E9
    dw Jump_085_4BB2
    dw Jump_085_57E9
    dw Jump_085_4B6F
    dw Jump_085_4B33

Jump_085_4B33::
    xor a, a
    ldh [$FF8D], a
    ld a, $01
    ld [$C92A], a
    ld a, $01
    ld [$C929], a
    ld a, $C0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $03
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $01
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld de, $002B
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Jump_085_4B6F::
    ld a, $01
    ld [$C929], a
    ld a, [$C921]
    or a, a
    jr nz, Jump_085_4B94
    ld a, $01
    ld [$C92A], a
    ld a, $70
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C921
    inc [hl]
    ret

Jump_085_4B94::
    ld a, $00
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4BB2::
    ld hl, $0BA7
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4BBD::
    ld de, $CBAB
    ld hl, $0BA6
    call Func_085_57A2
    ret

Jump_085_4BC7::
    ld a, [$C552]
    or a, a
    jr nz, Jump_085_4BEC
    ld hl, $8BA5
    call Func_085_57C8
    ld a, [$CB96]
    add a, a
    ld hl, $4BF8
    add a, l
    ld l, a
    jr nc, Jump_085_4BDF
    inc h

Jump_085_4BDF::
    ld a, [hl+]
    ld [$CBAA], a
    ld a, [hl]
    ld [$CBAB], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4BEC::
    ld hl, $8D95
    call Func_085_57C8
    ld a, $01
    ld [$C923], a
    ret
    db $D0, $10, $C0, $20, $D0, $30, $E0, $20

Jump_085_4C00::
    ld hl, $6D78
    ld b, $5F
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr nz, Jump_085_4C18
    ld hl, $0BA3
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4C18::
    ld hl, $4BA4
    call Func_085_57C8
    ld a, $02
    ld [$C923], a
    ret

Func_085_4C24::
    ld a, [$C923]
    rst $00
    dw Jump_085_4D69
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_4D30
    dw Jump_085_57E9
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4CC6
    dw Jump_085_4CBC
    dw Jump_085_4CBC
    dw Jump_085_57E9
    dw Jump_085_4C46
    dw Jump_085_57E9
    dw Func_085_57F3

Jump_085_4C46::
    ld a, [$C921]
    or a, a
    jr nz, Jump_085_4C51
    ld a, $65
    call Func_000_1278

Jump_085_4C51::
    ld a, [$C921]
    push af
    sra a
    ld [$C921], a
    ld de, $CBAB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    pop af
    ld [$C921], a
    ld a, [$C921]
    and a, $01
    jr nz, Jump_085_4C7F
    ld a, [$CBA6]
    inc a
    and a, $03
    ld [$CBA6], a

Jump_085_4C7F::
    ld a, [$CBAA]
    dec a
    dec a
    ld [$CBAA], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $40
    ret nz
    ld hl, $0B2C
    call Func_085_57C8
    ld a, $04
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $01
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld de, $002A
    call Func_000_1845
    xor a, a
    ldh [$FF8D], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4CBC::
    ld de, $CBAB
    ld hl, $0B2B
    call Func_085_57A2
    ret

Jump_085_4CC6::
    ld a, $0E
    ldh [$FF8D], a
    ld a, [$C921]
    or a, a
    jr nz, Jump_085_4CD5
    ld a, $65
    call Func_000_1278

Jump_085_4CD5::
    ld a, [$C921]
    push af
    sra a
    ld [$C921], a
    ld de, $CBAB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    pop af
    ld [$C921], a
    ld a, [$C921]
    and a, $01
    jr nz, Jump_085_4D03
    ld a, [$CBA6]
    inc a
    and a, $03
    ld [$CBA6], a

Jump_085_4D03::
    ld a, [$CBAA]
    inc a
    inc a
    ld [$CBAA], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $40
    ret nz
    ld a, $72
    call Func_000_1278
    ld a, [$CB96]
    ld [$CBA6], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4D29::
    ld hl, $61EF
    ld b, $12
    rst $10
    ret

Jump_085_4D30::
    ld a, [$C552]
    or a, a
    jr nz, Jump_085_4D55
    ld hl, $8B2A
    call Func_085_57C8
    ld a, [$CB96]
    add a, a
    ld hl, $4D61
    add a, l
    ld l, a
    jr nc, Jump_085_4D48
    inc h

Jump_085_4D48::
    ld a, [hl+]
    ld [$CBAA], a
    ld a, [hl]
    ld [$CBAB], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4D55::
    ld hl, $8D95
    call Func_085_57C8
    ld a, $01
    ld [$C923], a
    ret
    db $D0, $10, $C0, $20, $D0, $30, $E0, $20

Jump_085_4D69::
    ld hl, $6D78
    ld b, $5F
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr nz, Jump_085_4D81
    ld hl, $0B28
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4D81::
    ld hl, $4B29
    call Func_085_57C8
    ld a, $02
    ld [$C923], a
    ret

Func_085_4D8D::
    ld a, $01
    ldh [$FFC7], a
    ld a, [$D7F5]
    ldh [$FFC8], a
    ld a, $01
    ldh [$FFC9], a
    ld hl, $6E46
    ld b, $01
    rst $10
    ld a, $80
    ld [$C919], a
    ret

Func_085_4DA6::
    ld a, [$C923]
    rst $00
    dw Jump_085_4EAA
    dw Jump_085_4E1F
    dw Jump_085_4DE8
    dw Jump_085_4DB2

Jump_085_4DB2::
    ld a, [$C921]
    and a, $07
    jr nz, Jump_085_4DD8
    call Func_000_09F3
    ld a, [$CD03]
    and a, $03
    swap a
    ld hl, $CB86
    add a, l
    ld l, a
    jr nc, Jump_085_4DCB
    inc h

Jump_085_4DCB::
    push hl
    call Func_000_09F3
    ld a, [$CD04]
    and a, $01
    add a, a
    inc a
    pop hl
    ld [hl], a

Jump_085_4DD8::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $3C
    ret nz
    ld a, $80
    ld [$C919], a
    ret

Jump_085_4DE8::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $01
    ret nz
    xor a, a
    ld [$C921], a
    ld a, [$C922]
    cp a, $05
    jr z, Jump_085_4E06
    inc a
    ld [$C922], a
    ld hl, $C923
    dec [hl]
    ret

Jump_085_4E06::
    ld a, [$CC38]
    set 3, a
    ld [$CC38], a
    ld hl, $C923
    inc [hl]
    ld de, $0056
    call Func_000_181B
    ret c
    ld a, $80
    ld [$C919], a
    ret

Jump_085_4E1F::
    ld a, [$C922]
    add a, a
    add a, a
    add a, a
    ld hl, $4E7A
    add a, l
    ld l, a
    jr nc, Jump_085_4E2D
    inc h

Jump_085_4E2D::
    ld a, [$C921]
    and a, $01
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_085_4E39
    inc h

Jump_085_4E39::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $93
    ld hl, $C198
    call Func_000_0CF5
    pop hl
    ld a, [$C525]
    or a, a
    jr z, Jump_085_4E61
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, $02
    ldh [$FF70], a
    ld b, $93
    ld hl, $D000
    call Func_000_0CF5
    ld a, $00
    ldh [$FF70], a

Jump_085_4E61::
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $04
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret
    db $91, $5A
    dw Data_085_6124
    db $36, $5B
    dw Data_085_6153
    db $36, $5B
    dw Data_085_6153
    db $E9, $5B
    dw Data_085_6194
    db $E9, $5B
    dw Data_085_6194
    db $99, $5C
    dw Data_085_61CF
    db $99, $5C
    dw Data_085_61CF
    db $4B, $5D
    dw Data_085_6208
    db $4B, $5D
    dw Data_085_6208
    db $F5, $5D
    dw Data_085_623C
    db $F5, $5D
    dw Data_085_623C
    db $96, $5E
    dw Data_085_6266

Jump_085_4EAA::
    ld de, $0056
    call Func_000_181B
    jr nc, Jump_085_4F0B
    ld a, $01
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $10
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $02
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $03
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $20
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $00
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $30
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z

Jump_085_4F0B::
    xor a, a
    ld [$C922], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_4F14::
    ld a, [$C923]
    rst $00
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F8E
    dw Jump_085_57E9
    dw Jump_085_4F52
    dw Jump_085_4F3A
    dw Jump_085_4F34
    dw Jump_085_4F2E

Jump_085_4F2E::
    ld a, $80
    ld [$C919], a
    ret

Jump_085_4F34::
    ld b, $1E
    call Func_085_4FD8
    ret

Jump_085_4F3A::
    ld a, [$CBAA]
    inc a
    inc a
    inc a
    inc a
    ld [$CBAA], a
    cp a, $60
    ret nz
    ld hl, $CBAC
    call Func_085_5765
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4F52::
    ld a, $03
    ld [$CB86], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $04
    ret c
    push af
    ld a, $66
    call Func_000_1278
    xor a, a
    ld [$CB86], a
    pop af
    cp a, $08
    ret nz
    ld a, $01
    ld [$CB86], a
    ld hl, $CBAC
    call Func_085_576F
    ld hl, $CBAC
    call Func_085_5760
    ld a, $03
    ld [$CBA6], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4F8E::
    ld a, $03
    ld [$CB86], a
    ld hl, $0737
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_4F9E::
    ld hl, $CBAC
    call Func_085_576A
    ld a, [$C921]
    or a, a
    jr nz, Jump_085_4FBE
    ld a, [$CBAB]
    inc a
    ld [$CBAB], a
    cp a, $48
    ret nz
    ld a, $63
    call Func_000_1278
    ld hl, $C921
    inc [hl]
    ret

Jump_085_4FBE::
    ld a, [$CBAB]
    dec a
    dec a
    ld [$CBAB], a
    cp a, $40
    ret nz
    ld hl, $6E09
    ld b, $5F
    rst $10
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_4FD8::
    ld a, [$C5F0]
    and a, $03
    bit 0, a
    jr nz, Jump_085_5003
    dec a
    add a, a
    ld c, a
    bit 7, a
    jr z, Jump_085_4FF8
    cpl
    inc a
    ld c, a
    ldh a, [$FFA1]
    sub a, c
    ldh [$FFA1], a
    ldh a, [$FFA2]
    sbc a, $00
    ldh [$FFA2], a
    jr Jump_085_5003

Jump_085_4FF8::
    ldh a, [$FFA1]
    add a, c
    ldh [$FFA1], a
    ldh a, [$FFA2]
    adc a, $00
    ldh [$FFA2], a

Jump_085_5003::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, b
    ret nz
    xor a, a
    ldh [$FFA1], a
    ldh [$FFA2], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_501A::
    ld a, [$C923]
    rst $00
    dw Jump_085_5022
    dw Func_085_57F3

Jump_085_5022::
    ld hl, $C923
    inc [hl]
    ldh a, [$FF90]
    ld c, a
    ld de, $5041

Jump_085_502C::
    ld a, [de]
    cp a, $FF
    ret z
    ld a, [de]
    cp a, c
    jr z, Jump_085_5038
    inc de
    inc de
    jr Jump_085_502C

Jump_085_5038::
    inc de
    ld a, [de]
    ld l, a
    ld h, $0C
    call Func_085_57C8
    ret
    db $CA, $4A, $CB, $4B, $CC, $4C, $CD, $4D, $D3, $4E, $D4, $4F, $D5, $50, $D6, $51
    db $DC, $52, $DD, $53, $DE, $54, $DF, $55, $FF

Func_085_505A::
    ldh a, [$FF98]
    ld [$C8EF], a
    ld a, $80
    ld [$C919], a
    ret

Func_085_5065::
    ld a, [$C923]
    rst $00
    dw Jump_085_5086
    dw Jump_085_57E9
    dw Jump_085_506F

Jump_085_506F::
    xor a, a
    ld [$C923], a
    ld a, [$C922]
    inc a
    ld [$C922], a
    ld c, a
    ld a, [$C6FD]
    cp a, c
    ret nz
    ld a, $80
    ld [$C919], a
    ret

Jump_085_5086::
    ld hl, $C923
    inc [hl]
    ld a, $0A
    ld [$0100], a
    ld hl, $C6FE
    ld a, [$C922]
    add a, l
    ld l, a
    jr nc, Jump_085_509A
    inc h

Jump_085_509A::
    ld a, [hl]
    push af
    ld c, $01
    call Func_000_1FA4
    ld hl, $C8CF
    ld de, $C147
    ld b, $0A

Jump_085_50A9::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_085_50A9
    ld a, $F0
    ld [de], a
    pop af
    push af
    ld c, $56
    call Func_000_1F80
    ldh a, [$FFC6]
    ld e, a
    pop af
    ld c, $57
    call Func_000_1F80
    xor a, a
    ld [$0100], a
    ldh a, [$FFC6]
    cp a, e
    jr nz, Jump_085_50D2
    ld hl, $CA56
    call Func_085_57C8
    ret

Jump_085_50D2::
    ld l, a
    ld h, $00
    call Func_000_16F5
    ld de, $C17E
    ld a, [$C8C1]
    or a, a
    jr z, Jump_085_50E3
    ld [de], a
    inc de

Jump_085_50E3::
    ld a, [$C8C2]
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ld hl, $CA55
    call Func_085_57C8
    ret

Func_085_50F2::
    ld a, [$C923]
    rst $00
    dw Jump_085_521E
    dw Jump_085_51FB
    dw Jump_085_57E9
    dw Jump_085_51DC
    dw Jump_085_51A5
    dw Jump_085_5173
    dw Jump_085_57E9
    dw Jump_085_5123
    dw Jump_085_510A
    dw Func_085_57F3

Jump_085_510A::
    ld a, $E0
    ld [$CB8B], a
    ld a, $20
    ld [$CB9B], a
    ld hl, $078D
    call Func_085_57C8
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5123::
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_085_5130
    bit 1, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_5130::
    cp a, $3C
    jr nc, Jump_085_513A
    bit 2, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_513A::
    bit 3, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_5140::
    ld a, $20
    ld [$CB8B], a
    ld a, $E0
    ld [$CB9B], a
    jr Jump_085_5156

Jump_085_514C::
    ld a, $E0
    ld [$CB8B], a
    ld a, $20
    ld [$CB9B], a

Jump_085_5156::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    ld a, $E0
    ld [$CB8B], a
    ld a, $20
    ld [$CB9B], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5173::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $01
    jr z, Jump_085_5181
    call Func_085_5190

Jump_085_5181::
    ld a, [$C921]
    cp a, $78
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_5190::
    call Func_000_095B
    ld a, [$C5E8]
    and a, $03
    cp a, $03
    jr z, Func_085_5190
    dec a
    ld c, a
    ld a, $40
    add a, c
    ld [$CB9A], a
    ret

Jump_085_51A5::
    ld a, [$C922]
    and a, $03
    cp a, $03
    jr z, Jump_085_51B9
    ld de, $015F
    add a, e
    ld e, a
    jr nc, Jump_085_51B6
    inc d

Jump_085_51B6::
    call Func_000_1845

Jump_085_51B9::
    ld de, $0162
    call Func_000_181B
    jr c, Jump_085_51C7
    ld a, $80
    ld [$C919], a
    ret

Jump_085_51C7::
    ld de, $0163
    call Func_000_1845
    ld hl, $0779
    call Func_085_57C8
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_51DC::
    ld a, [$C922]
    and a, $03
    ld de, $51F7
    add a, e
    ld e, a
    jr nc, Jump_085_51E9
    inc d

Jump_085_51E9::
    ld a, [de]
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret
    db $0D, $0E, $0F, $10

Jump_085_51FB::
    ld a, [$C922]
    and a, $03
    add a, a
    ld de, $5216
    add a, e
    ld e, a
    jr nc, Jump_085_5209
    inc d

Jump_085_5209::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret
    db $6C, $07, $6F, $07, $72, $07, $75, $07

Jump_085_521E::
    ld hl, $C923
    inc [hl]
    xor a, a
    ld [$C922], a
    ld de, $015F
    call Func_000_181B
    ret nc
    ld hl, $C922
    inc [hl]
    ld de, $0160
    call Func_000_181B
    ret nc
    ld hl, $C922
    inc [hl]
    ld de, $0161
    call Func_000_181B
    ret nc
    ld hl, $C922
    inc [hl]
    ret

Func_085_5248::
    ld a, [$C923]
    rst $00
    dw Jump_085_5302
    dw Jump_085_52ED
    dw Jump_085_52C8
    dw Jump_085_5290
    dw Jump_085_57E9
    dw Jump_085_5302
    dw Jump_085_52ED
    dw Jump_085_52C8
    dw Jump_085_5290
    dw Jump_085_57E9
    dw Jump_085_5302
    dw Jump_085_52ED
    dw Jump_085_52C8
    dw Jump_085_5290
    dw Jump_085_57E9
    dw Jump_085_526C

Jump_085_526C::
    ld hl, $C61D

Jump_085_526F::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_085_527A
    or a, a
    jr z, Jump_085_527A
    inc hl
    jr Jump_085_526F

Jump_085_527A::
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $38
    ld a, [$C836]
    set 6, a
    ld [$C836], a
    ld a, $80
    ld [$C919], a
    ret

Jump_085_5290::
    ld a, [$CB86]
    or a, a
    jr nz, Jump_085_52A0
    ld a, [$CBD4]
    inc a
    inc a
    ld [$CBD4], a
    jr Jump_085_52B8

Jump_085_52A0::
    dec a
    jr nz, Jump_085_52AD
    ld hl, $CBD3
    inc [hl]
    ld hl, $CBD4
    inc [hl]
    jr Jump_085_52B8

Jump_085_52AD::
    dec a
    jr z, Jump_085_52B8
    ld hl, $CBD3
    dec [hl]
    ld hl, $CBD4
    inc [hl]

Jump_085_52B8::
    ld de, $CBD4
    call Func_085_5780
    ret nc
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_52C8::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $3C
    ret nz
    ld a, [$C922]
    ld hl, $052C
    add a, l
    ld l, a
    jr nc, Jump_085_52DD
    inc h

Jump_085_52DD::
    call Func_085_57C8
    xor a, a
    ld [$C921], a
    ld hl, $C922
    inc [hl]
    ld hl, $C923
    inc [hl]
    ret

Jump_085_52ED::
    ld a, $80
    ld [$CBCF], a
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_085_5780
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5302::
    ld a, [$C922]
    ld hl, $5329
    add a, l
    ld l, a
    jr nc, Jump_085_530D
    inc h

Jump_085_530D::
    ld a, [hl]
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    xor a, a
    ld [$CBCF], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_5329:: ; heuristic: follows a terminator; C0
    inc bc
    ld [$FA0A], sp
    inc hl
    ret
    db $C7, $DF, $53, $E9, $57
    dw Func_085_53C3
    dw Func_085_53A2
    dw Func_085_5361
    dw Func_085_533C

Func_085_533C:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [$CB7D], a
    ldh a, [$FF90]
    cp a, $96
    jr nz, Jump_085_534B
    ld de, $0201
    jr Jump_085_5358

Jump_085_534B::
    ld de, $00B9
    ldh a, [$FF8F]
    or a, a
    jr z, Jump_085_5358
    inc de
    dec a
    jr z, Jump_085_5358
    inc de

Jump_085_5358::
    call Func_000_1845
    ld a, $80
    ld [$C919], a
    ret

Func_085_5361:: ; heuristic: target of a pointer table; C0
    ld a, $E0
    ld [$C928], a
    xor a, a
    ld [$C929], a
    ldh a, [$FF90]
    cp a, $96
    jr z, Jump_085_5389
    ld a, $02
    ld [$C92A], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5389::
    ld a, $03
    ld [$C92A], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    xor a, a
    ld [$CB86], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_53A2:: ; heuristic: target of a pointer table; C0
    ld a, $20
    ldh [$FFC7], a
    ldh a, [$FF90]
    cp a, $96
    jr nz, Jump_085_53B0
    ld a, $40
    ldh [$FFC7], a

Jump_085_53B0::
    xor a, a
    ldh [$FFC6], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    ld a, $05
    ld [$C923], a
    ret

Func_085_53C3:: ; heuristic: target of a pointer table; C0
    ld a, [$C922]
    cp a, $01
    jr nz, Jump_085_53D0
    ld a, $04
    ld [$C923], a
    ret

Jump_085_53D0::
    ld a, $1B
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Func_085_53DF:: ; heuristic: follows a terminator; C0
    ld hl, $C923
    inc [hl]
    ldh a, [$FF93]
    bit 7, a
    jr z, Jump_085_53ED
    and a, $01
    jr z, Jump_085_53F9

Jump_085_53ED::
    ld a, $00
    ld [$C922], a
    ld hl, $0473
    call Func_085_57C8
    ret

Jump_085_53F9::
    ldh a, [$FF95]
    cp a, $00
    jr nz, Jump_085_53ED
    ldh a, [$FF94]
    cp a, $D6
    jr nz, Jump_085_5411
    ld a, $01
    ld [$C922], a
    ld hl, $0475
    call Func_085_57C8
    ret

Jump_085_5411::
    cp a, $EC
    jr nz, Jump_085_53ED
    ld a, $02
    ld [$C922], a
    ld hl, $0474
    call Func_085_57C8
    ret

Func_085_5421::
    ld a, [$C923]
    rst $00
    dw Jump_085_542B
    dw Jump_085_57E9
    dw Jump_085_5441

Jump_085_542B::
    ld hl, $C923
    inc [hl]
    ldh a, [$FF90]
    cp a, $43
    jr z, Jump_085_543A
    ld hl, $C923
    inc [hl]
    ret

Jump_085_543A::
    ld hl, $085D
    call Func_085_57C8
    ret

Jump_085_5441::
    ldh a, [$FF90]
    cp a, $37
    jr nz, Jump_085_544B
    ld a, $10
    jr Jump_085_5455

Jump_085_544B::
    cp a, $42
    jr nz, Jump_085_5453
    ld a, $60
    jr Jump_085_5455

Jump_085_5453::
    ld a, $30

Jump_085_5455::
    ldh [$FFC7], a
    ld a, $00
    ldh [$FFC6], a
    ld hl, $6BF8
    ld b, $5F
    rst $10
    ldh a, [$FFC6]
    or a, a
    ret z
    xor a, a
    ld [$CB7D], a
    ld a, $80
    ld [$C919], a
    ret

Func_085_546F::
    ld a, [$C923]
    rst $00
    dw Jump_085_55D0
    dw Jump_085_55C7
    dw Jump_085_57E9
    dw Jump_085_5581
    dw Jump_085_5562
    dw Jump_085_554F
    dw Jump_085_5514
    dw Jump_085_57E9
    dw Jump_085_5485

Jump_085_5485::
    ld a, $01
    ld [$C929], a
    ld b, $03
    ld hl, $CB9A

Jump_085_548F::
    push bc
    push hl
    ld a, [hl]
    cp a, $50
    jr z, Jump_085_54A8
    ld a, $01
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    jr Jump_085_54B8

Jump_085_54A8::
    ld a, $00
    ld [$C92A], a
    ld a, $B0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10

Jump_085_54B8::
    ld hl, $C929
    inc [hl]
    pop hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_085_54C4
    inc h

Jump_085_54C4::
    pop bc
    dec b
    jr nz, Jump_085_548F
    ld a, [$CBBA]
    cp a, $50
    jr nz, Jump_085_54D4
    ld a, $01
    ld [$C921], a

Jump_085_54D4::
    ld a, [$C921]
    or a, a
    ret z
    ld a, [$CBCA]
    cp a, $50
    jr z, Jump_085_54F1
    ld a, $03
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ret

Jump_085_54F1::
    ld a, $00
    ld [$C92A], a
    ld a, $B0
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld a, $01
    ld [$CB7D], a
    xor a, a
    ldh [$FF8D], a
    ld a, $80
    ld [$C919], a
    ret

Jump_085_5514::
    ld a, $02
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld a, $01
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $03
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, $04
    ld [$C929], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $0186
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_554F::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $3C
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5562::
    ld a, $02
    ld [$C929], a
    ld a, $02
    ld [$C92A], a
    ld a, $40
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5581::
    ld a, [$C921]
    and a, $0F
    jr nz, Jump_085_55A9
    call Func_000_09F3
    ld a, [$CD03]
    and a, $03
    inc a
    swap a
    ld hl, $CB86
    add a, l
    ld l, a
    jr nc, Jump_085_559B
    inc h

Jump_085_559B::
    push hl
    call Func_000_095B
    ld a, [$C5E8]
    and a, $01
    sla a
    inc a
    pop hl
    ld [hl], a

Jump_085_55A9::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $F0
    ret nz
    ld a, $02
    ld [$CB96], a
    ld [$CBA6], a
    ld [$CBB6], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_55C7::
    ld a, $0E
    ldh [$FF8D], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_55D0::
    ld a, $26
    ldh [$FF90], a
    xor a, a
    ldh [$FF8F], a
    ldh [$FF92], a
    ld a, $60
    ld [$C8C8], a
    ld a, $20
    ld [$C8C9], a
    ld a, $01
    ld [$C8C6], a
    ld hl, $6C5A
    ld b, $5F
    rst $10
    ld hl, $0185
    call Func_085_57C8
    ret

Func_085_55F5::
    ld a, [$C923]
    rst $00
    dw Jump_085_566F
    dw Jump_085_566F
    dw Jump_085_5664
    dw Jump_085_57E9
    dw Jump_085_5647
    dw Jump_085_561E
    dw Jump_085_5607

Jump_085_5607::
    ld a, [$CB9B]
    dec a
    dec a
    ld [$CB9B], a
    cp a, $10
    ret nz
    ld hl, $CB9C
    call Func_085_5765
    ld a, $80
    ld [$C919], a
    ret

Jump_085_561E::
    xor a, a
    ld [$C929], a
    ld a, $82
    ld [$C92A], a
    ld a, $50
    ld [$C928], a
    ld hl, $6B54
    ld b, $5F
    rst $10
    ld a, [$C92C]
    or a, a
    ret z
    ld hl, $CB9C
    call Func_085_5760
    ld a, $63
    call Func_000_1278
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5647::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $01
    ret z
    ld a, [$CB8B]
    inc a
    ld [$CB8B], a
    cp a, $60
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_085_5664::
    ld hl, $0172
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_566F::
    ld de, $CB8B
    call Func_085_5780
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_085_567B::
    ld a, [$C923]
    rst $00
    dw Jump_085_571A
    dw Jump_085_57E9
    dw Jump_085_56FF
    dw Jump_085_57E9
    dw Jump_085_5689

Jump_085_5689::
    ld a, [$C921]
    or a, a
    jr nz, Jump_085_5694
    ld a, $65
    call Func_000_1278

Jump_085_5694::
    ld a, [$C922]
    or a, a
    jr nz, Jump_085_56A4
    ld a, [$CBD3]
    dec a
    dec a
    ld [$CBD3], a
    jr Jump_085_56B3

Jump_085_56A4::
    ld a, [$C921]
    ld hl, $56DF
    add a, l
    ld l, a
    jr nc, Jump_085_56AF
    inc h

Jump_085_56AF::
    ld a, [hl]
    ld [$CBD3], a

Jump_085_56B3::
    ld a, [$CBD4]
    inc a
    ld [$CBD4], a
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$CBCF], a
    ld a, $80
    ld [$C919], a
    ret
    db $42, $45, $47, $4A, $4C, $4F, $51, $54, $56, $59, $5B, $5E, $60, $63, $65, $68
    db $6A, $6D, $6F, $72, $74, $77, $79, $7C, $7E, $81, $83, $86, $88, $8B, $8D, $90

Jump_085_56FF::
    ld a, $80
    ld [$CBCF], a
    ld hl, $CBD4
    dec [hl]
    ld de, $CBD4
    call Func_085_5780
    ret nc
    ld hl, $0084
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ret

Jump_085_571A::
    ld a, $02
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $40
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld hl, $0083
    call Func_085_57C8
    ld hl, $C923
    inc [hl]
    ldh a, [$FF8E]
    or a, a
    jr nz, Jump_085_574E
    ld a, $01
    ldh [$FF98], a
    ld [$C8EF], a
    ld a, $03
    ld [$CB86], a
    xor a, a
    ld [$C922], a
    ret

Jump_085_574E::
    ld a, $03
    ldh [$FF98], a
    ld [$C8EF], a
    ld a, $01
    ld [$CB86], a
    ld a, $01
    ld [$C922], a
    ret

Func_085_5760:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

Func_085_5765:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

Func_085_576A:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

Func_085_576F:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

Func_085_5774:: ; heuristic: follows a terminator; C0
    ld a, [$C921]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

Func_085_5780::
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    cp a, $20
    jr z, Jump_085_579C
    sub a, a
    ret

Jump_085_579C::
    xor a, a
    ld [$C921], a
    scf
    ret

Func_085_57A2:: ; heuristic: follows a terminator; C0
    push hl
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$C921]
    inc a
    ld [$C921], a
    pop hl
    cp a, $20
    ret nz
    call Func_085_57C8
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_57C8::
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret

Func_085_57D5::
    ld [$C928], a
    ld hl, $6936
    ld b, $5F
    rst $10
    ld a, [$C926]
    cp a, $FF
    jr z, Jump_085_57E7
    sub a, a
    ret

Jump_085_57E7::
    scf
    ret

Jump_085_57E9::
    xor a, a
    call Func_085_57D5
    ret nc
    ld hl, $C923
    inc [hl]
    ret

Func_085_57F3:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_085_57D5
    ret nc
    ld a, $80
    ld [$C919], a
    ret

Func_085_57FE:: ; heuristic: follows a terminator; C0
    ld a, [$C6FD]
    or a, a
    jr nz, Jump_085_5808

Jump_085_5804::
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_5808::
    ld b, a
    ld a, $0A
    ld [$0100], a
    ld hl, $C6FE

Jump_085_5811::
    push bc
    ld a, [hl]
    ld c, $6F
    call Func_000_1F80
    pop bc
    ldh a, [$FFC6]
    cp a, $C0
    jr c, Jump_085_582D
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    pop bc
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_085_5837

Jump_085_582D::
    inc hl
    dec b
    jr nz, Jump_085_5811
    xor a, a
    ld [$0100], a
    jr Jump_085_5804

Jump_085_5837::
    xor a, a
    ld [$0100], a
    ld a, $01
    ldh [$FFC6], a
    ret

Func_085_5840::
    ld a, [$C6FD]
    or a, a
    jr nz, Jump_085_584E

Jump_085_5846::
    xor a, a
    ld [$0100], a
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_584E::
    ld b, a
    ld a, $0A
    ld [$0100], a
    ld hl, $C6FE

Jump_085_5857::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    pop bc
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_085_5875
    push bc
    ld a, [hl]
    ld c, $6B
    call Func_000_1F89
    pop bc
    ldh a, [$FFC6]
    ld c, a
    ldh a, [$FFC7]
    or a, c
    jr nz, Jump_085_5846

Jump_085_5875::
    inc hl
    dec b
    jr nz, Jump_085_5857
    xor a, a
    ld [$0100], a
    ld a, $01
    ldh [$FFC6], a
    ret

Func_085_5882::
    ldh a, [$FF93]
    bit 7, a
    jr z, Jump_085_58B3
    and a, $01
    jr nz, Jump_085_58B3
    ld de, $5912
    ldh a, [$FF94]
    ld l, a
    ldh a, [$FF95]
    ld h, a

Jump_085_5895::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_58B2
    ld a, [de]
    cp a, l
    jr nz, Jump_085_58AD
    inc de
    ld a, [de]
    cp a, h
    jr nz, Jump_085_58AD
    pop de
    ld a, $01
    ldh [$FFC6], a
    ret

Jump_085_58AD::
    pop de
    inc de
    inc de
    jr Jump_085_5895

Jump_085_58B2::
    pop de

Jump_085_58B3::
    ld a, [$C6FD]
    or a, a
    jr nz, Jump_085_58BD
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_58BD::
    ld b, a
    ld a, $0A
    ld [$0100], a
    ld hl, $C6FE

Jump_085_58C6::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    pop bc
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_085_58FD
    push bc
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    pop bc
    ld de, $5912

Jump_085_58DF::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_58FC
    ldh a, [$FFC6]
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_085_58F7
    inc de
    ldh a, [$FFC7]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_085_5909

Jump_085_58F7::
    pop de
    inc de
    inc de
    jr Jump_085_58DF

Jump_085_58FC::
    pop de

Jump_085_58FD::
    inc hl
    dec b
    jr nz, Jump_085_58C6
    xor a, a
    ld [$0100], a
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_5909::
    pop de
    ld a, [$C6FD]
    sub a, b
    inc a
    ldh [$FFC6], a
    ret
    db $09, $00, $0E, $00, $11, $00, $12, $00, $16, $00, $18, $00, $19, $00, $2B, $00
    db $38, $00, $40, $00, $41, $00, $94, $00, $C6, $00, $EC, $00, $01, $01, $05, $01
    db $19, $01, $1B, $01, $1F, $01, $20, $01, $24, $01, $26, $01, $27, $01, $29, $01
    db $2A, $01, $2F, $01, $30, $01, $35, $01, $37, $01, $00, $00

Func_085_594E::
    ld de, $0000
    call Func_000_181B
    jr c, Jump_085_598C
    ldh a, [$FF93]
    bit 7, a
    jr z, Jump_085_5960
    and a, $01
    jr z, Jump_085_5964

Jump_085_5960::
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_5964::
    ld de, $5991
    ldh a, [$FF94]
    ld l, a
    ldh a, [$FF95]
    ld h, a

Jump_085_596D::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr nz, Jump_085_597B
    pop de
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_597B::
    ld a, [de]
    cp a, l
    jr nz, Jump_085_5987
    inc de
    ld a, [de]
    cp a, h
    jr nz, Jump_085_5987
    pop de
    jr Jump_085_598C

Jump_085_5987::
    pop de
    inc de
    inc de
    jr Jump_085_596D

Jump_085_598C::
    ld a, $02
    ldh [$FFC6], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $215991, $43
    dw Data_085_5A00
    dw Data_085_5B00
    dw Data_085_6500
    dw Data_085_6A00
    dw Data_085_6D00
    dw Data_085_6F00
    dw Data_085_7000
    dw Data_085_7100
    dw Data_085_7300
    dw Data_085_7400
    dw Data_085_7600
    db $00, $84, $00, $8D, $00, $8E, $00, $91, $00, $92, $00, $93, $00, $94, $00, $95
    db $00, $96, $00, $97, $00, $99

Data_085_5A00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $215A00, $75

Func_085_5A75::
    ldh a, [$FF93]
    bit 7, a
    jr z, Jump_085_5A7F
    and a, $01
    jr z, Jump_085_5A83

Jump_085_5A7F::
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_5A83::
    ldh a, [$FF95]
    cp a, $00
    jr nz, Jump_085_5A91
    ldh a, [$FF94]
    cp a, $F6
    jr c, Jump_085_5A7F
    jr Jump_085_5A98

Jump_085_5A91::
    dec a
    jr nz, Jump_085_5A7F
    cp a, $11
    jr nc, Jump_085_5A7F

Jump_085_5A98::
    ld a, $01
    ldh [$FFC7], a
    ret

Func_085_5A9D:: ; heuristic: follows a terminator; C0
    ld a, [$C6FD]
    or a, a
    ret z
    ld b, a
    ld a, $0A
    ld [$0100], a
    ld hl, $C6FE

Jump_085_5AAB::
    push bc
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    pop bc
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_085_5AE2
    push bc
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    pop bc
    ld de, $5AF8

Jump_085_5AC4::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_5AE1
    ldh a, [$FFC6]
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_085_5ADC
    inc de
    ldh a, [$FFC7]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_085_5AEE

Jump_085_5ADC::
    pop de
    inc de
    inc de
    jr Jump_085_5AC4

Jump_085_5AE1::
    pop de

Jump_085_5AE2::
    inc hl
    dec b
    jr nz, Jump_085_5AAB
    xor a, a
    ld [$0100], a
    xor a, a
    ldh [$FFC6], a
    ret

Jump_085_5AEE::
    pop de
    xor a, a
    ld [$0100], a
    ld a, $01
    ldh [$FFC6], a
    ret
    db $61, $01, $64, $01, $67, $01, $69, $01

Data_085_5B00:: ; heuristic: target of a monotone pointer table; C0
    db $74, $01, $00, $00

Func_085_5B04::
    ld hl, $5AC0
    ld b, $16
    rst $10
    ld hl, $0000
    ld de, $D09D
    ld b, $0B

Jump_085_5B12::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_085_5B18
    inc h

Jump_085_5B18::
    inc de
    dec b
    jr nz, Jump_085_5B12
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ret

Func_085_5B23:: ; heuristic: follows a terminator; C0
    ldh a, [$FFC6]
    ld c, a
    ld hl, $C707
    ld b, $20

Jump_085_5B2B::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_085_5B4E
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_085_5B45
    pop hl
    ld a, [hl]
    and a, $3F
    cp a, c
    jr nz, Jump_085_5B46
    ld a, $01
    ldh [$FFC6], a
    ret

Jump_085_5B45::
    pop hl

Jump_085_5B46::
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_085_5B2B
    ret

Jump_085_5B4E::
    pop hl
    xor a, a
    ldh [$FFC6], a
    ret

Func_085_5B53::
    ldh a, [$FF90]
    cp a, $0B
    ret nz
    ld a, [$C94A]
    bit 7, a
    jr nz, Jump_085_5B67
    ld a, [$D7FF]
    or a, a
    jr z, Jump_085_5BA9
    jr Jump_085_5B6B

Jump_085_5B67::
    and a, $03
    jr z, Jump_085_5BA9

Jump_085_5B6B::
    ld a, $50
    ld [$CB8A], a
    ld [$CB9A], a
    ld [$CBAA], a
    ld [$CBBA], a
    ld a, $00
    ld [$CB8B], a
    ld a, $F0
    ld [$CB9B], a
    ld a, $E0
    ld [$CBAB], a
    ld a, $D0
    ld [$CBBB], a
    xor a, a
    ld [$CB86], a
    ld [$CB96], a
    ld [$CBA6], a
    ld [$CBB6], a
    ld a, $30
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    xor a, a
    ld [$CB7D], a

Jump_085_5BA9::
    ld a, [$C94A]
    bit 7, a
    jr nz, Jump_085_5BD0
    ld a, [$C82C]
    add a, a
    add a, a
    ld hl, $5C5E
    add a, l
    ld l, a
    jr nc, Jump_085_5BBD
    inc h

Jump_085_5BBD::
    ld a, [$D7FF]
    add a, l
    ld l, a
    jr nc, Jump_085_5BC5
    inc h

Jump_085_5BC5::
    ld a, [hl]
    ld [$CB81], a
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    jr Jump_085_5BE9

Jump_085_5BD0::
    call Func_000_09F3
    ld a, [$CD04]
    and a, $1F
    ld hl, $5C72
    add a, l
    ld l, a
    jr nc, Jump_085_5BE0
    inc h

Jump_085_5BE0::
    ld a, [hl]
    ld [$CB81], a
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a

Jump_085_5BE9::
    ld a, $01
    ldh [$FFC8], a
    ld a, $04
    ldh [$FFC9], a
    ld hl, $8400
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    ld hl, $431F
    ld b, $04
    rst $10
    ld b, $00
    ld de, $CFDD
    ld hl, $8500

Jump_085_5C08::
    push hl
    push de
    push bc
    ld a, b
    add a, $05
    ldh [$FFC9], a
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    ld a, [de]
    ld [$CFE6], a
    inc de
    ld a, [de]
    ld [$CFE7], a
    ld a, $02
    ldh [$FFC6], a
    ld de, $FFC6
    ld c, $00
    ld hl, $4008
    ld b, $34
    rst $10
    pop bc
    push bc
    ld a, b
    swap a
    ld hl, $CB91
    add a, l
    ld l, a
    jr nc, Jump_085_5C3B
    inc h

Jump_085_5C3B::
    ldh a, [$FFC6]
    ld [hl+], a
    ldh a, [$FFC7]
    ld [hl], a
    xor a, a
    ldh [$FFC8], a
    ld hl, $431F
    ld b, $04
    rst $10
    pop bc
    pop de
    pop hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    inc de
    inc de
    inc b
    ld a, b
    cp a, $03
    jr nz, Jump_085_5C08
    ret
    db $06, $19, $18, $00, $15, $09, $16, $00, $14, $1E, $2A, $00, $0D, $2B, $12, $00
    db $28, $11, $20, $00, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $10, $11, $12, $13
    db $14, $15, $16, $1A, $1B, $1C, $1D, $21, $24, $25, $26, $28, $29, $2A, $2E, $2F
    db $33, $38, $39, $3D

Func_085_5C92::
    ld a, [$C8FE]
    cp a, $FF
    jr nz, Jump_085_5CB4
    ld a, [$C935]
    bit 7, a
    jr nz, Jump_085_5CB4
    ld a, [$C634]
    cp a, $FF
    jr z, Jump_085_5CAA
    or a, a
    jr nz, Jump_085_5CB4

Jump_085_5CAA::
    call Func_000_09F3
    ld a, [$C5E7]
    and a, $1F
    jr z, Jump_085_5CBE

Jump_085_5CB4::
    xor a, a
    ld [$C956], a
    ld a, $80
    ld [$C919], a
    ret

Jump_085_5CBE::
    ld a, [$C195]
    swap a
    and a, $0F
    dec a
    jr nz, Jump_085_5CFC
    call Func_085_5D6F
    cp a, $05
    jr nc, Jump_085_5CD8
    ld a, $80
    ld [$C956], a
    ld a, $2C
    jr Jump_085_5D41

Jump_085_5CD8::
    ld hl, $4001
    ld b, $61
    rst $10
    call Func_000_09F3
    ld a, [$CD04]
    and a, $1F
    sub a, $10
    ld c, a
    ld a, [$CD05]
    add a, c
    bit 7, a
    jr z, Jump_085_5CF3
    ld a, $01

Jump_085_5CF3::
    or a, $80
    ld [$C956], a
    ld a, $2C
    jr Jump_085_5D41

Jump_085_5CFC::
    push af
    ld a, $80
    ld [$C956], a
    call Func_085_5D6F
    cp a, $32
    jr nc, Jump_085_5D0D
    ld a, $00
    jr Jump_085_5D2F

Jump_085_5D0D::
    cp a, $46
    jr nc, Jump_085_5D15
    ld a, $01
    jr Jump_085_5D2F

Jump_085_5D15::
    cp a, $50
    jr nc, Jump_085_5D1D
    ld a, $02
    jr Jump_085_5D2F

Jump_085_5D1D::
    cp a, $5A
    jr nc, Jump_085_5D25
    ld a, $03
    jr Jump_085_5D2F

Jump_085_5D25::
    cp a, $5F
    jr nc, Jump_085_5D2D
    ld a, $04
    jr Jump_085_5D2F

Jump_085_5D2D::
    ld a, $05

Jump_085_5D2F::
    ld c, a
    pop af
    dec a
    and a, $01
    add a, a
    add a, a
    add a, a
    add a, c
    ld hl, $5D7C
    add a, l
    ld l, a
    jr nc, Jump_085_5D40
    inc h

Jump_085_5D40::
    ld a, [hl]

Jump_085_5D41::
    ld [$C922], a
    ld hl, $5D8C
    add a, l
    ld l, a
    jr nc, Jump_085_5D4C
    inc h

Jump_085_5D4C::
    ld a, [hl]
    or a, a
    jp z, Jump_085_5CB4
    ld [$C8FE], a
    ld hl, $7179
    ld b, $12
    rst $10
    ld a, [$C924]
    ld [$C8FF], a
    ld a, [$C925]
    ld [$C900], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_085_5D6F::
    call Func_000_09F3
    ld a, [$CD03]
    and a, $7F
    cp a, $63
    jr nc, Func_085_5D6F
    ret
    db $19, $1A, $1B, $1B, $1C, $2C, $00, $00, $01, $07, $28, $22, $0C, $2C, $00, $00
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0A, $06, $00, $01

Func_085_5DB9::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    ld b, a
    ld hl, $C6FE

Jump_085_5DC5::
    push hl
    ld a, [hl]
    ld c, $69
    call Func_000_1FD1
    push hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, $0064
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, d
    cp a, $03
    jr c, Jump_085_5DE7
    jr nz, Jump_085_5DE4
    ld a, e
    cp a, $E7
    jr c, Jump_085_5DE7

Jump_085_5DE4::
    ld de, $03E7

Jump_085_5DE7::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_085_5DC5
    xor a, a
    ld [$0100], a
    ret

Func_085_5DF5:: ; heuristic: follows a terminator; C0
    ld a, c
    ld de, $5E11
    or a, a
    jr z, Jump_085_5E05
    ld de, $5E41
    dec a
    jr z, Jump_085_5E05
    ld de, $5E71

Jump_085_5E05::
    ld b, $30
    ld hl, $C7CC

Jump_085_5E0A::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_085_5E0A
    ret
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $3F
    ds $21, $00
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $FF, $FF
    db $1F, $E0, $FF, $FF, $FF, $00, $FF, $FF, $FF, $03, $F8, $FF, $FF, $FF, $C1
    ds $11, $00
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $FF, $FF
    db $1F, $E0, $FF, $FF, $FF, $00, $FF, $FF, $FF, $03, $F8, $FF, $FF, $FF, $C1, $FF
    db $FF, $FF, $01, $FE, $FF, $FF, $FF, $F1, $FF, $FF, $FF, $8F, $FF, $FF, $1F
    ds $284, $00

Data_085_6124:: ; heuristic: target of a monotone pointer table; C0
    ds $2F, $00

Data_085_6153:: ; heuristic: target of a monotone pointer table; C0
    ds $41, $00

Data_085_6194:: ; heuristic: target of a monotone pointer table; C0
    ds $3B, $00

Data_085_61CF:: ; heuristic: target of a monotone pointer table; C0
    ds $39, $00

Data_085_6208:: ; heuristic: target of a monotone pointer table; C0
    ds $34, $00

Data_085_623C:: ; heuristic: target of a monotone pointer table; C0
    ds $2A, $00

Data_085_6266:: ; heuristic: target of a monotone pointer table; C0
    ds $29A, $00

Data_085_6500:: ; heuristic: target of a monotone pointer table; C0
    ds $500, $00

Data_085_6A00:: ; heuristic: target of a monotone pointer table; C0
    ds $300, $00

Data_085_6D00:: ; heuristic: target of a monotone pointer table; C0
    ds $200, $00

Data_085_6F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_085_7000:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_085_7100:: ; heuristic: target of a monotone pointer table; C0
    ds $200, $00

Data_085_7300:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_085_7400:: ; heuristic: target of a monotone pointer table; C0
    ds $200, $00

Data_085_7600:: ; heuristic: target of a monotone pointer table; C0
    ds $A00, $00
