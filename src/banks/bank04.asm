SECTION "Bank 04", ROMX[$4000], BANK[$04]
    db $04

; 7 call sites from 2 routines (e.g. Func_002_4AE0, Func_002_4C4E)
Func_004_4001::
    call Func_004_4BB0
    call Func_004_44CE
    ret

; 2 call sites from 1 routine (e.g. Func_069_4001)
; reads: wC88D, wC83A
; writes: wC88D, wCB7D
; points at: wC83B, wCB7F
Func_004_4008::
    ld a, [wC88D]
    bit 7, a
    ret z
    xor a, a
    ld [wC88D], a
    ld a, [wC83A]
    ld [wCB7D], a
    ld hl, wC83B
    ld de, wCB7F
    ld bc, $0050
    call CopyBytes
    ret

; 1 call site from 1 routine (e.g. Func_069_4001)
; reads: wCC44, wCC45, wCD06, wCD07, wCD0B, wC967
; writes: wC967, hFFCF, wCB7D
; points at: wCE7E, wCDAF, wCD89, wCDAC
Func_004_4025::
    xor a, a
    ld [wC967], a
    ld a, [wCC44]
    and a, $07
    cp a, $03
    jr z, Jump_004_4041
    cp a, $04
    jr z, Jump_004_40A9
    cp a, $06
    jp z, Jump_004_40C4
    cp a, $02
    jp z, Jump_004_40F8
    ret

Jump_004_4041::
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD89
    add a, l
    ld l, a
    jr nc, Jump_004_404E
    inc h

Jump_004_404E::
    xor a, a
    ldh [hFFCF], a
    ld a, [hl]
    cp a, $06
    jr z, Jump_004_4082
    cp a, $02
    jr c, Jump_004_4093
    cp a, $04
    jr nc, Jump_004_4093
    push af
    cp a, $02
    jr nz, Jump_004_4068
    ld a, $01
    ld [wC967], a

Jump_004_4068::
    ld a, [wCC45]
    swap a
    ld hl, wCDAC
    add a, l
    ld l, a
    jr nc, Jump_004_4075
    inc h

Jump_004_4075::
    ld a, [hl]
    bit 7, a
    jr nz, Jump_004_407D
    pop af
    jr Jump_004_4093

Jump_004_407D::
    pop af
    add a, $08
    jr Jump_004_4093

Jump_004_4082::
    ld a, [wCD07]
    bit 7, a
    jr z, Jump_004_408E
    xor a, a
    ld [wCB7D], a
    ret

Jump_004_408E::
    ld a, $01
    ldh [hFFCF], a
    ld a, [hl]

Jump_004_4093::
    dec a
    add a, a
    ld hl, $5327
    add a, l
    ld l, a
    jr nc, Jump_004_409D
    inc h

Jump_004_409D::
    call Func_004_4129
    ld a, [wC967]
    or a, a
    ret z
    call Func_004_42CD
    ret

Jump_004_40A9::
    xor a, a
    ldh [hFFCF], a
    ld c, $06
    ld a, [wCD0B]
    cp a, $07
    jr nz, Jump_004_40B7
    ld c, $0E

Jump_004_40B7::
    ld a, c
    ld hl, $5327
    add a, l
    ld l, a
    jr nc, Jump_004_40C0
    inc h

Jump_004_40C0::
    call Func_004_4129
    ret

Jump_004_40C4::
    ld a, [wCC45]
    swap a
    ld hl, wCDAF
    add a, l
    ld l, a
    jr nc, Jump_004_40D1
    inc h

Jump_004_40D1::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_004_40DA
    and a, $01
    jr z, Jump_004_40DF

Jump_004_40DA::
    xor a, a
    ld [wCB7D], a
    ret

Jump_004_40DF::
    ld a, [wCD07]
    bit 7, a
    jr nz, Jump_004_40DA
    ld a, $01
    ldh [hFFCF], a
    ld a, $08
    ld hl, $5327
    add a, l
    ld l, a
    jr nc, Jump_004_40F4
    inc h

Jump_004_40F4::
    call Func_004_4129
    ret

Jump_004_40F8::
    xor a, a
    ldh [hFFCF], a
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCE7E
    add a, l
    ld l, a
    jr nc, Jump_004_4108
    inc h

Jump_004_4108::
    ld a, [hl]
    or a, a
    jr nz, Jump_004_4112
    ld a, [wCD06]
    or a, a
    jr z, Jump_004_4117

Jump_004_4112::
    xor a, a
    ld [wCB7D], a
    ret

Jump_004_4117::
    ld a, $02
    ldh [hFFCF], a
    ld a, $0C
    ld hl, $5327
    add a, l
    ld l, a
    jr nc, Jump_004_4125
    inc h

Jump_004_4125::
    call Func_004_4129
    ret

; 4 call sites from 1 routine (e.g. Func_004_4025)
; reads: wC190, hFF92, hFF8F, hFFCF, hFFC8, hFFC6, wCD0B, hFFD0, ...
; writes: wCB7D, hFFD0, hFFCA, hFFCB, hFFC8, hFFC6, hFFC7, hFFC9, ...
; points at: wCB7F, wCE7B
Func_004_4129::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wC190]
    add a, a
    ld c, a
    ldh a, [hFF92]
    call Multiply8
    ldh a, [hFF8F]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_004_413F
    inc h

Jump_004_413F::
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    ret z
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    cp a, $FF
    jr nz, Jump_004_415F
    ld a, e
    cp a, $FF
    jr nz, Jump_004_415B
    xor a, a
    ld [wCB7D], a
    ret

Jump_004_415B::
    cp a, $FE
    jr z, Jump_004_415F

Jump_004_415F::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hl+]
    ld [wCB7D], a
    ld b, a
    ld de, wCB7F

Jump_004_416D::
    push bc
    ld a, b
    ldh [hFFD0], a
    xor a, a
    ldh [hFFCA], a
    ld a, [hl+]
    ldh [hFFCB], a
    ld a, [hl+]
    ldh [hFFC8], a
    inc de
    ld [de], a
    inc de
    ldh a, [hFFCF]
    or a, a
    jr nz, Jump_004_418E
    ld a, [hl+]
    ldh [hFFC6], a
    ld [de], a
    inc de
    ld a, [hl+]
    ldh [hFFC7], a
    ld [de], a
    inc de
    jr Jump_004_41C0

Jump_004_418E::
    dec a
    jr nz, Jump_004_41A3
    inc hl
    inc hl
    ld a, [wCE72]
    ldh [hFFC6], a
    ld [de], a
    inc de
    ld a, [wCE73]
    ldh [hFFC7], a
    ld [de], a
    inc de
    jr Jump_004_41C0

Jump_004_41A3::
    inc hl
    inc hl
    push hl
    ld a, [wCC45]
    and a, $0F
    add a, a
    add a, a
    ld hl, wCE7B
    add a, l
    ld l, a
    jr nc, Jump_004_41B5
    inc h

Jump_004_41B5::
    ld a, [hl+]
    ldh [hFFC6], a
    ld [de], a
    inc de
    ld a, [hl]
    ldh [hFFC7], a
    ld [de], a
    inc de
    pop hl

Jump_004_41C0::
    ldh a, [hFFC8]
    or a, a
    jr z, Jump_004_41E7
    ldh a, [hFFC6]
    cp a, $09
    jr nc, Jump_004_41E7
    push hl
    swap a
    ld hl, $423D
    add a, l
    ld l, a
    jr nc, Jump_004_41D6
    inc h

Jump_004_41D6::
    ld a, [wCD0B]
    add a, l
    ld l, a
    jr nc, Jump_004_41DE
    inc h

Jump_004_41DE::
    ld a, [hl]
    ldh [hFFC6], a
    dec de
    dec de
    ld [de], a
    inc de
    inc de
    pop hl

Jump_004_41E7::
    push de
    ld a, e
    sub a, $04
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, [hl+]
    ld [de], a
    pop de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_004_41FD
    inc d

Jump_004_41FD::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl]
    ld [de], a
    push de
    ld a, $07
    add a, e
    ld e, a
    jr nc, Jump_004_420B
    inc d

Jump_004_420B::
    ld a, [hl+]
    ld [de], a
    pop de
    inc de
    ld a, [hl+]
    ldh [hFFC9], a
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ldh a, [hFFD0]
    and a, $03
    ld [de], a
    xor a, a
    inc de
    ld [de], a
    inc de
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    push hl
    push de
    call Func_004_431F
    pop de
    pop hl
    pop bc
    dec b
    jp nz, Jump_004_416D
    ld a, $7F
    ld [wC527], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $01023D, $90

; 1 call site from 1 routine (e.g. Func_004_4025)
; reads: hFF92, hFF8F, wCD0B
; writes: wCB8B, wCB8A, wCB86
Func_004_42CD::
    ldh a, [hFF92]
    or a, a
    ret nz
    ldh a, [hFF8F]
    or a, a
    jr nz, Jump_004_4309
    ld a, $20
    ld [wCB8B], a
    ld a, [wCD0B]
    cp a, $01
    jr nz, Jump_004_42ED
    ld a, $20
    ld [wCB8A], a
    ld a, $01
    ld [wCB86], a
    ret

Jump_004_42ED::
    cp a, $07
    jr nz, Jump_004_42FC
    ld a, $20
    ld [wCB8A], a
    ld a, $01
    ld [wCB86], a
    ret

Jump_004_42FC::
    cp a, $08
    ret nz
    ld a, $30
    ld [wCB8A], a
    xor a, a
    ld [wCB86], a
    ret

Jump_004_4309::
    ld a, [wCD0B]
    cp a, $09
    ret nz
    ld a, $70
    ld [wCB8A], a
    ld a, $10
    ld [wCB8B], a
    ld a, $03
    ld [wCB86], a
    ret

; 25 call sites from 15 routines (e.g. Func_004_4B2D, Func_004_4AA8, Func_004_4129, Func_00F_60E6, ...)
; reads: hFFC8, hFFC6, hFFC7, hFFCA, hFFCB, wIsCGB, hFFC9
; points at: wC4DF
Func_004_431F::
    ldh a, [hFFC8]
    or a, a
    jr nz, Jump_004_433C
    ld de, $4EAA
    push de
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    pop de
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    jr Jump_004_4354

Jump_004_433C::
    ld de, $43AC
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    add hl, hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $7D
    ldh a, [hFFC6]
    cp a, $50
    jr c, Jump_004_4354
    inc b

Jump_004_4354::
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    ret z
    ldh a, [hFFC8]
    or a, a
    jr nz, Jump_004_437E
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    jr Jump_004_4396

Jump_004_437E::
    ldh a, [hFFC6]
    ld de, $4A46
    add a, e
    ld e, a
    jr nc, Jump_004_4388
    inc d

Jump_004_4388::
    ld a, [de]
    add a, a
    add a, a
    add a, a
    ld de, $4B15
    add a, e
    ld e, a
    jr nc, Jump_004_4394
    inc d

Jump_004_4394::
    ld b, $7E

Jump_004_4396::
    ldh a, [hFFC9]
    sla a
    sla a
    sla a
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_004_43A6
    inc h

Jump_004_43A6::
    ld c, $08
    call CopyFromBank
    ret
    INCBIN "dwm2-cobi-us.gbc", $0103AC, $86
    dw $7594
    dw $764F
    dw Func_004_7705
    dw $77BF
    db $FC, $77, $75, $79, $D4, $7A, $8D, $7B, $D0, $7B, $84, $7C, $75, $7D, $2D, $7E
    db $07, $7F, $01, $40, $D7, $40, $B1, $41, $7C, $42, $53, $43, $C6, $44, $89, $45
    db $E3, $45, $99, $46, $D8, $46, $FF, $46, $34, $47, $73, $47, $32, $48, $5F, $48
    db $D6, $48, $BD, $49, $D7, $4A

; 11 call sites from 11 routines (e.g. Func_002_64E5, Func_010_49EE, Func_012_6610, Func_012_66DA, ...)
; reads: hFF8C, wCB8C, wCB9C, wCBAC, wCBBC, wCBCC
; writes: hFF8C, wCB8C, wCB9C, wCBAC, wCBBC, wCBCC
Func_004_4470::
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    ld a, [wCB8C]
    or a, $02
    ld [wCB8C], a
    ld a, [wCB9C]
    or a, $02
    ld [wCB9C], a
    ld a, [wCBAC]
    or a, $02
    ld [wCBAC], a
    ld a, [wCBBC]
    or a, $02
    ld [wCBBC], a
    ld a, [wCBCC]
    or a, $02
    ld [wCBCC], a
    ret

; 14 call sites from 14 routines (e.g. Func_002_6391, Func_007_6213, Func_00C_73C7, Func_00C_741F, ...)
; reads: hFF8C, wCB8C, wCB9C, wCBAC, wCBBC, wCBCC
; writes: hFF8C, wCB8C, wCB9C, wCBAC, wCBBC, wCBCC
Func_004_449F::
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld a, [wCB8C]
    and a, $FD
    ld [wCB8C], a
    ld a, [wCB9C]
    and a, $FD
    ld [wCB9C], a
    ld a, [wCBAC]
    and a, $FD
    ld [wCBAC], a
    ld a, [wCBBC]
    and a, $FD
    ld [wCBBC], a
    ld a, [wCBCC]
    and a, $FD
    ld [wCBCC], a
    ret

; 5 call sites from 5 routines (e.g. Func_004_4001, Func_014_6804, Func_024_567C, Func_0F1_5B8E, ...)
; reads: wC468, wCB7D, hFFA1, hFFA2, hFFA5, hFFA6, hFFB0, hFFC6
; writes: hFFC6, hFFB0, hFFAF, hFFA9, hFFAA, hFFAB, hFFAC, hFFAE, ...
; points at: wCB7F
Func_004_44CE::
    ld a, [wC468]
    bit 7, a
    ret nz
    ld a, [wCB7D]
    or a, a
    ret z
    call Func_004_456D
    ld a, [wCB7D]
    ld b, a
    ld hl, wCB7F

Jump_004_44E3::
    push hl
    inc hl
    ld a, [hl+]
    ldh [hFFC6], a
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    and a, $07
    ldh [hFFB0], a
    inc hl
    ld a, [hl+]
    ldh [hFFAF], a
    inc hl
    inc hl
    ld a, [hl+]
    add a, $08
    ld d, a
    ldh a, [hFFA1]
    add a, d
    ldh [hFFA9], a
    ldh a, [hFFA2]
    adc a, $00
    ldh [hFFAA], a
    ld a, [hl+]
    add a, $10
    ld d, a
    ldh a, [hFFA5]
    add a, d
    ldh [hFFAB], a
    ldh a, [hFFA6]
    adc a, $00
    ldh [hFFAC], a
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_004_4526
    push af
    ldh a, [hFFB0]
    or a, $20
    ldh [hFFB0], a
    pop af
    and a, $7F

Jump_004_4526::
    ldh [hFFAE], a
    pop hl
    push bc
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_004_4555
    ld a, [hl+]
    and a, $7F
    ldh [hFFAD], a
    ld a, [hl-]
    or a, a
    jr nz, Jump_004_454D
    ld a, [hl]
    bit 7, a
    jr nz, Jump_004_4545
    farcall Func_025_4001
    jr Jump_004_455F

Jump_004_4545::
    farcall Func_026_4001
    jr Jump_004_455F

Jump_004_454D::
    farcall Func_027_4001
    jr Jump_004_455F

Jump_004_4555::
    ld a, [hl+]
    inc hl
    ldh [hFFAD], a
    farcall Func_07F_4001

Jump_004_455F::
    pop bc
    pop hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_004_4568
    inc h

Jump_004_4568::
    dec b
    jp nz, Jump_004_44E3
    ret

; 1 call site from 1 routine (e.g. Func_004_44CE)
; reads: wCB7D
; points at: wCB7F
Func_004_456D::
    ld a, [wCB7D]
    ld b, a
    ld hl, wCB7F

Jump_004_4574::
    push bc
    push hl
    push hl
    ld a, [hl]
    rst $00
    dw Jump_004_4592
    dw Jump_004_4704
    dw Jump_004_4606
    dw Jump_004_4705
    dw Jump_004_4863
    dw Jump_004_486E

Jump_004_4585::
    pop hl
    pop bc
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_004_458E
    inc h

Jump_004_458E::
    dec b
    jr nz, Jump_004_4574
    ret

Jump_004_4592::
    pop hl
    ld a, $0D
    add a, l
    ld l, a
    jr nc, Jump_004_459A
    inc h

Jump_004_459A::
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr nz, Jump_004_45A6
    ld a, [hl]
    inc a
    ld [hl], a

Jump_004_45A6::
    ld a, [hl]

Jump_004_45A7::
    ld c, a
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 2, a
    jr z, Jump_004_45BD
    ld a, c
    srl a
    srl a
    srl a
    and a, $01
    ld c, a
    jr Jump_004_45C5

Jump_004_45BD::
    ld a, c
    swap a
    srl a
    and a, $01
    ld c, a

Jump_004_45C5::
    ld a, l
    sub a, $06
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    cp a, $03
    jr nz, Jump_004_45EC
    ld a, $82
    add a, c
    push af
    ld a, $07
    add a, l
    ld l, a
    jr nc, Jump_004_45DD
    inc h

Jump_004_45DD::
    pop af
    ld [hl], a
    pop hl
    pop bc
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_004_45E8
    inc h

Jump_004_45E8::
    dec b
    jr nz, Jump_004_4574
    ret

Jump_004_45EC::
    add a, a
    add a, c
    push af
    ld a, $07
    add a, l
    ld l, a
    jr nc, Jump_004_45F6
    inc h

Jump_004_45F6::
    pop af
    ld [hl], a
    pop hl
    pop bc
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_004_4601
    inc h

Jump_004_4601::
    dec b
    jp nz, Jump_004_4574
    ret

Jump_004_4606::
    pop hl
    push hl
    ld a, $0D
    add a, l
    ld l, a
    jr nc, Jump_004_460F
    inc h

Jump_004_460F::
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr z, Jump_004_461B
    inc hl
    jr Jump_004_461F

Jump_004_461B::
    ld a, [hl]
    inc a
    ld [hl+], a
    ld a, [hl]

Jump_004_461F::
    ld a, [hl]
    bit 7, a
    jr z, Jump_004_465C
    inc hl
    bit 6, a
    jr nz, Jump_004_4638
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $03
    jr Jump_004_4645

Jump_004_4638::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $01

Jump_004_4645::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $0F
    jp nz, Jump_004_46F8
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    jp Jump_004_46F8

Jump_004_465C::
    ld a, [wC91F]
    or a, a
    jp nz, Jump_004_46F8
    dec hl
    ld a, [hl]
    cp a, $70
    jp nz, Jump_004_46F8
    xor a, a
    ld [hl+], a
    call NextTableByte
    ld a, [wC5E7]
    and a, $03
    cp a, $03
    jr z, Jump_004_46B9
    and a, $01
    jr z, Jump_004_46F8
    push hl
    inc hl
    ld a, [hl]
    or a, a
    jr z, Jump_004_46F7
    ld a, l
    sub a, $07
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    ld c, a
    ld a, $07
    add a, l
    ld l, a
    jr nc, Jump_004_4693
    inc h

Jump_004_4693::
    ld a, [hl]
    sub a, c
    cp a, $E0
    jr z, Jump_004_46F7
    ld a, [hl+]
    sub a, $10
    ld b, a
    ld a, [hl]
    ld c, a
    call Func_004_4904
    cp a, $01
    jr z, Jump_004_46F7
    call Func_004_49B0
    or a, a
    jr nz, Jump_004_46F7
    pop hl
    ld [hl], $80
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_46F8

Jump_004_46B9::
    push hl
    inc hl
    ld a, [hl]
    cp a, $90
    jr z, Jump_004_46F7
    ld a, l
    sub a, $07
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl]
    ld c, a
    ld a, $07
    add a, l
    ld l, a
    jr nc, Jump_004_46D1
    inc h

Jump_004_46D1::
    ld a, [hl]
    sub a, c
    cp a, $20
    jr z, Jump_004_46F7
    ld a, [hl+]
    add a, $11
    ld b, a
    ld a, [hl]
    ld c, a
    call Func_004_4904
    cp a, $01
    jr z, Jump_004_46F7
    call Func_004_49B0
    or a, a
    jr nz, Jump_004_46F7
    pop hl
    ld [hl], $C0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_46F8

Jump_004_46F7::
    pop hl

Jump_004_46F8::
    pop hl
    ld a, $09
    add a, l
    ld l, a
    jr nc, Jump_004_4700
    inc h

Jump_004_4700::
    ld a, [hl]
    jp Jump_004_45A7

Jump_004_4704::
    ret

Jump_004_4705::
    pop hl
    push hl
    ld a, $0D
    add a, l
    ld l, a
    jr nc, Jump_004_470E
    inc h

Jump_004_470E::
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    bit 1, a
    jr z, Jump_004_471A
    inc hl
    jr Jump_004_471E

Jump_004_471A::
    ld a, [hl]
    inc a
    ld [hl+], a
    ld a, [hl]

Jump_004_471E::
    ld a, [hl]
    bit 7, a
    jr z, Jump_004_4784
    push hl
    inc hl
    swap a
    srl a
    and a, $03
    jr z, Jump_004_4761
    dec a
    jr z, Jump_004_4742
    dec a
    jr z, Jump_004_4751
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $03
    jr Jump_004_476F

Jump_004_4742::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub a, $04
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $01
    jr Jump_004_476F

Jump_004_4751::
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld a, l
    sub a, $05
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $02
    jr Jump_004_476F

Jump_004_4761::
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, l
    sub a, $05
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld [hl], $00

Jump_004_476F::
    pop hl
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $0F
    jp nz, Jump_004_4846
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    jp Jump_004_4846

Jump_004_4784::
    ld a, [wC91F]
    or a, a
    jp nz, Jump_004_4846
    dec hl
    ld a, [hl]
    cp a, $E0
    jp nz, Jump_004_4846
    xor a, a
    ld [hl+], a
    call NextTableByte
    ld a, [wC5E7]
    and a, $03
    jr z, Jump_004_481C
    dec a
    jr z, Jump_004_47CD
    dec a
    jr z, Jump_004_47F4
    push hl
    inc hl
    ld a, [hl]
    or a, a
    jp z, Jump_004_4845
    ld a, [hl+]
    sub a, $10
    ld b, a
    ld a, [hl]
    ld c, a
    call Func_004_4852
    cp a, $01
    jp z, Jump_004_4845
    call Func_004_49B0
    or a, a
    jp nz, Jump_004_4845
    pop hl
    ld [hl], $E0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_47CD::
    push hl
    inc hl
    ld a, [hl]
    cp a, $90
    jr z, Jump_004_4845
    ld a, [hl+]
    add a, $11
    ld b, a
    ld a, [hl]
    ld c, a
    call Func_004_4852
    cp a, $01
    jr z, Jump_004_4845
    call Func_004_49B0
    or a, a
    jr nz, Jump_004_4845
    pop hl
    ld [hl], $A0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_47F4::
    push hl
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr z, Jump_004_4845
    dec hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    sub a, $10
    ld c, a
    call Func_004_4852
    cp a, $01
    jr z, Jump_004_4845
    call Func_004_49B0
    or a, a
    jr nz, Jump_004_4845
    pop hl
    ld [hl], $C0
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_481C::
    push hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, $80
    jr z, Jump_004_4845
    dec hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    add a, $11
    ld c, a
    call Func_004_4852
    cp a, $01
    jr z, Jump_004_4845
    call Func_004_49B0
    or a, a
    jr nz, Jump_004_4845
    pop hl
    ld [hl], $80
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    jr Jump_004_4846

Jump_004_4845::
    pop hl

Jump_004_4846::
    pop hl
    ld a, $09
    add a, l
    ld l, a
    jr nc, Jump_004_484E
    inc h

Jump_004_484E::
    ld a, [hl]
    jp Jump_004_45A7

; 4 call sites from 1 routine (e.g. Func_004_456D)
; reads: wC935
Func_004_4852::
    ld a, [wC935]
    and a, $0F
    cp a, $0A
    jr z, Jump_004_485F
    call Func_004_4904
    ret

Jump_004_485F::
    call Func_004_495A
    ret

Jump_004_4863::
    ld hl, $48D6
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    jr Jump_004_4877

Jump_004_486E::
    ld hl, $48FA
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a

Jump_004_4877::
    pop hl
    ld a, $0D
    add a, l
    ld l, a
    jr nc, Jump_004_487F
    inc h

Jump_004_487F::
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    dec hl
    push hl
    bit 1, a
    jr nz, Jump_004_48BD
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    inc hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    inc de
    ld a, [hl]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_004_489D
    inc d

Jump_004_489D::
    ld a, [de]
    cp a, c
    jr nz, Jump_004_48BD
    dec hl
    ld [hl], $00
    inc hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    inc de
    ld a, [hl]
    inc a
    ld [hl], a
    sla a
    add a, e
    ld e, a
    jr nc, Jump_004_48B6
    inc d

Jump_004_48B6::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_004_48BD
    ld [hl], $00

Jump_004_48BD::
    pop hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    inc hl
    ld a, [hl]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_004_48CD
    inc d

Jump_004_48CD::
    ld a, [de]
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], a
    jp Jump_004_4585
    db $00, $0E, $03, $0A, $04, $0E, $05, $0A, $00, $0E, $03, $0A, $04, $0E, $05, $0A
    db $00, $10, $01, $0E, $02, $0E, $01, $0E, $02, $0E, $00, $20, $06, $0E, $07, $20
    db $06, $0E, $FF, $FF, $00, $0E, $01, $0E, $02, $0E, $01, $0E, $FF, $FF

; 3 call sites from 2 routines (e.g. Func_004_4852, Func_004_456D)
; reads: wC192
; points at: wC198, wC910
Func_004_4904::
    push bc
    push de
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
    jr nc, Jump_004_4917
    inc h

Jump_004_4917::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_004_4925
    inc h

Jump_004_4925::
    ld de, wC198
    add hl, de
    ld de, wC910
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add a, l
    ld l, a
    jr nc, Jump_004_4939
    inc h

Jump_004_4939::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

Jump_004_4943::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wC192]
    cp a, c
    jr c, Jump_004_494E
    jr Jump_004_4955

Jump_004_494E::
    dec b
    jr nz, Jump_004_4943
    xor a, a
    pop de
    pop bc
    ret

Jump_004_4955::
    ld a, $01
    pop de
    pop bc
    ret

; 1 call site from 1 routine (e.g. Func_004_4852)
; reads: wC196
; points at: wC198, wC910
Func_004_495A::
    push bc
    push de
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
    jr nc, Jump_004_496D
    inc h

Jump_004_496D::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_004_497B
    inc h

Jump_004_497B::
    ld de, wC198
    add hl, de
    ld de, wC910
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add a, l
    ld l, a
    jr nc, Jump_004_498F
    inc h

Jump_004_498F::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

Jump_004_4999::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wC196]
    cp a, c
    jr c, Jump_004_49A4
    jr Jump_004_49AC

Jump_004_49A4::
    dec b
    jr nz, Jump_004_4999
    ld a, $01
    pop de
    pop bc
    ret

Jump_004_49AC::
    xor a, a
    pop de
    pop bc
    ret

; 6 call sites from 1 routine (e.g. Func_004_456D)
; reads: hFF8E, hFFC7, hFF91, hFFC6, wC6FD
; writes: hFFC6, hFFC7
; points at: wC8F0
Func_004_49B0::
    push bc
    ld a, c
    swap a
    and a, $0F
    ldh [hFFC6], a
    ld a, b
    swap a
    and a, $0F
    ldh [hFFC7], a
    ldh a, [hFF8E]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr z, Jump_004_49D9
    ldh a, [hFF8E]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_004_49F7

Jump_004_49D9::
    ldh a, [hFF91]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr z, Jump_004_49F3
    ldh a, [hFF91]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr nz, Jump_004_49F7

Jump_004_49F3::
    ld a, $01
    pop bc
    ret

Jump_004_49F7::
    ld a, [wC6FD]
    or a, a
    jr z, Jump_004_4A43
    ld b, a
    ld hl, wC8F0

Jump_004_4A01::
    push hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr z, Jump_004_4A1A
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_004_4A38

Jump_004_4A1A::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr z, Jump_004_4A33
    ld a, [hl]
    add a, $0F
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr nz, Jump_004_4A38

Jump_004_4A33::
    pop hl
    ld a, $01
    pop bc
    ret

Jump_004_4A38::
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_004_4A40
    inc h

Jump_004_4A40::
    dec b
    jr nz, Jump_004_4A01

Jump_004_4A43::
    xor a, a
    pop bc
    ret
    INCBIN "dwm2-cobi-us.gbc", $010A46, $62

; 32 call sites from 29 routines (e.g. Func_002_4628, Func_002_4745, Func_002_4A53, Func_00C_433D, ...)
; reads: hFF8C, hFF8B
; writes: hFF8B, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB
Func_004_4AA8::
    ld a, $00
    ldh [hFF8B], a
    ld de, $019F
    call TestFlagBit
    jr nc, Jump_004_4ABC
    ld de, $0025
    call TestFlagBit
    jr nc, Jump_004_4AC4

Jump_004_4ABC::
    ld de, $0002
    call TestFlagBit
    jr c, Jump_004_4AC8

Jump_004_4AC4::
    ld a, $01
    ldh [hFF8B], a

Jump_004_4AC8::
    ldh a, [hFF8C]
    bit 3, a
    jr z, Jump_004_4AD2
    ld a, $02
    ldh [hFF8B], a

Jump_004_4AD2::
    ldh a, [hFF8B]
    or a, a
    jr nz, Jump_004_4ADE
    call Func_004_4B2D
    call Func_000_228A
    ret

Jump_004_4ADE::
    dec a
    jr nz, Jump_004_4B23
    call Func_004_4B2D
    ld de, $0000
    call TestFlagBit
    jr c, Jump_004_4AF0
    ld a, $01
    jr Jump_004_4AF1

Jump_004_4AF0::
    xor a, a

Jump_004_4AF1::
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    inc a
    ldh [hFFC8], a
    ldh [hFFC9], a
    ld hl, vTiles0 + $100
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    call Func_004_431F
    ld a, $04
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC8], a
    ld a, $02
    ldh [hFFC9], a
    ld hl, vTiles0 + $200
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    call Func_004_431F
    ret

Jump_004_4B23::
    call Func_004_4B2D
    call Func_000_228A
    call Func_004_4B7E
    ret

; 5 call sites from 3 routines (e.g. Func_004_4AA8, Func_012_5007, Func_012_50B3)
; reads: hFF93, hFF94, hFF95
; writes: hFFC6, hFF8A, hFFC7, hFFC9, hFFC8, hFFCA, hFFCB
Func_004_4B2D::
    ldh a, [hFF93]
    bit 7, a
    jr nz, Jump_004_4B5E
    ld de, $0000
    call TestFlagBit
    jr c, Jump_004_4B42
    xor a, a
    ldh [hFFC6], a
    ldh [hFF8A], a
    jr Jump_004_4B48

Jump_004_4B42::
    ld a, $01
    ldh [hFFC6], a
    ldh [hFF8A], a

Jump_004_4B48::
    xor a, a
    ldh [hFFC7], a
    ldh [hFFC9], a
    ld a, $01
    ldh [hFFC8], a
    ld hl, vTiles0
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    call Func_004_431F
    ret

Jump_004_4B5E::
    and a, $01
    ldh [hFFC8], a
    ldh a, [hFF94]
    ld l, a
    ldh a, [hFF95]
    ld h, a
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC9], a
    ld hl, vTiles0
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    call Func_004_431F
    ret

; 1 call site from 1 routine (e.g. Func_004_4AA8)
; reads: hFF8C
; writes: wC527
; points at: wC4DF
Func_004_4B7E::
    ldh a, [hFF8C]
    bit 3, a
    ret z
    ld de, $58FF
    ld b, $7E
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $4BBD
    ld a, e
    add a, $08
    ld e, a
    ld a, d
    adc a, $01
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_004_4BA5
    inc h

Jump_004_4BA5::
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a
    ret

; 2 call sites from 2 routines (e.g. Func_004_4001, Func_002_4AE0)
; reads: hFF8C, hFF99, hFF8B
; writes: hFF99
; points at: hFF99
Func_004_4BB0::
    ldh a, [hFF8C]
    bit 1, a
    jr nz, Jump_004_4BC6
    ld hl, hFF99
    inc [hl]
    ldh a, [hFF8C]
    bit 2, a
    jr z, Jump_004_4BC6
    ldh a, [hFF99]
    add a, $03
    ldh [hFF99], a

Jump_004_4BC6::
    ldh a, [hFF8B]
    rst $00
    dw Jump_004_4BCF
    dw Jump_004_4BD6
    dw Jump_004_4BDD

Jump_004_4BCF::
    call Func_004_4C96
    call Func_004_4D43
    ret

Jump_004_4BD6::
    call Func_004_4C96
    call Func_004_4C25
    ret

Jump_004_4BDD::
    call Func_004_4C96
    call Func_004_4BE4
    ret

; 1 call site from 1 routine (e.g. Func_004_4BB0)
; reads: hFFAB, hFFAC, hFFB0, hFF8C
; writes: hFFAB, hFFAC, hFFAF, hFFB0, hFFAD, hFFAE
Func_004_4BE4::
    ldh a, [hFFAB]
    ld l, a
    ldh a, [hFFAC]
    ld h, a
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_004_4BF1
    inc h

Jump_004_4BF1::
    ld a, l
    ldh [hFFAB], a
    ld a, h
    ldh [hFFAC], a
    ld a, $70
    ldh [hFFAF], a
    ldh a, [hFFB0]
    and a, $F8
    or a, $07
    ldh [hFFB0], a
    ldh a, [hFF8C]
    bit 3, a
    jr z, Jump_004_4C17
    ld a, $21
    ldh [hFFAD], a
    xor a, a
    ldh [hFFAE], a
    farcall Func_07F_700A
    ret

Jump_004_4C17::
    ld a, $22
    ldh [hFFAD], a
    xor a, a
    ldh [hFFAE], a
    farcall Func_07F_700A
    ret

; 1 call site from 1 routine (e.g. Func_004_4BB0)
; reads: hFF8D, hFF8A, wC8F0, wC8F1, hFF99, hFFA1, hFFA2, hFFA5, ...
; writes: hFFAD, hFFB0, hFFAE, hFFAF, hFFA9, hFFAA, hFFAB, hFFAC
Func_004_4C25::
    ldh a, [hFF8D]
    bit 1, a
    ret nz
    ld de, $001B
    call TestFlagBit
    ret nc
    ldh a, [hFF8A]
    inc a
    and a, $01
    ldh [hFFAD], a
    ld a, $01
    ldh [hFFB0], a
    ld a, [wC8F0]
    ld b, a
    ld a, [wC8F1]
    ld c, a
    call Func_004_4E0F
    or a, a
    jr z, Jump_004_4C4E
    ld a, $02
    jr Jump_004_4C5B

Jump_004_4C4E::
    ld a, [wC8EF]
    cp a, $03
    jr nz, Jump_004_4C5B
    ld a, $21
    ldh [hFFB0], a
    ld a, $01

Jump_004_4C5B::
    sla a
    ld c, a
    ldh a, [hFF99]
    swap a
    srl a
    and a, $01
    add a, c
    ldh [hFFAE], a
    ld a, $10
    ldh [hFFAF], a
    ld a, [wC8F0]
    add a, $08
    ld l, a
    ldh a, [hFFA1]
    add a, l
    ldh [hFFA9], a
    ldh a, [hFFA2]
    adc a, $00
    ldh [hFFAA], a
    ld a, [wC8F1]
    add a, $10
    ld l, a
    ldh a, [hFFA5]
    add a, l
    ldh [hFFAB], a
    ldh a, [hFFA6]
    adc a, $00
    ldh [hFFAC], a
    farcall Func_07F_4001
    ret

; 3 call sites from 1 routine (e.g. Func_004_4BB0)
; reads: hFF8D, hFF8A, hFF8E, hFF91, hFF99, hFFA1, hFFA2, hFFA5, ...
; writes: hFFAD, hFFB0, hFFAE, hFFAF, hFFA9, hFFAA, hFFAB, hFFAC
Func_004_4C96::
    ldh a, [hFF8D]
    bit 0, a
    ret nz
    ldh a, [hFF8A]
    ldh [hFFAD], a
    ld a, $00
    ldh [hFFB0], a
    ldh a, [hFF8E]
    ld b, a
    ldh a, [hFF91]
    ld c, a
    call Func_004_4E0F
    or a, a
    jr z, Jump_004_4CB3
    ld a, $02
    jr Jump_004_4CBF

Jump_004_4CB3::
    ldh a, [hFF98]
    cp a, $03
    jr nz, Jump_004_4CBF
    ld a, $20
    ldh [hFFB0], a
    ld a, $01

Jump_004_4CBF::
    add a, a
    ld c, a
    ldh a, [hFF99]
    swap a
    srl a
    and a, $01
    add a, c
    ldh [hFFAE], a
    ld a, $00
    ldh [hFFAF], a
    ldh a, [hFF8E]
    add a, $08
    ld l, a
    ldh a, [hFFA1]
    add a, l
    ldh [hFFA9], a
    ldh a, [hFFA2]
    adc a, $00
    ldh [hFFAA], a
    ldh a, [hFF91]
    add a, $10
    ld l, a
    ldh a, [hFFA5]
    add a, l
    ldh [hFFAB], a
    ld l, a
    ldh a, [hFFA6]
    adc a, $00
    ldh [hFFAC], a
    ld h, a
    ldh a, [hFF8B]
    cp a, $02
    jr nz, Jump_004_4D06
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ldh [hFFAB], a
    ld a, h
    ldh [hFFAC], a

Jump_004_4D06::
    ldh a, [hFF93]
    bit 7, a
    jr nz, Jump_004_4D13

Jump_004_4D0C::
    farcall Func_07F_4001
    ret

Jump_004_4D13::
    and a, $01
    jr z, Jump_004_4D1D
    ldh a, [hFF94]
    ldh [hFFAD], a
    jr Jump_004_4D0C

Jump_004_4D1D::
    ldh a, [hFF94]
    and a, $7F
    ldh [hFFAD], a
    ldh a, [hFF95]
    or a, a
    jr nz, Jump_004_4D3C
    ldh a, [hFF94]
    bit 7, a
    jr nz, Jump_004_4D35
    farcall Func_025_4001
    ret

Jump_004_4D35::
    farcall Func_026_4001
    ret

Jump_004_4D3C::
    farcall Func_027_4001
    ret

; 1 call site from 1 routine (e.g. Func_004_4BB0)
; reads: wC6FD, hFFCF, hFF8D, hFF99, hFFC6, hFFA1, hFFA2, hFFA5, ...
; writes: hFFCF, hFFC6, hFFB0, hFFAE, hFFAF, hFFA9, hFFAA, hFFAB, ...
; points at: wC8EF, wC701
Func_004_4D43::
    ld a, $02
    ldh [hFFCF], a
    ld a, [wC6FD]
    or a, a
    ret z
    ld b, a
    ld hl, wC8EF
    ld de, wC701
    ld a, $10
    ldh [hFFC6], a

Jump_004_4D57::
    push bc
    push de
    push hl
    ldh a, [hFFCF]
    ld c, a
    ldh a, [hFF8D]
    and a, c
    jp nz, Jump_004_4DF3
    ld a, $03
    sub a, b
    inc a
    ldh [hFFB0], a
    push bc
    inc hl
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    ld c, a
    dec hl
    call Func_004_4E0F
    pop bc
    or a, a
    jr z, Jump_004_4D7C
    ld a, $02
    inc hl
    jr Jump_004_4D89

Jump_004_4D7C::
    ld a, [hl+]
    cp a, $03
    jr nz, Jump_004_4D89
    ldh a, [hFFB0]
    or a, $20
    ldh [hFFB0], a
    ld a, $01

Jump_004_4D89::
    add a, a
    ld c, a
    ldh a, [hFF99]
    swap a
    srl a
    and a, $01
    add a, c
    ldh [hFFAE], a
    ldh a, [hFFC6]
    ldh [hFFAF], a
    ld a, [hl+]
    add a, $08
    ld c, a
    ldh a, [hFFA1]
    add a, c
    ldh [hFFA9], a
    ldh a, [hFFA2]
    adc a, $00
    ldh [hFFAA], a
    ld a, [hl+]
    add a, $10
    ld c, a
    ldh a, [hFFA5]
    add a, c
    ldh [hFFAB], a
    ldh a, [hFFA6]
    adc a, $00
    ldh [hFFAC], a
    inc de
    ld a, [de]
    dec de
    cp a, $FF
    jr nz, Jump_004_4DCB
    ld a, $19
    ldh [hFFAD], a
    farcall Func_07F_700A
    jr Jump_004_4DF3

Jump_004_4DCB::
    ld a, [de]
    and a, $7F
    ldh [hFFAD], a
    inc de
    ld a, [de]
    or a, a
    jr nz, Jump_004_4DED
    dec de
    ld a, [de]
    bit 7, a
    jr nz, Jump_004_4DE4
    farcall Func_025_4001
    jp Jump_004_4DF3

Jump_004_4DE4::
    farcall Func_026_4001
    jp Jump_004_4DF3

Jump_004_4DED::
    farcall Func_027_4001

Jump_004_4DF3::
    ldh a, [hFFC6]
    add a, $10
    ldh [hFFC6], a
    ldh a, [hFFCF]
    rlca
    ldh [hFFCF], a
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_004_4E06
    inc h

Jump_004_4E06::
    pop de
    inc de
    inc de
    pop bc
    dec b
    jp nz, Jump_004_4D57
    ret

; 3 call sites from 3 routines (e.g. Func_004_4C96, Func_004_4C25, Func_004_4D43)
; reads: wC56C, hFF90, hFF8F, hFF92, hFF91
Func_004_4E0F::
    ld a, [wC56C]
    or a, a
    jr z, Jump_004_4E30
    ldh a, [hFF90]
    cp a, $5A
    jr nz, Jump_004_4E2E
    ldh a, [hFF8F]
    or a, a
    jr nz, Jump_004_4E2E
    ldh a, [hFF92]
    or a, a
    jr nz, Jump_004_4E2E
    ldh a, [hFF91]
    cp a, $80
    jr nz, Jump_004_4E2E
    ld a, $01
    ret

Jump_004_4E2E::
    xor a, a
    ret

Jump_004_4E30::
    push hl
    push de
    ld hl, $4E73

Jump_004_4E35::
    push hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_004_4E40
    pop hl
    pop de
    pop hl
    xor a, a
    ret

Jump_004_4E40::
    ldh a, [hFF90]
    ld e, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_004_4E69
    ldh a, [hFF8F]
    ld e, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_004_4E69
    ldh a, [hFF92]
    ld e, a
    ld a, [hl+]
    cp a, e
    jr nz, Jump_004_4E69
    ld a, [hl+]
    cp a, b
    jr nz, Jump_004_4E69
    ld a, [hl+]
    cp a, c
    jr z, Jump_004_4E5F
    jr nc, Jump_004_4E69

Jump_004_4E5F::
    ld a, [hl]
    cp a, c
    jr c, Jump_004_4E69
    pop hl
    pop de
    pop hl
    ld a, $01
    ret

Jump_004_4E69::
    pop hl
    ld a, $06
    add a, l
    ld l, a
    jr nc, Jump_004_4E71
    inc h

Jump_004_4E71::
    jr Jump_004_4E35
    db $05, $02, $00, $50, $00, $28, $2B, $03, $03, $20, $00, $18, $5A, $00, $00, $40
    db $10, $48, $5A, $00, $00, $70, $30, $48, $5C, $00, $01, $30, $78, $90, $7A, $00
    db $00, $40, $58, $80, $7A, $00, $01, $40, $00, $28, $7A, $00, $01, $50, $10, $28
    db $7A, $00, $01, $30, $38, $48, $FF

Data_004_4EAA:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $010EAA, $711

; HL is stored in wC921 (low) and wC922 (high); then wC5DC = 1, wC920 = 9, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 to wC919 is overwritten)
; 316 call sites from 44 routines (e.g. Func_004_7BAB, Func_004_6A35, Func_004_5D14, Func_004_58C2, ...)
; writes: wC921, wC922, wC919, wC5DC, wC920, wC91F, wC923
SetRequestPtrC921_B04::
Func_004_55BB:: ; address name
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wC5DC], a
    ld a, $09
    ld [wC920], a
    ld a, $01
    ld [wC91F], a
    xor a, a
    ld [wC919], a
    ld [wC923], a
    ret

; DE is stored in wC924 (low) and wC925 (high); then wC5DC = 1, wC920 = $0A, wC91F = 1, wC923 = 0 and wC919 = 0 (an earlier store of $80 is overwritten)
; 99 call sites from 58 routines (e.g. Func_004_6A35, Func_004_5D14, Func_004_58C2, Func_004_612B, ...)
; writes: wC924, wC925, wC919, wC5DC, wC920, wC91F, wC923
SetRequestPtrC924FromDE_B04::
Func_004_55DF:: ; address name
    ld a, e
    ld [wC924], a
    ld a, d
    ld [wC925], a
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wC5DC], a
    ld a, $0A
    ld [wC920], a
    ld a, $01
    ld [wC91F], a
    xor a, a
    ld [wC919], a
    ld [wC923], a
    ret

; HL is stored in wC91A (low) and wC91B (high); then wC919 = $80 and wC5DC = 1
; 177 call sites from 32 routines (e.g. Func_004_5616, Func_004_7BAB, Func_004_7B29, Func_004_6A35, ...)
; writes: wC91A, wC91B, wC919, wC5DC
SetRequestPtrC91A_B04::
Func_004_5603:: ; address name
    ld a, l
    ld [wC91A], a
    ld a, h
    ld [wC91B], a
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wC5DC], a
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC916
Func_004_5616::
    ld a, [wC916]
    rst $00
    dw Jump_004_5660
    dw Jump_004_5676
    dw Jump_004_567D
    db $00, $00
    dw Func_004_568B
    dw Func_004_5698
    dw Func_004_56AF
    dw Func_004_56BD
    dw Data_004_5731
    dw Data_004_5738
    dw Data_004_573F
    dw Data_004_57A4
    dw Data_004_57AB
    dw Data_004_57B2
    dw Data_004_57B9
    dw Data_004_57C0
    dw Data_004_57C7
    dw Data_004_57CE
    dw Data_004_57D5
    dw Data_004_57DC
    dw Data_004_57E3
    dw Data_004_57EA
    dw Data_004_57F1
    dw Data_004_57F8
    dw Data_004_580E
    dw Data_004_5815
    dw Func_004_581C
    dw Func_004_5852
    dw Func_004_5860
    dw Func_004_586E
    dw Func_004_587C
    dw Func_004_588A
    dw Func_004_5898
    dw Func_004_58A6
    dw Func_004_58B4

Jump_004_5660::
    ld de, $0001
    call TestFlagBit
    jr nc, Jump_004_566F
    ld hl, $5063
    call SetRequestPtrC91A_B04
    ret

Jump_004_566F::
    ld hl, $509F
    call SetRequestPtrC91A_B04
    ret

Jump_004_5676::
    ld hl, $4F54
    call SetRequestPtrC91A_B04
    ret

Jump_004_567D::
    ld hl, $5111
    call SetRequestPtrC91A_B04
    ret
    db $21, $44, $00, $CD, $BB, $55, $C9

; no direct call (reached through a table, a jump or a vector)
Func_004_568B:: ; heuristic: target of a pointer table; C0
    ld hl, $4F73
    call SetRequestPtrC91A_B04
    ld de, $0005
    call SetFlagBit
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
Func_004_5698:: ; heuristic: target of a pointer table; C0
    ld hl, $4F7C
    call SetRequestPtrC91A_B04
    ld a, $00
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld de, $0006
    call SetFlagBit
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_56AF:: ; heuristic: target of a pointer table; C0
    ld de, $000A
    call TestFlagBit
    ret nc
    ld hl, $4F9D
    call SetRequestPtrC91A_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wDataBank
Func_004_56BD:: ; heuristic: target of a pointer table; C0
    ld de, $0025
    call TestFlagBit
    jr c, Jump_004_571D
    ld de, $0002
    call TestFlagBit
    jr c, Jump_004_5702
    ld de, $000C
    call TestFlagBit
    jr c, Jump_004_56FB
    ld de, $0007
    call TestFlagBit
    jr c, Jump_004_56F4
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld hl, $4F88
    call SetRequestPtrC91A_B04
    ld de, $0007
    call SetFlagBit
    ret

Jump_004_56F4::
    ld hl, $0046
    call SetRequestPtrC921_B04
    ret

Jump_004_56FB::
    ld hl, $0079
    call SetRequestPtrC921_B04
    ret

Jump_004_5702::
    ld a, $10
    ld [wDataBank], a
    ld de, $0103
    call TestFlagBit
    jr c, Jump_004_5716
    ld hl, Data_010_5353
    call SetRequestPtrC91A_B04
    ret

Jump_004_5716::
    ld hl, $535D
    call SetRequestPtrC91A_B04
    ret

Jump_004_571D::
    ld a, $10
    ld [wDataBank], a
    ld de, $0127
    call TestFlagBit
    jr c, Jump_004_5716
    ld hl, Data_010_5364
    call SetRequestPtrC91A_B04
    ret

Data_004_5731:: ; heuristic: target of a monotone pointer table; C0
    db $21, $47, $00, $CD, $BB, $55, $C9

Data_004_5738:: ; heuristic: target of a monotone pointer table; C0
    db $21, $41, $54, $CD, $03, $56, $C9

Data_004_573F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $01173F, $65

Data_004_57A4:: ; heuristic: target of a monotone pointer table; C0
    db $21, $33, $02, $CD, $BB, $55, $C9

Data_004_57AB:: ; heuristic: target of a monotone pointer table; C0
    db $21, $34, $02, $CD, $BB, $55, $C9

Data_004_57B2:: ; heuristic: target of a monotone pointer table; C0
    db $21, $35, $02, $CD, $BB, $55, $C9

Data_004_57B9:: ; heuristic: target of a monotone pointer table; C0
    db $21, $36, $02, $CD, $BB, $55, $C9

Data_004_57C0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $37, $02, $CD, $BB, $55, $C9

Data_004_57C7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $38, $02, $CD, $BB, $55, $C9

Data_004_57CE:: ; heuristic: target of a monotone pointer table; C0
    db $21, $39, $02, $CD, $BB, $55, $C9

Data_004_57D5:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3A, $02, $CD, $BB, $55, $C9

Data_004_57DC:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3B, $02, $CD, $BB, $55, $C9

Data_004_57E3:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3C, $02, $CD, $BB, $55, $C9

Data_004_57EA:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3D, $02, $CD, $BB, $55, $C9

Data_004_57F1:: ; heuristic: target of a monotone pointer table; C0
    db $21, $3E, $02, $CD, $BB, $55, $C9

Data_004_57F8:: ; heuristic: target of a monotone pointer table; C0
    db $11, $25, $00, $CD, $1B, $18, $38, $07, $11, $24, $00, $CD, $1B, $18, $D8, $21
    db $42, $00, $CD, $BB, $55, $C9

Data_004_580E:: ; heuristic: target of a monotone pointer table; C0
    db $21, $10, $00, $CD, $BB, $55, $C9

Data_004_5815:: ; heuristic: target of a monotone pointer table; C0
    db $21, $0F, $00, $CD, $BB, $55, $C9

; no direct call (reached through a table, a jump or a vector)
; reads: wC836
; writes: hFFC7, wC836
Func_004_581C:: ; heuristic: target of a pointer table; C0
    ld de, $001A
    call TestFlagBit
    ret nc
    farcall Func_012_6990
    ld a, $01
    ldh [hFFC7], a
    farcall Func_012_6955
    farcall Func_012_6990
    ld a, $02
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld hl, $5039
    call SetRequestPtrC91A_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_5852:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D33
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_5860:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D34
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_586E:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D35
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_587C:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D36
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_588A:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D37
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_5898:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D38
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_58A6:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D39
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_58B4:: ; heuristic: target of a pointer table; C0
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld hl, $0D3A
    call SetRequestPtrC921_B04
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC916
Func_004_58C2::
    ld a, [wC916]
    rst $00
    dw Jump_004_59A2
    dw Jump_004_59A9
    dw Jump_004_59B0
    dw Jump_004_59B7
    dw Jump_004_59CD
    dw Jump_004_59E3
    dw Jump_004_59F9
    dw Jump_004_5A24
    dw Jump_004_5A35
    dw Jump_004_5A3C
    dw Jump_004_5A43
    dw Jump_004_5A54
    dw Jump_004_5A65
    dw Jump_004_5A6C
    dw Jump_004_5A73
    dw Jump_004_5A7A
    dw Jump_004_5A81
    dw Jump_004_5A97
    dw Jump_004_5A9E
    dw Jump_004_5AA5
    dw Jump_004_5B1D
    dw Jump_004_5B29
    dw Jump_004_5B30
    dw Jump_004_5B37
    dw Jump_004_5B4D
    dw Jump_004_5B54
    dw Jump_004_5B5B
    dw Jump_004_5B62
    dw Jump_004_5B78
    dw Jump_004_5B7F
    dw Jump_004_5B8B
    dw Jump_004_5B92
    dw Jump_004_5B99
    dw Jump_004_5BAA
    dw Jump_004_5BC0
    dw Jump_004_5BC7
    dw Jump_004_5BCE
    dw Jump_004_5BE4
    dw Jump_004_5BFA
    dw Jump_004_5C10
    dw Jump_004_5C17
    dw Jump_004_5C1E
    dw Jump_004_5C25
    dw Jump_004_5C2C
    dw Jump_004_5C3D
    dw Jump_004_5C49
    dw Jump_004_5C5F
    dw Jump_004_5C66
    dw Jump_004_5C6D
    dw Jump_004_5C92
    dw Jump_004_5CB7
    dw Jump_004_5CBE
    dw Jump_004_5D44
    dw Jump_004_5D6F
    dw Jump_004_5D80
    dw Jump_004_5D91
    dw Jump_004_5DA2
    dw Jump_004_5DB3
    dw Jump_004_5DC4
    dw Jump_004_5DD5
    dw Jump_004_5DDC
    dw Jump_004_5DE3
    dw Jump_004_5DF1
    dw Jump_004_5E0D
    dw Jump_004_5E23
    dw Jump_004_5E39
    dw Jump_004_5E40
    dw Jump_004_5E47
    dw Jump_004_5E5D
    dw Jump_004_5E73
    dw Jump_004_5EBD
    dw Jump_004_5EC4
    dw Jump_004_5ECB
    dw Jump_004_5ED2
    dw Jump_004_5ED9
    dw Jump_004_5EF5
    dw Jump_004_5F12
    dw Jump_004_5F1F
    dw Jump_004_5F24
    dw Jump_004_5F35
    dw Jump_004_5F5A
    dw Jump_004_5F7C
    dw Jump_004_5F83
    dw Jump_004_5F8A
    dw Jump_004_5F91
    dw Jump_004_5FA2
    dw Jump_004_5FB3
    dw Jump_004_5FC4
    dw Jump_004_5FD5
    dw Jump_004_5FE6
    dw Jump_004_5FED
    dw Jump_004_5FFE
    dw Jump_004_600F
    dw Jump_004_6020
    dw Jump_004_6031
    dw Jump_004_6042
    dw Jump_004_6049
    dw Jump_004_605A
    dw Jump_004_606B
    dw Jump_004_607C
    dw Jump_004_608D
    dw Jump_004_609E
    dw Jump_004_60AF
    dw Jump_004_60C0
    dw Jump_004_60D1
    dw Jump_004_60D8
    dw Jump_004_60DF
    dw Jump_004_60FC
    dw Jump_004_6103
    dw Jump_004_610A

Jump_004_59A2::
    ld hl, $0800
    call SetRequestPtrC921_B04
    ret

Jump_004_59A9::
    ld hl, $0801
    call SetRequestPtrC921_B04
    ret

Jump_004_59B0::
    ld hl, $0802
    call SetRequestPtrC921_B04
    ret

Jump_004_59B7::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59C6
    ld hl, $0803
    call SetRequestPtrC921_B04
    ret

Jump_004_59C6::
    ld hl, $0874
    call SetRequestPtrC921_B04
    ret

Jump_004_59CD::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59DC
    ld hl, $0804
    call SetRequestPtrC921_B04
    ret

Jump_004_59DC::
    ld hl, $0875
    call SetRequestPtrC921_B04
    ret

Jump_004_59E3::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_59F2
    ld hl, $0805
    call SetRequestPtrC921_B04
    ret

Jump_004_59F2::
    ld hl, $0876
    call SetRequestPtrC921_B04
    ret

Jump_004_59F9::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5A1D
    ld de, $0060
    call TestFlagBit
    jr c, Jump_004_5A16
    ld hl, $5B84
    call SetRequestPtrC91A_B04
    ld de, $0060
    call SetFlagBit
    ret

Jump_004_5A16::
    ld hl, $0808
    call SetRequestPtrC921_B04
    ret

Jump_004_5A1D::
    ld hl, $0877
    call SetRequestPtrC921_B04
    ret

Jump_004_5A24::
    ld a, $04
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5B8C
    call SetRequestPtrC91A_B04
    ret

Jump_004_5A35::
    ld hl, $080A
    call SetRequestPtrC921_B04
    ret

Jump_004_5A3C::
    ld hl, $080B
    call SetRequestPtrC921_B04
    ret

Jump_004_5A43::
    ld a, $02
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $0061
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5A54::
    ld a, $02
    ld [wC921], a
    ld a, $28
    ld [wC922], a
    ld de, $0062
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5A65::
    ld hl, $088A
    call SetRequestPtrC921_B04
    ret

Jump_004_5A6C::
    ld hl, $0889
    call SetRequestPtrC921_B04
    ret

Jump_004_5A73::
    ld hl, $0037
    call SetRequestPtrC921_B04
    ret

Jump_004_5A7A::
    ld hl, $080C
    call SetRequestPtrC921_B04
    ret

Jump_004_5A81::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5A90
    ld hl, $080D
    call SetRequestPtrC921_B04
    ret

Jump_004_5A90::
    ld hl, $0878
    call SetRequestPtrC921_B04
    ret

Jump_004_5A97::
    ld hl, $080E
    call SetRequestPtrC921_B04
    ret

Jump_004_5A9E::
    ld hl, $080F
    call SetRequestPtrC921_B04
    ret

Jump_004_5AA5::
    ld de, $006F
    call TestFlagBit
    jr c, Jump_004_5B16
    farcall Func_012_7E0F
    ldh a, [hFFC7]
    bit 7, a
    jr z, Jump_004_5AC0
    ld hl, $5C2F
    call SetRequestPtrC91A_B04
    ret

Jump_004_5AC0::
    farcall Func_05F_6CA9
    ld a, [wC92C]
    or a, a
    jr z, Jump_004_5AD3
    ld hl, $5C5C
    call SetRequestPtrC91A_B04
    ret

Jump_004_5AD3::
    ld a, $0A
    ld [rRAMG], a
    ldh a, [hFFC7]
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_004_5AE2
    inc h

Jump_004_5AE2::
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    xor a, a
    ld [rRAMG], a
    ld hl, wC8CF
    ld de, wC147
    ld bc, $000B
    call CopyBytes
    ldh a, [hFFC8]
    ld de, wC152
    call Func_000_241A
    ld de, $006D
    call TestFlagBit
    jr c, Jump_004_5B0F
    ld hl, $5C40
    call SetRequestPtrC91A_B04
    ret

Jump_004_5B0F::
    ld hl, $5C4E
    call SetRequestPtrC91A_B04
    ret

Jump_004_5B16::
    ld hl, $084A
    call SetRequestPtrC921_B04
    ret

Jump_004_5B1D::
    ld hl, $5B94
    call SetRequestPtrC91A_B04
    ld a, $10
    ld [wDataBank], a
    ret

Jump_004_5B29::
    ld hl, $5B9B
    call SetRequestPtrC91A_B04
    ret

Jump_004_5B30::
    ld hl, $081B
    call SetRequestPtrC921_B04
    ret

Jump_004_5B37::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5B46
    ld hl, $081C
    call SetRequestPtrC921_B04
    ret

Jump_004_5B46::
    ld hl, $0879
    call SetRequestPtrC921_B04
    ret

Jump_004_5B4D::
    ld hl, $088B
    call SetRequestPtrC921_B04
    ret

Jump_004_5B54::
    ld hl, $0889
    call SetRequestPtrC921_B04
    ret

Jump_004_5B5B::
    ld hl, $081D
    call SetRequestPtrC921_B04
    ret

Jump_004_5B62::
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5B71
    ld hl, $081E
    call SetRequestPtrC921_B04
    ret

Jump_004_5B71::
    ld hl, $087A
    call SetRequestPtrC921_B04
    ret

Jump_004_5B78::
    ld hl, $081F
    call SetRequestPtrC921_B04
    ret

Jump_004_5B7F::
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_5BA8
    call SetRequestPtrC91A_B04
    ret

Jump_004_5B8B::
    ld hl, $0821
    call SetRequestPtrC921_B04
    ret

Jump_004_5B92::
    ld hl, $0822
    call SetRequestPtrC921_B04
    ret

Jump_004_5B99::
    ld a, $06
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_5BAF
    call SetRequestPtrC91A_B04
    ret

Jump_004_5BAA::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BB9
    ld hl, $0824
    call SetRequestPtrC921_B04
    ret

Jump_004_5BB9::
    ld hl, $0D13
    call SetRequestPtrC921_B04
    ret

Jump_004_5BC0::
    ld hl, $0825
    call SetRequestPtrC921_B04
    ret

Jump_004_5BC7::
    ld hl, $0826
    call SetRequestPtrC921_B04
    ret

Jump_004_5BCE::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BDD
    ld hl, $0827
    call SetRequestPtrC921_B04
    ret

Jump_004_5BDD::
    ld hl, $087B
    call SetRequestPtrC921_B04
    ret

Jump_004_5BE4::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5BF3
    ld hl, $0829
    call SetRequestPtrC921_B04
    ret

Jump_004_5BF3::
    ld hl, $087C
    call SetRequestPtrC921_B04
    ret

Jump_004_5BFA::
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5C09
    ld hl, $082A
    call SetRequestPtrC921_B04
    ret

Jump_004_5C09::
    ld hl, $087D
    call SetRequestPtrC921_B04
    ret

Jump_004_5C10::
    ld hl, $082B
    call SetRequestPtrC921_B04
    ret

Jump_004_5C17::
    ld hl, $088D
    call SetRequestPtrC921_B04
    ret

Jump_004_5C1E::
    ld hl, $5BB6
    call SetRequestPtrC91A_B04
    ret

Jump_004_5C25::
    ld hl, $082E
    call SetRequestPtrC921_B04
    ret

Jump_004_5C2C::
    ld a, $02
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $0063
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5C3D::
    ld hl, $5BBD
    call SetRequestPtrC91A_B04
    ld a, $10
    ld [wDataBank], a
    ret

Jump_004_5C49::
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5C58
    ld hl, $082F
    call SetRequestPtrC921_B04
    ret

Jump_004_5C58::
    ld hl, $087E
    call SetRequestPtrC921_B04
    ret

Jump_004_5C5F::
    ld hl, $0830
    call SetRequestPtrC921_B04
    ret

Jump_004_5C66::
    ld hl, $5BC4
    call SetRequestPtrC91A_B04
    ret

Jump_004_5C6D::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5C8B
    ld de, $006D
    call TestFlagBit
    jr c, Jump_004_5C84
    ld hl, $0834
    call SetRequestPtrC921_B04
    ret

Jump_004_5C84::
    ld hl, $0842
    call SetRequestPtrC921_B04
    ret

Jump_004_5C8B::
    ld hl, $0D14
    call SetRequestPtrC921_B04
    ret

Jump_004_5C92::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5CB0
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5CA9
    ld hl, $0835
    call SetRequestPtrC921_B04
    ret

Jump_004_5CA9::
    ld hl, $0DC3
    call SetRequestPtrC921_B04
    ret

Jump_004_5CB0::
    ld hl, $087F
    call SetRequestPtrC921_B04
    ret

Jump_004_5CB7::
    ld hl, $0836
    call SetRequestPtrC921_B04
    ret

Jump_004_5CBE::
    ld de, $005F
    call TestFlagBit
    jr c, Jump_004_5D0D
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5CF5
    ld de, $006D
    call TestFlagBit
    jr c, Jump_004_5CEE
    call Func_004_5D14
    jr c, Jump_004_5CE7
    ld a, $01
    ld [wCBB6], a
    ld hl, $0837
    call SetRequestPtrC921_B04
    ret

Jump_004_5CE7::
    ld hl, $5BFE
    call SetRequestPtrC91A_B04
    ret

Jump_004_5CEE::
    ld hl, $5C19
    call SetRequestPtrC91A_B04
    ret

Jump_004_5CF5::
    call Func_004_5D14
    jr c, Jump_004_5D06
    ld a, $01
    ld [wCBB6], a
    ld hl, $0837
    call SetRequestPtrC921_B04
    ret

Jump_004_5D06::
    ld hl, $5C26
    call SetRequestPtrC91A_B04
    ret

Jump_004_5D0D::
    ld hl, $0880
    call SetRequestPtrC921_B04
    ret

; 2 call sites from 1 routine (e.g. Func_004_58C2)
; reads: wC6FD, hFFC7, hFFC6
; writes: rRAMG
; points at: wC6FE
Func_004_5D14::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_004_5D20::
    ld a, [hl+]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC7]
    or a, a
    jr z, Jump_004_5D35
    ldh a, [hFFC6]
    cp a, $3C
    jr c, Jump_004_5D35
    cp a, $5C
    jr c, Jump_004_5D3E

Jump_004_5D35::
    dec b
    jr nz, Jump_004_5D20
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

Jump_004_5D3E::
    xor a, a
    ld [rRAMG], a
    scf
    ret

Jump_004_5D44::
    ld de, $0066
    call TestFlagBit
    jr c, Jump_004_5D68
    ld de, $0065
    call TestFlagBit
    jr c, Jump_004_5D61
    ld hl, $5BE8
    call SetRequestPtrC91A_B04
    ld de, $0065
    call SetFlagBit
    ret

Jump_004_5D61::
    ld hl, $5BF2
    call SetRequestPtrC91A_B04
    ret

Jump_004_5D68::
    ld hl, $5BFC
    call SetRequestPtrC91A_B04
    ret

Jump_004_5D6F::
    ld a, $00
    ld [wC921], a
    ld a, $1B
    ld [wC922], a
    ld de, $0067
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5D80::
    ld a, $00
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $0068
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5D91::
    ld a, $00
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $0069
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5DA2::
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $006A
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5DB3::
    ld a, $00
    ld [wC921], a
    ld a, $46
    ld [wC922], a
    ld de, $006B
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5DC4::
    ld a, $00
    ld [wC921], a
    ld a, $28
    ld [wC922], a
    ld de, $006C
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5DD5::
    ld hl, $0843
    call SetRequestPtrC921_B04
    ret

Jump_004_5DDC::
    ld hl, $0844
    call SetRequestPtrC921_B04
    ret

Jump_004_5DE3::
    ld de, $006F
    call TestFlagBit
    ret nc
    ld hl, $5C69
    call SetRequestPtrC91A_B04
    ret

Jump_004_5DF1::
    ld de, $00F1
    call TestFlagBit
    jr c, Jump_004_5E06
    ld hl, $084E
    call SetRequestPtrC921_B04
    ld de, $00F1
    call SetFlagBit
    ret

Jump_004_5E06::
    ld hl, $5D36
    call SetRequestPtrC91A_B04
    ret

Jump_004_5E0D::
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E1C
    ld hl, $084F
    call SetRequestPtrC921_B04
    ret

Jump_004_5E1C::
    ld hl, $0881
    call SetRequestPtrC921_B04
    ret

Jump_004_5E23::
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E32
    ld hl, $0850
    call SetRequestPtrC921_B04
    ret

Jump_004_5E32::
    ld hl, $0882
    call SetRequestPtrC921_B04
    ret

Jump_004_5E39::
    ld hl, $0851
    call SetRequestPtrC921_B04
    ret

Jump_004_5E40::
    ld hl, $0852
    call SetRequestPtrC921_B04
    ret

Jump_004_5E47::
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E56
    ld hl, $0853
    call SetRequestPtrC921_B04
    ret

Jump_004_5E56::
    ld hl, $0883
    call SetRequestPtrC921_B04
    ret

Jump_004_5E5D::
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E6C
    ld hl, $0854
    call SetRequestPtrC921_B04
    ret

Jump_004_5E6C::
    ld hl, $0884
    call SetRequestPtrC921_B04
    ret

Jump_004_5E73::
    ld de, $005E
    call TestFlagBit
    jr c, Jump_004_5EB6
    ld de, $0076
    call TestFlagBit
    jr c, Jump_004_5E99
    ld de, $0070
    call TestFlagBit
    jr c, Jump_004_5E92
    ld hl, $5C77
    call SetRequestPtrC91A_B04
    ret

Jump_004_5E92::
    ld hl, $0858
    call SetRequestPtrC921_B04
    ret

Jump_004_5E99::
    call Func_004_7C37
    jr c, Jump_004_5EA5
    ld hl, $0DC7
    call SetRequestPtrC921_B04
    ret

Jump_004_5EA5::
    ld [hl], $5F
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $5C7E
    call SetRequestPtrC91A_B04
    ret

Jump_004_5EB6::
    ld hl, $0885
    call SetRequestPtrC921_B04
    ret

Jump_004_5EBD::
    ld hl, $5C88
    call SetRequestPtrC91A_B04
    ret

Jump_004_5EC4::
    ld hl, $5C8A
    call SetRequestPtrC91A_B04
    ret

Jump_004_5ECB::
    ld hl, $5C94
    call SetRequestPtrC91A_B04
    ret

Jump_004_5ED2::
    ld hl, $5C9E
    call SetRequestPtrC91A_B04
    ret

Jump_004_5ED9::
    ld de, $0074
    call TestFlagBit
    jr c, Jump_004_5EEE
    ld hl, $5CA8
    call SetRequestPtrC91A_B04
    ld de, $0074
    call SetFlagBit
    ret

Jump_004_5EEE::
    ld hl, $5CB5
    call SetRequestPtrC91A_B04
    ret

Jump_004_5EF5::
    call Func_004_7C37
    jr c, Jump_004_5F01
    ld hl, $0888
    call SetRequestPtrC921_B04
    ret

Jump_004_5F01::
    ld [hl], $31
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $5CC2
    call SetRequestPtrC91A_B04
    ret

Jump_004_5F12::
    ld hl, $5CCA
    call SetRequestPtrC91A_B04
    ld de, $0077
    call SetFlagBit
    ret

Jump_004_5F1F::
    xor a, a
    ld [wCB86], a
    ret

Jump_004_5F24::
    ld a, $00
    ld [wC921], a
    ld a, $2E
    ld [wC922], a
    ld de, $0079
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5F35::
    ld de, $007A
    call TestFlagBit
    jr c, Jump_004_5F53
    ld a, $31
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    ret z
    ld hl, $0865
    call SetRequestPtrC921_B04
    ret

Jump_004_5F53::
    ld hl, $0867
    call SetRequestPtrC921_B04
    ret

Jump_004_5F5A::
    ldh a, [hFF91]
    cp a, $30
    ret nz
    ld de, $007B
    call SetFlagBit
    ld hl, $5CD1
    call SetRequestPtrC91A_B04
    ldh a, [hFF8E]
    cp a, $50
    ret nz
    ld a, $40
    ld [wCB8A], a
    ld [wCB9A], a
    ld [wCBAA], a
    ret

Jump_004_5F7C::
    ld hl, $5CDD
    call SetRequestPtrC91A_B04
    ret

Jump_004_5F83::
    ld hl, $5D1C
    call SetRequestPtrC91A_B04
    ret

Jump_004_5F8A::
    ld hl, $5D2F
    call SetRequestPtrC91A_B04
    ret

Jump_004_5F91::
    ld a, $00
    ld [wC921], a
    ld a, $20
    ld [wC922], a
    ld de, $00E0
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5FA2::
    ld a, $00
    ld [wC921], a
    ld a, $28
    ld [wC922], a
    ld de, $00E1
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5FB3::
    ld a, $00
    ld [wC921], a
    ld a, $0C
    ld [wC922], a
    ld de, $00E2
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5FC4::
    ld a, $00
    ld [wC921], a
    ld a, $11
    ld [wC922], a
    ld de, $00E3
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5FD5::
    ld a, $00
    ld [wC921], a
    ld a, $0E
    ld [wC922], a
    ld de, $00E4
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5FE6::
    ld hl, $088C
    call SetRequestPtrC921_B04
    ret

Jump_004_5FED::
    ld a, $00
    ld [wC921], a
    ld a, $03
    ld [wC922], a
    ld de, $00E5
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_5FFE::
    ld a, $00
    ld [wC921], a
    ld a, $5C
    ld [wC922], a
    ld de, $00E6
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_600F::
    ld a, $01
    ld [wC921], a
    ld a, $06
    ld [wC922], a
    ld de, $00E7
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6020::
    ld a, $01
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $00E8
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6031::
    ld a, $01
    ld [wC921], a
    ld a, $28
    ld [wC922], a
    ld de, $00F2
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6042::
    ld hl, $0861
    call SetRequestPtrC921_B04
    ret

Jump_004_6049::
    ld a, $02
    ld [wC921], a
    ld a, $1D
    ld [wC922], a
    ld de, $00E9
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_605A::
    ld a, $02
    ld [wC921], a
    ld a, $1A
    ld [wC922], a
    ld de, $00EA
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_606B::
    ld a, $00
    ld [wC921], a
    ld a, $51
    ld [wC922], a
    ld de, $00EB
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_607C::
    ld a, $00
    ld [wC921], a
    ld a, $20
    ld [wC922], a
    ld de, $00EC
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_608D::
    ld a, $00
    ld [wC921], a
    ld a, $0C
    ld [wC922], a
    ld de, $00ED
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_609E::
    ld a, $00
    ld [wC921], a
    ld a, $0F
    ld [wC922], a
    ld de, $00EE
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_60AF::
    ld a, $02
    ld [wC921], a
    ld a, $04
    ld [wC922], a
    ld de, $00EF
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_60C0::
    ld a, $02
    ld [wC921], a
    ld a, $10
    ld [wC922], a
    ld de, $00F0
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_60D1::
    ld hl, $0862
    call SetRequestPtrC921_B04
    ret

Jump_004_60D8::
    ld hl, $0864
    call SetRequestPtrC921_B04
    ret

Jump_004_60DF::
    ld hl, $5CCF
    call SetRequestPtrC91A_B04
    ld a, $31
    ldh [hFFC6], a
    farcall Func_012_7DCE
    farcall Func_012_7DF1
    ld de, $007A
    call SetFlagBit
    ret

Jump_004_60FC::
    ld hl, $00FF
    call SetRequestPtrC921_B04
    ret

Jump_004_6103::
    ld hl, $5D44
    call SetRequestPtrC91A_B04
    ret

Jump_004_610A::
    ld a, $1F
    ld [wDataBank], a
    ld de, $0202
    call TestFlagBit
    jr c, Jump_004_6124
    ld hl, $5D4D
    call SetRequestPtrC91A_B04
    ld de, $0202
    call SetFlagBit
    ret

Jump_004_6124::
    ld hl, $5D54
    call SetRequestPtrC91A_B04
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC916
Func_004_612B::
    ld a, [wC916]
    rst $00
    dw Jump_004_61BB
    dw Jump_004_61C2
    dw Jump_004_61D8
    dw Jump_004_61EE
    dw Jump_004_61F5
    dw Jump_004_620B
    dw Jump_004_6221
    dw Jump_004_6237
    dw Jump_004_623E
    dw Jump_004_624F
    dw Jump_004_6283
    dw Jump_004_629F
    dw Jump_004_62B5
    dw Jump_004_62BC
    dw Jump_004_62D2
    dw Jump_004_62E8
    dw Jump_004_6331
    dw Jump_004_6338
    dw Jump_004_634E
    dw Jump_004_6374
    dw Jump_004_638A
    dw Jump_004_63AF
    dw Jump_004_63C5
    dw Jump_004_63CC
    dw Jump_004_63ED
    dw Jump_004_643E
    dw Jump_004_6445
    dw Jump_004_6456
    dw Jump_004_645D
    dw Jump_004_646B
    dw Jump_004_6472
    dw Jump_004_6479
    dw Jump_004_6485
    dw Jump_004_649B
    dw Jump_004_64B1
    dw Jump_004_64C7
    dw Jump_004_64DD
    dw Jump_004_64E4
    dw Jump_004_6509
    dw Jump_004_653D
    dw Jump_004_6562
    dw Jump_004_6587
    dw Jump_004_6594
    dw Jump_004_659B
    dw Jump_004_660B
    dw Jump_004_6621
    dw Jump_004_6637
    dw Jump_004_664B
    dw Jump_004_665C
    dw Jump_004_666D
    dw Jump_004_667E
    dw Jump_004_668F
    dw Jump_004_66A0
    dw Jump_004_66B1
    dw Jump_004_66C2
    dw Jump_004_66D3
    dw Jump_004_66E9
    dw Jump_004_674D
    dw Jump_004_676C
    dw Jump_004_6782
    dw Jump_004_6798
    dw Jump_004_67B8
    dw Jump_004_67BF
    dw Jump_004_67C6
    dw Jump_004_67CD
    dw Jump_004_67D4
    dw Jump_004_67DB
    dw Jump_004_67EC
    dw Jump_004_67FA
    dw Jump_004_6806

Jump_004_61BB::
    ld hl, $0130
    call SetRequestPtrC921_B04
    ret

Jump_004_61C2::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_61D1
    ld hl, $0131
    call SetRequestPtrC921_B04
    ret

Jump_004_61D1::
    ld hl, $01A3
    call SetRequestPtrC921_B04
    ret

Jump_004_61D8::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_61E7
    ld hl, $0132
    call SetRequestPtrC921_B04
    ret

Jump_004_61E7::
    ld hl, $01A4
    call SetRequestPtrC921_B04
    ret

Jump_004_61EE::
    ld hl, $0133
    call SetRequestPtrC921_B04
    ret

Jump_004_61F5::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6204
    ld hl, $0134
    call SetRequestPtrC921_B04
    ret

Jump_004_6204::
    ld hl, $01A5
    call SetRequestPtrC921_B04
    ret

Jump_004_620B::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_621A
    ld hl, $0135
    call SetRequestPtrC921_B04
    ret

Jump_004_621A::
    ld hl, $5B64
    call SetRequestPtrC91A_B04
    ret

Jump_004_6221::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6230
    ld hl, $0136
    call SetRequestPtrC921_B04
    ret

Jump_004_6230::
    ld hl, $0D07
    call SetRequestPtrC921_B04
    ret

Jump_004_6237::
    ld hl, $0137
    call SetRequestPtrC921_B04
    ret

Jump_004_623E::
    ld a, $01
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $0046
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_624F::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_627C
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6275
    ld de, $004A
    call TestFlagBit
    jr c, Jump_004_626E
    ld hl, $0138
    call SetRequestPtrC921_B04
    ret

Jump_004_626E::
    ld hl, $0173
    call SetRequestPtrC921_B04
    ret

Jump_004_6275::
    ld hl, $017A
    call SetRequestPtrC921_B04
    ret

Jump_004_627C::
    ld hl, $0D08
    call SetRequestPtrC921_B04
    ret

Jump_004_6283::
    ldh a, [hFF8E]
    cp a, $30
    jr nz, Jump_004_628E
    ld a, $02
    jp Jump_004_6290

Jump_004_628E::
    ld a, $01

Jump_004_6290::
    ld [wCB86], a
    ld hl, $59BA
    call SetRequestPtrC91A_B04
    ld a, $10
    ld [wDataBank], a
    ret

Jump_004_629F::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62AE
    ld hl, $0139
    call SetRequestPtrC921_B04
    ret

Jump_004_62AE::
    ld hl, $01A6
    call SetRequestPtrC921_B04
    ret

Jump_004_62B5::
    ld hl, $013A
    call SetRequestPtrC921_B04
    ret

Jump_004_62BC::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62CB
    ld hl, $013B
    call SetRequestPtrC921_B04
    ret

Jump_004_62CB::
    ld hl, $0D0B
    call SetRequestPtrC921_B04
    ret

Jump_004_62D2::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_62E1
    ld hl, $013C
    call SetRequestPtrC921_B04
    ret

Jump_004_62E1::
    ld hl, $0D0A
    call SetRequestPtrC921_B04
    ret

Jump_004_62E8::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_632A
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6323
    ld de, $0048
    call TestFlagBit
    jr c, Jump_004_631C
    ld de, $0045
    call TestFlagBit
    jr c, Jump_004_630F
    ld hl, $013D
    call SetRequestPtrC921_B04
    ret

Jump_004_630F::
    ld hl, $0168
    call SetRequestPtrC921_B04
    ld de, $0048
    call SetFlagBit
    ret

Jump_004_631C::
    ld hl, $0168
    call SetRequestPtrC921_B04
    ret

Jump_004_6323::
    ld hl, $017B
    call SetRequestPtrC921_B04
    ret

Jump_004_632A::
    ld hl, $0D09
    call SetRequestPtrC921_B04
    ret

Jump_004_6331::
    ld hl, $013E
    call SetRequestPtrC921_B04
    ret

Jump_004_6338::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6347
    ld hl, $013F
    call SetRequestPtrC921_B04
    ret

Jump_004_6347::
    ld hl, $01A7
    call SetRequestPtrC921_B04
    ret

Jump_004_634E::
    ld a, $03
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld de, $0040
    call TestFlagBit
    jr c, Jump_004_636D
    ld hl, Data_010_59C1
    call SetRequestPtrC91A_B04
    ld de, $0040
    call SetFlagBit
    ret

Jump_004_636D::
    ld hl, $59C8
    call SetRequestPtrC91A_B04
    ret

Jump_004_6374::
    ld de, $0043
    call TestFlagBit
    jr c, Jump_004_6383
    ld hl, $0140
    call SetRequestPtrC921_B04
    ret

Jump_004_6383::
    ld hl, $016A
    call SetRequestPtrC921_B04
    ret

Jump_004_638A::
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_63A8
    ld de, $0043
    call TestFlagBit
    jr c, Jump_004_63A1
    ld hl, $0141
    call SetRequestPtrC921_B04
    ret

Jump_004_63A1::
    ld hl, $016B
    call SetRequestPtrC921_B04
    ret

Jump_004_63A8::
    ld hl, $017C
    call SetRequestPtrC921_B04
    ret

Jump_004_63AF::
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_63BE
    ld hl, $0142
    call SetRequestPtrC921_B04
    ret

Jump_004_63BE::
    ld hl, $017D
    call SetRequestPtrC921_B04
    ret

Jump_004_63C5::
    ld hl, $0143
    call SetRequestPtrC921_B04
    ret

Jump_004_63CC::
    ld a, $1F
    ld [wDataBank], a
    ld de, $0041
    call TestFlagBit
    jr c, Jump_004_63E6
    ld hl, Data_01F_59CF
    call SetRequestPtrC91A_B04
    ld de, $0041
    call SetFlagBit
    ret

Jump_004_63E6::
    ld hl, $59D6
    call SetRequestPtrC91A_B04
    ret

Jump_004_63ED::
    ld de, $0042
    call TestFlagBit
    jr c, Jump_004_641D
    ld a, [wC6FD]
    cp a, $03
    jr nz, Jump_004_640F
    farcall Func_05F_6CA9
    ld a, [wC92C]
    or a, a
    jr nz, Jump_004_6416
    ld hl, $59DD
    call SetRequestPtrC91A_B04
    ret

Jump_004_640F::
    ld hl, $59F7
    call SetRequestPtrC91A_B04
    ret

Jump_004_6416::
    ld hl, $5A07
    call SetRequestPtrC91A_B04
    ret

Jump_004_641D::
    ld a, [wC6FD]
    cp a, $03
    jr nz, Jump_004_6437
    farcall Func_05F_6CA9
    ld a, [wC92C]
    or a, a
    jr nz, Jump_004_6437
    ld hl, $5A17
    call SetRequestPtrC91A_B04
    ret

Jump_004_6437::
    ld hl, $014E
    call SetRequestPtrC921_B04
    ret

Jump_004_643E::
    ld hl, $014F
    call SetRequestPtrC921_B04
    ret

Jump_004_6445::
    ld a, $01
    ld [wC921], a
    ld a, $06
    ld [wC922], a
    ld de, $0047
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6456::
    ld hl, $0137
    call SetRequestPtrC921_B04
    ret

Jump_004_645D::
    ld de, $0056
    call TestFlagBit
    ret nc
    ld hl, $018F
    call SetRequestPtrC921_B04
    ret

Jump_004_646B::
    ld hl, $01BE
    call SetRequestPtrC921_B04
    ret

Jump_004_6472::
    ld hl, $0037
    call SetRequestPtrC921_B04
    ret

Jump_004_6479::
    ld hl, $5A25
    call SetRequestPtrC91A_B04
    ld a, $10
    ld [wDataBank], a
    ret

Jump_004_6485::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6494
    ld hl, $0150
    call SetRequestPtrC921_B04
    ret

Jump_004_6494::
    ld hl, $01A8
    call SetRequestPtrC921_B04
    ret

Jump_004_649B::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64AA
    ld hl, $0154
    call SetRequestPtrC921_B04
    ret

Jump_004_64AA::
    ld hl, $01A9
    call SetRequestPtrC921_B04
    ret

Jump_004_64B1::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64C0
    ld hl, $0155
    call SetRequestPtrC921_B04
    ret

Jump_004_64C0::
    ld hl, $01AA
    call SetRequestPtrC921_B04
    ret

Jump_004_64C7::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_64D6
    ld hl, $0156
    call SetRequestPtrC921_B04
    ret

Jump_004_64D6::
    ld hl, $01AB
    call SetRequestPtrC921_B04
    ret

Jump_004_64DD::
    ld hl, $0157
    call SetRequestPtrC921_B04
    ret

Jump_004_64E4::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6502
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_64FB
    ld hl, $0158
    call SetRequestPtrC921_B04
    ret

Jump_004_64FB::
    ld hl, $0192
    call SetRequestPtrC921_B04
    ret

Jump_004_6502::
    ld hl, $01AC
    call SetRequestPtrC921_B04
    ret

Jump_004_6509::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6536
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_652F
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6528
    ld hl, $0159
    call SetRequestPtrC921_B04
    ret

Jump_004_6528::
    ld hl, $017E
    call SetRequestPtrC921_B04
    ret

Jump_004_652F::
    ld hl, $0191
    call SetRequestPtrC921_B04
    ret

Jump_004_6536::
    ld hl, $01AD
    call SetRequestPtrC921_B04
    ret

Jump_004_653D::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_655B
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6554
    ld hl, $5B57
    call SetRequestPtrC91A_B04
    ret

Jump_004_6554::
    ld hl, $017F
    call SetRequestPtrC921_B04
    ret

Jump_004_655B::
    ld hl, $01AE
    call SetRequestPtrC921_B04
    ret

Jump_004_6562::
    ld de, $0053
    call TestFlagBit
    jr c, Jump_004_6580
    ld de, $0049
    call TestFlagBit
    jr c, Jump_004_6579
    ld hl, $015A
    call SetRequestPtrC921_B04
    ret

Jump_004_6579::
    ld hl, $0170
    call SetRequestPtrC921_B04
    ret

Jump_004_6580::
    ld hl, $0180
    call SetRequestPtrC921_B04
    ret

Jump_004_6587::
    ld a, [wCC38]
    bit 3, a
    ret nz
    ld hl, $5B71
    call SetRequestPtrC91A_B04
    ret

Jump_004_6594::
    ld hl, $015F
    call SetRequestPtrC921_B04
    ret

Jump_004_659B::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6604
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_65FD
    ld de, $0054
    call TestFlagBit
    jr c, Jump_004_65F6
    ld de, $0049
    call TestFlagBit
    jr c, Jump_004_65EF
    ld de, $0048
    call TestFlagBit
    jr c, Jump_004_65E8
    ld de, $0045
    call TestFlagBit
    jr c, Jump_004_65E1
    ld de, $0044
    call TestFlagBit
    jr c, Jump_004_65DA
    ld hl, $5A2C
    call SetRequestPtrC91A_B04
    ret

Jump_004_65DA::
    ld hl, $5A4C
    call SetRequestPtrC91A_B04
    ret

Jump_004_65E1::
    ld hl, $0164
    call SetRequestPtrC921_B04
    ret

Jump_004_65E8::
    ld hl, $5A5C
    call SetRequestPtrC91A_B04
    ret

Jump_004_65EF::
    ld hl, $0174
    call SetRequestPtrC921_B04
    ret

Jump_004_65F6::
    ld hl, $5AD6
    call SetRequestPtrC91A_B04
    ret

Jump_004_65FD::
    ld hl, $0190
    call SetRequestPtrC921_B04
    ret

Jump_004_6604::
    ld hl, $01B0
    call SetRequestPtrC921_B04
    ret

Jump_004_660B::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_661A
    ld hl, $0166
    call SetRequestPtrC921_B04
    ret

Jump_004_661A::
    ld hl, $01B1
    call SetRequestPtrC921_B04
    ret

Jump_004_6621::
    ld de, $0056
    call TestFlagBit
    jr c, Jump_004_6630
    ld hl, $0167
    call SetRequestPtrC921_B04
    ret

Jump_004_6630::
    ld hl, $0193
    call SetRequestPtrC921_B04
    ret

Jump_004_6637::
    ld de, $0049
    call TestFlagBit
    ret nc
    ld hl, $5A95
    call SetRequestPtrC91A_B04
    ld de, $004A
    call SetFlagBit
    ret

Jump_004_664B::
    ld a, $01
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $004B
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_665C::
    ld a, $01
    ld [wC921], a
    ld a, $1A
    ld [wC922], a
    ld de, $004C
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_666D::
    ld a, $01
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $004D
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_667E::
    ld a, $01
    ld [wC921], a
    ld a, $2B
    ld [wC922], a
    ld de, $004E
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_668F::
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $004F
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_66A0::
    ld a, $00
    ld [wC921], a
    ld a, $24
    ld [wC922], a
    ld de, $0050
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_66B1::
    ld a, $00
    ld [wC921], a
    ld a, $29
    ld [wC922], a
    ld de, $0051
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_66C2::
    ld a, $00
    ld [wC921], a
    ld a, $48
    ld [wC922], a
    ld de, $0052
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_66D3::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_66E2
    ld hl, $5AAB
    call SetRequestPtrC91A_B04
    ret

Jump_004_66E2::
    ld hl, $5AD2
    call SetRequestPtrC91A_B04
    ret

Jump_004_66E9::
    ld de, $0056
    call TestFlagBit
    ret nc
    ld de, $0057
    call TestFlagBit
    jr c, Jump_004_6746
    ld a, $19
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1A
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1B
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_004_673F
    ld a, $1C
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_004_673F
    ld hl, $5B0D
    call SetRequestPtrC91A_B04
    ret

Jump_004_673F::
    ld hl, $5B1D
    call SetRequestPtrC91A_B04
    ret

Jump_004_6746::
    ld hl, $018E
    call SetRequestPtrC921_B04
    ret

Jump_004_674D::
    ld a, [wCC38]
    set 4, a
    ld [wCC38], a
    ld hl, $5B37
    call SetRequestPtrC91A_B04
    ld a, $30
    ldh [hFFC6], a
    farcall Func_012_7DCE
    farcall Func_012_7DF1
    ret

Jump_004_676C::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_677B
    ld hl, $0194
    call SetRequestPtrC921_B04
    ret

Jump_004_677B::
    ld hl, $01B2
    call SetRequestPtrC921_B04
    ret

Jump_004_6782::
    ld de, $005A
    call TestFlagBit
    jr c, Jump_004_6791
    ld hl, $0195
    call SetRequestPtrC921_B04
    ret

Jump_004_6791::
    ld hl, $01B4
    call SetRequestPtrC921_B04
    ret

Jump_004_6798::
    ld a, $03
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld de, $0059
    call TestFlagBit
    jr c, Jump_004_67B1
    ld hl, $5B3C
    call SetRequestPtrC91A_B04
    ret

Jump_004_67B1::
    ld hl, $5B49
    call SetRequestPtrC91A_B04
    ret

Jump_004_67B8::
    ld hl, $01B5
    call SetRequestPtrC921_B04
    ret

Jump_004_67BF::
    ld hl, $01BC
    call SetRequestPtrC921_B04
    ret

Jump_004_67C6::
    ld hl, $01BD
    call SetRequestPtrC921_B04
    ret

Jump_004_67CD::
    ld hl, $01C0
    call SetRequestPtrC921_B04
    ret

Jump_004_67D4::
    ld hl, $01BF
    call SetRequestPtrC921_B04
    ret

Jump_004_67DB::
    ld a, $01
    ld [wC921], a
    ld a, $19
    ld [wC922], a
    ld de, $005B
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_67EC::
    ld de, $0058
    call TestFlagBit
    ret nc
    ld hl, $5B53
    call SetRequestPtrC91A_B04
    ret

Jump_004_67FA::
    ld a, [wCC38]
    bit 4, a
    ret nz
    and a, $F7
    ld [wCC38], a
    ret

Jump_004_6806::
    ld a, $1F
    ld [wDataBank], a
    ld de, $005D
    call TestFlagBit
    jr c, Jump_004_6820
    ld hl, Data_01F_5B76
    call SetRequestPtrC91A_B04
    ld de, $005D
    call SetFlagBit
    ret

Jump_004_6820::
    ld hl, $5B7D
    call SetRequestPtrC91A_B04
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC916
Func_004_6827::
    ld a, [wC916]
    rst $00
    dw Jump_004_682F
    dw Jump_004_687C

Jump_004_682F::
    ld de, $00D2
    call TestFlagBit
    jr c, Jump_004_6875
    ld a, $36
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_004_686E
    ld a, $37
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_004_686E
    ld a, $38
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_004_686E
    ld hl, $61AA
    call SetRequestPtrC91A_B04
    ret

Jump_004_686E::
    ld hl, $619D
    call SetRequestPtrC91A_B04
    ret

Jump_004_6875::
    ld hl, $61DC
    call SetRequestPtrC91A_B04
    ret

Jump_004_687C::
    ld de, $00D0
    call TestFlagBit
    jr c, Jump_004_688B
    ld hl, $61E9
    call SetRequestPtrC91A_B04
    ret

Jump_004_688B::
    ld hl, $61F6
    call SetRequestPtrC91A_B04
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC916
Func_004_6892::
    ld a, [wC916]
    rst $00
    dw Jump_004_69E0
    dw Jump_004_69E1
    dw Jump_004_69E8
    dw Jump_004_69E0
    dw Jump_004_69EF
    dw Jump_004_69F6
    dw Jump_004_69FD
    dw Jump_004_6A04
    dw Jump_004_6A0B
    dw Jump_004_6A12
    dw Jump_004_6A19
    dw Jump_004_6A20
    dw Jump_004_6A20
    dw Jump_004_6A20
    dw Jump_004_6A27
    dw Jump_004_6A2E
    dw Jump_004_69BD
    dw Jump_004_69C4
    dw Jump_004_69CB
    dw Jump_004_69D2
    dw Jump_004_69D9
    dw Jump_004_6930
    dw Jump_004_6937
    dw Jump_004_693E
    dw Jump_004_6922
    dw Jump_004_691B
    dw Jump_004_6914
    dw Jump_004_6904
    dw Jump_004_68F4
    dw Jump_004_68ED
    dw Jump_004_68E6
    dw Jump_004_6929
    dw Jump_004_6945
    dw Jump_004_694C
    dw Jump_004_6953
    dw Jump_004_696C
    dw Jump_004_698B
    dw Jump_004_69AC
    dw Jump_004_69B8
    dw Jump_004_69E0

Jump_004_68E6::
    ld hl, $5173
    call SetRequestPtrC91A_B04
    ret

Jump_004_68ED::
    ld hl, $5171
    call SetRequestPtrC91A_B04
    ret

Jump_004_68F4::
    ld de, $0024
    call TestFlagBit
    jr c, Jump_004_68FD
    ret

Jump_004_68FD::
    ld hl, $516F
    call SetRequestPtrC91A_B04
    ret

Jump_004_6904::
    ld de, $0024
    call TestFlagBit
    jr c, Jump_004_690D
    ret

Jump_004_690D::
    ld hl, $516D
    call SetRequestPtrC91A_B04
    ret

Jump_004_6914::
    ld hl, $516B
    call SetRequestPtrC91A_B04
    ret

Jump_004_691B::
    ld hl, $5169
    call SetRequestPtrC91A_B04
    ret

Jump_004_6922::
    ld hl, $515F
    call SetRequestPtrC91A_B04
    ret

Jump_004_6929::
    ld hl, $5164
    call SetRequestPtrC91A_B04
    ret

Jump_004_6930::
    ld hl, $5155
    call SetRequestPtrC91A_B04
    ret

Jump_004_6937::
    ld hl, $5157
    call SetRequestPtrC91A_B04
    ret

Jump_004_693E::
    ld hl, $5159
    call SetRequestPtrC91A_B04
    ret

Jump_004_6945::
    ld hl, $515B
    call SetRequestPtrC91A_B04
    ret

Jump_004_694C::
    ld hl, $515D
    call SetRequestPtrC91A_B04
    ret

Jump_004_6953::
    ld a, [wC94D]
    or a, a
    ret z
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wC8EF], a
    xor a, a
    ld [wC922], a
    ld hl, $57E1
    call SetRequestPtrC91A_B04
    ret

Jump_004_696C::
    ld a, [wC94D]
    or a, a
    ret z
    ld a, [wC6FD]
    dec a
    ret z
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wC8F4], a
    ld a, $01
    ld [wC922], a
    ld hl, $57E1
    call SetRequestPtrC91A_B04
    ret

Jump_004_698B::
    ld a, [wC94D]
    or a, a
    ret z
    ld a, [wC6FD]
    dec a
    ret z
    dec a
    ret z
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wC8F9], a
    ld a, $02
    ld [wC922], a
    ld hl, $57E1
    call SetRequestPtrC91A_B04
    ret

Jump_004_69AC::
    ld a, [wC94D]
    or a, a
    ret nz
    ld hl, $57DC
    call SetRequestPtrC91A_B04
    ret

Jump_004_69B8::
    xor a, a
    ld [wC94D], a
    ret

Jump_004_69BD::
    ld hl, $514B
    call SetRequestPtrC91A_B04
    ret

Jump_004_69C4::
    ld hl, $514D
    call SetRequestPtrC91A_B04
    ret

Jump_004_69CB::
    ld hl, $514F
    call SetRequestPtrC91A_B04
    ret

Jump_004_69D2::
    ld hl, $5151
    call SetRequestPtrC91A_B04
    ret

Jump_004_69D9::
    ld hl, $5153
    call SetRequestPtrC91A_B04
    ret

Jump_004_69E0::
    ret

Jump_004_69E1::
    ld hl, $512F
    call SetRequestPtrC91A_B04
    ret

Jump_004_69E8::
    ld hl, $5131
    call SetRequestPtrC91A_B04
    ret

Jump_004_69EF::
    ld hl, $5137
    call SetRequestPtrC91A_B04
    ret

Jump_004_69F6::
    ld hl, $5139
    call SetRequestPtrC91A_B04
    ret

Jump_004_69FD::
    ld hl, $513B
    call SetRequestPtrC91A_B04
    ret

Jump_004_6A04::
    ld hl, $513D
    call SetRequestPtrC91A_B04
    ret

Jump_004_6A0B::
    ld hl, $513F
    call SetRequestPtrC91A_B04
    ret

Jump_004_6A12::
    ld hl, $5141
    call SetRequestPtrC91A_B04
    ret

Jump_004_6A19::
    ld hl, $5143
    call SetRequestPtrC91A_B04
    ret

Jump_004_6A20::
    ld hl, $5145
    call SetRequestPtrC91A_B04
    ret

Jump_004_6A27::
    ld hl, $5147
    call SetRequestPtrC91A_B04
    ret

Jump_004_6A2E::
    ld hl, $5149
    call SetRequestPtrC91A_B04
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC916
Func_004_6A35::
    ld a, [wC916]
    rst $00
    dw Jump_004_6BB9
    dw Jump_004_6BDD
    dw Jump_004_6C59
    dw Jump_004_6CA8
    dw Jump_004_6CDC
    dw Jump_004_6D01
    dw Jump_004_6D17
    dw Jump_004_6D4B
    dw Jump_004_6D61
    dw Jump_004_6D95
    dw Jump_004_6DC9
    dw Jump_004_6DDA
    dw Jump_004_6E56
    dw Jump_004_6E64
    dw Jump_004_6E7A
    dw Jump_004_6E90
    dw Jump_004_6ECA
    dw Jump_004_6EEF
    dw Jump_004_6F0B
    dw Jump_004_6F1F
    dw Jump_004_6F30
    dw Jump_004_6F41
    dw Jump_004_6F52
    dw Jump_004_6F59
    dw Jump_004_6F60
    dw Jump_004_6F71
    dw Jump_004_6F82
    dw Jump_004_6F93
    db $00, $00, $00, $00, $00, $00, $00, $00, $9A, $6F, $6A, $70
    dw Data_004_7093
    dw Data_004_709A
    dw Data_004_70A1
    dw Data_004_70B2
    dw Data_004_70B9
    dw Data_004_70C0
    dw Data_004_70C7
    dw Data_004_70CE
    dw Data_004_70DF
    dw Func_004_70E6
    dw Func_004_70FC
    dw Func_004_7112
    dw Func_004_7164
    db $A5, $71
    dw Func_004_71AC
    dw Func_004_71C2
    dw Func_004_71E7
    dw Func_004_71FD
    dw Func_004_7213
    dw Func_004_7238
    dw Func_004_724E
    dw Func_004_72BC
    dw Func_004_7315
    dw Func_004_7349
    dw Func_004_737D
    dw Func_004_73A2
    dw Func_004_73C7
    dw Func_004_73D8
    dw Func_004_73F3
    dw Func_004_7418
    db $97, $74
    dw Func_004_749E
    dw Func_004_74D2
    dw Func_004_7506
    dw Func_004_753A
    dw Func_004_760E
    dw Func_004_7624
    dw Func_004_763A
    dw Func_004_7657
    dw Func_004_766D
    dw Func_004_767E
    db $8F, $76, $96, $76, $9D, $76, $A4, $76, $B5, $76
    dw Func_004_76BC
    dw Func_004_76CD
    dw Func_004_76E3
    dw Func_004_76F4
    dw Func_004_7705
    db $16, $77
    ds $14, $00
    db $1D, $77, $24, $77, $2B, $77, $47, $77, $47, $77, $47, $77, $47, $77
    dw Func_004_774E
    dw Func_004_7764
    dw Func_004_7775
    dw Func_004_7786
    dw Func_004_7797
    dw Func_004_77A8
    dw Func_004_77B9
    dw Func_004_77CA
    dw Func_004_77DB
    dw Func_004_77EC
    dw Func_004_77FD
    dw Func_004_780E
    dw Func_004_781F
    dw Func_004_7830
    dw Func_004_7841
    dw Func_004_7852
    dw Func_004_7863
    db $74, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $7B, $78, $82, $78, $89, $78, $A5, $78, $A5, $78, $A5, $78, $A5, $78
    dw Func_004_78AC
    dw Func_004_78C2
    dw Func_004_78D3
    dw Func_004_78E4
    dw Func_004_78F5
    dw Func_004_7906
    dw Func_004_7917
    dw Func_004_7928
    dw Func_004_7939
    dw Func_004_794A
    dw Func_004_795B
    dw Func_004_796C
    dw Func_004_797D
    dw Func_004_798E
    dw Func_004_799F
    dw Func_004_79B0
    dw Func_004_79C1
    ds $10, $00
    db $D2, $79, $D9, $79, $E0, $79, $FC, $79, $FC, $79, $FC, $79, $FC, $79
    dw Func_004_7A03
    dw Func_004_7A19
    dw Func_004_7A2A
    dw Func_004_7A3B
    dw Func_004_7A4C
    dw Func_004_7A5D
    dw Func_004_7A6E
    dw Func_004_7A7F
    dw Func_004_7A90
    dw Func_004_7AA1
    dw Func_004_7AB2
    dw Func_004_7AC3
    dw Func_004_7AD4
    dw Func_004_7AE5
    dw Func_004_7AF6
    dw Func_004_7B07
    dw Func_004_7B18
    ds $10, $00

Jump_004_6BB9::
    ld de, $0140
    call TestFlagBit
    jr c, Jump_004_6BC8
    ld hl, $6200
    call SetRequestPtrC91A_B04
    ret

Jump_004_6BC8::
    ld de, $0148
    call TestFlagBit
    ret c
    ld de, $0147
    call TestFlagBit
    ret nc
    ld hl, $624B
    call SetRequestPtrC91A_B04
    ret

Jump_004_6BDD::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6C52
    ld de, $014F
    call TestFlagBit
    jr c, Jump_004_6C4B
    ld de, $014B
    call TestFlagBit
    jr c, Jump_004_6C44
    ld de, $0146
    call TestFlagBit
    jr c, Jump_004_6C3D
    ld de, $0143
    call TestFlagBit
    jr c, Jump_004_6C30
    ld de, $0141
    call TestFlagBit
    jr c, Jump_004_6C1A
    ld hl, $0701
    call SetRequestPtrC921_B04
    ld de, $0141
    call SetFlagBit
    ret

Jump_004_6C1A::
    ld de, $0142
    call TestFlagBit
    jr c, Jump_004_6C29
    ld hl, $0702
    call SetRequestPtrC921_B04
    ret

Jump_004_6C29::
    ld hl, $620C
    call SetRequestPtrC91A_B04
    ret

Jump_004_6C30::
    ld hl, $0706
    call SetRequestPtrC921_B04
    ld de, $0145
    call SetFlagBit
    ret

Jump_004_6C3D::
    ld hl, $0715
    call SetRequestPtrC921_B04
    ret

Jump_004_6C44::
    ld hl, $62AD
    call SetRequestPtrC91A_B04
    ret

Jump_004_6C4B::
    ld hl, $0738
    call SetRequestPtrC921_B04
    ret

Jump_004_6C52::
    ld hl, $0746
    call SetRequestPtrC921_B04
    ret

Jump_004_6C59::
    ld de, $0152
    call TestFlagBit
    jr c, Jump_004_6CA1
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6C94
    ld de, $0146
    call TestFlagBit
    jr c, Jump_004_6C8D
    ld de, $0143
    call TestFlagBit
    jr c, Jump_004_6C80
    ld hl, $6382
    call SetRequestPtrC91A_B04
    ret

Jump_004_6C80::
    ld hl, $0707
    call SetRequestPtrC921_B04
    ld de, $0145
    call SetFlagBit
    ret

Jump_004_6C8D::
    ld hl, $6240
    call SetRequestPtrC91A_B04
    ret

Jump_004_6C94::
    ld hl, $0747
    call SetRequestPtrC921_B04
    ld de, $0152
    call SetFlagBit
    ret

Jump_004_6CA1::
    ld hl, $0748
    call SetRequestPtrC921_B04
    ret

Jump_004_6CA8::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6CD5
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6CCE
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6CC7
    ld hl, $0708
    call SetRequestPtrC921_B04
    ret

Jump_004_6CC7::
    ld hl, $0717
    call SetRequestPtrC921_B04
    ret

Jump_004_6CCE::
    ld hl, $0755
    call SetRequestPtrC921_B04
    ret

Jump_004_6CD5::
    ld hl, $0749
    call SetRequestPtrC921_B04
    ret

Jump_004_6CDC::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6CFA
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6CF3
    ld hl, $0709
    call SetRequestPtrC921_B04
    ret

Jump_004_6CF3::
    ld hl, $0718
    call SetRequestPtrC921_B04
    ret

Jump_004_6CFA::
    ld hl, $074A
    call SetRequestPtrC921_B04
    ret

Jump_004_6D01::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D10
    ld hl, $070A
    call SetRequestPtrC921_B04
    ret

Jump_004_6D10::
    ld hl, $074B
    call SetRequestPtrC921_B04
    ret

Jump_004_6D17::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D44
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6D3D
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6D36
    ld hl, $070B
    call SetRequestPtrC921_B04
    ret

Jump_004_6D36::
    ld hl, $071A
    call SetRequestPtrC921_B04
    ret

Jump_004_6D3D::
    ld hl, $072C
    call SetRequestPtrC921_B04
    ret

Jump_004_6D44::
    ld hl, $074C
    call SetRequestPtrC921_B04
    ret

Jump_004_6D4B::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D5A
    ld hl, $070C
    call SetRequestPtrC921_B04
    ret

Jump_004_6D5A::
    ld hl, $074D
    call SetRequestPtrC921_B04
    ret

Jump_004_6D61::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6D8E
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6D87
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6D80
    ld hl, $070D
    call SetRequestPtrC921_B04
    ret

Jump_004_6D80::
    ld hl, $071B
    call SetRequestPtrC921_B04
    ret

Jump_004_6D87::
    ld hl, $072D
    call SetRequestPtrC921_B04
    ret

Jump_004_6D8E::
    ld hl, $074E
    call SetRequestPtrC921_B04
    ret

Jump_004_6D95::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6DC2
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6DBB
    ld de, $0147
    call TestFlagBit
    jr c, Jump_004_6DB4
    ld hl, $0752
    call SetRequestPtrC921_B04
    ret

Jump_004_6DB4::
    ld hl, $071C
    call SetRequestPtrC921_B04
    ret

Jump_004_6DBB::
    ld hl, $072E
    call SetRequestPtrC921_B04
    ret

Jump_004_6DC2::
    ld hl, $074F
    call SetRequestPtrC921_B04
    ret

Jump_004_6DC9::
    ld a, $10
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_637B
    call SetRequestPtrC91A_B04
    ret

Jump_004_6DDA::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6E4F
    ld de, $014D
    call TestFlagBit
    jr c, Jump_004_6E48
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6E3B
    ld de, $0146
    call TestFlagBit
    jr c, Jump_004_6E34
    ld de, $0144
    call TestFlagBit
    jr c, Jump_004_6E1E
    ld de, $0145
    call TestFlagBit
    jr c, Jump_004_6E17
    ld hl, $070F
    call SetRequestPtrC921_B04
    ld de, $0144
    call SetFlagBit
    ret

Jump_004_6E17::
    ld hl, $6218
    call SetRequestPtrC91A_B04
    ret

Jump_004_6E1E::
    ld de, $0145
    call TestFlagBit
    jr c, Jump_004_6E2D
    ld hl, $0753
    call SetRequestPtrC921_B04
    ret

Jump_004_6E2D::
    ld hl, $622C
    call SetRequestPtrC91A_B04
    ret

Jump_004_6E34::
    ld hl, $0714
    call SetRequestPtrC921_B04
    ret

Jump_004_6E3B::
    ld hl, $072A
    call SetRequestPtrC921_B04
    ld de, $014D
    call SetFlagBit
    ret

Jump_004_6E48::
    ld hl, $072B
    call SetRequestPtrC921_B04
    ret

Jump_004_6E4F::
    ld hl, $0744
    call SetRequestPtrC921_B04
    ret

Jump_004_6E56::
    ld de, $0148
    call TestFlagBit
    ret nc
    ld hl, $626A
    call SetRequestPtrC91A_B04
    ret

Jump_004_6E64::
    ld de, $014A
    call TestFlagBit
    jr c, Jump_004_6E73
    ld hl, $0723
    call SetRequestPtrC921_B04
    ret

Jump_004_6E73::
    ld hl, $0726
    call SetRequestPtrC921_B04
    ret

Jump_004_6E7A::
    ld de, $014A
    call TestFlagBit
    jr c, Jump_004_6E89
    ld hl, $6290
    call SetRequestPtrC91A_B04
    ret

Jump_004_6E89::
    ld hl, $62A0
    call SetRequestPtrC91A_B04
    ret

Jump_004_6E90::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6EC3
    ld de, $014E
    call TestFlagBit
    jr c, Jump_004_6EBC
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6EAF
    ld hl, $072F
    call SetRequestPtrC921_B04
    ret

Jump_004_6EAF::
    ld hl, $0731
    call SetRequestPtrC921_B04
    ld de, $014E
    call SetFlagBit
    ret

Jump_004_6EBC::
    ld hl, $0732
    call SetRequestPtrC921_B04
    ret

Jump_004_6EC3::
    ld hl, $0750
    call SetRequestPtrC921_B04
    ret

Jump_004_6ECA::
    ld de, $0151
    call TestFlagBit
    jr c, Jump_004_6EE8
    ld de, $014C
    call TestFlagBit
    jr c, Jump_004_6EE1
    ld hl, $0730
    call SetRequestPtrC921_B04
    ret

Jump_004_6EE1::
    ld hl, $0733
    call SetRequestPtrC921_B04
    ret

Jump_004_6EE8::
    ld hl, $0751
    call SetRequestPtrC921_B04
    ret

Jump_004_6EEF::
    ld de, $0150
    call TestFlagBit
    jr c, Jump_004_6F04
    ld hl, $62BD
    call SetRequestPtrC91A_B04
    ld de, $0150
    call SetFlagBit
    ret

Jump_004_6F04::
    ld hl, $6313
    call SetRequestPtrC91A_B04
    ret

Jump_004_6F0B::
    ld de, $014C
    call TestFlagBit
    ret nc
    ld hl, $6369
    call SetRequestPtrC91A_B04
    ld de, $0149
    call SetFlagBit
    ret

Jump_004_6F1F::
    ld a, $01
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $0153
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6F30::
    ld a, $01
    ld [wC921], a
    ld a, $10
    ld [wC922], a
    ld de, $0154
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6F41::
    ld a, $01
    ld [wC921], a
    ld a, $04
    ld [wC922], a
    ld de, $0155
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6F52::
    ld hl, $0756
    call SetRequestPtrC921_B04
    ret

Jump_004_6F59::
    ld hl, $0758
    call SetRequestPtrC921_B04
    ret

Jump_004_6F60::
    ld a, $00
    ld [wC921], a
    ld a, $03
    ld [wC922], a
    ld de, $0156
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6F71::
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $0157
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6F82::
    ld a, $00
    ld [wC921], a
    ld a, $12
    ld [wC922], a
    ld de, $0158
    call SetRequestPtrC924FromDE_B04
    ret

Jump_004_6F93::
    ld hl, $0757
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wC836
; writes: hFFC6, wC836
Func_004_6F9A:: ; heuristic: follows a terminator; C0
    ld de, $0167
    call TestFlagBit
    jp c, Jump_004_704E
    ld de, $0165
    call TestFlagBit
    jp c, Jump_004_7032
    ld de, $0163
    call TestFlagBit
    jr c, Jump_004_6FF7
    ld de, $0162
    call TestFlagBit
    jr c, Jump_004_6FF0
    ld de, $015F
    call TestFlagBit
    jr c, Jump_004_6FE9
    ld de, $015A
    call TestFlagBit
    jr c, Jump_004_6FE2
    ld de, $0159
    call TestFlagBit
    jr c, Jump_004_6FDB
    ld hl, $6398
    call SetRequestPtrC91A_B04
    ret

Jump_004_6FDB::
    ld hl, $63BC
    call SetRequestPtrC91A_B04
    ret

Jump_004_6FE2::
    ld hl, $075F
    call SetRequestPtrC921_B04
    ret

Jump_004_6FE9::
    ld hl, $6409
    call SetRequestPtrC91A_B04
    ret

Jump_004_6FF0::
    ld hl, $0778
    call SetRequestPtrC921_B04
    ret

Jump_004_6FF7::
    ld a, $3C
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_004_702B
    farcall Func_012_7DF1
    call Func_004_7C37
    ld [hl], $17
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $641B
    call SetRequestPtrC91A_B04
    ld a, $08
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ret

Jump_004_702B::
    ld hl, $077D
    call SetRequestPtrC921_B04
    ret

Jump_004_7032::
    ld de, $0166
    call TestFlagBit
    jr c, Jump_004_7047
    ld hl, $0786
    call SetRequestPtrC921_B04
    ld de, $0166
    call SetFlagBit
    ret

Jump_004_7047::
    ld hl, $0787
    call SetRequestPtrC921_B04
    ret

Jump_004_704E::
    ld de, $0168
    call TestFlagBit
    jr c, Jump_004_7063
    ld hl, $0789
    call SetRequestPtrC921_B04
    ld de, $0168
    call SetFlagBit
    ret

Jump_004_7063::
    ld hl, $078A
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wCB96
Func_004_706A:: ; heuristic: follows a terminator; C0
    ld de, $0167
    call TestFlagBit
    jr c, Jump_004_708C
    ld de, $0165
    call TestFlagBit
    jr c, Jump_004_7085
    xor a, a
    ld [wCB96], a
    ld hl, $075A
    call SetRequestPtrC921_B04
    ret

Jump_004_7085::
    ld hl, $0788
    call SetRequestPtrC921_B04
    ret

Jump_004_708C::
    ld hl, $078B
    call SetRequestPtrC921_B04
    ret

Data_004_7093:: ; heuristic: target of a monotone pointer table; C0
    db $21, $60, $07, $CD, $BB, $55, $C9

Data_004_709A:: ; heuristic: target of a monotone pointer table; C0
    db $21, $61, $07, $CD, $BB, $55, $C9

Data_004_70A1:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $01, $EA, $21, $C9, $3E, $2C, $EA, $22, $C9, $11, $5B, $01, $CD, $DF, $55
    db $C9

Data_004_70B2:: ; heuristic: target of a monotone pointer table; C0
    db $21, $62, $07, $CD, $BB, $55, $C9

Data_004_70B9:: ; heuristic: target of a monotone pointer table; C0
    db $21, $63, $07, $CD, $BB, $55, $C9

Data_004_70C0:: ; heuristic: target of a monotone pointer table; C0
    db $21, $64, $07, $CD, $BB, $55, $C9

Data_004_70C7:: ; heuristic: target of a monotone pointer table; C0
    db $21, $65, $07, $CD, $BB, $55, $C9

Data_004_70CE:: ; heuristic: target of a monotone pointer table; C0
    db $3E, $02, $EA, $21, $C9, $3E, $03, $EA, $22, $C9, $11, $5C, $01, $CD, $DF, $55
    db $C9

Data_004_70DF:: ; heuristic: target of a monotone pointer table; C0
    db $21, $66, $07, $CD, $BB, $55, $C9

; no direct call (reached through a table, a jump or a vector)
Func_004_70E6:: ; heuristic: target of a pointer table; C0
    ld de, $015D
    call TestFlagBit
    jr c, Jump_004_70F5
    ld hl, $63DB
    call SetRequestPtrC91A_B04
    ret

Jump_004_70F5::
    ld hl, $0768
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_70FC:: ; heuristic: target of a pointer table; C0
    ld de, $015E
    call TestFlagBit
    jr c, Jump_004_710B
    ld hl, $63E4
    call SetRequestPtrC91A_B04
    ret

Jump_004_710B::
    ld hl, $0768
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7112:: ; heuristic: target of a pointer table; C0
    ld de, $0167
    call TestFlagBit
    jr c, Jump_004_715D
    ld de, $0163
    call TestFlagBit
    jr c, Jump_004_7156
    ld de, $0161
    call TestFlagBit
    jr c, Jump_004_714F
    ld de, $0160
    call TestFlagBit
    jr c, Jump_004_7148
    ld de, $015F
    call TestFlagBit
    jr c, Jump_004_7141
    ld hl, $63ED
    call SetRequestPtrC91A_B04
    ret

Jump_004_7141::
    ld hl, $63F4
    call SetRequestPtrC91A_B04
    ret

Jump_004_7148::
    ld hl, $63FB
    call SetRequestPtrC91A_B04
    ret

Jump_004_714F::
    ld hl, $6402
    call SetRequestPtrC91A_B04
    ret

Jump_004_7156::
    ld hl, $078E
    call SetRequestPtrC921_B04
    ret

Jump_004_715D::
    ld hl, $078C
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC836
; writes: wC836
Func_004_7164:: ; heuristic: target of a pointer table; C0
    ld de, $0164
    call TestFlagBit
    jr c, Jump_004_719E
    ld de, $0163
    call TestFlagBit
    jr c, Jump_004_717B
    ld hl, $6416
    call SetRequestPtrC91A_B04
    ret

Jump_004_717B::
    call Func_004_7C37
    jr c, Jump_004_7187
    ld hl, $077B
    call SetRequestPtrC921_B04
    ret

Jump_004_7187::
    ld [hl], $3C
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $077A
    call SetRequestPtrC921_B04
    ld de, $0164
    call SetFlagBit
    ret

Jump_004_719E::
    ld hl, $077C
    call SetRequestPtrC921_B04
    ret
    db $21, $B7, $07, $CD, $BB, $55, $C9

; no direct call (reached through a table, a jump or a vector)
Func_004_71AC:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71BB
    ld hl, $078F
    call SetRequestPtrC921_B04
    ret

Jump_004_71BB::
    ld hl, $0CE2
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_71C2:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71E0
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_71D9
    ld hl, $0790
    call SetRequestPtrC921_B04
    ret

Jump_004_71D9::
    ld hl, $07C6
    call SetRequestPtrC921_B04
    ret

Jump_004_71E0::
    ld hl, $0CE3
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_71E7:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_71F6
    ld hl, $0791
    call SetRequestPtrC921_B04
    ret

Jump_004_71F6::
    ld hl, $0CE4
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_71FD:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_720C
    ld hl, $0792
    call SetRequestPtrC921_B04
    ret

Jump_004_720C::
    ld hl, $0CE5
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7213:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7231
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_722A
    ld hl, $0793
    call SetRequestPtrC921_B04
    ret

Jump_004_722A::
    ld hl, $07C7
    call SetRequestPtrC921_B04
    ret

Jump_004_7231::
    ld hl, $0CE6
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7238:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7247
    ld hl, $0794
    call SetRequestPtrC921_B04
    ret

Jump_004_7247::
    ld hl, $0CE7
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6
Func_004_724E:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_72B5
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_72AE
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_7291
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7275
    ld hl, $6430
    call SetRequestPtrC91A_B04
    ret

Jump_004_7275::
    ld de, $01B2
    call TestFlagBit
    jr c, Jump_004_728A
    ld hl, $07A4
    call SetRequestPtrC921_B04
    ld de, $01B2
    call SetFlagBit
    ret

Jump_004_728A::
    ld hl, $07A5
    call SetRequestPtrC921_B04
    ret

Jump_004_7291::
    ld a, $3D
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_004_728A
    farcall Func_012_7DF1
    ld hl, $64CA
    call SetRequestPtrC91A_B04
    ret

Jump_004_72AE::
    ld hl, $07CE
    call SetRequestPtrC921_B04
    ret

Jump_004_72B5::
    ld hl, $0CE8
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC836
; writes: wC836
Func_004_72BC:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_730E
    ld de, $01BF
    call TestFlagBit
    jr c, Jump_004_7307
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_72EA
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_72E3
    ld hl, $6437
    call SetRequestPtrC91A_B04
    ret

Jump_004_72E3::
    ld hl, $07A6
    call SetRequestPtrC921_B04
    ret

Jump_004_72EA::
    call Func_004_7C37
    jr c, Jump_004_72F6
    ld hl, $64DC
    call SetRequestPtrC91A_B04
    ret

Jump_004_72F6::
    ld [hl], $0B
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $64E3
    call SetRequestPtrC91A_B04
    ret

Jump_004_7307::
    ld hl, $07D3
    call SetRequestPtrC921_B04
    ret

Jump_004_730E::
    ld hl, $0CE9
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7315:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7342
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_733B
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7334
    ld hl, $0799
    call SetRequestPtrC921_B04
    ret

Jump_004_7334::
    ld hl, $07A7
    call SetRequestPtrC921_B04
    ret

Jump_004_733B::
    ld hl, $07D4
    call SetRequestPtrC921_B04
    ret

Jump_004_7342::
    ld hl, $0CEA
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7349:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7376
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_736F
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_7368
    ld hl, $079A
    call SetRequestPtrC921_B04
    ret

Jump_004_7368::
    ld hl, $07A8
    call SetRequestPtrC921_B04
    ret

Jump_004_736F::
    ld hl, $07D5
    call SetRequestPtrC921_B04
    ret

Jump_004_7376::
    ld hl, $0CEB
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_737D:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_739B
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_7394
    ld hl, $079B
    call SetRequestPtrC921_B04
    ret

Jump_004_7394::
    ld hl, $07C8
    call SetRequestPtrC921_B04
    ret

Jump_004_739B::
    ld hl, $0CEC
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_73A2:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_73C0
    ld de, $01BC
    call TestFlagBit
    jr c, Jump_004_73B9
    ld hl, $079C
    call SetRequestPtrC921_B04
    ret

Jump_004_73B9::
    ld hl, $07C9
    call SetRequestPtrC921_B04
    ret

Jump_004_73C0::
    ld hl, $0CED
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7FB, wDataBank
Func_004_73C7:: ; heuristic: target of a pointer table; C0
    ld a, $11
    ld [wD7FB], a
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_643E
    call SetRequestPtrC91A_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFF8E
; writes: wCB86, wDataBank
Func_004_73D8:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wCB86], a
    ldh a, [hFF8E]
    cp a, $30
    jr z, Jump_004_73E7
    ld a, $01
    ld [wCB86], a

Jump_004_73E7::
    ld hl, $6445
    call SetRequestPtrC91A_B04
    ld a, $10
    ld [wDataBank], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_73F3:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7411
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_740A
    ld hl, $079F
    call SetRequestPtrC921_B04
    ret

Jump_004_740A::
    ld hl, $07D6
    call SetRequestPtrC921_B04
    ret

Jump_004_7411::
    ld hl, $0CEE
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7418:: ; heuristic: target of a pointer table; C0
    ld de, $01C5
    call TestFlagBit
    jr c, Jump_004_7481
    ld de, $01C4
    call TestFlagBit
    jr c, Jump_004_747A
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7473
    ld de, $01C1
    call TestFlagBit
    jr c, Jump_004_746C
    ld de, $01C0
    call TestFlagBit
    jr c, Jump_004_7465
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_745E
    ld de, $01B0
    call TestFlagBit
    jr c, Jump_004_7457
    ld hl, $644C
    call SetRequestPtrC91A_B04
    ret

Jump_004_7457::
    ld hl, $6469
    call SetRequestPtrC91A_B04
    ret

Jump_004_745E::
    ld hl, $07D7
    call SetRequestPtrC921_B04
    ret

Jump_004_7465::
    ld hl, $6501
    call SetRequestPtrC91A_B04
    ret

Jump_004_746C::
    ld hl, $07DD
    call SetRequestPtrC921_B04
    ret

Jump_004_7473::
    ld hl, $654C
    call SetRequestPtrC91A_B04
    ret

Jump_004_747A::
    ld hl, $0CF1
    call SetRequestPtrC921_B04
    ret

Jump_004_7481::
    ld de, $01C6
    call TestFlagBit
    jr c, Jump_004_7490
    ld hl, $6558
    call SetRequestPtrC91A_B04
    ret

Jump_004_7490::
    ld hl, $6578
    call SetRequestPtrC91A_B04
    ret
    db $21, $A9, $07, $CD, $BB, $55, $C9

; no direct call (reached through a table, a jump or a vector)
Func_004_749E:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_74CB
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_74C4
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_74BD
    ld hl, $07AA
    call SetRequestPtrC921_B04
    ret

Jump_004_74BD::
    ld hl, $07C0
    call SetRequestPtrC921_B04
    ret

Jump_004_74C4::
    ld hl, $07D8
    call SetRequestPtrC921_B04
    ret

Jump_004_74CB::
    ld hl, $0CF2
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_74D2:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_74FF
    ld de, $01BE
    call TestFlagBit
    jr c, Jump_004_74F8
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_74F1
    ld hl, $6481
    call SetRequestPtrC91A_B04
    ret

Jump_004_74F1::
    ld hl, $07C1
    call SetRequestPtrC921_B04
    ret

Jump_004_74F8::
    ld hl, $07D9
    call SetRequestPtrC921_B04
    ret

Jump_004_74FF::
    ld hl, $0CF3
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7506:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_7533
    ld de, $01C0
    call TestFlagBit
    jr c, Jump_004_752C
    ld de, $01BB
    call TestFlagBit
    jr c, Jump_004_7525
    ld hl, $07AE
    call SetRequestPtrC921_B04
    ret

Jump_004_7525::
    ld hl, $07C2
    call SetRequestPtrC921_B04
    ret

Jump_004_752C::
    ld hl, $07DB
    call SetRequestPtrC921_B04
    ret

Jump_004_7533::
    ld hl, $0CF4
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCC3F
; writes: wCC3F
Func_004_753A:: ; heuristic: target of a pointer table; C0
    ld de, $01BE
    call TestFlagBit
    jp c, Jump_004_75FF
    ld de, $01BD
    call TestFlagBit
    jp c, Jump_004_75F8
    ld de, $01BB
    call TestFlagBit
    jp c, Jump_004_75F1
    ld de, $01B1
    call TestFlagBit
    jr c, Jump_004_75A3
    ld de, $01B3
    call TestFlagBit
    jr c, Jump_004_7572
    ld hl, $07AF
    call SetRequestPtrC921_B04
    ld de, $01B3
    call SetFlagBit
    ret

Jump_004_7572::
    ld de, $01B4
    call TestFlagBit
    jr c, Jump_004_7587
    ld hl, $07B0
    call SetRequestPtrC921_B04
    ld de, $01B4
    call SetFlagBit
    ret

Jump_004_7587::
    ld de, $01B5
    call TestFlagBit
    jr c, Jump_004_759C
    ld hl, $07B1
    call SetRequestPtrC921_B04
    ld de, $01B5
    call SetFlagBit
    ret

Jump_004_759C::
    ld hl, $07B2
    call SetRequestPtrC921_B04
    ret

Jump_004_75A3::
    ld de, $01B6
    call TestFlagBit
    jr c, Jump_004_75B8
    ld hl, $07B3
    call SetRequestPtrC921_B04
    ld de, $01B6
    call SetFlagBit
    ret

Jump_004_75B8::
    ld de, $01B7
    call TestFlagBit
    jr c, Jump_004_75CD
    ld hl, $07B4
    call SetRequestPtrC921_B04
    ld de, $01B7
    call SetFlagBit
    ret

Jump_004_75CD::
    ld de, $01B8
    call TestFlagBit
    jr c, Jump_004_75E2
    ld hl, $07B5
    call SetRequestPtrC921_B04
    ld de, $01B8
    call SetFlagBit
    ret

Jump_004_75E2::
    ld de, $01B9
    call TestFlagBit
    jr c, Jump_004_759C
    ld hl, $648E
    call SetRequestPtrC91A_B04
    ret

Jump_004_75F1::
    ld hl, $64BE
    call SetRequestPtrC91A_B04
    ret

Jump_004_75F8::
    ld hl, $07C5
    call SetRequestPtrC921_B04
    ret

Jump_004_75FF::
    ld hl, $64ED
    call SetRequestPtrC91A_B04
    ld a, [wCC3F]
    set 0, a
    ld [wCC3F], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_760E:: ; heuristic: target of a pointer table; C0
    ld de, $01BA
    call TestFlagBit
    jr c, Jump_004_761D
    ld hl, $07B8
    call SetRequestPtrC921_B04
    ret

Jump_004_761D::
    ld hl, $07BA
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7624:: ; heuristic: target of a pointer table; C0
    ld de, $01BA
    call TestFlagBit
    jr c, Jump_004_7633
    ld hl, $6496
    call SetRequestPtrC91A_B04
    ret

Jump_004_7633::
    ld hl, $64A6
    call SetRequestPtrC91A_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC836
; writes: wC836
Func_004_763A:: ; heuristic: target of a pointer table; C0
    call Func_004_7C37
    jr c, Jump_004_7646
    ld hl, $07BF
    call SetRequestPtrC921_B04
    ret

Jump_004_7646::
    ld [hl], $3D
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld hl, $64B3
    call SetRequestPtrC91A_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_7657:: ; heuristic: target of a pointer table; C0
    ld de, $01C2
    call TestFlagBit
    jr c, Jump_004_7666
    ld hl, $6509
    call SetRequestPtrC91A_B04
    ret

Jump_004_7666::
    ld hl, $652C
    call SetRequestPtrC91A_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_766D:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wC921], a
    ld a, $0E
    ld [wC922], a
    ld de, $01C8
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_767E:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $01C9
    call SetRequestPtrC924FromDE_B04
    ret
    db $21, $FB, $0C, $CD, $BB, $55, $C9, $21, $FA, $0C, $CD, $BB, $55, $C9, $21, $FC
    db $0C, $CD, $BB, $55, $C9, $3E, $01, $EA, $21, $C9, $3E, $04, $EA, $22, $C9, $11
    db $CA, $01, $CD, $DF, $55, $C9, $21, $FD, $0C, $CD, $BB, $55, $C9

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_76BC:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $08
    ld [wC922], a
    ld de, $01CB
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
Func_004_76CD:: ; heuristic: target of a pointer table; C0
    ld de, $01C3
    call TestFlagBit
    jr c, Jump_004_76DC
    ld hl, $0CFE
    call SetRequestPtrC921_B04
    ret

Jump_004_76DC::
    ld hl, $00A1
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_76E3:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $01CC
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_76F4:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $01CD
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7705:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $23
    ld [wC922], a
    ld de, $01CE
    call SetRequestPtrC924FromDE_B04
    ret
    db $21, $95, $65, $CD, $03, $56, $C9, $21, $03, $0C, $CD, $BB, $55, $C9, $21, $02
    db $0C, $CD, $BB, $55, $C9, $11, $D3, $01, $CD, $1B, $18, $38, $0D, $21, $00, $0C
    db $CD, $BB, $55, $11, $D3, $01, $CD, $45, $18, $C9, $21, $01, $0C, $CD, $BB, $55
    db $C9, $21, $9C, $65, $CD, $03, $56, $C9

; no direct call (reached through a table, a jump or a vector)
Func_004_774E:: ; heuristic: target of a pointer table; C0
    ld de, $016E
    call TestFlagBit
    jr c, Jump_004_775D
    ld hl, $659C
    call SetRequestPtrC91A_B04
    ret

Jump_004_775D::
    ld hl, $0C17
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7764:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $01D5
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7775:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $48
    ld [wC922], a
    ld de, $01D6
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7786:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $0A
    ld [wC922], a
    ld de, $01D8
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7797:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $01DA
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_77A8:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $51
    ld [wC922], a
    ld de, $01DB
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_77B9:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $01DC
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_77CA:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $01DE
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_77DB:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $44
    ld [wC922], a
    ld de, $01DF
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_77EC:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $0169
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_77FD:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $016B
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_780E:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5F
    ld [wC922], a
    ld de, $016C
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_781F:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $4E
    ld [wC922], a
    ld de, $016D
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7830:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $4C
    ld [wC922], a
    ld de, $016F
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7841:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $4D
    ld [wC922], a
    ld de, $0170
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7852:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $0171
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7863:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $0172
    call SetRequestPtrC924FromDE_B04
    ret
    db $21, $9E, $65, $CD, $03, $56, $C9, $21, $1B, $0C, $CD, $BB, $55, $C9, $21, $1A
    db $0C, $CD, $BB, $55, $C9, $11, $73, $01, $CD, $1B, $18, $38, $0D, $21, $18, $0C
    db $CD, $BB, $55, $11, $73, $01, $CD, $45, $18, $C9, $21, $19, $0C, $CD, $BB, $55
    db $C9, $21, $9C, $65, $CD, $03, $56, $C9

; no direct call (reached through a table, a jump or a vector)
Func_004_78AC:: ; heuristic: target of a pointer table; C0
    ld de, $00D9
    call TestFlagBit
    jr c, Jump_004_78BB
    ld hl, $659C
    call SetRequestPtrC91A_B04
    ret

Jump_004_78BB::
    ld hl, $0C2F
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_78C2:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $0A
    ld [wC922], a
    ld de, $0175
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_78D3:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $4A
    ld [wC922], a
    ld de, $0176
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_78E4:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $0177
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_78F5:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $0179
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7906:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $09
    ld [wC922], a
    ld de, $017A
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7917:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $61
    ld [wC922], a
    ld de, $017B
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7928:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $017D
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7939:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $52
    ld [wC922], a
    ld de, $017E
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_794A:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $07
    ld [wC922], a
    ld de, $017F
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_795B:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $46
    ld [wC922], a
    ld de, $00D6
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_796C:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $00D7
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_797D:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $60
    ld [wC922], a
    ld de, $00D8
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_798E:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $00DA
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_799F:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $4F
    ld [wC922], a
    ld de, $00DB
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_79B0:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5D
    ld [wC922], a
    ld de, $00DC
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_79C1:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $06
    ld [wC922], a
    ld de, $00DD
    call SetRequestPtrC924FromDE_B04
    ret
    db $21, $33, $0C, $CD, $BB, $55, $C9, $21, $32, $0C, $CD, $BB, $55, $C9, $11, $DE
    db $00, $CD, $1B, $18, $38, $0D, $21, $30, $0C, $CD, $BB, $55, $11, $DE, $00, $CD
    db $45, $18, $C9, $21, $31, $0C, $CD, $BB, $55, $C9, $21, $9C, $65, $CD, $03, $56
    db $C9

; no direct call (reached through a table, a jump or a vector)
Func_004_7A03:: ; heuristic: target of a pointer table; C0
    ld de, $01F6
    call TestFlagBit
    jr c, Jump_004_7A12
    ld hl, $659C
    call SetRequestPtrC91A_B04
    ret

Jump_004_7A12::
    ld hl, $0C47
    call SetRequestPtrC921_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A19:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $00F5
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A2A:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5C
    ld [wC922], a
    ld de, $00F6
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A3B:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $03
    ld [wC922], a
    ld de, $00F7
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A4C:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2C
    ld [wC922], a
    ld de, $00F9
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A5D:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $45
    ld [wC922], a
    ld de, $00FA
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A6E:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $47
    ld [wC922], a
    ld de, $00FB
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A7F:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5A
    ld [wC922], a
    ld de, $00FD
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7A90:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5B
    ld [wC922], a
    ld de, $00FE
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7AA1:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $00FF
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7AB2:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $50
    ld [wC922], a
    ld de, $01F3
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7AC3:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $4B
    ld [wC922], a
    ld de, $01F4
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7AD4:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $2A
    ld [wC922], a
    ld de, $01F5
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7AE5:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $01
    ld [wC922], a
    ld de, $01F7
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7AF6:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $5E
    ld [wC922], a
    ld de, $01F8
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7B07:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $49
    ld [wC922], a
    ld de, $01F9
    call SetRequestPtrC924FromDE_B04
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921, wC922
Func_004_7B18:: ; heuristic: target of a pointer table; C0
    ld a, $00
    ld [wC921], a
    ld a, $02
    ld [wC922], a
    ld de, $01FA
    call SetRequestPtrC924FromDE_B04
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC916
Func_004_7B29::
    ld a, [wC916]
    rst $00
    dw Jump_004_7B3F
    dw Jump_004_7B46
    dw Jump_004_7B82
    dw Jump_004_7BF7
    dw Jump_004_7BFE
    dw Jump_004_7C05
    dw Jump_004_7C0C
    dw Jump_004_7C1F
    dw Jump_004_7C2B

Jump_004_7B3F::
    ld hl, $5133
    call SetRequestPtrC91A_B04
    ret

Jump_004_7B46::
    ld a, $10
    ld [wDataBank], a
    ld a, [wCC45]
    add a, a
    add a, a
    push af
    ld hl, wCD89
    add a, l
    ld l, a
    jr nc, Jump_004_7B59
    inc h

Jump_004_7B59::
    ld a, [hl]
    cp a, $03
    jr nz, Jump_004_7B6B
    pop af
    ld a, $0F
    ld [wD7FB], a
    ld hl, $65A3
    call SetRequestPtrC91A_B04
    ret

Jump_004_7B6B::
    pop af
    add a, a
    ld hl, wCDAC
    ld a, $12
    bit 7, [hl]
    jr z, Jump_004_7B78
    ld a, $13

Jump_004_7B78::
    ld [wD7FB], a
    ld hl, $65A3
    call SetRequestPtrC91A_B04
    ret

Jump_004_7B82::
    ld a, [wCC44]
    cp a, $84
    jr nz, Jump_004_7B91
    ld hl, $65AA
    call SetRequestPtrC91A_B04
    jr Jump_004_7B9C

Jump_004_7B91::
    call Func_004_7BAB
    or a, a
    ret z
    ld hl, $65B1
    call SetRequestPtrC91A_B04

Jump_004_7B9C::
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld a, $10
    ld [wDataBank], a
    ret

; 1 call site from 1 routine (e.g. Func_004_7B29)
; reads: wCD0B, hFF8F, hFF8E
Func_004_7BAB::
    ld a, [wCD0B]
    cp a, $01
    jr nz, Jump_004_7BC3
    ldh a, [hFF8F]
    or a, a
    jr nz, Jump_004_7BF5
    ldh a, [hFF8E]
    cp a, $40
    jr z, Jump_004_7BF2
    cp a, $20
    jr z, Jump_004_7BF2
    jr Jump_004_7BF5

Jump_004_7BC3::
    cp a, $07
    jr nz, Jump_004_7BD4
    ldh a, [hFF8F]
    or a, a
    jr nz, Jump_004_7BF5
    ldh a, [hFF8E]
    cp a, $40
    jr z, Jump_004_7BF2
    jr Jump_004_7BF5

Jump_004_7BD4::
    cp a, $08
    jr nz, Jump_004_7BE9
    ldh a, [hFF8F]
    or a, a
    jr nz, Jump_004_7BF5
    ldh a, [hFF8E]
    cp a, $10
    jr z, Jump_004_7BF2
    cp a, $30
    jr z, Jump_004_7BF2
    jr Jump_004_7BF5

Jump_004_7BE9::
    cp a, $09
    jr nz, Jump_004_7BF5
    ldh a, [hFF8F]
    or a, a
    jr z, Jump_004_7BF5

Jump_004_7BF2::
    ld a, $01
    ret

Jump_004_7BF5::
    xor a, a
    ret

Jump_004_7BF7::
    ld hl, $5135
    call SetRequestPtrC91A_B04
    ret

Jump_004_7BFE::
    ld hl, $0120
    call SetRequestPtrC921_B04
    ret

Jump_004_7C05::
    ld hl, $0122
    call SetRequestPtrC921_B04
    ret

Jump_004_7C0C::
    ld a, [wCD0B]
    cp a, $05
    ret z
    cp a, $07
    ret z
    cp a, $08
    ret z
    ld hl, $0121
    call SetRequestPtrC921_B04
    ret

Jump_004_7C1F::
    ld a, $10
    ld [wDataBank], a
    ld hl, Data_010_65AA
    call SetRequestPtrC91A_B04
    ret

Jump_004_7C2B::
    ld a, $1F
    ld [wDataBank], a
    ld hl, Data_01F_65B8
    call SetRequestPtrC91A_B04
    ret

; 6 call sites from 5 routines (e.g. Func_004_5D14, Func_004_6F9A, Func_004_763A, Func_004_72BC, ...)
; reads: wC634
; points at: wC61D
Func_004_7C37::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_004_7C43
    or a, a
    jr z, Jump_004_7C43
    sub a, a
    ret

Jump_004_7C43::
    ld hl, wC61D

Jump_004_7C46::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_004_7C51
    or a, a
    jr z, Jump_004_7C51
    inc hl
    jr Jump_004_7C46

Jump_004_7C51::
    scf
    ret
    ds $3AD, $00
