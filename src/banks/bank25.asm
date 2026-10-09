SECTION "Bank 25", ROMX[$4000], BANK[$25]
    db $25

; 6 call sites from 6 routines (e.g. Func_001_5EAF, Func_004_44CE, Func_004_4C96, Func_004_4D43, ...)
; reads: hFFAD, hFFB0
; writes: hFFB0
Func_025_4001::
    ldh a, [hFFAD]
    ld e, a
    ld d, $00
    ld hl, Data_025_411E
    add hl, de
    bit 0, [hl]
    jr z, Jump_025_4017
    ld a, [hl]
    and a, $F0
    ld e, a
    ldh a, [hFFB0]
    or a, e
    ldh [hFFB0], a

Jump_025_4017::
    ld de, Data_025_401E
    call Func_025_419E
    ret

Data_025_401E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_025_441A
    dw Data_025_441A
    dw Data_025_448C
    dw Data_025_44FE
    dw Data_025_4570
    dw Data_025_45E2
    dw Data_025_4654
    dw Data_025_46C6
    dw Data_025_4738
    dw Data_025_47AA
    dw Data_025_481C
    dw Data_025_4876
    dw Data_025_48E8
    dw Data_025_495A
    dw Data_025_49B8
    dw Data_025_4A2A
    dw Data_025_4A9C
    dw Data_025_4B0E
    dw Data_025_4B68
    dw Data_025_4BDA
    dw Data_025_4C4C
    dw Data_025_4CBE
    dw Data_025_4D30
    dw Data_025_4DA2
    dw Data_025_4E14
    dw Data_025_4E86
    dw Data_025_4EF8
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4F6A
    dw Data_025_4FDC
    dw Data_025_504E
    dw Data_025_50C0
    dw Data_025_5132
    dw Data_025_51A4
    dw Data_025_5216
    dw Data_025_5288
    dw Data_025_52FA
    dw Data_025_536C
    dw Data_025_53DE
    dw Data_025_5450
    dw Data_025_54C2
    dw Data_025_5534
    dw Data_025_55A6
    dw Data_025_5618
    dw Data_025_568A
    dw Data_025_56FC
    dw Data_025_576E
    dw Data_025_57E0
    dw Data_025_5852
    dw Data_025_58C4
    dw Data_025_5936
    dw Data_025_59A8
    dw Data_025_5A1A
    dw Data_025_5A8C
    dw Data_025_5AFE
    dw Data_025_5B70
    dw Data_025_5BDA
    dw Data_025_5C4C
    dw Data_025_5CBE
    dw Data_025_5D30
    dw Data_025_5D30
    dw Data_025_5D30
    dw Data_025_5D30
    dw Data_025_5D30
    dw Data_025_5DA2
    dw Data_025_5E14
    dw Data_025_5E86
    dw Data_025_5EF8
    dw Data_025_5F6A
    dw Data_025_5FDC
    dw Data_025_604E
    dw Data_025_60C0
    dw Data_025_6132
    dw Data_025_61A4
    dw Data_025_6216
    dw Data_025_6288
    dw Data_025_62FA
    dw Data_025_636C
    dw Data_025_63DE
    dw Data_025_6450
    dw Data_025_64C2
    dw Data_025_6534
    dw Data_025_65A6
    dw Data_025_6618
    dw Data_025_668A
    dw Data_025_66FC
    dw Data_025_676E
    dw Data_025_67E0
    dw Data_025_6852
    dw Data_025_68C4
    dw Data_025_6936
    dw Data_025_69A8
    dw Data_025_6A1A
    dw Data_025_6A8C
    dw Data_025_6AFE
    dw Data_025_6B70
    dw Data_025_6B70
    dw Data_025_6B70
    dw Data_025_6B70
    dw Data_025_6BE2
    dw Data_025_6C44
    dw Data_025_6CB6
    dw Data_025_6D28
    dw Data_025_6D9A
    dw Data_025_6E0C
    dw Data_025_6E7E
    dw Data_025_6EF0
    dw Data_025_6F62
    dw Data_025_6FD4
    dw Data_025_7042
    dw Data_025_70B4
    dw Data_025_7126
    dw Data_025_7198
    dw Data_025_720A
    dw Data_025_727C
    dw Data_025_72EE
    dw Data_025_7360
    dw Data_025_73D2
    dw Data_025_7444
    dw Data_025_74B6

Data_025_411E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $09411E, $80

; 1 call site from 1 routine (e.g. Func_025_4001)
; reads: hFFB1, hFFD4, hFFD5, hFFAB, hFFAC, hFFD2, hFFD3, hFFA9, ...
; writes: hFFB3, hFFB4, hFFB1
; points at: hFFB5
Func_025_419E::
    ldh a, [hFFB1]
    cp a, $27
    ret nc
    ldh a, [hFFD4]
    ld c, a
    ldh a, [hFFD5]
    ld b, a
    ldh a, [hFFAB]
    add a, c
    ldh [hFFB3], a
    ldh a, [hFFAC]
    adc a, b
    ldh [hFFB4], a
    ldh a, [hFFD2]
    ld c, a
    ldh a, [hFFD3]
    ld b, a
    ld hl, hFFB5
    ldh a, [hFFA9]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [hFFAA]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [hFFAD]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [hFFAE]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ldh a, [hFFB1]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [hFFB9]
    or a, a
    jp nz, Jump_025_42E8
    ldh a, [hFFAF]
    ld c, a
    ldh a, [hFFB0]
    and a, $20
    jr nz, Jump_025_4270

Jump_025_41FA::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_025_4212
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_025_4221
    ld a, b
    cp a, $A8
    jr c, Jump_025_4226
    jr Jump_025_4221

Jump_025_4212::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_025_4221
    ld a, b
    cp a, $A8
    jr c, Jump_025_4226

Jump_025_4221::
    inc hl
    inc hl
    inc hl
    jr Jump_025_41FA

Jump_025_4226::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_025_423F
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $00
    jr nz, Jump_025_424E
    ld a, b
    cp a, $B8
    jr c, Jump_025_4255
    jr Jump_025_424E

Jump_025_423F::
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $FF
    jr nz, Jump_025_424E
    ld a, b
    cp a, $B8
    jr c, Jump_025_4255

Jump_025_424E::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_025_41FA

Jump_025_4255::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hFFAF]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hFFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hFFB1]
    inc a
    ldh [hFFB1], a
    cp a, $28
    jr nz, Jump_025_41FA
    ret

Jump_025_4270::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_025_4288
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_025_4297
    ld a, b
    cp a, $A8
    jr c, Jump_025_429C
    jr Jump_025_4297

Jump_025_4288::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_025_4297
    ld a, b
    cp a, $A8
    jr c, Jump_025_429C

Jump_025_4297::
    inc hl
    inc hl
    inc hl
    jr Jump_025_4270

Jump_025_429C::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_025_42B7
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $00
    jr z, Jump_025_42CD
    jr nz, Jump_025_42C6
    ld a, b
    cp a, $B8
    jr c, Jump_025_42CD
    jr Jump_025_42C6

Jump_025_42B7::
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $FF
    jr nz, Jump_025_42C6
    ld a, b
    cp a, $B8
    jr c, Jump_025_42CD

Jump_025_42C6::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_025_4270

Jump_025_42CD::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hFFAF]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hFFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hFFB1]
    inc a
    ldh [hFFB1], a
    cp a, $28
    jr nz, Jump_025_4270
    ret

Jump_025_42E8::
    ldh a, [hFFB0]
    and a, $20
    jr nz, Jump_025_4369

Jump_025_42EE::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_025_42F9
    dec b

Jump_025_42F9::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_025_4324
    ld a, c
    cp a, $B8
    jr nc, Jump_025_4324
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_025_4329
    cp a, $01
    jr nz, Jump_025_4317
    ld a, c
    cp a, $34
    jr c, Jump_025_4324
    jr Jump_025_4329

Jump_025_4317::
    cp a, $02
    jr nz, Jump_025_4322
    ld a, c
    cp a, $71
    jr c, Jump_025_4329
    jr Jump_025_4324

Jump_025_4322::
    jr Jump_025_4329

Jump_025_4324::
    inc hl
    inc hl
    inc hl
    jr Jump_025_42EE

Jump_025_4329::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_025_4334
    dec b

Jump_025_4334::
    ldh a, [hFFB5]
    add a, c
    ld c, a
    ldh a, [hFFB6]
    adc a, b
    jr nz, Jump_025_4342
    ld a, c
    cp a, $B8
    jr c, Jump_025_4349

Jump_025_4342::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_025_42EE

Jump_025_4349::
    ld a, c
    ld [de], a
    call Func_025_43E4
    jr nc, Jump_025_4342
    inc e
    ldh a, [hFFAF]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hFFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hFFB1]
    inc a
    ldh [hFFB1], a
    cp a, $28
    jr nz, Jump_025_42EE
    ret

Jump_025_4369::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_025_4374
    dec b

Jump_025_4374::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_025_439F
    ld a, c
    cp a, $B8
    jr nc, Jump_025_439F
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_025_43A4
    cp a, $01
    jr nz, Jump_025_4392
    ld a, c
    cp a, $34
    jr c, Jump_025_439F
    jr Jump_025_43A4

Jump_025_4392::
    cp a, $02
    jr nz, Jump_025_439D
    ld a, c
    cp a, $71
    jr c, Jump_025_43A4
    jr Jump_025_439F

Jump_025_439D::
    jr Jump_025_43A4

Jump_025_439F::
    inc hl
    inc hl
    inc hl
    jr Jump_025_4369

Jump_025_43A4::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_025_43AF
    dec b

Jump_025_43AF::
    ldh a, [hFFB7]
    sub a, c
    ld c, a
    ldh a, [hFFB8]
    sbc a, b
    jr nz, Jump_025_43BD
    ld a, c
    cp a, $B8
    jr c, Jump_025_43C4

Jump_025_43BD::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_025_4369

Jump_025_43C4::
    ld a, c
    ld [de], a
    call Func_025_43E4
    jr nc, Jump_025_43BD
    inc e
    ldh a, [hFFAF]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hFFB0]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hFFB1]
    inc a
    ldh [hFFB1], a
    cp a, $28
    jr nz, Jump_025_4369
    ret

; 2 call sites from 1 routine (e.g. Func_025_419E)
; reads: hFFA5, hFFA1, hFFBA, rSTAT
Func_025_43E4::
    push hl
    push bc
    ldh a, [hFFA5]
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
    ldh a, [hFFA1]
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
    ldh a, [hFFBA]
    ld b, a
    di

Jump_025_440E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_025_440E
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

Data_025_441A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09441A, $72

Data_025_448C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09448C, $72

Data_025_44FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0944FE, $72

Data_025_4570:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094570, $72

Data_025_45E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0945E2, $72

Data_025_4654:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094654, $72

Data_025_46C6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0946C6, $72

Data_025_4738:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094738, $72

Data_025_47AA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0947AA, $72

Data_025_481C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09481C, $5A

Data_025_4876:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094876, $72

Data_025_48E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0948E8, $72

Data_025_495A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09495A, $5E

Data_025_49B8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0949B8, $72

Data_025_4A2A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094A2A, $72

Data_025_4A9C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094A9C, $72

Data_025_4B0E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094B0E, $5A

Data_025_4B68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094B68, $72

Data_025_4BDA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094BDA, $72

Data_025_4C4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094C4C, $72

Data_025_4CBE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094CBE, $72

Data_025_4D30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094D30, $72

Data_025_4DA2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094DA2, $72

Data_025_4E14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094E14, $72

Data_025_4E86:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094E86, $72

Data_025_4EF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094EF8, $72

Data_025_4F6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094F6A, $72

Data_025_4FDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $094FDC, $72

Data_025_504E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09504E, $72

Data_025_50C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0950C0, $72

Data_025_5132:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095132, $72

Data_025_51A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0951A4, $72

Data_025_5216:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095216, $72

Data_025_5288:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095288, $72

Data_025_52FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0952FA, $72

Data_025_536C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09536C, $72

Data_025_53DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0953DE, $72

Data_025_5450:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095450, $72

Data_025_54C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0954C2, $72

Data_025_5534:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095534, $72

Data_025_55A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0955A6, $72

Data_025_5618:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095618, $72

Data_025_568A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09568A, $72

Data_025_56FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0956FC, $72

Data_025_576E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09576E, $72

Data_025_57E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0957E0, $72

Data_025_5852:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095852, $72

Data_025_58C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0958C4, $72

Data_025_5936:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095936, $72

Data_025_59A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0959A8, $72

Data_025_5A1A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095A1A, $72

Data_025_5A8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095A8C, $72

Data_025_5AFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095AFE, $72

Data_025_5B70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095B70, $6A

Data_025_5BDA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095BDA, $72

Data_025_5C4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095C4C, $72

Data_025_5CBE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095CBE, $72

Data_025_5D30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095D30, $72

Data_025_5DA2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095DA2, $72

Data_025_5E14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095E14, $72

Data_025_5E86:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095E86, $72

Data_025_5EF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095EF8, $72

Data_025_5F6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095F6A, $72

Data_025_5FDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $095FDC, $72

Data_025_604E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09604E, $72

Data_025_60C0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0960C0, $72

Data_025_6132:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096132, $72

Data_025_61A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0961A4, $72

Data_025_6216:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096216, $72

Data_025_6288:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096288, $72

Data_025_62FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0962FA, $72

Data_025_636C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09636C, $72

Data_025_63DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0963DE, $72

Data_025_6450:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096450, $72

Data_025_64C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0964C2, $72

Data_025_6534:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096534, $72

Data_025_65A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0965A6, $72

Data_025_6618:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096618, $72

Data_025_668A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09668A, $72

Data_025_66FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0966FC, $72

Data_025_676E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09676E, $72

Data_025_67E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0967E0, $72

Data_025_6852:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096852, $72

Data_025_68C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0968C4, $72

Data_025_6936:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096936, $72

Data_025_69A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0969A8, $72

Data_025_6A1A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096A1A, $72

Data_025_6A8C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096A8C, $72

Data_025_6AFE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096AFE, $72

Data_025_6B70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096B70, $72

Data_025_6BE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096BE2, $62

Data_025_6C44:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096C44, $72

Data_025_6CB6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096CB6, $72

Data_025_6D28:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096D28, $72

Data_025_6D9A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096D9A, $72

Data_025_6E0C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096E0C, $72

Data_025_6E7E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096E7E, $72

Data_025_6EF0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096EF0, $72

Data_025_6F62:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096F62, $72

Data_025_6FD4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $096FD4, $6E

Data_025_7042:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $097042, $72

Data_025_70B4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0970B4, $72

Data_025_7126:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $097126, $72

Data_025_7198:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $097198, $72

Data_025_720A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09720A, $72

Data_025_727C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09727C, $72

Data_025_72EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0972EE, $72

Data_025_7360:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $097360, $72

Data_025_73D2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0973D2, $72

Data_025_7444:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $097444, $72

Data_025_74B6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0974B6, $72
    ds $AD8, $00
