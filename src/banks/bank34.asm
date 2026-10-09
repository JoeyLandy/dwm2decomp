SECTION "Bank 34", ROMX[$4000], BANK[$34]
    db $34

Func_034_4001::
    ld de, $CFEC
    call Func_034_4040
    ret

Func_034_4008::
    ld a, [$CFE7]
    cp a, $02
    jr c, Jump_034_401D
    ld a, [$CFE6]
    cp a, $50
    jr c, Jump_034_401D
    ld hl, Func_034_4001
    ld b, $A2
    rst $10
    ret

Jump_034_401D::
    push de
    push bc
    ld a, [$CFE6]
    ld c, a
    ld a, [$CFE7]
    ld b, a
    ld a, $1A
    call Func_000_16AA
    ld a, l
    add a, $75
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop bc
    ld b, $00
    add hl, bc
    ldh a, [$FFC6]
    ld b, a
    pop de
    call Func_034_406E
    ret

Func_034_4040::
    ld a, [$CFE7]
    cp a, $02
    jr c, Jump_034_4055
    ld a, [$CFE6]
    cp a, $50
    jr c, Jump_034_4055
    ld hl, $402D
    ld b, $A2
    rst $10
    ret

Jump_034_4055::
    push de
    ld a, [$CFE6]
    ld c, a
    ld a, [$CFE7]
    ld b, a
    ld a, $1A
    call Func_000_16AA
    ld a, l
    add a, $75
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop de
    ld b, $1A

Func_034_406E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Func_034_406E
    ret
    db $00, $00, $FF, $FF, $FF, $FF
    ds $14, $00
    INCBIN "dwm2-cobi-us.gbc", $0D008F, $3C06
    ds $36B, $00
