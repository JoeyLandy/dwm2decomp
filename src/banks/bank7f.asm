SECTION "Bank 7F", ROMX[$4000], BANK[$7F]
    db $7F

; 3 call sites from 3 routines (e.g. Func_004_44CE, Func_004_4C25, Func_004_4C96)
Func_07F_4001::
    ld de, Data_07F_4008
    call Func_07F_40CC
    ret

Data_07F_4008:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_07F_4348
    dw Data_07F_43BA
    dw Data_07F_442C
    dw Data_07F_449E
    dw Data_07F_4510
    dw Data_07F_4582
    dw Data_07F_45F4
    dw Data_07F_4666
    dw Data_07F_46D8
    dw Data_07F_474A
    dw Data_07F_47BC
    dw Data_07F_482E
    dw Data_07F_48A0
    dw Data_07F_4912
    dw Data_07F_4984
    dw Data_07F_49F6
    dw Data_07F_4A68
    dw Data_07F_4ADA
    dw Data_07F_4B4C
    dw Data_07F_4BBE
    dw Data_07F_4C30
    dw Data_07F_4CA2
    dw Data_07F_4D14
    dw Data_07F_4D86
    dw Data_07F_4DF8
    dw Data_07F_4E6A
    dw Data_07F_4EDC
    dw Data_07F_4F4E
    dw Data_07F_4FC0
    dw Data_07F_5032
    dw Data_07F_50A4
    dw Data_07F_5116
    dw Data_07F_5188
    dw Data_07F_51FA
    dw Data_07F_526C
    dw Data_07F_52DE
    dw Data_07F_5350
    dw Data_07F_53C2
    dw Data_07F_5434
    dw Data_07F_54A6
    dw Data_07F_5518
    dw Data_07F_558A
    dw Data_07F_55FC
    dw Data_07F_566E
    dw Data_07F_56E0
    dw Data_07F_5752
    dw Data_07F_57C4
    dw Data_07F_5836
    dw Data_07F_58A8
    dw Data_07F_591A
    dw Data_07F_598C
    dw Data_07F_59FE
    dw Data_07F_5A70
    dw Data_07F_5AE2
    dw Data_07F_5B54
    dw Data_07F_5BC6
    dw Data_07F_5C38
    dw Data_07F_5CAA
    dw Data_07F_5D1C
    dw Data_07F_5D8E
    dw Data_07F_5E00
    dw Data_07F_5E72
    dw Data_07F_5EE4
    dw Data_07F_5F56
    dw Data_07F_5FC8
    dw Data_07F_603A
    dw Data_07F_60AC
    dw Data_07F_611E
    dw Data_07F_6190
    dw Data_07F_6202
    dw Data_07F_6274
    dw Data_07F_62E6
    dw Data_07F_63CF
    dw Data_07F_6490
    dw Data_07F_6502
    dw Data_07F_6574
    dw Data_07F_65E6
    dw Data_07F_6658
    dw Data_07F_66CA
    dw Data_07F_673C
    dw Data_07F_67AE
    dw Data_07F_6820
    dw Data_07F_6892
    dw Data_07F_6904
    dw Data_07F_6976
    dw Data_07F_6B96
    dw Data_07F_6C08
    dw Data_07F_6C7A
    dw Data_07F_6CEC
    dw Data_07F_6D5E
    dw Data_07F_6DD0
    dw Data_07F_6E42
    dw Data_07F_6EB4
    db $74, $62, $74, $62, $26, $6F, $74, $62, $98, $6F

; 1 call site from 1 routine (e.g. Func_07F_4001)
; reads: hFFB1, hFFD4, hFFD5, hFFAB, hFFAC, hFFD2, hFFD3, hFFA9, ...
; writes: hFFB3, hFFB4, hFFB1
; points at: hFFB5
Func_07F_40CC::
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
    jp nz, Jump_07F_4216
    ldh a, [hFFAF]
    ld c, a
    ldh a, [hFFB0]
    and a, $20
    jr nz, Jump_07F_419E

Jump_07F_4128::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_4140
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_07F_414F
    ld a, b
    cp a, $A8
    jr c, Jump_07F_4154
    jr Jump_07F_414F

Jump_07F_4140::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_07F_414F
    ld a, b
    cp a, $A8
    jr c, Jump_07F_4154

Jump_07F_414F::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_4128

Jump_07F_4154::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_416D
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $00
    jr nz, Jump_07F_417C
    ld a, b
    cp a, $B8
    jr c, Jump_07F_4183
    jr Jump_07F_417C

Jump_07F_416D::
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $FF
    jr nz, Jump_07F_417C
    ld a, b
    cp a, $B8
    jr c, Jump_07F_4183

Jump_07F_417C::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_4128

Jump_07F_4183::
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
    jr nz, Jump_07F_4128
    ret

Jump_07F_419E::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_41B6
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_07F_41C5
    ld a, b
    cp a, $A8
    jr c, Jump_07F_41CA
    jr Jump_07F_41C5

Jump_07F_41B6::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_07F_41C5
    ld a, b
    cp a, $A8
    jr c, Jump_07F_41CA

Jump_07F_41C5::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_419E

Jump_07F_41CA::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_41E5
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $00
    jr z, Jump_07F_41FB
    jr nz, Jump_07F_41F4
    ld a, b
    cp a, $B8
    jr c, Jump_07F_41FB
    jr Jump_07F_41F4

Jump_07F_41E5::
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $FF
    jr nz, Jump_07F_41F4
    ld a, b
    cp a, $B8
    jr c, Jump_07F_41FB

Jump_07F_41F4::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_419E

Jump_07F_41FB::
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
    jr nz, Jump_07F_419E
    ret

Jump_07F_4216::
    ldh a, [hFFB0]
    and a, $20
    jr nz, Jump_07F_4297

Jump_07F_421C::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_4227
    dec b

Jump_07F_4227::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_07F_4252
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_4252
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_07F_4257
    cp a, $01
    jr nz, Jump_07F_4245
    ld a, c
    cp a, $34
    jr c, Jump_07F_4252
    jr Jump_07F_4257

Jump_07F_4245::
    cp a, $02
    jr nz, Jump_07F_4250
    ld a, c
    cp a, $71
    jr c, Jump_07F_4257
    jr Jump_07F_4252

Jump_07F_4250::
    jr Jump_07F_4257

Jump_07F_4252::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_421C

Jump_07F_4257::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_4262
    dec b

Jump_07F_4262::
    ldh a, [hFFB5]
    add a, c
    ld c, a
    ldh a, [hFFB6]
    adc a, b
    jr nz, Jump_07F_4270
    ld a, c
    cp a, $B8
    jr c, Jump_07F_4277

Jump_07F_4270::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_421C

Jump_07F_4277::
    ld a, c
    ld [de], a
    call Func_07F_4312
    jr nc, Jump_07F_4270
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
    jr nz, Jump_07F_421C
    ret

Jump_07F_4297::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_42A2
    dec b

Jump_07F_42A2::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_07F_42CD
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_42CD
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_07F_42D2
    cp a, $01
    jr nz, Jump_07F_42C0
    ld a, c
    cp a, $34
    jr c, Jump_07F_42CD
    jr Jump_07F_42D2

Jump_07F_42C0::
    cp a, $02
    jr nz, Jump_07F_42CB
    ld a, c
    cp a, $71
    jr c, Jump_07F_42D2
    jr Jump_07F_42CD

Jump_07F_42CB::
    jr Jump_07F_42D2

Jump_07F_42CD::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_4297

Jump_07F_42D2::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_42DD
    dec b

Jump_07F_42DD::
    ldh a, [hFFB7]
    sub a, c
    ld c, a
    ldh a, [hFFB8]
    sbc a, b
    jr nz, Jump_07F_42EB
    ld a, c
    cp a, $B8
    jr c, Jump_07F_42F2

Jump_07F_42EB::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_4297

Jump_07F_42F2::
    ld a, c
    ld [de], a
    call Func_07F_4312
    jr nc, Jump_07F_42EB
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
    jr nz, Jump_07F_4297
    ret

; 2 call sites from 1 routine (e.g. Func_07F_40CC)
; reads: hFFA5, hFFA1, hFFBA, rSTAT
Func_07F_4312::
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

Jump_07F_433C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_07F_433C
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

Data_07F_4348:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC348, $72

Data_07F_43BA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC3BA, $72

Data_07F_442C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC42C, $72

Data_07F_449E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC49E, $72

Data_07F_4510:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC510, $72

Data_07F_4582:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC582, $72

Data_07F_45F4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC5F4, $72

Data_07F_4666:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC666, $72

Data_07F_46D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC6D8, $72

Data_07F_474A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC74A, $72

Data_07F_47BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC7BC, $72

Data_07F_482E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC82E, $72

Data_07F_48A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC8A0, $72

Data_07F_4912:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC912, $72

Data_07F_4984:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC984, $72

Data_07F_49F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FC9F6, $72

Data_07F_4A68:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCA68, $72

Data_07F_4ADA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCADA, $72

Data_07F_4B4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCB4C, $72

Data_07F_4BBE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCBBE, $72

Data_07F_4C30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCC30, $72

Data_07F_4CA2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCCA2, $72

Data_07F_4D14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCD14, $72

Data_07F_4D86:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCD86, $72

Data_07F_4DF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCDF8, $72

Data_07F_4E6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCE6A, $72

Data_07F_4EDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCEDC, $72

Data_07F_4F4E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCF4E, $72

Data_07F_4FC0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FCFC0, $72

Data_07F_5032:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD032, $72

Data_07F_50A4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD0A4, $72

Data_07F_5116:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD116, $72

Data_07F_5188:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD188, $72

Data_07F_51FA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD1FA, $72

Data_07F_526C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD26C, $72

Data_07F_52DE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD2DE, $72

Data_07F_5350:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD350, $72

Data_07F_53C2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD3C2, $72

Data_07F_5434:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD434, $72

Data_07F_54A6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD4A6, $72

Data_07F_5518:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD518, $72

Data_07F_558A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD58A, $72

Data_07F_55FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD5FC, $72

Data_07F_566E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD66E, $72

Data_07F_56E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD6E0, $72

Data_07F_5752:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD752, $72

Data_07F_57C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD7C4, $72

Data_07F_5836:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD836, $72

Data_07F_58A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD8A8, $72

Data_07F_591A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD91A, $72

Data_07F_598C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD98C, $72

Data_07F_59FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FD9FE, $72

Data_07F_5A70:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDA70, $72

Data_07F_5AE2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDAE2, $72

Data_07F_5B54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDB54, $72

Data_07F_5BC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDBC6, $72

Data_07F_5C38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDC38, $72

Data_07F_5CAA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDCAA, $72

Data_07F_5D1C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDD1C, $72

Data_07F_5D8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDD8E, $72

Data_07F_5E00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDE00, $72

Data_07F_5E72:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDE72, $72

Data_07F_5EE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDEE4, $72

Data_07F_5F56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDF56, $72

Data_07F_5FC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FDFC8, $72

Data_07F_603A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE03A, $72

Data_07F_60AC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE0AC, $72

Data_07F_611E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE11E, $72

Data_07F_6190:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE190, $72

Data_07F_6202:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE202, $72

Data_07F_6274:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE274, $72

Data_07F_62E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE2E6, $E9

Data_07F_63CF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE3CF, $C1

Data_07F_6490:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE490, $72

Data_07F_6502:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE502, $72

Data_07F_6574:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE574, $72

Data_07F_65E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE5E6, $72

Data_07F_6658:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE658, $72

Data_07F_66CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE6CA, $72

Data_07F_673C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE73C, $72

Data_07F_67AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE7AE, $72

Data_07F_6820:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE820, $72

Data_07F_6892:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE892, $72

Data_07F_6904:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE904, $72

Data_07F_6976:: ; heuristic: target of a monotone pointer table; C0
    dw Data_07F_6986
    dw Data_07F_69C7
    dw Data_07F_6A08
    dw Data_07F_6A49
    dw Data_07F_6A8A
    dw Data_07F_6ACF
    dw Data_07F_6B14
    dw Data_07F_6B55

Data_07F_6986:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE986, $41

Data_07F_69C7:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FE9C7, $41

Data_07F_6A08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEA08, $41

Data_07F_6A49:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEA49, $41

Data_07F_6A8A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEA8A, $45

Data_07F_6ACF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEACF, $45

Data_07F_6B14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEB14, $41

Data_07F_6B55:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEB55, $41

Data_07F_6B96:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEB96, $72

Data_07F_6C08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEC08, $72

Data_07F_6C7A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEC7A, $72

Data_07F_6CEC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FECEC, $72

Data_07F_6D5E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FED5E, $72

Data_07F_6DD0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEDD0, $72

Data_07F_6E42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEE42, $72

Data_07F_6EB4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FEEB4, $156

; 25 call sites from 20 routines (e.g. Func_003_7647, Func_004_4BE4, Func_004_4D43, Func_007_5DD6, ...)
Func_07F_700A::
    ld de, Data_07F_7011
    call Func_07F_7065
    ret

Data_07F_7011:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_07F_72E1
    dw Data_07F_72F4
    dw Data_07F_731A
    dw Data_07F_732D
    dw Data_07F_7340
    dw Data_07F_7353
    dw Data_07F_7366
    dw Data_07F_7379
    dw Data_07F_738C
    dw Data_07F_739F
    dw Data_07F_73B2
    dw Data_07F_73C5
    dw Data_07F_73D8
    dw Data_07F_73EB
    dw Data_07F_73FE
    dw Data_07F_7411
    dw Data_07F_7424
    dw Data_07F_7437
    dw Data_07F_744A
    dw Data_07F_7496
    dw Data_07F_74E2
    dw Data_07F_74F5
    dw Data_07F_7508
    dw Data_07F_752E
    dw Data_07F_7567
    dw Data_07F_75D9
    dw Data_07F_764B
    dw Data_07F_7671
    dw Data_07F_76E3
    dw Data_07F_7755
    dw Data_07F_7768
    dw Data_07F_779C
    dw Data_07F_7974
    dw Data_07F_79F9
    dw Data_07F_7A0C
    dw Data_07F_7A1F
    dw Data_07F_7A7E
    dw Data_07F_7ADD
    dw Data_07F_7B0F
    dw Data_07F_7B16
    dw Data_07F_7B1D
    dw Data_07F_7B24

; 1 call site from 1 routine (e.g. Func_07F_700A)
; reads: hFFB1, hFFD4, hFFD5, hFFAB, hFFAC, hFFD2, hFFD3, hFFA9, ...
; writes: hFFB3, hFFB4, hFFB1
; points at: hFFB5
Func_07F_7065::
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
    jp nz, Jump_07F_71AF
    ldh a, [hFFAF]
    ld c, a
    ldh a, [hFFB0]
    and a, $20
    jr nz, Jump_07F_7137

Jump_07F_70C1::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_70D9
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_07F_70E8
    ld a, b
    cp a, $A8
    jr c, Jump_07F_70ED
    jr Jump_07F_70E8

Jump_07F_70D9::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_07F_70E8
    ld a, b
    cp a, $A8
    jr c, Jump_07F_70ED

Jump_07F_70E8::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_70C1

Jump_07F_70ED::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_7106
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $00
    jr nz, Jump_07F_7115
    ld a, b
    cp a, $B8
    jr c, Jump_07F_711C
    jr Jump_07F_7115

Jump_07F_7106::
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $FF
    jr nz, Jump_07F_7115
    ld a, b
    cp a, $B8
    jr c, Jump_07F_711C

Jump_07F_7115::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_70C1

Jump_07F_711C::
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
    jr nz, Jump_07F_70C1
    ret

Jump_07F_7137::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_07F_714F
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_07F_715E
    ld a, b
    cp a, $A8
    jr c, Jump_07F_7163
    jr Jump_07F_715E

Jump_07F_714F::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_07F_715E
    ld a, b
    cp a, $A8
    jr c, Jump_07F_7163

Jump_07F_715E::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_7137

Jump_07F_7163::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_07F_717E
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $00
    jr z, Jump_07F_7194
    jr nz, Jump_07F_718D
    ld a, b
    cp a, $B8
    jr c, Jump_07F_7194
    jr Jump_07F_718D

Jump_07F_717E::
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $FF
    jr nz, Jump_07F_718D
    ld a, b
    cp a, $B8
    jr c, Jump_07F_7194

Jump_07F_718D::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_7137

Jump_07F_7194::
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
    jr nz, Jump_07F_7137
    ret

Jump_07F_71AF::
    ldh a, [hFFB0]
    and a, $20
    jr nz, Jump_07F_7230

Jump_07F_71B5::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_71C0
    dec b

Jump_07F_71C0::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_07F_71EB
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_71EB
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_07F_71F0
    cp a, $01
    jr nz, Jump_07F_71DE
    ld a, c
    cp a, $34
    jr c, Jump_07F_71EB
    jr Jump_07F_71F0

Jump_07F_71DE::
    cp a, $02
    jr nz, Jump_07F_71E9
    ld a, c
    cp a, $71
    jr c, Jump_07F_71F0
    jr Jump_07F_71EB

Jump_07F_71E9::
    jr Jump_07F_71F0

Jump_07F_71EB::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_71B5

Jump_07F_71F0::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_71FB
    dec b

Jump_07F_71FB::
    ldh a, [hFFB5]
    add a, c
    ld c, a
    ldh a, [hFFB6]
    adc a, b
    jr nz, Jump_07F_7209
    ld a, c
    cp a, $B8
    jr c, Jump_07F_7210

Jump_07F_7209::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_71B5

Jump_07F_7210::
    ld a, c
    ld [de], a
    call Func_07F_72AB
    jr nc, Jump_07F_7209
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
    jr nz, Jump_07F_71B5
    ret

Jump_07F_7230::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_723B
    dec b

Jump_07F_723B::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_07F_7266
    ld a, c
    cp a, $B8
    jr nc, Jump_07F_7266
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_07F_726B
    cp a, $01
    jr nz, Jump_07F_7259
    ld a, c
    cp a, $34
    jr c, Jump_07F_7266
    jr Jump_07F_726B

Jump_07F_7259::
    cp a, $02
    jr nz, Jump_07F_7264
    ld a, c
    cp a, $71
    jr c, Jump_07F_726B
    jr Jump_07F_7266

Jump_07F_7264::
    jr Jump_07F_726B

Jump_07F_7266::
    inc hl
    inc hl
    inc hl
    jr Jump_07F_7230

Jump_07F_726B::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_07F_7276
    dec b

Jump_07F_7276::
    ldh a, [hFFB7]
    sub a, c
    ld c, a
    ldh a, [hFFB8]
    sbc a, b
    jr nz, Jump_07F_7284
    ld a, c
    cp a, $B8
    jr c, Jump_07F_728B

Jump_07F_7284::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_07F_7230

Jump_07F_728B::
    ld a, c
    ld [de], a
    call Func_07F_72AB
    jr nc, Jump_07F_7284
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
    jr nz, Jump_07F_7230
    ret

; 2 call sites from 1 routine (e.g. Func_07F_7065)
; reads: hFFA5, hFFA1, hFFBA, rSTAT
Func_07F_72AB::
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

Jump_07F_72D5::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_07F_72D5
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

Data_07F_72E1:: ; heuristic: target of a monotone pointer table; C0
    db $E3, $72, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_72F4:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $72, $09, $73, $F0, $F8, $02, $00, $F0, $00, $02, $20, $F8, $F8, $03, $00
    db $F8, $00, $03, $20, $80, $F0, $F8, $00, $00, $F0, $00, $00, $20, $F8, $F8, $01
    db $00, $F8, $00, $01, $20, $80

Data_07F_731A:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_732D:: ; heuristic: target of a monotone pointer table; C0
    db $2F, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7340:: ; heuristic: target of a monotone pointer table; C0
    db $42, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7353:: ; heuristic: target of a monotone pointer table; C0
    db $55, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7366:: ; heuristic: target of a monotone pointer table; C0
    db $68, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7379:: ; heuristic: target of a monotone pointer table; C0
    db $7B, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_738C:: ; heuristic: target of a monotone pointer table; C0
    db $8E, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_739F:: ; heuristic: target of a monotone pointer table; C0
    db $A1, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_73B2:: ; heuristic: target of a monotone pointer table; C0
    db $B4, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_73C5:: ; heuristic: target of a monotone pointer table; C0
    db $C7, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_73D8:: ; heuristic: target of a monotone pointer table; C0
    db $DA, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_73EB:: ; heuristic: target of a monotone pointer table; C0
    db $ED, $73, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_73FE:: ; heuristic: target of a monotone pointer table; C0
    db $00, $74, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7411:: ; heuristic: target of a monotone pointer table; C0
    db $13, $74, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7424:: ; heuristic: target of a monotone pointer table; C0
    db $26, $74, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7437:: ; heuristic: target of a monotone pointer table; C0
    db $39, $74, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_744A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF44A, $4C

Data_07F_7496:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF496, $4C

Data_07F_74E2:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $74, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_74F5:: ; heuristic: target of a monotone pointer table; C0
    db $F7, $74, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7508:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $75, $1D, $75, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00
    db $F8, $00, $03, $00, $80, $F0, $F8, $04, $00, $F0, $00, $05, $00, $F8, $F8, $06
    db $00, $F8, $00, $07, $00, $80

Data_07F_752E:: ; heuristic: target of a monotone pointer table; C0
    db $34, $75, $45, $75, $56, $75, $EF, $F8, $00, $00, $EF, $00, $01, $00, $F7, $F8
    db $02, $00, $F7, $00, $03, $00, $80, $F0, $F8, $04, $00, $F0, $00, $05, $00, $F8
    db $F8, $06, $00, $F8, $00, $07, $00, $80, $F0, $F8, $08, $00, $F0, $00, $09, $00
    db $F8, $F8, $0A, $00, $F8, $00, $0B, $00, $80

Data_07F_7567:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF567, $72

Data_07F_75D9:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF5D9, $72

Data_07F_764B:: ; heuristic: target of a monotone pointer table; C0
    db $4F, $76, $60, $76, $F8, $F8, $02, $00, $F8, $00, $03, $00, $F0, $F8, $00, $00
    db $F0, $00, $01, $00, $80, $F8, $F8, $06, $00, $F8, $00, $07, $00, $F0, $F8, $04
    db $00, $F0, $00, $05, $00, $80

Data_07F_7671:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF671, $72

Data_07F_76E3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF6E3, $72

Data_07F_7755:: ; heuristic: target of a monotone pointer table; C0
    db $57, $77, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7768:: ; heuristic: target of a monotone pointer table; C0
    db $70, $77, $75, $77, $7A, $77, $8B, $77, $F4, $FC, $00, $00, $80, $F4, $FC, $01
    db $00, $80, $F0, $F8, $02, $00, $F8, $F8, $03, $00, $F0, $FF, $02, $20, $F8, $FF
    db $03, $20, $80, $F0, $F8, $04, $00, $F0, $FF, $04, $20, $F8, $F8, $05, $00, $F8
    db $FF, $05, $20, $80

Data_07F_779C:: ; heuristic: target of a monotone pointer table; C0
    dw Data_07F_77DC
    dw Data_07F_77ED
    dw Data_07F_77FE
    dw Data_07F_780F
    dw Data_07F_7820
    dw Data_07F_7831
    dw Data_07F_7856
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873
    dw Data_07F_7873

Data_07F_77DC:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00, $03, $00
    db $80

Data_07F_77ED:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $04, $00, $F0, $00, $05, $00, $F8, $F8, $06, $00, $F8, $00, $07, $00
    db $80

Data_07F_77FE:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $00, $04, $20, $F0, $F8, $05, $20, $F8, $00, $06, $20, $F8, $F8, $07, $20
    db $80

Data_07F_780F:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $08, $00, $F0, $00, $09, $00, $F8, $F8, $0A, $00, $F8, $00, $0B, $00
    db $80

Data_07F_7820:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $0C, $00, $F0, $00, $0D, $00, $F8, $F8, $0E, $00, $F8, $00, $0F, $00
    db $80

Data_07F_7831:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $10, $00, $F0, $00, $11, $00, $F8, $F8, $12, $00, $F8, $00, $13, $00
    db $F0, $F5, $18, $00, $EE, $FC, $19, $00, $EA, $04, $1A, $00, $E8, $F5, $16, $00
    db $E6, $FC, $17, $00, $80

Data_07F_7856:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $F8, $10, $00, $F0, $00, $11, $00, $F8, $F8, $14, $00, $F8, $00, $15, $00
    db $F8, $08, $1A, $00, $F9, $EF, $16, $00, $F8, $0C, $17, $00, $80

Data_07F_7873:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF873, $101

Data_07F_7974:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FF974, $85

Data_07F_79F9:: ; heuristic: target of a monotone pointer table; C0
    db $FB, $79, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7A0C:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $7A, $F0, $F8, $00, $00, $F0, $00, $01, $00, $F8, $F8, $02, $00, $F8, $00
    db $03, $00, $80

Data_07F_7A1F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FFA1F, $5F

Data_07F_7A7E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FFA7E, $5F

Data_07F_7ADD:: ; heuristic: target of a monotone pointer table; C0
    db $E7, $7A, $EC, $7A, $EC, $7A, $F5, $7A, $06, $7B, $F0, $F8, $00, $00, $80, $F0
    db $F8, $01, $00, $F0, $00, $02, $00, $80, $F0, $F9, $03, $00, $F0, $01, $04, $00
    db $F8, $F9, $05, $00, $F8, $01, $06, $00, $80, $F8, $00, $07, $00, $F8, $F8, $05
    db $00, $80

Data_07F_7B0F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $7B, $00, $00, $00, $00, $80

Data_07F_7B16:: ; heuristic: target of a monotone pointer table; C0
    db $18, $7B, $00, $00, $00, $00, $80

Data_07F_7B1D:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $7B, $00, $00, $00, $00, $80

Data_07F_7B24:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $1FFB24, $72
    ds $46A, $00
