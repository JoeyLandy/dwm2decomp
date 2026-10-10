SECTION "Bank 36", ROMX[$4000], BANK[$36]
    db $36

; 2 call sites from 2 routines (e.g. Func_03A_6157, Func_03A_68C9)
; reads: wCFCB
Func_036_4001::
    ld a, [wCFCB]
    rst $00
    dw Jump_036_4025
    dw Jump_036_4077
    dw Jump_036_431F
    dw Jump_036_4356
    dw Jump_036_438A
    dw Jump_036_458E
    dw Jump_036_4603
    dw Jump_036_460B
    dw Jump_036_4776
    dw Jump_036_47F1
    dw Jump_036_4806
    dw Jump_036_48DE
    dw Jump_036_48FA
    dw Jump_036_4901
    dw Jump_036_4908
    dw Jump_036_490F

Jump_036_4025::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ld a, [wDABD]
    or a, a
    jr nz, Jump_036_4069
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4069
    ld a, [wD8A5]
    call Func_036_7F3C
    jr c, Jump_036_4069
    ld a, [wD8A5]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 5, [hl]
    jr z, Jump_036_4069
    farcall Func_0A3_4A5F
    ld a, c
    cp a, $FF
    jr z, Jump_036_4069
    ld [wC971], a
    ld d, $33
    farcall Func_03A_6EE5
    ret

Jump_036_4069::
    ld a, [wD8A5]
    ld hl, wD854
    add a, a
    add_a_to_hl
    res 5, [hl]

Jump_036_4077::
    ld a, [wCFCC]
    rst $00
    dw Jump_036_407F
    dw Jump_036_4127

Jump_036_407F::
    xor a, a
    ld [wC981], a
    ld a, [wDABD]
    or a, a
    jp nz, Jump_036_411F
    ld a, [wCFF2]
    cp a, $40
    jp z, Jump_036_4127
    and a, $F0
    cp a, $20
    jp z, Jump_036_4127
    ld a, [wCFF3]
    bit 4, a
    jr z, Jump_036_40ED
    ld a, [wD8A5]
    and a, $04
    ld c, a
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add_a_to_hl
    bit 6, [hl]
    jr z, Jump_036_40ED
    ld a, l
    add a, $5A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    rrca
    rrca
    and a, $03
    or a, c
    ld c, a
    call Func_036_7F3C
    jr c, Jump_036_40ED
    ld a, $01
    ld [wDAB2], a
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld [hl], c
    ld a, c
    ld [wD8A5], a
    ld d, $CB
    farcall Func_03A_7193
    ld hl, wCFCC
    inc [hl]
    ret

Jump_036_40ED::
    ld hl, wCFCC
    inc [hl]
    ld a, [wCFF3]
    bit 7, a
    jr nz, Jump_036_4102
    bit 4, a
    jr nz, Jump_036_4109
    bit 6, a
    jr nz, Jump_036_4110
    jr Jump_036_4117

Jump_036_4102::
    call Func_036_4162
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4109::
    call Func_036_421D
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4110::
    call Func_036_425A
    jr c, Jump_036_411E
    jr Jump_036_411C

Jump_036_4117::
    call Func_036_42AA
    jr c, Jump_036_411E

Jump_036_411C::
    jr Jump_036_4127

Jump_036_411E::
    ret

Jump_036_411F::
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]

Jump_036_4127::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ld a, [wD8A5]
    ld hl, wD80E
    call AddAx9ToHL
    bit 3, [hl]
    ret z
    ld a, [wCFF3]
    bit 3, a
    ret z
    res 3, [hl]
    ld d, $E9
    call Func_036_7E87
    jr c, Jump_036_414B
    inc d

Jump_036_414B::
    farcall Func_03A_7193
    ld a, $03
    ld [wDABE], a
    ld a, [wDAC0]
    res 4, a
    ld [wDAC0], a
    call Func_036_4FD1
    ret

; 1 call site from 1 routine (e.g. Func_036_4001)
; reads: wD8A5, wCFF5, wD8A6, wD8A4
; writes: wDAD1, wD8A5
; points at: wD812, wD854, wD810, wDA1D, wDABF
Func_036_4162::
    ld a, [wD8A5]
    call Func_036_7F5B
    jr z, Jump_036_4191
    ld a, [wCFF5]
    bit 5, a
    jr z, Jump_036_4191
    ld a, [wD8A6]
    cp a, $4E
    jr z, Jump_036_4189
    cp a, $4F
    jr z, Jump_036_4189
    ld a, $84
    call StoreWC60B
    call Func_036_4FD1
    ld d, $68
    jp Jump_036_4317

Jump_036_4189::
    call Func_036_4FD1
    ld d, $69
    jp Jump_036_4317

Jump_036_4191::
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [wD8A6]
    cp a, $4E
    jr z, Jump_036_41A2
    cp a, $4F
    jr nz, Jump_036_41AF

Jump_036_41A2::
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_036_421B

Jump_036_41AF::
    ld a, [wD8A5]
    call Func_036_7F3C
    jr c, Jump_036_421B
    ld a, [wD8A5]
    ld hl, wD854
    call AddDoubleAToHL_Bank36
    bit 5, [hl]
    jr nz, Jump_036_41D1
    ld a, [wD8A5]
    ld hl, wD812
    call AddAx9ToHL
    bit 5, [hl]
    jr z, Jump_036_421B

Jump_036_41D1::
    call Func_036_4F18
    jr c, Jump_036_4211
    push af
    ld a, [wD8A6]
    cp a, $CC
    jr nz, Jump_036_41EB
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a

Jump_036_41EB::
    pop af
    push af
    ld d, $C8
    farcall Func_03A_7193
    ld a, [wD8A5]
    ld [wDAD1], a
    pop af
    ld [wD8A5], a
    ld b, a
    ld a, [wD8A4]
    ld hl, wDA1D
    call AddDoubleAToHL_Bank36
    ld [hl], b
    ld hl, wDABF
    set 0, [hl]
    scf
    ret

Jump_036_4211::
    ld d, $C9
    farcall Func_03A_7193
    scf
    ret

Jump_036_421B::
    xor a, a
    ret

; 1 call site from 1 routine (e.g. Func_036_4001)
; reads: wD8A5, wD8A4
; writes: wDABE, wC981
; points at: wD80E
Func_036_421D::
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [wD8A5]
    ld hl, wD80E
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_036_4253
    res 6, [hl]
    ld a, $02
    ld [wDABE], a
    ld d, $C7
    farcall Func_03A_7193
    ld a, $01
    ld [wC981], a
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_4255
    ld d, $01
    call Func_036_4EB1
    scf
    ret

Jump_036_4253::
    xor a, a
    ret

Jump_036_4255::
    call Func_036_4FD1
    scf
    ret

; 1 call site from 1 routine (e.g. Func_036_4001)
; reads: wD8A5, wCFF5, wD8A4
; writes: wDABE, wC981
; points at: wD80E
Func_036_425A::
    call Func_036_42D3
    jp nc, Jump_036_4317
    ld a, [wD8A5]
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [hl]
    and a, $22
    jr z, Jump_036_42A3
    ld a, [wCFF5]
    bit 7, a
    jr z, Jump_036_42A3
    bit 1, [hl]
    jr nz, Jump_036_4280
    res 5, [hl]
    ld a, $01
    ld [wDABE], a

Jump_036_4280::
    call Func_036_7E87
    ld d, $C5
    jr c, Jump_036_4289
    ld d, $C6

Jump_036_4289::
    farcall Func_03A_7193
    ld a, $01
    ld [wC981], a
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_42A5
    ld d, $04
    call Func_036_4EB1
    scf
    ret

Jump_036_42A3::
    xor a, a
    ret

Jump_036_42A5::
    call Func_036_4FD1
    scf
    ret

; 1 call site from 1 routine (e.g. Func_036_4001)
; reads: wD8A5, wCFF5
Func_036_42AA::
    ld a, [wD8A5]
    call Func_036_7F5B
    jr z, Jump_036_42CB
    ld a, [wCFF5]
    bit 5, a
    jr z, Jump_036_42CB
    ld a, $84
    call StoreWC60B
    ld d, $68
    farcall Func_03A_7193
    call Func_036_4FD1
    scf
    ret

Jump_036_42CB::
    call Func_036_42D3
    jp nc, Jump_036_4317
    xor a, a
    ret

; 4 call sites from 4 routines (e.g. Func_036_42AA, Func_036_425A, Func_036_421D, Func_036_4162)
; reads: wD8A5, wCFF4, wD8A4
; writes: wDAD1, wD8A5, wC981
; points at: wD812, wDA1D, wDABF
Func_036_42D3::
    ld a, [wD8A5]
    ld hl, wD812
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Jump_036_4315
    ld a, [wCFF4]
    bit 0, a
    jr z, Jump_036_4315
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    call Func_036_7F3C
    jr c, Jump_036_4315
    ld a, [wD8A5]
    ld [wDAD1], a
    ld a, [wD8A4]
    ld hl, wDA1D
    call AddDoubleAToHL_Bank36
    ld [hl], c
    ld a, c
    ld [wD8A5], a
    ld a, $01
    ld [wC981], a
    ld hl, wDABF
    set 1, [hl]
    ld d, $CA
    xor a, a
    ret

Jump_036_4315::
    scf
    ret

Jump_036_4317::
    farcall Func_03A_7193
    scf
    ret

Jump_036_431F::
    ld hl, wCFCB
    inc [hl]
    ld a, [wDABD]
    or a, a
    jr z, Jump_036_4356
    ld a, [wDAB2]
    or a, a
    jr nz, Jump_036_4356
    call Func_036_433F
    ret z
    ld a, $82
    ld [wDAD2], a
    farcall Func_03A_4001
    ret

; 1 call site from 1 routine (e.g. Func_036_42D3)
; reads: wD8A6, wD8A4
; points at: wD80F
Func_036_433F::
    ld a, [wD8A6]
    cp a, $91
    jr z, Jump_036_4347
    ret

Jump_036_4347::
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $40
    xor a, $40
    ret

Jump_036_4356::
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A5]
    call Func_036_7F3C
    jr c, Jump_036_438A
    ld a, [wCFF4]
    bit 6, a
    jr z, Jump_036_438A
    ld a, [wD8A5]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_036_438A
    ld d, $35
    farcall Func_03A_6EE5
    call Func_036_4FD1
    ld a, $84
    call StoreWC60B
    ret

Jump_036_438A::
    call Func_036_454F
    jr z, Jump_036_439B
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_439B
    call Func_036_5009
    ret

Jump_036_439B::
    ld hl, wCFCB
    inc [hl]
    call Func_036_4582
    ret z
    ld a, [wCFF4]
    bit 1, a
    jr z, Jump_036_43D8
    ld a, [wD8A6]
    cp a, $CC
    jr nz, Jump_036_43BF
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_43D8

Jump_036_43BF::
    ld a, [wD8A5]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_036_43D8
    ld d, $66
    farcall Func_03A_7193
    jp Jump_036_4543

Jump_036_43D8::
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4431
    ld a, [wD8A5]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_4416
    cp a, $0C
    jr nz, Jump_036_4406
    ld a, [wD8A6]
    cp a, $CC
    jr nz, Jump_036_4406
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_4416

Jump_036_4406::
    ld a, $84
    call StoreWC60B
    ld d, $68
    farcall Func_03A_7193
    jp Jump_036_4543

Jump_036_4416::
    ld a, [wD8A5]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_036_4431
    cp a, $C0
    jr nz, Jump_036_4406
    ld a, [wD8A6]
    cp a, $CC
    jr z, Jump_036_4431
    jr Jump_036_4406

Jump_036_4431::
    ld a, [wCFF3]
    bit 0, a
    jr z, Jump_036_447F
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr z, Jump_036_4451
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $A0
    jr nc, Jump_036_4451
    jr Jump_036_4469

Jump_036_4451::
    ld a, [wD8A4]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jr z, Jump_036_447F
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $60
    jr nc, Jump_036_447F

Jump_036_4469::
    ld a, [wD8A4]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 2, [hl]
    jr nz, Jump_036_447F
    call Func_036_4FBC
    jp Jump_036_4543

Jump_036_447F::
    ld a, [wCFF4]
    bit 6, a
    jp z, Jump_036_4542
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $D0
    jp nz, Jump_036_4542
    ld bc, $0004
    add hl, bc
    ld a, [hl]
    and a, $03
    jp nz, Jump_036_4542
    inc hl
    ld a, [hl]
    and a, $30
    jp nz, Jump_036_4542
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $03
    jp nz, Jump_036_4542
    call Func_000_3ED4
    ld a, [wD8A5]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr z, Jump_036_44C8
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_4533

Jump_036_44C8::
    ld a, [wD8A4]
    ld hl, wD91F
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD91F
    call Func_036_7E5B
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_036_452B
    or a, l
    jr z, Jump_036_452B
    ld bc, $0320
    call CompareHLToBC
    jr nc, Jump_036_4517
    ld bc, $0258
    call CompareHLToBC
    jr nc, Jump_036_451B
    ld bc, $0190
    call CompareHLToBC
    jr nc, Jump_036_451F
    ld bc, $00C8
    call CompareHLToBC
    jr nc, Jump_036_4523
    ld bc, $0064
    call CompareHLToBC
    jr nc, Jump_036_4527
    ld b, $02
    jr Jump_036_452D

Jump_036_4517::
    ld b, $80
    jr Jump_036_452D

Jump_036_451B::
    ld b, $20
    jr Jump_036_452D

Jump_036_451F::
    ld b, $10
    jr Jump_036_452D

Jump_036_4523::
    ld b, $08
    jr Jump_036_452D

Jump_036_4527::
    ld b, $04
    jr Jump_036_452D

Jump_036_452B::
    ld b, $01

Jump_036_452D::
    ld a, [wC5E7]
    cp a, b
    jr nc, Jump_036_4542

Jump_036_4533::
    ld d, $D2
    farcall Func_03A_7193
    ld a, $84
    call StoreWC60B
    jr Jump_036_4543

Jump_036_4542::
    ret

Jump_036_4543::
    ld a, [wDAC0]
    res 4, a
    ld [wDAC0], a
    call Func_036_4FD1
    ret

; 1 call site from 1 routine (e.g. Func_036_433F)
; reads: wD8A6
Func_036_454F::
    ld a, [wD8A6]
    cp a, $35
    ret z
    cp a, $16
    ret z
    cp a, $17
    ret z
    cp a, $18
    ret z
    cp a, $1B
    ret z
    cp a, $1C
    ret z
    cp a, $1D
    ret z
    cp a, $1E
    ret z
    cp a, $1F
    ret z
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $98
    ret z
    cp a, $9A
    ret z
    cp a, $9D
    ret z
    cp a, $BB
    ret z
    cp a, $CE
    ret

; 1 call site from 1 routine (e.g. Func_036_433F)
; reads: wD8A6
Func_036_4582::
    ld a, [wD8A6]
    cp a, $6A
    ret z
    cp a, $A0
    ret z
    cp a, $A1
    ret

Jump_036_458E::
    ld hl, wCFCB
    inc [hl]
    ld a, [wCFF4]
    and a, $18
    jr z, Jump_036_4603
    bit 4, a
    jr z, Jump_036_45AA
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, Jump_036_4603

Jump_036_45AA::
    ld a, [wCFF4]
    bit 3, a
    jr z, Jump_036_45F7
    ld a, [wD8A4]
    ld hl, wD854
    call AddDoubleAToHL_Bank36
    bit 0, [hl]
    jr nz, Jump_036_45D3
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    bit 3, [hl]
    jr nz, Jump_036_45D3
    call Func_000_3ED4
    call Func_036_4918
    jr nc, Jump_036_45F7

Jump_036_45D3::
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    set 7, [hl]
    call Func_036_7E6C
    ld d, $9C
    jr c, Jump_036_45E7
    ld d, $9D

Jump_036_45E7::
    farcall Func_03A_7193
    ld a, $83
    call StoreWC60B
    ld hl, wCFCB
    inc [hl]
    ret

Jump_036_45F7::
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    ret

Jump_036_4603::
    ld hl, wCFCB
    inc [hl]
    call Func_036_6717
    ret

Jump_036_460B::
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    bit 7, [hl]
    jr z, Jump_036_4622
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz

Jump_036_4622::
    ld hl, wCFCB
    inc [hl]
    ld a, [wCFF4]
    bit 4, a
    jr z, Jump_036_464D
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr z, Jump_036_464D
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    jr Jump_036_46C7

Jump_036_464D::
    ld a, [wCFF4]
    bit 3, a
    jr z, Jump_036_4679
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    bit 7, [hl]
    jr z, Jump_036_4679
    res 7, [hl]
    call Func_036_7C85
    ld a, [wD8A4]
    call Func_036_7E2E
    call Func_036_4930
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    jr Jump_036_46EB

Jump_036_4679::
    ld a, [wCFF4]
    bit 5, a
    jr z, Jump_036_46A0
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_036_46A0
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    jr Jump_036_46C7

Jump_036_46A0::
    ld a, [wCFF3]
    bit 1, a
    jr z, Jump_036_46C7
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Jump_036_46C7
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_494E
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a

Jump_036_46C7::
    ld a, [wD8A4]
    ld hl, wD854
    call AddDoubleAToHL_Bank36
    bit 6, [hl]
    jr z, Jump_036_46EB
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld c, l
    ld b, h
    srl b
    rr c
    add hl, bc
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a

Jump_036_46EB::
    ld a, [wD8A5]
    ld hl, wD813
    call AddAx9ToHL
    ld a, [hl]
    and a, $07
    jr z, Jump_036_4742
    and a, $03
    ld c, a
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    jr nz, Jump_036_4713
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4742

Jump_036_470D::
    srl h
    rr l
    jr Jump_036_4723

Jump_036_4713::
    ld a, [wCFF4]
    bit 7, a
    jr z, Jump_036_4742
    bit 0, c
    jr nz, Jump_036_470D
    ld a, $0A
    call DivideHLByA

Jump_036_4723::
    ld a, [wD8A5]
    ld de, wD854
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_472F
    inc d

Jump_036_472F::
    ld a, [de]
    bit 1, a
    jr z, Jump_036_4738
    srl h
    rr l

Jump_036_4738::
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    jr Jump_036_4742

Jump_036_4742::
    ld a, [wD8A5]
    ld hl, wD812
    call AddAx9ToHL
    bit 2, [hl]
    jr z, Jump_036_4775
    ld a, [wCFF3]
    bit 7, a
    jr z, Jump_036_4775
    ld a, [wD8A6]
    cp a, $6F
    jr z, Jump_036_4775
    cp a, $70
    jr z, Jump_036_4775
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a

Jump_036_4775::
    ret

Jump_036_4776::
    ld a, [wD8A6]
    cp a, $CD
    jr nz, Jump_036_4787
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz

Jump_036_4787::
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    ld a, [wDAC0]
    ld b, a
    bit 5, a
    jr z, Jump_036_47B1
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_036_47A9
    set 4, b
    res 6, b
    jr Jump_036_47AD

Jump_036_47A9::
    res 4, b
    set 6, b

Jump_036_47AD::
    ld a, b
    ld [wDAC0], a

Jump_036_47B1::
    ld a, [wD8A6]
    cp a, $CF
    jr nz, Jump_036_47C7
    ld a, [wDAC0]
    bit 4, a
    ret z
    ld hl, wCFCB
    dec [hl]
    ld a, [wDABA]
    or a, a
    ret nz

Jump_036_47C7::
    ld b, $40
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_036_47D6
    bit 6, a
    jr nz, Jump_036_47D6
    set 0, b

Jump_036_47D6::
    ld a, b
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, [wDAC0]
    and a, $10
    or a, $20
    ld [wDAD3], a
    farcall Func_03A_5762
    ret

Jump_036_47F1::
    ld hl, wCFCB
    inc [hl]
    ld a, $13
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $85
    call StoreWC60B
    ret

Jump_036_4806::
    ld hl, wCFCB
    inc [hl]
    ld a, [wDAC0]
    bit 7, a
    jr z, Jump_036_484E
    bit 4, a
    jr z, Jump_036_4825
    ld a, [wDAC2]
    ld [wC0A0], a
    ld a, [wDAC0]
    bit 3, a
    call nz, Func_036_4991
    jr Jump_036_4833

Jump_036_4825::
    ld a, [wDAC3]
    ld [wC0A0], a
    ld a, [wDAC1]
    bit 3, a
    call nz, Func_036_4A38

Jump_036_4833::
    ld a, [wD8A6]
    cp a, $DC
    jr z, Jump_036_484E
    cp a, $D7
    jr nz, Jump_036_4844
    farcall Func_032_67AA

Jump_036_4844::
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193

Jump_036_484E::
    call Func_036_4961
    ld a, [wDAC0]
    bit 4, a
    jr nz, Jump_036_4859
    ret

Jump_036_4859::
    ld a, [wD8A6]
    cp a, $3A
    jr z, Jump_036_4879
    cp a, $3B
    jr z, Jump_036_4890
    cp a, $B8
    jr z, Jump_036_4890
    cp a, $32
    jr z, Jump_036_48AE
    cp a, $77
    jr z, Jump_036_48AE
    cp a, $DC
    jr z, Jump_036_48B5
    cp a, $DF
    jr z, Jump_036_48A3
    ret

Jump_036_4879::
    ld a, [wD8A5]
    add a, a
    ld de, wD958
    add a, e
    ld e, a
    jr nc, Jump_036_4885
    inc d

Jump_036_4885::
    ld a, [wD8A4]
    ld b, a
    call Func_036_4E26
    call Func_036_70F4
    ret

Jump_036_4890::
    ld de, wC0A0
    ld a, $60
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [wD8A4]
    ld b, a
    call Func_036_4E26
    ret

Jump_036_48A3::
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    call SetBit1OfWD095Indexed_Bank36

Jump_036_48AE::
    ld a, [wD8A4]
    call SetBit1OfWD095Indexed_Bank36
    ret

Jump_036_48B5::
    ld a, [wD8A4]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_036_48CB
    pop af
    ld [wD8A4], a

; 1 call site from 1 routine (e.g. Func_036_4582)
; reads: wD8A4
; points at: wC0A0
Func_036_48CB::
    ld de, wC0A0
    ld a, $61
    ld [de], a
    inc de
    ld a, $01
    ld [de], a
    dec de
    ld a, [wD8A4]
    ld b, a
    call Func_036_4E26
    ret

Jump_036_48DE::
    ld a, [wD8A6]
    cp a, $82
    jp z, Jump_036_4A9D
    cp a, $83
    jp z, Jump_036_4B16
    cp a, $84
    jp z, Jump_036_4B16
    cp a, $B3
    jp z, Jump_036_4B16
    ld hl, wCFCB
    inc [hl]
    ret

Jump_036_48FA::
    farcall Func_032_59DF
    ret

Jump_036_4901::
    farcall Func_032_5A3A
    ret

Jump_036_4908::
    farcall Func_032_5EAB
    ret

Jump_036_490F::
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    ret

; 1 call site from 1 routine (e.g. Func_036_4582)
; reads: hFFC6, wC5E7
Func_036_4918::
    push bc
    push hl
    farcall Func_0A3_49D5
    pop hl
    pop bc
    ldh a, [hFFC6]
    ld b, a
    cp a, $03
    jr nz, Jump_036_492B
    ld b, $04

Jump_036_492B::
    ld a, [wC5E7]
    cp a, b
    ret

; 3 call sites from 3 routines (e.g. Func_036_4582, Func_036_7353, Func_036_7314)
Func_036_4930::
    push hl
    ld bc, $0014
    call Func_000_3F04
    ld e, l
    ld d, h
    pop bc
    push bc
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    ld a, e
    cpl
    add a, $01
    ld e, a
    ld a, d
    cpl
    adc a, $00
    ld d, a
    add hl, de
    call Func_000_3E98
    ret

; 1 call site from 1 routine (e.g. Func_036_4582)
Func_036_494E::
    ld c, l
    ld b, h
    srl b
    rr c
    sla l
    rl h
    push hl
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E98
    ret

; 2 call sites from 2 routines (e.g. Func_036_4A38, Func_036_4582)
; reads: wDAC0, wDABD, wDABF, wDAD1, wD8A4
; writes: wD8A5, wDAD1
; points at: wDA1D
Func_036_4961::
    ld a, [wDAC0]
    bit 4, a
    ret nz
    ld a, [wDABD]
    or a, a
    ret nz
    call Func_036_5009
    ld a, [wDABF]
    or a, a
    ret z
    ld a, [wDAD1]
    cp a, $FF
    ret z
    ld [wD8A5], a
    ld b, a
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld [hl], b
    ld a, $FF
    ld [wDAD1], a
    ret

; 1 call site from 1 routine (e.g. Func_036_4582)
; reads: wD8A6, wDABF, wDAC2
; writes: wC0A0
; points at: wC0A0, wD872
Func_036_4991::
    ld a, [wD8A6]
    cp a, $6C
    jr nz, Jump_036_49A1

Jump_036_4998::
    call Func_036_7E87
    ret nc
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_49A1::
    ld a, [wDABF]
    bit 0, a
    jr nz, Jump_036_4998
    call Func_036_7E6C
    ret c
    ld a, [wD8A6]
    cp a, $34
    jr z, Jump_036_49FC
    cp a, $AD
    jr z, Jump_036_49FC
    cp a, $78
    jr z, Jump_036_49FC
    cp a, $13
    jr z, Jump_036_4A01
    cp a, $14
    jr z, Jump_036_4A01
    cp a, $15
    jr z, Jump_036_4A13
    cp a, $2B
    jr z, Jump_036_4A23
    cp a, $2C
    jr z, Jump_036_4A23
    cp a, $79
    jr z, Jump_036_4A01
    cp a, $80
    jr z, Jump_036_4A07
    cp a, $92
    jr z, Jump_036_4A0D
    cp a, $B5
    jr z, Jump_036_4A29
    cp a, $BA
    jr z, Jump_036_4A32
    cp a, $BF
    jr z, Jump_036_49FC
    cp a, $C0
    jr z, Jump_036_49FC
    cp a, $C9
    jr z, Jump_036_49FC
    cp a, $CA
    jr z, Jump_036_49FC
    cp a, $CB
    jr z, Jump_036_49FC

Jump_036_49F7::
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_49FC::
    ld hl, wC0A0
    dec [hl]
    ret

Jump_036_4A01::
    ld a, $8A
    ld [wC0A0], a
    ret

Jump_036_4A07::
    ld a, $56
    ld [wC0A0], a
    ret

Jump_036_4A0D::
    ld a, $63
    ld [wC0A0], a
    ret

Jump_036_4A13::
    ld hl, wD872
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    jr z, Jump_036_4A01
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_4A23::
    ld a, $CD
    ld [wC0A0], a
    ret

Jump_036_4A29::
    ld a, [wDAC2]
    cp a, $73
    jr z, Jump_036_49F7
    jr Jump_036_49FC

Jump_036_4A32::
    ld a, $78
    ld [wC0A0], a
    ret

; 1 call site from 1 routine (e.g. Func_036_4582)
; reads: wD8A6
; writes: wC0A0
; points at: wC0A0
Func_036_4A38::
    call Func_036_7E6C
    ret c
    ld a, [wD8A6]
    cp a, $72
    jr z, Jump_036_4A74
    cp a, $73
    jr z, Jump_036_4A74
    cp a, $74
    jr z, Jump_036_4A74
    cp a, $75
    jr z, Jump_036_4A7A
    cp a, $7E
    jr z, Jump_036_4A80
    cp a, $7F
    jr z, Jump_036_4A86
    cp a, $80
    jr z, Jump_036_4A8C
    cp a, $8B
    jr z, Jump_036_4A8C
    cp a, $8C
    jr z, Jump_036_4A8C
    cp a, $8F
    jr z, Jump_036_4A92
    cp a, $AA
    jr z, Jump_036_4A92
    cp a, $C0
    jr z, Jump_036_4A98
    ld hl, wC0A0
    inc [hl]
    ret

Jump_036_4A74::
    ld a, $6A
    ld [wC0A0], a
    ret

Jump_036_4A7A::
    ld a, $6B
    ld [wC0A0], a
    ret

Jump_036_4A80::
    ld a, $6C
    ld [wC0A0], a
    ret

Jump_036_4A86::
    ld a, $6D
    ld [wC0A0], a
    ret

Jump_036_4A8C::
    ld a, $6E
    ld [wC0A0], a
    ret

Jump_036_4A92::
    ld a, $71
    ld [wC0A0], a
    ret

Jump_036_4A98::
    ld hl, wC0A0
    dec [hl]
    ret

Jump_036_4A9D::
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, [wCFCC]
    or a, a
    jr z, Jump_036_4AE5
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    call Func_036_6E75
    ld a, [wCFCA]
    cp a, $05
    ret z
    ld a, [wDAC0]
    bit 4, a
    ld a, $99
    call nz, StoreWC60B
    ld a, [wDAC3]
    ld d, a
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_036_4AE1
    ld a, [wDAC2]
    ld d, a
    farcall Func_03A_7193

Jump_036_4AE1::
    call Func_036_4961
    ret

Jump_036_4AE5::
    call Func_036_6E40
    ld a, [wDAC0]
    bit 4, a
    ld a, $87
    call nz, StoreWC60B
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_036_4B06
    ld a, [wDAC2]
    ld d, a
    call Func_036_7E6C
    jr c, Jump_036_4B0A
    ld d, $CD
    jr Jump_036_4B0A

Jump_036_4B06::
    ld a, [wDAC3]
    ld d, a

Jump_036_4B0A::
    farcall Func_03A_7193
    ld a, $01
    ld [wCFCC], a
    ret

Jump_036_4B16::
    ld a, [wCFCC]
    rst $00
    dw Jump_036_4B26
    dw Jump_036_4B41
    dw Jump_036_4D42
    dw Jump_036_4D7F
    dw Jump_036_4DD6
    dw Jump_036_4DF3

Jump_036_4B26::
    ld hl, wCFCC
    inc [hl]
    ld a, [wD8A5]
    ld hl, wD80E
    call AddAx9ToHL
    bit 6, [hl]
    ret z
    res 6, [hl]
    ld d, $80
    farcall Func_03A_7193
    ret

Jump_036_4B41::
    ld hl, wCFCC
    inc [hl]
    ld hl, wCFCC
    inc [hl]
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    jp z, Jump_036_4CCF
    ld a, [hl]
    and a, $CF
    ld [hl], a
    ld hl, wCFCC
    dec [hl]
    ld d, $5F
    farcall Func_03A_7193
    push hl
    farcall Func_0A3_4A02
    ld a, [wD8A5]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    pop hl
    ld a, $01
    ld [wD868], a
    ld a, [wD8A5]
    ld c, a
    farcall Func_019_434D
    call Func_036_4D0C
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4001
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    call Func_036_7E42
    call CompareHLToBC
    jr c, Jump_036_4BCC
    ld a, [wD8A5]
    call SetBit0OfWD095Indexed_Bank36
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b

Jump_036_4BCC::
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4045
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD8EF
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    call Func_036_7E47
    call CompareHLToBC
    jr c, Jump_036_4C07
    ld a, [wD8A5]
    call SetBit1OfWD095Indexed_Bank36
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b

Jump_036_4C07::
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4089
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD8FF
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4155
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD92F
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    ld c, a
    farcall Func_019_4298
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4199
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD8B7
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_41D3
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD968
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_420D
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD970
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4247
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD978
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4281
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD980
    add_a_to_hl
    ld [hl], c

Jump_036_4CCF::
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4111
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD91F
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_40CD
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD90F
    call AddDoubleAToHL_Bank36
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_036_4A38)
; reads: wD8A5
; writes: wD868, wD869, wD86A, wD86B
; points at: wDA72
Func_036_4D0C::
    ld a, [wD8A5]
    ld b, a
    and a, $03
    cp a, $03
    ret z
    ld a, b
    ld e, $31
    call Func_000_3F32
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, [wD8A5]
    ld de, wDA72
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_4D33
    inc d

Jump_036_4D33::
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ret

Jump_036_4D42::
    ld hl, wCFCC
    inc [hl]
    ld a, [wD8A5]
    ld b, a
    add a, a
    ld de, wD958
    add a, e
    ld e, a
    jr nc, Jump_036_4D53
    inc d

Jump_036_4D53::
    call Func_036_4E26
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld a, [wC58A]
    cp a, $01
    ret z
    ld a, [wD8A5]
    cp a, $04
    ret c
    and a, $03
    cp a, $03
    ret z
    ld hl, wDAD4
    add_a_to_hl
    ld [hl], $FF
    ret

Jump_036_4D7F::
    ld hl, wCFCC
    inc [hl]
    ld a, [wD8A5]
    and a, $03
    cp a, $03
    ret nz
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    ret c
    ld d, $7F
    farcall Func_03A_7193
    ld a, [wD8A5]
    ld hl, wDA63
    add_a_to_hl
    ld [hl], $FF
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FF
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wD8A5]
    and a, $04
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    res 2, [hl]
    ret

Jump_036_4DD6::
    ld hl, wCFCC
    inc [hl]
    ld a, [wD8A5]
    ld hl, wD814
    call AddAx9ToHL
    bit 4, [hl]
    ret z
    res 4, [hl]
    ld a, $FF
    ld [wDAAC], a
    ld a, $FF
    ld [wDAAD], a
    ret

Jump_036_4DF3::
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ld a, [wD80A]
    and a, $93
    ld [wD80A], a
    ld a, [wD80B]
    and a, $93
    ld [wD80B], a
    ld a, [wD8A6]
    cp a, $83
    ret z
    ld a, [wD80A]
    or a, $08
    ld [wD80A], a
    ld a, [wD80B]
    or a, $08
    ld [wD80B], a
    ret

; 5 call sites from 4 routines (e.g. Func_036_48CB, Func_036_4582, Func_036_4D0C, Func_036_6C9A)
; reads: wC58A, wC57F, wIsCGB, wD890, wC985, wC984
; writes: wC526, hFFC6
Func_036_4E26::
    ld a, [wC58A]
    cp a, $01
    ld a, b
    jr nz, Jump_036_4E3C
    ld a, [wC57F]
    bit 1, a
    ld a, b
    jr z, Jump_036_4E3C
    cp a, $03
    jr nc, Jump_036_4EB0
    jr Jump_036_4E46

Jump_036_4E3C::
    cp a, $04
    jr c, Jump_036_4EB0
    cp a, $07
    jr z, Jump_036_4EB0
    sub a, $04

Jump_036_4E46::
    push de
    push af
    ld bc, $0240
    call Func_000_16AA
    ld bc, vTiles2 + $140
    add hl, bc
    pop af
    pop de
    sla a
    add a, $01
    ld c, a
    push bc
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld d, a
    ld e, b
    push de
    call Func_000_1FE3
    pop de
    pop bc
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $7F
    ld [wC526], a
    ld a, c
    ldh [hFFC6], a
    ld a, [wC58A]
    cp a, $01
    ld a, [wD890]
    jr nz, Jump_036_4E8A
    ld a, [wC57F]
    bit 1, a
    ld a, [wC985]
    jr z, Jump_036_4E8A
    ld a, [wC984]

Jump_036_4E8A::
    cp a, $01
    jr z, Jump_036_4E97
    cp a, $03
    jr z, Jump_036_4E9C
    ld hl, vBGMap0 + $E4
    jr Jump_036_4E9F

Jump_036_4E97::
    ld hl, vBGMap0 + $E7
    jr Jump_036_4E9F

Jump_036_4E9C::
    ld hl, vBGMap0 + $E1

Jump_036_4E9F::
    ld a, c
    sub a, $01
    srl a
    ld b, a
    add a, a
    add a, b
    add a, a
    add_a_to_hl
    call Func_000_2090

Jump_036_4EB0::
    ret

; 2 call sites from 2 routines (e.g. Func_036_425A, Func_036_421D)
; reads: wD8A4, wD8A5, wDABA, wDABD
; writes: wD8A4, wD8A5, wDABD
; points at: wDAC9, wDA1C
Func_036_4EB1::
    push de
    ld hl, wDAC9
    ld a, [wD8A4]
    ld [hl+], a
    ld a, [wD8A5]
    ld [hl+], a
    ld a, [wDABA]
    ld [hl+], a
    ld a, [wD8A4]
    ld de, wDA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_4ECD
    inc d

Jump_036_4ECD::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, [wD8A5]
    ld bc, wDA1C
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_036_4EDE
    inc b

Jump_036_4EDE::
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a
    ld a, [wD8A4]
    ld [bc], a
    dec bc
    dec de
    ld a, [de]
    ld [bc], a
    ld a, [wD8A4]
    ld l, a
    ld a, [wD8A5]
    ld h, a
    ld a, h
    ld [wD8A4], a
    ld a, l
    ld [wD8A5], a
    pop de
    bit 0, d
    jr nz, Jump_036_4F06
    bit 2, d
    jr nz, Jump_036_4F06
    jr Jump_036_4F06

Jump_036_4F06::
    ld a, [wDABD]
    or a, d
    ld [wDABD], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wCFCA, wCFCB
Func_036_4F0E:: ; heuristic: follows a terminator; C0
    ld a, $03
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

; 1 call site from 1 routine (e.g. Func_036_4162)
; reads: wD8A5, wC971, wC5E7
; points at: wD854, wD86D
Func_036_4F18::
    ld a, [wD8A5]
    ld hl, wD854
    add a, a
    add_a_to_hl
    bit 5, [hl]
    jr z, Jump_036_4F2E
    ld a, [wC971]
    scf
    ccf
    ret

Jump_036_4F2E::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $33
    jp c, Jump_036_4FBA
    cp a, $66
    jr c, Jump_036_4F80
    ld a, $FF
    ld hl, wD86D
    ld bc, $0003
    call FillBytes
    ld a, [wD8A5]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_036_4F54::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_4F65
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld [hl], c
    inc e

Jump_036_4F65::
    inc c
    dec b
    jr nz, Jump_036_4F54

; 1 call site from 1 routine (e.g. Func_036_4F69)
; points at: wD86D
Func_036_4F69::
    ld hl, $0000
    ld b, $00
    dec e
    ld c, e
    call Func_000_3E98
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld a, [hl]
    scf
    ccf
    ret

Jump_036_4F80::
    ld a, $FF
    ld hl, wD86D
    ld bc, $0003
    call FillBytes
    ld a, [wD8A5]
    ld d, a
    ld a, [wD8A5]
    and a, $04
    ld c, a
    ld b, $03
    ld e, $00

Jump_036_4F99::
    ld a, c
    cp a, d
    jr z, Jump_036_4FAE
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_4FAE
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld [hl], c
    inc e

Jump_036_4FAE::
    inc c
    dec b
    jr nz, Jump_036_4F99
    ld a, e
    or a, a
    jr z, Jump_036_4FBA
    call Func_036_4F69
    ret

Jump_036_4FBA::
    scf
    ret

; 1 call site from 1 routine (e.g. Func_036_433F)
Func_036_4FBC::
    ld a, $84
    call StoreWC60B
    call Func_036_7E6C
    ld d, $D0
    jr c, Jump_036_4FCA
    ld d, $D1

Jump_036_4FCA::
    farcall Func_03A_7193
    ret

; 8 call sites from 6 routines (e.g. Func_036_433F, Func_036_4001, Func_036_42AA, Func_036_425A, ...)
; reads: wD8A6, wD8A4
; writes: wCFCA, wCFCB
; points at: wD810
Func_036_4FD1::
    ld a, [wD8A6]
    cp a, $CC
    jr z, Jump_036_4FF3
    ld a, [wD8A6]
    cp a, $D0
    jr c, Jump_036_4FE9
    cp a, $E4
    jr nc, Jump_036_4FE9
    farcall Func_0A3_413F

Jump_036_4FE9::
    ld a, $02
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_036_4FF3::
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    cp a, $04
    jr nz, Jump_036_4FE9
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr Jump_036_4FE9

; 2 call sites from 2 routines (e.g. Func_036_4961, Func_036_433F)
; writes: wCFCA, wCFCB
Func_036_5009::
    ld a, $03
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

; 14 call sites from 13 routines (e.g. Func_036_5522, Func_036_6098, Func_036_5533, Func_036_5544, ...)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_5013::
    call Func_000_3ED4
    ld a, [wD8A5]
    ld hl, wD90F
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    call Func_036_650B

; 2 call sites from 1 routine (e.g. Func_036_50DC)
; reads: wD8A4
; writes: wD872, wD873
Func_036_5025::
    ld a, [wD8A4]
    call Func_036_7E2E
    call CompareHLToBC
    jr z, Jump_036_504E
    jr c, Jump_036_504E
    ld a, l
    sub a, c
    ld e, a
    ld a, h
    sbc a, b
    ld d, a
    srl d
    rr e
    push hl
    push bc
    ld b, d
    ld c, e
    call Func_036_6510
    call CompareHLToBC
    pop bc
    pop hl
    jr z, Jump_036_5059
    jr nc, Jump_036_5059
    jr Jump_036_5066

Jump_036_504E::
    ld hl, $0000
    ld bc, $0001
    call Func_000_3E98
    jr Jump_036_508B

Jump_036_5059::
    call Func_036_6510
    ld c, l
    ld b, h
    ld hl, $0000
    call Func_000_3E98
    jr Jump_036_508B

Jump_036_5066::
    ld l, e
    ld h, d
    push hl
    call Func_036_6510
    ld c, l
    ld b, h
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call Func_000_3E98
    pop hl
    add hl, de
    push hl
    ld hl, rIE
    ld bc, $0001
    call Func_000_3E98
    pop hl
    add hl, de
    ld e, l
    ld d, h

Jump_036_508B::
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ret

; 1 call site from 1 routine (e.g. Func_036_6912)
Func_036_5094:: ; heuristic: follows a terminator; C0
    call Func_036_6159
    ld a, $00
    call Func_036_621C
    ret

; 1 call site from 1 routine (e.g. Func_036_691E)
Func_036_509D:: ; heuristic: follows a terminator; C0
    call Func_036_5A6C
    call Func_036_6594
    cp a, $00
    jr z, Jump_036_50AE
    cp a, $08
    jr z, Jump_036_50AE
    cp a, $09
    ret nz

Jump_036_50AE::
    call Func_036_6451
    ret

; 1 call site from 1 routine (e.g. Func_036_692A)
Func_036_50B2:: ; heuristic: follows a terminator; C0
    call Func_036_5A6C
    call Func_036_6594
    cp a, $01
    jr z, Jump_036_50C3
    cp a, $03
    jr z, Jump_036_50C3
    cp a, $06
    ret nz

Jump_036_50C3::
    call Func_036_6451
    ret

; 1 call site from 1 routine (e.g. Func_036_6936)
Func_036_50C7:: ; heuristic: follows a terminator; C0
    call Func_036_5A6C
    call Func_036_6594
    cp a, $02
    jr z, Jump_036_50D8
    cp a, $05
    jr z, Jump_036_50D8
    cp a, $04
    ret nz

Jump_036_50D8::
    call Func_036_6451
    ret

; 1 call site from 1 routine (e.g. Func_036_6957)
; reads: wD8A4, wD872, wD873, hFFC6
; writes: wD8A4, wD872, wD873
Func_036_50DC:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    push af
    call Func_000_3ED4
    ld bc, $0000
    call Func_036_5025
    ld a, [wD872]
    ld e, a
    ld a, [wD873]
    ld d, a
    push de
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_000_3ED4
    ld bc, $0000
    call Func_036_5025
    pop de
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    pop af
    ld [wD8A4], a
    ret

; 1 call site from 1 routine (e.g. Func_036_6963)
; reads: wD8A4, wD872, wD873, hFFC6
; writes: wD8A4, wD872, wD873
Func_036_511D:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    push af
    call Func_036_5013
    ld a, [wD872]
    ld e, a
    ld a, [wD873]
    ld d, a
    push de
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_036_5013
    pop de
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    pop af
    ld [wD8A4], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D9152, $7F

; 1 call site from 1 routine (e.g. Func_036_6B7B)
Func_036_51D1::
    call Func_036_6159
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_621C
    ret

; 1 call site from 1 routine (e.g. Func_036_6B81)
Func_036_51DF::
    call Func_036_6159
    call Func_036_61A6
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

; 1 call site from 1 routine (e.g. Func_036_6B87)
Func_036_51ED::
    call Func_036_6159
    call Func_036_61A6
    and a, $03
    call Func_036_621C
    ret

; 1 call site from 1 routine (e.g. Func_036_6B8D)
Func_036_51F9::
    call Func_036_6159

; 2 call sites from 2 routines (e.g. Func_036_592E, Func_036_58C5)
Func_036_51FC::
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_621C
    ret

; 2 call sites from 2 routines (e.g. Func_036_6906, Func_036_6B93)
Func_036_5207::
    call Func_036_6159

; 1 call site from 1 routine (e.g. Func_036_5993)
Func_036_520A::
    call Func_036_61AB
    swap a
    and a, $03
    call Func_036_621C
    ret

; 1 call site from 1 routine (e.g. Func_036_6B99)
Func_036_5215::
    call Func_036_6159
    call Func_036_61AB
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

; 2 call sites from 2 routines (e.g. Func_036_697B, Func_036_6C24)
; reads: wD8A6, wD872, wD873, wD8A5, wD8A4, wC58A
; writes: wD872, wD873
; points at: wD8BF, wD8CF, wDAFA
Func_036_5223::
    ld a, [wD8A6]
    cp a, $18
    jp z, Jump_036_52CC
    cp a, $1A
    jp z, Jump_036_52CC
    cp a, $20
    jr z, Jump_036_5251
    cp a, $B1
    jr z, Jump_036_5251
    cp a, $7B
    jr z, Jump_036_5251
    cp a, $CF
    jr z, Jump_036_528B
    cp a, $DA
    jr z, Jump_036_5251

Jump_036_5244::
    call Func_036_6159
    ld a, [wD872]
    ld e, a
    ld a, [wD873]
    ld d, a
    jr Jump_036_5265

Jump_036_5251::
    ld a, [wD8A5]
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a

Jump_036_5265::
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wD8A5]
    call Func_036_7E38
    call CompareHLToBC
    jr nc, Jump_036_5285
    ld b, h
    ld c, l

Jump_036_5285::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret

Jump_036_528B::
    ld a, [wD8A5]
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ld a, [wD8A4]
    ld hl, wDAFA
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr z, Jump_036_5265
    push af
    call Func_036_640D
    ld a, [wD872]
    ld e, a
    ld a, [wD873]
    ld d, a
    pop af
    dec a
    jr z, Jump_036_5265
    sra d
    rr e
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    jr Jump_036_5265

Jump_036_52CC::
    ld a, [wC58A]
    cp a, $01
    jp z, Jump_036_5251
    ld a, [wD8A4]
    bit 2, a
    jp z, Jump_036_5251
    jp Jump_036_5244

; 1 call site from 1 routine (e.g. Func_036_6C5E)
; reads: wD8A6, wD8A5
; writes: wD872, wD873
; points at: wD8DF
Func_036_52DF::
    ld a, [wD8A6]
    cp a, $1B
    jr z, Jump_036_52EF
    cp a, $1C
    jr z, Jump_036_52F4
    ld de, $0050
    jr Jump_036_52F7

Jump_036_52EF::
    ld de, $000F
    jr Jump_036_52F7

Jump_036_52F4::
    ld de, $001E

Jump_036_52F7::
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    ld a, l
    add a, e
    ld c, a
    ld a, h
    adc a, d
    ld b, a
    ld a, [wD8A5]
    call Func_036_7E3D
    call CompareHLToBC
    jr nc, Jump_036_531F
    ld b, h
    ld c, l

Jump_036_531F::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    scf
    ret
    db $37, $3F, $C9

; 1 call site from 1 routine (e.g. Func_036_71A9)
Func_036_5328::
    call Func_036_6159
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_6232
    ret

; 1 call site from 1 routine (e.g. Func_036_71AF)
Func_036_5336::
    call Func_036_6159
    call Func_036_61BA
    swap a
    and a, $03
    call Func_036_6232
    ret

; 1 call site from 1 routine (e.g. Func_036_71B8)
Func_036_5344::
    call Func_036_6159
    call Func_036_61BA
    rrca
    rrca
    and a, $03
    call Func_036_6232
    ret

; 1 call site from 1 routine (e.g. Func_036_71D3)
Func_036_5352::
    call Func_036_6159
    call Func_036_61C4
    swap a
    and a, $03
    call Func_036_621C
    ret

; 2 call sites from 2 routines (e.g. Func_036_6A82, Func_036_6DCB)
; reads: wD8A5, wD8A6, wD872, wD873
; writes: wD872, wD873
; points at: wD90F
Func_036_5360::
    ld a, [wD8A5]
    call Func_036_6521
    jr nc, Jump_036_53C4
    jr z, Jump_036_53C4
    ld a, [wD8A5]
    call Func_036_6634
    ld a, [wD8A6]
    cp a, $25
    jr z, Jump_036_5380
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_5383

Jump_036_5380::
    call Func_036_650B

Jump_036_5383::
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a
    ld a, [wD8A5]
    ld hl, wD90F
    call AddDoubleAToHL_Bank36
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [wD8A5]
    push hl
    call Func_036_6521
    pop hl
    jr c, Jump_036_53C2
    ld a, [hl-]
    ld e, [hl]
    ld d, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    ld a, [wD872]
    sub a, e
    ld e, a
    ld a, [wD873]
    sbc a, d
    ld d, a
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a

Jump_036_53C2::
    scf
    ret

Jump_036_53C4::
    xor a, a
    ret

; 2 call sites from 2 routines (e.g. Func_036_7645, Func_036_6DF2)
; reads: wD8A6
; writes: wD86A
Func_036_53C6::
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    swap a
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_53DC
    scf
    ret

Jump_036_53DC::
    and a, $03
    ld b, a
    ld a, [wD8A6]
    cp a, $8C
    ld a, b
    jr z, Jump_036_53EB
    call Func_036_61D6
    ret

Jump_036_53EB::
    call Func_036_620F
    ret

; 1 call site from 1 routine (e.g. Func_036_6DF8)
; reads: wD8A5, wD8A6
; writes: wD872, wD873
; points at: wD90F
Func_036_53EF::
    ld a, [wD8A5]
    call Func_036_7E33
    ld b, h
    ld c, l
    ld hl, $0001
    call CompareHLToBC
    jr c, Jump_036_5401
    xor a, a
    ret

Jump_036_5401::
    ld a, [wD8A5]
    call Func_036_6634
    ld a, [wD8A6]
    cp a, $27
    jr z, Jump_036_5417
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_541A

Jump_036_5417::
    call Func_036_650B

Jump_036_541A::
    ld a, [wD8A5]
    ld hl, wD90F
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld h, [hl]
    or a, h
    pop hl
    jr z, Jump_036_543F
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    jr nc, Jump_036_543D
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_036_543D::
    scf
    ret

Jump_036_543F::
    xor a, a
    ret

; 2 call sites from 2 routines (e.g. Func_036_6A82, Func_036_6E13)
; reads: wD8A5, wD8A6, wD872, wD873
; writes: wD872, wD873
; points at: wD91F
Func_036_5441::
    ld a, [wD8A5]
    call Func_036_6558
    jr nc, Jump_036_54A5
    ld a, [wD8A5]
    call Func_036_6646
    ld a, [wD8A6]
    cp a, $29
    jr z, Jump_036_545F
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_5462

Jump_036_545F::
    call Func_036_650B

Jump_036_5462::
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a
    ld a, [wD8A5]
    ld hl, wD91F
    call AddDoubleAToHL_Bank36
    ld a, [hl]
    add a, c
    ld [hl+], a
    ld a, [hl]
    adc a, b
    ld [hl], a
    ld a, [wD8A5]
    push hl
    call Func_036_6558
    pop hl
    jr c, Jump_036_54A3
    dec hl
    ld a, [hl+]
    sub a, c
    ld e, a
    ld a, [hl]
    sbc a, b
    ld d, a
    ld a, b
    ld [hl-], a
    ld [hl], c
    ld a, [wD872]
    ld c, a
    ld a, [wD873]
    ld b, a
    ld a, c
    sub a, e
    ld e, a
    ld a, b
    sbc a, d
    ld d, a
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a

Jump_036_54A3::
    scf
    ret

Jump_036_54A5::
    xor a, a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_54A7:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    rrca
    rrca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_54BA
    scf
    ret

Jump_036_54BA::
    call Func_036_61D6
    ret

; 1 call site from 1 routine (e.g. Func_036_6E40)
; reads: wD8A5, wD8A6
; writes: wD872, wD873
; points at: wD91F
Func_036_54BE::
    ld a, [wD8A5]
    call Func_036_6646
    ld a, [wD8A6]
    cp a, $2B
    jr z, Jump_036_54D4
    ld l, c
    ld h, b
    call Func_036_64DB
    ld c, l
    ld b, h
    jr Jump_036_54D7

Jump_036_54D4::
    call Func_036_650B

Jump_036_54D7::
    ld a, [wD8A5]
    ld hl, wD91F
    call AddDoubleAToHL_Bank36
    push hl
    ld d, $00
    deref_hl
    call CompareHLToBC
    jr nz, Jump_036_54ED
    ld d, $01

Jump_036_54ED::
    push bc
    ld bc, $0002
    call CompareHLToBC
    pop bc
    pop hl
    jr c, Jump_036_5520
    ld a, c
    sub a, d
    ld c, a
    ld a, b
    sbc a, $00
    ld b, a
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a
    ld a, [hl]
    ld e, a
    sub a, c
    ld [hl+], a
    ld a, [hl]
    ld d, a
    sbc a, b
    ld [hl], a
    jr nc, Jump_036_551E
    xor a, a
    ld [hl-], a
    ld [hl], $01
    dec de
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a

Jump_036_551E::
    scf
    ret

Jump_036_5520::
    xor a, a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5522:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61A6
    swap a
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5533:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5544:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    swap a
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_5555:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    rrca
    rrca
    and a, $03
    call Func_036_6248
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_5566:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $00
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_5571:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $01
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_557C:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $02
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_5587:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $03
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_5592:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $05
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_559D:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $04
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_55A8:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $06
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_55B3:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $07
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_55BE:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $08
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A4
; writes: wD872, wD873
; points at: wD90F
Func_036_55C9:: ; heuristic: follows a terminator; C0
    call Func_036_6594
    cp a, $09
    jp nz, Func_036_5013
    jp Func_036_66E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD872, wD873
; writes: wD872, wD873
; points at: wD8A7
Func_036_55D4:: ; heuristic: follows a terminator; C0
    call Func_036_5013
    ld a, [wD8A5]
    ld hl, wD8A7
    add_a_to_hl
    bit 0, [hl]
    jr z, Jump_036_55FA
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6465
    inc hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a

Jump_036_55FA::
    ret

; 2 call sites from 2 routines (e.g. Func_036_6E75, Func_036_74F6)
; reads: wD8A6
Func_036_55FB::
    ld a, [wD8A6]
    cp a, $82
    jr z, Jump_036_5611
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5613

Jump_036_5611::
    scf
    ret

Jump_036_5613::
    and a, $03
    ld b, a
    ld a, [wD8A6]
    cp a, $7E
    ld a, b
    jr z, Jump_036_5622
    call Func_036_61D6
    ret

Jump_036_5622::
    call Func_036_61F9
    ret

; 1 call site from 1 routine (e.g. Func_036_6EFC)
; writes: wD86A
Func_036_5626:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    rrca
    rrca
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_563C
    scf
    ret

Jump_036_563C::
    call Func_036_61D6
    ret

; 2 call sites from 1 routine (e.g. Func_036_6EFC)
; reads: wD8A4
; points at: wD8DF, wD8F0
Func_036_5640:: ; heuristic: follows a terminator; C0
    call Func_036_5671
    ld a, [wD8A4]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    add hl, bc
    ld b, h
    ld c, l
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A4]
    call Func_036_65D6
    jr nc, Jump_036_5670
    ld a, [wD8A4]
    ld bc, wD8F0
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_036_566B
    inc b

Jump_036_566B::
    ld a, [bc]
    ld [hl-], a
    dec bc
    ld a, [bc]
    ld [hl], a

Jump_036_5670::
    ret

; 2 call sites from 2 routines (e.g. Func_036_5640, Func_036_746B)
; reads: wD8A5, wD8A6, wC982, wC983, wD8A4
; writes: wD872, wD873
; points at: wD8DF, wD8B7
Func_036_5671::
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [wD8A6]
    cp a, $DF
    jr nz, Jump_036_568C
    ld a, [wC982]
    ld c, a
    ld a, [wC983]
    ld b, a
    jr Jump_036_56AE

Jump_036_568C::
    deref_hl
    or a, h
    jr z, Jump_036_56B8
    ld a, [wD8A4]
    ld de, wD8B7
    add a, e
    ld e, a
    jr nc, Jump_036_569D
    inc d

Jump_036_569D::
    ld a, [de]
    srl a
    srl a
    add a, $05
    ld c, a
    ld b, $00
    call CompareHLToBC
    jr nc, Jump_036_56AE
    ld b, h
    ld c, l

Jump_036_56AE::
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a
    jr Jump_036_56C3

Jump_036_56B8::
    ld bc, $0000
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a

Jump_036_56C3::
    pop hl
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_036_6F96)
Func_036_56CB:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_56DC
    scf
    ret

Jump_036_56DC::
    call Func_036_61D6
    ret

; 1 call site from 1 routine (e.g. Func_036_6FC1)
; reads: wD8A6
Func_036_56E0:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    rlca
    rlca
    and a, $03
    push af
    ld a, [wD8A6]
    cp a, $E1
    jr nz, Jump_036_56F5
    pop af
    xor a, a
    push af

Jump_036_56F5::
    pop af
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_56FF
    scf
    ret

Jump_036_56FF::
    call Func_036_620F
    ret

; 1 call site from 1 routine (e.g. Func_036_70CC)
; reads: wD8A5, wD8A4, wC58A, wCFF1
; writes: wD868, wD869, wD86A, wD86B, wCFEC, wCFED
; points at: wD8A7, wD8BF, wD8CF, wD8DF, wD8EF, wD8FF, wD90F, wD91F, ...
Func_036_5703:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    call Func_036_66D6
    ld a, [wD8A4]
    ld hl, wD8A7
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    call Func_036_65E8
    ld a, [wD8A4]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, Jump_036_5737
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A4]
    call SetBit0OfWD095Indexed_Bank36

Jump_036_5737::
    ld a, [wD8A4]
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A5]
    call Func_036_6605
    ld a, [wD8A4]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    push hl
    deref_hl
    call CompareHLToBC
    pop hl
    jr c, Jump_036_5765
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A4]
    call SetBit1OfWD095Indexed_Bank36

Jump_036_5765::
    ld a, [wD8A4]
    ld hl, wD8EF
    call AddDoubleAToHL_Bank36
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A4]
    ld hl, wD8FF
    call AddDoubleAToHL_Bank36
    ld a, [wD8A5]
    call Func_036_6622
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A4]
    ld hl, wD90F
    call AddDoubleAToHL_Bank36
    ld a, [wD8A5]
    call Func_036_6634
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A4]
    ld hl, wD91F
    call AddDoubleAToHL_Bank36
    ld a, [wD8A5]
    call Func_036_6646
    ld a, c
    ld [hl+], a
    ld [hl], b
    ld a, [wD8A5]
    call Func_036_6658
    ld a, [wD8A4]
    ld de, wDA72
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_57BD
    inc d

Jump_036_57BD::
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ld a, [wD8A5]
    call Func_036_669E
    ld a, [wD8A4]
    ld de, wD988
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_57E6
    inc d

Jump_036_57E6::
    ld c, $00

Jump_036_57E8::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_036_584D
    cp a, $C8
    jr z, Jump_036_584D
    push af
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_5822
    ld a, [wD8A5]
    cp a, $04
    jr nc, Jump_036_5811
    pop af
    cp a, $34
    jr nz, Jump_036_5809
    ld a, $AD
    jr Jump_036_5823

Jump_036_5809::
    cp a, $35
    jr nz, Jump_036_5823
    ld a, $AE
    jr Jump_036_5823

Jump_036_5811::
    pop af
    cp a, $AD
    jr nz, Jump_036_581A
    ld a, $34
    jr Jump_036_5823

Jump_036_581A::
    cp a, $AE
    jr nz, Jump_036_5823
    ld a, $35
    jr Jump_036_5823

Jump_036_5822::
    pop af

Jump_036_5823::
    push af
    push hl
    push de
    push bc
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    farcall Func_01A_4001
    pop bc
    pop de
    pop hl
    ld a, [wCFF1]
    swap a
    and a, $0F
    ld [de], a
    inc de
    pop af
    ld [de], a
    inc hl
    inc de
    inc c
    dec b
    jr nz, Jump_036_57E8
    ld a, c
    cp a, $08
    jr z, Jump_036_585B

Jump_036_584D::
    ld a, $00
    ld [de], a
    inc de
    ld a, $FF
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $08
    jr nz, Jump_036_584D

Jump_036_585B::
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D985C, $69

; 1 call site from 1 routine (e.g. Func_036_71C1)
; reads: wD8A4, wC58A, wD872, wD873
; writes: wD872, wD873
; points at: wD8B7
Func_036_58C5::
    ld a, [wD8A4]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld b, h
    ld c, l
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_58E8
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_036_58E8
    call Func_036_650B
    jr Jump_036_58ED

Jump_036_58E8::
    add hl, bc
    add hl, bc
    ld bc, $000A

Jump_036_58ED::
    add hl, bc
    ld bc, $00B4
    call CompareHLToBC
    jr c, Jump_036_58F9
    ld hl, $00B4

Jump_036_58F9::
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call Func_036_64D4
    call Func_036_651C
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call Func_000_3E98
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_51FC
    ret

; 1 call site from 1 routine (e.g. Func_036_71C7)
; reads: wD8A4, wC58A, wD872, wD873
; writes: wD872, wD873
; points at: wD8B7
Func_036_592E::
    ld a, [wD8A4]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_594E
    cp a, $04
    jr c, Jump_036_594E
    ld b, h
    ld c, l
    call Func_036_650B
    jr Jump_036_5952

Jump_036_594E::
    add hl, hl
    ld bc, $001E

Jump_036_5952::
    add hl, bc
    ld bc, $0096
    call CompareHLToBC
    jr c, Jump_036_595E
    ld hl, $0096

Jump_036_595E::
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call Func_036_64CD
    call Func_036_6518
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call Func_000_3E98
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_51FC
    ret

; 1 call site from 1 routine (e.g. Func_036_71CD)
; reads: wD8A4, wC58A, wD872, wD873
; writes: wD872, wD873
; points at: wD8B7
Func_036_5993::
    ld a, [wD8A4]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_59B6
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_036_59B6
    ld b, h
    ld c, l
    call Func_036_650B
    jr Jump_036_59BA

Jump_036_59B6::
    add hl, hl
    ld bc, $0014

Jump_036_59BA::
    add hl, bc
    push hl
    call Func_036_6594
    cp a, $09
    jr z, Jump_036_59C8
    ld bc, $00B4
    jr Jump_036_59CB

Jump_036_59C8::
    ld bc, $00DC

Jump_036_59CB::
    pop hl
    call CompareHLToBC
    jr c, Jump_036_59D3
    ld l, c
    ld h, b

Jump_036_59D3::
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call Func_036_64CD
    call Func_036_6518
    ld b, h
    ld c, l
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    call Func_000_3E98
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, de
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_520A
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wC58A, wD8A4, wCFFB, wCFFC, wCFFD, wD872, wD873, ...
; writes: wCFEC, wCFED, wD86A, wD872, wD873
Func_036_5A08:: ; heuristic: follows a terminator; C0
    ld a, [wD8A6]
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    farcall Func_01A_4001
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_5A33
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_036_5A33
    ld a, [wCFFB]
    ld l, a
    ld a, [wCFFC]
    ld h, a
    ld a, [wCFFD]
    jr Jump_036_5A3E

Jump_036_5A33::
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF8]
    ld h, a
    ld a, [wCFF9]

Jump_036_5A3E::
    ld [wD86A], a
    call Func_036_618F
    call Func_036_6594
    cp a, $07
    jr nz, Jump_036_5A5E
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_646C
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a

Jump_036_5A5E::
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61AB
    rlca
    rlca
    and a, $03
    call Func_036_6232
    ret

; 4 call sites from 4 routines (e.g. Func_036_509D, Func_036_50B2, Func_036_50C7, Func_036_6942)
Func_036_5A6C::
    call Func_036_6159
    call Func_036_61C4
    rrca
    rrca
    and a, $03
    call Func_036_621C
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873
Func_036_5A7A:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    call Func_036_7E42
    call Func_036_64A3
    inc hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    and a, $03
    call Func_036_621C
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC58A, wCFC5, wD8A5, wD872, wD873
; writes: wD872, wD873
Func_036_5A98:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    and a, $03
    call Func_036_61D6
    jr nc, Jump_036_5AF5
    ld a, [wD8A4]
    call Func_036_7E42
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    deref_hl
    ld a, h
    or a, a
    jr nz, Jump_036_5ABF
    ld a, l
    cp a, $01
    jr z, Jump_036_5AEB

Jump_036_5ABF::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_036_5AD8
    ld a, [wCFC5]
    or a, a
    jr z, Jump_036_5ACF
    cp a, $01
    jr nz, Jump_036_5AD8

Jump_036_5ACF::
    ld a, [wD8A5]
    call Func_036_7E42
    dec hl
    jr Jump_036_5AE4

Jump_036_5AD8::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    dec hl
    call Func_036_651C

Jump_036_5AE4::
    ld a, h
    or a, l
    jr nz, Jump_036_5AEB
    ld hl, $0001

Jump_036_5AEB::
    scf
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_5AF5::
    ld hl, $0000
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    xor a, a
    ret

; 1 call site from 1 routine (e.g. Func_036_7434)
Func_036_5B02:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    swap a
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B15
    scf
    ret

Jump_036_5B15::
    call Func_036_620F
    ret

; 2 call sites from 2 routines (e.g. Func_036_757F, Func_036_6B9F)
; reads: wD8A6, wD86A
; writes: wD86A
Func_036_5B19:: ; heuristic: follows a terminator; C0
    call Func_036_6141
    jp z, Jump_036_613D
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    swap a
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B35
    scf
    ret

Jump_036_5B35::
    ld a, [wD8A6]
    cp a, $13
    jr c, Jump_036_5B4F
    cp a, $14
    jr z, Jump_036_5B4F
    cp a, $79
    jr z, Jump_036_5B4F
    cp a, $82
    jr z, Jump_036_5B56
    ld a, [wD86A]
    call Func_036_61D6
    ret

Jump_036_5B4F::
    ld a, [wD86A]
    call Func_036_620F
    ret

Jump_036_5B56::
    ld a, [wD86A]
    call Func_036_61F9
    ret

; 5 call sites from 5 routines (e.g. Func_036_5D91, Func_036_76F4, Func_036_76CD, Func_036_7645, ...)
; reads: wD8A6
Func_036_5B5D:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [wD8A6]
    cp a, $7A
    jr z, Jump_036_5B7D
    cp a, $8E
    jr z, Jump_036_5B7D
    cp a, $90
    jr z, Jump_036_5B7D
    ld a, b
    call Func_036_61D6
    jr Jump_036_5B8A

Jump_036_5B7D::
    ld a, b
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5B87
    scf
    ret

Jump_036_5B87::
    call Func_036_620F

Jump_036_5B8A::
    ret

; 1 call site from 1 routine (e.g. Func_036_757F)
; reads: wD8A5
; points at: wD90F, wD91F, wD80D
Func_036_5B8B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD90F
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_036_5BC2
    ld a, [wD8A5]
    ld hl, wD91F
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_036_5BC2
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr z, Jump_036_5BC2
    xor a, a
    ret

Jump_036_5BC2::
    scf
    ret

; 1 call site from 1 routine (e.g. Func_036_75AB)
; reads: wD871, wCFEC, wCFED, wCFF5, wCFF6, wCFF7, wCFF8, wCFF9, ...
; writes: wCFE6, wCFE7, wD006, wD007, wD868, wD869, wD86A, wD86B
; points at: wD80C, wDA63, wDAAE, wD958, wD8B7, wD8BF, wD8CF, wD8DF, ...
Func_036_5BC4:: ; heuristic: follows a terminator; C0
    ld a, [wD871]
    ld hl, wD80C
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wD871]
    ld hl, wDA63
    add_a_to_hl
    ld [hl], $00
    ld a, [wD871]
    srl a
    srl a
    and a, $01
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wCFE6], a
    ld a, h
    ld [wCFE7], a
    farcall Func_034_4001
    ld a, [wCFEC]
    ld c, a
    ld a, [wCFED]
    ld b, a
    ld hl, wD958
    call Func_036_5D84
    ld a, [wCFF5]
    ld c, a
    ld hl, wD8B7
    call Func_036_5D7A
    ld a, [wCFF6]
    ld c, a
    ld a, [wCFF7]
    ld b, a
    ld hl, wD8BF
    call Func_036_5D84
    ld a, [wCFF6]
    ld c, a
    ld a, [wCFF7]
    ld b, a
    ld hl, wD8CF
    call Func_036_5D84
    ld a, [wCFF8]
    ld c, a
    ld a, [wCFF9]
    ld b, a
    ld hl, wD8DF
    call Func_036_5D84
    ld a, [wCFF8]
    ld c, a
    ld a, [wCFF9]
    ld b, a
    ld hl, wD8EF
    call Func_036_5D84
    ld a, [wCFFA]
    ld c, a
    ld a, [wCFFB]
    ld b, a
    ld hl, wD8FF
    call Func_036_5D84
    ld a, [wCFFC]
    ld c, a
    ld a, [wCFFD]
    ld b, a
    ld hl, wD90F
    call Func_036_5D84
    ld a, [wCFFE]
    ld c, a
    ld a, [wCFFF]
    ld b, a
    ld hl, wD91F
    call Func_036_5D84
    ld a, [wD000]
    ld c, a
    ld a, [wD001]
    ld b, a
    ld hl, wD92F
    call Func_036_5D84
    ld bc, $03E7
    ld hl, wD93F
    call Func_036_5D84
    ld a, [wD002]
    ld c, a
    ld hl, wD968
    call Func_036_5D7A
    ld a, [wD003]
    ld c, a
    ld hl, wD978
    call Func_036_5D7A
    ld a, [wD004]
    ld c, a
    ld hl, wD970
    call Func_036_5D7A
    ld a, [wD005]
    ld c, a
    ld hl, wD980
    call Func_036_5D7A
    ld c, $00
    ld hl, wD8A7
    call Func_036_5D7A
    ld c, $00
    ld hl, wD8AF
    call Func_036_5D7A
    ld a, [wD871]
    ld c, a
    farcall Func_019_4298
    ld a, [wCFEC]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    farcall Func_035_4001
    ld hl, wD01A
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, [wD871]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_036_5D0B
    inc d

Jump_036_5D0B::
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ld hl, wCFEE
    ld de, wC0A0
    ld bc, $0004
    call CopyBytes
    ld hl, wC0A0
    call Func_036_5D2C
    ret

; 1 call site from 1 routine (e.g. Func_036_5BC4)
; reads: wD871, wCFF1
; writes: wCFEC, wD868, wCFED, wD869, wD86A, wD86B
; points at: wD989, wCFF1
Func_036_5D2C::
    ld b, $04
    ld a, [wD871]
    ld de, wD989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_5D3B
    inc d

Jump_036_5D3B::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
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
    swap a
    and a, $0F
    pop de
    ld [de], a
    inc de
    inc de
    inc de
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_036_5D3B
    ret

; 7 call sites from 1 routine (e.g. Func_036_5BC4)
; reads: wD871
Func_036_5D7A::
    ld a, [wD871]
    add_a_to_hl
    ld [hl], c
    ret

; 10 call sites from 1 routine (e.g. Func_036_5BC4)
; reads: wD871
Func_036_5D84::
    ld a, [wD871]
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_036_7697)
; reads: wD8A5
; points at: wD8A7
Func_036_5D91:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD8A7
    add_a_to_hl
    bit 4, [hl]
    ret nz
    call Func_036_5B5D
    ret

; 1 call site from 1 routine (e.g. Func_036_77B5)
Func_036_5DA3:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5DB4
    scf
    ret

Jump_036_5DB4::
    call Func_036_61D6
    ret

; 1 call site from 1 routine (e.g. Func_036_77DE)
Func_036_5DB8:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61C4
    rlca
    rlca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5DCB
    scf
    ret

Jump_036_5DCB::
    call Func_036_61D6
    ret

; 1 call site from 1 routine (e.g. Func_036_71DF)
; reads: wD8A4, wC58A
; writes: wD872, wD873
; points at: wD8B7
Func_036_5DCF:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD8B7
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_5DF4
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_036_5DF4
    push hl
    srl h
    rr l
    pop bc
    add hl, bc
    jr Jump_036_5DF5

Jump_036_5DF4::
    add hl, hl

Jump_036_5DF5::
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61C4
    swap a
    and a, $03
    call Func_036_621C
    ret
    INCBIN "dwm2-cobi-us.gbc", $0D9E0B, $CD

; 1 call site from 1 routine (e.g. Func_036_6BC7)
; reads: wD8A6
Func_036_5ED8::
    call Func_036_6141
    jp z, Jump_036_613D
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B5
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5EEF
    scf
    ret

Jump_036_5EEF::
    push af
    ld a, [wD8A6]
    cp a, $D6
    jr z, Jump_036_5EFC
    pop af
    call Func_036_61EC
    ret

Jump_036_5EFC::
    pop af
    call Func_036_6346
    ret

; 2 call sites from 2 routines (e.g. Func_036_610D, Func_036_6EA8)
; reads: wD8A6, wD86A
; writes: wD86A
Func_036_5F01::
    call Func_036_6159
    call Func_036_61B0
    rlca
    rlca
    and a, $03
    ld [wD86A], a
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_5F17
    scf
    ret

Jump_036_5F17::
    ld a, [wD8A6]
    cp a, $2F
    ld a, [wD86A]
    jp z, Func_036_61D6
    jp Func_036_620F

; 1 call site from 1 routine (e.g. Func_036_710F)
; reads: wD8A6, wCFF6, wCFF7, wD8A4, wCFF8, wCFF9, wCFFA, wCFFB, ...
; writes: wCFE6, wCFE7, wD006, wD007, wD868, wD869, wD86A, wD86B
; points at: wD8CF, wD8BF, wD8EF, wD8DF, wD8FF, wD90F, wD91F, wD92F, ...
Func_036_5F25:: ; heuristic: follows a terminator; C0
    ld hl, $0082
    ld a, [wD8A6]
    cp a, $DC
    jr nz, Jump_036_5F32
    ld hl, $0262

Jump_036_5F32::
    ld a, l
    ld [wCFE6], a
    ld a, h
    ld [wCFE7], a
    farcall Func_034_4001
    ld a, [wCFF6]
    ld c, a
    ld a, [wCFF7]
    ld b, a
    ld hl, wD8CF
    call Func_036_608B
    ld a, [wD8A4]
    ld hl, wD8BF
    call Func_036_6701
    ld a, [wCFF8]
    ld c, a
    ld a, [wCFF9]
    ld b, a
    ld hl, wD8EF
    call Func_036_608B
    ld a, [wD8A4]
    ld hl, wD8DF
    call Func_036_6701
    ld a, [wCFFA]
    ld c, a
    ld a, [wCFFB]
    ld b, a
    ld hl, wD8FF
    call Func_036_608B
    ld a, [wCFFC]
    ld c, a
    ld a, [wCFFD]
    ld b, a
    ld hl, wD90F
    call Func_036_608B
    ld a, [wCFFE]
    ld c, a
    ld a, [wCFFF]
    ld b, a
    ld hl, wD91F
    call Func_036_608B
    ld a, [wD000]
    ld c, a
    ld a, [wD001]
    ld b, a
    ld hl, wD92F
    call Func_036_608B
    ld a, [wCFEC]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    farcall Func_035_4001
    ld a, [wD8A4]
    ld c, a
    farcall Func_019_4298
    ld hl, wD01A
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, [wD8A4]
    ld c, a
    add a, a
    add a, c
    add a, a
    add a, c
    ld de, wDA72
    add a, e
    ld e, a
    jr nc, Jump_036_5FE1
    inc d

Jump_036_5FE1::
    ld a, e
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ld hl, wCFEE
    ld de, wC0A0
    ld bc, $0004
    call CopyBytes
    call Func_036_6018
    ld a, [wD8A4]
    ld hl, wD8A7
    add_a_to_hl
    ld [hl], $00
    ld a, [wD8A4]
    call SetBit0OfWD095Indexed_Bank36
    ld a, [wD8A4]
    call SetBit1OfWD095Indexed_Bank36
    ret

; 1 call site from 1 routine (e.g. Func_036_5F25)
; reads: wD8A4, wCFF1
; writes: wCFEC, wD868, wCFED, wD869, wD86A, wD86B
; points at: wC0A0, wD989, wCFF1
Func_036_6018::
    ld hl, wC0A0
    ld b, $04
    ld a, [wD8A4]
    ld de, wD989
    swap a
    add a, e
    ld e, a
    jr nc, Jump_036_602A
    inc d

Jump_036_602A::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_036_6034
    call Func_036_6077
    jr Jump_036_606A

Jump_036_6034::
    push hl
    push bc
    ld a, [hl]
    ld [de], a
    dec de
    push de
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
    swap a
    and a, $0F
    pop de
    pop bc
    pop hl
    ld [de], a
    inc de
    inc de
    inc de

Jump_036_606A::
    inc hl
    dec b
    jr nz, Jump_036_602A
    call Func_036_6077
    call Func_036_6077
    call Func_036_6077

; 4 call sites from 1 routine (e.g. Func_036_6018)
Func_036_6077::
    ld a, $FF
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    inc de
    inc de
    inc de
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
Func_036_6081:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    add_a_to_hl
    ld [hl], c
    ret

; 6 call sites from 1 routine (e.g. Func_036_5F25)
; reads: wD8A4
Func_036_608B::
    ld a, [wD8A4]
    add a, a
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; points at: wD8FF
Func_036_6098:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD8FF
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    push bc
    ld a, $00
    ld [hl-], a
    ld [hl], $C8
    call Func_036_5013
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_036_71D9)
; reads: wD8A6
Func_036_60B4:: ; heuristic: follows a terminator; C0
    call Func_036_6159
    call Func_036_61A6
    swap a
    rrca
    rrca
    and a, $03
    ld b, a
    ld a, [wD8A6]
    cp a, $4C
    ld a, b
    jr z, Jump_036_60CD
    call Func_036_6232
    ret

Jump_036_60CD::
    call Func_036_621C
    ret

; 3 call sites from 3 routines (e.g. Func_036_73EC, Func_032_5EAB, Func_03B_4D1C)
Func_036_60D1::
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BA
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_60E2
    scf
    ret

Jump_036_60E2::
    call Func_036_620F
    ld e, $00
    ret c
    ld e, $01
    ret

; 2 call sites from 2 routines (e.g. Func_036_73C3, Func_032_5EAB)
Func_036_60EB::
    call Func_036_6141
    jp z, Jump_036_613D
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61BF
    rlca
    rlca
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_6104
    scf
    ret

Jump_036_6104::
    call Func_036_620F
    ld e, $00
    ret c
    ld e, $01
    ret

; 1 call site from 1 routine (e.g. Func_032_5EAB)
Func_036_610D::
    call Func_036_5F01
    ld e, $00
    ret c
    ld e, $01
    ret

; 1 call site from 1 routine (e.g. Func_036_771B)
Func_036_6116:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61A6
    swap a
    rrca
    rrca
    and a, $03
    call Func_036_61D6
    ret

; 1 call site from 1 routine (e.g. Func_036_753C)
Func_036_6126:: ; heuristic: follows a terminator; C0
    call HLToWD814EntryOfWD8A5_Bank36
    call Func_036_61B0
    swap a
    and a, $03
    call Func_036_65B6
    cp a, $04
    jr nz, Jump_036_6139
    scf
    ret

Jump_036_6139::
    call Func_036_61D6
    ret

Jump_036_613D::
    xor a, a
    ld e, $01
    ret

; 3 call sites from 3 routines (e.g. Func_036_60EB, Func_036_5B19, Func_036_5ED8)
; reads: wCFC5, wD8A4
Func_036_6141::
    ld a, [wCFC5]
    cp a, $02
    jr z, Jump_036_614C
    cp a, $03
    jr nz, Jump_036_6155

Jump_036_614C::
    ld a, [wD8A4]
    cp a, $04
    jr nc, Jump_036_6155
    xor a, a
    ret

Jump_036_6155::
    ld a, $01
    or a, a
    ret

; 15 call sites from 15 routines (e.g. Func_036_5F01, Func_036_5094, Func_036_60B4, Func_036_5A6C, ...)
; reads: wC58A, wD8A4, wCFFB, wCFFC, wCFFD, wD8A5, wCFF7, wCFF8, ...
; writes: wD86A
; points at: wD814
Func_036_6159::
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_6174
    ld a, [wD8A4]
    bit 2, a
    jr z, Jump_036_6174
    ld a, [wCFFB]
    ld l, a
    ld a, [wCFFC]
    ld h, a
    ld a, [wCFFD]
    jr Jump_036_617F

Jump_036_6174::
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF8]
    ld h, a
    ld a, [wCFF9]

Jump_036_617F::
    ld [wD86A], a
    call Func_036_618F

; HL = wD814 + 9 * [wD8A5] (AddAx9ToHL); A = [wD8A5] (the same 10 bytes appear in 2 banks)
; 27 call sites from 27 routines (e.g. Func_036_55FB, Func_036_60D1, Func_036_60EB, Func_036_6116, ...)
; reads: wD8A5
; points at: wD814
HLToWD814EntryOfWD8A5_Bank36::
Func_036_6185:: ; address name
    ld a, [wD8A5]
    ld hl, wD814
    call AddAx9ToHL
    ret

; 2 call sites from 2 routines (e.g. Func_036_6159, Func_036_5A08)
; reads: wD86A
; writes: wD872, wD873
Func_036_618F::
    push hl
    ld a, [wD86A]
    ld c, a
    ld b, $00
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    call Func_000_3E98
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ret

; 7 call sites from 7 routines (e.g. Func_036_6116, Func_036_5522, Func_036_60B4, Func_036_5328, ...)
; reads: wD8A5
; points at: wDA72
Func_036_61A6::
    ld de, wDA72
    jr Jump_036_61C7

; 8 call sites from 8 routines (e.g. Func_036_55FB, Func_036_5533, Func_036_5544, Func_036_5555, ...)
; reads: wD8A5
; points at: wDA73
Func_036_61AB::
    ld de, wDA73
    jr Jump_036_61C7

; 5 call sites from 5 routines (e.g. Func_036_5F01, Func_036_5626, Func_036_6126, Func_036_56CB, ...)
; reads: wD8A5
; points at: wDA74
Func_036_61B0::
    ld de, wDA74
    jr Jump_036_61C7

; 6 call sites from 6 routines (e.g. Func_036_5A7A, Func_036_56E0, Func_036_5A98, Func_036_53C6, ...)
; reads: wD8A5
; points at: wDA75
Func_036_61B5::
    ld de, wDA75
    jr Jump_036_61C7

; 3 call sites from 3 routines (e.g. Func_036_60D1, Func_036_5344, Func_036_5336)
; reads: wD8A5
; points at: wDA76
Func_036_61BA::
    ld de, wDA76
    jr Jump_036_61C7

; 4 call sites from 4 routines (e.g. Func_036_60EB, Func_036_5B02, Func_036_5B5D, Func_036_5DA3)
; reads: wD8A5
; points at: wDA77
Func_036_61BF::
    ld de, wDA77
    jr Jump_036_61C7

; 4 call sites from 4 routines (e.g. Func_036_5A6C, Func_036_5DB8, Func_036_5DCF, Func_036_5352)
; reads: wD8A5
; points at: wDA78
Func_036_61C4::
    ld de, wDA78

Jump_036_61C7::
    ld a, [wD8A5]
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_036_61D4
    inc d

Jump_036_61D4::
    ld a, [de]
    ret

; 12 call sites from 12 routines (e.g. Func_036_55FB, Func_036_6116, Func_036_5626, Func_036_6126, ...)
Func_036_61D6::
    bit 6, [hl]
    jr z, Jump_036_61DF
    call Func_036_629B
    jr Jump_036_61EB

Jump_036_61DF::
    bit 7, [hl]
    jr z, Jump_036_61E8
    call Func_036_628E
    jr Jump_036_61EB

Jump_036_61E8::
    call Func_036_6278

Jump_036_61EB::
    ret

; 1 call site from 1 routine (e.g. Func_036_5ED8)
Func_036_61EC:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_61F5
    call Func_036_6278
    jr Jump_036_61F8

Jump_036_61F5::
    call Func_036_628E

Jump_036_61F8::
    ret

; 2 call sites from 2 routines (e.g. Func_036_55FB, Func_036_5B19)
Func_036_61F9::
    bit 6, [hl]
    jr z, Jump_036_6202
    call Func_036_62B1
    jr Jump_036_620E

Jump_036_6202::
    bit 7, [hl]
    jr z, Jump_036_620B
    call Func_036_628E
    jr Jump_036_620E

Jump_036_620B::
    call Func_036_629B

Jump_036_620E::
    ret

; 7 call sites from 7 routines (e.g. Func_036_60D1, Func_036_60EB, Func_036_56E0, Func_036_5B02, ...)
Func_036_620F::
    bit 7, [hl]
    jr z, Jump_036_6218
    call Func_036_6278
    jr Jump_036_621B

Jump_036_6218::
    call Func_036_62B1

Jump_036_621B::
    ret

; 12 call sites from 12 routines (e.g. Func_036_5094, Func_036_60B4, Func_036_5A6C, Func_036_5A7A, ...)
Func_036_621C:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_6225
    call Func_036_62EF
    jr Jump_036_6231

Jump_036_6225::
    bit 7, [hl]
    jr z, Jump_036_622E
    call Func_036_6302
    jr Jump_036_6231

Jump_036_622E::
    call Func_036_62DC

Jump_036_6231::
    ret

; 5 call sites from 5 routines (e.g. Func_036_60B4, Func_036_5344, Func_036_5336, Func_036_5328, ...)
Func_036_6232:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_623B
    call Func_036_6319
    jr Jump_036_6247

Jump_036_623B::
    bit 7, [hl]
    jr z, Jump_036_6244
    call Func_036_6302
    jr Jump_036_6247

Jump_036_6244::
    call Func_036_62EF

Jump_036_6247::
    ret

; 4 call sites from 4 routines (e.g. Func_036_5522, Func_036_5533, Func_036_5544, Func_036_5555)
Func_036_6248::
    bit 6, [hl]
    jr z, Jump_036_6251
    call Func_036_62DC
    jr Jump_036_6254

Jump_036_6251::
    call Func_036_6302

Jump_036_6254::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_6255:: ; heuristic: follows a terminator; C0
    bit 7, [hl]
    jr z, Jump_036_625E
    call Func_036_62DC
    jr Jump_036_6261

Jump_036_625E::
    call Func_036_6319

Jump_036_6261::
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_6262:: ; heuristic: follows a terminator; C0
    bit 6, [hl]
    jr z, Jump_036_626B
    call Func_036_629B
    jr Jump_036_6277

Jump_036_626B::
    bit 7, [hl]
    jr z, Jump_036_6274
    call Func_036_6346
    jr Jump_036_6277

Jump_036_6274::
    call Func_036_6330

Jump_036_6277::
    ret

; 3 call sites from 3 routines (e.g. Func_036_61D6, Func_036_620F, Func_036_61EC)
; reads: wC5E7
Func_036_6278::
    and a, a
    jr nz, Jump_036_627D
    scf
    ret

Jump_036_627D::
    cp a, $01
    jr nz, Jump_036_6284
    jp Jump_036_636A

Jump_036_6284::
    cp a, $02
    jr nz, Jump_036_628B
    jp Jump_036_637C

Jump_036_628B::
    scf
    ccf
    ret

; 3 call sites from 3 routines (e.g. Func_036_61D6, Func_036_61F9, Func_036_61EC)
; reads: wC5E7
Func_036_628E::
    cp a, $02
    jr nc, Jump_036_6293
    ret

Jump_036_6293::
    jr nz, Jump_036_6298
    jp Jump_036_6373

Jump_036_6298::
    scf
    ccf
    ret

; 3 call sites from 3 routines (e.g. Func_036_61D6, Func_036_61F9, Func_036_6262)
; reads: wC5E7
Func_036_629B::
    and a, a
    jr nz, Jump_036_62A0
    scf
    ret

Jump_036_62A0::
    cp a, $01
    jr nz, Jump_036_62A7
    jp Jump_036_6373

Jump_036_62A7::
    cp a, $02
    jr nz, Jump_036_62AE
    jp Jump_036_6385

Jump_036_62AE::
    scf
    ccf
    ret

; 2 call sites from 2 routines (e.g. Func_036_61F9, Func_036_620F)
; reads: wC58A, wD8A5, wC5E7
Func_036_62B1::
    push af
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_62C4
    ld a, [wD8A5]
    cp a, $04
    jr nc, Jump_036_62C4
    pop af
    jp Jump_036_6353

Jump_036_62C4::
    pop af
    and a, a
    jr nz, Jump_036_62CB
    jp Jump_036_6373

Jump_036_62CB::
    cp a, $01
    jr nz, Jump_036_62D2
    jp Jump_036_637C

Jump_036_62D2::
    cp a, $02
    jr nz, Jump_036_62D9
    jp Jump_036_6397

Jump_036_62D9::
    scf
    ccf
    ret

; 3 call sites from 3 routines (e.g. Func_036_621C, Func_036_6248, Func_036_6255)
; reads: wD872, wD873
; writes: wD872, wD873
Func_036_62DC:: ; heuristic: follows a terminator; C0
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_036_62E5
    jp Jump_036_63D1

Jump_036_62E5::
    cp a, $02
    jr nz, Jump_036_62EC
    jp Jump_036_63F9

Jump_036_62EC::
    jp Jump_036_6449

; 2 call sites from 2 routines (e.g. Func_036_621C, Func_036_6232)
; reads: wD872, wD873
; writes: wD872, wD873
Func_036_62EF::
    and a, a
    ret z
    cp a, $01
    jr nz, Jump_036_62F8
    jp Jump_036_63E5

Jump_036_62F8::
    cp a, $02
    jr nz, Jump_036_62FF
    jp Func_036_640D

Jump_036_62FF::
    jp Jump_036_6449

; 3 call sites from 3 routines (e.g. Func_036_621C, Func_036_6248, Func_036_6232)
; reads: wD872, wD873
; writes: wD872, wD873
Func_036_6302::
    and a, a
    jr nz, Jump_036_6308
    jp Jump_036_63A9

Jump_036_6308::
    cp a, $01
    jr nz, Jump_036_630F
    jp Jump_036_63BD

Jump_036_630F::
    cp a, $02
    jr nz, Jump_036_6316
    jp Jump_036_63E5

Jump_036_6316::
    jp Jump_036_6421

; 2 call sites from 2 routines (e.g. Func_036_6255, Func_036_6232)
; reads: wD872, wD873
; writes: wD872, wD873
Func_036_6319:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_036_631F
    jp Jump_036_63E5

Jump_036_631F::
    cp a, $01
    jr nz, Jump_036_6326
    jp Jump_036_63F9

Jump_036_6326::
    cp a, $02
    jr nz, Jump_036_632D
    jp Jump_036_6435

Jump_036_632D::
    jp Jump_036_6449

; 1 call site from 1 routine (e.g. Func_036_6262)
; reads: wC5E7
Func_036_6330:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_036_6335
    scf
    ret

Jump_036_6335::
    cp a, $01
    jr nz, Jump_036_633C
    jp Jump_036_6373

Jump_036_633C::
    cp a, $02
    jr nz, Jump_036_6343
    jp Jump_036_637C

Jump_036_6343::
    jp Jump_036_6397

; 2 call sites from 2 routines (e.g. Func_036_6262, Func_036_5ED8)
; reads: wC5E7
Func_036_6346::
    cp a, $02
    jr nc, Jump_036_634B
    ret

Jump_036_634B::
    jr nz, Jump_036_6350
    jp Jump_036_6373

Jump_036_6350::
    jp Jump_036_6385

Jump_036_6353::
    and a, a
    jr nz, Jump_036_6359
    jp Jump_036_637C

Jump_036_6359::
    cp a, $01
    jr nz, Jump_036_6360
    jp Jump_036_638E

Jump_036_6360::
    cp a, $02
    jr nz, Jump_036_6367
    jp Jump_036_63A0

Jump_036_6367::
    scf
    ccf
    ret

Jump_036_636A::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $D8
    ret

Jump_036_6373::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $BF
    ret

Jump_036_637C::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $7F
    ret

Jump_036_6385::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $66
    ret

Jump_036_638E::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $4C
    ret

Jump_036_6397::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $3F
    ret

Jump_036_63A0::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $26
    ret

Jump_036_63A9::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_646C
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63BD::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6477
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63D1::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6494
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63E5::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_64B2
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_63F9::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_651C
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

; 1 call site from 1 routine (e.g. Func_036_5223)
; reads: wD872, wD873
; writes: wD872, wD873
Func_036_640D::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_64CD
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_6421::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_64D4
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_6435::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6518
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_036_6449::
    xor a, a
    ld [wD872], a
    ld [wD873], a
    ret

; 3 call sites from 3 routines (e.g. Func_036_509D, Func_036_50B2, Func_036_50C7)
; reads: wD872, wD873
; writes: wD872, wD873
Func_036_6451::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6465
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

; 3 call sites from 3 routines (e.g. Func_036_6451, Func_036_55D4, Func_036_72E0)
Func_036_6465::
    ld b, h
    ld c, l
    call Func_036_651C
    add hl, bc
    ret

; 2 call sites from 2 routines (e.g. Func_036_6346, Func_036_5A08)
Func_036_646C::
    ld b, h
    ld c, l
    call Func_036_6507
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

; 1 call site from 1 routine (e.g. Func_036_6346)
Func_036_6477::
    ld b, h
    ld c, l
    call Func_036_6503
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

; no direct call (reached through a table, a jump or a vector)
Func_036_6482:: ; heuristic: follows a terminator; C0
    call Func_036_651C
    ld b, h
    ld c, l
    call Func_036_650B
    add hl, bc
    call Func_036_650B
    add hl, bc
    call Func_036_6507
    add hl, bc
    ret

; 1 call site from 1 routine (e.g. Func_036_6346)
Func_036_6494::
    push de
    ld b, h
    ld c, l
    ld a, $55
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    pop de
    ret

; 3 call sites from 3 routines (e.g. Func_036_64CD, Func_036_64EC, Func_036_5A7A)
Func_036_64A3::
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Func_000_16AA
    ld a, $0A
    call Func_000_16E2
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_036_6346)
Func_036_64B2::
    push bc
    call Func_036_651C
    ld b, h
    ld c, l
    call Func_036_650B
    add hl, bc
    pop bc
    ret

; 2 call sites from 2 routines (e.g. Func_036_64E2, Func_036_64D4)
Func_036_64BE::
    push de
    ld b, h
    ld c, l
    ld a, $06
    call Func_000_16AA
    ld a, $0A
    call Func_000_16E2
    pop de
    ret

; 3 call sites from 3 routines (e.g. Func_036_640D, Func_036_5993, Func_036_592E)
Func_036_64CD::
    call Func_036_64A3
    call Func_036_651C
    ret

; 2 call sites from 2 routines (e.g. Func_036_640D, Func_036_58C5)
Func_036_64D4::
    call Func_036_64BE
    call Func_036_651C
    ret

; 4 call sites from 4 routines (e.g. Func_036_54BE, Func_036_5441, Func_036_5360, Func_036_53EF)
Func_036_64DB::
    ld bc, $0003
    call Func_000_3F04
    ret

; 1 call site from 1 routine (e.g. Func_036_771B)
Func_036_64E2:: ; heuristic: follows a terminator; C0
    call Func_036_64BE
    call Func_036_651C
    call Func_036_651C
    ret

; 1 call site from 1 routine (e.g. Func_036_771B)
Func_036_64EC:: ; heuristic: follows a terminator; C0
    call Func_036_64A3
    call Func_036_651C
    call Func_036_651C
    call Func_036_651C
    call Func_036_651C
    ret

; 1 call site from 1 routine (e.g. Func_036_6558)
Func_036_64FC:: ; heuristic: follows a terminator; C0
    call AddDoubleAToHL_Bank36
    deref_hl
    ret

; 1 call site from 1 routine (e.g. Func_036_6477)
Func_036_6503::
    srl b
    rr c

; 4 call sites from 3 routines (e.g. Func_036_646C, Func_036_6477, Func_036_6482)
Func_036_6507::
    srl b
    rr c

; 11 call sites from 10 routines (e.g. Func_036_54BE, Func_036_64B2, Func_036_5013, Func_036_6482, ...)
Func_036_650B::
    srl b
    rr c
    ret

; 3 call sites from 1 routine (e.g. Func_036_5025)
Func_036_6510:: ; heuristic: follows a terminator; C0
    srl h
    rr l
    srl h
    rr l

; 3 call sites from 3 routines (e.g. Func_036_640D, Func_036_5993, Func_036_592E)
Func_036_6518::
    srl h
    rr l

; 15 call sites from 11 routines (e.g. Func_036_7D13, Func_036_64E2, Func_036_6346, Func_036_64B2, ...)
Func_036_651C::
    srl h
    rr l
    ret

; 2 call sites from 1 routine (e.g. Func_036_5360)
; reads: wD868, wC58A
; writes: wD868
Func_036_6521:: ; heuristic: follows a terminator; C0
    ld [wD868], a
    call Func_036_7E33
    ld bc, $03E7
    call CompareHLToBC
    jr nc, Jump_036_6554
    push hl
    ld a, [wD868]
    call Func_036_6634
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_6544
    ld a, [wD868]
    cp a, $04
    jr nc, Jump_036_6548

Jump_036_6544::
    sla c
    rl b

Jump_036_6548::
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, Jump_036_6554

Jump_036_6552::
    scf
    ret

Jump_036_6554::
    jr z, Jump_036_6552
    xor a, a
    ret

; 2 call sites from 1 routine (e.g. Func_036_5441)
; reads: wD868, wC58A
; writes: wD868
; points at: wD91F
Func_036_6558:: ; heuristic: follows a terminator; C0
    ld [wD868], a
    ld hl, wD91F
    call Func_036_64FC
    ld bc, $03E7
    call CompareHLToBC
    jr z, Jump_036_6590
    jr nc, Jump_036_6590
    push hl
    ld a, [wD868]
    call Func_036_6646
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_6544
    ld a, [wD868]
    cp a, $04
    jr nc, Jump_036_6584
    sla c
    rl b

Jump_036_6584::
    sla c
    rl b
    pop hl
    call CompareHLToBC
    jr nc, Jump_036_6590

Jump_036_658E::
    scf
    ret

Jump_036_6590::
    jr z, Jump_036_658E
    xor a, a
    ret

; 15 call sites from 15 routines (e.g. Func_036_509D, Func_036_50B2, Func_036_5566, Func_036_50C7, ...)
; reads: wD008
; writes: wD006, wD007
Func_036_6594::
    call Func_036_65A9
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    farcall Func_035_4001
    ld a, [wD008]
    ret

; 1 call site from 1 routine (e.g. Func_036_6594)
; reads: wD8A5
; points at: wD958
Func_036_65A9::
    ld a, [wD8A5]
    add a, a
    ld hl, wD958
    add_a_to_hl
    ret

; 16 call sites from 16 routines (e.g. Func_036_55FB, Func_036_60D1, Func_036_60EB, Func_036_5F01, ...)
; reads: wD8A4
; points at: wD854
Func_036_65B6::
    cp a, $03
    ret z
    push bc
    push hl
    ld b, a
    ld a, [wD8A4]
    ld hl, wD854
    add a, a
    add_a_to_hl
    ld a, [hl]
    and a, $04
    jr nz, Jump_036_65D1
    ld a, b
    pop hl
    pop bc
    ret

Jump_036_65D1::
    ld a, $04
    pop hl
    pop bc
    ret

; 1 call site from 1 routine (e.g. Func_036_5640)
Func_036_65D6:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld b, a
    call Func_036_7E47
    push hl
    ld a, b
    call Func_036_7E3D
    pop bc
    call CompareHLToBC
    pop bc
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_036_5703)
; reads: wDAC4, wDAC5
Func_036_65E8:: ; heuristic: follows a terminator; C0
    push hl
    ld c, a
    farcall Func_03B_4001
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld hl, $03E7
    call CompareHLToBC
    jr nc, Jump_036_6603
    ld bc, $03E7

Jump_036_6603::
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_036_5703)
; reads: wDAC4, wDAC5
Func_036_6605:: ; heuristic: follows a terminator; C0
    push hl
    ld c, a
    farcall Func_03B_4045
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld hl, $03E7
    call CompareHLToBC
    jr nc, Jump_036_6620
    ld bc, $03E7

Jump_036_6620::
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_036_5703)
; reads: wDAC4, wDAC5
Func_036_6622::
    push hl
    ld c, a
    farcall Func_03B_4089
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    pop hl
    ret

; 4 call sites from 4 routines (e.g. Func_036_6521, Func_036_5703, Func_036_5360, Func_036_53EF)
; reads: wDAC4, wDAC5
Func_036_6634::
    push hl
    ld c, a
    farcall Func_03B_40CD
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    pop hl
    ret

; 4 call sites from 4 routines (e.g. Func_036_54BE, Func_036_6558, Func_036_5703, Func_036_5441)
; reads: wDAC4, wDAC5
Func_036_6646::
    push hl
    ld c, a
    farcall Func_03B_4111
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_036_5703)
; reads: wCFEC, wCFED
; writes: wCFE6, wCFE7, wD006, wD007
; points at: wDAAE, wD01A
Func_036_6658:: ; heuristic: follows a terminator; C0
    ld b, a
    and a, $03
    cp a, $03
    jr z, Jump_036_6667
    ld a, b
    ld e, $31
    call Func_000_3F32
    jr Jump_036_669D

Jump_036_6667::
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wCFE6], a
    ld a, h
    ld [wCFE7], a
    farcall Func_034_4001
    ld a, [wCFEC]
    ld [wD006], a
    ld a, [wCFED]
    ld [wD007], a
    farcall Func_035_4001
    ld hl, wD01A

Jump_036_669D::
    ret

; 1 call site from 1 routine (e.g. Func_036_5703)
; writes: wCFE6, wCFE7
; points at: wDAAE, wCFEE
Func_036_669E:: ; heuristic: follows a terminator; C0
    ld b, a
    and a, $03
    cp a, $03
    jr z, Jump_036_66AF
    ld a, b
    ld e, $0E
    call Func_000_3F32
    ld b, $08
    jr Jump_036_66D5

Jump_036_66AF::
    ld a, b
    srl a
    srl a
    and a, $01
    ld hl, wDAAE
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wCFE6], a
    ld a, h
    ld [wCFE7], a
    farcall Func_034_4001
    ld hl, wCFEE
    ld b, $04

Jump_036_66D5::
    ret

; 1 call site from 1 routine (e.g. Func_036_5703)
Func_036_66D6:: ; heuristic: follows a terminator; C0
    push hl
    ld c, a
    farcall Func_03B_42BB
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; points at: wD90F
Func_036_66E0:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    add a, a
    ld hl, wD90F
    add_a_to_hl
    push hl
    ld a, [hl+]
    ld c, a
    ld b, [hl]
    push bc
    srl b
    rr c
    ld [hl], b
    dec hl
    ld [hl], c
    call Func_036_5013
    pop bc
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; 2 call sites from 1 routine (e.g. Func_036_5F25)
Func_036_6701::
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    call CompareHLToBC
    jr nc, Jump_036_6712
    ld b, h
    ld c, l

Jump_036_6712::
    pop hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_036_4582)
; reads: wD8A6
Func_036_6717::
    ld a, [wD8A6]
    ld c, a
    ld b, $00
    ld hl, $6726
    add hl, bc
    add hl, bc
    call Func_000_000B
    ret
    db $75, $6B
    dw Func_036_6B7B
    dw Func_036_6B7B
    dw Func_036_6B7B
    dw Func_036_6B81
    dw Func_036_6B81
    dw Func_036_6B81
    dw Func_036_6B87
    dw Func_036_6B87
    dw Func_036_6B87
    dw Func_036_6B8D
    dw Func_036_6B8D
    dw Func_036_6B8D
    dw Func_036_6B93
    dw Func_036_6B93
    dw Func_036_6B93
    dw Func_036_6B99
    dw Func_036_6B99
    dw Func_036_6B99
    dw Func_036_6B9F
    dw Func_036_6B9F
    dw Func_036_6BC7
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C24
    dw Func_036_6C5E
    dw Func_036_6C5E
    dw Func_036_6C5E
    dw Func_036_6C9A
    dw Func_036_6CF5
    dw Func_036_6D20
    dw Func_036_6D4E
    dw Func_036_6D64
    dw Func_036_6D87
    dw Func_036_6DB5
    dw Func_036_6DCB
    dw Func_036_6DCB
    dw Func_036_6DF2
    dw Func_036_6DF2
    db $13, $6E, $13, $6E, $3A, $6E, $3A, $6E, $5B, $6E, $75, $6E, $A8, $6E, $A8, $6E
    db $E2, $6E, $FC, $6E, $96, $6F, $C1, $6F, $F1, $6F, $3D, $70, $3D, $70, $79, $70
    db $AE, $70, $CC, $70, $0F, $71, $4F, $71, $96, $71
    dw Func_036_71A9
    dw Func_036_6B93
    dw Func_036_71AF
    dw Func_036_71AF
    dw Func_036_71AF
    dw Func_036_71AF
    dw Func_036_71B8
    dw Func_036_71B8
    dw Func_036_71B8
    dw Func_036_71B8
    dw Func_036_71C1
    dw Func_036_71C7
    dw Func_036_71CD
    dw Func_036_71D3
    dw Func_036_71D9
    dw Func_036_71D9
    dw Func_036_71DF
    dw Func_036_71DF
    dw Data_036_721A
    dw Data_036_7220
    dw Data_036_7226
    dw Data_036_722C
    dw Data_036_7232
    dw Data_036_7238
    dw Data_036_723E
    dw Data_036_7244
    dw Data_036_724A
    dw Data_036_7250
    dw Data_036_7256
    dw Data_036_725C
    dw Data_036_7262
    dw Data_036_7268
    db $6E
    dw $7472
    dw $7472
    dw $7472
    dw Func_036_7872
    db $72, $91, $72, $91, $72, $97, $72, $C4, $72, $CA, $72, $D0, $72, $E0, $72
    dw Func_036_72F9
    dw Func_036_7314
    dw Func_036_7353
    dw Func_036_7378
    dw Func_036_7387
    db $B7, $73, $BD, $73, $A8, $6E
    dw Func_036_73C3
    dw Func_036_73EC
    dw Func_036_73EC
    dw Func_036_7434
    dw Func_036_745D
    db $FC, $6E, $C1, $6F
    dw Func_036_6B9F
    dw Func_036_747E
    dw Func_036_74A0
    dw Func_036_6C24
    dw Func_036_74D1
    dw Func_036_74F2
    dw Func_036_74F6
    dw Func_036_753C
    dw Func_036_7571
    dw Func_036_757F
    dw Func_036_7599
    dw Func_036_7599
    dw Func_036_75AB
    dw Func_036_75AB
    dw Func_036_75AB
    dw Func_036_75AB
    dw Func_036_7627
    dw Func_036_7637
    dw Func_036_7645
    dw Func_036_7645
    dw Func_036_7697
    dw Func_036_7697
    dw Func_036_76CD
    dw Func_036_76F4
    dw Func_036_771B
    dw Func_036_77B5
    dw Func_036_77DE
    dw Func_036_7809
    dw Func_036_7836
    dw Func_036_7809
    dw Func_036_7844
    dw Func_036_7844
    dw Func_036_789B
    dw Func_036_789B
    dw Func_036_78DE
    dw Func_036_78EC
    dw Func_036_78FA
    dw Func_036_7931
    db $3F, $79, $4F, $79, $9B, $79, $EC, $79, $EC, $79, $EC, $79, $EC, $79, $EC, $79
    db $EC, $79, $EC, $79, $EC, $79, $ED, $79, $A5, $7B, $06, $7A, $C1, $6F, $F1, $6F
    db $74, $6B
    dw Func_036_7A18
    dw Func_036_6C24
    dw Func_036_7A18
    dw Func_036_7599
    dw Func_036_7A8E
    dw Func_036_7AAC
    dw Func_036_7AD5
    db $A5, $7B, $0F, $71, $EE, $7A
    dw Func_036_7AF4
    dw Func_036_6CF5
    dw Func_036_7B09
    dw Func_036_7B36
    db $74, $6B
    dw Func_036_7C2C
    dw Func_036_7B6B
    dw Func_036_7B89
    dw Func_036_7BA1
    db $A5, $7B, $A5, $7B
    dw Func_036_7BA8
    dw Func_036_7BB6
    dw Func_036_7BB6
    dw Func_036_7BC9
    dw Func_036_7BF8
    dw Func_036_7BF8
    dw Func_036_7C2C
    dw Func_036_7C5F
    dw Func_036_7C6B
    dw Func_036_7C77
    dw Func_036_7C7A
    dw Func_036_6906
    dw Func_036_6912
    dw Func_036_691E
    dw Func_036_692A
    dw Func_036_6936
    dw Func_036_6942
    dw Func_036_694E
    dw Func_036_6957
    dw Func_036_6963
    db $6F, $69
    dw Func_036_697B
    dw Func_036_69ED
    dw Func_036_6A69
    dw Func_036_6A82
    dw Func_036_6ACA
    dw Func_036_6AE7
    dw Func_036_6AF0
    dw Func_036_6B0F
    dw Func_036_6B18
    dw Func_036_6B42
    db $74
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    dw Func_036_746B
    db $6B

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6906:: ; heuristic: target of a pointer table; C0
    call Func_036_5207
    farcall Func_0A3_413F
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6912:: ; heuristic: target of a pointer table; C0
    call Func_036_5094
    farcall Func_0A3_413F
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_691E:: ; heuristic: target of a pointer table; C0
    call Func_036_509D
    farcall Func_0A3_413F
    jp Func_036_7C85

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_692A:: ; heuristic: target of a pointer table; C0
    call Func_036_50B2
    farcall Func_0A3_413F
    jp Func_036_7C85

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_6936:: ; heuristic: target of a pointer table; C0
    call Func_036_50C7
    farcall Func_0A3_413F
    jp Func_036_7C85

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_6942:: ; heuristic: target of a pointer table; C0
    call Func_036_5A6C
    farcall Func_0A3_413F
    jp Func_036_7C85

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD8A5
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535, wD8BF, sB58F
Func_036_694E:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    jp Func_036_6BC7

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_6957:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    call Func_036_50DC
    jp Func_036_7C85

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_6963:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    call Func_036_511D
    jp Func_036_7C85
    db $CD, $52, $51, $21, $3F, $41, $06, $A3, $D7, $C3, $85, $7C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, hFFC6
; writes: hFFC6, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD8BF, wD8CF, wD8DF, wD8EF
Func_036_697B:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    xor a, a
    ldh [hFFC6], a
    call Func_036_7D33
    or a, a
    jr z, Jump_036_6990
    ld [hl], $00
    ld a, $01
    ldh [hFFC6], a

Jump_036_6990::
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_69B4
    call Func_036_5223
    ld a, $01
    ldh [hFFC6], a

Jump_036_69B4::
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    dec hl
    ld e, l
    ld d, h
    ld a, [wD8A5]
    ld hl, wD8EF
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_69DD
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ld a, $01
    ldh [hFFC6], a

Jump_036_69DD::
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_036_69EA
    ld l, $37
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_69EA::
    jp Jump_036_7CB0

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD8A6, wDAD3, wDAD2, hFFC6, hFFC7
; writes: wD8A6, hFFC6, hFFC7, wDAD2, wDAD3, wDAC2, wDAC0, wDAC1
Func_036_69ED:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    call Func_036_7D33
    call Func_000_3ED4
    ld a, [wC5E7]
    sra a
    sra a
    and a, $03
    sla a
    sla a
    ld de, $6A59
    add a, e
    ld e, a
    jr nc, Jump_036_6A0E
    inc d

Jump_036_6A0E::
    ld a, [de]
    inc de
    ld c, a
    ld a, [hl]
    or a, c
    ld [hl], a
    ld a, [wD8A6]
    push af
    push de
    ld a, [de]
    cp a, $FF
    jr z, Jump_036_6A4B
    ld [wD8A6], a
    ld a, [wDAD3]
    ldh [hFFC6], a
    ld a, [wDAD2]
    ldh [hFFC7], a
    ld a, $41
    ld [wDAD2], a
    ld a, $30
    ld [wDAD3], a
    farcall Func_03A_4001
    farcall Func_03A_5762
    ldh a, [hFFC6]
    ld [wDAD3], a
    ldh a, [hFFC7]
    ld [wDAD2], a

Jump_036_6A4B::
    pop de
    inc de
    pop af
    ld [wD8A6], a
    ld a, [de]
    ld l, a
    ld bc, $4090
    jp Jump_036_7CA3

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
Func_036_6A59:: ; heuristic: follows a terminator; C0
    ld [bc], a
    cpl
    ld [hl], a
    nop
    jr nz, Jump_036_6A93
    reti
    db $00, $40, $2F, $76, $00, $10, $34, $42, $00

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, hFFC6, wD8A6
; writes: wD8A4, wD872, wD873, wDAC2, wDAC0, wDAC1
; points at: wDAD8, wD80D
Func_036_6A69:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_036_710F
    pop af
    ld [wD8A4], a
    jp Func_036_710F

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wC5E7
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
; points at: wD80D
Func_036_6A82:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    set 2, [hl]

Jump_036_6A93::
    push hl
    call Func_000_3ED4
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, [wC5E7]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a
    call Func_036_5360
    jr nc, Jump_036_6AB7
    ld a, [wD8A5]
    call Func_036_7D45

Jump_036_6AB7::
    call Func_036_5441
    jr nc, Jump_036_6AC2
    ld a, [wD8A5]
    call Func_036_7D45

Jump_036_6AC2::
    ld l, $93
    ld bc, $0090
    jp Func_036_7C9C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
; points at: wD80D
Func_036_6ACA:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    set 0, [hl]
    set 6, [hl]
    set 7, [hl]
    ld l, $9E
    ld bc, $0090
    jp Func_036_7C9C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A6, wD8A4, hFFC6, wC982, wC983, wDAD1, wDABD
; writes: wC982, wC983, wD8A4, wD872, wD873, wDAC2, wDAC0, wDAC1, ...
; points at: wD8DF, wD8EF, wDA1D
Func_036_6AE7:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    jp Func_036_6EFC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, hFFC6, wD8A6, wDAD1, wDABD
; writes: wD8A4, wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD813, wDA1D
Func_036_6AF0:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    ld a, [wD8A4]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_036_7809
    pop af
    ld [wD8A4], a
    jp Func_036_7809

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80C
Func_036_6B0F:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    jp Func_036_6FC1

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, hFFC6, wDAD1, wDABD
; writes: hFFC6, wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD813, hFFC6, wDA1D
Func_036_6B18:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    ld a, [wD8A4]
    and a, $04
    ldh [hFFC6], a
    ld b, $04

Jump_036_6B27::
    ldh a, [hFFC6]
    ld c, a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_6B38
    ld a, c
    ld hl, wD813
    call AddAx9ToHL
    set 1, [hl]

Jump_036_6B38::
    ld hl, hFFC6
    inc [hl]
    dec b
    jr nz, Jump_036_6B27
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, hFFC6, wDAD1, wDABD
; writes: hFFC6, wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD80D, hFFC6, wDA1D
Func_036_6B42:: ; heuristic: target of a pointer table; C0
    farcall Func_0A3_413F
    ld a, [wD8A4]
    and a, $04
    ldh [hFFC6], a
    ld b, $03

Jump_036_6B51::
    ldh a, [hFFC6]
    ld c, a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_6B6A
    ldh a, [hFFC6]
    ld hl, wD80D
    call AddAx9ToHL
    set 3, [hl]
    inc hl
    inc hl
    inc hl
    res 6, [hl]
    set 7, [hl]

Jump_036_6B6A::
    ld hl, hFFC6
    inc [hl]
    dec b
    jr nz, Jump_036_6B51
    jp Jump_036_7CD3
    db $C9

; 1 call site from 1 routine (e.g. Func_036_7BA1)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_6B75::
    call Func_036_5013
    jp Func_036_7C85

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6B7B:: ; heuristic: target of a pointer table; C0
    call Func_036_51D1
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6B81:: ; heuristic: target of a pointer table; C0
    call Func_036_51DF
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6B87:: ; heuristic: target of a pointer table; C0
    call Func_036_51ED
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6B8D:: ; heuristic: target of a pointer table; C0
    call Func_036_51F9
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6B93:: ; heuristic: target of a pointer table; C0
    call Func_036_5207
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_6B99:: ; heuristic: target of a pointer table; C0
    call Func_036_5215
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD8BF, sB58E
Func_036_6B9F:: ; heuristic: target of a pointer table; C0
    call Func_036_5B19
    jr nc, Jump_036_6BC4
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld hl, sB58E
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_6BC4::
    jp Jump_036_7CB7

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7, wD8A5
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535, wD8BF, sB58F
Func_036_6BC7:: ; heuristic: target of a pointer table; C0
    call Func_036_5ED8
    jr nc, Jump_036_6C21
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_6C01
    ld a, [wD8A5]
    call Func_036_7E42
    push hl
    ld a, $64
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, Jump_036_6BE9
    ld hl, $0001

Jump_036_6BE9::
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    or a, c
    jr nz, Jump_036_6BF6
    ld bc, $0001

Jump_036_6BF6::
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a
    jp Jump_036_7C7D

Jump_036_6C01::
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld hl, sB58F
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_6C21::
    jp Jump_036_7CB7

; 2 call sites from 2 routines (e.g. Func_036_799B, Func_036_6D20)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wDAC3, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, wCFCB, wDAC2
; points at: wDA1D, wD8BF, wD8CF
Func_036_6C24:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_6C30
    jr z, Jump_036_6C5B
    jr Jump_036_6C58

Jump_036_6C30::
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_6C58
    call Func_036_5223
    ld l, $37
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_6C58::
    jp Jump_036_7CB0

Jump_036_6C5B::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wDAC3, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, wCFCB, wDAC2
; points at: wDA1D, wD8DF, wD8EF
Func_036_6C5E:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_6C6A
    jr z, Jump_036_6C97
    jr Jump_036_6C94

Jump_036_6C6A::
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD8EF
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    jr z, Jump_036_6C94
    call Func_036_52DF
    jr nc, Jump_036_6C94
    ld l, $C3
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_6C94::
    jp Jump_036_7CB0

Jump_036_6C97::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wC5E7, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD8CF, wD8BF, wD958, wDA1D
Func_036_6C9A:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jp nc, Jump_036_6D1A
    jp z, Jump_036_6D1D
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_6CED
    ld a, [wD8A5]
    ld b, a
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    srl d
    rr e

Jump_036_6CC1::
    ld a, b
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    ld a, e
    ld [hl+], a
    ld [hl], d
    call Func_036_7E87
    jr c, Jump_036_6CE2
    ld a, [wD8A5]
    ld b, a
    add a, a
    ld de, wD958
    add a, e
    ld e, a
    jr nc, Jump_036_6CDD
    inc d

Jump_036_6CDD::
    call Func_036_4E26
    jr Jump_036_6CE2

Jump_036_6CE2::
    call Func_036_7D79
    ld l, $50
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6CED::
    ld h, $67
    ld bc, $0080
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, ...
; points at: wD8CF, wD8BF, wD958, wDA1D
Func_036_6CF5:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    and a, $03
    cp a, $03
    jr z, Jump_036_6D1D
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jp nc, Jump_036_6D1A
    jp z, Jump_036_6D1D

; 3 call sites from 3 routines (e.g. Func_036_7931, Func_036_6D20, Func_03B_4C7D)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
; points at: wD8CF, wD8BF, wD958
Func_036_6D0A::
    ld a, [wD8A5]
    ld b, a
    ld hl, wD8CF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    jp Jump_036_6CC1

Jump_036_6D1A::
    jp Jump_036_7CB0

Jump_036_6D1D::
    jp Jump_036_7CD3

; 1 call site from 1 routine (e.g. Func_036_74A0)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD8A4, wDAC0, wDA1D
Func_036_6D20:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD8A4
    cp a, [hl]
    jr z, Jump_036_6D1D
    ld a, [wD8A5]
    and a, $03
    cp a, $03
    jr z, Jump_036_6D1D
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_6D45
    jr z, Jump_036_6D1D
    call Func_036_6D0A
    ld hl, wDAC0
    set 6, [hl]
    ret

Jump_036_6D45::
    call Func_036_6C24
    ld hl, wDAC0
    res 6, [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
Func_036_6D4E:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $03
    jr z, Jump_036_6D61
    ld a, [hl]
    and a, $FC
    ld [hl], a
    ld l, $4E
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6D61::
    jp Jump_036_7CB0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wDA5B
Func_036_6D64:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $10
    jr z, Jump_036_6D84
    ld a, [hl]
    and a, $EF
    ld [hl], a
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld l, $83
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6D84::
    jp Jump_036_7CB0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wDAC3, wDAC0, wDAC1
; points at: wDA5B
Func_036_6D87:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $CC
    jr z, Jump_036_6DB2
    push hl
    bit 6, [hl]
    jr z, Jump_036_6D97
    ld l, $4F
    jr Jump_036_6D99

Jump_036_6D97::
    ld l, $82

Jump_036_6D99::
    ld bc, $4090
    call Func_036_7C9C
    pop hl
    ld a, [hl]
    and a, $33
    ld [hl], a
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ret

Jump_036_6DB2::
    jp Jump_036_7CB0

; no direct call (reached through a table, a jump or a vector)
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
Func_036_6DB5:: ; heuristic: target of a pointer table; C0
    call Func_036_7D33
    and a, $20
    jr z, Jump_036_6DC8
    ld a, [hl]
    and a, $DF
    ld [hl], a
    ld l, $51
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_6DC8::
    jp Jump_036_7CB0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD872, wD873
; writes: wDAC2, wDAC0, wDAC1, wDAC3
Func_036_6DCB:: ; heuristic: target of a pointer table; C0
    call Func_036_5360
    jr nc, Jump_036_6DEA
    ld a, [wD8A5]
    call Func_036_7D45
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, l
    or a, h
    jr z, Jump_036_6DEA
    ld l, $45
    ld bc, $0090
    jp Jump_036_7CA3

Jump_036_6DEA::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wDAC2, wDAC0, wDAC1, wDAC3
Func_036_6DF2:: ; heuristic: target of a pointer table; C0
    call Func_036_53C6
    jp nc, Jump_036_7CB7

; 1 call site from 1 routine (e.g. Func_036_757F)
; reads: wD8A5
; writes: wDAC2, wDAC0, wDAC1, wDAC3
Func_036_6DF8::
    call Func_036_53EF
    jr nc, Jump_036_6E0B
    ld a, [wD8A5]
    call Func_036_7D50
    ld l, $39
    ld bc, $0098
    jp Jump_036_7CA3

Jump_036_6E0B::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD872, wD873
; writes: wDAC2, wDAC0, wDAC1, wDAC3
Func_036_6E13:: ; heuristic: follows a terminator; C0
    call Func_036_5441
    jr nc, Jump_036_6E32
    ld a, [wD8A5]
    call Func_036_7D45
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, l
    or a, h
    jr z, Jump_036_6E32
    ld l, $49
    ld bc, $0090
    jp Jump_036_7CA3

Jump_036_6E32::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC
    db $CD, $A7, $54, $D2, $B7, $7C

; 1 call site from 1 routine (e.g. Func_036_4A38)
; reads: wD8A5
; writes: wDAC2, wDAC0, wDAC1, wDAC3
Func_036_6E40::
    call Func_036_54BE
    jr nc, Jump_036_6E53
    ld a, [wD8A5]
    call Func_036_7D50
    ld l, $48
    ld bc, $0098
    jp Jump_036_7CA3

Jump_036_6E53::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, ...
; points at: wD80D, wDA1D
Func_036_6E5B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    bit 2, [hl]
    jr nz, Jump_036_6E72
    set 2, [hl]
    ld l, $43
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_6E72::
    jp Jump_036_7CD3

; 1 call site from 1 routine (e.g. Func_036_4A38)
; reads: wD8A5, wDAC0, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD80D, wDA1D
Func_036_6E75::
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_036_6E9A
    call Func_036_55FB
    jr nc, Jump_036_6EA5
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    set 1, [hl]
    ld l, $4A
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_6E9A::
    ld a, [wDAC0]
    and a, $EF
    ld [wDAC0], a
    jp Jump_036_7CD3

Jump_036_6EA5::
    jp Jump_036_7CB7

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A6
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80C
Func_036_6EA8:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $8C
    jr nz, Jump_036_6EDA
    push hl
    call Func_036_5F01
    pop hl
    jr nc, Jump_036_6EC9
    ld a, [hl]
    or a, $8C
    ld [hl], a
    ld l, $73
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_6EC9::
    ld a, [wD8A6]
    cp a, $71
    ld h, $B5
    jr z, Jump_036_6ED4
    ld h, $CE

Jump_036_6ED4::
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_6EDA::
    ld h, $D4
    ld bc, $0080
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, ...
; points at: wD80E, wDA1D
Func_036_6EE2:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_036_6EF9
    set 0, [hl]
    ld l, $3F
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_6EF9::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A6, wD8A4, hFFC6, wC982, wC983, wDAD1, wDABD
; writes: wC982, wC983, wD8A4, wD872, wD873, wDAC2, wDAC0, wDAC1, ...
; points at: wD8DF, wD8EF, wDA1D
Func_036_6EFC:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jp z, Jump_036_6F93
    ld a, [wD8A6]
    cp a, $DF
    jr z, Jump_036_6F2D
    ld a, [wD8A4]
    call Func_036_7E47
    ld a, [wD8A4]
    ld de, wD8EF
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_036_6F23
    inc d

Jump_036_6F23::
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    call CompareHLToBC
    jr nc, Jump_036_6F93

Jump_036_6F2D::
    call Func_036_5626
    jr nc, Jump_036_6F93
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    sra b
    rr c
    ld a, c
    ld [wC982], a
    ld a, b
    ld [wC983], a
    call Func_036_5640
    ld a, [wD8A6]
    cp a, $DF
    jr nz, Jump_036_6F8B
    farcall Func_0A3_414F
    ld a, [wD8A4]
    push af
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_036_5640
    pop af
    ld [wD8A4], a
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wC982]
    ld c, a
    ld a, [wC983]
    ld b, a
    sla c
    rl b
    ld a, c
    ld [wD872], a
    ld a, b
    ld [wD873], a

Jump_036_6F8B::
    ld l, $3D
    ld bc, $4098
    jp Jump_036_7CA3

Jump_036_6F93::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD80D, wDA1D
Func_036_6F96:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_036_6FBB
    call Func_036_56CB
    jr nc, Jump_036_6FBE
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    set 0, [hl]
    ld l, $3B
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_6FBB::
    jp Jump_036_7CD3

Jump_036_6FBE::
    jp Jump_036_7CB7

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80C
Func_036_6FC1:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_036_6FE6
    call Func_036_56E0
    jr nc, Jump_036_6FEE
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    set 4, [hl]
    ld l, $42
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_6FE6::
    ld h, $CF
    ld bc, $0084
    jp Jump_036_7CBC

Jump_036_6FEE::
    jp Jump_036_7CB7

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
; points at: wD811
Func_036_6FF1:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_036_700D
    ld a, [wD8A5]
    cp a, $04
    jr c, Jump_036_700D
    ld hl, wD811
    call AddAx9ToHL
    ld b, $01
    ld a, [wD8A5]
    ld c, a
    jr Jump_036_701B

Jump_036_700D::
    ld b, $04
    ld a, [wD8A5]
    and a, $04
    ld c, a
    ld hl, wD811
    call AddAx9ToHL

Jump_036_701B::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7025
    ld a, [hl]
    or a, $C0
    ld [hl], a

Jump_036_7025::
    ld a, $09
    add_a_to_hl
    inc c
    dec b
    jr nz, Jump_036_701B
    farcall Func_03A_7B66
    ld l, d
    ld bc, $0090
    jp Func_036_7C9C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wD8A6
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80E
Func_036_703D:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    ld a, [wD8A6]
    cp a, $37
    jr z, Jump_036_705F
    bit 5, [hl]
    jr nz, Jump_036_7071
    ld a, [hl]
    and a, $DD
    or a, $20
    ld [hl], a
    ld l, $4B
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_705F::
    bit 1, [hl]
    jr nz, Jump_036_7071
    ld a, [hl]
    and a, $DD
    or a, $02
    ld [hl], a
    ld l, $4C
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7071::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, ...
; points at: wD80E, wDA1D
Func_036_7079:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    and a, $04
    ld c, a
    ld b, $04
    ld d, $00

Jump_036_7083::
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7099
    bit 2, [hl]
    jr nz, Jump_036_709B
    inc d
    set 2, [hl]
    jr Jump_036_709B

Jump_036_7099::
    res 2, [hl]

Jump_036_709B::
    inc c
    dec b
    jr nz, Jump_036_7083
    ld a, d
    or a, a
    jr z, Jump_036_70AB
    ld l, $4D
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_70AB::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD814, wDA1D
Func_036_70AE:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_70B6::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_70C5
    ld a, c
    ld hl, wD814
    call AddAx9ToHL
    set 6, [hl]

Jump_036_70C5::
    inc c
    dec b
    jr nz, Jump_036_70B6
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; points at: wDAD8, wD80D
Func_036_70CC:: ; heuristic: follows a terminator; C0
    ld l, $52
    ld bc, $4090
    call Func_036_7C9C
    call Func_036_5703
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    set 5, [hl]
    res 4, [hl]
    ret

; 1 call site from 1 routine (e.g. Func_036_4582)
; reads: wC58A, wD8A4, wD8A5
; points at: wDAD4
Func_036_70F4::
    ld a, [wC58A]
    cp a, $01
    ret z
    ld a, [wD8A4]
    cp a, $04
    ret c
    and a, $03
    ld hl, wDAD4
    add_a_to_hl
    ld a, [wD8A5]
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_036_6A69)
; reads: wD8A4, wD8A6
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
; points at: wDAD8, wD80D
Func_036_710F:: ; heuristic: follows a terminator; C0
    call Func_036_5F25
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    set 4, [hl]
    res 5, [hl]
    ld a, [wD8A4]
    ld c, a
    farcall Func_032_5E1E
    ld a, [wD8A6]
    cp a, $DC
    jr z, Jump_036_7147
    ld l, $44
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_7147::
    ld l, $F7
    ld bc, $4090
    jp Func_036_7C9C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; writes: wD8A6, wCFEC, wCFED, wD8A5, wCFCA, wCFCB
; points at: wDA1C, wDA1D
Func_036_714F:: ; heuristic: follows a terminator; C0
    farcall Func_0A3_4AAF
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld a, c
    ld [hl], a
    ld [wD8A6], a
    ld [wCFEC], a
    ld a, $00
    ld [wCFED], a
    farcall Func_01A_4001
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld [hl], $FF
    farcall Func_030_4102
    ld a, d
    ld [wD8A5], a
    xor a, a
    ld [wCFCA], a
    ld a, $03
    ld [wCFCB], a
    ret
    db $FA, $66, $D8, $6F, $FA, $67, $D8, $67, $7D, $B4, $CA, $B7, $7C, $CD, $5C, $58
    db $C3, $7D, $7C

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71A9:: ; heuristic: target of a pointer table; C0
    call Func_036_5328
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71AF:: ; heuristic: target of a pointer table; C0
    call Func_036_5336
    call Func_036_7D13
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71B8:: ; heuristic: target of a pointer table; C0
    call Func_036_5344
    call Func_036_7D13
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71C1:: ; heuristic: target of a pointer table; C0
    call Func_036_58C5
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71C7:: ; heuristic: target of a pointer table; C0
    call Func_036_592E
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71CD:: ; heuristic: target of a pointer table; C0
    call Func_036_5993
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71D3:: ; heuristic: target of a pointer table; C0
    call Func_036_5352
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: sB535
Func_036_71D9:: ; heuristic: target of a pointer table; C0
    call Func_036_60B4
    jp Jump_036_7C7D

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC5E7
; writes: wCFCA, wCFCB, wDAC3, wDAC0, wDAC1, wDAC2
; points at: wD812, wD035
Func_036_71DF:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_036_7214
    push hl
    call Func_000_3ED4
    pop hl
    ld a, [wC5E7]
    cp a, $80
    jr c, Jump_036_720C
    set 0, [hl]
    ld d, $53
    farcall Func_03A_7193
    ld a, $03
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_036_720C::
    ld h, $69
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_7214::
    call Func_036_5DCF
    jp Func_036_7C85

Data_036_721A:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $22, $55, $C3, $85, $7C

Data_036_7220:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $33, $55, $C3, $85, $7C

Data_036_7226:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $44, $55, $C3, $85, $7C

Data_036_722C:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $55, $55, $C3, $85, $7C

Data_036_7232:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $66, $55, $C3, $85, $7C

Data_036_7238:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $71, $55, $C3, $85, $7C

Data_036_723E:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $7C, $55, $C3, $85, $7C

Data_036_7244:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $87, $55, $C3, $85, $7C

Data_036_724A:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $92, $55, $C3, $85, $7C

Data_036_7250:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $9D, $55, $C3, $85, $7C

Data_036_7256:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $A8, $55, $C3, $85, $7C

Data_036_725C:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $B3, $55, $C3, $85, $7C

Data_036_7262:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $BE, $55, $C3, $85, $7C

Data_036_7268:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0DB268, $78

; 1 call site from 1 routine (e.g. Func_036_7378)
; reads: wD872, wD873
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_72E0::
    call Func_036_5013
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_6465
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    jp Func_036_7C85

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD, wD872, wD873
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1, wD872, wD873, ...
; points at: wD810, wDA1D, wD035
Func_036_72F9:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_730E
    ld a, [hl]
    or a, $0C
    ld [hl], a
    jp Jump_036_7CD3

Jump_036_730E::
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr Func_036_72E0

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wC5E7, wD8A4
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80E, wD235
Func_036_7314:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    call Func_000_3E25
    jr c, Jump_036_7326
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $A0
    jr c, Jump_036_734B

Jump_036_7326::
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    ld a, [wD8A4]
    call Func_036_7E2E
    call Func_036_4930
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ld hl, wD235
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_734B::
    ld h, $D2
    ld bc, $0080
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80E, sB535
Func_036_7353:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    ld a, [wD8A4]
    call Func_036_7E2E
    call Func_036_4930
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ld hl, sB535
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; points at: wD80E
Func_036_7378:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    call Func_036_72E0
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wD872, wD873
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD812, wD80E, wD035
Func_036_7387:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    set 2, [hl]
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    res 7, [hl]
    call Func_036_5013
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    sla l
    rl h
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    jp Func_036_7C85
    db $CD, $7A, $5A, $C3, $85, $7C, $CD, $98, $5A, $C3, $7D, $7C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wDAC3, wDAC0, wDAC1, wD872, wD873, wDAC2, wD8A5, wDAD1, ...
; points at: wD80C, wDA1D
Func_036_73C3:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_036_73E9
    push hl
    call Func_036_60EB
    pop hl
    jr c, Jump_036_73DF
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_73DF::
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_73E9::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A6, wDAD1, wD8A4, wDABD
; writes: wDAC3, wDAC0, wDAC1, wD872, wD873, wDAC2, wD8A5, wDAD1, ...
; points at: wD80C, wDA1D
Func_036_73EC:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [wD8A6]
    cp a, $74
    jr z, Jump_036_7403
    ld a, [hl]
    and a, $03
    jr nz, Jump_036_7431
    jr Jump_036_7407

Jump_036_7403::
    bit 1, [hl]
    jr nz, Jump_036_7431

Jump_036_7407::
    push hl
    call Func_036_60D1
    pop hl
    jr c, Jump_036_7416
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7416::
    ld a, [wD8A6]
    cp a, $74
    jr z, Jump_036_7425
    set 0, [hl]
    res 1, [hl]
    ld l, $75
    jr Jump_036_742B

Jump_036_7425::
    set 1, [hl]
    res 0, [hl]
    ld l, $77

Jump_036_742B::
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_7431::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wDAC3, wDAC0, wDAC1, wD872, wD873, wDAC2, wD8A5, wDAD1, ...
; points at: wD80C, wDA1D
Func_036_7434:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    bit 5, [hl]
    jr nz, Jump_036_745A
    push hl
    call Func_036_5B02
    pop hl
    jr c, Jump_036_7450
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7450::
    set 5, [hl]
    ld l, $D9
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_745A::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD8DF, wDA1D
Func_036_745D:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_036_747B
    db $CD

; no direct call (reached through a table, a jump or a vector)
; writes: wDAC2, wDAC0, wDAC1, wDAC3
Func_036_746B:: ; heuristic: target of a pointer table; C0
    ld h, $56
    jp nc, Jump_036_7CB7
    call Func_036_5671
    ld l, $57
    ld bc, $4090
    jp Jump_036_7CA3

Jump_036_747B::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wDA1D
Func_036_747E:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 1, [hl]
    jr nz, Jump_036_749D
    call Func_036_5B5D
    jr nc, Jump_036_749A
    call Func_036_7D5B
    set 1, [hl]
    call Func_036_7D65
    ld l, $58
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_749A::
    jp Jump_036_7CB7

Jump_036_749D::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wDABA, wC5E7
; writes: wCFCA, wCFCB, wCFCC
; points at: wCFCF
Func_036_74A0:: ; heuristic: target of a pointer table; C0
    ld a, [wDABA]
    or a, a
    jr nz, Jump_036_74CD
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $01
    jr nz, Jump_036_74CD
    ld d, $CC
    farcall Func_03A_7193
    ld a, $01
    ld [wCFCA], a
    ld a, $0E
    ld [wCFCB], a
    ld a, $00
    ld [wCFCC], a
    ld hl, wCFCF
    set 0, [hl]
    ret

Jump_036_74CD::
    call Func_036_6D20
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC5E7, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD811, wDA1D
Func_036_74D1:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [wD8A4]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_74EF
    ld a, [wC5E7]
    and a, $04
    add a, $04
    ld b, a
    ld a, [hl]
    and a, $F3
    or a, b
    ld [hl], a

Jump_036_74EF::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A6, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD811, wD80D, wDA1D
Func_036_74F2:: ; heuristic: target of a pointer table; C0
    ld d, $02
    jr Jump_036_74F8

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A6, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD811, wD80D, wDA1D
Func_036_74F6:: ; heuristic: target of a pointer table; C0
    ld d, $01

Jump_036_74F8::
    ld a, [wD8A5]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, d
    jr nz, Jump_036_7539
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    bit 1, [hl]
    jr nz, Jump_036_7539
    push de
    call Func_036_55FB
    pop de
    jr nc, Jump_036_7531
    ld a, [wD8A5]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    or a, d
    ld [hl], a
    ld a, [wD8A6]
    sub a, $2A
    ld l, a
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7531::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7539::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD814
Func_036_753C:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD814
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_036_7569
    call Func_036_6126
    jr nc, Jump_036_7561
    ld a, [wD8A5]
    ld hl, wD814
    call AddAx9ToHL
    set 7, [hl]
    ld l, $D5
    ld bc, $0098
    jp Func_036_7C9C

Jump_036_7561::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7569::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
Func_036_7571:: ; heuristic: target of a pointer table; C0
    farcall Func_032_6581
    ld l, $60
    ld bc, $0090
    jp Func_036_7C9C

; no direct call (reached through a table, a jump or a vector)
; writes: wCFCC, wDAC3, wDAC0, wDAC1
Func_036_757F:: ; heuristic: target of a pointer table; C0
    call Func_036_5B19
    jr nc, Jump_036_7591
    call Func_036_5B8B
    jr nc, Jump_036_7591
    call Func_036_6DF8
    xor a, a
    ld [wCFCC], a
    ret

Jump_036_7591::
    ld h, $B5
    ld bc, $0080
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; writes: wCFCC, wD872, wD873, wDAC2, wDAC0, wDAC1
Func_036_7599:: ; heuristic: target of a pointer table; C0
    farcall Func_032_6622
    xor a, a
    ld [wCFCC], a
    ld l, $5E
    ld bc, $0090
    jp Func_036_7C9C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC5E7, wD8A6, wD871
; writes: wD871, wD8A5, wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80A, wD854, wDAAE
Func_036_75AB:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add_a_to_hl
    bit 2, [hl]
    jr nz, Jump_036_761F
    push hl
    ld a, [wD8A4]
    ld hl, wD854
    add a, a
    add_a_to_hl
    ld a, [hl]
    pop hl
    and a, $04
    jr nz, Jump_036_75DD
    call Func_000_3ED4
    ld a, $C0
    ld b, a
    ld a, [wC5E7]
    cp a, b
    jr nc, Jump_036_7617

Jump_036_75DD::
    set 2, [hl]
    ld a, [wD8A4]
    and a, $04
    or a, $03
    ld [wD871], a
    ld a, [wD8A6]
    sub a, $07
    ld c, a
    ld b, $00
    ld a, [wD871]
    srl a
    srl a
    and a, $01
    add a, a
    ld hl, wDAAE
    add_a_to_hl
    ld [hl], c
    inc hl
    ld [hl], b
    call Func_036_5BC4
    ld a, [wD871]
    ld [wD8A5], a
    ld l, $61
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7617::
    ld h, $72
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_761F::
    ld h, $CC
    ld bc, $0084
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD810, wDA1D
Func_036_7627:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    or a, $30
    ld [hl], a
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD810, wDA1D
Func_036_7637:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    set 7, [hl]
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD90F, wDA1D
Func_036_7645:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 3, [hl]
    jr nz, Jump_036_7694
    ld a, [wD8A6]
    cp a, $8C
    jr z, Jump_036_7658
    call Func_036_5B5D
    jr Jump_036_765B

Jump_036_7658::
    call Func_036_53C6

Jump_036_765B::
    jr nc, Jump_036_768C
    call Func_036_7D5B
    set 3, [hl]
    call Func_036_7D65
    ld a, [wD8A6]
    cp a, $8B
    jr z, Jump_036_7680
    ld a, [wD8A5]
    ld hl, wD90F
    call AddDoubleAToHL_Bank36
    ld a, $01
    ld [hl+], a
    ld [hl], $00
    ld a, [wD8A5]
    call Func_036_7D50

Jump_036_7680::
    ld a, [wD8A6]
    sub a, $31
    ld l, a
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_768C::
    ld h, $71
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_7694::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD8A7, wDA1D
Func_036_7697:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 2, [hl]
    jp nz, Jump_036_7CD3
    call Func_036_5D91
    jr nc, Jump_036_76B4
    call Func_036_7D5B
    set 2, [hl]
    call Func_036_7D65
    ld l, $5D
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_76B4::
    ld a, [wD8A5]
    ld hl, wD8A7
    add_a_to_hl
    bit 4, [hl]
    ld h, $70
    jr z, Jump_036_76C7
    ld h, $68

Jump_036_76C7::
    ld bc, $0080
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wDA1D
Func_036_76CD:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 5, [hl]
    jr nz, Jump_036_76F1
    call Func_036_5B5D
    jr nc, Jump_036_76E9
    call Func_036_7D5B
    set 5, [hl]
    call Func_036_7D65
    ld l, $59
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_76E9::
    ld h, $B5
    ld bc, $0888
    jp Jump_036_7CBC

Jump_036_76F1::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wDA1D
Func_036_76F4:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 4, [hl]
    jr nz, Jump_036_7718
    call Func_036_5B5D
    jr nc, Jump_036_7710
    call Func_036_7D5B
    set 4, [hl]
    call Func_036_7D65
    ld l, $5C
    ld bc, $0090
    jp Func_036_7C9C

Jump_036_7710::
    ld h, $6B
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_7718::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wD8A5, wC5E7
; writes: wCFCA, wCFCB, wDAC3, wDAC0, wDAC1, wD8A5, wD872, wD873, ...
; points at: wD80F, wD854, wD80C, wD0AD
Func_036_771B:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr z, Jump_036_775E
    call Func_036_6116
    jr nc, Jump_036_7756
    ld a, [wD8A5]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    ld a, $40
    ld [hl], a
    ld a, [wD8A5]
    add a, a
    ld hl, wD854
    add_a_to_hl
    ld [hl], $00
    ld d, $DD
    farcall Func_03A_7193
    jp Func_036_7CC9

Jump_036_7756::
    ld h, $6E
    ld bc, $0080
    jp Jump_036_7CBC

Jump_036_775E::
    ld a, [hl]
    and a, $3F
    ld [hl], a
    ld a, [wD8A4]
    ld [wD8A5], a
    ld hl, wD80C
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_036_7780
    bit 7, [hl]
    jr nz, Jump_036_7780
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_036_77AD

Jump_036_7780::
    ld a, [wD8A4]
    call Func_036_7E38
    push hl
    call Func_036_64E2
    ld c, l
    ld b, h
    pop hl
    push bc
    call Func_036_64EC
    pop bc
    call Func_000_3E98
    ld a, d
    or a, e
    jr nz, Jump_036_779C
    ld de, $0001

Jump_036_779C::
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ld hl, wD0AD
    ld bc, vTiles1 + $A8
    jp Jump_036_7C8B

Jump_036_77AD::
    ld h, $AF
    ld bc, $0080
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD80D, wDA1D
Func_036_77B5:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    bit 6, [hl]
    jp nz, Jump_036_7CD3
    call Func_036_5DA3
    jr nc, Jump_036_77DB
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    set 6, [hl]
    ld l, $DE
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_77DB::
    jp Jump_036_7CB7

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3, wD8A5, wDAD1, ...
; points at: wD80D, wDA1D
Func_036_77DE:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_036_7806
    call Func_036_5DB8
    jr nc, Jump_036_7803
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    set 7, [hl]
    ld l, $64
    ld bc, $4098
    jp Func_036_7C9C

Jump_036_7803::
    jp Jump_036_7CB7

Jump_036_7806::
    jp Jump_036_7CD3

; 1 call site from 1 routine (e.g. Func_036_6AF0)
; reads: wD8A4, wD8A6, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD813, wDA1D
Func_036_7809:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD813
    call AddAx9ToHL
    ld a, [wD8A6]
    cp a, $96
    jr z, Jump_036_782D
    cp a, $E0
    jr nz, Jump_036_7825
    ld a, [hl]
    and a, $F0
    or a, $0C
    ld [hl], a
    jr Jump_036_7833

Jump_036_7825::
    ld a, [hl]
    and a, $F0
    or a, $02
    ld [hl], a
    jr Jump_036_7833

Jump_036_782D::
    ld a, [hl]
    and a, $F0
    or a, $04
    ld [hl], a

Jump_036_7833::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD812, wDA1D
Func_036_7836:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    set 5, [hl]
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wD8A6, wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD80A, wD8A4, wD812, wDA1D
Func_036_7844:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    add a, l
    ld l, a

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wD8A5, wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD8A4, wD812, wDA1D
Func_036_7850:: ; heuristic: target of a pointer table; C0
    jr nc, Jump_036_7853
    inc h

Jump_036_7853::
    bit 4, [hl]
    jp nz, Jump_036_7CD3
    ld a, [wD8A6]
    cp a, $98
    jr z, Jump_036_7867
    ld a, [wD8A5]
    ld c, a
    ld b, $01
    jr Jump_036_7871

Jump_036_7867::
    set 4, [hl]
    ld a, [wD8A5]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_7871::
    ld a, c

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD8A4, wD812, wDA1D
Func_036_7872:: ; heuristic: target of a pointer table; C0
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7894
    ld a, c
    ld hl, wD8A4
    cp a, [hl]
    jr z, Jump_036_7894
    ld hl, wD812
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_036_7894
    set 4, [hl]
    inc hl
    ld a, [wD8A4]
    and a, $0F
    swap a
    or a, [hl]
    ld [hl], a

Jump_036_7894::
    inc c
    dec b
    jr nz, Jump_036_7871
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wD8A5, wDAD1, wD8A4, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD80E, wDA1D, wD80A
Func_036_789B:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A6]
    cp a, $9A
    jr z, Jump_036_78AF
    ld a, [wD8A5]
    ld hl, wD80E
    call AddAx9ToHL
    set 6, [hl]
    jr Jump_036_78DB

Jump_036_78AF::
    ld a, [wD8A5]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_78B7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_78C6
    ld a, c
    ld hl, wD80E
    call AddAx9ToHL
    set 6, [hl]

Jump_036_78C6::
    inc c
    dec b
    jr nz, Jump_036_78B7
    ld a, [wD8A5]
    rra
    rra
    and a, $01
    ld hl, wD80A
    add_a_to_hl
    set 5, [hl]

Jump_036_78DB::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD80E, wDA1D
Func_036_78DE:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80E
    call AddAx9ToHL
    set 3, [hl]
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD814, wDA1D
Func_036_78EC:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD814
    call AddAx9ToHL
    set 4, [hl]
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD80A, wD864, wD812, wDA1D
Func_036_78FA:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    rrca
    rrca
    and a, $01
    ld b, a
    ld hl, wD80A
    add_a_to_hl
    bit 6, [hl]
    jp nz, Jump_036_7CD3
    set 6, [hl]
    ld a, b
    ld hl, wD864
    add_a_to_hl
    ld a, [wD8A4]
    and a, $03
    rla
    rla
    or a, [hl]
    ld [hl], a
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    set 1, [hl]
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD812, wDA1D
Func_036_7931:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    set 3, [hl]
    jp Jump_036_7CD3
    db $CD, $86, $5E, $30, $08, $2E, $37, $01, $90, $40, $C3, $A3, $7C, $C3, $B0, $7C
    db $FA, $A4, $D8, $21, $11, $D8, $CD, $25, $3F, $7E, $E6, $10, $20, $09, $7E, $E6
    db $CF, $F6, $20, $77, $C3, $03, $7D

Jump_036_7966::
    ld a, [wDABA]
    or a, a
    jr nz, Jump_036_7981
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $80
    jr c, Jump_036_7981
    ld d, $72
    farcall Func_03A_7193
    jp Func_036_7D03

Jump_036_7981::
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_036_7998
    jr z, Jump_036_7998
    ld a, [wD8A5]
    and a, $03
    cp a, $03
    jr z, Jump_036_7998
    call Func_036_6D0A
    ret

Jump_036_7998::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC5E7, wC96F
; writes: wCFCA, wCFCB
; points at: wD814, wDAFA
Func_036_799B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wD814
    call AddAx9ToHL
    ld a, [hl]
    and a, $01
    jr nz, Jump_036_79CF
    push hl
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $0F
    ld hl, $79DC
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, [wD8A4]
    ld hl, wDAFA
    add_a_to_hl
    pop af
    ld [hl], a
    pop hl
    set 1, [hl]
    jp Func_036_7D03

Jump_036_79CF::
    ld a, [wC96F]
    or a, a
    jr z, Jump_036_79D9
    call Func_036_6C24
    ret

Jump_036_79D9::
    jp Func_036_7D03
    db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $02, $02, $02
    db $C9, $CD, $13, $50, $FA, $72, $D8, $6F, $FA, $73, $D8, $67, $CD, $1C, $65, $7D
    db $EA, $72, $D8, $7C, $EA, $73, $D8, $C3, $7D, $7C, $FA, $A4, $D8, $21, $13, $D8
    db $CD, $25, $3F, $7E, $E6, $F0, $F6, $01, $77, $C3, $D3, $7C

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wD8A4, wD8A5, wD8A6, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD8BF, wDA63, wD94F, wDA1D
Func_036_7A18:: ; heuristic: target of a pointer table; C0
    ld a, [wC58A]
    or a, a
    jp nz, Jump_036_7CD3
    ld a, [wD8A4]
    cp a, $04
    jp nc, Jump_036_7CD3
    ld a, [wD8A5]
    cp a, $04
    jr c, Jump_036_7A7A
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wD8A5]
    ld hl, wDA63
    add_a_to_hl
    ld [hl], $FF
    ld a, [wD8A5]
    and a, $03
    ld hl, wD94F
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall Func_032_5AB3
    ld a, [wD8A6]
    cp a, $B2
    ld d, $8F
    jr z, Jump_036_7A85
    ld d, $D8
    farcall Func_03A_7193
    ld a, $82
    call StoreWC60B
    jp Jump_036_7CD3

Jump_036_7A7A::
    ld a, [wD8A6]
    cp a, $B2
    ld d, $8F
    jr z, Jump_036_7A85
    ld d, $5C

Jump_036_7A85::
    farcall Func_03A_7193
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD80D, wDA1D
Func_036_7A8E:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_036_7A96::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_036_7AA5
    ld a, c
    ld hl, wD80D
    call AddAx9ToHL
    set 3, [hl]

Jump_036_7AA5::
    inc c
    dec b
    jr nz, Jump_036_7A96
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1, wDAC3
; points at: wD80C
Func_036_7AAC:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $8C
    jr nz, Jump_036_7ACD
    ld a, [hl]
    or a, $8C
    ld [hl], a
    call Func_036_7E87
    ld l, $73
    jr nc, Jump_036_7AC7
    ld l, $74

Jump_036_7AC7::
    ld bc, $4090
    jp Func_036_7C9C

Jump_036_7ACD::
    ld h, $D4
    ld bc, $0080
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wDAC2, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, wCFCB
; points at: wD8DF, wDA1D
Func_036_7AD5:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    ld a, [hl+]
    or a, [hl]
    jp z, Jump_036_7CD3
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld l, $DF
    ld bc, $4090
    jp Jump_036_7CA3
    db $CD, $98, $60, $C3, $85, $7C

; no direct call (reached through a table, a jump or a vector)
; reads: wDAD1, wD8A4, wDABD
; writes: wDAC2, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, wCFCB
; points at: wDA1D
Func_036_7AF4:: ; heuristic: target of a pointer table; C0
    call Func_036_7D5B
    bit 0, [hl]
    jp nz, Jump_036_7CD3
    set 0, [hl]
    call Func_036_7D65
    ld l, $78
    ld bc, $0098
    jp Jump_036_7CA3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wDAC2, wDAC0, wDAC1, wD8A5, wDAD1, wCFCA, wCFCB
; points at: wD8DF, wD8EF, wDA1D
Func_036_7B09:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank36
    push hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD8EF
    call AddDoubleAToHL_Bank36
    deref_hl
    call CompareHLToBC
    pop bc
    jp z, Jump_036_7CD3
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld l, $C3
    ld bc, $4090
    jp Jump_036_7CA3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
; points at: wD8BF
Func_036_7B36:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank36
    ld c, l
    ld b, h
    ld a, [hl+]
    cp a, $01
    jr nz, Jump_036_7B5C
    ld a, [hl]
    or a, a
    jr nz, Jump_036_7B5C
    ld hl, $0001
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld l, $35
    ld bc, vTiles1 + $A8
    jr Jump_036_7B68

Jump_036_7B5C::
    ld a, $01
    ld [bc], a
    inc bc
    ld a, $00
    ld [bc], a
    ld l, $38
    ld bc, $4090

Jump_036_7B68::
    jp Jump_036_7CA3

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD136
Func_036_7B6B:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $40
    jr c, Jump_036_7B81
    call Func_036_5013
    ld hl, wD136
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

Jump_036_7B81::
    ld h, $D1
    ld bc, $0888
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
; reads: wC5E7
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_7B89:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $C0
    jr c, Jump_036_7B99
    call Func_036_5013
    jp Func_036_7C85

Jump_036_7B99::
    ld h, $D0
    ld bc, $0888
    jp Jump_036_7CBC

; no direct call (reached through a table, a jump or a vector)
Func_036_7BA1:: ; heuristic: target of a pointer table; C0
    call Func_036_6B75
    ret
    db $C3, $D3, $7C

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wDAD1, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wD80F, wDA1D
Func_036_7BA8:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    set 2, [hl]
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; writes: wDAC2, wDAC0, wDAC1
; points at: wD80C
Func_036_7BB6:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    set 6, [hl]
    ld l, $76
    ld bc, $4090
    jp Jump_036_7CA3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5, wDAD1, wD8A4, wDABD
; writes: wD8A5, wDAD1, wCFCA, wCFCB, wDAC0, wDAC1
; points at: wDA63, wD94F, wDA1D
Func_036_7BC9:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A5]
    ld hl, wDA63
    add_a_to_hl
    ld [hl], $FF
    call Func_036_7E87
    jr c, Jump_036_7BF5
    ld a, [wD8A5]
    and a, $03
    ld hl, wD94F
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    farcall Func_032_5AB3

Jump_036_7BF5::
    jp Jump_036_7CD3

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80F, sAF36
Func_036_7BF8:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [wD8A4]
    call Func_036_7E42
    ld a, $0A
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, Jump_036_7C1B
    ld hl, $0001

Jump_036_7C1B::
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld hl, sAF36
    ld bc, vTiles0 + $A8
    jp Jump_036_7C8B

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80F, wD80C, sAFAF, sAF36
Func_036_7C2C:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld [hl+], a
    ld a, [hl]
    and a, $F3
    ld [hl], a
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $0C
    jr nz, Func_036_7BF8
    ld hl, $0000
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld hl, sAFAF
    ld bc, $0080
    jp Jump_036_7C8B

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wD872, wD873
; writes: wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD810, wD035
Func_036_7C5F:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    jp Jump_036_730E

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wC5E7
; writes: wD8A5, wD872, wD873, wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD80F, wD80C, wD0AD
Func_036_7C6B:: ; heuristic: target of a pointer table; C0
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    jp Jump_036_775E

; no direct call (reached through a table, a jump or a vector)
; reads: wDABA, wC5E7, wD8A5, wDAD1, wD8A4, wDABD
; writes: wCFCA, wCFCB, wD8A5, wDAD1, wDAC0, wDAC1
; points at: wDA1D
Func_036_7C77:: ; heuristic: target of a pointer table; C0
    jp Jump_036_7966

; no direct call (reached through a table, a jump or a vector)
; reads: wC96F
; writes: wCFCA, wCFCB
Func_036_7C7A:: ; heuristic: target of a pointer table; C0
    jp Jump_036_79CF

Jump_036_7C7D::
    ld hl, sB535
    ld bc, vTiles0 + $A8
    jr Jump_036_7C8B

; 1 call site from 1 routine (e.g. Func_036_4582)
; writes: wDAC2, wDAC3, wDAC0, wDAC1
; points at: wD035
Func_036_7C85::
    ld hl, wD035
    ld bc, vTiles1 + $A8

Jump_036_7C8B::
    ld a, l
    ld [wDAC2], a
    ld a, h
    ld [wDAC3], a
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

; 2 call sites from 2 routines (e.g. Func_036_70CC, Func_036_6D87)
; writes: wD872, wD873, wDAC2, wDAC0, wDAC1
Func_036_7C9C::
    xor a, a
    ld [wD872], a
    ld [wD873], a

Jump_036_7CA3::
    ld a, l
    ld [wDAC2], a
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

Jump_036_7CB0::
    ld h, $CC
    ld bc, $0080
    jr Jump_036_7CBC

Jump_036_7CB7::
    ld h, $B5
    ld bc, $0080

Jump_036_7CBC::
    ld a, h
    ld [wDAC3], a

Jump_036_7CC0::
    ld a, c
    ld [wDAC0], a
    ld a, b
    ld [wDAC1], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wCFCA, wCFCB
Func_036_7CC9:: ; heuristic: follows a terminator; C0
    ld a, $02
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_036_7CD3::
    ld a, [wDAD1]
    cp a, $FF
    jr z, Jump_036_7CF3
    push hl
    ld [wD8A5], a
    push af
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    pop af
    ld [hl], a
    ld a, $FF
    ld [wDAD1], a
    pop hl

Jump_036_7CF3::
    ld a, [wDABD]
    or a, a
    jr nz, Jump_036_7D0D
    ld a, $03
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wCFCA, wCFCB
Func_036_7D03:: ; heuristic: follows a terminator; C0
    ld a, $07
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_036_7D0D::
    ld bc, $0000
    jp Jump_036_7CC0

; 2 call sites from 2 routines (e.g. Func_036_71B8, Func_036_71AF)
; reads: wD8A5, wD872, wD873
; writes: wD872, wD873
; points at: wD80E
Func_036_7D13:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD80E
    call AddAx9ToHL
    bit 2, [hl]
    ret z
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    call Func_036_651C
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

; 6 call sites from 6 routines (e.g. Func_036_69ED, Func_036_697B, Func_036_6DB5, Func_036_6D87, ...)
; reads: wD8A5
; writes: wD872, wD873
; points at: wD80C
Func_036_7D33:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [wD872], a
    ld [wD873], a
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    ret

; 4 call sites from 3 routines (e.g. Func_036_6A82, Func_036_6DCB, Func_036_6E13)
; points at: wD812
Func_036_7D45:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, wD812
    call AddAx9ToHL
    set 6, [hl]
    pop hl
    ret

; 3 call sites from 3 routines (e.g. Func_036_6E40, Func_036_7645, Func_036_6DF8)
; points at: wD812
Func_036_7D50::
    push hl
    ld hl, wD812
    call AddAx9ToHL
    set 7, [hl]
    pop hl
    ret

; 11 call sites from 6 routines (e.g. Func_036_7AF4, Func_036_76F4, Func_036_76CD, Func_036_7697, ...)
; reads: wD8A5
; points at: wD80F
Func_036_7D5B:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD80F
    call AddAx9ToHL
    ret

; 6 call sites from 6 routines (e.g. Func_036_7AF4, Func_036_76F4, Func_036_76CD, Func_036_7697, ...)
; reads: wD8A5
; points at: wD811
Func_036_7D65:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    and a, $F8
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_036_6C9A)
; reads: wD8A5
; points at: wDA63, wD80C, wDA5B
Func_036_7D79:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld b, a
    ld hl, wDA63
    add_a_to_hl
    ld [hl], $00
    ld a, b
    ld hl, wD80C
    call AddAx9ToHL
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD895
Func_036_7DA6:: ; heuristic: follows a terminator; C0
    ld hl, wD895
    ld b, $08
    ld d, $00

Jump_036_7DAD::
    bit 0, d
    jr nz, Jump_036_7DB7
    ld a, [hl]
    cp a, c
    jr nz, Jump_036_7DC4
    ld d, $01

Jump_036_7DB7::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_036_7DAD
    ld [hl], $FF
    ret

Jump_036_7DC4::
    inc hl
    dec b
    jr nz, Jump_036_7DAD
    ret

; 1 call site from 1 routine (e.g. Func_039_6E27)
; reads: wD8A6
Func_036_7DC9:: ; heuristic: follows a terminator; C0
    ld a, [wD8A6]
    or a, a
    jr z, Jump_036_7DD1
    sub a, $47

Jump_036_7DD1::
    ld hl, $7DDE
    add a, a
    add_a_to_hl
    call Func_000_000B
    ret
    db $13, $50, $C5, $58, $2E, $59, $93, $59, $52, $53, $B4, $60, $B4, $60, $CF, $5D
    db $CF, $5D, $22, $55, $33, $55, $44, $55, $55, $55, $66, $55, $71, $55, $7C, $55
    db $87, $55, $92, $55, $9D, $55, $A8, $55, $B3, $55, $BE, $55, $C9, $55, $D4
    dw Func_000_1355
    dw Func_000_1350
    dw Func_000_1350
    dw Func_036_7850
    db $72, $0B, $5E, $0B, $5E, $13, $50, $13, $50, $6C, $5A, $13, $50, $E0, $72, $13
    db $50, $13, $50, $13, $50, $E0, $72, $13, $50

; 4 call sites from 4 routines (e.g. Func_036_4582, Func_036_5025, Func_036_7353, Func_036_7314)
; points at: wD8FF
Func_036_7E2E::
    ld hl, wD8FF
    jr Func_036_7E5B

; 2 call sites from 2 routines (e.g. Func_036_6521, Func_036_53EF)
; points at: wD90F
Func_036_7E33::
    ld hl, wD90F
    jr Func_036_7E5B

; 2 call sites from 2 routines (e.g. Func_036_5223, Func_036_771B)
; points at: wD8CF
Func_036_7E38::
    ld hl, wD8CF
    jr Func_036_7E5B

; 2 call sites from 2 routines (e.g. Func_036_65D6, Func_036_52DF)
; points at: wD8EF
Func_036_7E3D::
    ld hl, wD8EF
    jr Func_036_7E5B

; 6 call sites from 5 routines (e.g. Func_036_4A38, Func_036_5A7A, Func_036_5A98, Func_036_7BF8, ...)
; points at: wD8BF
Func_036_7E42::
    ld hl, wD8BF
    jr Func_036_7E5B

; 3 call sites from 3 routines (e.g. Func_036_4A38, Func_036_65D6, Func_036_6EFC)
; points at: wD8DF
Func_036_7E47::
    ld hl, wD8DF
    jr Func_036_7E5B
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

; 1 call site from 1 routine (e.g. Func_036_433F)
Func_036_7E5B::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; 56 call sites from 30 routines (e.g. Func_036_54BE, Func_036_4582, Func_036_42D3, Func_036_4162, ...)
AddDoubleAToHL_Bank36::
Func_036_7E65:: ; address name
    add a, a
    add_a_to_hl
    ret

; 5 call sites from 4 routines (e.g. Func_036_4A38, Func_036_4991, Func_036_4582, Func_036_4FBC)
; reads: wC58A, wC57F, wD8A4
Func_036_7E6C::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_036_7E81
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_036_7E81
    ld a, [wD8A4]
    cp a, $04
    ccf
    ret

Jump_036_7E81::
    ld a, [wD8A4]
    cp a, $04
    ret

; 6 call sites from 6 routines (e.g. Func_036_4991, Func_036_4001, Func_036_425A, Func_036_6C9A, ...)
; reads: wC58A, wC57F, wD8A5
Func_036_7E87::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_036_7E9C
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_036_7E9C
    ld a, [wD8A5]
    cp a, $04
    ccf
    ret

Jump_036_7E9C::
    ld a, [wD8A5]
    cp a, $04
    ret
    db $7A, $21, $B7, $7E, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 3 call sites from 3 routines (e.g. Func_036_4A38, Func_036_5F25, Func_036_5703)
; points at: wD095
SetBit0OfWD095Indexed_Bank36::
Func_036_7EBE:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 5 call sites from 4 routines (e.g. Func_036_4582, Func_036_4A38, Func_036_5F25, Func_036_5703)
; points at: wD095
SetBit1OfWD095Indexed_Bank36::
Func_036_7ECB:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wD095
SetBit2OfWD095Indexed_Bank36:: ; heuristic: follows a terminator; C0
Func_036_7ED8:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD968, wD970, wD978
Func_036_7EE5:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wD968
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F01
    ld l, $09
    cp a, $40
    jr nc, Jump_036_7F01
    ld l, $12

Jump_036_7F01::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wD970
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F1C
    ld l, $03
    cp a, $40
    jr nc, Jump_036_7F1C
    ld l, $06

Jump_036_7F1C::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wD978
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_036_7F37
    ld l, $01
    cp a, $40
    jr nc, Jump_036_7F37
    ld l, $02

Jump_036_7F37::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; 5 call sites from 4 routines (e.g. Func_036_433F, Func_036_4001, Func_036_42D3, Func_036_4162)
; points at: wD80F
Func_036_7F3C::
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_036_7F56
    ld a, [hl]
    and a, $0C
    jr nz, Jump_036_7F56
    xor a, a
    jr Jump_036_7F57

Jump_036_7F56::
    scf

Jump_036_7F57::
    ld a, c
    pop bc
    pop hl
    ret

; 2 call sites from 2 routines (e.g. Func_036_42AA, Func_036_4162)
; points at: wD80F
Func_036_7F5B::
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_036_7F6A
    ld a, [hl]
    and a, $0C

Jump_036_7F6A::
    pop hl
    ret
    ds $94, $00
