SECTION "Bank E1", ROMX[$4000], BANK[$E1]
    INCBIN "dwm2-cobi-us.gbc", $384000, $10E

Data_0E1_410E:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $38410E, $501

Data_0E1_460F:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $38460F, $3C3

Data_0E1_49D2:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $3849D2, $1055

Data_0E1_5A27:: ; heuristic: argument of a bank-switching copy helper; C0
    db $0F, $54, $FF, $7F, $1F, $13, $AA, $04, $0F, $54, $FF, $7F, $1F, $13, $D5, $09
    db $33, $05, $FF, $03, $BD, $21, $AA, $04, $33, $05, $FF, $7F, $1F, $13, $AA, $04
    db $33, $05, $FF, $7F, $BD, $21, $AA, $04, $36, $04, $FF, $7F, $1F, $13, $AA, $04
    db $36, $04, $FF, $7F, $1F, $13, $D5, $09, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F

Data_0E1_5A67:: ; heuristic: argument of a bank-switching copy helper; C0
    db $0F, $54, $FF, $7F, $1F, $13, $AA, $04, $0F, $54, $FF, $7F, $1F, $13, $D5, $09
    db $33, $05, $FF, $03, $BD, $21, $AA, $04, $33, $05, $FF, $7F, $1F, $13, $AA, $04
    db $33, $05, $FF, $7F, $BD, $21, $AA, $04, $36, $04, $FF, $7F, $1F, $13, $AA, $04
    db $36, $04, $FF, $7F, $1F, $13, $D5, $09, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F

Data_0E1_5AA7:: ; heuristic: argument of a bank-switching copy helper; C0
    db $20, $7C, $FF, $7F, $A8, $14, $00, $00, $20, $7C, $FF, $7F, $35, $04, $00, $00

Func_0E1_5AB7::
    ld de, Data_0E1_5ABE
    call Func_0E1_5AC0
    ret

Data_0E1_5ABE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $5D

Func_0E1_5AC0::
    ldh a, [$FFB1]
    cp a, $27
    ret nc
    ldh a, [$FFD4]
    ld c, a
    ldh a, [$FFD5]
    ld b, a
    ldh a, [$FFAB]
    add a, c
    ldh [$FFB3], a
    ldh a, [$FFAC]
    adc a, b
    ldh [$FFB4], a
    ldh a, [$FFD2]
    ld c, a
    ldh a, [$FFD3]
    ld b, a
    ld hl, $FFB5
    ldh a, [$FFA9]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [$FFAA]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [$FFAD]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [$FFAE]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ldh a, [$FFB1]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [$FFB9]
    or a, a
    jp nz, Jump_0E1_5C0A
    ldh a, [$FFAF]
    ld c, a
    ldh a, [$FFB0]
    and a, $20
    jr nz, Jump_0E1_5B92

Jump_0E1_5B1C::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_0E1_5B34
    ldh a, [$FFB3]
    add a, b
    ld b, a
    ldh a, [$FFB4]
    adc a, $00
    jr nz, Jump_0E1_5B43
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5B48
    jr Jump_0E1_5B43

Jump_0E1_5B34::
    ldh a, [$FFB3]
    add a, b
    ld b, a
    ldh a, [$FFB4]
    adc a, $FF
    jr nz, Jump_0E1_5B43
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5B48

Jump_0E1_5B43::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5B1C

Jump_0E1_5B48::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_0E1_5B61
    ldh a, [$FFB5]
    add a, b
    ld b, a
    ldh a, [$FFB6]
    adc a, $00
    jr nz, Jump_0E1_5B70
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5B77
    jr Jump_0E1_5B70

Jump_0E1_5B61::
    ldh a, [$FFB5]
    add a, b
    ld b, a
    ldh a, [$FFB6]
    adc a, $FF
    jr nz, Jump_0E1_5B70
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5B77

Jump_0E1_5B70::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5B1C

Jump_0E1_5B77::
    ld a, b
    ld [de], a
    inc e
    ldh a, [$FFAF]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [$FFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [$FFB1]
    inc a
    ldh [$FFB1], a
    cp a, $28
    jr nz, Jump_0E1_5B1C
    ret

Jump_0E1_5B92::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_0E1_5BAA
    ldh a, [$FFB3]
    add a, b
    ld b, a
    ldh a, [$FFB4]
    adc a, $00
    jr nz, Jump_0E1_5BB9
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5BBE
    jr Jump_0E1_5BB9

Jump_0E1_5BAA::
    ldh a, [$FFB3]
    add a, b
    ld b, a
    ldh a, [$FFB4]
    adc a, $FF
    jr nz, Jump_0E1_5BB9
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5BBE

Jump_0E1_5BB9::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5B92

Jump_0E1_5BBE::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_0E1_5BD9
    ldh a, [$FFB7]
    sub a, b
    ld b, a
    ldh a, [$FFB8]
    sbc a, $00
    jr z, Jump_0E1_5BEF
    jr nz, Jump_0E1_5BE8
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5BEF
    jr Jump_0E1_5BE8

Jump_0E1_5BD9::
    ldh a, [$FFB7]
    sub a, b
    ld b, a
    ldh a, [$FFB8]
    sbc a, $FF
    jr nz, Jump_0E1_5BE8
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5BEF

Jump_0E1_5BE8::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5B92

Jump_0E1_5BEF::
    ld a, b
    ld [de], a
    inc e
    ldh a, [$FFAF]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [$FFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [$FFB1]
    inc a
    ldh [$FFB1], a
    cp a, $28
    jr nz, Jump_0E1_5B92
    ret

Jump_0E1_5C0A::
    ldh a, [$FFB0]
    and a, $20
    jr nz, Jump_0E1_5C8B

Jump_0E1_5C10::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5C1B
    dec b

Jump_0E1_5C1B::
    ldh a, [$FFB3]
    add a, c
    ld c, a
    ldh a, [$FFB4]
    adc a, b
    jr nz, Jump_0E1_5C46
    ld a, c
    cp a, $B8
    jr nc, Jump_0E1_5C46
    ldh a, [$FFB9]
    or a, a
    jr z, Jump_0E1_5C4B
    cp a, $01
    jr nz, Jump_0E1_5C39
    ld a, c
    cp a, $34
    jr c, Jump_0E1_5C46
    jr Jump_0E1_5C4B

Jump_0E1_5C39::
    cp a, $02
    jr nz, Jump_0E1_5C44
    ld a, c
    cp a, $71
    jr c, Jump_0E1_5C4B
    jr Jump_0E1_5C46

Jump_0E1_5C44::
    jr Jump_0E1_5C4B

Jump_0E1_5C46::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5C10

Jump_0E1_5C4B::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5C56
    dec b

Jump_0E1_5C56::
    ldh a, [$FFB5]
    add a, c
    ld c, a
    ldh a, [$FFB6]
    adc a, b
    jr nz, Jump_0E1_5C64
    ld a, c
    cp a, $B8
    jr c, Jump_0E1_5C6B

Jump_0E1_5C64::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5C10

Jump_0E1_5C6B::
    ld a, c
    ld [de], a
    call Func_0E1_5D06
    jr nc, Jump_0E1_5C64
    inc e
    ldh a, [$FFAF]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [$FFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [$FFB1]
    inc a
    ldh [$FFB1], a
    cp a, $28
    jr nz, Jump_0E1_5C10
    ret

Jump_0E1_5C8B::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5C96
    dec b

Jump_0E1_5C96::
    ldh a, [$FFB3]
    add a, c
    ld c, a
    ldh a, [$FFB4]
    adc a, b
    jr nz, Jump_0E1_5CC1
    ld a, c
    cp a, $B8
    jr nc, Jump_0E1_5CC1
    ldh a, [$FFB9]
    or a, a
    jr z, Jump_0E1_5CC6
    cp a, $01
    jr nz, Jump_0E1_5CB4
    ld a, c
    cp a, $34
    jr c, Jump_0E1_5CC1
    jr Jump_0E1_5CC6

Jump_0E1_5CB4::
    cp a, $02
    jr nz, Jump_0E1_5CBF
    ld a, c
    cp a, $71
    jr c, Jump_0E1_5CC6
    jr Jump_0E1_5CC1

Jump_0E1_5CBF::
    jr Jump_0E1_5CC6

Jump_0E1_5CC1::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5C8B

Jump_0E1_5CC6::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5CD1
    dec b

Jump_0E1_5CD1::
    ldh a, [$FFB7]
    sub a, c
    ld c, a
    ldh a, [$FFB8]
    sbc a, b
    jr nz, Jump_0E1_5CDF
    ld a, c
    cp a, $B8
    jr c, Jump_0E1_5CE6

Jump_0E1_5CDF::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5C8B

Jump_0E1_5CE6::
    ld a, c
    ld [de], a
    call Func_0E1_5D06
    jr nc, Jump_0E1_5CDF
    inc e
    ldh a, [$FFAF]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [$FFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [$FFB1]
    inc a
    ldh [$FFB1], a
    cp a, $28
    jr nz, Jump_0E1_5C8B
    ret

Func_0E1_5D06::
    push hl
    push bc
    ldh a, [$FFA5]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add a, b
    sub a, $0C
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [$FFA1]
    ld b, a
    ld a, [de]
    add a, b
    sub a, $04
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld l, a
    ld a, h
    and a, $03
    adc a, $98
    ld h, a
    ldh a, [$FFBA]
    ld b, a
    di

Jump_0E1_5D30::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_0E1_5D30
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $385D3C, $1E1B
    ds $4A9, $00
