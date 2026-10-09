SECTION "Bank 00", ROM0[$0000]

Func_000_0000::
    pop hl
    push de
    ld e, a
    ld d, $00
    sla e
    rl d
    add hl, de
    pop de

Func_000_000B::
    ld a, [hl+]
    ld h, [hl]
    ld l, a

Func_000_000E::
    jp hl
    db $00

Func_000_0010::
    ld a, [$4000]
    push af
    ld a, b
    ld [$2100], a
    call Func_000_000E
    pop af
    ld [$2100], a
    ret
    ds $10, $00

Func_000_0030::
    ret
    db $00, $00, $00, $00, $00, $00, $00

Func_000_0038::
    ret
    db $00, $00, $00, $00, $00, $00, $00

Func_000_0040::
    di
    jp Jump_000_03A4
    db $00, $00, $00, $00

Func_000_0048::
    jp Jump_000_256A
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Func_000_0058::
    jp Jump_000_255B
    db $D9
    ds $24, $00

Func_000_0080::
    ld c, $80
    ld b, $0A
    ld hl, $008E

Jump_000_0087::
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_0087
    ret

Func_000_008E:: ; heuristic: follows a terminator; C0
    ld a, $C0
    ldh [$FF46], a
    ld a, $28

Jump_000_0094::
    dec a
    jr nz, Jump_000_0094
    ret
    ds $68, $00

Func_000_0100::
    nop
    jp Func_000_0150
    INCBIN "dwm2-cobi-us.gbc", $000104, $4C

Func_000_0150::
    cp a, $11
    ld a, $00
    jr nz, Jump_000_0157
    inc a

Jump_000_0157::
    ld [$C525], a

Jump_000_015A::
    di
    ld sp, $DFFF
    call Func_000_078D
    call Func_000_08D0
    call Func_000_0080
    ld hl, $8000
    ld bc, $1C00
    xor a, a
    call Func_000_0949
    ld a, [$C525]
    or a, a
    jr z, Jump_000_0189
    ld a, $01
    ldh [$FF4F], a
    ld hl, $9800
    ld bc, $0800
    xor a, a
    call Func_000_0949
    ld a, $00
    ldh [$FF4F], a

Jump_000_0189::
    ld hl, $C5DB
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $05
    ld [$C5DB], a
    ld a, $00
    ld [$4100], a
    ld a, $00
    ld [$0100], a
    ld a, $01
    ld [$2100], a
    ld a, $00
    ld [$3100], a
    ld a, $01
    ld [$C524], a
    ld a, $FF
    ld [$C60A], a
    ld [$C60B], a
    call Func_000_3290
    xor a, a
    ld [$C58C], a
    ld a, [$C525]
    or a, a
    jr z, Jump_000_01D3
    xor a, a
    ldh [$FF4F], a
    ldh [$FF70], a
    ldh [$FF56], a
    ld hl, $42FA
    ld b, $02
    rst $10
    jr Jump_000_01D8

Jump_000_01D3::
    call Func_000_05E2
    jr c, Jump_000_01DF

Jump_000_01D8::
    xor a, a
    ld [$C524], a
    jp Jump_000_02D1

Jump_000_01DF::
    ld bc, $000C
    call Func_000_0692
    ld a, $14
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $02
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $03
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $04
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $05
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $06
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $07
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $08
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $09
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $0C
    ld bc, $0800
    ld e, $6C
    ld d, $44
    ld h, $17
    call Func_000_0705
    call Func_000_05D1
    ld a, $0D
    ld e, $8C
    ld d, $44
    ld b, $17
    call Func_000_06A8
    call Func_000_05D1
    ld a, $12
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $0A
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $13
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $0E
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ld a, $01
    ld [$C524], a
    ld a, $FF
    ld [$C523], a
    xor a, a
    ld [$C51F], a
    ld [$C520], a
    ld hl, $41CF
    ld b, $17
    rst $10

Jump_000_02D1::
    ei

Jump_000_02D2::
    call Func_000_0930
    call Func_000_0BA7
    call Func_000_0B7F
    call Func_000_0B9B
    call Func_000_0DCA
    xor a, a
    ld [$C586], a
    ld [$C52B], a
    ld [$C52F], a
    ld [$C530], a
    call Func_000_0355
    xor a, a
    ld [$C5DF], a
    ld [$C5E0], a
    ld [$C5EE], a
    ld [$C0C0], a
    ld [$C0C1], a
    ld [$C0D8], a
    ld [$C0D9], a
    ld [$C5ED], a
    ld [$C5F0], a
    ld [$C5F1], a
    ldh [$FFB9], a
    ld a, $80
    ldh [$FFBA], a
    xor a, a
    ld [$C58D], a
    ld [$C58E], a
    ld hl, $C604
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_000_0324::
    ld a, [$C58A]
    or a, a
    call z, Func_000_095B
    halt
    nop
    ld a, [$C5DF]
    or a, a
    jr z, Jump_000_0324
    ld a, [$C56C]
    or a, a
    jr z, Jump_000_033D
    bit 7, a
    jr z, Jump_000_0324

Jump_000_033D::
    di
    call Func_000_078D
    call Func_000_05D1
    ld a, $00
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    jp Jump_000_02D2

Func_000_0355::
    ld a, [$C5DB]
    rst $00
    dw Jump_000_036B
    dw Jump_000_0372
    dw Jump_000_0379
    dw Jump_000_0380
    dw Jump_000_0381
    dw Jump_000_0388
    dw Jump_000_038F
    dw Jump_000_0396
    dw Jump_000_039D

Jump_000_036B::
    ld hl, $4001
    ld b, $01
    rst $10
    ret

Jump_000_0372::
    ld hl, $45C6
    ld b, $02
    rst $10
    ret

Jump_000_0379::
    ld hl, $4001
    ld b, $03
    rst $10
    ret

Jump_000_0380::
    ret

Jump_000_0381::
    ld hl, $4001
    ld b, $31
    rst $10
    ret

Jump_000_0388::
    ld hl, $486E
    ld b, $07
    rst $10
    ret

Jump_000_038F::
    ld hl, $4001
    ld b, $24
    rst $10
    ret

Jump_000_0396::
    ld hl, $4ECF
    ld b, $A0
    rst $10
    ret

Jump_000_039D::
    ld hl, $4001
    ld b, $F2
    rst $10
    ret

Jump_000_03A4::
    push af
    push bc
    push de
    push hl
    ldh a, [$FF70]
    ld b, a
    ld a, $00
    ldh [$FF70], a
    push bc
    ldh a, [$FF4F]
    push af
    ld hl, $C5ED
    bit 0, [hl]
    jp nz, Jump_000_046B
    set 0, [hl]
    call $FF80
    ld a, [$C525]
    or a, a
    jr z, Jump_000_03EA
    ld a, [$C56C]
    or a, a
    jr nz, Jump_000_03EA
    ld hl, $C526
    ld a, [hl]
    inc hl
    or a, [hl]
    jr z, Jump_000_03EA
    ld a, [$C526]
    or a, a
    call nz, Func_000_0829
    xor a, a
    ld [$C526], a
    ld a, [$C527]
    or a, a
    call nz, Func_000_085C
    xor a, a
    ld [$C527], a

Jump_000_03EA::
    call Func_000_0BCC
    call Func_000_07FD
    call Func_000_07E0
    call Func_000_04ED
    call Func_000_07F1
    ld a, [$C58A]
    and a, a
    jr nz, Jump_000_042E
    ei
    call Func_000_0A17
    call Func_000_0A8D
    call Func_000_33E8
    call Func_000_09F3
    call Func_000_131A
    call Func_000_0474
    ld a, [$C52B]
    or a, a
    call nz, Func_000_2620
    call Func_000_0F4E
    ld a, [$C5F0]
    add a, $01
    ld [$C5F0], a
    ld a, [$C5F1]
    adc a, $00
    ld [$C5F1], a
    jr Jump_000_043A

Jump_000_042E::
    call Func_000_33E8
    ei
    call Func_000_131A
    call Func_000_0474
    jr Jump_000_043A

Jump_000_043A::
    ld a, [$C56C]
    or a, a
    jr nz, Jump_000_0456
    ld a, [$C55E]
    and a, $0F
    cp a, $0F
    jr nz, Jump_000_0450
    ld a, [$C58A]
    or a, a
    jp z, Jump_000_015A

Jump_000_0450::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_000_0456

Jump_000_0456::
    ld hl, $C5ED
    res 0, [hl]

Jump_000_045B::
    pop af
    ldh [$FF4F], a
    ldh a, [$FF44]
    ld [$C5D7], a
    pop af
    ldh [$FF70], a
    pop hl
    pop de
    pop bc
    pop af
    reti

Jump_000_046B::
    call Func_000_07F1
    call Func_000_33E8
    ei
    jr Jump_000_045B

Func_000_0474::
    xor a, a
    ldh [$FFB1], a
    call Func_000_252D
    call Func_000_048A
    ld a, [$C56C]
    or a, a
    jr z, Jump_000_0486
    bit 7, a
    ret z

Jump_000_0486::
    call Func_000_0BB4
    ret

Func_000_048A::
    ld a, [$C5DF]
    or a, a
    ret nz
    ld a, [$C58A]
    or a, a
    jr nz, Jump_000_049E
    ld a, [$C56C]
    or a, a
    jr z, Jump_000_049E
    bit 7, a
    ret z

Jump_000_049E::
    ld a, [$C5DB]
    rst $00
    dw Jump_000_04B4
    dw Jump_000_04BB
    dw Jump_000_04C2
    dw Jump_000_04C9
    dw Jump_000_04CA
    dw Jump_000_04D1
    dw Jump_000_04D8
    dw Jump_000_04DF
    dw Jump_000_04E6

Jump_000_04B4::
    ld hl, $4AD4
    ld b, $01
    rst $10
    ret

Jump_000_04BB::
    ld hl, $4AD8
    ld b, $02
    rst $10
    ret

Jump_000_04C2::
    ld hl, $4015
    ld b, $03
    rst $10
    ret

Jump_000_04C9::
    ret

Jump_000_04CA::
    ld hl, $40A5
    ld b, $31
    rst $10
    ret

Jump_000_04D1::
    ld hl, $4F7B
    ld b, $07
    rst $10
    ret

Jump_000_04D8::
    ld hl, $4117
    ld b, $24
    rst $10
    ret

Jump_000_04DF::
    ld hl, $4F70
    ld b, $A0
    rst $10
    ret

Jump_000_04E6::
    ld hl, $40A2
    ld b, $F2
    rst $10
    ret

Func_000_04ED::
    ld hl, $C604
    ld b, [hl]
    inc hl
    or a, [hl]
    ret z
    ld a, [$C604]
    or a, a
    jr z, Jump_000_0511
    dec a
    ld [$C604], a
    ldh a, [$FF42]
    ld b, a
    ld a, [$C604]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, Jump_000_050E
    xor a, $07

Jump_000_050E::
    add a, b
    ldh [$FF42], a

Jump_000_0511::
    ld a, [$C605]
    or a, a
    jr z, Jump_000_0530
    dec a
    ld [$C605], a
    ldh a, [$FF43]
    ld b, a
    ld a, [$C605]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, Jump_000_052B
    xor a, $07

Jump_000_052B::
    sub a, $04
    add a, b
    ldh [$FF43], a

Jump_000_0530::
    ret
    db $CD, $CC, $0B, $C9

Func_000_0535::
    ld a, [$C58A]
    or a, a
    ret z
    ld a, [$C58D]
    add a, $01
    ld [$C58D], a
    ld a, [$C58E]
    adc a, $00
    ld [$C58E], a
    or a, a
    jp nz, Jump_000_015A
    ld a, [$C57F]
    bit 1, a
    ret nz
    ld a, [$C581]
    cp a, $05
    jr nz, Jump_000_0563
    ld a, [$C5ED]
    bit 1, a
    ret nz
    jr Jump_000_057C

Jump_000_0563::
    ld a, [$C5ED]
    bit 1, a
    jr nz, Jump_000_0574
    bit 2, a
    jr nz, Jump_000_0574
    bit 7, a
    jr nz, Jump_000_0574
    jr Jump_000_057C

Jump_000_0574::
    xor a, a
    ld [$C56A], a
    ld [$C56B], a
    ret

Jump_000_057C::
    ld a, [$C55E]
    ld [$C56A], a
    ld a, [$C55F]
    ld [$C56B], a
    call Func_000_0A17
    ld a, [$C594]
    cp a, $FF
    jr z, Jump_000_059D
    ld a, $00
    ld [$C582], a
    ld a, [$C594]
    jp Func_000_08AD

Jump_000_059D::
    ld hl, $C592
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_000_05C7
    ld a, [$C595]
    ld l, a
    ld a, [$C596]
    ld h, a
    push hl
    ld a, [$C595]
    add a, $01
    ld [$C595], a
    ld a, [$C596]
    adc a, $00
    ld [$C596], a
    pop hl
    ld a, $00
    ld [$C582], a
    ld a, [hl]
    jp Func_000_08AD

Jump_000_05C7::
    ld a, $00
    ld [$C582], a
    ld a, $F0
    jp Func_000_08AD

Func_000_05D1::
    ld a, [$C524]
    or a, a
    ret z
    ld de, $1B58

Jump_000_05D9::
    nop
    nop
    nop
    dec de
    ld a, d
    or a, e
    jr nz, Jump_000_05D9
    ret

Func_000_05E2::
    ld a, $0B
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ldh a, [$FF00]
    and a, $03
    cp a, $03
    jr nz, Jump_000_0636
    ld a, $20
    ldh [$FF00], a
    ldh a, [$FF00]
    ldh a, [$FF00]
    ld a, $30
    ldh [$FF00], a
    ld a, $10
    ldh [$FF00], a
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ld a, $30
    ldh [$FF00], a
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    and a, $03
    cp a, $03
    jr nz, Jump_000_0636
    ld a, $0A
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    sub a, a
    ret

Jump_000_0636::
    ld a, $0A
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    scf
    ret

Func_000_0646::
    ldh a, [$FF00]
    ld b, $04
    ld c, a
    jr Jump_000_0651

Jump_000_064D::
    ldh a, [$FF00]
    cp a, c
    ret z

Jump_000_0651::
    cpl
    and a, $03
    sla a
    ld d, $00
    ld e, a
    ld hl, $C474
    add hl, de
    ld a, $20
    ldh [$FF00], a
    ldh a, [$FF00]
    ldh a, [$FF00]
    cpl
    and a, $0F
    swap a
    ld d, a
    ld a, $30
    ldh [$FF00], a
    ld a, $10
    ldh [$FF00], a
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    cpl
    and a, $0F
    or a, d
    ld d, a
    ld a, [hl+]
    xor a, d
    and a, d
    ld [hl-], a
    ld a, d
    ld [hl], a
    ld a, $30
    ldh [$FF00], a
    dec b
    jr nz, Jump_000_064D
    ret

Func_000_0692::
    ld a, [$C524]
    or a, a
    ret z

Jump_000_0697::
    ld de, $06D6

Jump_000_069A::
    nop
    nop
    nop
    dec de
    ld a, d
    or a, e
    jr nz, Jump_000_069A
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_0697
    ret

Func_000_06A8::
    ld [$C47C], a
    ld a, [$C524]
    or a, a
    ret z
    push bc
    call Func_000_0796
    call Func_000_0B9B
    xor a, a
    ldh [$FF43], a
    ldh [$FF42], a
    push de
    ld hl, $8800
    ld bc, $1000
    xor a, a
    call Func_000_0949
    pop de
    ld a, $E4
    ldh [$FF47], a
    pop bc
    ld hl, $8800
    call Func_000_0C5A
    ld hl, $9800
    ld de, $000C
    ld a, $80
    ld c, $0D

Jump_000_06DD::
    ld b, $14

Jump_000_06DF::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_000_06DF
    add hl, de
    dec c
    jr nz, Jump_000_06DD
    ld a, $81
    ldh [$FF40], a
    ld [$C5EC], a
    ld bc, $0005
    call Func_000_0692
    ld hl, $5040
    ld b, $1F
    rst $10
    ld bc, $0006
    call Func_000_0692
    call Func_000_0796
    ret

Func_000_0705::
    ld [$C47C], a
    ld a, [$C524]
    or a, a
    ret z
    push hl
    push bc
    call Func_000_0796
    call Func_000_0B9B
    xor a, a
    ldh [$FF43], a
    ldh [$FF42], a
    ld a, $E4
    ldh [$FF47], a
    pop bc
    pop hl
    ld a, [$4000]
    push af
    push bc
    ld a, h
    ld [$2100], a
    pop bc
    ld hl, $8800

Jump_000_072D::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_072D
    ld hl, $9800
    ld de, $000C
    ld a, $80
    ld c, $0D

Jump_000_073F::
    ld b, $14

Jump_000_0741::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_000_0741
    add hl, de
    dec c
    jr nz, Jump_000_073F
    ld a, $81
    ldh [$FF40], a
    ld [$C5EC], a
    ld bc, $0005
    call Func_000_0692
    ld hl, $5040
    ld b, $1F
    rst $10
    ld bc, $0006
    call Func_000_0692
    call Func_000_0796
    pop af
    ld [$2100], a
    ret

Func_000_076B::
    push hl
    push bc
    xor a, a
    ld hl, $C47F
    ld c, $10

Jump_000_0773::
    ld [hl+], a
    dec c
    jr nz, Jump_000_0773
    pop bc
    pop hl
    ret

Jump_000_077A::
    push af
    ld a, [$C58A]
    or a, a
    jr z, Jump_000_0784
    call Func_000_14D1

Jump_000_0784::
    call Func_000_07AA
    pop af
    call Func_000_07D8
    ei
    ret

Func_000_078D::
    xor a, a
    ldh [$FF0F], a
    ldh a, [$FFFF]
    and a, $E2
    ldh [$FFFF], a

Func_000_0796::
    ld hl, $FF40
    bit 7, [hl]
    ret z

Jump_000_079C::
    ldh a, [$FF44]
    cp a, $91
    jr nz, Jump_000_079C
    res 7, [hl]
    ld hl, $C5EC
    res 7, [hl]
    ret

Func_000_07AA::
    ld hl, $C5EC
    set 7, [hl]
    ld a, [hl]
    ldh [$FF40], a
    ld a, [$C524]
    or a, a
    ret z
    ld a, $01
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    call Func_000_05D1
    ret
    db $C9, $AF, $E0, $0F, $F0, $FF, $E6, $F7, $E0, $FF, $C9

Func_000_07D1::
    ldh a, [$FF02]
    bit 7, a
    jr nz, Func_000_07D1
    ret

Func_000_07D8::
    ld b, a
    xor a, a
    ldh [$FF0F], a
    ld a, b
    ldh [$FFFF], a
    ret

Func_000_07E0::
    ldh a, [$FFA1]
    ldh [$FF43], a
    ldh a, [$FFA5]
    ldh [$FF42], a
    ldh a, [$FF9F]
    ldh [$FF4B], a
    ldh a, [$FFA0]
    ldh [$FF4A], a
    ret

Func_000_07F1::
    ldh a, [$FF41]
    and a, $03
    jr nz, Func_000_07F1
    ld a, [$C5EC]
    ldh [$FF40], a
    ret

Func_000_07FD::
    ld hl, $C5E9
    ld a, [hl+]
    ldh [$FF47], a
    ld a, [hl+]
    ldh [$FF48], a
    ld a, [hl]
    ldh [$FF49], a
    ret

Func_000_080A:: ; heuristic: follows a terminator; C0
    ld a, [$C525]
    or a, a
    ret z
    ld a, [$4000]
    push af
    ld a, b
    ld [$2100], a
    ld b, $40

Jump_000_0819::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_000_0819
    ld b, $00
    add hl, bc
    ld [hl], $7F
    pop af
    ld [$2100], a
    ret

Func_000_0829::
    ld a, [$C526]
    bit 7, a
    jr z, Jump_000_0841
    ldh [$FF68], a
    call Func_000_0897
    ld a, l
    add a, $9F
    ld l, a
    ld a, h
    adc a, $C4
    ld h, a
    ld b, $08
    jr Jump_000_084F

Jump_000_0841::
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF68], a
    ei
    ld b, $40
    ld hl, $C49F

Jump_000_084F::
    ld c, $69

Jump_000_0851::
    di
    call Func_000_120A
    ld a, [hl+]
    ldh [c], a
    ei
    dec b
    jr nz, Jump_000_0851
    ret

Func_000_085C::
    ld a, [$C527]
    bit 7, a
    jr z, Jump_000_0876
    ldh [$FF6A], a
    call Func_000_0897
    ld a, l
    add a, $DF
    ld l, a
    ld a, h
    adc a, $C4
    ld h, a
    ld e, l
    ld d, h
    ld b, $08
    jr Jump_000_0884

Jump_000_0876::
    di
    call Func_000_120A
    ld a, $80
    ldh [$FF6A], a
    ei
    ld b, $40
    ld de, $C4DF

Jump_000_0884::
    ld hl, $FF6B

Jump_000_0887::
    ld a, [de]
    inc de
    ld c, a
    di

Jump_000_088B::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_088B
    ld [hl], c
    ei
    dec b
    jr nz, Jump_000_0887
    ret

Func_000_0897::
    res 7, a
    and a, $38
    ld l, a
    ld h, $00
    ret

Func_000_089F:: ; heuristic: follows a terminator; C0
    ldh a, [$FF41]
    or a, $40
    ldh [$FF41], a
    ret

Func_000_08A6::
    ldh a, [$FF41]
    and a, $07
    ldh [$FF41], a
    ret

Func_000_08AD::
    di
    call Func_000_08C7
    ld hl, $FF02
    set 0, [hl]
    set 7, [hl]
    ei
    ret

Func_000_08BA::
    di
    call Func_000_08C7
    ld hl, $FF02
    res 0, [hl]
    set 7, [hl]
    ei
    ret

Func_000_08C7::
    ld b, a
    ld a, $00
    ldh [$FF02], a
    ld a, b
    ldh [$FF01], a
    ret

Func_000_08D0::
    ld a, [$C525]
    or a, a
    jr z, Jump_000_08EC
    xor a, a
    ldh [$FF4F], a
    ldh [$FF70], a
    ldh [$FF51], a
    ldh [$FF52], a
    ldh [$FF53], a
    ldh [$FF54], a
    ldh [$FF55], a
    ldh [$FF68], a
    ldh [$FF6A], a
    ld a, [$C525]

Jump_000_08EC::
    push af
    ld hl, $C000
    ld bc, $1E00
    ld a, $00
    call Func_000_0949
    ld hl, $FF8A
    ld bc, $0074
    ld a, $00
    call Func_000_0949
    pop af
    ld [$C525], a
    ld a, $0A
    ld [$0100], a
    ld a, $02
    ld [$4100], a
    xor a, a
    ld hl, $A000
    ld bc, $2000
    call Func_000_0949
    ld a, $00
    ld [$4100], a
    xor a, a
    ld hl, $A000
    ld bc, $2000
    call Func_000_0949
    ld a, $00
    ld [$0100], a
    ret

Func_000_0930::
    ld hl, $9800
    ld bc, $0800
    ld a, [$D066]
    or a, a
    jr z, Jump_000_0945
    xor a, a
    ld [$D066], a
    ld bc, $0400
    ld a, $C3

Jump_000_0945::
    call Func_000_0949
    ret

Func_000_0949::
    ld d, a

Jump_000_094A::
    ld [hl], d
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_094A
    ret

Func_000_0952::
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Func_000_0952
    ret

Func_000_095B::
    push hl
    ld a, [$C5E8]
    inc a
    and a, $7F
    ld [$C5E8], a
    ld hl, $0973
    add a, l
    ld l, a
    jr nc, Jump_000_096D
    inc h

Jump_000_096D::
    ld a, [hl]
    ld [$C5E7], a
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $000973, $80

Func_000_09F3::
    push hl
    push bc
    ld a, [$CD03]
    ld l, a
    ld a, [$CD04]
    ld h, a
    ld c, l
    ld b, h
    sla l
    rl h
    sla l
    rl h
    add hl, bc
    ld a, $0B
    add a, l
    ld [$CD03], a
    ld a, h
    adc a, $00
    ld [$CD04], a
    pop bc
    pop hl
    ret

Func_000_0A17::
    ld a, [$C524]
    or a, a
    jr z, Jump_000_0A39
    call Func_000_0646
    ld a, [$C55E]
    ld [$C55F], a
    ld a, [$C474]
    ld [$C55E], a
    ld a, [$C560]
    ld [$C561], a
    ld a, [$C476]
    ld [$C560], a
    ret

Jump_000_0A39::
    xor a, a
    ld [$C55D], a
    call Func_000_0A61
    ld a, [$C55E]
    ld [$C55F], a
    ld a, b
    ld [$C55E], a
    ld a, $30
    ldh [$FF00], a
    ret

Func_000_0A4F:: ; heuristic: follows a terminator; C0
    call Func_000_0A61
    ld a, [$C560]
    ld [$C561], a
    ld a, b
    ld [$C560], a
    ld a, $30
    ldh [$FF00], a
    ret

Func_000_0A61::
    ld a, $20
    ldh [$FF00], a
    ldh a, [$FF00]
    ldh a, [$FF00]
    cpl
    and a, $0F
    swap a
    ld b, a
    ld a, $10
    ldh [$FF00], a
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    ldh a, [$FF00]
    cpl
    and a, $0F
    or a, b
    ld b, a
    ret

Func_000_0A8D::
    ld a, [$C58A]
    or a, a
    jr nz, Jump_000_0AA0
    ld a, [$C55D]
    or a, a
    jr nz, Jump_000_0AA0
    xor a, a
    ld [$C560], a
    ld [$C561], a

Jump_000_0AA0::
    xor a, a
    ld [$C563], a
    ld hl, $C55E
    ld a, [hl]
    inc hl
    xor a, [hl]
    dec hl
    and a, [hl]
    ld [$C562], a
    ld hl, $C55E
    ld a, [hl+]
    or a, a
    jr z, Jump_000_0AB9
    cp a, [hl]
    jr z, Jump_000_0AC6

Jump_000_0AB9::
    ld a, [$C562]
    ld [$C563], a
    ld a, $14
    ld [$C564], a
    jr Jump_000_0AD6

Jump_000_0AC6::
    ld hl, $C564
    ld a, [hl]
    or a, a
    jr nz, Jump_000_0AD5
    ld [hl], $06
    ld a, [$C55E]
    ld [$C563], a

Jump_000_0AD5::
    dec [hl]

Jump_000_0AD6::
    xor a, a
    ld [$C567], a
    ld hl, $C560
    ld a, [hl]
    inc hl
    xor a, [hl]
    dec hl
    and a, [hl]
    ld [$C566], a
    ld hl, $C560
    ld a, [hl+]
    or a, a
    jr z, Jump_000_0AEF
    cp a, [hl]
    jr z, Jump_000_0AFC

Jump_000_0AEF::
    ld a, [$C566]
    ld [$C567], a
    ld a, $14
    ld [$C568], a
    jr Jump_000_0B0C

Jump_000_0AFC::
    ld hl, $C568
    ld a, [hl]
    or a, a
    jr nz, Jump_000_0B0B
    ld [hl], $06
    ld a, [$C560]
    ld [$C567], a

Jump_000_0B0B::
    dec [hl]

Jump_000_0B0C::
    ret

Func_000_0B0D::
    add a, a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_000_0B18::
    ld a, [$4000]
    push af
    ld a, b
    ld [$2100], a

Jump_000_0B20::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0B20
    pop af
    ld [$2100], a
    ret

Func_000_0B2B::
    ld a, [$4000]
    push af
    ld a, b
    ld [$2100], a

Jump_000_0B33::
    di

Jump_000_0B34::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_0B34
    ld a, [de]
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_000_0B33
    pop af
    ld [$2100], a
    ret

Func_000_0B46::
    ld a, [$4000]
    push af
    ld a, b
    ld [$2100], a

Jump_000_0B4E::
    di

Jump_000_0B4F::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_0B4F
    ld a, [de]
    ld b, a
    inc de
    ei
    di

Jump_000_0B5A::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_0B5A
    ld a, [hl]
    or a, b
    ld [hl+], a
    ei
    dec c
    jr nz, Jump_000_0B4E
    pop af
    ld [$2100], a
    ret

Func_000_0B6C::
    ld a, [$4000]
    push af
    ld a, [$D7FE]
    ld [$2100], a
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    ld c, a
    pop af
    ld [$2100], a
    ret

Func_000_0B7F::
    ld hl, $C5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, $D040
    ld a, [$C5E9]
    ld [hl+], a
    ld a, [$C5EA]
    ld [hl+], a
    ld a, [$C5EB]
    ld [hl], a
    ret

Func_000_0B9B::
    xor a, a
    ld hl, $FFA1
    call Func_000_0BA2

Func_000_0BA2::
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ret

Func_000_0BA7::
    xor a, a
    ldh [$FFB1], a
    ld hl, $C000
    ld b, $A0

Jump_000_0BAF::
    ld [hl+], a
    dec b
    jr nz, Jump_000_0BAF
    ret

Func_000_0BB4::
    ldh a, [$FFB1]
    cp a, $28
    ret z
    ld l, a
    sla l
    sla l
    ld h, $C0
    sub a, $28
    ld b, a
    xor a, a

Jump_000_0BC4::
    ld [hl+], a
    inc l
    inc l
    inc l
    inc b
    jr nz, Jump_000_0BC4
    ret

Func_000_0BCC::
    ld a, [$C0C0]
    ld e, a
    ld a, [$C0C1]
    ld d, a
    ld a, d
    or a, e
    jr nz, Jump_000_0BD9
    ret

Jump_000_0BD9::
    ld a, [$C0C3]
    ld b, a
    ld hl, $C0C4
    ld a, [$C0C2]
    or a, a
    jr nz, Jump_000_0BF7
    ld a, e
    and a, $E0
    ld c, a

Jump_000_0BEA::
    ld a, [hl+]
    ld [de], a
    inc e
    ld a, e
    and a, $1F
    or a, c
    ld e, a
    dec b
    jr nz, Jump_000_0BEA
    jr Jump_000_0C05

Jump_000_0BF7::
    ld a, [hl+]
    ld [de], a
    ld a, $20
    add a, e
    ld e, a
    jr nc, Jump_000_0C00
    inc d

Jump_000_0C00::
    res 2, d
    dec b
    jr nz, Jump_000_0BF7

Jump_000_0C05::
    xor a, a
    ld [$C0C0], a
    ld [$C0C1], a
    ld a, [$C525]
    or a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    ld a, [$C0D8]
    ld e, a
    ld a, [$C0D9]
    ld d, a
    ld a, d
    or a, e
    jr nz, Jump_000_0C22
    ret

Jump_000_0C22::
    ld a, [$C0DB]
    ld b, a
    ld hl, $C0DC
    ld a, [$C0DA]
    or a, a
    jr nz, Jump_000_0C40
    ld a, e
    and a, $E0
    ld c, a

Jump_000_0C33::
    ld a, [hl+]
    ld [de], a
    inc e
    ld a, e
    and a, $1F
    or a, c
    ld e, a
    dec b
    jr nz, Jump_000_0C33
    jr Jump_000_0C4E

Jump_000_0C40::
    ld a, [hl+]
    ld [de], a
    ld a, $20
    add a, e
    ld e, a
    jr nc, Jump_000_0C49
    inc d

Jump_000_0C49::
    res 2, d
    dec b
    jr nz, Jump_000_0C40

Jump_000_0C4E::
    ld a, $00
    ldh [$FF4F], a
    xor a, a
    ld [$C0D8], a
    ld [$C0D9], a
    ret

Func_000_0C5A::
    ldh a, [$FFD6]
    or a, a
    jr nz, Func_000_0C5A
    inc a
    ldh [$FFD6], a
    call Func_000_0C69
    xor a, a
    ldh [$FFD6], a
    ret

Func_000_0C69::
    ld a, [$4000]
    push af
    call Func_000_0DA8

Jump_000_0C70::
    ld a, [de]
    inc de
    push hl
    ld hl, $FFBB
    cp a, [hl]
    jr z, Jump_000_0C83
    pop hl
    ld [hl], a
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_0C70
    jr Jump_000_0CF0

Jump_000_0C83::
    pop hl
    ld a, [de]
    ldh [$FFC0], a
    inc de
    ld a, [de]
    ldh [$FFBF], a
    inc de
    ldh a, [$FFBF]
    push af
    and a, $0F
    add a, $04
    cp a, $13
    jr nz, Jump_000_0C9B
    ld a, [de]
    inc de
    add a, $13

Jump_000_0C9B::
    ldh [$FFBF], a
    pop af
    push de
    swap a
    and a, $0F
    ld d, a
    ldh a, [$FFC0]
    ld e, a
    push hl
    ldh a, [$FFBC]
    ld l, a
    ldh a, [$FFBD]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl

Jump_000_0CB2::
    ldh a, [$FFC2]
    cp a, d
    jr z, Jump_000_0CBB
    jr c, Jump_000_0CC2
    jr Jump_000_0CDD

Jump_000_0CBB::
    ldh a, [$FFC1]
    cp a, e
    jr z, Jump_000_0CC2
    jr nc, Jump_000_0CDD

Jump_000_0CC2::
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [$FFC4]
    cp a, d
    jr z, Jump_000_0CCF
    jr nc, Jump_000_0CD6
    jr Jump_000_0CDD

Jump_000_0CCF::
    ldh a, [$FFC3]
    cp a, e
    jr z, Jump_000_0CDD
    jr c, Jump_000_0CDD

Jump_000_0CD6::
    ld a, $10
    add a, d
    ld d, a
    xor a, a
    jr Jump_000_0CDE

Jump_000_0CDD::
    ld a, [de]

Jump_000_0CDE::
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr z, Jump_000_0CEF
    ldh a, [$FFBF]
    dec a
    ldh [$FFBF], a
    jr nz, Jump_000_0CB2
    pop de
    jr Jump_000_0C70

Jump_000_0CEF::
    pop de

Jump_000_0CF0::
    pop af
    ld [$2100], a
    ret

Func_000_0CF5::
    ldh a, [$FFD6]
    or a, a
    jr nz, Func_000_0CF5
    inc a
    ldh [$FFD6], a
    ld a, [$4000]
    push af
    call Func_000_0DA8

Jump_000_0D04::
    ld a, [de]
    inc de
    push hl
    ld hl, $FFBB
    cp a, [hl]
    jr z, Jump_000_0D22
    pop hl
    ldh [$FFC5], a
    di

Jump_000_0D11::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_0D11
    ldh a, [$FFC5]
    ld [hl+], a
    ei
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_0D04
    jr Jump_000_0DA0

Jump_000_0D22::
    pop hl
    ld a, [de]
    ldh [$FFC0], a
    inc de
    ld a, [de]
    ldh [$FFBF], a
    inc de
    ldh a, [$FFBF]
    ldh [$FFC5], a
    and a, $0F
    add a, $04
    cp a, $13
    jr nz, Jump_000_0D3B
    ld a, [de]
    inc de
    add a, $13

Jump_000_0D3B::
    ldh [$FFBF], a
    ldh a, [$FFC5]
    push de
    swap a
    and a, $0F
    ld d, a
    ldh a, [$FFC0]
    ld e, a
    ldh a, [$FFBC]
    add a, e
    ld e, a
    ldh a, [$FFBD]
    adc a, d
    ld d, a

Jump_000_0D50::
    ldh a, [$FFC2]
    cp a, d
    jr z, Jump_000_0D59
    jr c, Jump_000_0D60
    jr Jump_000_0D84

Jump_000_0D59::
    ldh a, [$FFC1]
    cp a, e
    jr z, Jump_000_0D60
    jr nc, Jump_000_0D84

Jump_000_0D60::
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [$FFC4]
    cp a, d
    jr z, Jump_000_0D6D
    jr nc, Jump_000_0D74
    jr Jump_000_0D84

Jump_000_0D6D::
    ldh a, [$FFC3]
    cp a, e
    jr z, Jump_000_0D84
    jr c, Jump_000_0D84

Jump_000_0D74::
    ld a, $10
    add a, d
    ld d, a
    di

Jump_000_0D79::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_0D79
    xor a, a
    ld [hl+], a
    ei
    jr Jump_000_0D8E

Jump_000_0D84::
    di

Jump_000_0D85::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_0D85
    ld a, [de]
    ld [hl+], a
    ei

Jump_000_0D8E::
    inc de
    dec bc
    ld a, b
    or a, c
    jr z, Jump_000_0D9F
    ldh a, [$FFBF]
    dec a
    ldh [$FFBF], a
    jr nz, Jump_000_0D50
    pop de
    jp Jump_000_0D04

Jump_000_0D9F::
    pop de

Jump_000_0DA0::
    pop af
    ld [$2100], a
    xor a, a
    ldh [$FFD6], a
    ret

Func_000_0DA8::
    ld a, b
    ld [$2100], a
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ldh [$FFBB], a
    inc de
    ld a, l
    ldh [$FFBC], a
    ldh [$FFC3], a
    ld a, h
    ldh [$FFBD], a
    ldh [$FFC4], a
    push hl
    add hl, bc
    ld a, l
    ldh [$FFC1], a
    ld a, h
    ldh [$FFC2], a
    pop hl
    ret

Func_000_0DCA::
    ld hl, $C56F
    ld a, [$C5E9]
    ld [hl+], a
    ld a, [$C5EA]
    ld [hl+], a
    ld a, [$C5EB]
    ld [hl], a
    jr Jump_000_0DDB

Jump_000_0DDB::
    xor a, a
    ld hl, $C572
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld [$C56C], a
    ld a, $07
    ld [$C56D], a
    ld a, $1F
    ld [$C56E], a
    ret

Func_000_0DF2::
    ld b, a
    ld a, [$C525]
    or a, a
    jp nz, Jump_000_0E9B
    ld a, [$C524]
    or a, a
    jp z, Jump_000_0EA8
    bit 7, b
    jr nz, Jump_000_0E2C
    ld a, b
    ld [$C56C], a
    ld hl, $C4FF
    ld de, $C4DF
    ld c, $20

Jump_000_0E11::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0E11
    ld a, $00
    ld [$C572], a
    ld a, [$C56C]
    srl a
    srl a
    ld [$C573], a
    ld [$C574], a
    jp Jump_000_0F3D

Jump_000_0E2C::
    ld a, b
    ld [$C56C], a
    ld a, $20
    ld [$C572], a
    ld a, [$C56C]
    cpl
    srl a
    srl a
    ld [$C573], a
    ld [$C574], a
    ld hl, $C4FF
    ld de, $C4DF
    ld c, $20

Jump_000_0E4B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0E4B
    ld de, $7FFF
    ld a, [$C56D]
    bit 7, a
    jr z, Jump_000_0E5E
    ld de, $0000

Jump_000_0E5E::
    ld hl, $C4DF
    ld c, $10

Jump_000_0E63::
    ld [hl], e
    inc hl
    ld [hl], d
    inc hl
    dec c
    jr nz, Jump_000_0E63
    call Func_000_076B
    ld hl, $C4DF
    ld de, $C47F
    ld a, $01
    ld [de], a
    inc de
    call Func_000_1022
    call Func_000_05D1
    ld a, [$C56E]
    bit 4, a
    jp z, Jump_000_0F3D
    call Func_000_076B
    ld hl, $C4EF
    ld de, $C47F
    ld a, $09
    ld [de], a
    inc de
    call Func_000_1022
    call Func_000_05D1
    jp Jump_000_0F3D

Jump_000_0E9B::
    ld a, b
    ld [$C56C], a
    ld hl, $4001
    ld b, $02
    rst $10
    jp Jump_000_0F3D

Jump_000_0EA8::
    ld a, [$C56D]
    bit 7, a
    jr nz, Jump_000_0EF7
    bit 7, b
    jr nz, Jump_000_0ED8
    ld a, b
    ld [$C56C], a
    ld hl, $C56F
    ld a, [$C5E9]
    ld [hl+], a
    ld a, [$C5EA]
    ld [hl+], a
    ld a, [$C5EB]
    ld [hl], a
    ld a, $00
    ld [$C572], a
    ld a, [$C56C]
    add a, $02
    ld [$C573], a
    ld [$C574], a
    jr Jump_000_0F3D

Jump_000_0ED8::
    ld a, b
    ld [$C56C], a
    ld a, $04
    ld [$C572], a
    ld a, [$C56C]
    cpl
    add a, $02
    ld [$C573], a
    ld [$C574], a
    ld a, $00
    ld hl, $C5E9
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    jr Jump_000_0F3D

Jump_000_0EF7::
    bit 7, b
    jr nz, Jump_000_0F20
    ld a, b
    ld [$C56C], a
    ld hl, $C56F
    ld a, [$C5E9]
    ld [hl+], a
    ld a, [$C5EA]
    ld [hl+], a
    ld a, [$C5EB]
    ld [hl], a
    ld a, $00
    ld [$C572], a
    ld a, [$C56C]
    add a, $02
    ld [$C573], a
    ld [$C574], a
    jr Jump_000_0F3D

Jump_000_0F20::
    ld a, b
    ld [$C56C], a
    ld a, $04
    ld [$C572], a
    ld a, [$C56C]
    cpl
    add a, $02
    ld [$C573], a
    ld [$C574], a
    ld a, $FF
    ld hl, $C5E9
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_000_0F3D::
    ret

Func_000_0F3E:: ; heuristic: follows a terminator; C0
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, $8800
    add hl, bc
    ld c, $08

Jump_000_0F47::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_000_0F47
    ret

Func_000_0F4E::
    ld a, [$C56C]
    or a, a
    ret z
    bit 7, a
    call z, Func_000_137D
    ld a, [$C525]
    or a, a
    jp nz, Jump_000_10C7
    ld a, [$C524]
    or a, a
    jp z, Jump_000_10CE
    ld a, [$C56C]
    bit 7, a
    jr nz, Jump_000_0F98
    ld a, [$C574]
    or a, a
    jr z, Jump_000_0F78
    dec a
    ld [$C574], a
    ret

Jump_000_0F78::
    ld a, [$C572]
    add a, $05
    cp a, $1F
    jr c, Jump_000_0F83
    ld a, $1F

Jump_000_0F83::
    ld [$C572], a
    call Func_000_0FC1
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    cp a, $1F
    jp z, Jump_000_1205
    ret

Jump_000_0F98::
    ld a, [$C574]
    or a, a
    jr z, Jump_000_0FA3
    dec a
    ld [$C574], a
    ret

Jump_000_0FA3::
    ld a, [$C572]
    sub a, $05
    bit 7, a
    jr z, Jump_000_0FAD
    xor a, a

Jump_000_0FAD::
    ld [$C572], a
    call Func_000_0FC1
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    or a, a
    jp z, Jump_000_1205
    ret

Func_000_0FC1::
    ld a, [$C56E]
    bit 0, a
    ld a, $00
    ld [$C576], a
    call nz, Func_000_1040
    ld a, [$C56E]
    bit 1, a
    ld a, $08
    ld [$C576], a
    call nz, Func_000_1040
    ld a, [$C56E]
    bit 4, a
    jr z, Jump_000_0FFC
    ld a, [$C56E]
    bit 2, a
    ld a, $10
    ld [$C576], a
    call nz, Func_000_1040
    ld a, [$C56E]
    bit 3, a
    ld a, $18
    ld [$C576], a
    call nz, Func_000_1040

Jump_000_0FFC::
    call Func_000_076B
    ld hl, $C4DF
    ld de, $C47F
    ld a, $01
    ld [de], a
    inc de
    call Func_000_1022
    ld a, [$C56E]
    bit 4, a
    ret z
    call Func_000_05D1
    call Func_000_076B
    ld hl, $C4EF
    ld de, $C47F
    ld a, $09
    ld [de], a
    inc de

Func_000_1022::
    ld c, $08

Jump_000_1024::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_000_1024
    inc hl
    inc hl
    ld c, $06

Jump_000_102E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_000_102E
    ld a, $FF
    ld [$C47C], a
    ld b, $1F
    ld hl, $5040
    rst $10
    ret

Func_000_1040::
    call Func_000_1051
    call Func_000_1049
    call Func_000_1049

Func_000_1049::
    ld a, [$C576]
    add a, $02
    ld [$C576], a

Func_000_1051::
    ld hl, $C4FF
    ld a, [$C576]
    add a, l
    ld l, a
    jr nc, Jump_000_105C
    inc h

Jump_000_105C::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld hl, $0000
    ld a, [$C572]
    ld b, a
    ld a, e
    call Func_000_10AB
    ld l, a
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, d
    call Func_000_10AB
    ld d, a
    ld e, $00
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    add hl, de
    pop de
    ld a, d
    srl a
    srl a
    call Func_000_10AB
    sla a
    sla a
    add a, h
    ld h, a
    push hl
    pop de
    ld hl, $C4DF
    ld b, $00
    ld a, [$C576]
    ld c, a
    add hl, bc
    ld [hl], e
    inc hl
    ld [hl], d
    ret

Func_000_10AB::
    push af
    ld a, [$C56D]
    ld c, a
    pop af
    bit 7, c
    jr nz, Jump_000_10C0
    and a, $1F
    add a, b
    cp a, $1F
    jr c, Jump_000_10C6
    ld a, $1F
    jr Jump_000_10C6

Jump_000_10C0::
    and a, $1F
    sub a, b
    jr nc, Jump_000_10C6
    xor a, a

Jump_000_10C6::
    ret

Jump_000_10C7::
    ld hl, $4071
    ld b, $02
    rst $10
    ret

Jump_000_10CE::
    ld a, [$C56D]
    bit 7, a
    jp nz, Jump_000_116D
    ld a, [$C56C]
    bit 7, a
    jr nz, Jump_000_10FE
    ld a, [$C574]
    or a, a
    jr z, Jump_000_10E8
    dec a
    ld [$C574], a
    ret

Jump_000_10E8::
    call Func_000_111F
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    inc a
    ld [$C572], a
    cp a, $04
    jp z, Jump_000_1205
    ret

Jump_000_10FE::
    ld a, [$C574]
    or a, a
    jr z, Jump_000_1109
    dec a
    ld [$C574], a
    ret

Jump_000_1109::
    call Func_000_111F
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    dec a
    ld [$C572], a
    cp a, $FF
    jp z, Jump_000_1205
    ret

Func_000_111F::
    ld a, [$C56D]
    bit 0, a
    ld a, [$C56F]
    ld hl, $C5E9
    call nz, Func_000_1145
    ld a, [$C56D]
    bit 1, a
    ld a, [$C570]
    inc hl
    call nz, Func_000_1145
    ld a, [$C56D]
    bit 2, a
    ld a, [$C571]
    inc hl
    jr nz, Func_000_1145
    ret

Func_000_1145::
    ld d, a
    ld a, [$C572]
    ld b, a
    ld c, $00
    ld a, d
    call Func_000_1160
    call Func_000_115B
    call Func_000_115B
    call Func_000_115B
    ld [hl], c
    ret

Func_000_115B::
    rrc d
    rrc d
    ld a, d

Func_000_1160::
    and a, $03
    sub a, b
    jr nc, Jump_000_1166
    xor a, a

Jump_000_1166::
    or a, c
    ld c, a
    rrc c
    rrc c
    ret

Jump_000_116D::
    ld a, [$C56C]
    bit 7, a
    jr nz, Jump_000_1194
    ld a, [$C574]
    or a, a
    jr z, Jump_000_117F
    dec a
    ld [$C574], a
    ret

Jump_000_117F::
    call Func_000_11B4
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    inc a
    ld [$C572], a
    cp a, $04
    jr z, Jump_000_1205
    ret

Jump_000_1194::
    ld a, [$C574]
    or a, a
    jr z, Jump_000_119F
    dec a
    ld [$C574], a
    ret

Jump_000_119F::
    call Func_000_11B4
    ld a, [$C573]
    ld [$C574], a
    ld a, [$C572]
    dec a
    ld [$C572], a
    cp a, $FF
    jr z, Jump_000_1205
    ret

Func_000_11B4::
    ld a, [$C56D]
    bit 0, a
    ld a, [$C56F]
    ld hl, $C5E9
    call nz, Func_000_11DA
    ld a, [$C56D]
    bit 1, a
    ld a, [$C570]
    inc hl
    call nz, Func_000_11DA
    ld a, [$C56D]

Func_000_11D1::
    bit 2, a
    ld a, [$C571]
    inc hl
    jr nz, Func_000_11DA
    ret

Func_000_11DA::
    ld d, a
    ld a, [$C572]
    ld b, a
    ld c, $00
    ld a, d
    call Func_000_11F5
    call Func_000_11F0
    call Func_000_11F0
    call Func_000_11F0
    ld [hl], c
    ret

Func_000_11F0::
    rrc d
    rrc d
    ld a, d

Func_000_11F5::
    and a, $03
    add a, b
    cp a, $03
    jr c, Jump_000_11FE
    ld a, $03

Jump_000_11FE::
    or a, c
    ld c, a
    rrc c
    rrc c
    ret

Jump_000_1205::
    xor a, a
    ld [$C56C], a
    ret

Func_000_120A::
    ldh a, [$FF41]
    bit 1, a
    ret z
    jr Func_000_120A

Func_000_1211::
    ldh [$FFD1], a
    di

Jump_000_1214::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_1214
    ldh a, [$FFD1]
    ld [hl], a
    ei
    ret

Func_000_121F::
    ldh [$FFD1], a
    di

Jump_000_1222::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_1222
    ldh a, [$FFD1]
    ld [hl+], a
    ei
    ret

Func_000_122D::
    ld [$C60A], a
    ret

Func_000_1231::
    ld [$C608], a
    di
    call Func_000_3290
    ld a, [$C608]
    or a, a
    jr z, Jump_000_1276
    ld [$DD10], a
    cp a, $02
    jr z, Jump_000_126E
    cp a, $0F
    jr z, Jump_000_126E
    cp a, $40
    jr z, Jump_000_1273
    cp a, $42
    jr z, Jump_000_1273
    cp a, $44
    jr z, Jump_000_1273
    cp a, $46
    jr z, Jump_000_1273
    cp a, $48
    jr z, Jump_000_1273
    cp a, $50
    jr z, Jump_000_1273
    cp a, $52
    jr z, Jump_000_1273
    cp a, $58
    jr z, Jump_000_126E
    call Func_000_334E
    ei
    ret

Jump_000_126E::
    call Func_000_334B
    ei
    ret

Jump_000_1273::
    call Func_000_3351

Jump_000_1276::
    ei
    ret

Func_000_1278::
    ld [$C60B], a
    ret

Func_000_127C::
    push af
    push bc
    push de
    push hl
    ld [$DD10], a
    cp a, $63
    jr z, Jump_000_1306
    cp a, $67
    jr z, Jump_000_1306
    cp a, $6D
    jp z, Jump_000_1310
    cp a, $70
    jr z, Jump_000_1306
    cp a, $72
    jr z, Jump_000_1306
    cp a, $74
    jr z, Jump_000_1306
    cp a, $7E
    jr z, Jump_000_1306
    cp a, $89
    jr z, Jump_000_1306
    cp a, $8B
    jr z, Jump_000_1306
    cp a, $8D
    jr z, Jump_000_1306
    cp a, $91
    jr z, Jump_000_1306
    cp a, $9F
    jr z, Jump_000_1306
    cp a, $A5
    jr z, Jump_000_1306
    cp a, $AC
    jr z, Jump_000_1306
    cp a, $AE
    jr z, Jump_000_1306
    cp a, $B2
    jr z, Jump_000_1306
    cp a, $B6
    jr z, Jump_000_1306
    cp a, $B8
    jr z, Jump_000_1306
    cp a, $BA
    jr z, Jump_000_1306
    cp a, $BD
    jr z, Jump_000_1306
    cp a, $BF
    jr z, Jump_000_1306
    cp a, $C1
    jr z, Jump_000_1306
    cp a, $C3
    jr z, Jump_000_1306
    cp a, $C5
    jr z, Jump_000_1306
    cp a, $C7
    jr z, Jump_000_1306
    cp a, $C9
    jr z, Jump_000_1306
    cp a, $D2
    jr z, Jump_000_1306
    cp a, $D4
    jr z, Jump_000_1306
    cp a, $DA
    jr z, Jump_000_1306
    cp a, $DD
    jr z, Jump_000_1306
    di
    call Func_000_3354
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

Jump_000_1306::
    di
    call Func_000_3351
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

Jump_000_1310::
    di
    call Func_000_334E
    ei
    pop hl
    pop de
    pop bc
    pop af
    ret

Func_000_131A::
    ld a, [$C60A]
    cp a, $FF
    jr z, Jump_000_1329
    call Func_000_1231
    ld a, $FF
    ld [$C60A], a

Jump_000_1329::
    ld a, [$C60B]
    cp a, $FF
    jr z, Jump_000_1338
    call Func_000_127C
    ld a, $FF
    ld [$C60B], a

Jump_000_1338::
    ret
    db $C9, $47, $FA, $E0, $C5, $B7, $20, $37, $78, $CB, $7F, $20, $32, $B7, $28, $2F
    db $EA, $E2, $C5, $FA, $24, $C5, $B7

Func_000_1350:: ; heuristic: target of a pointer table; C0
    jr nz, Jump_000_135A
    ld a, [$C5E2]

Func_000_1355:: ; heuristic: target of a pointer table; C0
    sra a
    ld [$C5E2], a

Jump_000_135A::
    ldh a, [$FF24]
    bit 7, a
    jr nz, Jump_000_1378
    bit 3, a

Func_000_1362:: ; heuristic: target of a pointer table; C0
    jr nz, Jump_000_1378
    or a, a
    jr z, Jump_000_1378
    ld a, [$C5E2]
    ld [$C5E3], a
    ld a, $08
    ld [$C5E4], a
    ldh a, [$FF24]
    ld [$C5E5], a
    ret

Jump_000_1378::
    xor a, a
    ld [$C5E2], a
    ret

Func_000_137D::
    ld a, [$C5E0]
    or a, a
    jr nz, Jump_000_13E0
    ld a, [$C5E2]
    bit 7, a
    jr nz, Jump_000_13E0
    or a, a
    ret z
    ld a, [$C5E3]
    or a, a
    jr z, Jump_000_1397
    dec a
    ld [$C5E3], a
    ret

Jump_000_1397::
    ldh a, [$FF24]
    and a, $88
    cp a, $88
    jr z, Jump_000_13E0
    ld a, [$C5E5]
    or a, a
    jr z, Jump_000_13E0
    ld b, a
    and a, $0F
    ld d, a
    ld a, b
    swap a
    and a, $0F
    ld c, a
    bit 3, c
    jr nz, Jump_000_13B8
    ld a, c
    or a, a
    jr z, Jump_000_13B8
    dec c

Jump_000_13B8::
    bit 3, d
    jr nz, Jump_000_13C1
    ld a, d
    or a, a
    jr z, Jump_000_13C1
    dec d

Jump_000_13C1::
    ld a, c
    swap a
    or a, d
    ldh [$FF24], a
    ld [$C5E5], a
    or a, a
    jr z, Jump_000_13DE
    ld a, [$C5E4]
    or a, a
    jr z, Jump_000_13E0
    dec a
    ld [$C5E4], a
    ld a, [$C5E2]
    ld [$C5E3], a
    ret

Jump_000_13DE::
    di
    ei

Jump_000_13E0::
    xor a, a
    ld [$C5E2], a
    ret

Func_000_13E5::
    ld hl, $C523
    cp a, [hl]
    ret z
    ld [hl], a
    cp a, $00
    jr nz, Jump_000_1419
    ld a, $10
    ld e, $93
    ld d, $44
    ld b, $17
    call Func_000_06A8
    call Func_000_05D1
    ld a, $11
    ld e, $5A
    ld d, $50
    ld b, $17
    call Func_000_06A8
    call Func_000_05D1
    ld a, $0F
    ld e, $03
    ld d, $5B
    ld b, $17
    call Func_000_06A8
    jp Jump_000_14CF

Jump_000_1419::
    cp a, $01
    jr nz, Jump_000_1447
    ld a, $10
    ld e, $01
    ld d, $40
    ld b, $18
    call Func_000_06A8
    call Func_000_05D1
    ld a, $11
    ld e, $0B
    ld d, $49
    ld b, $18
    call Func_000_06A8
    call Func_000_05D1
    ld a, $0F
    ld e, $E0
    ld d, $5E
    ld b, $17
    call Func_000_06A8
    jp Jump_000_14CF

Jump_000_1447::
    cp a, $02
    jr nz, Jump_000_1474
    ld a, $10
    ld e, $C1
    ld d, $49
    ld b, $18
    call Func_000_06A8
    call Func_000_05D1
    ld a, $11
    ld e, $6F
    ld d, $55
    ld b, $18
    call Func_000_06A8
    call Func_000_05D1
    ld a, $0F
    ld e, $A6
    ld d, $61
    ld b, $17
    call Func_000_06A8
    jr Jump_000_14CF

Jump_000_1474::
    cp a, $03
    jr nz, Jump_000_14A1
    ld a, $10
    ld e, $2D
    ld d, $60
    ld b, $18
    call Func_000_06A8
    call Func_000_05D1
    ld a, $11
    ld e, $F4
    ld d, $6B
    ld b, $18
    call Func_000_06A8
    call Func_000_05D1
    ld a, $0F
    ld e, $5B
    ld d, $65
    ld b, $17
    call Func_000_06A8
    jr Jump_000_14CF

Jump_000_14A1::
    cp a, $04
    jr nz, Jump_000_14CF
    ld a, $10
    ld e, $AA
    ld d, $5D
    ld b, $E1
    call Func_000_06A8
    call Func_000_05D1
    ld a, $11
    ld e, $90
    ld d, $69
    ld b, $E1
    call Func_000_06A8
    call Func_000_05D1
    ld a, $0F
    ld e, $E2
    ld d, $76
    ld b, $E1
    call Func_000_06A8
    call Func_000_05D1

Jump_000_14CF::
    ret
    db $C9

Func_000_14D1::
    ld a, [$C58A]
    or a, a
    jp z, Jump_000_1575
    ld a, $08
    call Func_000_07D8
    ld a, [$C580]
    set 7, a
    res 6, a
    ld [$C580], a
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_000_14F6
    ld hl, $6000

Jump_000_14F1::
    dec hl
    ld a, h
    or a, l
    jr nz, Jump_000_14F1

Jump_000_14F6::
    ei
    ld a, [$C581]
    cp a, $05
    jr nz, Jump_000_150D
    call Func_000_15C2
    call Func_000_07D1
    ldh a, [$FF01]
    cp a, $F5
    call nz, Func_000_15C2
    jr Jump_000_1558

Jump_000_150D::
    call Func_000_1583
    cp a, $02
    jr z, Jump_000_1517
    call Func_000_07D1

Jump_000_1517::
    ldh a, [$FF01]
    cp a, $70
    jr z, Jump_000_1524
    cp a, $71
    jr z, Jump_000_1524
    call Func_000_1583

Jump_000_1524::
    ld b, a
    ld a, [$C581]
    cp a, $05
    jr z, Jump_000_1558
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_000_1545
    ld a, [$C525]
    and a, a
    jr nz, Jump_000_1558
    ld a, b
    bit 0, a
    jr z, Jump_000_1558
    ld a, [$C57F]
    set 1, a
    jr Jump_000_1555

Jump_000_1545::
    ld a, [$C525]
    and a, a
    jr z, Jump_000_1558
    ld a, b
    bit 0, a
    jr nz, Jump_000_1558
    ld a, [$C57F]
    res 1, a

Jump_000_1555::
    ld [$C57F], a

Jump_000_1558::
    di
    ld a, [$C580]
    res 7, a
    ld [$C580], a
    ld a, [$C580]
    res 0, a
    res 1, a
    ld [$C580], a
    ld a, [$C57F]
    bit 1, a
    ld a, $F8
    call nz, Func_000_08BA

Jump_000_1575::
    xor a, a
    ld [$C582], a
    ld hl, $C55E
    ld b, $0E

Jump_000_157E::
    ld [hl+], a
    dec b
    jr nz, Jump_000_157E
    ret

Func_000_1583::
    ld a, [$C57F]
    bit 1, a
    jr nz, Jump_000_1594
    ld a, [$C525]
    or a, $70
    call Func_000_08AD
    jr Jump_000_159C

Jump_000_1594::
    ld a, [$C525]
    or a, $70
    call Func_000_08BA

Jump_000_159C::
    ld a, [$C588]
    add a, $01
    ld [$C588], a
    ld a, [$C589]
    adc a, $00
    ld [$C589], a
    ld a, [$C589]
    cp a, $FF
    jr nc, Jump_000_15BC
    ld a, [$C580]
    bit 6, a
    jr z, Jump_000_159C
    xor a, a
    ret

Jump_000_15BC::
    ld a, $02
    ld [$C58E], a
    ret

Func_000_15C2::
    ld a, [$C57F]
    bit 1, a
    ld a, $F5
    call nz, Func_000_08BA
    ld a, [$C57F]
    bit 1, a
    ld a, $F5
    call z, Func_000_08AD

Jump_000_15D6::
    ld a, [$C580]
    bit 6, a
    jr z, Jump_000_15D6
    ret

Func_000_15DE::
    push bc
    ld b, a
    ld a, [$4000]
    ld c, a
    ld a, b
    ld [$2100], a
    ld a, c
    pop bc
    push af

Jump_000_15EB::
    push hl
    push bc

Jump_000_15ED::
    di
    ld a, [de]
    call Func_000_121F
    ei
    inc de
    dec b
    jr nz, Jump_000_15ED
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1606
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_000_15EB

Jump_000_1606::
    pop af
    ld [$2100], a
    ret

Func_000_160B::
    push bc
    ld b, a
    ld a, [$4000]
    ld c, a
    ld a, b
    ld [$2100], a
    ld a, c
    pop bc
    push af

Jump_000_1618::
    push hl
    push bc

Jump_000_161A::
    di
    ld a, [de]
    call Func_000_121F
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_162D
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_162D::
    inc de
    dec b
    jr nz, Jump_000_161A
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1644
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1618

Jump_000_1644::
    pop af
    ld [$2100], a
    ret

Func_000_1649:: ; heuristic: follows a terminator; C0
    ld hl, $9800
    ld de, $C198
    ld c, $20

Jump_000_1651::
    ld b, $20
    push hl

Jump_000_1654::
    ld a, [de]
    call Func_000_1211
    ld a, l
    and a, $E0
    push af
    ld a, l
    inc a
    and a, $1F
    ld l, a
    pop af
    or a, l
    ld l, a
    inc de
    dec b
    jr nz, Jump_000_1654
    pop hl
    push bc
    ld bc, $0020
    add hl, bc
    ld a, h
    and a, $03
    or a, $98
    ld h, a
    pop bc
    dec c
    jr nz, Jump_000_1651
    ret

Func_000_1679::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_000_1679
    ret

Func_000_1682::
    ld b, $00
    ld h, b
    ld l, b
    call Func_000_1689

Func_000_1689::
    rrca
    jr nc, Jump_000_168D
    add hl, bc

Jump_000_168D::
    sla c
    rl b
    rrca
    jr nc, Jump_000_1695
    add hl, bc

Jump_000_1695::
    sla c
    rl b
    rrca
    jr nc, Jump_000_169D
    add hl, bc

Jump_000_169D::
    sla c
    rl b
    rrca
    jr nc, Jump_000_16A5
    add hl, bc

Jump_000_16A5::
    sla c
    rl b
    ret

Func_000_16AA::
    push af
    push bc
    ld c, b
    call Func_000_1682
    pop bc
    pop af
    push hl
    call Func_000_1682
    pop bc
    ld a, c
    add a, h
    ld h, a
    ld a, b
    adc a, $00
    ld e, a
    ret

Func_000_16BF::
    ld d, $08
    ld e, a
    xor a, a

Jump_000_16C3::
    sla b
    rla
    jr c, Jump_000_16CB
    cp a, e
    jr c, Jump_000_16CD

Jump_000_16CB::
    sub a, e
    inc b

Jump_000_16CD::
    dec d
    jr nz, Jump_000_16C3
    ret

Func_000_16D1::
    ld d, $10
    ld e, a
    xor a, a

Jump_000_16D5::
    add hl, hl
    rla
    jr c, Jump_000_16DC
    cp a, e
    jr c, Jump_000_16DE

Jump_000_16DC::
    sub a, e
    inc l

Jump_000_16DE::
    dec d
    jr nz, Jump_000_16D5
    ret

Func_000_16E2::
    ld d, $18
    ld b, a
    xor a, a

Jump_000_16E6::
    add hl, hl
    rl e
    rla
    jr c, Jump_000_16EF
    cp a, b
    jr c, Jump_000_16F1

Jump_000_16EF::
    sub a, b
    inc l

Jump_000_16F1::
    dec d
    jr nz, Jump_000_16E6
    ret

Func_000_16F5::
    xor a, a
    ld [$C8C0], a
    ld [$C8C1], a
    ld [$C8C2], a

Jump_000_16FF::
    ld a, [$C8C0]
    inc a
    ld [$C8C0], a
    ld bc, $FF9C
    add hl, bc
    ld a, h
    rlc a
    jr nc, Jump_000_16FF
    ld bc, $0064
    add hl, bc
    ld a, [$C8C0]
    dec a
    ld [$C8C0], a

Jump_000_171A::
    ld a, [$C8C1]
    inc a
    ld [$C8C1], a
    ld bc, $FFF6
    add hl, bc
    ld a, h
    rlc a
    jr nc, Jump_000_171A
    ld bc, $000A
    add hl, bc
    ld a, [$C8C1]
    dec a
    ld [$C8C1], a
    ld a, l
    ld [$C8C2], a
    ret

Func_000_173A::
    xor a, a
    ldh [$FFC9], a
    ldh [$FFC8], a
    ldh [$FFC7], a
    ldh [$FFC6], a
    ld hl, $C8C0
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld d, a
    ld e, $00

Jump_000_174E::
    ld a, c
    sub a, $40
    ld c, a
    ld a, b
    sbc a, $42
    ld b, a
    ld a, d
    sbc a, $0F
    ld d, a
    jr c, Jump_000_1768
    ld hl, $C8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr Jump_000_174E

Jump_000_1768::
    ld a, e
    ldh [$FFC9], a
    ld hl, $C8C0
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld d, a
    ld e, $00

Jump_000_1776::
    ld a, c
    sub a, $A0
    ld c, a
    ld a, b
    sbc a, $86
    ld b, a
    ld a, d
    sbc a, $01
    ld d, a
    jr c, Jump_000_1790
    ld hl, $C8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr Jump_000_1776

Jump_000_1790::
    ld a, e
    swap a
    ldh [$FFC8], a
    ld hl, $C8C0
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ld d, a
    ld e, $00

Jump_000_17A0::
    ld a, c
    sub a, $10
    ld c, a
    ld a, b
    sbc a, $27
    ld b, a
    ld a, d
    sbc a, $00
    ld d, a
    jr c, Jump_000_17BA
    ld hl, $C8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr Jump_000_17A0

Jump_000_17BA::
    ldh a, [$FFC8]
    add a, e
    ldh [$FFC8], a
    ld hl, $C8C0
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld e, $00

Jump_000_17C8::
    ld a, c
    sub a, $E8
    ld c, a
    ld a, b
    sbc a, $03
    ld b, a
    jr c, Jump_000_17DC
    ld hl, $C8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr Jump_000_17C8

Jump_000_17DC::
    ld a, e
    swap a
    ldh [$FFC7], a
    ld hl, $C8C0
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ld b, a
    ld e, $00

Jump_000_17EA::
    ld a, c
    sub a, $64
    ld c, a
    ld a, b
    sbc a, $00
    ld b, a
    jr c, Jump_000_17FE
    ld hl, $C8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr Jump_000_17EA

Jump_000_17FE::
    ldh a, [$FFC7]
    add a, e
    ldh [$FFC7], a
    ld a, [$C8C0]
    ld e, $00

Jump_000_1808::
    sub a, $0A
    jr c, Jump_000_1812
    ld [$C8C0], a
    inc e
    jr Jump_000_1808

Jump_000_1812::
    swap e
    ld a, [$C8C0]
    add a, e
    ldh [$FFC6], a
    ret

Func_000_181B::
    ld b, e
    sra d
    rr e
    sra d
    rr e
    sra d
    rr e
    ld a, e
    add a, $D7
    ld e, a
    ld a, d
    adc a, $CB
    ld d, a
    ld c, $01
    ld a, b
    and a, $07
    jr z, Jump_000_183D
    ld b, a

Jump_000_1838::
    sla c
    dec b
    jr nz, Jump_000_1838

Jump_000_183D::
    ld a, [de]
    and a, c
    jr nz, Jump_000_1843
    sub a, a
    ret

Jump_000_1843::
    scf
    ret

Func_000_1845::
    ld a, d
    cp a, $03
    jr nc, Jump_000_1870
    ld b, e
    sra d
    rr e
    sra d
    rr e
    sra d
    rr e
    ld a, e
    add a, $D7
    ld e, a
    ld a, d
    adc a, $CB
    ld d, a
    ld c, $01
    ld a, b
    and a, $07
    jr z, Jump_000_186C
    ld b, a

Jump_000_1867::
    sla c
    dec b
    jr nz, Jump_000_1867

Jump_000_186C::
    ld a, [de]
    or a, c
    ld [de], a
    ret

Jump_000_1870::
    jr Jump_000_1870

Func_000_1872::
    ld a, [$4000]
    push af
    ld a, b
    ld [$2100], a
    ld a, [de]
    ld c, a
    pop af
    ld [$2100], a
    ret

Func_000_1881::
    ld a, b
    ld [$C52D], a

Jump_000_1885::
    push bc
    ld de, $2940
    ld c, $10

Jump_000_188B::
    di

Jump_000_188C::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_188C
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec c
    jr nz, Jump_000_188B
    pop bc
    dec b
    jr nz, Jump_000_1885
    ld a, [$C52D]
    ld b, a
    dec c
    jr nz, Jump_000_1885
    ret

Func_000_18A5::
    push hl
    push bc

Jump_000_18A7::
    di

Jump_000_18A8::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_18A8
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_18BE
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_18BE::
    inc de
    dec b
    jr nz, Jump_000_18A7
    pop bc
    pop hl
    dec c
    jr z, Jump_000_18D5
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr Func_000_18A5

Jump_000_18D5::
    ret

Func_000_18D6::
    ld a, [$4000]
    push af
    ld a, b
    ld [$2100], a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, [de]
    ld b, a
    pop af
    ld [$2100], a
    ret
    db $FA, $00, $40, $F5, $3E, $61, $EA, $00, $21, $F0, $C6, $6F, $26, $00, $29, $7D
    db $C6, $05, $6F, $7C, $CE, $67, $67, $3E, $02, $18, $19

Func_000_1906::
    ld a, [$4000]
    push af
    ld a, $61
    ld [$2100], a
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $D8
    ld l, a
    ld a, h
    adc a, $60
    ld h, a
    ld a, $14
    push af
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop af
    add a, l
    ld l, a
    ldh [$FFC6], a
    ld a, h
    adc a, $00
    ld h, a
    ldh [$FFC7], a
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [$4000]
    push af
    ld a, [hl]
    ld [$2100], a
    ld a, [$C190]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ldh a, [$FF92]
    call Func_000_1682
    ldh a, [$FF8F]
    ld c, a
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_000_1951
    inc h

Jump_000_1951::
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, $C198
    call Func_000_0CF5
    pop af
    ld [$2100], a
    ld a, [$C525]
    or a, a
    jr nz, Jump_000_1978
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr Jump_000_19A4

Jump_000_1978::
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [$2100], a
    ldh a, [$FFC8]
    ld l, a
    ldh a, [$FFC9]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    call Func_000_0CF5
    ld a, $00
    ldh [$FF70], a

Jump_000_19A4::
    pop af
    ld [$2100], a
    ret

Func_000_19A9::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_000_19B7
    ld hl, $4472
    ld b, $61
    rst $10
    ret

Jump_000_19B7::
    ld a, [$4000]
    push af
    ld a, $11
    ld [$2100], a
    call Func_000_1D7F
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_000_19CA
    inc h

Jump_000_19CA::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [de]
    ld b, $08

Jump_000_19D9::
    sla a
    jr c, Jump_000_19E6
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec b
    jr nz, Jump_000_19D9

Jump_000_19E6::
    ld a, l
    ldh [$FFC6], a
    ld a, h
    ldh [$FFC7], a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [$4000]
    push af
    ld a, [hl]
    ld [$2100], a
    ld a, [$C190]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ldh a, [$FF92]
    call Func_000_1682
    ldh a, [$FF8F]
    ld c, a
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_000_1A0E
    inc h

Jump_000_1A0E::
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, $C198
    call Func_000_0CF5
    pop af
    ld [$2100], a
    ld a, [$C525]
    or a, a
    jr nz, Jump_000_1A36
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr Jump_000_1A62

Jump_000_1A36::
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [$2100], a
    ldh a, [$FFC8]
    ld l, a
    ldh a, [$FFC9]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    call Func_000_0CF5
    ld a, $00
    ldh [$FF70], a

Jump_000_1A62::
    pop af
    ld [$2100], a
    ld hl, $43B8
    ld b, $84
    rst $10
    call Func_000_1B6F
    call Func_000_1A73
    ret

Func_000_1A73::
    ld a, [$CC44]
    bit 7, a
    jp nz, Jump_000_1AB3
    ldh a, [$FF90]
    ld c, a
    ld b, $00
    ld hl, $1AB4

Jump_000_1A83::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_000_1A89
    ret

Jump_000_1A89::
    cp a, c
    jr z, Jump_000_1A92
    inc hl
    inc hl
    inc hl
    inc b
    jr Jump_000_1A83

Jump_000_1A92::
    ld a, [$C88E]
    or a, a
    jr z, Jump_000_1AA9
    ld a, [$C891]
    dec a
    cp a, b
    jr nz, Jump_000_1AA9
    ld de, $C88F
    ld a, b
    ldh [$FFC6], a
    call Func_000_1AD6
    ret

Jump_000_1AA9::
    ld e, l
    ld d, h
    inc de
    ld a, b
    ldh [$FFC6], a
    call Func_000_1AD6
    ret

Jump_000_1AB3::
    ret
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

Func_000_1AD6::
    ldh a, [$FF8F]
    swap a
    ld c, a
    ldh a, [$FF92]
    or a, c
    ld c, a
    inc de
    ld a, [de]
    cp a, c
    ret nz
    dec de
    push hl
    ld a, [de]
    and a, $0F
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld a, [de]
    and a, $0F
    add a, l
    ld l, a
    jr nc, Jump_000_1AFB
    inc h

Jump_000_1AFB::
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, [de]
    swap a
    and a, $0F
    sla a
    add a, l
    ld l, a
    jr nc, Jump_000_1B13
    inc h

Jump_000_1B13::
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, $46
    ld [hl+], a
    inc a
    ld [hl-], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_000_1B28
    inc h

Jump_000_1B28::
    ld a, $56
    ld [hl+], a
    inc a
    ld [hl], a
    pop hl
    ld a, [$C525]
    or a, a
    jr z, Jump_000_1B6D
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [$FF70], a
    ld c, $03
    ldh a, [$FFC6]
    cp a, $04
    jr z, Jump_000_1B5C
    cp a, $0A
    jr z, Jump_000_1B5C
    ld c, $05
    cp a, $05
    jr z, Jump_000_1B5C
    cp a, $06
    jr z, Jump_000_1B5C
    cp a, $07
    jr z, Jump_000_1B5C
    ld c, $01

Jump_000_1B5C::
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_000_1B66
    inc h

Jump_000_1B66::
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [$FF70], a

Jump_000_1B6D::
    pop hl
    ret

Func_000_1B6F::
    ld de, $012B
    call Func_000_181B
    ret nc
    ldh a, [$FF8F]
    or a, a
    ret nz
    ldh a, [$FF90]
    cp a, $0D
    jr nz, Jump_000_1B95
    ld hl, $C2E2
    ld [hl], $44
    inc hl
    ld [hl], $45
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_000_1B8F
    inc h

Jump_000_1B8F::
    ld [hl], $46
    inc hl
    ld [hl], $47
    ret

Jump_000_1B95::
    cp a, $05
    ret nz
    ld hl, $C1CA
    ld [hl], $78
    inc hl
    ld [hl], $79
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_000_1BA7
    inc h

Jump_000_1BA7::
    ld [hl], $7A
    inc hl
    ld [hl], $7B
    ret

Func_000_1BAD::
    ld a, [$4000]
    push af
    ld a, $61
    ld [$2100], a
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    sla l
    rl h
    ld a, l
    add a, $D8
    ld l, a
    ld a, h
    adc a, $60
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, $9000
    call Func_000_0CF5
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    call Func_000_24E5
    pop hl
    ld a, [hl+]
    ld [$C190], a
    ld a, [hl+]
    ld [$C191], a
    ld a, [hl+]
    ld [$C192], a
    ld a, [hl+]
    ld [$C193], a
    ld a, [hl+]
    ld [$C90D], a
    xor a, a
    ld [$C901], a
    ld [$C194], a
    ld [$C195], a
    ld [$C196], a
    pop af
    ld [$2100], a
    ret

Func_000_1C0C::
    ld a, [$CC44]
    bit 7, a
    jr z, Jump_000_1C1A
    ld hl, $420D
    ld b, $61
    rst $10
    ret

Jump_000_1C1A::
    ld a, [$4000]
    push af
    ld a, $11
    ld [$2100], a
    call Func_000_1D7F
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, $9000
    ldh a, [$FF90]
    cp a, $14
    jr nz, Jump_000_1C51
    ld hl, $8800
    call Func_000_0CF5
    ld de, $7861
    ld b, $48
    ld hl, $9000
    call Func_000_0CF5
    pop hl
    xor a, a
    ld [$C46B], a
    ld [$C46C], a
    jr Jump_000_1C55

Jump_000_1C51::
    call Func_000_0CF5
    pop hl

Jump_000_1C55::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    call Func_000_24E5
    pop hl
    ld a, [hl+]
    ld [$C190], a
    ld a, [hl+]
    ld [$C191], a
    ld a, [hl+]
    ld [$C192], a
    ld a, [hl+]
    ld [$C193], a
    ld a, [hl+]
    ld [$C90D], a
    ld a, [hl+]
    or a, $80
    ld [$C901], a
    ld a, [hl+]
    ld [$C194], a
    ld a, [hl+]
    ld [$C195], a
    or a, a
    jr z, Jump_000_1C93
    and a, $0F
    jr z, Jump_000_1C8F
    ld a, [hl+]
    ld [$C196], a
    jr Jump_000_1C93

Jump_000_1C8F::
    ld a, [hl+]
    ld [$C197], a

Jump_000_1C93::
    call Func_000_1D47
    call Func_000_1CB7
    call Func_000_1CA1
    pop af
    ld [$2100], a
    ret

Func_000_1CA1::
    ldh a, [$FF90]
    cp a, $19
    ret nz
    ld a, [$CC37]
    ret nz
    ld de, $00D1
    call Func_000_181B
    ret nc
    ld a, $0B
    ld [$C90D], a
    ret

Func_000_1CB7::
    ld a, [$CC37]
    bit 5, a
    ret nz
    bit 1, a
    ret z
    ldh a, [$FF90]
    cp a, $01
    jr z, Jump_000_1CCB
    cp a, $02
    jr z, Jump_000_1CE2
    ret

Jump_000_1CCB::
    ld de, $9500
    ld hl, $9510
    ld b, $10
    call Func_000_1CF9
    ld de, $1D07
    ld hl, $9120
    ld b, $40
    call Func_000_1CF9
    ret

Jump_000_1CE2::
    ld de, $9400
    ld hl, $9410
    ld b, $10
    call Func_000_1CF9
    ld de, $1D07
    ld hl, $92A0
    ld b, $40
    call Func_000_1CF9
    ret

Func_000_1CF9::
    di
    call Func_000_120A
    ld a, [de]
    ei
    call Func_000_121F
    inc de
    dec b
    jr nz, Func_000_1CF9
    ret
    db $FF, $1E, $E1, $21, $DF, $5F, $E2, $62, $9C, $9C, $A4, $A4, $C4, $C4, $CE, $4E
    db $FF, $78, $87, $84, $FB, $FA, $67, $66, $39, $39, $25, $25, $23, $23, $33, $32
    db $DF, $53, $FF, $62, $F6, $0A, $FF, $04, $FC, $04, $BF, $48, $FF, $10, $FF, $0F
    db $7B, $6A, $BF, $E6, $FF, $22, $9F, $10, $FD, $12, $8F, $08, $FF, $04, $FF, $F8

Func_000_1D47::
    ldh a, [$FF90]
    cp a, $30
    jr z, Jump_000_1D51
    cp a, $B8
    jr nz, Jump_000_1D5C

Jump_000_1D51::
    ld a, $11
    ld [$C195], a
    ld a, $2C
    ld [$C197], a
    ret

Jump_000_1D5C::
    cp a, $63
    jr c, Jump_000_1D6F
    cp a, $67
    jr nc, Jump_000_1D6F
    ld a, $22
    ld [$C195], a
    ld a, $30
    ld [$C197], a
    ret

Jump_000_1D6F::
    cp a, $70
    jr nz, Jump_000_1D7E
    ld a, $12
    ld [$C195], a
    ld a, $2C
    ld [$C197], a
    ret

Jump_000_1D7E::
    ret

Func_000_1D7F::
    ldh a, [$FF90]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, $44B8
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ret

Func_000_1D90::
    ld a, [$4000]
    push af
    ld a, $11
    ld [$2100], a
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $B8
    ld l, a
    ld a, h
    adc a, $44
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld l, e
    ld h, d
    ld a, $06
    add a, l
    ld l, a
    jr nc, Jump_000_1DB4
    inc h

Jump_000_1DB4::
    ld a, [$C5FA]
    ld c, a
    ld a, [hl+]
    ldh [$FFC6], a
    cp a, c
    jr z, Jump_000_1DC0
    jr nc, Jump_000_1DC7

Jump_000_1DC0::
    pop af
    ld [$2100], a
    ld a, $01
    ret

Jump_000_1DC7::
    ld a, [$C5FC]
    ld c, a
    ld a, [hl+]
    cp a, c
    jr z, Jump_000_1DC0
    jr c, Jump_000_1DC0
    ld a, $08
    add a, l
    ld l, a
    jr nc, Jump_000_1DD8
    inc h

Jump_000_1DD8::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [de]
    ld b, $08

Jump_000_1DE7::
    sla a
    jr c, Jump_000_1DF4
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec b
    jr nz, Jump_000_1DE7

Jump_000_1DF4::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [$2100], a
    ldh a, [$FFC6]
    ld c, a
    sla a
    add a, c
    ld c, a
    ld a, [$C5FC]
    call Func_000_1682
    ld a, [$C5FA]
    ld c, a
    sla a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_000_1E15
    inc h

Jump_000_1E15::
    add hl, de
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    or a, c
    jr nz, Jump_000_1E23
    pop af
    ld [$2100], a
    ld a, $01
    ret

Jump_000_1E23::
    pop af
    ld [$2100], a
    xor a, a
    ret

Func_000_1E29::
    push hl
    ld de, $C198
    ld bc, $1412

Jump_000_1E30::
    push hl
    push bc

Jump_000_1E32::
    di
    ld a, [de]
    call Func_000_121F
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1E45
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1E45::
    inc de
    dec b
    jr nz, Jump_000_1E32
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1E5B
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_000_1E55
    inc h

Jump_000_1E55::
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1E30

Jump_000_1E5B::
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    ld de, $D000
    ld bc, $1412

Jump_000_1E6F::
    push hl
    push bc

Jump_000_1E71::
    di
    ld a, [de]
    and a, $07
    call Func_000_121F
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1E86
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1E86::
    inc de
    dec b
    jr nz, Jump_000_1E71
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1E9C
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_000_1E96
    inc h

Jump_000_1E96::
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1E6F

Jump_000_1E9C::
    ld a, $00
    ldh [$FF70], a
    ld a, $00
    ldh [$FF4F], a
    ret

Func_000_1EA5::
    ld de, $C198
    ld a, [$C8CB]
    bit 7, a
    jr z, Jump_000_1EC1
    ld a, $64
    add a, e
    ld e, a
    jr nc, Jump_000_1EB6
    inc d

Jump_000_1EB6::
    ld a, $A0
    add a, l
    ld l, a
    jr nc, Jump_000_1EBD
    inc h

Jump_000_1EBD::
    ld a, h
    and a, $9B
    ld h, a

Jump_000_1EC1::
    push de
    push hl
    ld bc, $140D

Jump_000_1EC6::
    push hl
    push bc

Jump_000_1EC8::
    di

Jump_000_1EC9::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_1EC9
    ld a, [de]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1EDF
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1EDF::
    inc de
    dec b
    jr nz, Jump_000_1EC8
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1EF5
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_000_1EEF
    inc h

Jump_000_1EEF::
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1EC6

Jump_000_1EF5::
    pop hl
    pop de
    ld a, [$C525]
    or a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    ld a, e
    add a, $68
    ld e, a
    ld a, d
    adc a, $0E
    ld d, a
    ld bc, $140D

Jump_000_1F0F::
    push hl
    push bc

Jump_000_1F11::
    di

Jump_000_1F12::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_1F12
    ld a, [de]
    and a, $07
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_000_1F2A
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_000_1F2A::
    inc de
    dec b
    jr nz, Jump_000_1F11
    pop bc
    pop hl
    dec c
    jr z, Jump_000_1F40
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_000_1F3A
    inc h

Jump_000_1F3A::
    ld a, h
    and a, $9B
    ld h, a
    jr Jump_000_1F0F

Jump_000_1F40::
    ld a, $00
    ldh [$FF70], a
    ld a, $00
    ldh [$FF4F], a
    ret

Func_000_1F49::
    push bc
    call Func_000_24C5
    ld c, $A5
    call Func_000_1682
    ld bc, $A000
    add hl, bc
    pop bc
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_000_1F5D
    inc h

Jump_000_1F5D::
    ret

Func_000_1F5E:: ; heuristic: follows a terminator; C0
    push hl
    push de
    call Func_000_1F49
    ld de, $FFC6

Jump_000_1F66::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_000_1F66
    pop de
    pop hl
    ret

Func_000_1F6F:: ; heuristic: follows a terminator; C0
    push hl
    push de
    call Func_000_1F49
    ld de, $FFC6

Jump_000_1F77::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_1F77
    pop de
    pop hl
    ret

Func_000_1F80::
    push hl
    call Func_000_1FD1
    ld a, [hl]
    ldh [$FFC6], a
    pop hl
    ret

Func_000_1F89::
    push hl
    call Func_000_1FD1
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, [hl]
    ldh [$FFC7], a
    pop hl
    ret

Func_000_1F95::
    push hl
    call Func_000_1FD1
    ld a, [hl+]
    ldh [$FFC6], a
    ld a, [hl+]
    ldh [$FFC7], a
    ld a, [hl+]
    ldh [$FFC8], a
    pop hl
    ret

Func_000_1FA4::
    push hl
    push de
    call Func_000_1FD1
    ld de, $C8CF
    ld b, $0A
    ld a, [hl]
    cp a, $FF
    jr z, Jump_000_1FBD

Jump_000_1FB3::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_1FB3
    pop de
    pop hl
    sub a, a
    ret

Jump_000_1FBD::
    ld l, e
    ld h, d
    ld [hl], $98
    inc hl
    ld [hl], $98
    inc hl
    ld [hl], $98
    inc hl
    ld [hl], $90
    inc hl
    ld [hl], $90
    pop de
    pop hl
    scf
    ret

Func_000_1FD1::
    push bc
    ld c, $A5
    call Func_000_1682
    ld bc, $A000
    add hl, bc
    pop bc
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_000_1FE2
    inc h

Jump_000_1FE2::
    ret

Func_000_1FE3::
    push bc
    push de
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld a, [$4000]
    push af
    ld a, $38
    ld [$2100], a
    ld de, $4001
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    pop af
    ld [$2100], a
    pop hl
    call Func_000_0CF5
    pop de
    pop bc
    ld a, [$C525]
    or a, a
    ret z
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, $4209
    add hl, de
    ld e, l
    ld d, h
    ld b, $7B
    ld a, c
    sla a
    sla a
    sla a
    ld hl, $C49F
    add a, l
    ld l, a
    jr nc, Jump_000_2032
    inc h

Jump_000_2032::
    ld c, $10
    call Func_000_0B18
    ret

Func_000_2038::
    ld a, [$4000]
    push af
    ld a, $38
    ld [$2100], a
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld de, $447E
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    jr z, Jump_000_2056
    ld a, [hl+]
    ld d, a
    ld l, [hl]
    ld a, l
    jr Jump_000_205B

Jump_000_2056::
    ld de, $20E9
    ld a, $00

Jump_000_205B::
    ld [$2100], a
    pop hl
    ld a, $02
    ldh [$FF70], a
    ld bc, $0606

Jump_000_2066::
    push hl
    push bc

Jump_000_2068::
    di
    ld a, [de]
    push bc
    ld c, a
    ldh a, [$FFC6]
    add a, c
    pop bc
    call Func_000_121F
    ei
    inc de
    dec b
    jr nz, Jump_000_2068
    pop bc
    pop hl
    dec c
    jr z, Jump_000_2087
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_000_2066

Jump_000_2087::
    ld a, $00
    ldh [$FF70], a
    pop af
    ld [$2100], a
    ret

Func_000_2090::
    ld a, [$4000]
    push af
    ld a, $38
    ld [$2100], a
    push hl
    ld l, e
    ld h, d
    add hl, hl
    add hl, de
    ld de, $447E
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    jr z, Jump_000_20AE
    ld a, [hl+]
    ld d, a
    ld l, [hl]
    ld a, l
    jr Jump_000_20B3

Jump_000_20AE::
    ld de, $20E9
    ld a, $00

Jump_000_20B3::
    ld [$2100], a
    ld a, $01
    ldh [$FF4F], a
    pop hl
    ld bc, $0606

Jump_000_20BE::
    push hl
    push bc

Jump_000_20C0::
    di
    ld a, [de]
    push bc
    ld c, a
    ldh a, [$FFC6]
    add a, c
    pop bc
    call Func_000_121F
    ei
    inc de
    dec b
    jr nz, Jump_000_20C0
    pop bc
    pop hl
    dec c
    jr z, Jump_000_20DF
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_000_20BE

Jump_000_20DF::
    ld c, $4F
    ld a, $00
    ldh [c], a
    pop af
    ld [$2100], a
    ret
    ds $24, $00

Func_000_210D::
    push hl
    ld hl, $C8C1
    ld a, [hl+]
    or a, a
    jr z, Jump_000_2119
    add a, $E0
    jr Jump_000_211B

Jump_000_2119::
    ld a, $C3

Jump_000_211B::
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0

Jump_000_2120::
    ld [de], a
    pop hl
    ret

Func_000_2123::
    push hl
    ld c, $00
    ld hl, $C8C0
    ld a, [hl+]
    or a, a
    jr z, Jump_000_2133
    add a, $E0
    ld c, $01
    jr Jump_000_2135

Jump_000_2133::
    ld a, $C3

Jump_000_2135::
    ld [de], a
    inc de
    ld a, [hl+]
    bit 0, c
    jr nz, Jump_000_213F
    or a, a
    jr z, Jump_000_2145

Jump_000_213F::
    add a, $E0
    ld c, $01
    jr Jump_000_2147

Jump_000_2145::
    ld a, $C3

Jump_000_2147::
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    pop hl
    ret

Func_000_214F::
    push hl
    ld c, $00
    ld hl, $FFC9
    ld a, [hl-]
    and a, $0F
    jr z, Jump_000_2160
    ld c, $01
    add a, $E0
    jr Jump_000_2162

Jump_000_2160::
    ld a, $C3

Jump_000_2162::
    ld [de], a
    inc de
    ld b, $03

Jump_000_2166::
    ld a, [hl]
    srl a
    srl a
    srl a
    srl a
    bit 0, c
    jr nz, Jump_000_2177
    and a, $0F
    jr z, Jump_000_217D

Jump_000_2177::
    ld c, $01
    add a, $E0
    jr Jump_000_217F

Jump_000_217D::
    ld a, $C3

Jump_000_217F::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_2186
    ld c, $01

Jump_000_2186::
    inc b
    ld a, [hl-]
    and a, $0F
    bit 0, c
    jr nz, Jump_000_2192
    and a, $0F
    jr z, Jump_000_2198

Jump_000_2192::
    ld c, $01
    add a, $E0
    jr Jump_000_219A

Jump_000_2198::
    ld a, $C3

Jump_000_219A::
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_2166
    pop hl
    ret

Func_000_21A1::
    ld a, [$4000]
    push af
    ld a, $1F
    ld [$2100], a
    ld hl, $C8CF
    ld c, $0B

Jump_000_21AF::
    push bc
    ld a, [hl+]
    cp a, $F0
    jr nz, Jump_000_21BB
    pop bc
    pop af
    ld [$2100], a
    ret

Jump_000_21BB::
    push hl
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld bc, $4010
    add hl, bc
    ld b, $10

Jump_000_21CC::
    di

Jump_000_21CD::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_21CD
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, Jump_000_21CC
    pop hl
    ld a, [hl]
    cp a, $8D
    jr z, Jump_000_21E6
    cp a, $8E
    jr z, Jump_000_21ED
    jr Jump_000_2221

Jump_000_21E6::
    inc hl
    push hl
    ld hl, $48E0
    jr Jump_000_21F2

Jump_000_21ED::
    inc hl
    push hl
    ld hl, $48F0

Jump_000_21F2::
    ld b, $10
    ld a, e
    sub a, $10
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a

Jump_000_21FC::
    ld a, [hl+]
    ld c, a
    di

Jump_000_21FF::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_21FF
    ld a, [de]
    ei
    or a, c
    push af
    ld a, b
    cp a, $0D
    jr nz, Jump_000_2212
    pop af
    and a, $FD
    push af

Jump_000_2212::
    di

Jump_000_2213::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_2213
    pop af
    ld [de], a
    ei
    inc de
    dec b
    jr nz, Jump_000_21FC
    pop hl

Jump_000_2221::
    pop bc
    dec c
    jp nz, Jump_000_21AF
    pop af
    ld [$2100], a
    ret

Func_000_222B::
    ld a, $90
    ld [$C8CF], a
    ld [$C8D0], a
    ld [$C8D1], a
    ld [$C8D2], a
    ld [$C8D3], a
    ld a, $F0
    ld [$C8D4], a
    ld de, $8D00
    call Func_000_21A1
    ld de, $8D50
    call Func_000_21A1
    ld de, $8DA0
    call Func_000_21A1
    ld a, $0A
    ld [$0100], a
    ld a, [$C6FD]
    or a, a
    ret z
    ld b, a
    ld hl, $C6FE
    ld de, $8D00

Jump_000_2264::
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    pop de
    push de
    call Func_000_21A1
    pop de
    ld a, $50
    add a, e
    ld e, a
    jr nc, Jump_000_227F
    inc d

Jump_000_227F::
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_000_2264
    xor a, a
    ld [$0100], a
    ret

Func_000_228A::
    ld a, [$C6FD]
    or a, a
    ret z
    ld b, a
    ld hl, $C701
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    ld hl, $8100
    ld a, l
    ldh [$FFC8], a
    ld a, h
    ldh [$FFC9], a
    ld de, $C6FE

Jump_000_22A5::
    push bc
    push de
    ld a, $0A
    ld [$0100], a
    push de
    ld a, [de]
    ld c, $55
    call Func_000_1F80
    pop de
    ldh a, [$FFC6]
    bit 7, a
    jr z, Jump_000_2304
    xor a, a
    ld [$0100], a
    ldh a, [$FFCA]
    ld c, a
    ldh a, [$FFCB]
    ld b, a
    ld a, $FF
    ld [bc], a
    inc bc
    ld [bc], a
    ld de, $545E
    ld b, $7E
    ldh a, [$FFC8]
    ld l, a
    ldh a, [$FFC9]
    ld h, a
    call Func_000_0CF5
    ld a, [$C525]
    or a, a
    jp z, Jump_000_2378
    pop de
    pop bc
    push bc
    push de
    ld a, $03
    sub a, b
    inc a
    add a, a
    add a, a
    add a, a
    ld hl, $C4DF
    add a, l
    ld l, a
    jr nc, Jump_000_22F1
    inc h

Jump_000_22F1::
    ld a, $C8
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_000_22FB
    inc d

Jump_000_22FB::
    ld b, $7E
    ld c, $08
    call Func_000_0B18
    jr Jump_000_2378

Jump_000_2304::
    ld a, [de]
    ld c, $0B
    call Func_000_1F89
    xor a, a
    ld [$0100], a
    ldh a, [$FFC6]
    ld e, a
    ldh a, [$FFC7]
    ld d, a
    ld l, e
    ld h, d
    ldh a, [$FFCA]
    ld c, a
    ldh a, [$FFCB]
    ld b, a
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    add hl, hl
    add hl, de
    ld de, $4EAA
    add hl, de
    ld a, [$4000]
    push af
    ld a, $04
    ld [$2100], a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    pop af
    ld [$2100], a
    ldh a, [$FFC8]
    ld l, a
    ldh a, [$FFC9]
    ld h, a
    call Func_000_0CF5
    ld a, [$C525]
    or a, a
    jr z, Jump_000_2378
    pop de
    pop bc
    push bc
    push de
    ld a, $03
    sub a, b
    inc a
    add a, a
    add a, a
    add a, a
    ld hl, $C4DF
    add a, l
    ld l, a
    jr nc, Jump_000_235C
    inc h

Jump_000_235C::
    push hl
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
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
    pop hl
    ld c, $08
    call Func_000_0B18

Jump_000_2378::
    ldh a, [$FFC9]
    inc a
    ldh [$FFC9], a
    ldh a, [$FFCA]
    add a, $02
    ldh [$FFCA], a
    ldh a, [$FFCB]
    adc a, $00
    ldh [$FFCB], a
    pop de
    inc de
    pop bc
    dec b
    jp nz, Jump_000_22A5
    ret

Func_000_2391::
    ldh [$FFCC], a
    ld c, $6F
    call Func_000_1F80
    call Func_000_23BD
    ld a, $09
    call Func_000_1682
    ld b, l
    ldh a, [$FFCC]
    ld c, $72
    call Func_000_1F80
    call Func_000_23BD
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    ldh a, [$FFCC]
    ld c, $70
    call Func_000_1F80
    call Func_000_23BD
    ld a, c
    add a, b
    ret

Func_000_23BD::
    ldh a, [$FFC6]
    ld c, $00
    cp a, $C0
    ret nc
    inc c
    cp a, $40
    ret nc
    inc c
    ret

Func_000_23CA:: ; heuristic: follows a terminator; C0
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [$FFC7]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [$FFC8]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [$FFC9]
    or a, a
    jr nz, Jump_000_23E4
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ret

Jump_000_23E4::
    ld c, $00
    ldh a, [$FFC9]
    or a, a
    jr z, Jump_000_23EF
    ld [de], a
    inc de
    ld c, $01

Jump_000_23EF::
    ld b, $03
    ld hl, $FFC8

Jump_000_23F4::
    ld a, [hl]
    swap a
    and a, $0F
    bit 0, c
    jr nz, Jump_000_2400
    or a, a
    jr z, Jump_000_2404

Jump_000_2400::
    ld [de], a
    inc de
    ld c, $01

Jump_000_2404::
    ld a, [hl]
    and a, $0F
    bit 0, c
    jr nz, Jump_000_240E
    or a, a
    jr z, Jump_000_2412

Jump_000_240E::
    ld [de], a
    inc de
    ld c, $01

Jump_000_2412::
    dec hl
    dec b
    jr nz, Jump_000_23F4
    ld a, $F0
    ld [de], a
    ret

Func_000_241A::
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $58
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [$4000]
    push af
    ld a, $08
    ld [$2100], a
    jr Jump_000_2447

Func_000_2431::
    sla a
    ld l, a
    ld h, $00
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $47
    ld h, a
    ld a, [$4000]
    push af
    ld a, $08
    ld [$2100], a

Jump_000_2447::
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

Jump_000_244C::
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, Jump_000_244C
    pop af
    ld [$2100], a
    ret

Func_000_2458::
    cp a, $FE
    jr nz, Jump_000_2482
    ld a, $16
    ld [de], a
    inc de
    ld a, $24
    ld [de], a
    inc de
    ld a, $2A
    ld [de], a
    inc de
    ld a, $2C
    ld [de], a
    inc de
    ld a, $26
    ld [de], a
    inc de
    ld a, $90
    ld [de], a
    inc de
    ld a, $14
    ld [de], a
    inc de
    ld a, $28
    ld [de], a
    inc de
    ld a, $3C
    ld [de], a
    inc de
    jr Jump_000_249E

Jump_000_2482::
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl+]
    inc a
    push hl
    call Func_000_24A2
    pop hl
    dec de
    ld a, [hl]
    add a, $11
    call Func_000_24A2
    dec de

Jump_000_249E::
    ld a, $F0
    ld [de], a
    ret

Func_000_24A2::
    add a, a
    ld hl, $4078
    add a, l
    ld l, a
    jr nc, Jump_000_24AB
    inc h

Jump_000_24AB::
    ld a, [$4000]
    push af
    ld a, $09
    ld [$2100], a
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

Jump_000_24B9::
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, Jump_000_24B9
    pop af
    ld [$2100], a
    ret

Func_000_24C5::
    push bc
    ld b, a
    ld a, [$C58A]
    or a, a
    jr z, Jump_000_24D7
    ld a, [$C5DB]
    cp a, $04
    jr nz, Jump_000_24D7
    ld a, b
    pop bc
    ret

Jump_000_24D7::
    ld a, b
    pop bc
    ld hl, $C6FE
    and a, $7F
    add a, l
    ld l, a
    jr nc, Jump_000_24E3
    inc h

Jump_000_24E3::
    ld a, [hl]
    ret

Func_000_24E5::
    ld a, [$C525]
    or a, a
    ret z
    ld hl, $C49F
    ld c, $40
    call Func_000_0B18
    ld a, $7F
    ld [$C526], a
    ret

Func_000_24F8::
    push bc
    push de
    push hl
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    and a, $1F
    ld b, a
    ld a, $20
    sub a, b
    ld b, a
    ld a, $14
    sub a, b
    bit 7, a
    jr nz, Jump_000_2528
    pop hl
    push hl
    ld d, a
    ld a, l
    and a, $1F
    cp a, d
    jr nc, Jump_000_2528
    pop hl
    pop de
    pop bc
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, $FF
    ret

Jump_000_2528::
    pop hl
    pop de
    pop bc
    xor a, a
    ret

Func_000_252D::
    ld a, [$C5DB]
    cp a, $01
    jr nz, Jump_000_253C
    ld a, [$C5DC]
    and a, $0F
    cp a, $06
    ret z

Jump_000_253C::
    ld hl, $FFA1
    ld a, [hl+]
    sub a, $09
    cpl
    ldh [$FFD2], a
    ld a, [hl]
    sbc a, $00
    cpl
    ldh [$FFD3], a
    ld hl, $FFA5
    ld a, [hl+]
    sub a, $11
    cpl
    ldh [$FFD4], a
    ld a, [hl]
    sbc a, $00
    cpl
    ldh [$FFD5], a
    ret

Jump_000_255B::
    push af
    push bc
    push de
    push hl
    ld hl, $4001
    ld b, $1B
    rst $10
    pop hl
    pop de
    pop bc
    pop af
    reti

Jump_000_256A::
    push af
    push hl
    push de
    ldh a, [$FF70]
    ld d, a
    xor a, a
    ldh [$FF70], a
    push de
    ld a, [$C5E1]
    and a, $03
    rst $00
    dw Jump_000_2582
    dw Jump_000_2589
    dw Jump_000_258B
    dw Jump_000_25AA

Jump_000_2582::
    pop af
    ldh [$FF70], a
    pop de
    pop hl
    pop af
    reti

Jump_000_2589::
    jr Jump_000_2582

Jump_000_258B::
    ldh a, [$FF44]
    ld hl, $C0F0
    add a, l
    ld l, a
    jr nc, Jump_000_2595
    inc h

Jump_000_2595::
    ld a, [hl]
    ldh [$FF43], a
    ldh a, [$FF45]
    add a, $02
    cp a, $90
    jr c, Jump_000_25A6
    ldh a, [$FFA1]
    ldh [$FF43], a
    ld a, $00

Jump_000_25A6::
    ldh [$FF45], a
    jr Jump_000_2582

Jump_000_25AA::
    ldh a, [$FF44]
    ld hl, $C0F0
    add a, l
    ld l, a
    jr nc, Jump_000_25B4
    inc h

Jump_000_25B4::
    ld a, [hl]
    ldh [$FF42], a
    ldh a, [$FF45]
    add a, $02
    cp a, $81
    jr c, Jump_000_25C5
    ldh a, [$FFA5]
    ldh [$FF42], a
    ld a, $00

Jump_000_25C5::
    ldh [$FF45], a
    jr Jump_000_2582

Func_000_25C9::
    push de
    call Func_000_290E
    ld a, [$C52D]
    ld [$C531], a
    ld [$C535], a
    ld a, [$C52E]
    ld [$C532], a
    ld [$C536], a
    pop de
    call Func_000_2E40
    ld a, e
    ld [$C533], a
    ld [$C537], a
    ld a, d
    ld [$C534], a
    ld [$C538], a
    ld a, $01
    ld [$C52B], a
    xor a, a
    ld [$C52C], a
    ld [$C54F], a
    ret

Func_000_25FE::
    call Func_000_2E40
    ld a, [$C53D]
    ld l, a
    ld a, [$C53E]
    ld h, a

Jump_000_2609::
    ld a, [de]
    ld [hl+], a
    inc de
    cp a, $F0
    jr nz, Jump_000_2609
    ret

Func_000_2611::
    ld hl, $C52B
    set 1, [hl]

Jump_000_2616::
    call Func_000_2620
    ld a, [$C52B]
    or a, a
    jr nz, Jump_000_2616
    ret

Func_000_2620::
    ld a, [$C52C]
    bit 7, a
    jr z, Func_000_2637

Jump_000_2627::
    ld hl, $C52B
    set 1, [hl]
    call Func_000_2637
    ld a, [$C52C]
    bit 7, a
    jr nz, Jump_000_2627
    ret

Func_000_2637::
    ld a, [$4000]
    push af
    ld a, [$C52A]
    ld [$2100], a
    ld a, [$C52C]
    bit 2, a
    jp nz, Jump_000_2847
    ld a, [$C52B]
    or a, a
    jp z, Jump_000_2875
    bit 5, a
    jr z, Jump_000_266E
    ld c, $BD
    ld a, [$C5F0]
    bit 4, a
    jr z, Jump_000_265F
    ld c, $B4

Jump_000_265F::
    ld hl, $0060
    call Func_000_305E
    ld b, $09
    call Func_000_3048
    ld a, c
    call Func_000_1211

Jump_000_266E::
    ld a, [$C52B]
    bit 2, a
    jp z, Jump_000_2764
    ld a, [$C550]
    cp a, $E6
    jr z, Jump_000_2685
    ld a, [$C550]
    cp a, $FF
    jp nz, Jump_000_274A

Jump_000_2685::
    ld a, [$C563]
    ld b, a
    ld a, [$C567]
    or a, b
    bit 6, a
    jr z, Jump_000_26A2
    ld a, [$C552]
    and a, $01
    xor a, $01
    ld [$C552], a
    ld a, $69
    call Func_000_1278
    jr Jump_000_26B5

Jump_000_26A2::
    bit 7, a
    jr z, Jump_000_26B5
    ld a, [$C552]
    and a, $01
    xor a, $01
    ld [$C552], a
    ld a, $69
    call Func_000_1278

Jump_000_26B5::
    ld c, $BB
    ld b, $C3
    ld a, [$C552]
    or a, a
    jr z, Jump_000_26C3
    ld c, $C3
    ld b, $BB

Jump_000_26C3::
    ld a, [$C5F0]
    bit 4, a
    jr z, Jump_000_26CE
    ld c, $C3
    ld b, $C3

Jump_000_26CE::
    push bc
    ld hl, $0120
    call Func_000_3072
    ld b, $0F
    call Func_000_3048
    pop bc
    ld a, c
    call Func_000_1211
    push bc
    ld hl, $0160
    call Func_000_3072
    ld b, $0F
    call Func_000_3048
    pop bc
    ld a, b
    call Func_000_1211
    ld a, [$C562]
    ld b, a
    ld a, [$C566]
    or a, b
    bit 0, a
    jr z, Jump_000_2711
    ld a, [$C552]
    or a, a
    jr nz, Jump_000_2716
    ld a, [$C550]
    cp a, $E6
    jp z, Jump_000_271B
    ld a, $69
    call Func_000_1278
    jr Jump_000_271B

Jump_000_2711::
    bit 1, a
    jp z, Jump_000_2875

Jump_000_2716::
    ld a, $01
    ld [$C552], a

Jump_000_271B::
    ld hl, $C52B
    res 2, [hl]
    res 1, [hl]
    push de
    ld hl, $9800
    ldh a, [$FFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [$FFA1]
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_000_2743
    inc h

Jump_000_2743::
    pop de
    call Func_000_1EA5
    jp Jump_000_2875

Jump_000_274A::
    ld a, [$C562]
    ld b, a
    ld a, [$C566]
    or a, b
    and a, $F7
    jp z, Jump_000_2875
    ld hl, $C52B
    res 2, [hl]
    res 1, [hl]
    call Func_000_2BFA
    jp Jump_000_2875

Jump_000_2764::
    bit 6, a
    jr z, Jump_000_278B
    ld a, [$C53B]
    dec a
    ld [$C53B], a
    or a, a
    jp z, Jump_000_2780
    ld a, [$C562]
    ld b, a
    ld a, [$C566]
    or a, b
    and a, $F7
    jp z, Jump_000_2875

Jump_000_2780::
    ld hl, $C52B
    res 6, [hl]
    call Func_000_2BFA
    jp Jump_000_2875

Jump_000_278B::
    bit 7, a
    jr z, Jump_000_27A2
    ld a, [$C53C]
    dec a
    ld [$C53C], a
    or a, a
    jp nz, Jump_000_2875
    ld hl, $C52B
    res 7, [hl]
    jp Jump_000_2875

Jump_000_27A2::
    ld a, [$C533]
    ld l, a
    ld a, [$C534]
    ld h, a
    ld a, [hl]
    cp a, $8D
    jr z, Jump_000_2816
    cp a, $8E
    jr z, Jump_000_2816
    cp a, $E0
    jr nc, Jump_000_282C
    ld a, [$C52B]
    bit 1, a
    jr nz, Jump_000_27E5
    ld a, [$C562]
    ld b, a
    ld a, [$C566]
    or a, b
    and a, $F7
    jr z, Jump_000_27CF
    ld hl, $C52C
    set 7, [hl]

Jump_000_27CF::
    ld a, [$C964]
    ld b, a
    ld a, [$C52B]
    bit 3, a
    jr z, Jump_000_27DE
    ld a, [$C539]
    ld b, a

Jump_000_27DE::
    ld a, [$C54F]
    cp a, b
    jp c, Jump_000_2875

Jump_000_27E5::
    xor a, a
    ld [$C54F], a
    ld hl, $C52C
    res 1, [hl]
    call Func_000_2E5D
    ld a, [hl]
    cp a, $E0
    jr nc, Jump_000_282C
    call Func_000_287E
    ld a, [$C52C]
    bit 0, a
    jr z, Jump_000_2875
    ld a, b
    cp a, $90
    jr z, Jump_000_2875
    cp a, $9A
    jr z, Jump_000_2875
    ld a, [$C556]
    call Func_000_1278
    ld hl, $C52C
    set 1, [hl]
    jr Jump_000_2875

Jump_000_2816::
    ld a, [$C533]
    add a, $01
    ld [$C533], a
    ld a, [$C534]
    adc a, $00
    ld [$C534], a
    ld a, [hl]
    call Func_000_28AB
    jr Jump_000_2875

Jump_000_282C::
    ld a, [$C533]
    add a, $01
    ld [$C533], a
    ld a, [$C534]
    adc a, $00
    ld [$C534], a
    ld a, [hl]
    call Func_000_2950
    ld hl, $C52C
    res 1, [hl]
    jr Jump_000_2875

Jump_000_2847::
    ld a, [$DC00]
    ld hl, $DC01
    and a, [hl]
    ld hl, $DC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, $DCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    jr nz, Jump_000_2875
    ld hl, $C52C
    res 2, [hl]

Jump_000_2875::
    ld hl, $C54F
    inc [hl]
    pop af
    ld [$2100], a
    ret

Func_000_287E::
    ld l, a
    ld a, [$4000]
    push af
    ld a, $1F
    ld [$2100], a
    call Func_000_28F4
    ld c, $08

Jump_000_288D::
    di

Jump_000_288E::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_288E
    ld a, [de]
    ld [hl+], a
    inc e
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec c
    jr nz, Jump_000_288D
    ld a, l
    ld [$C531], a
    ld a, h
    ld [$C532], a
    pop af
    ld [$2100], a
    ret

Func_000_28AB::
    ld l, a
    ld a, [$4000]
    push af
    ld a, $1F
    ld [$2100], a
    call Func_000_28BD
    pop af
    ld [$2100], a
    ret

Func_000_28BD::
    call Func_000_28F4
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld b, $10

Jump_000_28CA::
    di
    ld a, b
    cp a, $0D
    jr z, Jump_000_28DB

Jump_000_28D0::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_28D0
    ld a, [de]
    or a, [hl]
    ld [hl+], a
    jr Jump_000_28E6

Jump_000_28DB::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_28DB
    ld a, [de]
    or a, [hl]
    and a, $FD
    ld [hl+], a

Jump_000_28E6::
    ei
    inc de
    dec b
    jr nz, Jump_000_28CA
    ld a, l
    ld [$C531], a
    ld a, h
    ld [$C532], a
    ret

Func_000_28F4::
    ld de, $4010
    ld a, l
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    ld a, [$C531]
    ld l, a
    ld a, [$C532]
    ld h, a
    ret

Func_000_290E::
    ld hl, $C52F
    ld a, [hl+]
    or a, [hl]
    ret z
    ld a, [$C52D]
    ld l, a
    ld a, [$C52E]
    ld h, a
    ld a, [$C530]
    ld c, a

Jump_000_2920::
    ld a, [$C52F]
    ld b, a

Jump_000_2924::
    push bc
    ld b, $10
    ld de, $2940

Jump_000_292A::
    di

Jump_000_292B::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_000_292B
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    dec b
    jr nz, Jump_000_292A
    pop bc
    dec b
    jr nz, Jump_000_2924
    dec c
    jr nz, Jump_000_2920
    ret
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

Func_000_2950::
    ld [$C550], a
    sub a, $E0
    rst $00
    dw Jump_000_2996
    dw Jump_000_2996
    dw Jump_000_2996
    dw Jump_000_2996
    dw Jump_000_2996
    dw Jump_000_29A8
    dw Jump_000_29BA
    dw Jump_000_29BD
    dw Jump_000_29CB
    dw Jump_000_29FA
    dw Jump_000_2A25
    dw Jump_000_2A30
    dw Jump_000_2A3B
    dw Jump_000_2A6D
    dw Jump_000_2A73
    dw Jump_000_2B09
    dw Jump_000_2BCD
    dw Jump_000_2C21
    dw Jump_000_2C48
    dw Jump_000_2C51
    dw Func_000_2C6A
    dw Jump_000_2C75
    dw Jump_000_2C7B
    dw Jump_000_2CAD
    dw Jump_000_2CB8
    dw Jump_000_2CC5
    dw Jump_000_2CFD
    dw Jump_000_2D03
    dw Jump_000_2D15
    dw Jump_000_2D27
    dw Jump_000_2D2D
    dw Func_000_2D33

Jump_000_2996::
    ld hl, $C52C
    res 7, [hl]
    call Func_000_2E5D
    ld a, [hl]
    call Func_000_1278
    ld hl, $C52C
    set 2, [hl]
    ret

Jump_000_29A8::
    ld hl, $C52C
    res 7, [hl]
    call Func_000_2E5D
    ld a, [hl]
    call Func_000_122D
    ld hl, $C52C
    set 2, [hl]
    ret

Jump_000_29BA::
    jp Func_000_2D33

Jump_000_29BD::
    call Func_000_2D33
    ld a, $01
    ld [$C552], a
    ld a, $FF
    ld [$C550], a
    ret

Jump_000_29CB::
    call Func_000_2E5D
    ld d, $00
    ld e, [hl]
    call Func_000_2E5D
    ld c, [hl]
    ld a, [$C530]
    call Func_000_1682
    add hl, de
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, [$C52D]
    ld e, a
    ld a, [$C52E]
    ld d, a
    add hl, de
    ld a, l
    ld [$C531], a
    ld a, h
    ld [$C532], a
    ld a, l
    ld [$C535], a
    ld a, h
    ld [$C536], a
    ret

Jump_000_29FA::
    call Func_000_2E5D
    ld a, [hl]
    cp a, $FF
    jr z, Jump_000_2A1A
    cp a, $60
    jr c, Jump_000_2A16
    cp a, $CC
    jr z, Jump_000_2A16
    cp a, $CF
    jr z, Jump_000_2A16
    cp a, $D6
    jr z, Jump_000_2A16
    call Func_000_1278
    ret

Jump_000_2A16::
    call Func_000_122D
    ret

Jump_000_2A1A::
    ld hl, $604B
    ld b, $02
    rst $10
    ret
    db $CD, $78, $12, $C9

Jump_000_2A25::
    ld hl, $C52C
    set 0, [hl]
    ld a, $6B
    ld [$C556], a
    ret

Jump_000_2A30::
    ld hl, $C52C
    set 0, [hl]
    ld a, $6A
    ld [$C556], a
    ret

Jump_000_2A3B::
    ld hl, $C52C
    res 7, [hl]
    ld a, [$C964]
    cp a, $07
    jr z, Jump_000_2A59
    ld hl, $2A66
    add a, l
    ld l, a
    jr nc, Jump_000_2A4F
    inc h

Jump_000_2A4F::
    ld a, [hl]
    ld [$C53C], a
    ld hl, $C52B
    set 7, [hl]
    ret

Jump_000_2A59::
    ld hl, $C52C
    res 7, [hl]
    ld hl, $C52B
    set 2, [hl]
    set 5, [hl]
    ret
    db $06, $0C, $14, $1A, $20, $28, $30

Jump_000_2A6D::
    ld hl, $C52C
    set 7, [hl]
    ret

Jump_000_2A73::
    ld a, [$C52D]
    ld e, a
    ld a, [$C52E]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    ld a, [$C554]
    ld l, a
    ld a, [$C555]
    ld h, a
    push bc

Jump_000_2A9C::
    ld a, e
    call Func_000_1211
    call Func_000_304F
    inc e
    dec b
    jr nz, Jump_000_2A9C
    ld hl, $0020
    call Func_000_305E
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    call Func_000_3095
    ld a, [$C530]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld c, l
    ld b, h
    push de
    ld a, [$C52D]
    ld e, a
    ld a, [$C52E]
    ld d, a
    add hl, de
    pop de

Jump_000_2AD2::
    ld a, $FF
    call Func_000_121F
    xor a, a
    call Func_000_121F
    dec bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_2AD2
    pop bc
    ld hl, $0040
    call Func_000_305E

Jump_000_2AE8::
    ld a, e
    call Func_000_1211
    call Func_000_304F
    inc e
    dec b
    jr nz, Jump_000_2AE8
    ld a, [$C535]
    ld l, a
    ld a, [$C536]
    ld h, a
    ld a, l
    ld [$C531], a
    ld a, h
    ld [$C532], a
    ld hl, $C52B
    res 1, [hl]
    ret

Jump_000_2B09::
    ld a, [$C530]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [$C52D]
    ld e, a
    ld a, [$C52E]
    ld d, a
    add hl, de
    ld a, [$C535]
    ld e, a
    ld a, [$C536]
    ld d, a
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    ld a, d
    or a, e
    jr z, Jump_000_2B45
    ld a, l
    ld [$C531], a
    ld a, h
    ld [$C532], a
    ld a, l
    ld [$C535], a
    ld a, h
    ld [$C536], a
    call Func_000_2E5D
    ret

Jump_000_2B45::
    ld a, [$C554]
    ld l, a
    ld a, [$C555]
    ld h, a
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    call Func_000_3095
    ld a, [$C52D]
    ld e, a
    ld a, [$C52E]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    ld hl, $0020
    call Func_000_305E
    ld a, e
    add a, b
    ld e, a

Jump_000_2B81::
    ld a, e
    call Func_000_1211
    call Func_000_304F
    inc e
    dec b
    jr nz, Jump_000_2B81
    ld hl, $0040
    call Func_000_305E
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    call Func_000_3095
    ld a, [$C530]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [$C52D]
    ld e, a
    ld a, [$C52E]
    ld d, a
    ld c, l
    ld b, h
    add hl, de

Jump_000_2BB5::
    di
    call Func_000_120A
    ld a, [hl+]
    ei
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_2BB5
    ld hl, $C52B
    set 7, [hl]
    ld a, $04
    ld [$C53C], a
    ret

Jump_000_2BCD::
    ld a, [$C52B]
    bit 4, a
    jp z, Jump_000_2BF1
    ld a, [$C52B]
    res 4, a
    ld [$C52B], a
    call Func_000_2BFA
    ld a, [$C537]
    ld l, a
    ld a, [$C538]
    ld h, a
    ld a, l
    ld [$C533], a
    ld a, h
    ld [$C534], a
    ret

Jump_000_2BF1::
    xor a, a
    ld [$C52B], a
    xor a, a
    ld [$C52C], a
    ret

Func_000_2BFA::
    ld a, [$C52B]
    bit 5, a
    ret z
    res 5, a
    ld [$C52B], a
    ld hl, $0060
    call Func_000_305E
    ld b, $09
    call Func_000_3048
    ld a, $B4
    call Func_000_1211
    ld a, [$C5DB]
    cp a, $04
    ret z
    ld a, $69
    call Func_000_1278
    ret

Jump_000_2C21::
    ld a, [$C530]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [$C535]
    ld e, a
    ld a, [$C536]
    ld d, a
    add hl, de
    ld a, l
    ld [$C531], a
    ld a, h
    ld [$C532], a
    ld a, l
    ld [$C535], a
    ld a, h
    ld [$C536], a
    ret

Jump_000_2C48::
    call Func_000_2BFA
    call Func_000_2C6A
    call Func_000_290E

Jump_000_2C51::
    ld a, [$C52D]
    ld l, a
    ld a, [$C52E]
    ld h, a
    ld a, l
    ld [$C531], a
    ld a, h
    ld [$C532], a
    ld a, l
    ld [$C535], a
    ld a, h
    ld [$C536], a
    ret

Func_000_2C6A::
    ld hl, $C52C
    res 7, [hl]
    ld hl, $C52B
    res 1, [hl]
    ret

Jump_000_2C75::
    ld hl, $C52B
    set 1, [hl]
    ret

Jump_000_2C7B::
    ld hl, $C60C
    ld de, $C53F
    ld b, $0A

Jump_000_2C83::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_2C83
    ld a, $F0
    ld [de], a
    ld hl, $C52B
    set 4, [hl]
    ld a, [$C533]
    ld l, a
    ld a, [$C534]
    ld h, a
    ld a, l
    ld [$C537], a
    ld a, h
    ld [$C538], a
    ld hl, $C53F
    ld a, l
    ld [$C533], a
    ld a, h
    ld [$C534], a
    ret

Jump_000_2CAD::
    ld hl, $C52B
    set 2, [hl]
    ld hl, $C52C
    res 7, [hl]
    ret

Jump_000_2CB8::
    ld hl, $C52B
    set 3, [hl]
    call Func_000_2E5D
    ld a, [hl]
    ld [$C539], a
    ret

Jump_000_2CC5::
    ld hl, $C52B
    set 4, [hl]
    ld a, [$C533]
    ld l, a
    ld a, [$C534]
    ld h, a
    ld a, l
    ld [$C537], a
    ld a, h
    ld [$C538], a
    ld a, [$C537]
    add a, $01
    ld [$C537], a
    ld a, [$C538]
    adc a, $00
    ld [$C538], a
    ld de, $C130
    ld a, [hl]
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, l
    ld [$C533], a
    ld a, h
    ld [$C534], a
    ret

Jump_000_2CFD::
    ld hl, $C52B
    set 5, [hl]
    ret

Jump_000_2D03::
    ld hl, $C52B
    set 6, [hl]
    call Func_000_2E5D
    ld a, [hl]
    ld [$C53B], a
    ld hl, $C52C
    res 7, [hl]
    ret

Jump_000_2D15::
    ld hl, $C52B
    set 7, [hl]
    call Func_000_2E5D
    ld a, [hl]
    ld [$C53C], a
    ld hl, $C52C
    res 7, [hl]
    ret

Jump_000_2D27::
    ld hl, $C52C
    set 0, [hl]
    ret

Jump_000_2D2D::
    ld hl, $C52C
    res 0, [hl]
    ret

Func_000_2D33::
    ld hl, $C52C
    res 7, [hl]
    ld a, $6C
    call Func_000_1278
    call Func_000_2D4A
    ld hl, $C52B
    set 2, [hl]
    xor a, a
    ld [$C552], a
    ret

Func_000_2D4A::
    call Func_000_2DD6
    ld de, Data_01F_4180
    ld hl, $8EE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4330
    ld hl, $8EF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $0100
    call Func_000_3072
    ld b, $0E
    call Func_000_3048
    push hl
    ld de, $2DFA

Jump_000_2D76::
    push hl

Jump_000_2D77::
    ld a, [de]
    inc de
    cp a, $FE
    jr z, Jump_000_2D9A
    cp a, $FD
    jr nz, Jump_000_2D92
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $03
    or a, $98
    ld h, a
    jr Jump_000_2D76

Jump_000_2D92::
    call Func_000_1211
    call Func_000_304F
    jr Jump_000_2D77

Jump_000_2D9A::
    pop hl
    pop hl
    ld a, [$C525]
    or a, a
    ret z
    ld de, $2E1D
    push bc
    ld a, $01
    ldh [$FF4F], a
    pop bc

Jump_000_2DAA::
    push hl

Jump_000_2DAB::
    ld a, [de]
    inc de
    cp a, $FE
    jr z, Jump_000_2DCE
    cp a, $FD
    jr nz, Jump_000_2DC6
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $03
    or a, $98
    ld h, a
    jr Jump_000_2DAA

Jump_000_2DC6::
    call Func_000_1211
    call Func_000_304F
    jr Jump_000_2DAB

Jump_000_2DCE::
    push bc
    ld a, $00
    ldh [$FF4F], a
    pop bc
    pop hl
    ret

Func_000_2DD6::
    ld hl, $8EE0
    ld de, $C89E
    ld c, $10
    call Func_000_2DED
    ld hl, $8EF0
    ld de, $C8AE
    ld c, $10
    call Func_000_2DED
    ret

Func_000_2DED::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Func_000_2DED
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Func_000_2DED
    ret
    INCBIN "dwm2-cobi-us.gbc", $002DFA, $46

Func_000_2E40::
    ld a, [$4000]
    ld [$C52A], a
    ld a, [$C528]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [$C529]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ret

Func_000_2E5D::
    ld a, [$C533]
    ld l, a
    ld a, [$C534]
    ld h, a
    ld a, l
    add a, $01
    ld [$C533], a
    ld a, h
    adc a, $00
    ld [$C534], a
    ret

Func_000_2E72:: ; heuristic: follows a terminator; C0
    ld a, h
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld hl, $4001
    ld b, $08
    rst $10
    ret

Func_000_2E81::
    ld a, e
    ld [$C53D], a
    ld a, d
    ld [$C53E], a
    ld a, h
    ld [$C528], a
    ld a, l
    ld [$C529], a
    ld hl, $4016
    ld b, $08
    rst $10
    ret

Func_000_2E98::
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    call Func_000_290E
    ret

Func_000_2EAC::
    cp a, $64
    jr nc, Jump_000_2EB6
    cp a, $0A
    jr nc, Jump_000_2EBB
    jr Jump_000_2EC0

Jump_000_2EB6::
    ld e, $64
    call Func_000_2EC5

Jump_000_2EBB::
    ld e, $0A
    call Func_000_2EC5

Jump_000_2EC0::
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

Func_000_2EC5::
    ld d, $FF

Jump_000_2EC7::
    inc d
    sub a, e
    jr nc, Jump_000_2EC7
    add a, e
    ld [hl], d
    inc hl
    ret

Func_000_2ECF::
    ld a, $0F
    ldh [$FFCC], a
    ld e, $40
    ld d, $42
    call Func_000_2F36
    or a, a
    jp nz, Jump_000_2F03
    ld a, $01
    ldh [$FFCC], a
    ld e, $A0
    ld d, $86
    call Func_000_2F36
    or a, a
    jr nz, Jump_000_2F11
    ld a, $00
    ldh [$FFCC], a
    ld e, $10
    ld d, $27
    call Func_000_2F36
    or a, a
    jr nz, Jump_000_2F1F
    ldh a, [$FFC6]
    ld c, a
    ldh a, [$FFC7]
    ld b, a
    jp Func_000_2F84

Jump_000_2F03::
    ld a, $0F
    ldh [$FFCC], a
    ld e, $40
    ld d, $42
    call Func_000_2F5A
    call Func_000_2FDC

Jump_000_2F11::
    ld a, $01
    ldh [$FFCC], a
    ld e, $A0
    ld d, $86
    call Func_000_2F5A
    call Func_000_2FDC

Jump_000_2F1F::
    ld a, $00
    ldh [$FFCC], a
    ld e, $10
    ld d, $27
    call Func_000_2F5A
    call Func_000_2FDC
    ldh a, [$FFC6]
    ld c, a
    ldh a, [$FFC7]
    ld b, a
    jp Jump_000_2FA7

Func_000_2F36::
    ldh a, [$FFC6]
    ld [$C0A0], a
    ldh a, [$FFC7]
    ld [$C0A1], a
    ldh a, [$FFC8]
    ld [$C0A2], a
    call Func_000_2F5A
    push af
    ld a, [$C0A0]
    ldh [$FFC6], a
    ld a, [$C0A1]
    ldh [$FFC7], a
    ld a, [$C0A2]
    ldh [$FFC8], a
    pop af
    ret

Func_000_2F5A::
    push hl
    ldh a, [$FFCC]
    ld l, a
    ld h, $FF

Jump_000_2F60::
    inc h
    ldh a, [$FFC6]
    sub a, e
    ldh [$FFC6], a
    ldh a, [$FFC7]
    sbc a, d
    ldh [$FFC7], a
    ldh a, [$FFC8]
    sbc a, l
    ldh [$FFC8], a
    jr nc, Jump_000_2F60
    ldh a, [$FFC6]
    add a, e
    ldh [$FFC6], a
    ldh a, [$FFC7]
    adc a, d
    ldh [$FFC7], a
    ldh a, [$FFC8]
    adc a, l
    ldh [$FFC8], a
    ld a, h
    pop hl
    ret

Func_000_2F84::
    ld de, $03E8
    push bc
    call Func_000_2FC7
    pop bc
    or a, a
    jr nz, Jump_000_2FA7
    ld de, $0064
    push bc
    call Func_000_2FC7
    pop bc
    or a, a
    jr nz, Jump_000_2FB0
    ld de, $000A
    push bc
    call Func_000_2FC7
    pop bc
    or a, a
    jr nz, Jump_000_2FB9
    jr Jump_000_2FC2

Jump_000_2FA7::
    ld de, $03E8
    call Func_000_2FC7
    call Func_000_2FDC

Jump_000_2FB0::
    ld de, $0064
    call Func_000_2FC7
    call Func_000_2FDC

Jump_000_2FB9::
    ld de, $000A
    call Func_000_2FC7
    call Func_000_2FDC

Jump_000_2FC2::
    ld a, c
    call Func_000_2FDC
    ret

Func_000_2FC7::
    push hl
    ld h, $FF

Jump_000_2FCA::
    inc h
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    jr nc, Jump_000_2FCA
    ld a, c
    add a, e
    ld c, a
    ld a, b
    adc a, d
    ld b, a
    ld a, h
    pop hl
    ret

Func_000_2FDC::
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

Func_000_2FE1::
    ld b, $05

Jump_000_2FE3::
    ld a, [de]
    ld [hl+], a
    inc de
    cp a, $8D
    jr z, Jump_000_2FE3
    cp a, $8E
    jr z, Jump_000_2FE3
    dec b
    jr nz, Jump_000_2FE3
    ld a, [de]
    cp a, $8D
    jr z, Jump_000_2FFD
    cp a, $8E
    jr z, Jump_000_2FFD
    ld [hl], $F0
    ret

Jump_000_2FFD::
    ld [hl+], a
    ld [hl], $F0
    ret

Func_000_3001:: ; heuristic: follows a terminator; C0
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld a, [$C52D]
    ld e, a
    ld a, [$C52E]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    ld a, [$C554]
    ld l, a
    ld a, [$C555]
    ld h, a

Jump_000_3031::
    push bc

Jump_000_3032::
    ld a, e
    call Func_000_1211
    call Func_000_304F
    inc e
    dec b
    jr nz, Jump_000_3032
    pop bc
    ld hl, $0040
    call Func_000_305E
    dec c
    jr nz, Jump_000_3031
    ret

Func_000_3048::
    call Func_000_304F
    dec b
    jr nz, Func_000_3048
    ret

Func_000_304F::
    push af
    ld a, l
    and a, $E0
    push af
    ld a, l
    inc a
    and a, $1F
    ld l, a
    pop af
    or a, l
    ld l, a
    pop af
    ret

Func_000_305E::
    ld a, [$C554]
    add a, l
    ld l, a
    ld a, [$C555]
    adc a, h
    and a, $03
    ld h, a
    ld a, [$C555]
    and a, $FC
    or a, h
    ld h, a
    ret

Func_000_3072::
    push hl
    ldh a, [$FFA5]
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [$FFA1]
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld c, a
    ld b, h
    pop hl
    ld a, c
    add a, l
    ld l, a
    ld a, b
    adc a, h
    and a, $03
    ld h, a
    and a, $03
    or a, $98
    ld h, a
    ret

Func_000_3095::
    ld a, $C3
    call Func_000_1211
    call Func_000_304F
    dec b
    jr nz, Func_000_3095
    ret

Func_000_30A1:: ; heuristic: follows a terminator; C0
    push hl
    ld de, $4010
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [$4000]
    push af
    ld a, $1F
    ld [$2100], a
    ld b, $08

Jump_000_30BE::
    ld a, [de]
    ld [hl+], a
    inc e
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_000_30BE
    pop af
    ld [$2100], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $0030CC, $1C4

Func_000_3290::
    ld bc, $0000
    call Func_000_32DB
    ld a, $80
    ldh [$FF26], a
    xor a, a
    ldh [$FF25], a
    ld [$DD09], a
    ld a, $77
    ldh [$FF24], a
    ld hl, $DC00
    ld de, $0020
    ld b, $06
    ld a, $FF

Jump_000_32AE::
    ld [hl+], a
    ld [hl-], a
    add hl, de
    dec b
    jr nz, Jump_000_32AE
    ld hl, $DCC0
    ld b, $48
    xor a, a

Jump_000_32BA::
    ld [hl+], a
    dec b
    jr nz, Jump_000_32BA
    xor a, a
    ld [$DD15], a
    ld [$DD19], a
    ret

Func_000_32C6:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [$DD15], a
    ld a, [$DD16]
    ld [$DD09], a
    ret

Func_000_32D1:: ; heuristic: follows a terminator; C0
    ld a, $04
    ld [$DD15], a
    xor a, a
    ld [$DD09], a
    ret

Func_000_32DB::
    ld a, b
    ld [$DD12], a
    ld a, c
    ld [$DD13], a
    xor a, a
    ld [$DD14], a
    ret

Func_000_32E8::
    ld a, [$DD0F]
    inc a
    ld b, a
    ld a, $01

Jump_000_32EF::
    dec b
    jr z, Jump_000_32F5
    add a, a
    jr Jump_000_32EF

Jump_000_32F5::
    ld b, a
    ld a, [$DD14]
    or a, b
    ld [$DD14], a
    ret

Func_000_32FE::
    ld a, [$DD14]
    ld hl, $DD12
    and a, [hl]
    cp a, [hl]
    jr nz, Jump_000_3332
    ld hl, $DC06
    ld a, [$DD13]
    and a, $0F
    ld b, a
    ld a, [$DD12]

Jump_000_3314::
    srl a
    ld [$DD14], a
    jr nc, Jump_000_3320
    ld a, [hl]
    and a, $F0
    or a, b
    ld [hl], a

Jump_000_3320::
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$DD14]
    and a, a
    jr nz, Jump_000_3314
    xor a, a
    ld [$DD12], a

Jump_000_3332::
    xor a, a
    ld [$DD14], a
    ret

Func_000_3337:: ; heuristic: follows a terminator; C0
    call Func_000_3340
    call Func_000_3340
    call Func_000_3340

Func_000_3340::
    push bc
    push de
    push hl
    ld [$DD10], a
    ld hl, $3E24
    jr Jump_000_335D

Func_000_334B::
    call Func_000_3354

Func_000_334E::
    call Func_000_3354

Func_000_3351::
    call Func_000_3354

Func_000_3354::
    push bc
    push de
    push hl
    ld [$DD10], a
    ld hl, $3E13

Jump_000_335D::
    cp a, [hl]
    jr c, Jump_000_3366
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_000_335D

Jump_000_3366::
    ld a, [$4000]
    push af
    dec hl
    ld a, [hl-]
    ld [$2100], a
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec hl
    ld a, [$DD10]
    sub a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, de
    push hl
    pop de
    ld a, [de]
    inc de
    ld c, a
    ld b, $00
    ld hl, $DC00
    add hl, bc
    ld a, [hl]
    cp a, $FF
    jr z, Jump_000_33AA
    inc hl
    ld a, [hl-]
    ld b, $EE
    and a, $03
    jr z, Jump_000_33A3
    ld b, $DD
    cp a, $01
    jr z, Jump_000_33A3
    ld b, $BB
    cp a, $02
    jr z, Jump_000_33A3
    ld b, $77

Jump_000_33A3::
    ld a, [$DD09]
    and a, b
    ld [$DD09], a

Jump_000_33AA::
    xor a, a
    ld [hl+], a
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
    ld a, [$4000]
    ld [hl], a
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, $FF
    ld [hl+], a
    xor a, a
    push de
    ld de, $000E
    add hl, de
    pop de
    push hl
    ld [hl+], a
    ld [hl+], a
    ld [hl-], a
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], a
    pop hl
    inc hl
    inc hl
    inc hl
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    pop af
    ld [$2100], a
    ld a, [$DD10]
    inc a
    pop hl
    pop de
    pop bc
    ret

Func_000_33E8::
    ld a, [$4000]
    push af
    ld a, [$DD15]
    ld [$DD0F], a
    xor a, a
    ld [$DD08], a
    ld hl, $DD0E
    inc [hl]
    ld hl, $DC00

Jump_000_33FD::
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    and a, b
    cp a, $FF
    jp z, Jump_000_352F
    push hl
    ld c, $D8
    ld b, $04

Jump_000_340B::
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_340B
    ldh a, [$FFDD]
    ld [$2100], a
    ldh a, [$FFDA]
    and a, $03
    ld [$DD0A], a
    ld b, a
    add a, a
    add a, a
    add a, b
    ld [$DD0D], a
    inc b
    ld a, $88

Jump_000_343C::
    rlca
    dec b
    jr nz, Jump_000_343C
    ld [$DD0B], a
    ld [$DD0C], a
    ldh a, [$FFD8]
    ld b, a
    ldh a, [$FFD9]
    or a, b
    and a, a
    jp z, Jump_000_3554
    call Func_000_39F8
    call Func_000_3A7A
    ldh a, [$FFE6]
    ld b, a
    ldh a, [$FFE7]
    inc a
    cp a, b
    jr c, Jump_000_3460
    ld a, b

Jump_000_3460::
    ldh [$FFE7], a
    ld hl, $FFDF
    ldh a, [$FFDE]
    and a, $0F
    add a, [hl]
    cp a, $10
    jr c, Jump_000_3473
    sub a, $10
    ld [hl], a
    jr Jump_000_34C7

Jump_000_3473::
    ld [hl], a
    call Func_000_39B9
    ldh a, [$FFF0]
    and a, a
    jr z, Jump_000_347F
    dec a
    ldh [$FFF0], a

Jump_000_347F::
    ldh a, [$FFE1]
    and a, a
    jr nz, Jump_000_34BA
    ldh a, [$FFF3]
    and a, $F0
    jr z, Jump_000_349C
    ld hl, $FFF2
    dec [hl]
    jr nz, Jump_000_34A8
    ldh a, [$FFED]
    and a, $F0
    ld c, a
    ldh a, [$FFE0]
    and a, $0F
    or a, c
    ldh [$FFE0], a

Jump_000_349C::
    call Func_000_32E8

Jump_000_349F::
    ldh a, [$FFEF]
    ldh [$FFF0], a
    call Func_000_35CD
    jr Jump_000_34C7

Jump_000_34A8::
    ldh a, [$FFF3]
    and a, $0F
    dec a
    cp a, [hl]
    jr nz, Jump_000_34C7
    call Func_000_3DC8
    ldh a, [$FFE0]
    call Func_000_3A2F
    jr Jump_000_34C7

Jump_000_34BA::
    dec a
    ldh [$FFE1], a
    jr nz, Jump_000_34C7
    ldh a, [$FFF3]
    and a, $F0
    jr nz, Jump_000_34C7
    jr Jump_000_349C

Jump_000_34C7::
    ld a, [$DD19]
    and a, a
    jr z, Jump_000_3502
    ld a, [$DD0A]
    cp a, $02
    jr nz, Jump_000_3502
    ld a, [$DD0F]
    cp a, $02
    jr c, Jump_000_3502
    ld a, [$DD0B]
    ld b, a
    ld a, [$DD08]
    and a, b
    jr nz, Jump_000_3502
    ld a, [$DD17]
    ld b, a
    ldh a, [$FFE2]
    cp a, b
    jr z, Jump_000_3502
    ld e, a
    ld [$DD17], a
    swap e
    xor a, a
    ld [$DD19], a
    ldh [$FF1A], a
    ld d, a
    call Func_000_3D8D
    ld a, $80
    ldh [$FF1A], a

Jump_000_3502::
    ld a, [$DD0B]
    ld b, a
    ld a, [$DD08]
    or a, b
    ld [$DD08], a
    pop hl
    push hl
    ld c, $D8
    ld b, $04

Jump_000_3513::
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    ldh a, [c]
    ld [hl+], a
    inc c
    dec b
    jr nz, Jump_000_3513
    pop hl

Jump_000_352F::
    ld de, $0020
    add hl, de
    ld a, [$DD0F]
    inc a
    ld [$DD0F], a
    cp a, $06
    jp c, Jump_000_33FD
    ld a, [$DD08]
    ld b, a
    ld a, [$DD09]
    and a, b
    ld [$DD09], a
    ldh [$FF25], a
    pop af
    ld [$2100], a
    call Func_000_32FE
    ret

Jump_000_3554::
    ldh a, [$FFDB]
    ld l, a
    ldh a, [$FFDC]
    ld h, a
    ld a, [hl+]
    and a, $0F
    ld d, a
    ldh [$FFDF], a
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_3593
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    or a, d

Jump_000_356D::
    ldh [$FFDE], a
    ld a, [hl+]
    swap a
    ldh [$FFE0], a
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_3599
    ld a, [hl+]
    ldh [$FFE2], a

Jump_000_357E::
    xor a, a
    ldh [$FFE3], a
    ldh [$FFE4], a
    ldh [$FFE5], a
    ldh [$FFE8], a
    ldh [$FFD9], a
    dec a
    ldh [$FFEE], a
    ld a, $02
    ldh [$FFD8], a
    jp Jump_000_349F

Jump_000_3593::
    ld a, [hl+]
    ldh [$FFE6], a
    ld a, d
    jr Jump_000_356D

Jump_000_3599::
    xor a, a
    ldh [$FF1A], a
    ld d, a
    ldh a, [$FFE2]
    ld e, a
    cp a, $FF
    jr nz, Jump_000_35A8
    ld e, [hl]
    ld a, e
    ldh [$FFE2], a

Jump_000_35A8::
    ld [$DD17], a
    swap e
    ld hl, $30CC
    push de
    ldh a, [$FFF1]
    swap a
    and a, $0F
    add a, a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    pop de
    add hl, de
    ld c, $30
    ld b, $10

Jump_000_35C5::
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_35C5
    jr Jump_000_357E

Func_000_35CD::
    ldh a, [$FFD8]
    ld l, a
    ldh a, [$FFD9]
    ld h, a
    add hl, hl
    ldh a, [$FFDB]
    ld e, a
    ldh a, [$FFDC]
    ld d, a
    add hl, de

Jump_000_35DB::
    ldh a, [$FFD8]
    add a, $01
    ldh [$FFD8], a
    ldh a, [$FFD9]
    adc a, $00
    ldh [$FFD9], a
    ld a, [hl+]
    cp a, $D0
    jr nc, Jump_000_362E
    cp a, $B0
    jr nc, Jump_000_366D
    cp a, $A0
    jp nc, Jump_000_36A9
    jp Jump_000_38C9

Jump_000_35F8::
    cp a, $FD
    jr z, Jump_000_3602
    cp a, $FF
    jr z, Jump_000_3613
    jr Jump_000_3610

Jump_000_3602::
    push hl
    ld b, [hl]
    call Func_000_3DAE
    xor a, a
    ld [hl+], a
    ldh a, [$FFD8]
    ld [hl+], a
    ldh a, [$FFD9]
    ld [hl], a
    pop hl

Jump_000_3610::
    inc hl
    jr Jump_000_35DB

Jump_000_3613::
    ldh [$FFD8], a
    ldh [$FFD9], a
    ld a, [$DD0A]
    cp a, $02
    jr nz, Jump_000_362A
    ld a, [$DD0F]
    cp a, $02
    jr nc, Jump_000_362A
    ld a, $FF
    ld [$DD19], a

Jump_000_362A::
    call Func_000_3B41
    ret

Jump_000_362E::
    cp a, $F0
    jr nc, Jump_000_35F8
    cp a, $E0
    jr nc, Jump_000_363A
    and a, $0F
    jr Jump_000_363E

Jump_000_363A::
    and a, $0F
    cpl
    inc a

Jump_000_363E::
    ld b, a
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_364E
    ld a, b
    ldh [$FFE8], a
    ld a, [hl]
    ldh [$FFE9], a
    ldh [$FFEA], a

Jump_000_364E::
    inc hl
    jr Jump_000_35DB

Jump_000_3651::
    and a, $0F
    ld b, a
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_3669
    ldh a, [$FFE0]
    and a, $0F
    jr nz, Jump_000_3669
    ld a, [hl]
    ldh [$FFE6], a
    ld a, b
    swap a
    ldh [$FFE5], a

Jump_000_3669::
    inc hl
    jp Jump_000_35DB

Jump_000_366D::
    cp a, $C0
    jr nc, Jump_000_3651
    and a, $0F
    jp z, Jump_000_368C
    ld e, a
    ld b, [hl]
    push hl
    call Func_000_3DAE
    inc [hl]
    ld a, [hl+]
    inc e
    cp a, e
    jr nc, Jump_000_3688
    ld a, [hl+]
    ldh [$FFD8], a
    ld a, [hl]
    ldh [$FFD9], a

Jump_000_3688::
    pop hl
    jp Func_000_35CD

Jump_000_368C::
    ld a, [hl]
    ld b, a
    and a, $F0
    cp a, $F0
    jp nz, Jump_000_36A5
    ld b, [hl]
    push hl
    call Func_000_3DAE
    inc hl
    ld a, [hl+]
    ldh [$FFD8], a
    ld a, [hl]
    ldh [$FFD9], a
    pop hl
    jp Func_000_35CD

Jump_000_36A5::
    inc hl
    jp Jump_000_35DB

Jump_000_36A9::
    cp a, $A0
    jr nz, Jump_000_36C3
    ld a, [hl+]
    swap a
    ldh [$FFE0], a
    ld a, [$DD0B]
    ld b, a
    ld a, [$DD08]
    and a, b
    jp nz, Jump_000_35DB
    call Func_000_3A2F
    jp Jump_000_35DB

Jump_000_36C3::
    cp a, $A1
    jr nz, Jump_000_3712
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_36D4
    ld a, [hl+]
    ldh [$FFE2], a
    jp Jump_000_35DB

Jump_000_36D4::
    ld a, [hl+]
    ld e, a
    ldh [$FFE2], a
    ld a, [$DD0B]
    ld b, a
    ld a, [$DD08]
    and a, b
    jr z, Jump_000_36E5
    jp Jump_000_35DB

Jump_000_36E5::
    xor a, a
    ldh [$FF1A], a
    ld d, a
    push hl
    ld a, e
    ld [$DD17], a
    swap e
    ld hl, $30CC
    push de
    ldh a, [$FFF1]
    swap a
    and a, $0F
    add a, a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    pop de
    add hl, de
    ld c, $30
    ld b, $10

Jump_000_3708::
    ld a, [hl+]
    ldh [c], a
    inc c
    dec b
    jr nz, Jump_000_3708
    pop hl
    jp Jump_000_35DB

Jump_000_3712::
    cp a, $A2
    jr nz, Jump_000_3733
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_372D
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    ld d, a
    ldh a, [$FFDE]
    and a, $3F
    or a, d
    ldh [$FFDE], a
    jp Jump_000_35DB

Jump_000_372D::
    ld a, [hl+]
    ldh [$FFE6], a
    jp Jump_000_35DB

Jump_000_3733::
    cp a, $A3
    cp a, $A3
    jr nz, Jump_000_375C
    ld a, [hl+]
    cp a, $FE
    jr z, Jump_000_3756
    ld b, a
    and a, $0F
    add a, a
    ldh [$FFEF], a
    ldh [$FFF0], a
    ld a, b
    add a, $10
    and a, $F0
    ld e, a
    ldh a, [$FFDA]
    and a, $0F
    or a, e

Jump_000_3751::
    ldh [$FFDA], a
    jp Jump_000_35DB

Jump_000_3756::
    ldh a, [$FFDA]
    and a, $0F
    jr Jump_000_3751

Jump_000_375C::
    cp a, $A5
    jr nz, Jump_000_376E
    ld a, [hl+]
    cp a, $01
    jr nz, Jump_000_3769
    ldh a, [$FFEE]
    swap a

Jump_000_3769::
    ldh [$FFEE], a
    jp Jump_000_35DB

Jump_000_376E::
    cp a, $A6
    jr nz, Jump_000_3778
    ld a, [hl+]
    ldh [$FF24], a
    jp Jump_000_35DB

Jump_000_3778::
    cp a, $A7
    jr nz, Jump_000_3782
    ld a, [hl]
    ldh [$FFE1], a
    jp Jump_000_3998

Jump_000_3782::
    cp a, $A8
    jr nz, Jump_000_3794
    ld a, [hl+]
    ld c, a
    and a, $0F
    ld b, a
    ld a, c
    and a, $F0
    or a, b
    ldh [$FFF1], a
    jp Jump_000_35DB

Jump_000_3794::
    cp a, $A9
    jp nz, Jump_000_37FF
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_000_37DB
    cp a, $F1
    jr z, Jump_000_37E3
    cp a, $F2
    jr z, Jump_000_37EB
    cp a, $F3
    jr z, Jump_000_37F5
    cp a, $FE
    jr z, Jump_000_37B6
    cp a, $FF
    jr nz, Jump_000_37CA
    ldh a, [$FFE4]
    jr Jump_000_37B9

Jump_000_37B6::
    ld a, [$DD18]

Jump_000_37B9::
    sla a
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ldh [$FFD8], a
    ld a, [hl]
    ldh [$FFD9], a
    jp Func_000_35CD

Jump_000_37CA::
    cp a, $80
    jr nc, Jump_000_37D3
    ldh [$FFE4], a
    jp Jump_000_35DB

Jump_000_37D3::
    sub a, $80
    ld [$DD18], a
    jp Jump_000_35DB

Jump_000_37DB::
    ldh a, [$FFE4]
    inc a
    ldh [$FFE4], a
    jp Jump_000_35DB

Jump_000_37E3::
    ldh a, [$FFE4]
    dec a
    ldh [$FFE4], a
    jp Jump_000_35DB

Jump_000_37EB::
    ld a, [$DD18]
    inc a
    ld [$DD18], a
    jp Jump_000_35DB

Jump_000_37F5::
    ld a, [$DD18]
    dec a
    ld [$DD18], a
    jp Jump_000_35DB

Jump_000_37FF::
    cp a, $AA
    jr nz, Jump_000_3829
    ld a, [hl+]
    ld c, a
    and a, $F0
    jr z, Jump_000_381F
    swap a
    ldh [$FFF2], a
    or a, $F0
    ldh [$FFF3], a
    ld a, c
    and a, $0F
    ld c, a
    ldh a, [$FFED]
    and a, $F0
    or a, c
    ldh [$FFED], a
    jp Jump_000_35DB

Jump_000_381F::
    xor a, a
    ldh [$FFF2], a
    ldh [$FFED], a
    ldh [$FFF3], a
    jp Jump_000_35DB

Jump_000_3829::
    cp a, $AC
    jr nz, Jump_000_3867
    ldh a, [$FFF4]
    sub a, $01
    jr z, Jump_000_3855
    jr nc, Jump_000_3836
    ld a, [hl]

Jump_000_3836::
    ldh [$FFF4], a
    ldh a, [$FFD8]
    sub a, $01
    ldh [$FFF5], a
    ldh a, [$FFD9]
    sbc a, $00
    ldh [$FFF6], a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    srl h
    rr l
    ld a, l
    ldh [$FFD8], a
    ld a, h
    ldh [$FFD9], a
    jp Func_000_35CD

Jump_000_3855::
    xor a, a
    ldh [$FFF4], a
    ldh a, [$FFD8]
    add a, $01
    ldh [$FFD8], a
    ldh a, [$FFD9]
    adc a, $00
    ldh [$FFD9], a
    jp Func_000_35CD

Jump_000_3867::
    cp a, $AD
    jr nz, Jump_000_3876
    ldh a, [$FFF5]
    ldh [$FFD8], a
    ldh a, [$FFF6]
    ldh [$FFD9], a
    jp Func_000_35CD

Jump_000_3876::
    cp a, $AE
    jr nz, Jump_000_3888
    ld a, [hl+]
    and a, $10
    ld b, a
    ldh a, [$FFDE]
    and a, $EF
    or a, b
    ldh [$FFDE], a
    jp Jump_000_35DB

Jump_000_3888::
    cp a, $AF
    jr nz, Jump_000_389C
    ld a, [hl+]
    and a, $0F
    ldh [$FFDF], a
    ld b, a
    ldh a, [$FFDE]
    and a, $F0
    or a, b
    ldh [$FFDE], a
    jp Jump_000_35DB

Jump_000_389C::
    inc hl
    jp Jump_000_35DB
    db $00, $01, $11, $12, $14, $23, $07, $15, $17, $32, $33, $60, $61, $45, $53, $62

Jump_000_38B0::
    xor a, a
    ldh [$FFEB], a
    ld a, $80
    ldh [$FFEC], a
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_38C2
    call Func_000_3B39
    ret

Jump_000_38C2::
    call Func_000_3B51
    xor a, a
    ldh [$FF1A], a
    ret

Jump_000_38C9::
    ld b, a
    ldh a, [$FFF3]
    and a, $F0
    jr z, Jump_000_38DF
    push de
    ldh a, [$FFF3]
    and a, $0F
    ldh [$FFF2], a
    ld c, a
    ld a, [hl]
    sub a, c
    ldh [$FFE1], a
    pop de
    jr Jump_000_38E2

Jump_000_38DF::
    ld a, [hl]
    ldh [$FFE1], a

Jump_000_38E2::
    ld a, [$DD0A]
    cp a, $03
    jr nz, Jump_000_3905
    ld a, b
    cp a, $1F
    jr z, Jump_000_38B0
    cp a, $10
    jr nc, Jump_000_3900
    ld hl, $38A0
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld l, [hl]
    ld h, $00
    jr Jump_000_3938

Jump_000_3900::
    ld l, a
    ld h, $00
    jr Jump_000_3938

Jump_000_3905::
    ld a, b
    and a, $0F
    cp a, $0C
    jr nc, Jump_000_38B0
    add a, a
    ld e, a
    ldh a, [$FFDE]
    and a, $10
    jr z, Jump_000_3918
    ld a, e
    add a, $18
    ld e, a

Jump_000_3918::
    ld d, $00
    ld hl, $3B5C
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, b
    swap a
    and a, $0F
    jr z, Jump_000_3930
    ld b, a

Jump_000_3929::
    srl h
    rr l
    dec b
    jr nz, Jump_000_3929

Jump_000_3930::
    ld a, $00
    sub a, l
    ld l, a
    ld a, $08
    sbc a, h
    ld h, a

Jump_000_3938::
    xor a, a
    ldh [$FFE7], a
    call Func_000_3B51
    ld a, [$DD0A]
    cp a, $02
    jr nz, Jump_000_394C
    call Func_000_3D7C
    ld a, $80
    ldh [$FF1A], a

Jump_000_394C::
    push hl
    call Func_000_3A21
    pop hl
    ld a, [$DD0A]
    and a, a
    ldh a, [$FFE2]
    ld c, $10
    call z, Func_000_3A4E
    ld a, l
    ld c, $13
    call Func_000_3A4E
    ld a, l
    cp a, $02
    jr c, Jump_000_396F
    cp a, $FE
    jr c, Jump_000_3971
    ld a, $FD
    jr Jump_000_3971

Jump_000_396F::
    ld a, $02

Jump_000_3971::
    ldh [$FFEB], a
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_39AB
    cp a, $02
    jr nc, Jump_000_3989
    ldh a, [$FFDE]
    and a, $C0
    or a, $3F
    ld c, $11
    call Func_000_3A4E

Jump_000_3989::
    ld a, h
    and a, $07
    or a, $80

Jump_000_398E::
    ldh [$FFEC], a
    ld c, $14
    call Func_000_3A4E
    call Func_000_3A5D

Jump_000_3998::
    ld a, [$DD0C]
    ld b, a
    cpl
    ld c, a
    ldh a, [$FFEE]
    and a, b
    ld b, a
    ld a, [$DD09]
    and a, c
    or a, b
    ld [$DD09], a
    ret

Jump_000_39AB::
    xor a, a
    ldh [$FF1B], a
    ldh a, [$FF26]
    and a, $04
    jr z, Jump_000_3989
    ld a, h
    and a, $07
    jr Jump_000_398E

Func_000_39B9::
    ld a, [$DD0A]
    cp a, $02
    ret z
    ldh a, [$FFE8]
    and a, a
    ret z
    ld hl, $FFEA
    dec [hl]
    ret nz
    ldh a, [$FFE0]
    swap a
    cp a, $10
    ret nc
    and a, $0F
    ld b, a
    ldh a, [$FFE9]
    ldh [$FFEA], a
    ld hl, $FFE8
    ld a, [hl]
    bit 7, a
    jr nz, Jump_000_39EC
    dec [hl]
    ld a, b
    cp a, $0F
    ret z
    ldh a, [$FFE0]
    add a, $10
    ldh [$FFE0], a
    jp Func_000_3A2F

Jump_000_39EC::
    inc [hl]
    ld a, b
    and a, a
    ret z
    ldh a, [$FFE0]
    sub a, $10
    ldh [$FFE0], a
    jr Func_000_3A2F

Func_000_39F8::
    call Func_000_3B51
    ld a, [$DD0A]
    cp a, $03
    ret z
    ldh a, [$FFF0]
    and a, a
    ret nz
    ldh a, [$FFDA]
    and a, $F0
    ret z
    sub a, $10
    ld b, a
    ld a, [$DD0E]
    and a, $0F
    or a, b
    ld e, a
    ld d, $00
    ld hl, $3C8C
    add hl, de
    ldh a, [$FFEB]
    add a, [hl]
    ld c, $13
    jr Func_000_3A4E

Func_000_3A21::
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_3A57
    ldh a, [$FFE5]
    and a, a
    jr nz, Jump_000_3A94
    ldh a, [$FFE0]

Func_000_3A2F::
    ld b, a
    and a, $07
    jr nz, Jump_000_3A38
    ld a, b
    or a, $08
    ld b, a

Jump_000_3A38::
    ld a, [$DD0D]
    add a, $12
    ld c, a
    ldh a, [c]
    cp a, b
    ret z
    ld a, b
    ldh [c], a
    ldh a, [$FFEC]
    ld c, $14
    call Func_000_3A4E
    call Func_000_3A5D
    ret

Func_000_3A4E::
    ld b, a
    ld a, [$DD0D]
    add a, c
    ld c, a
    ld a, b
    ldh [c], a
    ret

Jump_000_3A57::
    ldh a, [$FFE0]
    ld c, $12
    jr Func_000_3A4E

Func_000_3A5D::
    ld c, $11
    ld a, [$DD0D]
    add a, c
    ld c, a
    ldh a, [c]
    and a, $C0
    ldh [c], a
    ret

Jump_000_3A69::
    ld a, e
    srl a
    add a, $02
    swap a
    ld hl, $FFE0
    cp a, [hl]
    ret c
    and a, $60
    ldh [$FF1C], a
    ret

Func_000_3A7A::
    call Func_000_3B51
    ldh a, [$FFEB]
    and a, a
    jr nz, Jump_000_3A89
    ldh a, [$FFEC]
    and a, $7F
    jp z, Func_000_3B39

Jump_000_3A89::
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_3A94
    ldh a, [$FFE5]
    and a, a
    ret z

Jump_000_3A94::
    ldh a, [$FFE6]
    and a, a
    ret z
    ld e, $00
    ld c, a
    ldh a, [$FFE7]
    ld b, $04

Jump_000_3A9F::
    add a, a
    cp a, c
    jr c, Jump_000_3AA4
    sub a, c

Jump_000_3AA4::
    ccf
    rl e
    dec b
    jr nz, Jump_000_3A9F
    ld a, [$DD0A]
    cp a, $02
    jr z, Jump_000_3A69
    ldh a, [$FFE5]
    or a, e
    ld e, a
    ld d, $00
    push de
    ldh a, [$FFF1]
    and a, $0F
    ld de, $31CE
    sla a
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    add hl, de
    ldh a, [$FFE0]
    swap a
    ld e, a
    ld a, [hl]
    ld h, a
    and a, $F0
    or a, e
    ld e, a
    bit 2, h
    jr nz, Jump_000_3B05
    inc b
    ld a, c
    swap a
    and a, $0F
    jr z, Jump_000_3B05
    ld b, a
    bit 3, e
    jr nz, Jump_000_3AFE
    sla b
    bit 2, e
    jr nz, Jump_000_3AFE
    sla b
    bit 1, e
    jr z, Jump_000_3B03

Jump_000_3AFE::
    ld a, b
    cp a, $08
    jr c, Jump_000_3B05

Jump_000_3B03::
    ld b, $00

Jump_000_3B05::
    bit 1, h
    jr z, Jump_000_3B0E
    ld a, b
    jr z, Jump_000_3B0E
    srl b

Jump_000_3B0E::
    ld a, h
    and a, $08
    or a, b
    ld b, a
    bit 0, h
    jr z, Jump_000_3B20
    ld hl, $3B8C
    add hl, de
    ld a, [hl]
    or a, b
    jp Func_000_3A2F

Jump_000_3B20::
    ld c, $12
    ld a, [$DD0D]
    add a, c
    ld c, a
    ldh a, [c]
    and a, $08
    ld l, a
    ld a, h
    and a, $08
    cp a, l
    ret z
    ld hl, $3B8C
    add hl, de
    ld a, [hl]
    or a, b
    jp Func_000_3A2F

Func_000_3B39::
    call Func_000_3B51
    ld a, $00
    jp Func_000_3A2F

Func_000_3B41::
    call Func_000_3B51
    ld a, [$DD0B]
    cpl
    ld b, a
    ld a, [$DD09]
    and a, b
    ld [$DD09], a
    ret

Func_000_3B51::
    ld a, [$DD0B]
    ld b, a
    ld a, [$DD08]
    and a, b
    ret z
    pop af
    ret
    db $D4, $07, $64, $07, $F9, $06, $95, $06, $37, $06, $DD, $05, $89, $05, $3A, $05
    db $F0, $04, $A8, $04, $65, $04, $26, $04, $9C, $07, $2E, $07, $C7, $06, $66, $06
    db $0A, $06, $B3, $05, $61, $05, $15, $05, $CC, $04, $86, $04, $45, $04, $08, $04
    ds $18, $00
    INCBIN "dwm2-cobi-us.gbc", $003BA4, $126
    ds $12, $FF
    ds $10, $FE
    ds $10, $01
    ds $10, $02
    ds $70, $00

Func_000_3D7C::
    ld a, [$DD17]
    ld b, a
    ldh a, [$FFE2]
    cp a, b
    ret z
    ld [$DD17], a
    ld e, a
    swap e
    xor a, a
    ldh [$FF1A], a

Func_000_3D8D::
    ld d, a
    ld hl, $30CC
    push de
    ldh a, [$FFF1]
    swap a
    and a, $0F
    add a, a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    pop de
    add hl, de
    ld de, $FF30
    ld b, $10

Jump_000_3DA7::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_3DA7
    ret

Func_000_3DAE::
    ld a, [$DD0F]
    add a, a
    ld c, a
    add a, a
    add a, c
    add a, a
    ld c, a
    ld a, b
    and a, $0F
    ld b, a
    add a, a
    add a, b
    add a, c
    ld hl, $DCC0
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ret

Func_000_3DC8::
    push de
    push bc
    ldh a, [$FFED]
    and a, $0F
    inc a
    ld d, a
    ld bc, $0000
    ldh a, [$FFE0]
    swap a
    and a, $0F
    inc a
    ld e, a

Jump_000_3DDB::
    ld a, e
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    dec d
    jr nz, Jump_000_3DDB
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    ld a, c
    and a, a
    jr nz, Jump_000_3DFB
    ld c, $01

Jump_000_3DFB::
    swap c
    ldh a, [$FFE0]
    ld d, a
    and a, $F0
    ld e, a
    ldh a, [$FFED]
    and a, $0F
    or a, e
    ldh [$FFED], a
    ld a, d
    and a, $0F
    or a, c
    ldh [$FFE0], a
    pop bc
    pop de
    ret
    db $00, $01, $40, $40, $1C, $01, $40, $41, $31, $01, $40, $42, $A8, $01, $40, $43
    db $FF, $FF

Func_000_3E25::
    push hl
    push bc
    ld c, a
    call Func_000_3E54
    jr c, Jump_000_3E50
    ld a, c
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $D0
    jr nz, Jump_000_3E4F
    inc hl
    inc hl
    ld a, [hl+]
    and a, $3F
    jr nz, Jump_000_3E4F
    inc hl
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_000_3E4F
    inc hl
    inc hl
    bit 3, [hl]
    jr nz, Jump_000_3E4F
    xor a, a
    jr Jump_000_3E50

Jump_000_3E4F::
    scf

Jump_000_3E50::
    ld a, c
    pop bc
    pop hl
    ret

Func_000_3E54::
    push hl
    push bc
    ld c, a
    cp a, $08
    jr nc, Jump_000_3E6E
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_000_3E63
    inc h

Jump_000_3E63::
    ld a, [hl]
    and a, a
    jr z, Jump_000_3E72
    cp a, $FF
    jr z, Jump_000_3E6E
    scf
    jr Jump_000_3E76

Jump_000_3E6E::
    xor a, a
    scf
    jr Jump_000_3E76

Jump_000_3E72::
    ld a, $0A
    cp a, $01

Jump_000_3E76::
    ld a, c
    pop bc
    pop hl
    ret

Func_000_3E7A::
    ld a, h
    cp a, b
    ret nz
    ld a, l
    cp a, c
    ret

Func_000_3E80:: ; heuristic: follows a terminator; C0
    ld a, b
    or a, c
    jr nz, Jump_000_3E8F
    ld a, h
    or a, l
    jr nz, Jump_000_3E8C
    xor a, a
    scf
    ccf
    ret

Jump_000_3E8C::
    scf
    ccf
    ret

Jump_000_3E8F::
    ld a, h
    or a, l
    jr nz, Func_000_3E7A
    ld a, $01
    or a, a
    scf
    ret

Func_000_3E98::
    call Func_000_3E7A
    jr z, Jump_000_3ED1
    ld a, h
    or a, l
    jr z, Jump_000_3EB1
    ld a, l
    cpl
    add a, $01
    ld l, a
    ld a, h
    cpl
    adc a, $00
    ld h, a
    ld a, c
    add a, l
    ld c, a
    ld a, b
    adc a, h
    ld b, a

Jump_000_3EB1::
    ld a, c
    add a, $01
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    push hl
    call Func_000_3ED4
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    call Func_000_3F04
    pop hl
    ld a, c
    sub a, l
    ld e, a
    ld a, b
    sbc a, h
    ld d, a
    jr Jump_000_3ED3

Jump_000_3ED1::
    ld e, a
    ld d, h

Jump_000_3ED3::
    ret

Func_000_3ED4::
    ld a, [$C58A]
    or a, a
    jr nz, Func_000_3EDE
    call Func_000_095B
    ret

Func_000_3EDE::
    push hl
    ld a, [$C5BA]
    ld l, a
    ld a, [$C5BB]
    ld h, a
    ld a, l
    ld [$C5E7], a
    ld a, h
    ld [$C5E8], a
    call Func_000_095B
    ld a, [$C5E7]
    ld l, a
    ld a, [$C5E8]
    ld h, a
    ld a, l
    ld [$C5BA], a
    ld a, h
    ld [$C5BB], a
    pop hl
    ret

Func_000_3F04::
    ld de, $0000
    ld a, b
    or a, a
    jr z, Jump_000_3F16

Jump_000_3F0B::
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr c, Jump_000_3F1F
    inc de
    jr Jump_000_3F0B

Jump_000_3F16::
    ld a, c
    call Func_000_16D1
    ld c, a
    ld b, $00
    jr Jump_000_3F24

Jump_000_3F1F::
    add hl, bc
    ld b, h
    ld c, l
    ld h, d
    ld l, e

Jump_000_3F24::
    ret

Func_000_3F25::
    push de
    ld d, a
    add a, a
    add a, a
    add a, a
    add a, d
    pop de
    add a, l
    ld l, a
    jr nc, Jump_000_3F31
    inc h

Jump_000_3F31::
    ret

Func_000_3F32::
    cp a, $03
    jr c, Jump_000_3F37
    dec a

Jump_000_3F37::
    ld c, $4E
    call Func_000_1682
    ld bc, $D0D5
    add hl, bc
    ld a, e
    add a, l
    ld l, a
    jr nc, Jump_000_3F46
    inc h

Jump_000_3F46::
    ret

Func_000_3F47::
    push bc
    push af
    ld a, [$DAAC]
    ld c, a
    pop af
    cp a, c
    jr nz, Jump_000_3F53

Jump_000_3F51::
    pop bc
    ret

Jump_000_3F53::
    cp a, $34
    jr nz, Jump_000_3F5C
    ld a, $AD
    cp a, c
    jr Jump_000_3F51

Jump_000_3F5C::
    cp a, $AD
    jr nz, Jump_000_3F65
    ld a, $34
    cp a, c
    jr Jump_000_3F51

Jump_000_3F65::
    cp a, $35
    jr nz, Jump_000_3F6E
    ld a, $AE
    cp a, c
    jr Jump_000_3F51

Jump_000_3F6E::
    cp a, $AE
    jr nz, Jump_000_3F77
    ld a, $35
    cp a, c
    jr Jump_000_3F51

Jump_000_3F77::
    cp a, $6A
    jr nz, Jump_000_3F80
    ld a, $CC
    cp a, c
    jr Jump_000_3F51

Jump_000_3F80::
    cp a, $CC
    jr nz, Jump_000_3F89
    ld a, $6A
    cp a, c
    jr Jump_000_3F51

Jump_000_3F89::
    cp a, $A1
    jr nz, Jump_000_3F92
    ld a, $CF
    cp a, c
    jr Jump_000_3F51

Jump_000_3F92::
    cp a, $CF
    jr nz, Jump_000_3F9B
    ld a, $A1
    cp a, c
    jr Jump_000_3F51

Jump_000_3F9B::
    cp a, $8F
    jr nz, Jump_000_3FA4
    ld a, $AA
    cp a, c
    jr Jump_000_3F51

Jump_000_3FA4::
    cp a, $AA
    jr nz, Jump_000_3F51
    ld a, $8F
    cp a, c
    jr Jump_000_3F51
    ds $53, $00
