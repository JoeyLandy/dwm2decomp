SECTION "Bank 30", ROMX[$4000], BANK[$30]
    db $30

; 1 call site from 1 routine (e.g. Func_031_4365)
; reads: wC52B, wCFCA
Func_030_4001::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wCFCA]
    rst $00
    dw Jump_030_4018
    dw Jump_030_40A0
    dw Jump_030_40E3
    dw Jump_030_40E7
    dw Jump_030_4160
    dw Jump_030_42B7
    dw Jump_030_434C

Jump_030_4018::
    ld hl, wCFCA
    inc [hl]
    ld a, [wC58A]
    or a, a
    ret nz
    xor a, a
    ld [wDAE8], a
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityHi
    ld de, $0000
    call Func_030_408D
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityMid
    push de
    ld de, $0000
    call Func_030_408D
    pop hl
    ld a, l
    sub a, e
    ld a, h
    sbc a, d
    jr nc, Jump_030_4052
    ld h, d
    ld l, e
    ld a, $01
    ld [wDAE8], a

Jump_030_4052::
    push hl
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld hl, wSlotPersonalityLo
    ld de, $0000
    call Func_030_408D
    pop hl
    ld a, l
    sub a, e
    ld a, h
    sbc a, d
    jr nc, Jump_030_4070
    ld h, d
    ld l, e
    ld a, $02
    ld [wDAE8], a

Jump_030_4070::
    push hl
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld hl, wD980
    ld de, $0000
    call Func_030_408D
    pop hl
    ld a, l
    sub a, e
    ld a, h
    sbc a, d
    jr nc, Jump_030_408C
    ld a, $03
    ld [wDAE8], a

Jump_030_408C::
    ret

; 4 call sites from 1 routine (e.g. Func_030_4001)
Func_030_408D::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_409A
    ld a, e
    add a, [hl]
    ld e, a
    ld a, d
    adc a, $00
    ld d, a

Jump_030_409A::
    inc hl
    inc c
    dec b
    jr nz, Func_030_408D
    ret

Jump_030_40A0::
    ld a, [wC58A]
    or a, a
    call nz, Func_000_3EDE
    ld a, [wD8A4]
    cp a, $08
    jr z, Jump_030_40D6
    ld e, a
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_030_40C3

Jump_030_40BC::
    inc e
    ld a, e
    ld [wD8A4], a
    jr Jump_030_40E2

Jump_030_40C3::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_40BC
    ld [wD8A4], a
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    jr Jump_030_40E2

Jump_030_40D6::
    ld hl, wCFCA
    inc [hl]
    ld hl, wCFCA
    inc [hl]
    ld hl, wCFCA
    inc [hl]

Jump_030_40E2::
    ret

Jump_030_40E3::
    call Func_030_43C4
    ret

Jump_030_40E7::
    call Func_030_4102
    ld a, [wD8A4]
    ld hl, wDA5B
    add_a_to_hl
    ld a, $02
    ld [hl], a
    ld a, $01
    ld [wCFCA], a
    ld hl, wD8A4
    inc [hl]
    ret

; 5 call sites from 4 routines (e.g. Func_030_408D, Func_036_714F, Func_03A_61F8, Func_03A_6846)
; reads: wC58A, wC46B, wD8A4
; points at: wDAD8, wDA1D, wDAE9
Func_030_4102::
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_030_4112
    cp a, $02
    jr z, Jump_030_4149
    ld a, [wC46B]
    jr Jump_030_4122

Jump_030_4112::
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]

Jump_030_4122::
    and a, $03
    cp a, $01
    jr nz, Jump_030_4149
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr nz, Jump_030_4149
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp nz, Jump_030_4151

Jump_030_4149::
    farcall Func_039_4001
    jr Jump_030_4152

Jump_030_4151::
    ld d, a

Jump_030_4152::
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld d, [hl]
    ret

Jump_030_4160::
    ld hl, wD895
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wD868
    ld bc, $0009
    ld a, $FF
    call FillBytes
    ld hl, wD87D
    ld bc, $0012
    ld a, $00
    call FillBytes
    xor a, a
    ld [wD89E], a
    ld [wD871], a
    ld hl, wD87D
    ld a, l
    ld [wD87A], a
    ld a, h
    ld [wD87B], a
    ld de, $0800

Jump_030_4196::
    ld a, e
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_41D2
    ld a, e
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_030_41D2
    ld a, e
    call Func_030_41DF
    call Func_030_4203
    ld hl, wD87A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD871]
    ld hl, wD868
    add_a_to_hl
    ld [hl], e
    ld hl, wD871
    inc [hl]
    ld hl, wD87A
    inc [hl]
    ld hl, wD87A
    inc [hl]

Jump_030_41D2::
    inc e
    dec d
    jp nz, Jump_030_4196
    call Func_030_4297
    ld hl, wCFCA
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_030_4102)
; points at: wD91F
Func_030_41DF::
    push de
    call Func_000_3ED4
    ld a, e
    ld hl, wD91F
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $03
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop bc
    call Func_000_3E98
    ld c, e
    ld b, d
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_030_4102)
; reads: wD868, wD869, wD86A, wD86B, wCFF3, wC5E7
; writes: wCFEC, wCFED, wD868, wD869, wD86A, wD86B
; points at: wDA1C, wCFF3
Func_030_4203::
    push de
    ld a, e
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $62
    jr z, Jump_030_4275
    cp a, $69
    jr z, Jump_030_427F
    cp a, $D8
    jr z, Jump_030_4275
    push af
    push bc
    push de
    push hl
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    push hl
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    push hl
    ld a, $05
    ld [wD868], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFF3
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall Func_01A_4022
    pop hl
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    pop hl
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    pop hl
    pop de
    pop bc
    pop af
    ld a, [wCFF3]
    bit 2, a
    jr nz, Jump_030_427A
    ld hl, $000A
    jr Jump_030_4292

Jump_030_4275::
    ld hl, $0BB8
    jr Jump_030_4292

Jump_030_427A::
    ld hl, $03E8
    jr Jump_030_4292

Jump_030_427F::
    call Func_000_3ED4
    ld a, [wC5E7]
    ld b, a
    ld a, $09
    call DivideBByA
    add a, $01
    ld c, a
    ld b, $00
    jr Jump_030_4295

Jump_030_4292::
    add hl, bc
    ld c, l
    ld b, h

Jump_030_4295::
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_030_4102)
; reads: wD892, wD871
; points at: wD87A, wD868
Func_030_4297::
    ld a, [wD892]
    cp a, $FF
    ret z
    ld bc, $07DA
    ld hl, wD87A
    deref_hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD871]
    ld hl, wD868
    add_a_to_hl
    ld [hl], $10
    ret

Jump_030_42B7::
    ld d, $08

Jump_030_42B9::
    ld hl, wD87D
    ld a, l
    ld [wD87A], a
    ld a, h
    ld [wD87B], a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wD87F
    deref_hl
    ld e, $00

Jump_030_42CF::
    call CompareHLToBC
    jr c, Jump_030_4309
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld a, c
    ld [wD874], a
    ld a, b
    ld [wD875], a
    ld a, [wD87A]
    ld l, a
    ld a, [wD87B]
    ld h, a
    ld a, [wD872]
    ld [hl+], a
    ld a, [wD873]
    ld [hl+], a
    ld a, [wD874]
    ld [hl+], a
    ld a, [wD875]
    ld [hl], a
    ld a, e
    ld hl, wD868
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld [hl-], a
    ld [hl], b

Jump_030_4309::
    inc e
    ld a, e
    cp a, d
    jr z, Jump_030_4322
    ld hl, wD87A
    inc [hl]
    ld hl, wD87A
    inc [hl]
    deref_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc hl
    deref_hl
    jr Jump_030_42CF

Jump_030_4322::
    dec d
    jr nz, Jump_030_42B9
    ld a, [wD89E]
    ld de, wD895
    add a, e
    ld e, a
    jr nc, Jump_030_4330
    inc d

Jump_030_4330::
    ld a, [wD89E]
    ld hl, wD868
    ld b, $09

Jump_030_4338::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_030_4342
    ld [de], a
    inc de
    dec b
    jr nz, Jump_030_4338

Jump_030_4342::
    ld a, $00
    ld [wD89E], a
    ld hl, wCFCA
    inc [hl]
    ret

Jump_030_434C::
    ld hl, wD8BF
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    ld a, c
    ld [wD2C8], a
    ld a, b
    ld [wD2C9], a
    ld hl, wD8CF
    ld bc, $0000
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    call AddWordAtHLToBC_Bank30
    ld a, c
    ld [wD2CA], a
    ld a, b
    ld [wD2CB], a
    ld hl, wCFC9
    inc [hl]
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld hl, wCFCB
    ld bc, $0005
    call FillBytes
    farcall Func_0A3_4187
    call Func_030_439D
    ret

; BC += the word at [HL]; HL += 2; clobbers A (the same 7 bytes appear in 2 banks)
; 6 call sites from 1 routine (e.g. Func_030_4297)
AddWordAtHLToBC_Bank30::
Func_030_4396:: ; address name
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ret

; 1 call site from 1 routine (e.g. Func_030_4297)
; points at: wDA1C, wD812
Func_030_439D::
    ld c, $00
    ld b, $08

Jump_030_43A1::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_43BF
    ld a, c
    add a, a
    ld hl, wDA1C
    add_a_to_hl
    ld a, [hl]
    cp a, $6E
    jr nz, Jump_030_43BF
    ld a, c
    ld hl, wD812
    call AddAx9ToHL
    set 2, [hl]

Jump_030_43BF::
    inc c
    dec b
    jr nz, Jump_030_43A1
    ret

; 2 call sites from 2 routines (e.g. Func_030_408D, Func_0A1_413F)
; reads: wCFCB
Func_030_43C4::
    ld a, [wCFCB]
    rst $00
    dw Jump_030_43D0
    dw Jump_030_441D
    dw Func_030_4595
    dw Jump_030_4CF0

Jump_030_43D0::
    ld a, [wD8A4]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call Func_030_5287
    jr nz, Jump_030_4414
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_440B
    cp a, $02
    jr z, Jump_030_43FA
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_440E

Jump_030_43FA::
    ld a, [wD8A4]
    cp a, $01
    jr z, Jump_030_4406
    ld a, [wC46B]
    jr Jump_030_440E

Jump_030_4406::
    ld a, [wDAE9]
    jr Jump_030_440E

Jump_030_440B::
    ld a, [wC46B]

Jump_030_440E::
    and a, $03
    cp a, $01
    jr z, Jump_030_4418

Jump_030_4414::
    ld hl, wCFCB
    inc [hl]

Jump_030_4418::
    ld hl, wCFCB
    inc [hl]
    ret

Jump_030_441D::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wDAC4], a
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4431
    cp a, $02
    jr z, Jump_030_4431
    jr Jump_030_4438

Jump_030_4431::
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_030_4480

Jump_030_4438::
    ld a, $01
    ld [wDAC4], a
    ld hl, wD868
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_030_4480
    call Func_030_44E0
    or a, a
    jr z, Jump_030_4480
    cp a, $01
    jr z, Jump_030_4497
    call Func_030_4506
    call Func_030_450B
    call Func_030_4536
    call Func_030_4558
    call Func_030_4579
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    ld a, [wD86A]
    ld c, a
    ld a, [wD86B]
    ld b, a
    call CompareHLToBC
    jr c, Jump_030_4497

Jump_030_4480::
    call Func_030_540C
    res 6, [hl]
    ld a, [wD8A4]
    ld hl, wDAE0
    add_a_to_hl
    ld [hl], $00
    call Func_030_52B5
    jr Jump_030_44DF

Jump_030_4497::
    call Func_030_540C
    set 6, [hl]
    ld a, [wD8A4]
    ld hl, wDAE0
    add_a_to_hl
    ld [hl], $01
    ld a, [wD8A4]
    ld hl, wDA1C
    call AddDoubleAToHL_Bank30
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    set 7, [hl]
    call Func_030_52B5
    call Func_030_502D
    ld a, $03
    ld [wCFCB], a
    ld a, [wD8A4]
    and a, $03
    cp a, $03
    jr z, Jump_030_44DF
    ld d, $28
    farcall Func_03A_6EE5

Jump_030_44DF::
    ret

; 1 call site from 1 routine (e.g. Func_030_43C4)
; reads: wD8A4
; points at: wD93F
Func_030_44E0::
    ld a, [wD8A4]
    ld hl, wD93F
    add a, a
    add_a_to_hl
    deref_hl
    ld bc, $0033
    call CompareHLToBC
    ld a, $00
    jr c, Jump_030_4505
    ld bc, $03B6
    call CompareHLToBC
    ld a, $02
    jr c, Jump_030_4505
    ld a, $03

Jump_030_4505::
    ret

; 1 call site from 1 routine (e.g. Func_030_43C4)
; reads: wD8A4
; points at: wD980, wD868
Func_030_4506::
    ld hl, wD980
    jr Jump_030_451F

; 1 call site from 1 routine (e.g. Func_030_43C4)
; reads: wD8A4
; points at: wD868
Func_030_450B::
    call Func_030_540C
    cp a, $03
    ret z
    ld hl, Data_030_4519
    call Func_030_5C68
    jr Jump_030_451F

Data_030_4519:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $68, $D9, $70, $D9, $78, $D9

Jump_030_451F::
    ld a, [wD8A4]
    add_a_to_hl
    ld a, [hl]
    srl a
    srl a
    ld hl, wD868
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_030_43C4)
; reads: wPersonalityIndex
; points at: wD868
Func_030_4536::
    ld a, [wPersonalityIndex]
    add a, a
    add a, a
    ld hl, Data_030_5587
    add_a_to_hl
    push hl
    call Func_030_540C
    pop hl
    add_a_to_hl
    ld a, [hl]
    ld hl, wD868
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_030_43C4)
; reads: wD8A4, wD86A, wD86B
; writes: wD86A, wD86B
; points at: wD93F
Func_030_4558::
    ld a, [wD8A4]
    ld hl, wD93F
    add a, a
    add_a_to_hl
    deref_hl
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    jr Jump_030_4586

; 1 call site from 1 routine (e.g. Func_030_43C4)
; reads: wC5E7, wD86A, wD86B
; writes: wD86A, wD86B
Func_030_4579::
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $3F
    ld l, a
    ld h, $00
    jr Jump_030_4586

Jump_030_4586::
    ld a, [wD86A]
    add a, l
    ld [wD86A], a
    ld a, [wD86B]
    adc a, h
    ld [wD86B], a
    ret

; 2 call sites from 1 routine (e.g. Func_0E0_56C7)
; reads: wD8A4
; writes: wD2CC
; points at: wDAD8, wDA53, wCFCB
Func_030_4595::
    call Func_030_5287
    jr nz, Jump_030_45C7
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_030_45CB
    call Func_030_45DA
    xor a, a
    ld [wD2CC], a
    ld a, [wD8A4]
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_45D0
    call Func_030_5C68
    call JumpToHL
    jr Jump_030_45CB

Jump_030_45C7::
    call Func_030_541B
    ld [hl], b

Jump_030_45CB::
    ld hl, wCFCB
    inc [hl]
    ret

Data_030_45D0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $46, $49
    dw Func_030_4AD3
    dw Func_030_4AD3
    dw Func_030_4AD3
    dw Func_030_4AC6

; 1 call site from 1 routine (e.g. Func_030_4595)
; writes: wDA3C, wDA3D, wDA3E, wDA3F, wDA40, wDA41, wDA42, wD871
; points at: wD2AD
Func_030_45DA::
    ld hl, wD2AD
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
    ld [wDA3C], a
    ld [wDA3D], a
    ld [wDA3E], a
    ld a, $01
    ld [wDA3F], a
    ld a, $02
    ld [wDA40], a
    ld a, $03
    ld [wDA41], a
    ld a, $03
    ld [wDA42], a
    call Func_030_4617
    call Func_030_4688
    call Func_030_46BA
    call Func_030_47B9
    call Func_030_483F
    ld a, $00
    ld [wD871], a
    ret

; 2 call sites from 2 routines (e.g. Func_030_45DA, Func_030_5472)
; reads: wC58A, wD8A4, wC46B, wDAE9
; points at: wDA3C, wDA4B, wDAE9
Func_030_4617::
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4646
    cp a, $02
    jr nz, Jump_030_4634
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_030_4687
    cp a, $00
    ld a, [wC46B]
    jr z, Jump_030_4650
    ld a, [wDAE9]
    jr Jump_030_4650

Jump_030_4634::
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_4650

Jump_030_4646::
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_030_4687
    ld a, [wC46B]

Jump_030_4650::
    and a, $03
    cp a, $01
    jr nz, Jump_030_466C
    call Func_030_540C
    cp a, $03
    jr z, Jump_030_4687
    ld hl, wDA3C
    add_a_to_hl
    ld e, $2D
    call Func_030_5428
    jr Jump_030_4687

Jump_030_466C::
    ld a, [wD8A4]
    ld hl, wDA4B
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld hl, wDA3C
    add_a_to_hl
    ld e, $14
    call Func_030_5428

Jump_030_4687::
    ret

; 2 call sites from 2 routines (e.g. Func_030_45DA, Func_030_5472)
; reads: wD8A4
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wDA3C
Func_030_4688::
    ld hl, wSlotPersonalityHi
    ld a, $00
    call Func_030_469D
    ld hl, wSlotPersonalityMid
    ld a, $01
    call Func_030_469D
    ld hl, wSlotPersonalityLo
    ld a, $02

; 2 call sites from 1 routine (e.g. Func_030_4688)
; reads: wD8A4
; points at: wDA3C
Func_030_469D::
    push af
    ld a, [wD8A4]
    add_a_to_hl
    ld b, [hl]
    ld a, $0A
    call DivideBByA
    pop af
    ld hl, wDA3C
    add_a_to_hl
    ld e, b
    call Func_030_5428
    ret

; 2 call sites from 2 routines (e.g. Func_030_45DA, Func_030_5472)
; reads: wD8A4, wC58A, wC46B, wDAE9, wD891
; points at: wD80D, wDA3C, wDA53, wDA3E, wD989, wDAE9
Func_030_46BA::
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl+]
    and a, $08
    jr nz, Jump_030_46CF
    inc hl
    inc hl
    ld a, [hl]
    and a, $33
    jr z, Jump_030_470B

Jump_030_46CF::
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_46FA
    cp a, $02
    jr nz, Jump_030_46E8
    ld a, [wD8A4]
    cp a, $00
    ld a, [wC46B]
    jr z, Jump_030_46FD
    ld a, [wDAE9]
    jr Jump_030_46FD

Jump_030_46E8::
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_46FD

Jump_030_46FA::
    ld a, [wC46B]

Jump_030_46FD::
    and a, $03
    cp a, $01
    jr z, Jump_030_470B
    ld hl, wDA3C
    ld e, $1E
    call Func_030_5428

Jump_030_470B::
    call Func_030_478B
    jr z, Jump_030_4768
    ld a, [wD8A4]
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    cp a, $04
    jr z, Jump_030_4726
    cp a, $03
    jr z, Jump_030_4726
    jr Jump_030_4768

Jump_030_4726::
    ld a, [wD8A4]
    ld hl, wD989
    swap a
    add_a_to_hl
    ld b, $08

Jump_030_4735::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_4768
    cp a, $16
    jr c, Jump_030_4752
    cp a, $21
    jr c, Jump_030_4759
    cp a, $7B
    jr z, Jump_030_4759
    cp a, $7C
    jr z, Jump_030_4759
    cp a, $9F
    jr c, Jump_030_4752
    cp a, $A2
    jr c, Jump_030_4759

Jump_030_4752::
    inc hl
    inc hl
    dec b
    jr nz, Jump_030_4735
    jr Jump_030_4768

Jump_030_4759::
    call Func_030_540C
    cp a, $03
    jr z, Jump_030_4768
    ld hl, wDA3E
    ld e, $1E
    call Func_030_5428

Jump_030_4768::
    ld a, [wD891]
    or a, a
    jr nz, Jump_030_478A
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_030_478A
    ld a, [wC58A]
    or a, a
    jr nz, Jump_030_478A
    ld a, [wC46B]
    and a, $01
    jr nz, Jump_030_478A
    ld hl, wDA3E
    ld e, $E2
    call Func_030_5428

Jump_030_478A::
    ret

; 1 call site from 1 routine (e.g. Func_030_46BA)
; reads: wD8A4
Func_030_478B::
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_030_4793::
    push bc
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_47AE
    ld a, c
    call Func_030_5C45
    ld a, $06
    call DivideHLByA
    push hl
    ld a, c
    call Func_030_5C4F
    pop bc
    call CompareHLToBC
    jr c, Jump_030_47B4

Jump_030_47AE::
    pop bc
    inc c
    dec b
    jr nz, Jump_030_4793
    ret

Jump_030_47B4::
    pop bc
    ld a, $01
    or a, a
    ret

; 2 call sites from 2 routines (e.g. Func_030_45DA, Func_030_5472)
; reads: wC58A, wD8A4, wC5E7
; points at: wDA3C, wSlotPersonalityHi, wSlotPersonalityMid, wDA3D, wSlotPersonalityLo, wDA3E
Func_030_47B9::
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_47E6
    cp a, $02
    jr nz, Jump_030_47CA
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_030_47E6

Jump_030_47CA::
    call Func_030_540C
    cp a, $03
    ret z
    ld hl, wDA3C
    ld b, $03

Jump_030_47D5::
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $0F
    ld e, a
    call Func_030_5428
    inc hl
    dec b
    jr nz, Jump_030_47D5
    ret

Jump_030_47E6::
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_030_47CA
    ld a, [wD8A4]
    ld hl, wSlotPersonalityHi
    ld de, wDA3C
    call Func_030_480E
    ld a, [wD8A4]
    ld hl, wSlotPersonalityMid
    ld de, wDA3D
    call Func_030_480E
    ld a, [wD8A4]
    ld hl, wSlotPersonalityLo
    ld de, wDA3E

; 2 call sites from 1 routine (e.g. Func_030_47B9)
Func_030_480E::
    push de
    add_a_to_hl
    ld a, [hl]
    ld bc, $001E
    cp a, $32
    jr c, Jump_030_4834
    ld bc, $0019
    cp a, $64
    jr c, Jump_030_4834
    ld bc, $0014
    cp a, $96
    jr c, Jump_030_4834
    ld bc, $000F
    cp a, $C8
    jr c, Jump_030_4834
    ld bc, $000A

Jump_030_4834::
    ld hl, $0000
    call Func_000_3E98
    pop hl
    call Func_030_5428
    ret

; 2 call sites from 2 routines (e.g. Func_030_45DA, Func_030_5472)
; reads: wC5E7, wC5E8, wDA3F, wDA40, wDA41, wDA3C, wD8A4
; writes: wDA3F, wDA40, wDA41
; points at: wDA3C, wD988, wD2AD, wD2BD
Func_030_483F::
    ld a, [wC5E7]
    ld c, a
    ld a, [wC5E8]
    ld b, a
    ld hl, wDA3C
    ld a, [hl+]
    cp a, [hl]
    ccf
    jr c, Jump_030_4868
    jr nz, Jump_030_4855
    bit 0, b
    jr nz, Jump_030_4868

Jump_030_4855::
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wDA3F]
    push af
    ld a, [wDA40]
    ld [wDA3F], a
    pop af
    ld [wDA40], a

Jump_030_4868::
    ld a, [hl+]
    cp a, [hl]
    ccf
    jr c, Jump_030_4886
    jr nz, Jump_030_4873
    bit 0, c
    jr nz, Jump_030_4886

Jump_030_4873::
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wDA40]
    push af
    ld a, [wDA41]
    ld [wDA40], a
    pop af
    ld [wDA41], a

Jump_030_4886::
    dec hl
    ld a, [wDA3C]
    cp a, [hl]
    ccf
    jr c, Jump_030_48A7
    jr nz, Jump_030_4894
    bit 1, b
    jr nz, Jump_030_48A7

Jump_030_4894::
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wDA3F]
    push af
    ld a, [wDA40]
    ld [wDA3F], a
    pop af
    ld [wDA40], a

Jump_030_48A7::
    ld a, [wDA3F]
    ld d, a
    ld e, $32
    call Func_030_48B6
    ld a, [wDA40]
    ld d, a
    ld e, $19

; 1 call site from 1 routine (e.g. Func_030_483F)
; reads: wD8A4
; points at: wD988, wD2AD, wD2BD
Func_030_48B6::
    ld bc, $0800
    ld hl, wD988
    ld a, [wD8A4]
    swap a
    add a, l
    ld l, a
    jr nc, Jump_030_48C6
    inc h

Jump_030_48C6::
    push bc
    ld a, [hl]
    cp a, d
    jr nz, Jump_030_48DA
    push hl
    ld a, c
    ld hl, wD2AD
    add a, a
    add_a_to_hl
    call Func_030_48F3
    pop hl

Jump_030_48DA::
    pop bc
    inc hl
    inc hl
    inc c
    dec b
    jr nz, Jump_030_48C6
    ld a, d
    cp a, $02
    jr z, Jump_030_48F2
    dec a
    ld hl, wD2BD
    add_a_to_hl
    call Func_030_48F3

Jump_030_48F2::
    ret

; 2 call sites from 1 routine (e.g. Func_030_48B6)
; reads: wC58A, wD8A4, wC46B, wDAE9
; points at: wDAE9
Func_030_48F3::
    push de
    push hl
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4920
    cp a, $01
    jr z, Jump_030_490E
    ld a, [wD8A4]
    cp a, $00
    ld a, [wC46B]
    jr z, Jump_030_4923
    ld a, [wDAE9]
    jr Jump_030_4923

Jump_030_490E::
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld hl, wDAE9
    add_a_to_hl
    ld a, [hl]
    jr Jump_030_4923

Jump_030_4920::
    ld a, [wC46B]

Jump_030_4923::
    and a, $03
    cp a, $01
    jr z, Jump_030_492F
    and a, $01
    jr z, Jump_030_493A
    jr Jump_030_493C

Jump_030_492F::
    call Func_030_540C
    cp a, $03
    jr z, Jump_030_493A
    sla e
    jr Jump_030_493C

Jump_030_493A::
    ld e, $00

Jump_030_493C::
    pop hl
    ld a, e
    add a, [hl]
    ld [hl+], a
    ld a, $00
    adc a, [hl]
    ld [hl], a
    pop de
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC58A, wDA42, wD871
; points at: wDA3C, wDA42
Func_030_4946:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $03
    cp a, $03
    jr z, Jump_030_496E
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4959
    cp a, $02
    jr nz, Jump_030_4960

Jump_030_4959::
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_030_496E

Jump_030_4960::
    call Func_030_540C
    cp a, $03
    jr nz, Jump_030_496E

Jump_030_4967::
    ld b, $00
    call Func_030_541B
    ld [hl], b
    ret

Jump_030_496E::
    ld a, [wDA42]
    cp a, $06
    jr nc, Jump_030_4967
    ld hl, wDA3C
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_4998
    dec a
    call Func_030_5C68
    call JumpToHL
    call Func_030_541B
    ld b, [hl]
    ld a, [wD871]
    cp a, $FF
    ret z
    ld hl, wDA42
    inc [hl]
    jr Func_030_4946

Data_030_4998:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C0998, $12E

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC58A, wDA3F
; writes: wDA6B, wDA6C
; points at: wD988, wD2AD
Func_030_4AC6:: ; heuristic: target of a pointer table; C0
    ld hl, Data_030_59E0
    ld a, l
    ld [wDA6B], a
    ld a, h
    ld [wDA6C], a
    jr Jump_030_4ADE

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC58A, wDA3F
; writes: wDA6B, wDA6C
; points at: wD988, wD2AD
Func_030_4AD3:: ; heuristic: target of a pointer table; C0
    ld hl, Data_030_5785
    ld a, l
    ld [wDA6B], a
    ld a, h
    ld [wDA6C], a

Jump_030_4ADE::
    ld a, [wD8A4]
    and a, $03
    cp a, $03
    jr z, Jump_030_4B06
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4AF1
    cp a, $02
    jr nz, Jump_030_4AF8

Jump_030_4AF1::
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_030_4B06

Jump_030_4AF8::
    call Func_030_540C
    cp a, $03
    jr nz, Jump_030_4B06
    ld b, $00
    call Func_030_541B
    ld [hl], b
    ret

Jump_030_4B06::
    call Func_030_4C63
    ld a, [wD8A4]
    ld hl, wD988
    swap a
    add_a_to_hl
    ld de, wD2AD
    ld b, $08

Jump_030_4B1B::
    push bc
    push hl
    push de
    inc hl
    call Func_030_4B9F
    pop de
    pop hl
    ld a, [wDA3F]
    cp a, [hl]
    call z, Func_030_4B76
    inc hl
    inc hl
    inc de
    inc de
    pop bc
    dec b
    jr nz, Jump_030_4B1B
    ld a, $00
    push de
    call Func_030_4BA0
    pop de
    ld a, [wDA3F]
    cp a, $01
    call z, Func_030_4B76
    inc de
    inc de
    ld a, $AC
    push de
    call Func_030_4BA0
    pop de
    ld a, [wD8A4]
    and a, $03
    cp a, $03
    jr z, Jump_030_4B6F
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4B5E
    cp a, $02
    jr nz, Jump_030_4B65

Jump_030_4B5E::
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_030_4B6F

Jump_030_4B65::
    ld a, [wDA3F]
    cp a, $03
    call z, Func_030_4B76
    jr Jump_030_4B72

Jump_030_4B6F::
    call Func_030_4B88

Jump_030_4B72::
    call Func_030_4C00
    ret

; 3 call sites from 1 routine (e.g. Func_030_4AD3)
Func_030_4B76::
    push de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    bit 7, a
    jr nz, Jump_030_4B86
    sla c
    rla
    ld [de], a
    dec de
    ld a, c
    ld [de], a

Jump_030_4B86::
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_030_4AD3)
Func_030_4B88::
    push de
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    bit 7, a
    jr nz, Jump_030_4B9D
    srl a
    rr c
    srl a
    rr c
    ld [de], a
    dec de
    ld a, c
    ld [de], a

Jump_030_4B9D::
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_030_4AD3)
; reads: wCFF1, wDA6B, wDA6C, wDA6E, wDA6F, wDA70, wDA71
; writes: wDA6E, wDA6F, wDA70, wDA71
Func_030_4B9F::
    ld a, [hl]

; 2 call sites from 1 routine (e.g. Func_030_4AD3)
; reads: wCFF1, wDA6B, wDA6C, wDA6E, wDA6F, wDA70, wDA71
; writes: wDA6E, wDA6F, wDA70, wDA71
Func_030_4BA0::
    push de
    cp a, $FF
    jr z, Jump_030_4BFA
    call Func_030_4CAB
    ld e, a
    ld d, $00
    ld a, [wCFF1]
    bit 0, a
    jr z, Jump_030_4BFA
    ld a, [wDA6B]
    ld l, a
    ld a, [wDA6C]
    ld h, a
    add hl, de
    add hl, de
    add hl, de
    ld e, [hl]
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld h, a
    ld l, e
    xor a, a
    ld [wDA6E], a
    ld [wDA6F], a
    ld [wDA70], a
    ld [wDA71], a
    rst $10
    ld a, [wDA6E]
    ld c, a
    ld a, [wDA6F]
    ld b, a
    ld a, [wDA70]
    ld l, a
    ld a, [wDA71]
    ld h, a
    ld a, h
    and a, l
    cp a, $FF
    jr z, Jump_030_4BFA
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    pop hl
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    bit 7, a
    jr z, Jump_030_4BFF
    dec hl
    push hl

Jump_030_4BFA::
    pop hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a

Jump_030_4BFF::
    ret

; 1 call site from 1 routine (e.g. Func_030_4AD3)
; reads: wC5E7, wD8A4, hFFC6
; writes: hFFC6
; points at: wD2AD, wD989
Func_030_4C00::
    xor a, a
    ldh [hFFC6], a
    ld hl, $0000
    ld de, $0A00

Jump_030_4C09::
    ld a, e
    push hl
    ld hl, wD2AD
    add a, a
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop hl
    ld a, b
    and a, c
    cp a, $FF
    jr z, Jump_030_4C34
    call CompareHLToBC
    jr c, Jump_030_4C2F
    jr nz, Jump_030_4C34
    call Func_000_3ED4
    ld a, [wC5E7]
    bit 0, a
    jr z, Jump_030_4C34

Jump_030_4C2F::
    ld h, b
    ld l, c
    ld a, e
    ldh [hFFC6], a

Jump_030_4C34::
    inc e
    dec d
    jr nz, Jump_030_4C09
    ld a, [wD8A4]
    swap a
    ld hl, wD989
    add_a_to_hl
    ldh a, [hFFC6]
    cp a, $08
    jr z, Jump_030_4C58
    cp a, $09
    jr z, Jump_030_4C5C
    add a, a
    add_a_to_hl
    ld b, [hl]
    jr Jump_030_4C5E

Jump_030_4C58::
    ld b, $00
    jr Jump_030_4C5E

Jump_030_4C5C::
    ld b, $AC

Jump_030_4C5E::
    call Func_030_541B
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_030_4AD3)
; reads: wD8A4
; points at: wD2C1
Func_030_4C63::
    ld a, [wD8A4]
    call Func_030_5C3B
    ld d, h
    ld e, l
    ld a, [wD8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_030_4C75::
    push de
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_030_4C8D
    call Func_030_5C40
    srl h
    rr l
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    bit 7, a
    jr z, Jump_030_4C92

Jump_030_4C8D::
    ld de, $0000
    jr Jump_030_4C96

Jump_030_4C92::
    srl d
    rr e

Jump_030_4C96::
    ld a, c
    and a, $03
    ld hl, wD2C1
    add a, a
    add_a_to_hl
    ld [hl], e
    inc hl
    ld [hl], d
    pop de
    inc c
    dec b
    jr nz, Jump_030_4C75
    ret

; 1 call site from 1 routine (e.g. Func_030_4BA0)
; writes: wCFEC, wCFED
Func_030_4CAB::
    push de
    push af
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $F3
    ld l, a
    ld a, h
    adc a, $55
    ld h, a
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_030_4CC9
    dec hl
    ld a, [de]
    add a, [hl]
    ld [de], a
    inc hl
    inc de
    ld a, [de]
    adc a, [hl]
    ld [de], a
    call Func_030_4CDB

Jump_030_4CC9::
    pop af
    push af
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    farcall Func_01A_4001
    pop af
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_030_4CAB)
; reads: wC5E7
Func_030_4CDB::
    push af
    dec de
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $3F
    ld b, a
    ld a, [de]
    add a, b
    ld [de], a
    inc de
    ld a, [de]
    adc a, $00
    ld [de], a
    pop af
    ret

Jump_030_4CF0::
    call Func_030_4CFC
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    ret

; 2 call sites from 2 routines (e.g. Func_030_4CDB, Func_030_5440)
; reads: wC58A, wD8A4
Func_030_4CFC::
    ld a, [wC58A]
    or a, a
    jr z, Jump_030_4D06
    cp a, $02
    jr nz, Jump_030_4D0F

Jump_030_4D06::
    ld a, [wD8A4]
    cp a, $03
    jr nc, Jump_030_4D24
    jr Jump_030_4D18

Jump_030_4D0F::
    ld a, [wD8A4]
    and a, $03
    cp a, $03
    jr z, Jump_030_4D24

Jump_030_4D18::
    call Func_030_4D25
    ld a, c
    and a, b
    cp a, $FF
    jr z, Jump_030_4D24
    call Func_030_4F14

Jump_030_4D24::
    ret

; 1 call site from 1 routine (e.g. Func_030_4CFC)
Func_030_4D25::
    call Func_030_541B
    ld c, [hl]
    ld b, $00
    ld hl, Data_030_4D34
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

Data_030_4D34:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C0D34, $6A
    ds $10, $FF
    INCBIN "dwm2-cobi-us.gbc", $0C0DAE, $56
    ds $12, $FF
    db $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00
    db $04, $00, $04, $00, $FF, $FF, $10, $00, $80, $00, $04, $00, $04, $00, $04, $00
    db $10, $00
    ds $12, $FF
    db $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00, $04, $00
    db $04, $00, $02, $00, $20, $00, $0A, $00
    ds $10, $FF
    db $10, $00, $10, $00
    ds $12, $FF
    db $02, $00
    ds $8A, $FF

; 1 call site from 1 routine (e.g. Func_030_4CFC)
Func_030_4F14::
    ld e, $00
    ld d, $10
    ld hl, Func_030_4F46

Jump_030_4F1B::
    push hl
    push bc
    push de
    ld a, c
    and a, [hl]
    jr z, Jump_030_4F27
    call Func_030_4F3B
    jr Jump_030_4F2F

Jump_030_4F27::
    inc hl
    ld a, b
    and a, [hl]
    jr z, Jump_030_4F2F
    call Func_030_4F3B

Jump_030_4F2F::
    pop de
    pop bc
    pop hl
    jr c, Jump_030_4F3A
    inc hl
    inc hl
    inc e
    dec d
    jr nz, Jump_030_4F1B

Jump_030_4F3A::
    ret

; 2 call sites from 1 routine (e.g. Func_030_4F14)
Func_030_4F3B::
    ld d, $00
    ld hl, $4F66
    add hl, de
    add hl, de
    call Func_000_000B
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD8A4
; points at: wSlotPersonalityHi, wD854
Func_030_4F46:: ; heuristic: follows a terminator; C0
    ld bc, $0200
    nop
    inc b
    nop
    ld [$1000], sp
    nop
    jr nz, Jump_030_4F52

Jump_030_4F52::
    ld b, b
    nop
    add a, b
    nop
    nop
    ld bc, $0200
    nop
    inc b
    nop
    ld [$1000], sp
    nop
    jr nz, Jump_030_4F63

Jump_030_4F63::
    ld b, b
    nop
    add a, b
    add a, [hl]
    ld c, a
    adc a, [hl]
    ld c, a
    sub a, [hl]
    ld c, a
    sbc a, [hl]
    ld c, a
    and a, [hl]
    ld c, a
    xor a, [hl]
    ld c, a
    or a, [hl]
    ld c, a
    cp a, [hl]
    ld c, a
    add a, $4F
    add a, $4F
    add a, $4F
    add a, $4F
    add a, $4F
    add a, $4F
    add a, $4F
    add a, $4F
    ld hl, wSlotPersonalityHi
    ld de, $0001
    jr Jump_030_4FC8

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD8A4
; points at: wSlotPersonalityHi, wD854
Func_030_4F8E:: ; heuristic: follows a terminator; C0
    ld hl, wSlotPersonalityHi
    ld de, $0002
    jr Func_030_4FE9
    db $21, $70, $D9, $11, $04, $00, $18, $2A, $21, $70, $D9, $11, $08, $00, $18, $43
    db $21, $78, $D9, $11, $10, $00, $18, $1A, $21, $78, $D9, $11, $20, $00, $18, $33
    db $21, $80, $D9, $11, $40, $00, $18, $0A, $21, $80, $D9, $11, $80, $00, $18, $23
    db $AF, $C9

Jump_030_4FC8::
    call Func_000_3ED4
    ld a, [wC5E7]
    ld b, a
    ld a, [wD8A4]
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    ret c
    cp a, $A2
    jr c, Jump_030_500C
    cp a, $C3
    jr c, Jump_030_5010
    cp a, $E4
    jr c, Jump_030_5014
    jr Jump_030_5008

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD8A4
; points at: wD854
Func_030_4FE9:: ; heuristic: follows a terminator; C0
    call Func_000_3ED4
    ld a, [wC5E7]
    ld b, a
    ld a, [wD8A4]
    add_a_to_hl
    ld a, [hl]
    cp a, $80
    ret nc
    cp a, $60
    jr nc, Jump_030_500C
    cp a, $3F
    jr nc, Jump_030_5010
    cp a, $1E
    jr nc, Jump_030_5014

Jump_030_5008::
    ld c, $08
    jr Jump_030_5016

Jump_030_500C::
    ld c, $01
    jr Jump_030_5016

Jump_030_5010::
    ld c, $02
    jr Jump_030_5016

Jump_030_5014::
    ld c, $04

Jump_030_5016::
    ld a, b
    cp a, c
    ret nc
    ld a, [wD8A4]
    ld hl, wD854
    add a, a
    add_a_to_hl
    ld a, [hl]
    or a, e
    ld [hl+], a
    ld a, [hl]
    or a, d
    ld [hl], a
    scf
    ret

; 1 call site from 1 routine (e.g. Func_030_43C4)
; reads: wD8A4, wC0A0, wC0A8
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wC0A0
Func_030_502D::
    ld b, $00
    ld hl, wSlotPersonalityHi
    call Func_030_50AC
    ld hl, wSlotPersonalityMid
    call Func_030_50AC
    ld hl, wSlotPersonalityLo
    call Func_030_50AC
    ld a, b
    cp a, $03
    jr z, Jump_030_509A
    ld b, $00
    ld hl, wSlotPersonalityMid
    call Func_030_50BA
    ld hl, wSlotPersonalityLo
    call Func_030_50BA
    ld a, b
    cp a, $02
    jr nz, Jump_030_50A0
    ld hl, wC0A0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    call Func_030_50D2
    ld a, [wD8A4]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    cp a, $40
    jr c, Jump_030_507E
    ld a, [wC0A0]
    cp a, $FF
    jr z, Jump_030_50A6

Jump_030_507E::
    call Func_030_5129
    ld a, [wC0A8]
    cp a, $FF
    jr z, Jump_030_50A6
    call Func_030_519A
    ld a, [wC0A0]
    cp a, $FF
    jr z, Jump_030_50A6
    call Func_030_5209
    call Func_030_541B
    ld [hl], c
    ret

Jump_030_509A::
    call Func_030_541B
    ld [hl], $AB
    ret

Jump_030_50A0::
    call Func_030_541B
    ld [hl], $AC
    ret

Jump_030_50A6::
    call Func_030_541B
    ld [hl], $00
    ret

; 3 call sites from 1 routine (e.g. Func_030_502D)
; reads: wD8A4
Func_030_50AC::
    ld a, [wD8A4]
    add_a_to_hl
    ld a, [hl]
    cp a, $40
    ret nc
    inc b
    ret

; 2 call sites from 1 routine (e.g. Func_030_502D)
; reads: wD8A4
; points at: wSlotPersonalityHi
Func_030_50BA::
    ld a, [wD8A4]
    add_a_to_hl
    ld a, [wD8A4]
    ld de, wSlotPersonalityHi
    add a, e
    ld e, a
    jr nc, Jump_030_50CD
    inc d

Jump_030_50CD::
    ld a, [de]
    cp a, [hl]
    ret c
    inc b
    ret

; 1 call site from 1 routine (e.g. Func_030_502D)
; reads: wD8A4, wCFF1
; writes: wCFEC, wD868, wCFED, wD869, wD86A, wD86B
; points at: wD989, wCFF1, wC0A0
Func_030_50D2::
    ld a, [wD8A4]
    swap a
    ld hl, wD989
    add_a_to_hl
    ld b, $08
    ld c, $00

Jump_030_50E3::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_5123
    push hl
    push bc
    ld [wCFEC], a
    ld a, $03
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFF1
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall Func_01A_4022
    ld a, [wCFF1]
    and a, $03
    cp a, $02
    pop bc
    pop hl
    jr z, Jump_030_5123
    ld a, c
    ld de, wC0A0
    add a, e
    ld e, a
    jr nc, Jump_030_5120
    inc d

Jump_030_5120::
    ld a, [hl]
    ld [de], a
    inc c

Jump_030_5123::
    inc hl
    inc hl
    dec b
    jr nz, Jump_030_50E3
    ret

; 1 call site from 1 routine (e.g. Func_030_502D)
; reads: wD8A4, wCFEE
; writes: wCFEC, wD868, wCFED, wD869, wD86A, wD86B
; points at: wD8DF, wC0A0, wCFEE, wC0A8
Func_030_5129::
    ld a, [wD8A4]
    ld hl, wD8DF
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld hl, wC0A0
    ld e, $08
    ld d, $00

Jump_030_513F::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_5187
    push hl
    push bc
    push de
    ld [wCFEC], a
    ld a, $00
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFEE
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall Func_01A_4022
    pop de
    pop bc
    ld a, [wCFEE]
    ld l, a
    ld h, $00
    call CompareHLToBC
    jr c, Jump_030_5181
    ld a, d
    ld hl, wC0A0
    add_a_to_hl
    ld [hl], $FF

Jump_030_5181::
    inc d
    pop hl
    inc hl
    dec e
    jr nz, Jump_030_513F

Jump_030_5187::
    ld hl, wC0A8
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wC0A0
    ld de, wC0A8
    jr Jump_030_51CD

; 1 call site from 1 routine (e.g. Func_030_502D)
; points at: wC0A8, wC0A0
Func_030_519A::
    ld hl, wC0A8
    ld b, $08
    ld c, $00

Jump_030_51A1::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_51BC
    call Func_030_51DC
    jr c, Jump_030_51B7
    ld a, c
    ld de, wC0A8
    add a, e
    ld e, a
    jr nc, Jump_030_51B4
    inc d

Jump_030_51B4::
    ld a, $FF
    ld [de], a

Jump_030_51B7::
    inc c
    inc hl
    dec b
    jr nz, Jump_030_51A1

Jump_030_51BC::
    ld hl, wC0A0
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld hl, wC0A8
    ld de, wC0A0

Jump_030_51CD::
    ld b, $08

Jump_030_51CF::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_51D7
    ld a, [hl]
    ld [de], a
    inc de

Jump_030_51D7::
    inc hl
    dec b
    jr nz, Jump_030_51CF
    ret

; 1 call site from 1 routine (e.g. Func_030_519A)
Func_030_51DC::
    cp a, $01
    jr c, Jump_030_5204
    cp a, $16
    jr c, Jump_030_5207
    cp a, $3D
    jr c, Jump_030_5204
    cp a, $68
    jr c, Jump_030_5207
    cp a, $6B
    jr z, Jump_030_5207
    cp a, $6C
    jr z, Jump_030_5207
    cp a, $6D
    jr z, Jump_030_5207
    cp a, $6E
    jr z, Jump_030_5207
    cp a, $6F
    jr z, Jump_030_5207
    cp a, $70
    jr z, Jump_030_5207

Jump_030_5204::
    scf
    ccf
    ret

Jump_030_5207::
    scf
    ret

; 1 call site from 1 routine (e.g. Func_030_502D)
; reads: wC0A0, wCFEE
; writes: wCFEC, wD868, wCFED, wD869, wD86A, wD86B
; points at: wCFEE, wC0A1, wC0A0
Func_030_5209::
    ld a, [wC0A0]
    ld [wCFEC], a
    ld a, $00
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFEE
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall Func_01A_4022
    ld a, [wCFEE]
    ld c, a
    ld b, $00
    ld hl, wC0A1
    ld de, $0700

Jump_030_523A::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_030_527C
    push hl
    push de
    push bc
    ld [wCFEC], a
    ld a, $00
    ld [wD868], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wCFEE
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall Func_01A_4022
    ld a, [wCFEE]
    ld l, a
    ld h, $00
    pop bc
    pop de
    call CompareHLToBC
    jr c, Jump_030_5277
    ld c, l
    ld b, h
    ld a, $08
    sub a, d
    ld e, a

Jump_030_5277::
    pop hl
    inc hl
    dec d
    jr nz, Jump_030_523A

Jump_030_527C::
    ld a, e
    ld hl, wC0A0
    add_a_to_hl
    ld c, [hl]
    ret

; 2 call sites from 2 routines (e.g. Func_030_4595, Func_030_43C4)
; reads: wD8A4
; points at: wD80F
Func_030_5287::
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $40
    jr z, Jump_030_5299
    ld b, $CD
    jr Jump_030_52B4

Jump_030_5299::
    ld a, [hl+]
    and a, $04
    jr z, Jump_030_52A2
    ld b, $CC
    jr Jump_030_52B4

Jump_030_52A2::
    ld a, [hl+]
    and a, $10
    jr z, Jump_030_52AB
    ld b, $CE
    jr Jump_030_52B4

Jump_030_52AB::
    inc hl
    inc hl
    ld a, [hl]
    and a, $01
    jr z, Jump_030_52B4
    ld b, $CF

Jump_030_52B4::
    ret

; 2 call sites from 1 routine (e.g. Func_030_43C4)
; reads: wC58A, wD8A4
; writes: hFFC6, hFFC7, hFFC8, hFFC9
; points at: wD8B7, wD980
Func_030_52B5::
    ld a, [wC58A]
    or a, a
    ret nz
    ld a, [wD8A4]
    cp a, $03
    ret nc
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld bc, $0000
    ld a, [wD8A4]
    ld hl, wD8B7
    add_a_to_hl
    ld a, [hl]
    cp a, $0A
    jr c, Jump_030_52E8
    cp a, $14
    jr c, Jump_030_52EC
    cp a, $1E
    jr c, Jump_030_52F0
    ld c, $0C
    jr Jump_030_52F2

Jump_030_52E8::
    ld c, $00
    jr Jump_030_52F2

Jump_030_52EC::
    ld c, $04
    jr Jump_030_52F2

Jump_030_52F0::
    ld c, $08

Jump_030_52F2::
    ld de, $0000
    ld a, [wD8A4]
    ld hl, wD980
    add_a_to_hl
    ld a, [hl]
    cp a, $97
    jr c, Jump_030_5307
    ld e, $10

Jump_030_5307::
    call Func_030_540C
    ld hl, Data_030_5384
    call Func_030_5C68
    add hl, de
    add hl, bc
    call Func_030_5319
    call Func_030_533E
    ret

; 1 call site from 1 routine (e.g. Func_030_52B5)
; points at: hFFC6
Func_030_5319::
    push hl
    call Func_030_540C
    ld c, [hl]
    pop hl
    ld de, hFFC6
    call Func_030_5335
    inc hl
    inc de
    call Func_030_5335
    inc hl
    inc de
    call Func_030_5335
    inc hl
    inc de
    call Func_030_5335
    ret

; 4 call sites from 1 routine (e.g. Func_030_5319)
Func_030_5335::
    ld a, [hl]
    ld [de], a
    bit 6, c
    ret z
    cpl
    inc a
    ld [de], a
    ret

; 1 call site from 1 routine (e.g. Func_030_52B5)
; reads: wDAE8, hFFC6, hFFC7, hFFC8, hFFC9, wD8A4
; points at: hFFC6, wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo, wD980
Func_030_533E::
    ld a, [wDAE8]
    ld c, a
    ld b, $00
    ld hl, hFFC6
    add hl, bc
    ld e, [hl]
    push hl
    call Func_030_540C
    bit 6, [hl]
    pop hl
    jr z, Jump_030_5357
    ld a, e
    cpl
    inc a
    ld e, a
    ld [hl], e

Jump_030_5357::
    ldh a, [hFFC6]
    ld e, a
    ld hl, wSlotPersonalityHi
    call Func_030_5378
    ldh a, [hFFC7]
    ld e, a
    ld hl, wSlotPersonalityMid
    call Func_030_5378
    ldh a, [hFFC8]
    ld e, a
    ld hl, wSlotPersonalityLo
    call Func_030_5378
    ldh a, [hFFC9]
    ld e, a
    ld hl, wD980

; 3 call sites from 1 routine (e.g. Func_030_533E)
; reads: wD8A4
Func_030_5378::
    ld a, [wD8A4]
    add_a_to_hl
    call Func_030_5428
    ret

Data_030_5384:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C1384, $88

; 13 call sites from 12 routines (e.g. Func_030_48F3, Func_030_47B9, Func_030_46BA, Func_030_4617, ...)
; reads: wD8A4
; points at: wDA43
Func_030_540C::
    ld a, [wD8A4]
    ld hl, wDA43
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ret

; 12 call sites from 8 routines (e.g. Func_030_4D25, Func_030_4595, Func_030_502D, Func_030_5440, ...)
; reads: wD8A4
; points at: wDA1C
Func_030_541B::
    ld a, [wD8A4]
    add a, a
    ld hl, wDA1C
    add_a_to_hl
    ret

; 9 call sites from 6 routines (e.g. Func_030_47B9, Func_030_480E, Func_030_46BA, Func_030_469D, ...)
Func_030_5428::
    bit 7, e
    jr z, Jump_030_5438
    ld a, e
    cpl
    inc a
    ld e, a
    ld a, [hl]
    sub a, e
    jr nc, Jump_030_543E
    ld a, $00
    jr Jump_030_543E

Jump_030_5438::
    ld a, e
    add a, [hl]
    jr nc, Jump_030_543E
    ld a, $FF

Jump_030_543E::
    ld [hl], a
    ret

; 3 call sites from 2 routines (e.g. Func_032_4F0A, Func_0E0_5A35)
; reads: wD8A4
; writes: wPersonalityIndex, wD2CC
; points at: wDA53
Func_030_5440::
    ld a, [wD8A4]
    call PersonalityIndexOfSlot_Bank30
    ld [wPersonalityIndex], a
    call Func_030_5472
    ld a, $01
    ld [wD2CC], a
    ld a, [wD8A4]
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_030_45D0
    call Func_030_5C68
    call JumpToHL
    call Func_030_541B
    ld [hl], b
    call Func_030_4CFC
    xor a, a
    ld [wD2CC], a
    ret

; 1 call site from 1 routine (e.g. Func_030_5440)
; writes: wDA3C, wDA3D, wDA3E, wDA3F, wDA40, wDA41, wDA42, wD871
; points at: wD2AD
Func_030_5472::
    ld hl, wD2AD
    ld bc, $0014
    xor a, a
    call FillBytes
    xor a, a
    ld [wDA3C], a
    ld [wDA3D], a
    ld [wDA3E], a
    ld a, $01
    ld [wDA3F], a
    ld a, $02
    ld [wDA40], a
    ld a, $03
    ld [wDA41], a
    ld a, $03
    ld [wDA42], a
    call Func_030_54B5
    call Func_030_4617
    call Func_030_4688
    call Func_030_46BA
    call Func_030_54DA
    call Func_030_47B9
    call Func_030_483F
    ld a, $00
    ld [wD871], a
    ret

; 1 call site from 1 routine (e.g. Func_030_5472)
; reads: wCFF1
; points at: wDA3E, wDA3D, wDA3C
Func_030_54B5::
    ld a, [wCFF1]
    and a, $F0
    cp a, $10
    jr z, Jump_030_54C8
    cp a, $20
    jr z, Jump_030_54CD
    cp a, $30
    jr z, Jump_030_54D2
    jr Jump_030_54D9

Jump_030_54C8::
    ld hl, wDA3C
    jr Jump_030_54D5

Jump_030_54CD::
    ld hl, wDA3D
    jr Jump_030_54D5

Jump_030_54D2::
    ld hl, wDA3E

Jump_030_54D5::
    ld a, [hl]
    add a, $0A
    ld [hl], a

Jump_030_54D9::
    ret

; 1 call site from 1 routine (e.g. Func_030_5472)
; reads: wD8A4, wDA3E, wDA3C
; writes: wDA3E, wDA3C
; points at: wD2C8, wD8BF
Func_030_54DA::
    ld a, [wD8A4]
    rrca
    and a, $02
    xor a, $02
    ld hl, wD2C8
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wD8A4]
    rrca
    and a, $02
    ld hl, wD2C8
    add_a_to_hl
    deref_hl
    push hl
    ld a, [wD8A4]
    rlca
    and a, $08
    ld hl, wD8BF
    add_a_to_hl
    ld bc, $0000
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, Jump_030_5534
    ld a, [wDA3E]
    add a, $14
    ld [wDA3E], a

Jump_030_5534::
    ld a, [wD8A4]
    rlca
    and a, $08
    xor a, $08
    ld hl, wD8BF
    add_a_to_hl
    ld bc, $0000
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld a, [hl+]
    add a, c
    ld c, a
    ld a, [hl+]
    adc a, b
    ld b, a
    ld h, b
    ld l, c
    add hl, bc
    add hl, bc
    pop bc
    call CompareHLToBC
    jr nc, Jump_030_556B
    ld a, [wDA3C]
    add a, $14
    ld [wDA3C], a

Jump_030_556B::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC5F8, wC5FA, wC5E7, wC5F9
Func_030_556C:: ; heuristic: follows a terminator; C0
    call Func_000_3ED4
    call Func_030_541B
    ld a, [wC5F8]
    or a, a
    jr z, Jump_030_5586
    ld a, [wC5FA]
    ld b, a
    ld a, [wC5E7]
    cp a, b
    jr nc, Jump_030_5586
    ld a, [wC5F9]
    ld [hl], a

Jump_030_5586::
    ret

Data_030_5587:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C1587, $1AF
    ds $11, $00
    db $50, $00, $00, $00, $50, $00, $5A, $00, $3C
    ds $33, $00
    db $64, $00

Data_030_5785:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C1785, $189
    dw Data_030_5D83
    db $E2
    dw Data_030_5DBC
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5E46
    db $E2
    dw Data_030_5E83
    db $E2
    dw Data_030_5EC0
    db $E2
    dw Data_030_5F0A
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_6044
    db $E2
    dw Data_030_6089
    db $E2
    dw Data_030_60A6
    db $E2
    dw Data_030_60D7
    db $E2
    dw Data_030_6112
    db $E2
    dw Data_030_6139
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_618D
    db $E2
    dw Data_030_61C2
    db $E2
    dw Data_030_61CD
    db $E2
    dw Data_030_61E0
    db $E2
    dw Data_030_6249
    db $E2
    dw Data_030_62A4
    db $E2
    dw Data_030_6303
    db $E2
    dw Data_030_6350
    db $E2
    dw Data_030_6387
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_6401
    db $E2
    dw Data_030_641E
    db $E2
    dw Data_030_6425
    db $E2
    dw Data_030_6473
    db $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2, $FA, $63, $E2, $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $FA, $63, $E2
    db $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $01, $64, $E2, $1E, $64, $E2, $BF
    db $64, $E2, $BF, $64, $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C1
    db $E2

Data_030_59E0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C19E0, $189
    dw Data_030_5D83
    db $E2
    dw Data_030_5DBC
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5DED
    db $E2
    dw Data_030_5E46
    db $E2
    dw Data_030_5E83
    db $E2
    dw Data_030_5EC0
    db $E2
    dw Data_030_5F0A
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5F94
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_5FE8
    db $E2
    dw Data_030_6044
    db $E2
    dw Data_030_6089
    db $E2
    dw Data_030_60A6
    db $E2
    dw Data_030_60D7
    db $E2
    dw Data_030_6112
    db $E2
    dw Data_030_6139
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_6160
    db $E2
    dw Data_030_618D
    db $E2
    dw Data_030_61C2
    db $E2
    dw Data_030_61CD
    db $E2
    dw Data_030_61E0
    db $E2
    dw Data_030_6249
    db $E2
    dw Data_030_62A4
    db $E2
    dw Data_030_6303
    db $E2
    dw Data_030_6350
    db $E2
    dw Data_030_6387
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_63FA
    db $E2
    dw Data_030_6401
    db $E2
    dw Data_030_641E
    db $E2
    dw Data_030_6425
    db $E2
    dw Data_030_6473
    db $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64BF
    db $E2, $FA, $63, $E2, $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $FA, $63, $E2
    db $FA, $63, $E2, $BF, $64, $E2, $BF, $64, $E2, $01, $64, $E2, $1E, $64, $E2, $BF
    db $64, $E2, $BF, $64, $E2
    dw Data_030_648D
    db $E2
    dw Data_030_64BF
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C0
    db $E2
    dw Data_030_64C1
    db $E2

; 1 call site from 1 routine (e.g. Func_030_4C63)
; points at: wD8FF
Func_030_5C3B::
    ld hl, wD8FF
    jr Func_030_5C68

; 1 call site from 1 routine (e.g. Func_030_4C63)
; points at: wD90F
Func_030_5C40::
    ld hl, wD90F
    jr Func_030_5C68

; 1 call site from 1 routine (e.g. Func_030_478B)
; points at: wD8CF
Func_030_5C45::
    ld hl, wD8CF
    jr Func_030_5C68
    db $21, $EF, $D8, $18, $19

; 1 call site from 1 routine (e.g. Func_030_478B)
; points at: wD8BF
Func_030_5C4F::
    ld hl, wD8BF
    jr Func_030_5C68
    db $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30
    db $01, $24, $7E, $C9

; 5 call sites from 5 routines (e.g. Func_030_4595, Func_030_52B5, Func_030_450B, Func_030_5440, ...)
Func_030_5C68::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; 1 call site from 1 routine (e.g. Func_030_43C4)
AddDoubleAToHL_Bank30::
Func_030_5C72:: ; address name
    add a, a
    add_a_to_hl
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wD8A4
Func_030_5C79:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_030_5C8E
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_030_5C8E
    ld a, [wD8A4]
    cp a, $04
    ccf
    ret

Jump_030_5C8E::
    ld a, [wD8A4]
    cp a, $04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wD8A5
Func_030_5C94:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_030_5CA9
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_030_5CA9
    ld a, [wD8A5]
    cp a, $04
    ccf
    ret

Jump_030_5CA9::
    ld a, [wD8A5]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $0C1CAF, $43

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. Func_030_43C4, Func_030_5440)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank30::
Func_030_5CF2:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_030_5D0E
    ld l, $09
    cp a, $40
    jr nc, Jump_030_5D0E
    ld l, $12

Jump_030_5D0E::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_030_5D29
    ld l, $03
    cp a, $40
    jr nc, Jump_030_5D29
    ld l, $06

Jump_030_5D29::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_030_5D44
    ld l, $01
    cp a, $40
    jr nc, Jump_030_5D44
    ld l, $02

Jump_030_5D44::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
Func_030_5D49:: ; heuristic: follows a terminator; C0
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_030_5D63
    ld a, [hl]
    and a, $0C
    jr nz, Jump_030_5D63
    xor a, a
    jr Jump_030_5D64

Jump_030_5D63::
    scf

Jump_030_5D64::
    ld a, c
    pop bc
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
Func_030_5D68:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_030_5D77
    ld a, [hl]
    and a, $0C

Jump_030_5D77::
    pop hl
    ret
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_030_5D83:: ; heuristic: target of a monotone pointer table; C0
    ds $39, $00

Data_030_5DBC:: ; heuristic: target of a monotone pointer table; C0
    ds $31, $00

Data_030_5DED:: ; heuristic: target of a monotone pointer table; C0
    ds $59, $00

Data_030_5E46:: ; heuristic: target of a monotone pointer table; C0
    ds $3D, $00

Data_030_5E83:: ; heuristic: target of a monotone pointer table; C0
    ds $3D, $00

Data_030_5EC0:: ; heuristic: target of a monotone pointer table; C0
    ds $4A, $00

Data_030_5F0A:: ; heuristic: target of a monotone pointer table; C0
    ds $8A, $00

Data_030_5F94:: ; heuristic: target of a monotone pointer table; C0
    ds $54, $00

Data_030_5FE8:: ; heuristic: target of a monotone pointer table; C0
    ds $5C, $00

Data_030_6044:: ; heuristic: target of a monotone pointer table; C0
    ds $45, $00

Data_030_6089:: ; heuristic: target of a monotone pointer table; C0
    ds $1D, $00

Data_030_60A6:: ; heuristic: target of a monotone pointer table; C0
    ds $31, $00

Data_030_60D7:: ; heuristic: target of a monotone pointer table; C0
    ds $3B, $00

Data_030_6112:: ; heuristic: target of a monotone pointer table; C0
    ds $27, $00

Data_030_6139:: ; heuristic: target of a monotone pointer table; C0
    ds $27, $00

Data_030_6160:: ; heuristic: target of a monotone pointer table; C0
    ds $2D, $00

Data_030_618D:: ; heuristic: target of a monotone pointer table; C0
    ds $35, $00

Data_030_61C2:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_030_61CD:: ; heuristic: target of a monotone pointer table; C0
    ds $13, $00

Data_030_61E0:: ; heuristic: target of a monotone pointer table; C0
    ds $69, $00

Data_030_6249:: ; heuristic: target of a monotone pointer table; C0
    ds $5B, $00

Data_030_62A4:: ; heuristic: target of a monotone pointer table; C0
    ds $5F, $00

Data_030_6303:: ; heuristic: target of a monotone pointer table; C0
    ds $4D, $00

Data_030_6350:: ; heuristic: target of a monotone pointer table; C0
    ds $37, $00

Data_030_6387:: ; heuristic: target of a monotone pointer table; C0
    ds $73, $00

Data_030_63FA:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00

Data_030_6401:: ; heuristic: target of a monotone pointer table; C0
    ds $1D, $00

Data_030_641E:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00

Data_030_6425:: ; heuristic: target of a monotone pointer table; C0
    ds $4E, $00

Data_030_6473:: ; heuristic: target of a monotone pointer table; C0
    ds $1A, $00

Data_030_648D:: ; heuristic: target of a monotone pointer table; C0
    ds $32, $00

Data_030_64BF:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_030_64C0:: ; heuristic: target of a monotone pointer table; C0
    db $00

Data_030_64C1:: ; heuristic: target of a monotone pointer table; C0
    ds $1B3F, $00
