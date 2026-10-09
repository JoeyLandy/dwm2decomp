SECTION "Bank 5F", ROMX[$4000], BANK[$5F]
    INCBIN "dwm2-cobi-us.gbc", $17C000, $2936

Func_05F_6936::
    ld a, [$C926]
    cp a, $FF
    jr nz, Jump_05F_693E
    ret

Jump_05F_693E::
    rst $00
    dw Jump_05F_6947
    dw Jump_05F_698D
    dw Jump_05F_69A2
    dw Jump_05F_69D2

Jump_05F_6947::
    ld a, [$C928]
    or a, a
    jr nz, Jump_05F_6953
    ld hl, $4470
    ld b, $04
    rst $10

Jump_05F_6953::
    ld a, [$C925]
    bit 7, a
    jr nz, Jump_05F_6988
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
    jr c, Jump_05F_6988
    ld a, $81
    ld [$C8CB], a
    ld a, $01
    ldh [$FFB9], a

Jump_05F_6988::
    ld hl, $C926
    inc [hl]
    ret

Jump_05F_698D::
    ld a, [$C925]
    bit 7, a
    jr nz, Jump_05F_699A
    ld a, [$C8CB]
    and a, $03
    ret nz

Jump_05F_699A::
    call Func_05F_69F3
    ld hl, $C926
    inc [hl]
    ret

Jump_05F_69A2::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld a, [$C925]
    bit 6, a
    jr nz, Jump_05F_69CD
    ld a, $69
    call Func_000_1278
    ld a, $02
    ld [$C8CB], a
    ld a, $00
    ld [$C8CC], a
    ld a, $00
    ldh [$FFB9], a
    ldh a, [$FF91]
    cp a, $48
    jr c, Jump_05F_69CD
    ld a, $82
    ld [$C8CB], a

Jump_05F_69CD::
    ld hl, $C926
    inc [hl]
    ret

Jump_05F_69D2::
    ld a, [$C925]
    bit 6, a
    jr nz, Jump_05F_69E1
    ld a, [$C8CB]
    and a, $03
    jr z, Jump_05F_69E1
    ret

Jump_05F_69E1::
    ld a, [$C928]
    or a, a
    jr nz, Jump_05F_69ED
    ld hl, $449F
    ld b, $04
    rst $10

Jump_05F_69ED::
    ld a, $FF
    ld [$C926], a
    ret

Func_05F_69F3::
    ld a, [$C924]
    ld l, a
    ld a, [$C925]
    ld h, a

Func_05F_69FB::
    ld a, [$CC44]
    cp a, $80
    jr z, Jump_05F_6A07
    bit 7, a
    jp nz, Jump_05F_6A85

Jump_05F_6A07::
    ld a, h
    and a, $3F
    ld h, a
    ld a, l
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld a, h
    rst $00
    dw Jump_05F_6A31
    dw Jump_05F_6A38
    dw Jump_05F_6A3F
    dw Jump_05F_6A46
    dw Jump_05F_6A4D
    dw Jump_05F_6A54
    dw Jump_05F_6A5B
    dw Jump_05F_6A5B
    dw Jump_05F_6A62
    dw Jump_05F_6A69
    dw Jump_05F_6A69
    dw Jump_05F_6A70
    dw Jump_05F_6A77
    dw Jump_05F_6A7E

Jump_05F_6A31::
    ld hl, $4001
    ld b, $28
    rst $10
    ret

Jump_05F_6A38::
    ld hl, $4001
    ld b, $29
    rst $10
    ret

Jump_05F_6A3F::
    ld hl, $4001
    ld b, $2A
    rst $10
    ret

Jump_05F_6A46::
    ld hl, $4001
    ld b, $2B
    rst $10
    ret

Jump_05F_6A4D::
    ld hl, $4001
    ld b, $2C
    rst $10
    ret

Jump_05F_6A54::
    ld hl, $4001
    ld b, $2D
    rst $10
    ret

Jump_05F_6A5B::
    ld hl, $4001
    ld b, $2E
    rst $10
    ret

Jump_05F_6A62::
    ld hl, $4001
    ld b, $7C
    rst $10
    ret

Jump_05F_6A69::
    ld hl, $4001
    ld b, $80
    rst $10
    ret

Jump_05F_6A70::
    ld hl, $4001
    ld b, $82
    rst $10
    ret

Jump_05F_6A77::
    ld hl, $4001
    ld b, $86
    rst $10
    ret

Jump_05F_6A7E::
    ld hl, $4001
    ld b, $89
    rst $10
    ret

Jump_05F_6A85::
    ld a, l
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $4001
    ld b, $28
    rst $10
    ret

Func_05F_6A94:: ; heuristic: follows a terminator; C0
    ldh a, [$FF8C]
    or a, $04
    ldh [$FF8C], a
    xor a, a
    ldh [$FF98], a
    ldh a, [$FF91]
    call Func_05F_6B43
    ld a, [$C928]
    ld c, a
    ldh a, [$FF91]
    inc a
    ldh [$FF91], a
    cp a, c
    jr z, Jump_05F_6AB3
    xor a, a
    ld [$C92C], a
    ret

Jump_05F_6AB3::
    ldh a, [$FF8C]
    and a, $FB
    ldh [$FF8C], a
    ld a, $01
    ld [$C92C], a
    ret

Func_05F_6ABF:: ; heuristic: follows a terminator; C0
    ldh a, [$FF8C]
    or a, $04
    ldh [$FF8C], a
    ld a, $01
    ldh [$FF98], a
    ldh a, [$FF8E]
    call Func_05F_6B43
    ld a, [$C928]
    ld c, a
    ldh a, [$FF8E]
    inc a
    ldh [$FF8E], a
    cp a, c
    jr z, Jump_05F_6ADF
    xor a, a
    ld [$C92C], a
    ret

Jump_05F_6ADF::
    ldh a, [$FF8C]
    and a, $FB
    ldh [$FF8C], a
    ld a, $01
    ld [$C92C], a
    ret

Func_05F_6AEB:: ; heuristic: follows a terminator; C0
    ldh a, [$FF8C]
    or a, $04
    ldh [$FF8C], a
    ld a, $02
    ldh [$FF98], a
    ldh a, [$FF91]
    call Func_05F_6B43
    ld a, [$C928]
    ld c, a
    ldh a, [$FF91]
    dec a
    ldh [$FF91], a
    cp a, c
    jr z, Jump_05F_6B0B
    xor a, a
    ld [$C92C], a
    ret

Jump_05F_6B0B::
    ldh a, [$FF8C]
    and a, $FB
    ldh [$FF8C], a
    ld a, $01
    ld [$C92C], a
    ret

Func_05F_6B17:: ; heuristic: follows a terminator; C0
    ldh a, [$FF8C]
    or a, $04
    ldh [$FF8C], a
    ld a, $03
    ldh [$FF98], a
    ldh a, [$FF8E]
    call Func_05F_6B43
    ld a, [$C928]
    ld c, a
    ldh a, [$FF8E]
    dec a
    ldh [$FF8E], a
    cp a, c
    jr z, Jump_05F_6B37
    xor a, a
    ld [$C92C], a
    ret

Jump_05F_6B37::
    ldh a, [$FF8C]
    and a, $FB
    ldh [$FF8C], a
    ld a, $01
    ld [$C92C], a
    ret

Func_05F_6B43::
    and a, $0F
    jr nz, Jump_05F_6B4D
    ld hl, $5923
    ld b, $02
    rst $10

Jump_05F_6B4D::
    ld hl, $5946
    ld b, $02
    rst $10
    ret

Func_05F_6B54:: ; heuristic: follows a terminator; C0
    ld a, [$C929]
    swap a
    ld hl, $CB8C
    add a, l
    ld l, a
    jr nc, Jump_05F_6B61
    inc h

Jump_05F_6B61::
    ld a, [hl]
    or a, $04
    ld [hl], a
    push hl
    push hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld a, [$C92A]
    ld b, a
    and a, $03
    jr nz, Jump_05F_6B83
    ld [hl], $00
    pop hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, Jump_05F_6B80
    inc a

Jump_05F_6B80::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6B83::
    dec a
    jr nz, Jump_05F_6B95
    ld [hl], $01
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, Jump_05F_6B92
    inc a

Jump_05F_6B92::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6B95::
    dec a
    jr nz, Jump_05F_6BA6
    ld [hl], $02
    pop hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, Jump_05F_6BA3
    dec a

Jump_05F_6BA3::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6BA6::
    ld [hl], $03
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, Jump_05F_6BB2
    dec a

Jump_05F_6BB2::
    ld [hl], a

Jump_05F_6BB3::
    push af
    ld a, [$C928]
    ld c, a
    pop af
    cp a, c
    jr z, Jump_05F_6BC2
    xor a, a
    ld [$C92C], a
    pop hl
    ret

Jump_05F_6BC2::
    pop hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ld a, $01
    ld [$C92C], a
    ret

Func_05F_6BCD::
    ld a, [$C928]
    ld e, a
    ld a, [$C929]
    ld d, a
    ld a, [$C921]
    srl a
    ld hl, $6BE8
    add a, l
    ld l, a
    jr nc, Jump_05F_6BE2
    inc h

Jump_05F_6BE2::
    ld a, [hl]
    ld c, a
    ld a, [de]
    add a, c
    ld [de], a
    ret

Func_05F_6BE8:: ; heuristic: follows a terminator; C0
    cp a, $FF
    rst $38
    nop
    rst $38
    nop
    rst $38
    nop
    nop
    ld bc, $0100
    nop
    ld bc, $0201

Func_05F_6BF8::
    ld a, [$C921]
    cp a, $1E
    jr nc, Jump_05F_6C05
    bit 3, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C05::
    cp a, $3C
    jr nc, Jump_05F_6C0F
    bit 2, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C0F::
    bit 1, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C15::
    ldh a, [$FFC6]
    swap a
    ld hl, $CB8B
    add a, l
    ld l, a
    jr nc, Jump_05F_6C21
    inc h

Jump_05F_6C21::
    ldh a, [$FFC7]
    ld [hl], a
    jr Jump_05F_6C34

Jump_05F_6C26::
    ldh a, [$FFC6]
    swap a
    ld hl, $CB8B
    add a, l
    ld l, a
    jr nc, Jump_05F_6C32
    inc h

Jump_05F_6C32::
    ld [hl], $E0

Jump_05F_6C34::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    jr z, Jump_05F_6C43
    xor a, a
    ldh [$FFC6], a
    ret

Jump_05F_6C43::
    ldh a, [$FFC6]
    swap a
    ld hl, $CB8B
    add a, l
    ld l, a
    jr nc, Jump_05F_6C4F
    inc h

Jump_05F_6C4F::
    ld [hl], $E0
    xor a, a
    ld [$C921], a
    ld a, $01
    ldh [$FFC6], a
    ret

Func_05F_6C5A:: ; heuristic: follows a terminator; C0
    ld a, $0F
    call Func_000_0DF2
    ld a, $04
    ld [$C5DC], a
    xor a, a
    ld [$C8C5], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Func_05F_6C71:: ; heuristic: follows a terminator; C0
    ld a, $03
    ld [$C5DC], a
    xor a, a
    ld [$C904], a
    ld a, $02
    ld [$C8C7], a
    ld hl, $5EEE
    ld b, $02
    rst $10
    ld hl, $476E
    ld b, $0A
    rst $10
    ret

Func_05F_6C8C::
    push hl
    ld hl, $C61D

Jump_05F_6C90::
    ld a, [hl]
    or a, a
    jr z, Jump_05F_6C9B
    cp a, $FF
    jr z, Jump_05F_6C9B
    inc hl
    jr Jump_05F_6C90

Jump_05F_6C9B::
    ld a, [$C928]
    ld [hl], a
    pop hl
    ld a, [$C836]
    set 6, a
    ld [$C836], a
    ret

Func_05F_6CA9::
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    or a, a
    jr z, Jump_05F_6CC8
    ld b, a
    ld hl, $C6FE

Jump_05F_6CB8::
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    ldh a, [$FFC6]
    bit 7, a
    jr nz, Jump_05F_6CD1
    inc hl
    dec b
    jr nz, Jump_05F_6CB8

Jump_05F_6CC8::
    xor a, a
    ld [$C92C], a
    xor a, a
    ld [$0100], a
    ret

Jump_05F_6CD1::
    ld a, $01
    ld [$C92C], a
    xor a, a
    ld [$0100], a
    ret

Func_05F_6CDB:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    or a, a
    jr z, Jump_05F_6CFA
    ld b, a
    ld hl, $C6FE

Jump_05F_6CEA::
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    ldh a, [$FFC6]
    bit 2, a
    jr nz, Jump_05F_6D03
    inc hl
    dec b
    jr nz, Jump_05F_6CEA

Jump_05F_6CFA::
    xor a, a
    ld [$C92C], a
    xor a, a
    ld [$0100], a
    ret

Jump_05F_6D03::
    ld a, $01
    ld [$C92C], a
    xor a, a
    ld [$0100], a
    ret

Func_05F_6D0D:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    or a, a
    jr z, Jump_05F_6D2C
    ld b, a
    ld hl, $C6FE

Jump_05F_6D1C::
    ld a, [hl]
    ld c, $55
    call Func_000_1F80
    ldh a, [$FFC6]
    bit 0, a
    jr nz, Jump_05F_6D35
    inc hl
    dec b
    jr nz, Jump_05F_6D1C

Jump_05F_6D2C::
    xor a, a
    ld [$C92C], a
    xor a, a
    ld [$0100], a
    ret

Jump_05F_6D35::
    ld a, $01
    ld [$C92C], a
    xor a, a
    ld [$0100], a
    ret

Func_05F_6D3F:: ; heuristic: follows a terminator; C0
    ld hl, $7D95
    ld b, $12
    rst $10
    ldh a, [$FF8D]
    or a, $0E
    ldh [$FF8D], a
    ldh a, [$FFC6]
    ld hl, $C6FE
    add a, l
    ld l, a
    jr nc, Jump_05F_6D55
    inc h

Jump_05F_6D55::
    ld a, [hl]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, $7E96
    ld b, $14
    rst $10
    call Func_000_222B
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ldh a, [$FF8D]
    and a, $F1
    ldh [$FF8D], a
    ret

Func_05F_6D78::
    ld a, $FF
    ld [$D7F1], a
    ld a, $01
    ld [$D7F2], a
    ld hl, $7E96
    ld b, $14
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret z
    ld a, [$C7C7]
    and a, $03
    ld hl, $6DA8
    add a, l
    ld l, a
    jr nc, Jump_05F_6D9B
    inc h

Jump_05F_6D9B::
    ld a, [hl]
    ld c, a
    ld a, [$D7F5]
    cp a, c
    ret c
    ld a, $FF
    ld [$D7F5], a
    ret

Func_05F_6DA8:: ; heuristic: follows a terminator; C0
    ld a, [bc]
    inc d
    ld e, $1E

Func_05F_6DAC::
    ldh a, [$FFC6]
    ld c, a
    ld hl, $C707

Jump_05F_6DB2::
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_05F_6DCF
    cp a, $FF
    jr nz, Jump_05F_6DBE
    pop hl
    ret

Jump_05F_6DBE::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_05F_6DCF
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $3F
    cp a, c
    jr z, Jump_05F_6DD6

Jump_05F_6DCF::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_05F_6DB2

Jump_05F_6DD6::
    set 6, a
    ld [hl], a
    pop hl
    ret

Func_05F_6DDB::
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
    jr nc, Jump_05F_6E03
    inc d

Jump_05F_6E03::
    ld l, e
    ld h, d
    call Func_000_1E29
    ret

Func_05F_6E09::
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
    push de
    ldh a, [$FFA1]
    sub a, $08
    call Func_05F_6E35
    pop de
    ldh a, [$FFA1]
    add a, $A0
    call Func_05F_6E35
    ret

Func_05F_6E35::
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_05F_6E40
    inc d

Jump_05F_6E40::
    ld l, e
    ld h, d
    ld b, $12

Jump_05F_6E44::
    ld a, $C4
    call Func_000_1211
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_05F_6E50
    inc h

Jump_05F_6E50::
    ld a, h
    and a, $9B
    ld h, a
    dec b
    jr nz, Jump_05F_6E44
    ret

Func_05F_6E58::
    ld a, [$C92D]
    rst $00
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E97
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E93
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E8F
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E7E
    dw Jump_05F_6EEE
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6EE3

Jump_05F_6E7E::
    xor a, a
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_6E8F::
    ld a, $02
    jr Jump_05F_6E99

Jump_05F_6E93::
    ld a, $01
    jr Jump_05F_6E99

Jump_05F_6E97::
    ld a, $03

Jump_05F_6E99::
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8C]
    and a, $FD
    ldh [$FF8C], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $40
    ret nz
    ldh a, [$FF8C]
    or a, $02
    ldh [$FF8C], a
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Func_05F_6EC3::
    ld a, [$C92D]
    rst $00
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_701C
    dw Jump_05F_6FE7
    dw Jump_05F_6F6B
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6F46
    dw Jump_05F_7009
    dw Jump_05F_6EEE
    dw Jump_05F_6F46
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6EE3

Jump_05F_6EE3::
    ldh a, [$FF8C]
    and a, $FD
    ldh [$FF8C], a
    ld hl, $C923
    inc [hl]
    ret

Jump_05F_6EEE::
    ld de, $FF91
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld de, $C8F1
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld de, $C8F6
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld de, $C8FB
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
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_6F46::
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $03
    ret nz
    ldh a, [$FF98]
    inc a
    and a, $03
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    or a, a
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_6F6B::
    ld a, [$C921]
    and a, $07
    jr nz, Jump_05F_6F8C
    ldh a, [$FF98]
    dec a
    and a, $03
    ldh [$FF98], a
    bit 0, a
    jr z, Jump_05F_6F81
    inc a
    inc a
    and a, $03

Jump_05F_6F81::
    ld [$C8EF], a
    ld hl, $C8F0
    dec [hl]
    ld hl, $FF8E
    inc [hl]

Jump_05F_6F8C::
    ld a, [$C921]
    and a, $03
    jr nz, Jump_05F_6FDC
    ld a, [$C921]
    srl a
    srl a
    ld c, a
    ld a, $1F
    sub a, c
    sla a
    ld hl, $7092
    add a, l
    ld l, a
    jr nc, Jump_05F_6FA8
    inc h

Jump_05F_6FA8::
    ld a, [hl+]
    ld c, a
    ld a, [$C8FA]
    add a, c
    ld [$C8FA], a
    ld a, [$C8F5]
    sub a, c
    ld [$C8F5], a
    ld a, [hl]
    ld c, a
    ld a, [$C8FB]
    add a, c
    ld [$C8FB], a
    ld a, [$C8F6]
    sub a, c
    ld [$C8F6], a
    ld a, [$C921]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_6FDC
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_6FDC::
    ldh a, [$FF8C]
    or a, $02
    ldh [$FF8C], a
    ld hl, $C921
    inc [hl]
    ret

Jump_05F_6FE7::
    ld de, $C8F6
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld de, $C8FB
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10

Jump_05F_7009::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_701C::
    ld a, [$C921]
    and a, $07
    jr nz, Jump_05F_703D
    ldh a, [$FF98]
    inc a
    and a, $03
    ldh [$FF98], a
    bit 0, a
    jr z, Jump_05F_7032
    inc a
    inc a
    and a, $03

Jump_05F_7032::
    ld [$C8EF], a
    ld hl, $C8F0
    inc [hl]
    ld hl, $FF8E
    dec [hl]

Jump_05F_703D::
    ld hl, $7092
    call Func_05F_7044
    ret

Func_05F_7044::
    ld a, [$C921]
    and a, $03
    jr nz, Jump_05F_708D
    ld a, [$C921]
    srl a
    srl a
    sla a
    add a, l
    ld l, a
    jr nc, Jump_05F_7059
    inc h

Jump_05F_7059::
    ld a, [hl+]
    ld c, a
    ld a, [$C8F5]
    add a, c
    ld [$C8F5], a
    ld a, [$C8FA]
    sub a, c
    ld [$C8FA], a
    ld a, [hl]
    ld c, a
    ld a, [$C8F6]
    add a, c
    ld [$C8F6], a
    ld a, [$C8FB]
    sub a, c
    ld [$C8FB], a
    ld a, [$C921]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_708D
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_708D::
    ld hl, $C921
    inc [hl]
    ret
    db $FE, $00, $FF, $00, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $00, $FF, $00, $FE
    db $00, $FE, $00, $FF, $01, $FE, $01, $FF, $01, $FF, $02, $FF, $01, $00, $02, $00
    db $02, $00, $01, $00, $02, $01, $01, $01, $01, $01, $01, $02, $00, $01, $00, $02
    db $00, $02, $00, $01, $FF, $02, $FF, $01, $FF, $01, $FE, $01, $FF, $00, $FE, $00

Func_05F_70D2::
    ld a, [$C92D]
    rst $00
    dw Jump_05F_7345
    dw Jump_05F_72E4
    dw Jump_05F_72B3
    dw Jump_05F_7280
    dw Jump_05F_7195
    dw Jump_05F_7172
    dw Jump_05F_7138
    dw Jump_05F_70E6

Jump_05F_70E6::
    ld a, $01
    ld [$C8EF], a
    ld a, [$C8F0]
    inc a
    ld [$C8F0], a
    ld a, [$C921]
    and a, $01
    jr nz, Jump_05F_7105
    ld a, $02
    ld [$C8F4], a
    ld a, [$C8F6]
    dec a
    ld [$C8F6], a

Jump_05F_7105::
    ld hl, $C921
    inc [hl]
    ld a, $03
    ld [$C8F9], a
    ld a, [$C8FA]
    dec a
    ld [$C8FA], a
    ldh a, [$FF8E]
    ld c, a
    ld a, [$C8FA]
    cp a, c
    ret nz
    xor a, a
    ldh [$FF98], a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8C]
    and a, $FB
    ldh [$FF8C], a
    xor a, a
    ld [$C921], a
    ld hl, $C923
    inc [hl]
    ret

Jump_05F_7138::
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$CBD4]
    inc a
    ld [$CBD4], a
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$CBCF], a
    ldh a, [$FF8C]
    and a, $FD
    ldh [$FF8C], a
    ld a, $02
    ldh [$FF98], a
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_7172::
    ldh a, [$FF8C]
    or a, $02
    ldh [$FF8C], a
    xor a, a
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $3C
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_7195::
    ld a, [$C931]
    ld l, a
    ld a, [$C932]
    ld h, a
    dec hl
    ld a, l
    ld [$C931], a
    ld a, h
    ld [$C932], a
    ld a, l
    or a, h
    jr nz, Jump_05F_71B2
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]

Jump_05F_71B2::
    ld b, $03
    ld hl, $C8EF
    ld de, $C92E

Jump_05F_71BA::
    push hl
    push de
    ld a, [de]
    or a, a
    jr nz, Jump_05F_71D4
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [$FF91]
    add a, $10
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $01
    ld [de], a
    jr Jump_05F_7231

Jump_05F_71D4::
    dec a
    jr nz, Jump_05F_71F4
    ld a, [$C5F0]
    srl a
    srl a
    srl a
    and a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [$FF8E]
    add a, $20
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $02
    ld [de], a
    jr Jump_05F_7231

Jump_05F_71F4::
    dec a
    jr nz, Jump_05F_720A
    ld a, $02
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [$FF91]
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $03
    ld [de], a
    jr Jump_05F_7231

Jump_05F_720A::
    ld a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [$FF8E]
    sub a, $20
    cp a, c
    jr nz, Jump_05F_721B
    xor a, a
    ld [de], a

Jump_05F_721B::
    ldh a, [$FF8E]
    sub a, $20
    ld c, a
    ld a, [hl]
    sub a, c
    ld de, $7240
    add a, e
    ld e, a
    jr nc, Jump_05F_722A
    inc d

Jump_05F_722A::
    ld a, [de]
    ld c, a
    ldh a, [$FF91]
    sub a, c
    inc hl
    ld [hl], a

Jump_05F_7231::
    pop de
    inc de
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_05F_723B
    inc h

Jump_05F_723B::
    dec b
    jp nz, Jump_05F_71BA
    ret
    ds $11, $00
    db $01, $05, $08, $0A, $0C, $0D, $0E, $0E, $0F, $0F, $10, $10, $10, $11, $11, $11
    db $11, $10, $10, $10, $0F, $0F, $0E, $0E, $0D, $0C, $0A, $08, $05, $01
    ds $11, $00

Jump_05F_7280::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $78
    ret nz
    xor a, a
    ld [$C921], a
    ldh a, [$FF8C]
    or a, $04
    ldh [$FF8C], a
    ld a, $00
    ld [$C92E], a
    ld a, $01
    ld [$C92F], a
    ld a, $03
    ld [$C930], a
    ld hl, $0320
    ld a, l
    ld [$C931], a
    ld a, h
    ld [$C932], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_72B3::
    ld a, $80
    ld [$CBCF], a
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    ld hl, $6BCD
    ld b, $5F
    rst $10
    ld a, [$CBD4]
    dec a
    ld [$CBD4], a
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_72E4::
    ld a, $03
    ld [$C8EF], a
    ld a, [$C8F0]
    dec a
    ld [$C8F0], a
    ld a, [$C921]
    and a, $01
    jr nz, Jump_05F_7303
    ld a, $00
    ld [$C8F4], a
    ld a, [$C8F6]
    inc a
    ld [$C8F6], a

Jump_05F_7303::
    ld hl, $C921
    inc [hl]
    ld a, $01
    ld [$C8F9], a
    ld a, [$C8FA]
    inc a
    ld [$C8FA], a
    ldh a, [$FF8E]
    ld c, a
    ld a, [$C8FA]
    sub a, c
    cp a, $20
    ret nz
    xor a, a
    ldh [$FF98], a
    ld [$C8EF], a
    inc a
    ld [$C8F4], a
    ld a, $03
    ld [$C8F9], a
    ld a, $0B
    ldh [$FFC6], a
    ld hl, $6B98
    ld b, $12
    rst $10
    ldh a, [$FF8C]
    or a, $02
    ldh [$FF8C], a
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_7345::
    ldh a, [$FF8C]
    or a, $04
    ldh [$FF8C], a
    ldh a, [$FF8E]
    call Func_05F_6B43
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $3C
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Func_05F_7363::
    ld a, [$C92D]
    rst $00
    dw Jump_05F_7700
    dw Jump_05F_76D6
    dw Jump_05F_766C
    dw Jump_05F_7631
    dw Jump_05F_7617
    dw Jump_05F_75EC
    dw Jump_05F_75D2
    dw Jump_05F_7593
    dw Jump_05F_7554
    dw Jump_05F_753A
    dw Jump_05F_750C
    dw Jump_05F_74CD
    dw Jump_05F_746F
    dw Jump_05F_743D
    dw Jump_05F_742F
    dw Jump_05F_73B2
    dw Jump_05F_753A
    dw Jump_05F_738B

Jump_05F_738B::
    ld hl, $C923
    inc [hl]
    ret

Func_05F_7390:: ; heuristic: follows a terminator; C0
    ld a, [$C552]
    or a, a
    jr nz, Jump_05F_739E
    ld a, $06
    ld hl, $C92D
    inc [hl]
    jr Jump_05F_73A4

Jump_05F_739E::
    ld a, $07
    ld hl, $C92D
    dec [hl]

Jump_05F_73A4::
    call Func_05F_7761
    ret

Func_05F_73A8:: ; heuristic: follows a terminator; C0
    ld a, $05
    call Func_05F_7761
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_73B2::
    ld a, [$C921]
    or a, a
    jr nz, Jump_05F_73BD
    ld a, $65
    call Func_000_1278

Jump_05F_73BD::
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    call Func_05F_6BCD
    ld a, [$C921]
    and a, $01
    jr nz, Jump_05F_73D6
    ld hl, $CB8A
    inc [hl]

Jump_05F_73D6::
    ld a, [$C921]
    and a, $01
    jr nz, Jump_05F_73E6
    ld a, [$CB86]
    inc a
    and a, $03
    ld [$CB86], a

Jump_05F_73E6::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    jr z, Jump_05F_7402
    ld hl, $6B22
    ld b, $12
    rst $10
    ld a, $01
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ret

Jump_05F_7402::
    ld a, $72
    call Func_000_1278
    ld de, $7AD4
    ld b, $7D
    ld hl, $8500
    call Func_000_0CF5
    ld a, $49
    ld [$CB81], a
    xor a, a
    ld [$CB86], a
    ld a, $04
    call Func_05F_7761
    ld a, [$C933]
    ld [$C6FD], a
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_742F::
    xor a, a
    call Func_05F_77C7
    ret nc
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_743D::
    ld hl, $6B22
    ld b, $12
    rst $10
    ld a, $01
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    call Func_05F_6BCD
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, $03
    call Func_05F_7761
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_746F::
    ld hl, $6B22
    ld b, $12
    rst $10
    ld a, $01
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld a, [$C922]
    add a, $01
    ld [$C922], a
    sra a
    sra a
    sra a
    sra a
    ld c, a
    ld a, [$C921]
    add a, c
    ld [$C921], a
    cp a, $18
    jr c, Jump_05F_74A5
    xor a, a
    ld [$C921], a
    xor a, a
    ld [$CBCF], a
    jr Jump_05F_74AA

Jump_05F_74A5::
    ld a, $80
    ld [$CBCF], a

Jump_05F_74AA::
    ld a, [$C922]
    sra a
    sra a
    sra a
    sra a
    cp a, $30
    ret c
    xor a, a
    ld [$CBCF], a
    ld a, $30
    ld [$CBD4], a
    xor a, a
    ld [$C921], a
    ld [$C922], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_74CD::
    ld hl, $6B22
    ld b, $12
    rst $10
    ld a, $01
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    call Func_05F_6BCD
    ld a, [$C921]
    bit 0, a
    jr nz, Jump_05F_74F6
    ld hl, $CBD4
    inc [hl]

Jump_05F_74F6::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$C921], a
    ld [$C922], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_750C::
    call Func_000_095B
    ld a, [$C5E7]
    and a, $03
    jr z, Jump_05F_750C
    dec a
    dec a
    add a, $40
    ld [$CBD3], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $B4
    ret nz
    ld a, $40
    ld [$CBD3], a
    ld a, $72
    call Func_000_1278
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_753A::
    xor a, a
    call Func_05F_77C7
    ret nc
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ld de, $00D1
    call Func_000_181B
    ret nc
    ld a, $11
    ld [$C92D], a
    ret

Jump_05F_7554::
    ld hl, $6B22
    ld b, $12
    rst $10
    ld a, $01
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    call Func_05F_6BCD
    ld hl, $CBD3
    dec [hl]
    ld hl, $CBD4
    inc [hl]
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, $02
    call Func_05F_7761
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_7593::
    ld hl, $6B22
    ld b, $12
    rst $10
    ld a, $01
    ldh [$FFC6], a
    ld hl, $6B33
    ld b, $12
    rst $10
    ld de, $CB8B
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    call Func_05F_6BCD
    ld a, [$C921]
    inc a
    ld [$C921], a
    and a, $01
    jr nz, Jump_05F_75C3
    ld a, [$CB8A]
    dec a
    ld [$CB8A], a

Jump_05F_75C3::
    ld a, [$C921]
    cp a, $20
    ret nz
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_75D2::
    xor a, a
    call Func_05F_77C7
    ret nc
    ld de, $41E1
    ld b, $7D
    ld hl, $8500
    call Func_000_0CF5
    ld a, $02
    ld [$CB81], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_75EC::
    ld de, $CBD4
    ld a, e
    ld [$C928], a
    ld a, d
    ld [$C929], a
    call Func_05F_6BCD
    ld hl, $CBD4
    dec [hl]
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    ld a, $01
    call Func_05F_7761
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_7617::
    xor a, a
    call Func_05F_77C7
    ret nc
    ld a, $80
    ld [$CBCF], a
    ld a, [$C6FD]
    ld [$C933], a
    ld a, $01
    ld [$C6FD], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_7631::
    ld a, [$C921]
    or a, a
    jr nz, Jump_05F_7646
    inc a
    ld [$C921], a
    ld a, $0E
    ldh [$FF8D], a
    ld hl, $64F8
    ld b, $12
    rst $10
    ret

Jump_05F_7646::
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
    xor a, a
    ldh [$FF8D], a
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_766C::
    ld a, [$C921]
    srl a
    srl a
    and a, $01
    jr z, Jump_05F_7697
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_05F_76BE
    ld hl, $C0F0
    ld de, $C49F
    ld bc, $0040
    call Func_000_0952
    jr Jump_05F_76B9

Jump_05F_7697::
    ld hl, $C5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [$C525]
    or a, a
    jr z, Jump_05F_76BE
    ld b, $40
    ld hl, $C0F0
    ld de, $C49F

Jump_05F_76B1::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_05F_76B1

Jump_05F_76B9::
    ld a, $7F
    ld [$C526], a

Jump_05F_76BE::
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $1E
    ret nz
    ld a, $00
    call Func_05F_7761
    xor a, a
    ld [$C921], a
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_76D6::
    ld a, $03
    ldh [$FF98], a
    ld a, $01
    ld [$CB86], a
    xor a, a
    call Func_05F_77C7
    ret nc
    ld a, [$C525]
    or a, a
    jr z, Jump_05F_76F6
    ld hl, $C49F
    ld de, $C0F0
    ld bc, $0040
    call Func_000_0952

Jump_05F_76F6::
    ld a, $7A
    call Func_000_1278
    ld hl, $C92D
    inc [hl]
    ret

Jump_05F_7700::
    ld a, $01
    ldh [$FFC6], a
    ld hl, $6AD9
    ld b, $12
    rst $10
    ld de, $0021
    call Func_000_181B
    jr c, Jump_05F_771D
    ld a, $00
    ld [$C92E], a
    ld a, $03
    ldh [$FFC6], a
    jr Jump_05F_774C

Jump_05F_771D::
    ld de, $0022
    call Func_000_181B
    jr c, Jump_05F_7730
    ld a, $01
    ld [$C92E], a
    ld a, $08
    ldh [$FFC6], a
    jr Jump_05F_774C

Jump_05F_7730::
    ld de, $0023
    call Func_000_181B
    jr c, Jump_05F_7743
    ld a, $02
    ld [$C92E], a
    ld a, $0A
    ldh [$FFC6], a
    jr Jump_05F_774C

Jump_05F_7743::
    ld a, $03
    ld [$C92E], a
    ld a, $0F
    ldh [$FFC6], a

Jump_05F_774C::
    ld hl, $6B98
    ld b, $12
    rst $10
    ld a, $50
    ld [$CBD3], a
    ld a, $30
    ld [$CBD4], a
    ld hl, $C92D
    inc [hl]
    ret

Func_05F_7761::
    sla a
    ld de, $7787
    add a, e
    ld e, a
    jr nc, Jump_05F_776B
    inc d

Jump_05F_776B::
    ld a, [$C92E]
    swap a
    add a, e
    ld e, a
    jr nc, Jump_05F_7775
    inc d

Jump_05F_7775::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [$C924], a
    ld a, h
    ld [$C925], a
    xor a, a
    ld [$C926], a
    ret
    db $26, $01, $27, $01, $28, $01, $29, $01, $2A, $01, $00, $00, $00, $00, $00, $00
    db $A8, $02, $A9, $02, $AA, $02, $AB, $02, $AC, $02, $00, $00, $00, $00, $00, $00
    db $A8, $02, $E9, $02, $AA, $02, $AB, $02, $EC, $02, $00, $00, $00, $00, $00, $00
    db $34, $05, $35, $05, $36, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Func_05F_77C7::
    ld [$C928], a
    call Func_05F_6936
    ld a, [$C926]
    cp a, $FF
    jr z, Jump_05F_77D6
    sub a, a
    ret

Jump_05F_77D6::
    scf
    ret

Func_05F_77D8::
    ld c, $10
    ld a, [$C921]
    and a, $0F
    call Func_000_1682
    ld a, l
    add a, $7F
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a
    push hl
    ld a, $0D
    add a, l
    ld l, a
    jr nc, Jump_05F_77F2
    inc h

Jump_05F_77F2::
    ld a, [hl]
    or a, $04
    ld [hl], a
    dec hl
    dec hl
    ld a, [$C921]
    swap a
    and a, $0F
    jr z, Jump_05F_7809
    dec a
    jr z, Jump_05F_780F
    dec a
    jr z, Jump_05F_7814
    jr Jump_05F_781A

Jump_05F_7809::
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_780F::
    ld a, [hl]
    inc a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_7814::
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_781A::
    ld a, [hl]
    dec a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_781F::
    pop hl
    ld a, $07
    add a, l
    ld l, a
    jr nc, Jump_05F_7827
    inc h

Jump_05F_7827::
    ld a, [$C921]
    swap a
    and a, $0F
    ld [hl], a
    ld a, [$C923]
    inc a
    cp a, $10
    jr z, Jump_05F_783B
    ld [$C923], a
    ret

Jump_05F_783B::
    xor a, a
    ld [$C923], a
    ld a, [$C922]
    dec a
    ld [$C922], a
    ret nz
    ld a, $06
    add a, l
    ld l, a
    jr nc, Jump_05F_784E
    inc h

Jump_05F_784E::
    ld a, [hl]
    and a, $FB
    ld [hl], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_05F_785C::
    ld a, [$C921]
    ld l, a
    ld a, [$C922]
    ld h, a
    dec hl
    ld a, l
    ld [$C921], a
    ld a, h
    ld [$C922], a
    ld a, l
    or a, a
    ret nz
    cp a, h
    ret nz
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_05F_787C::
    xor a, a
    ld [$C55E], a
    ld [$C562], a
    ld a, [$C468]
    bit 7, a
    ret nz
    ldh a, [$FF8C]
    bit 0, a
    ret nz
    ld a, [$C922]
    or a, a
    jr nz, Jump_05F_789A
    ld a, $80
    ld [$C919], a
    ret

Jump_05F_789A::
    dec a
    ld [$C922], a
    ld a, [$C921]
    or a, a
    jr nz, Jump_05F_78AD
    ld a, [$C55E]
    set 7, a
    ld [$C55E], a
    ret

Jump_05F_78AD::
    dec a
    jr nz, Jump_05F_78B9
    ld a, [$C55E]
    set 4, a
    ld [$C55E], a
    ret

Jump_05F_78B9::
    dec a
    jr nz, Jump_05F_78C5
    ld a, [$C55E]
    set 6, a
    ld [$C55E], a
    ret

Jump_05F_78C5::
    ld a, [$C55E]
    set 5, a
    ld [$C55E], a
    ret

Func_05F_78CE::
    ld a, [$C921]
    bit 7, a
    jr nz, Jump_05F_78EE
    or a, a
    jr nz, Jump_05F_78DD
    ld hl, $FF98
    jr Jump_05F_78FD

Jump_05F_78DD::
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, $C8EF
    add a, l
    ld l, a
    jr nc, Jump_05F_78EC
    inc h

Jump_05F_78EC::
    jr Jump_05F_78FD

Jump_05F_78EE::
    and a, $7F
    ld c, $10
    call Func_000_1682
    ld a, l
    add a, $86
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a

Jump_05F_78FD::
    ld a, [$C922]
    ld [hl], a
    ld a, $80
    ld [$C919], a
    ret

Func_05F_7907:: ; heuristic: follows a terminator; C0
    ld a, [$C922]
    bit 7, a
    jr nz, Jump_05F_7927
    or a, a
    jr nz, Jump_05F_7916
    ld de, $FF91
    jr Jump_05F_7933

Jump_05F_7916::
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld de, $C8F1
    add a, e
    ld e, a
    jr nc, Jump_05F_7925
    inc d

Jump_05F_7925::
    jr Jump_05F_7933

Jump_05F_7927::
    and a, $7F
    swap a
    ld de, $CB8B
    add a, e
    ld e, a
    jr nc, Jump_05F_7933
    inc d

Jump_05F_7933::
    ld a, [$C921]
    srl a
    ld hl, $7959
    add a, l
    ld l, a
    jr nc, Jump_05F_7940
    inc h

Jump_05F_7940::
    ld a, [hl]
    ld c, a
    ld a, [de]
    add a, c
    ld [de], a
    ld a, [$C921]
    inc a
    ld [$C921], a
    cp a, $20
    ret nz
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret
    db $FE, $FF, $FF, $00, $FF, $00, $FF, $00, $00, $01, $00, $01, $00, $01, $01, $02

Func_05F_7969::
    ld a, [$C923]
    rst $00
    dw Jump_05F_7977
    dw Jump_05F_7A02
    dw Jump_05F_7A42
    dw Jump_05F_7A5D
    dw Jump_05F_7A8C

Jump_05F_7977::
    ld a, [$C921]
    cp a, $03
    jr z, Jump_05F_7987
    ld a, [$C922]
    ld de, $C152
    call Func_000_2431

Jump_05F_7987::
    ld hl, $C923
    inc [hl]
    ld a, [$C921]
    push af
    ld c, a
    add a, a
    add a, c
    add a, $A0
    ld [$C921], a
    ld a, [$C924]
    ld e, a
    ld a, [$C925]
    ld d, a
    call Func_000_181B
    jr nc, Jump_05F_79AE
    pop af
    ld hl, $C921
    inc [hl]
    xor a, a
    ld [$C922], a
    ret

Jump_05F_79AE::
    pop af
    cp a, $03
    jr z, Jump_05F_79F5
    ld a, [$C634]
    cp a, $FF
    jr z, Jump_05F_79BE
    cp a, $00
    jr nz, Jump_05F_79E8

Jump_05F_79BE::
    ld hl, $C61D

Jump_05F_79C1::
    ld a, [hl]
    or a, a
    jr z, Jump_05F_79CC
    cp a, $FF
    jr z, Jump_05F_79CC
    inc hl
    jr Jump_05F_79C1

Jump_05F_79CC::
    ld a, [$C922]
    ld [hl], a
    ld a, [$C836]
    set 6, a
    ld [$C836], a

Jump_05F_79D8::
    ld a, [$C924]
    ld e, a
    ld a, [$C925]
    ld d, a
    call Func_000_1845
    xor a, a
    ld [$C922], a
    ret

Jump_05F_79E8::
    ld a, [$C921]
    inc a
    inc a
    ld [$C921], a
    xor a, a
    ld [$C922], a
    ret

Jump_05F_79F5::
    ld hl, $689A
    ld b, $12
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_05F_79E8
    jr Jump_05F_79D8

Jump_05F_7A02::
    ld a, [$C922]
    bit 7, a
    jr nz, Jump_05F_7A3D
    ld hl, $4470
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
    jr c, Jump_05F_7A3D
    ld a, $81
    ld [$C8CB], a
    ld a, $01
    ldh [$FFB9], a

Jump_05F_7A3D::
    ld hl, $C923
    inc [hl]
    ret

Jump_05F_7A42::
    ld a, [$C922]
    bit 7, a
    jr nz, Jump_05F_7A4F
    ld a, [$C8CB]
    and a, $03
    ret nz

Jump_05F_7A4F::
    ld a, [$C921]
    ld l, a
    ld h, $00
    call Func_05F_69FB
    ld hl, $C923
    inc [hl]
    ret

Jump_05F_7A5D::
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld a, [$C922]
    bit 6, a
    jr nz, Jump_05F_7A87
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
    jr c, Jump_05F_7A87
    ld a, $82
    ld [$C8CB], a

Jump_05F_7A87::
    ld hl, $C923
    inc [hl]
    ret

Jump_05F_7A8C::
    ld a, [$C8CB]
    and a, $03
    ret nz
    ld hl, $43B8
    ld b, $84
    rst $10
    ld hl, $6DDB
    ld b, $5F
    rst $10
    ld hl, $449F
    ld b, $04
    rst $10
    xor a, a
    ld [$C920], a
    xor a, a
    ld [$C91F], a
    ld a, $00
    ld [$C5DC], a
    ret

Func_05F_7AB2:: ; heuristic: follows a terminator; C0
    ld a, [$C923]
    or a, a
    jr nz, Jump_05F_7AC8
    ld a, [$C921]
    ldh [$FFC6], a
    ld hl, $47A4
    ld b, $0A
    rst $10
    ld hl, $C923
    inc [hl]
    ret

Jump_05F_7AC8::
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$C921]
    rst $00
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B3B
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40

Jump_05F_7B3B::
    xor a, a
    ld [$CB7D], a
    ret

Jump_05F_7B40::
    ret
    ds $4BF, $00
