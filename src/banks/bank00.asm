SECTION "Bank 00", ROM0[$0000]

; C2 static reading (E-0007): rst $00 pops its return address as the base of an inline word table, indexes it by A (entry = base + 2*A), preserves DE, and jumps to the entry.
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

; C2 static reading (E-0007): rst $10 selects ROM bank B, calls the code at HL, then restores the caller's bank (saved from $4000, which holds each bank's own number, E-0006).
Func_000_0010::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    call Func_000_000E
    pop af
    ld [rROMB0], a
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
    ldh [rDMA], a
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
    ld [wIsCGB], a

Jump_000_015A::
    di
    ld sp, wDFFF
    call Func_000_078D
    call Func_000_08D0
    call Func_000_0080
    ld hl, vTiles0
    ld bc, $1C00
    xor a, a
    call Func_000_0949
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_0189
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0800
    xor a, a
    call Func_000_0949
    ld a, $00
    ldh [rVBK], a

Jump_000_0189::
    ld hl, wC5DB
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, $05
    ld [wC5DB], a
    ld a, $00
    ld [rRAMB], a
    ld a, $00
    ld [rRAMG], a
    ld a, $01
    ld [rROMB0], a
    ld a, $00
    ld [rROMB1], a
    ld a, $01
    ld [wC524], a
    ld a, $FF
    ld [wC60A], a
    ld [wC60B], a
    call Func_000_3290
    xor a, a
    ld [wC58C], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_01D3
    xor a, a
    ldh [rVBK], a
    ldh [rSVBK], a
    ldh [rRP], a
    ld hl, Func_002_42FA
    ld b, $02
    rst $10
    jr Jump_000_01D8

Jump_000_01D3::
    call Func_000_05E2
    jr c, Jump_000_01DF

Jump_000_01D8::
    xor a, a
    ld [wC524], a
    jp Jump_000_02D1

Jump_000_01DF::
    ld bc, $000C
    call Func_000_0692
    ld a, $14
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $02
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $03
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $04
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $05
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $06
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $07
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $08
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $09
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
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
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $0A
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $13
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $0E
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ld a, $01
    ld [wC524], a
    ld a, $FF
    ld [wC523], a
    xor a, a
    ld [wC51F], a
    ld [wC520], a
    ld hl, Func_017_41CF
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
    ld [wC586], a
    ld [wC52B], a
    ld [wC52F], a
    ld [wC530], a
    call Func_000_0355
    xor a, a
    ld [wC5DF], a
    ld [wC5E0], a
    ld [wC5EE], a
    ld [wC0C0], a
    ld [wC0C1], a
    ld [wC0D8], a
    ld [wC0D9], a
    ld [wC5ED], a
    ld [wC5F0], a
    ld [wC5F1], a
    ldh [hFFB9], a
    ld a, $80
    ldh [hFFBA], a
    xor a, a
    ld [wC58D], a
    ld [wC58E], a
    ld hl, wC604
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_000_0324::
    ld a, [wC58A]
    or a, a
    call z, Func_000_095B
    halt
    nop
    ld a, [wC5DF]
    or a, a
    jr z, Jump_000_0324
    ld a, [wC56C]
    or a, a
    jr z, Jump_000_033D
    bit 7, a
    jr z, Jump_000_0324

Jump_000_033D::
    di
    call Func_000_078D
    call Func_000_05D1
    ld a, $00
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    jp Jump_000_02D2

Func_000_0355::
    ld a, [wC5DB]
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
    ld hl, Func_001_4001
    ld b, $01
    rst $10
    ret

Jump_000_0372::
    ld hl, Func_002_45C6
    ld b, $02
    rst $10
    ret

Jump_000_0379::
    ld hl, Func_003_4001
    ld b, $03
    rst $10
    ret

Jump_000_0380::
    ret

Jump_000_0381::
    ld hl, Func_031_4001
    ld b, $31
    rst $10
    ret

Jump_000_0388::
    ld hl, Func_007_486E
    ld b, $07
    rst $10
    ret

Jump_000_038F::
    ld hl, Func_024_4001
    ld b, $24
    rst $10
    ret

Jump_000_0396::
    ld hl, Func_0A0_4ECF
    ld b, $A0
    rst $10
    ret

Jump_000_039D::
    ld hl, Func_0F2_4001
    ld b, $F2
    rst $10
    ret

Jump_000_03A4::
    push af
    push bc
    push de
    push hl
    ldh a, [rSVBK]
    ld b, a
    ld a, $00
    ldh [rSVBK], a
    push bc
    ldh a, [rVBK]
    push af
    ld hl, wC5ED
    bit 0, [hl]
    jp nz, Jump_000_046B
    set 0, [hl]
    call $FF80
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_03EA
    ld a, [wC56C]
    or a, a
    jr nz, Jump_000_03EA
    ld hl, wC526
    ld a, [hl]
    inc hl
    or a, [hl]
    jr z, Jump_000_03EA
    ld a, [wC526]
    or a, a
    call nz, Func_000_0829
    xor a, a
    ld [wC526], a
    ld a, [wC527]
    or a, a
    call nz, Func_000_085C
    xor a, a
    ld [wC527], a

Jump_000_03EA::
    call Func_000_0BCC
    call Func_000_07FD
    call Func_000_07E0
    call Func_000_04ED
    call Func_000_07F1
    ld a, [wC58A]
    and a, a
    jr nz, Jump_000_042E
    ei
    call Func_000_0A17
    call Func_000_0A8D
    call Func_000_33E8
    call Func_000_09F3
    call Func_000_131A
    call Func_000_0474
    ld a, [wC52B]
    or a, a
    call nz, Func_000_2620
    call Func_000_0F4E
    ld a, [wC5F0]
    add a, $01
    ld [wC5F0], a
    ld a, [wC5F1]
    adc a, $00
    ld [wC5F1], a
    jr Jump_000_043A

Jump_000_042E::
    call Func_000_33E8
    ei
    call Func_000_131A
    call Func_000_0474
    jr Jump_000_043A

Jump_000_043A::
    ld a, [wC56C]
    or a, a
    jr nz, Jump_000_0456
    ld a, [wC55E]
    and a, $0F
    cp a, $0F
    jr nz, Jump_000_0450
    ld a, [wC58A]
    or a, a
    jp z, Jump_000_015A

Jump_000_0450::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_000_0456

Jump_000_0456::
    ld hl, wC5ED
    res 0, [hl]

Jump_000_045B::
    pop af
    ldh [rVBK], a
    ldh a, [rLY]
    ld [wC5D7], a
    pop af
    ldh [rSVBK], a
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
    ldh [hFFB1], a
    call Func_000_252D
    call Func_000_048A
    ld a, [wC56C]
    or a, a
    jr z, Jump_000_0486
    bit 7, a
    ret z

Jump_000_0486::
    call Func_000_0BB4
    ret

Func_000_048A::
    ld a, [wC5DF]
    or a, a
    ret nz
    ld a, [wC58A]
    or a, a
    jr nz, Jump_000_049E
    ld a, [wC56C]
    or a, a
    jr z, Jump_000_049E
    bit 7, a
    ret z

Jump_000_049E::
    ld a, [wC5DB]
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
    ld hl, Func_001_4AD4
    ld b, $01
    rst $10
    ret

Jump_000_04BB::
    ld hl, Func_002_4AD8
    ld b, $02
    rst $10
    ret

Jump_000_04C2::
    ld hl, Func_003_4015
    ld b, $03
    rst $10
    ret

Jump_000_04C9::
    ret

Jump_000_04CA::
    ld hl, Func_031_40A5
    ld b, $31
    rst $10
    ret

Jump_000_04D1::
    ld hl, Func_007_4F7B
    ld b, $07
    rst $10
    ret

Jump_000_04D8::
    ld hl, Func_024_4117
    ld b, $24
    rst $10
    ret

Jump_000_04DF::
    ld hl, Func_0A0_4F70
    ld b, $A0
    rst $10
    ret

Jump_000_04E6::
    ld hl, Func_0F2_40A2
    ld b, $F2
    rst $10
    ret

Func_000_04ED::
    ld hl, wC604
    ld b, [hl]
    inc hl
    or a, [hl]
    ret z
    ld a, [wC604]
    or a, a
    jr z, Jump_000_0511
    dec a
    ld [wC604], a
    ldh a, [rSCY]
    ld b, a
    ld a, [wC604]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, Jump_000_050E
    xor a, $07

Jump_000_050E::
    add a, b
    ldh [rSCY], a

Jump_000_0511::
    ld a, [wC605]
    or a, a
    jr z, Jump_000_0530
    dec a
    ld [wC605], a
    ldh a, [rSCX]
    ld b, a
    ld a, [wC605]
    add a, a
    ld c, a
    and a, $07
    bit 3, c
    jr nz, Jump_000_052B
    xor a, $07

Jump_000_052B::
    sub a, $04
    add a, b
    ldh [rSCX], a

Jump_000_0530::
    ret
    db $CD, $CC, $0B, $C9

Func_000_0535::
    ld a, [wC58A]
    or a, a
    ret z
    ld a, [wC58D]
    add a, $01
    ld [wC58D], a
    ld a, [wC58E]
    adc a, $00
    ld [wC58E], a
    or a, a
    jp nz, Jump_000_015A
    ld a, [wC57F]
    bit 1, a
    ret nz
    ld a, [wC581]
    cp a, $05
    jr nz, Jump_000_0563
    ld a, [wC5ED]
    bit 1, a
    ret nz
    jr Jump_000_057C

Jump_000_0563::
    ld a, [wC5ED]
    bit 1, a
    jr nz, Jump_000_0574
    bit 2, a
    jr nz, Jump_000_0574
    bit 7, a
    jr nz, Jump_000_0574
    jr Jump_000_057C

Jump_000_0574::
    xor a, a
    ld [wC56A], a
    ld [wC56B], a
    ret

Jump_000_057C::
    ld a, [wC55E]
    ld [wC56A], a
    ld a, [wC55F]
    ld [wC56B], a
    call Func_000_0A17
    ld a, [wC594]
    cp a, $FF
    jr z, Jump_000_059D
    ld a, $00
    ld [wC582], a
    ld a, [wC594]
    jp Func_000_08AD

Jump_000_059D::
    ld hl, wC592
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_000_05C7
    ld a, [wC595]
    ld l, a
    ld a, [wC596]
    ld h, a
    push hl
    ld a, [wC595]
    add a, $01
    ld [wC595], a
    ld a, [wC596]
    adc a, $00
    ld [wC596], a
    pop hl
    ld a, $00
    ld [wC582], a
    ld a, [hl]
    jp Func_000_08AD

Jump_000_05C7::
    ld a, $00
    ld [wC582], a
    ld a, $F0
    jp Func_000_08AD

Func_000_05D1::
    ld a, [wC524]
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
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ldh a, [rP1]
    and a, $03
    cp a, $03
    jr nz, Jump_000_0636
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ld a, $30
    ldh [rP1], a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ld a, $30
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    and a, $03
    cp a, $03
    jr nz, Jump_000_0636
    ld a, $0A
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    sub a, a
    ret

Jump_000_0636::
    ld a, $0A
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    scf
    ret

Func_000_0646::
    ldh a, [rP1]
    ld b, $04
    ld c, a
    jr Jump_000_0651

Jump_000_064D::
    ldh a, [rP1]
    cp a, c
    ret z

Jump_000_0651::
    cpl
    and a, $03
    sla a
    ld d, $00
    ld e, a
    ld hl, wC474
    add hl, de
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and a, $0F
    swap a
    ld d, a
    ld a, $30
    ldh [rP1], a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
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
    ldh [rP1], a
    dec b
    jr nz, Jump_000_064D
    ret

Func_000_0692::
    ld a, [wC524]
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
    ld [wC47C], a
    ld a, [wC524]
    or a, a
    ret z
    push bc
    call Func_000_0796
    call Func_000_0B9B
    xor a, a
    ldh [rSCX], a
    ldh [rSCY], a
    push de
    ld hl, vTiles1
    ld bc, $1000
    xor a, a
    call Func_000_0949
    pop de
    ld a, $E4
    ldh [rBGP], a
    pop bc
    ld hl, vTiles1
    call Func_000_0C5A
    ld hl, vBGMap0
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
    ldh [rLCDC], a
    ld [wC5EC], a
    ld bc, $0005
    call Func_000_0692
    ld hl, Func_01F_5040
    ld b, $1F
    rst $10
    ld bc, $0006
    call Func_000_0692
    call Func_000_0796
    ret

Func_000_0705::
    ld [wC47C], a
    ld a, [wC524]
    or a, a
    ret z
    push hl
    push bc
    call Func_000_0796
    call Func_000_0B9B
    xor a, a
    ldh [rSCX], a
    ldh [rSCY], a
    ld a, $E4
    ldh [rBGP], a
    pop bc
    pop hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    push bc
    ld a, h
    ld [rROMB0], a
    pop bc
    ld hl, vTiles1

Jump_000_072D::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_000_072D
    ld hl, vBGMap0
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
    ldh [rLCDC], a
    ld [wC5EC], a
    ld bc, $0005
    call Func_000_0692
    ld hl, Func_01F_5040
    ld b, $1F
    rst $10
    ld bc, $0006
    call Func_000_0692
    call Func_000_0796
    pop af
    ld [rROMB0], a
    ret

Func_000_076B::
    push hl
    push bc
    xor a, a
    ld hl, wC47F
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
    ld a, [wC58A]
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
    ldh [rIF], a
    ldh a, [rIE]
    and a, $E2
    ldh [rIE], a

Func_000_0796::
    ld hl, rLCDC
    bit 7, [hl]
    ret z

Jump_000_079C::
    ldh a, [rLY]
    cp a, $91
    jr nz, Jump_000_079C
    res 7, [hl]
    ld hl, wC5EC
    res 7, [hl]
    ret

Func_000_07AA::
    ld hl, wC5EC
    set 7, [hl]
    ld a, [hl]
    ldh [rLCDC], a
    ld a, [wC524]
    or a, a
    ret z
    ld a, $01
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    call Func_000_05D1
    ret
    db $C9, $AF, $E0, $0F, $F0, $FF, $E6, $F7, $E0, $FF, $C9

Func_000_07D1::
    ldh a, [rSC]
    bit 7, a
    jr nz, Func_000_07D1
    ret

Func_000_07D8::
    ld b, a
    xor a, a
    ldh [rIF], a
    ld a, b
    ldh [rIE], a
    ret

Func_000_07E0::
    ldh a, [hFFA1]
    ldh [rSCX], a
    ldh a, [hFFA5]
    ldh [rSCY], a
    ldh a, [hFF9F]
    ldh [rWX], a
    ldh a, [hFFA0]
    ldh [rWY], a
    ret

Func_000_07F1::
    ldh a, [rSTAT]
    and a, $03
    jr nz, Func_000_07F1
    ld a, [wC5EC]
    ldh [rLCDC], a
    ret

Func_000_07FD::
    ld hl, wC5E9
    ld a, [hl+]
    ldh [rBGP], a
    ld a, [hl+]
    ldh [rOBP0], a
    ld a, [hl]
    ldh [rOBP1], a
    ret

Func_000_080A:: ; heuristic: follows a terminator; C0
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
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
    ld [rROMB0], a
    ret

Func_000_0829::
    ld a, [wC526]
    bit 7, a
    jr z, Jump_000_0841
    ldh [rBGPI], a
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
    ldh [rBGPI], a
    ei
    ld b, $40
    ld hl, wC49F

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
    ld a, [wC527]
    bit 7, a
    jr z, Jump_000_0876
    ldh [rOBPI], a
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
    ldh [rOBPI], a
    ei
    ld b, $40
    ld de, wC4DF

Jump_000_0884::
    ld hl, rOBPD

Jump_000_0887::
    ld a, [de]
    inc de
    ld c, a
    di

Jump_000_088B::
    ldh a, [rSTAT]
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
    ldh a, [rSTAT]
    or a, $40
    ldh [rSTAT], a
    ret

Func_000_08A6::
    ldh a, [rSTAT]
    and a, $07
    ldh [rSTAT], a
    ret

Func_000_08AD::
    di
    call Func_000_08C7
    ld hl, rSC
    set 0, [hl]
    set 7, [hl]
    ei
    ret

Func_000_08BA::
    di
    call Func_000_08C7
    ld hl, rSC
    res 0, [hl]
    set 7, [hl]
    ei
    ret

Func_000_08C7::
    ld b, a
    ld a, $00
    ldh [rSC], a
    ld a, b
    ldh [rSB], a
    ret

Func_000_08D0::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_08EC
    xor a, a
    ldh [rVBK], a
    ldh [rSVBK], a
    ldh [rHDMA1], a
    ldh [rHDMA2], a
    ldh [rHDMA3], a
    ldh [rHDMA4], a
    ldh [rHDMA5], a
    ldh [rBGPI], a
    ldh [rOBPI], a
    ld a, [wIsCGB]

Jump_000_08EC::
    push af
    ld hl, wC000
    ld bc, $1E00
    ld a, $00
    call Func_000_0949
    ld hl, hFF8A
    ld bc, $0074
    ld a, $00
    call Func_000_0949
    pop af
    ld [wIsCGB], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $02
    ld [rRAMB], a
    xor a, a
    ld hl, sA000
    ld bc, $2000
    call Func_000_0949
    ld a, $00
    ld [rRAMB], a
    xor a, a
    ld hl, sA000
    ld bc, $2000
    call Func_000_0949
    ld a, $00
    ld [rRAMG], a
    ret

Func_000_0930::
    ld hl, vBGMap0
    ld bc, $0800
    ld a, [wD066]
    or a, a
    jr z, Jump_000_0945
    xor a, a
    ld [wD066], a
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
    ld a, [wC5E8]
    inc a
    and a, $7F
    ld [wC5E8], a
    ld hl, $0973
    add a, l
    ld l, a
    jr nc, Jump_000_096D
    inc h

Jump_000_096D::
    ld a, [hl]
    ld [wC5E7], a
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $000973, $80

Func_000_09F3::
    push hl
    push bc
    ld a, [wCD03]
    ld l, a
    ld a, [wCD04]
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
    ld [wCD03], a
    ld a, h
    adc a, $00
    ld [wCD04], a
    pop bc
    pop hl
    ret

Func_000_0A17::
    ld a, [wC524]
    or a, a
    jr z, Jump_000_0A39
    call Func_000_0646
    ld a, [wC55E]
    ld [wC55F], a
    ld a, [wC474]
    ld [wC55E], a
    ld a, [wC560]
    ld [wC561], a
    ld a, [wC476]
    ld [wC560], a
    ret

Jump_000_0A39::
    xor a, a
    ld [wC55D], a
    call Func_000_0A61
    ld a, [wC55E]
    ld [wC55F], a
    ld a, b
    ld [wC55E], a
    ld a, $30
    ldh [rP1], a
    ret

Func_000_0A4F:: ; heuristic: follows a terminator; C0
    call Func_000_0A61
    ld a, [wC560]
    ld [wC561], a
    ld a, b
    ld [wC560], a
    ld a, $30
    ldh [rP1], a
    ret

Func_000_0A61::
    ld a, $20
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and a, $0F
    swap a
    ld b, a
    ld a, $10
    ldh [rP1], a
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    cpl
    and a, $0F
    or a, b
    ld b, a
    ret

Func_000_0A8D::
    ld a, [wC58A]
    or a, a
    jr nz, Jump_000_0AA0
    ld a, [wC55D]
    or a, a
    jr nz, Jump_000_0AA0
    xor a, a
    ld [wC560], a
    ld [wC561], a

Jump_000_0AA0::
    xor a, a
    ld [wC563], a
    ld hl, wC55E
    ld a, [hl]
    inc hl
    xor a, [hl]
    dec hl
    and a, [hl]
    ld [wC562], a
    ld hl, wC55E
    ld a, [hl+]
    or a, a
    jr z, Jump_000_0AB9
    cp a, [hl]
    jr z, Jump_000_0AC6

Jump_000_0AB9::
    ld a, [wC562]
    ld [wC563], a
    ld a, $14
    ld [wC564], a
    jr Jump_000_0AD6

Jump_000_0AC6::
    ld hl, wC564
    ld a, [hl]
    or a, a
    jr nz, Jump_000_0AD5
    ld [hl], $06
    ld a, [wC55E]
    ld [wC563], a

Jump_000_0AD5::
    dec [hl]

Jump_000_0AD6::
    xor a, a
    ld [wC567], a
    ld hl, wC560
    ld a, [hl]
    inc hl
    xor a, [hl]
    dec hl
    and a, [hl]
    ld [wC566], a
    ld hl, wC560
    ld a, [hl+]
    or a, a
    jr z, Jump_000_0AEF
    cp a, [hl]
    jr z, Jump_000_0AFC

Jump_000_0AEF::
    ld a, [wC566]
    ld [wC567], a
    ld a, $14
    ld [wC568], a
    jr Jump_000_0B0C

Jump_000_0AFC::
    ld hl, wC568
    ld a, [hl]
    or a, a
    jr nz, Jump_000_0B0B
    ld [hl], $06
    ld a, [wC560]
    ld [wC567], a

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

; C2 static reading (E-0014): selects ROM bank B and copies C bytes from [DE] to [HL] (C = 0 copies 256), then restores the caller's bank.
Func_000_0B18::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

Jump_000_0B20::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0B20
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): like Func_000_0B18, but before each byte waits for STAT ($FF41) bit 1 to clear with interrupts disabled, so HL can be VRAM.
Func_000_0B2B::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

Jump_000_0B33::
    di

Jump_000_0B34::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0B34
    ld a, [de]
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_000_0B33
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): selects ROM bank B; C times reads a byte from [DE] (advancing DE once), waits for STAT bit 1 to clear, ORs the byte into [HL] and advances HL; then restores the caller's bank. Clobbers B.
Func_000_0B46::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a

Jump_000_0B4E::
    di

Jump_000_0B4F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0B4F
    ld a, [de]
    ld b, a
    inc de
    ei
    di

Jump_000_0B5A::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0B5A
    ld a, [hl]
    or a, b
    ld [hl+], a
    ei
    dec c
    jr nz, Jump_000_0B4E
    pop af
    ld [rROMB0], a
    ret

; C2 static reading (E-0014): switches to the ROM bank held in $D7FE, reads the word at [HL] into B (low address) and C (next address), leaves HL unchanged, restores the caller's bank. $D7FE is therefore the data-bank variable for reads through HL; 30 call sites.
Func_000_0B6C::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wDataBank]
    ld [rROMB0], a
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    ld c, a
    pop af
    ld [rROMB0], a
    ret

Func_000_0B7F::
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld hl, wD040
    ld a, [wC5E9]
    ld [hl+], a
    ld a, [wC5EA]
    ld [hl+], a
    ld a, [wC5EB]
    ld [hl], a
    ret

Func_000_0B9B::
    xor a, a
    ld hl, hFFA1
    call Func_000_0BA2

Func_000_0BA2::
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ret

Func_000_0BA7::
    xor a, a
    ldh [hFFB1], a
    ld hl, wC000
    ld b, $A0

Jump_000_0BAF::
    ld [hl+], a
    dec b
    jr nz, Jump_000_0BAF
    ret

Func_000_0BB4::
    ldh a, [hFFB1]
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
    ld a, [wC0C0]
    ld e, a
    ld a, [wC0C1]
    ld d, a
    ld a, d
    or a, e
    jr nz, Jump_000_0BD9
    ret

Jump_000_0BD9::
    ld a, [wC0C3]
    ld b, a
    ld hl, wC0C4
    ld a, [wC0C2]
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
    ld [wC0C0], a
    ld [wC0C1], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, [wC0D8]
    ld e, a
    ld a, [wC0D9]
    ld d, a
    ld a, d
    or a, e
    jr nz, Jump_000_0C22
    ret

Jump_000_0C22::
    ld a, [wC0DB]
    ld b, a
    ld hl, wC0DC
    ld a, [wC0DA]
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
    ldh [rVBK], a
    xor a, a
    ld [wC0D8], a
    ld [wC0D9], a
    ret

; C2 static reading (E-0016): takes the lock byte $FFD6 (spins while it is non-zero), calls Func_000_0C69, then clears the lock.
Func_000_0C5A::
    ldh a, [hDecompressLock]
    or a, a
    jr nz, Func_000_0C5A
    inc a
    ldh [hDecompressLock], a
    call Func_000_0C69
    xor a, a
    ldh [hDecompressLock], a
    ret

; C2 (E-0016: static reading; 141 emulated calls matched tools/lzss_gfx.py byte for byte): expands the compressed stream at [DE] in ROM bank B into memory at [HL] with a plain store per byte (RAM destination). Header and format: see Func_000_0DA8. Restores the caller's bank on return.
Func_000_0C69::
    ld a, [BANK_NUMBER_BYTE]
    push af
    call Func_000_0DA8

Jump_000_0C70::
    ld a, [de]
    inc de
    push hl
    ld hl, hDecompressMarker
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
    ldh [hFFC0], a
    inc de
    ld a, [de]
    ldh [hFFBF], a
    inc de
    ldh a, [hFFBF]
    push af
    and a, $0F
    add a, $04
    cp a, $13
    jr nz, Jump_000_0C9B
    ld a, [de]
    inc de
    add a, $13

Jump_000_0C9B::
    ldh [hFFBF], a
    pop af
    push de
    swap a
    and a, $0F
    ld d, a
    ldh a, [hFFC0]
    ld e, a
    push hl
    ldh a, [hDecompressDestLo]
    ld l, a
    ldh a, [hDecompressDestHi]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl

Jump_000_0CB2::
    ldh a, [hFFC2]
    cp a, d
    jr z, Jump_000_0CBB
    jr c, Jump_000_0CC2
    jr Jump_000_0CDD

Jump_000_0CBB::
    ldh a, [hFFC1]
    cp a, e
    jr z, Jump_000_0CC2
    jr nc, Jump_000_0CDD

Jump_000_0CC2::
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [hFFC4]
    cp a, d
    jr z, Jump_000_0CCF
    jr nc, Jump_000_0CD6
    jr Jump_000_0CDD

Jump_000_0CCF::
    ldh a, [hFFC3]
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
    ldh a, [hFFBF]
    dec a
    ldh [hFFBF], a
    jr nz, Jump_000_0CB2
    pop de
    jr Jump_000_0C70

Jump_000_0CEF::
    pop de

Jump_000_0CF0::
    pop af
    ld [rROMB0], a
    ret

; C2 (E-0016): the same expansion as Func_000_0C69 but for VRAM destinations: each store waits for STAT ($FF41) bit 1 to clear with interrupts disabled, back-references read the already-written VRAM, and the lock byte $FFD6 is taken on entry and cleared on exit.
Func_000_0CF5::
    ldh a, [hDecompressLock]
    or a, a
    jr nz, Func_000_0CF5
    inc a
    ldh [hDecompressLock], a
    ld a, [BANK_NUMBER_BYTE]
    push af
    call Func_000_0DA8

Jump_000_0D04::
    ld a, [de]
    inc de
    push hl
    ld hl, hDecompressMarker
    cp a, [hl]
    jr z, Jump_000_0D22
    pop hl
    ldh [hFFC5], a
    di

Jump_000_0D11::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0D11
    ldh a, [hFFC5]
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
    ldh [hFFC0], a
    inc de
    ld a, [de]
    ldh [hFFBF], a
    inc de
    ldh a, [hFFBF]
    ldh [hFFC5], a
    and a, $0F
    add a, $04
    cp a, $13
    jr nz, Jump_000_0D3B
    ld a, [de]
    inc de
    add a, $13

Jump_000_0D3B::
    ldh [hFFBF], a
    ldh a, [hFFC5]
    push de
    swap a
    and a, $0F
    ld d, a
    ldh a, [hFFC0]
    ld e, a
    ldh a, [hDecompressDestLo]
    add a, e
    ld e, a
    ldh a, [hDecompressDestHi]
    adc a, d
    ld d, a

Jump_000_0D50::
    ldh a, [hFFC2]
    cp a, d
    jr z, Jump_000_0D59
    jr c, Jump_000_0D60
    jr Jump_000_0D84

Jump_000_0D59::
    ldh a, [hFFC1]
    cp a, e
    jr z, Jump_000_0D60
    jr nc, Jump_000_0D84

Jump_000_0D60::
    ld a, $F0
    add a, d
    ld d, a
    ldh a, [hFFC4]
    cp a, d
    jr z, Jump_000_0D6D
    jr nc, Jump_000_0D74
    jr Jump_000_0D84

Jump_000_0D6D::
    ldh a, [hFFC3]
    cp a, e
    jr z, Jump_000_0D84
    jr c, Jump_000_0D84

Jump_000_0D74::
    ld a, $10
    add a, d
    ld d, a
    di

Jump_000_0D79::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_0D79
    xor a, a
    ld [hl+], a
    ei
    jr Jump_000_0D8E

Jump_000_0D84::
    di

Jump_000_0D85::
    ldh a, [rSTAT]
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
    ldh a, [hFFBF]
    dec a
    ldh [hFFBF], a
    jr nz, Jump_000_0D50
    pop de
    jp Jump_000_0D04

Jump_000_0D9F::
    pop de

Jump_000_0DA0::
    pop af
    ld [rROMB0], a
    xor a, a
    ldh [hDecompressLock], a
    ret

; C2 static reading (E-0016): selects ROM bank B, then reads the compressed-stream header from [DE]: u16 output size into BC, a marker byte into $FFBB. Saves the destination start (HL) in $FFBC/$FFBD and $FFC3/$FFC4 and the destination end (HL + size) in $FFC1/$FFC2.
Func_000_0DA8::
    ld a, b
    ld [rROMB0], a
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ldh [hDecompressMarker], a
    inc de
    ld a, l
    ldh [hDecompressDestLo], a
    ldh [hFFC3], a
    ld a, h
    ldh [hDecompressDestHi], a
    ldh [hFFC4], a
    push hl
    add hl, bc
    ld a, l
    ldh [hFFC1], a
    ld a, h
    ldh [hFFC2], a
    pop hl
    ret

Func_000_0DCA::
    ld hl, wC56F
    ld a, [wC5E9]
    ld [hl+], a
    ld a, [wC5EA]
    ld [hl+], a
    ld a, [wC5EB]
    ld [hl], a
    jr Jump_000_0DDB

Jump_000_0DDB::
    xor a, a
    ld hl, wC572
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld [wC56C], a
    ld a, $07
    ld [wC56D], a
    ld a, $1F
    ld [wC56E], a
    ret

Func_000_0DF2::
    ld b, a
    ld a, [wIsCGB]
    or a, a
    jp nz, Jump_000_0E9B
    ld a, [wC524]
    or a, a
    jp z, Jump_000_0EA8
    bit 7, b
    jr nz, Jump_000_0E2C
    ld a, b
    ld [wC56C], a
    ld hl, wC4FF
    ld de, wC4DF
    ld c, $20

Jump_000_0E11::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0E11
    ld a, $00
    ld [wC572], a
    ld a, [wC56C]
    srl a
    srl a
    ld [wC573], a
    ld [wC574], a
    jp Jump_000_0F3D

Jump_000_0E2C::
    ld a, b
    ld [wC56C], a
    ld a, $20
    ld [wC572], a
    ld a, [wC56C]
    cpl
    srl a
    srl a
    ld [wC573], a
    ld [wC574], a
    ld hl, wC4FF
    ld de, wC4DF
    ld c, $20

Jump_000_0E4B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_000_0E4B
    ld de, $7FFF
    ld a, [wC56D]
    bit 7, a
    jr z, Jump_000_0E5E
    ld de, $0000

Jump_000_0E5E::
    ld hl, wC4DF
    ld c, $10

Jump_000_0E63::
    ld [hl], e
    inc hl
    ld [hl], d
    inc hl
    dec c
    jr nz, Jump_000_0E63
    call Func_000_076B
    ld hl, wC4DF
    ld de, wC47F
    ld a, $01
    ld [de], a
    inc de
    call Func_000_1022
    call Func_000_05D1
    ld a, [wC56E]
    bit 4, a
    jp z, Jump_000_0F3D
    call Func_000_076B
    ld hl, wC4EF
    ld de, wC47F
    ld a, $09
    ld [de], a
    inc de
    call Func_000_1022
    call Func_000_05D1
    jp Jump_000_0F3D

Jump_000_0E9B::
    ld a, b
    ld [wC56C], a
    ld hl, Func_002_4001
    ld b, $02
    rst $10
    jp Jump_000_0F3D

Jump_000_0EA8::
    ld a, [wC56D]
    bit 7, a
    jr nz, Jump_000_0EF7
    bit 7, b
    jr nz, Jump_000_0ED8
    ld a, b
    ld [wC56C], a
    ld hl, wC56F
    ld a, [wC5E9]
    ld [hl+], a
    ld a, [wC5EA]
    ld [hl+], a
    ld a, [wC5EB]
    ld [hl], a
    ld a, $00
    ld [wC572], a
    ld a, [wC56C]
    add a, $02
    ld [wC573], a
    ld [wC574], a
    jr Jump_000_0F3D

Jump_000_0ED8::
    ld a, b
    ld [wC56C], a
    ld a, $04
    ld [wC572], a
    ld a, [wC56C]
    cpl
    add a, $02
    ld [wC573], a
    ld [wC574], a
    ld a, $00
    ld hl, wC5E9
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    jr Jump_000_0F3D

Jump_000_0EF7::
    bit 7, b
    jr nz, Jump_000_0F20
    ld a, b
    ld [wC56C], a
    ld hl, wC56F
    ld a, [wC5E9]
    ld [hl+], a
    ld a, [wC5EA]
    ld [hl+], a
    ld a, [wC5EB]
    ld [hl], a
    ld a, $00
    ld [wC572], a
    ld a, [wC56C]
    add a, $02
    ld [wC573], a
    ld [wC574], a
    jr Jump_000_0F3D

Jump_000_0F20::
    ld a, b
    ld [wC56C], a
    ld a, $04
    ld [wC572], a
    ld a, [wC56C]
    cpl
    add a, $02
    ld [wC573], a
    ld [wC574], a
    ld a, $FF
    ld hl, wC5E9
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_000_0F3D::
    ret

Func_000_0F3E:: ; heuristic: follows a terminator; C0
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, vTiles1
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
    ld a, [wC56C]
    or a, a
    ret z
    bit 7, a
    call z, Func_000_137D
    ld a, [wIsCGB]
    or a, a
    jp nz, Jump_000_10C7
    ld a, [wC524]
    or a, a
    jp z, Jump_000_10CE
    ld a, [wC56C]
    bit 7, a
    jr nz, Jump_000_0F98
    ld a, [wC574]
    or a, a
    jr z, Jump_000_0F78
    dec a
    ld [wC574], a
    ret

Jump_000_0F78::
    ld a, [wC572]
    add a, $05
    cp a, $1F
    jr c, Jump_000_0F83
    ld a, $1F

Jump_000_0F83::
    ld [wC572], a
    call Func_000_0FC1
    ld a, [wC573]
    ld [wC574], a
    ld a, [wC572]
    cp a, $1F
    jp z, Jump_000_1205
    ret

Jump_000_0F98::
    ld a, [wC574]
    or a, a
    jr z, Jump_000_0FA3
    dec a
    ld [wC574], a
    ret

Jump_000_0FA3::
    ld a, [wC572]
    sub a, $05
    bit 7, a
    jr z, Jump_000_0FAD
    xor a, a

Jump_000_0FAD::
    ld [wC572], a
    call Func_000_0FC1
    ld a, [wC573]
    ld [wC574], a
    ld a, [wC572]
    or a, a
    jp z, Jump_000_1205
    ret

Func_000_0FC1::
    ld a, [wC56E]
    bit 0, a
    ld a, $00
    ld [wC576], a
    call nz, Func_000_1040
    ld a, [wC56E]
    bit 1, a
    ld a, $08
    ld [wC576], a
    call nz, Func_000_1040
    ld a, [wC56E]
    bit 4, a
    jr z, Jump_000_0FFC
    ld a, [wC56E]
    bit 2, a
    ld a, $10
    ld [wC576], a
    call nz, Func_000_1040
    ld a, [wC56E]
    bit 3, a
    ld a, $18
    ld [wC576], a
    call nz, Func_000_1040

Jump_000_0FFC::
    call Func_000_076B
    ld hl, wC4DF
    ld de, wC47F
    ld a, $01
    ld [de], a
    inc de
    call Func_000_1022
    ld a, [wC56E]
    bit 4, a
    ret z
    call Func_000_05D1
    call Func_000_076B
    ld hl, wC4EF
    ld de, wC47F
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
    ld [wC47C], a
    ld b, $1F
    ld hl, Func_01F_5040
    rst $10
    ret

Func_000_1040::
    call Func_000_1051
    call Func_000_1049
    call Func_000_1049

Func_000_1049::
    ld a, [wC576]
    add a, $02
    ld [wC576], a

Func_000_1051::
    ld hl, wC4FF
    ld a, [wC576]
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
    ld a, [wC572]
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
    ld hl, wC4DF
    ld b, $00
    ld a, [wC576]
    ld c, a
    add hl, bc
    ld [hl], e
    inc hl
    ld [hl], d
    ret

Func_000_10AB::
    push af
    ld a, [wC56D]
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
    ld hl, Func_002_4071
    ld b, $02
    rst $10
    ret

Jump_000_10CE::
    ld a, [wC56D]
    bit 7, a
    jp nz, Jump_000_116D
    ld a, [wC56C]
    bit 7, a
    jr nz, Jump_000_10FE
    ld a, [wC574]
    or a, a
    jr z, Jump_000_10E8
    dec a
    ld [wC574], a
    ret

Jump_000_10E8::
    call Func_000_111F
    ld a, [wC573]
    ld [wC574], a
    ld a, [wC572]
    inc a
    ld [wC572], a
    cp a, $04
    jp z, Jump_000_1205
    ret

Jump_000_10FE::
    ld a, [wC574]
    or a, a
    jr z, Jump_000_1109
    dec a
    ld [wC574], a
    ret

Jump_000_1109::
    call Func_000_111F
    ld a, [wC573]
    ld [wC574], a
    ld a, [wC572]
    dec a
    ld [wC572], a
    cp a, $FF
    jp z, Jump_000_1205
    ret

Func_000_111F::
    ld a, [wC56D]
    bit 0, a
    ld a, [wC56F]
    ld hl, wC5E9
    call nz, Func_000_1145
    ld a, [wC56D]
    bit 1, a
    ld a, [wC570]
    inc hl
    call nz, Func_000_1145
    ld a, [wC56D]
    bit 2, a
    ld a, [wC571]
    inc hl
    jr nz, Func_000_1145
    ret

Func_000_1145::
    ld d, a
    ld a, [wC572]
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
    ld a, [wC56C]
    bit 7, a
    jr nz, Jump_000_1194
    ld a, [wC574]
    or a, a
    jr z, Jump_000_117F
    dec a
    ld [wC574], a
    ret

Jump_000_117F::
    call Func_000_11B4
    ld a, [wC573]
    ld [wC574], a
    ld a, [wC572]
    inc a
    ld [wC572], a
    cp a, $04
    jr z, Jump_000_1205
    ret

Jump_000_1194::
    ld a, [wC574]
    or a, a
    jr z, Jump_000_119F
    dec a
    ld [wC574], a
    ret

Jump_000_119F::
    call Func_000_11B4
    ld a, [wC573]
    ld [wC574], a
    ld a, [wC572]
    dec a
    ld [wC572], a
    cp a, $FF
    jr z, Jump_000_1205
    ret

Func_000_11B4::
    ld a, [wC56D]
    bit 0, a
    ld a, [wC56F]
    ld hl, wC5E9
    call nz, Func_000_11DA
    ld a, [wC56D]
    bit 1, a
    ld a, [wC570]
    inc hl
    call nz, Func_000_11DA
    ld a, [wC56D]

Func_000_11D1::
    bit 2, a
    ld a, [wC571]
    inc hl
    jr nz, Func_000_11DA
    ret

Func_000_11DA::
    ld d, a
    ld a, [wC572]
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
    ld [wC56C], a
    ret

Func_000_120A::
    ldh a, [rSTAT]
    bit 1, a
    ret z
    jr Func_000_120A

Func_000_1211::
    ldh [hFFD1], a
    di

Jump_000_1214::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_1214
    ldh a, [hFFD1]
    ld [hl], a
    ei
    ret

Func_000_121F::
    ldh [hFFD1], a
    di

Jump_000_1222::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_1222
    ldh a, [hFFD1]
    ld [hl+], a
    ei
    ret

Func_000_122D::
    ld [wC60A], a
    ret

Func_000_1231::
    ld [wC608], a
    di
    call Func_000_3290
    ld a, [wC608]
    or a, a
    jr z, Jump_000_1276
    ld [wSoundId], a
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
    ld [wC60B], a
    ret

Func_000_127C::
    push af
    push bc
    push de
    push hl
    ld [wSoundId], a
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
    ld a, [wC60A]
    cp a, $FF
    jr z, Jump_000_1329
    call Func_000_1231
    ld a, $FF
    ld [wC60A], a

Jump_000_1329::
    ld a, [wC60B]
    cp a, $FF
    jr z, Jump_000_1338
    call Func_000_127C
    ld a, $FF
    ld [wC60B], a

Jump_000_1338::
    ret
    db $C9, $47, $FA, $E0, $C5, $B7, $20, $37, $78, $CB, $7F, $20, $32, $B7, $28, $2F
    db $EA, $E2, $C5, $FA, $24, $C5, $B7

Func_000_1350:: ; heuristic: target of a pointer table; C0
    jr nz, Jump_000_135A
    ld a, [wC5E2]

Func_000_1355:: ; heuristic: target of a pointer table; C0
    sra a
    ld [wC5E2], a

Jump_000_135A::
    ldh a, [rNR50]
    bit 7, a
    jr nz, Jump_000_1378
    bit 3, a

Func_000_1362:: ; heuristic: target of a pointer table; C0
    jr nz, Jump_000_1378
    or a, a
    jr z, Jump_000_1378
    ld a, [wC5E2]
    ld [wC5E3], a
    ld a, $08
    ld [wC5E4], a
    ldh a, [rNR50]
    ld [wC5E5], a
    ret

Jump_000_1378::
    xor a, a
    ld [wC5E2], a
    ret

Func_000_137D::
    ld a, [wC5E0]
    or a, a
    jr nz, Jump_000_13E0
    ld a, [wC5E2]
    bit 7, a
    jr nz, Jump_000_13E0
    or a, a
    ret z
    ld a, [wC5E3]
    or a, a
    jr z, Jump_000_1397
    dec a
    ld [wC5E3], a
    ret

Jump_000_1397::
    ldh a, [rNR50]
    and a, $88
    cp a, $88
    jr z, Jump_000_13E0
    ld a, [wC5E5]
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
    ldh [rNR50], a
    ld [wC5E5], a
    or a, a
    jr z, Jump_000_13DE
    ld a, [wC5E4]
    or a, a
    jr z, Jump_000_13E0
    dec a
    ld [wC5E4], a
    ld a, [wC5E2]
    ld [wC5E3], a
    ret

Jump_000_13DE::
    di
    ei

Jump_000_13E0::
    xor a, a
    ld [wC5E2], a
    ret

Func_000_13E5::
    ld hl, wC523
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
    ld a, [wC58A]
    or a, a
    jp z, Jump_000_1575
    ld a, $08
    call Func_000_07D8
    ld a, [wC580]
    set 7, a
    res 6, a
    ld [wC580], a
    ld a, [wC57F]
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
    ld a, [wC581]
    cp a, $05
    jr nz, Jump_000_150D
    call Func_000_15C2
    call Func_000_07D1
    ldh a, [rSB]
    cp a, $F5
    call nz, Func_000_15C2
    jr Jump_000_1558

Jump_000_150D::
    call Func_000_1583
    cp a, $02
    jr z, Jump_000_1517
    call Func_000_07D1

Jump_000_1517::
    ldh a, [rSB]
    cp a, $70
    jr z, Jump_000_1524
    cp a, $71
    jr z, Jump_000_1524
    call Func_000_1583

Jump_000_1524::
    ld b, a
    ld a, [wC581]
    cp a, $05
    jr z, Jump_000_1558
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_000_1545
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_000_1558
    ld a, b
    bit 0, a
    jr z, Jump_000_1558
    ld a, [wC57F]
    set 1, a
    jr Jump_000_1555

Jump_000_1545::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_000_1558
    ld a, b
    bit 0, a
    jr nz, Jump_000_1558
    ld a, [wC57F]
    res 1, a

Jump_000_1555::
    ld [wC57F], a

Jump_000_1558::
    di
    ld a, [wC580]
    res 7, a
    ld [wC580], a
    ld a, [wC580]
    res 0, a
    res 1, a
    ld [wC580], a
    ld a, [wC57F]
    bit 1, a
    ld a, $F8
    call nz, Func_000_08BA

Jump_000_1575::
    xor a, a
    ld [wC582], a
    ld hl, wC55E
    ld b, $0E

Jump_000_157E::
    ld [hl+], a
    dec b
    jr nz, Jump_000_157E
    ret

Func_000_1583::
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_000_1594
    ld a, [wIsCGB]
    or a, $70
    call Func_000_08AD
    jr Jump_000_159C

Jump_000_1594::
    ld a, [wIsCGB]
    or a, $70
    call Func_000_08BA

Jump_000_159C::
    ld a, [wC588]
    add a, $01
    ld [wC588], a
    ld a, [wC589]
    adc a, $00
    ld [wC589], a
    ld a, [wC589]
    cp a, $FF
    jr nc, Jump_000_15BC
    ld a, [wC580]
    bit 6, a
    jr z, Jump_000_159C
    xor a, a
    ret

Jump_000_15BC::
    ld a, $02
    ld [wC58E], a
    ret

Func_000_15C2::
    ld a, [wC57F]
    bit 1, a
    ld a, $F5
    call nz, Func_000_08BA
    ld a, [wC57F]
    bit 1, a
    ld a, $F5
    call z, Func_000_08AD

Jump_000_15D6::
    ld a, [wC580]
    bit 6, a
    jr z, Jump_000_15D6
    ret

Func_000_15DE::
    push bc
    ld b, a
    ld a, [BANK_NUMBER_BYTE]
    ld c, a
    ld a, b
    ld [rROMB0], a
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
    ld [rROMB0], a
    ret

Func_000_160B::
    push bc
    ld b, a
    ld a, [BANK_NUMBER_BYTE]
    ld c, a
    ld a, b
    ld [rROMB0], a
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
    ld [rROMB0], a
    ret

Func_000_1649:: ; heuristic: follows a terminator; C0
    ld hl, vBGMap0
    ld de, wC198
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
    ld [wC8C0], a
    ld [wC8C1], a
    ld [wC8C2], a

Jump_000_16FF::
    ld a, [wC8C0]
    inc a
    ld [wC8C0], a
    ld bc, hFF9C
    add hl, bc
    ld a, h
    rlc a
    jr nc, Jump_000_16FF
    ld bc, $0064
    add hl, bc
    ld a, [wC8C0]
    dec a
    ld [wC8C0], a

Jump_000_171A::
    ld a, [wC8C1]
    inc a
    ld [wC8C1], a
    ld bc, hFFF6
    add hl, bc
    ld a, h
    rlc a
    jr nc, Jump_000_171A
    ld bc, $000A
    add hl, bc
    ld a, [wC8C1]
    dec a
    ld [wC8C1], a
    ld a, l
    ld [wC8C2], a
    ret

Func_000_173A::
    xor a, a
    ldh [hFFC9], a
    ldh [hFFC8], a
    ldh [hFFC7], a
    ldh [hFFC6], a
    ld hl, wC8C0
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
    ld hl, wC8C0
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
    ldh [hFFC9], a
    ld hl, wC8C0
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
    ld hl, wC8C0
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
    ldh [hFFC8], a
    ld hl, wC8C0
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
    ld hl, wC8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    ld a, d
    ld [hl+], a
    inc e
    jr Jump_000_17A0

Jump_000_17BA::
    ldh a, [hFFC8]
    add a, e
    ldh [hFFC8], a
    ld hl, wC8C0
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
    ld hl, wC8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr Jump_000_17C8

Jump_000_17DC::
    ld a, e
    swap a
    ldh [hFFC7], a
    ld hl, wC8C0
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
    ld hl, wC8C0
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl+], a
    inc e
    jr Jump_000_17EA

Jump_000_17FE::
    ldh a, [hFFC7]
    add a, e
    ldh [hFFC7], a
    ld a, [wC8C0]
    ld e, $00

Jump_000_1808::
    sub a, $0A
    jr c, Jump_000_1812
    ld [wC8C0], a
    inc e
    jr Jump_000_1808

Jump_000_1812::
    swap e
    ld a, [wC8C0]
    add a, e
    ldh [hFFC6], a
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    ld a, [de]
    ld c, a
    pop af
    ld [rROMB0], a
    ret

Func_000_1881::
    ld a, b
    ld [wC52D], a

Jump_000_1885::
    push bc
    ld de, $2940
    ld c, $10

Jump_000_188B::
    di

Jump_000_188C::
    ldh a, [rSTAT]
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
    ld a, [wC52D]
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
    ldh a, [rSTAT]
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, b
    ld [rROMB0], a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, [de]
    ld b, a
    pop af
    ld [rROMB0], a
    ret
    db $FA, $00, $40, $F5, $3E, $61, $EA, $00, $21, $F0, $C6, $6F, $26, $00, $29, $7D
    db $C6, $05, $6F, $7C, $CE, $67, $67, $3E, $02, $18, $19

Func_000_1906::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $61
    ld [rROMB0], a
    ldh a, [hFFC6]
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
    ldh [hFFC6], a
    ld a, h
    adc a, $00
    ld h, a
    ldh [hFFC7], a
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [hl]
    ld [rROMB0], a
    ld a, [wC190]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ldh a, [hFF92]
    call Func_000_1682
    ldh a, [hFF8F]
    ld c, a
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_000_1951
    inc h

Jump_000_1951::
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, wC198
    call Func_000_0CF5
    pop af
    ld [rROMB0], a
    ld a, [wIsCGB]
    or a, a
    jr nz, Jump_000_1978
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr Jump_000_19A4

Jump_000_1978::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    call Func_000_0CF5
    ld a, $00
    ldh [rSVBK], a

Jump_000_19A4::
    pop af
    ld [rROMB0], a
    ret

Func_000_19A9::
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_000_19B7
    ld hl, Func_061_4472
    ld b, $61
    rst $10
    ret

Jump_000_19B7::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
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
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [hl]
    ld [rROMB0], a
    ld a, [wC190]
    ld c, a
    add a, a
    add a, c
    ld c, a
    ldh a, [hFF92]
    call Func_000_1682
    ldh a, [hFF8F]
    ld c, a
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_000_1A0E
    inc h

Jump_000_1A0E::
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, wC198
    call Func_000_0CF5
    pop af
    ld [rROMB0], a
    ld a, [wIsCGB]
    or a, a
    jr nz, Jump_000_1A36
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    jr Jump_000_1A62

Jump_000_1A36::
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld [rROMB0], a
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    call Func_000_0CF5
    ld a, $00
    ldh [rSVBK], a

Jump_000_1A62::
    pop af
    ld [rROMB0], a
    ld hl, Func_084_43B8
    ld b, $84
    rst $10
    call Func_000_1B6F
    call Func_000_1A73
    ret

Func_000_1A73::
    ld a, [wCC44]
    bit 7, a
    jp nz, Jump_000_1AB3
    ldh a, [hFF90]
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
    ld a, [wC88E]
    or a, a
    jr z, Jump_000_1AA9
    ld a, [wC891]
    dec a
    cp a, b
    jr nz, Jump_000_1AA9
    ld de, wC88F
    ld a, b
    ldh [hFFC6], a
    call Func_000_1AD6
    ret

Jump_000_1AA9::
    ld e, l
    ld d, h
    inc de
    ld a, b
    ldh [hFFC6], a
    call Func_000_1AD6
    ret

Jump_000_1AB3::
    ret
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

Func_000_1AD6::
    ldh a, [hFF8F]
    swap a
    ld c, a
    ldh a, [hFF92]
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
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_000_1B6D
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    ld c, $03
    ldh a, [hFFC6]
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
    ldh [rSVBK], a

Jump_000_1B6D::
    pop hl
    ret

Func_000_1B6F::
    ld de, $012B
    call Func_000_181B
    ret nc
    ldh a, [hFF8F]
    or a, a
    ret nz
    ldh a, [hFF90]
    cp a, $0D
    jr nz, Jump_000_1B95
    ld hl, wC2E2
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
    ld hl, wC1CA
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $61
    ld [rROMB0], a
    ldh a, [hFFC6]
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
    ld hl, vTiles2
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
    ld [wC190], a
    ld a, [hl+]
    ld [wC191], a
    ld a, [hl+]
    ld [wC192], a
    ld a, [hl+]
    ld [wC193], a
    ld a, [hl+]
    ld [wC90D], a
    xor a, a
    ld [wC901], a
    ld [wC194], a
    ld [wC195], a
    ld [wC196], a
    pop af
    ld [rROMB0], a
    ret

Func_000_1C0C::
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_000_1C1A
    ld hl, Func_061_420D
    ld b, $61
    rst $10
    ret

Jump_000_1C1A::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
    call Func_000_1D7F
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles2
    ldh a, [hFF90]
    cp a, $14
    jr nz, Jump_000_1C51
    ld hl, vTiles1
    call Func_000_0CF5
    ld de, $7861
    ld b, $48
    ld hl, vTiles2
    call Func_000_0CF5
    pop hl
    xor a, a
    ld [wC46B], a
    ld [wC46C], a
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
    ld [wC190], a
    ld a, [hl+]
    ld [wC191], a
    ld a, [hl+]
    ld [wC192], a
    ld a, [hl+]
    ld [wC193], a
    ld a, [hl+]
    ld [wC90D], a
    ld a, [hl+]
    or a, $80
    ld [wC901], a
    ld a, [hl+]
    ld [wC194], a
    ld a, [hl+]
    ld [wC195], a
    or a, a
    jr z, Jump_000_1C93
    and a, $0F
    jr z, Jump_000_1C8F
    ld a, [hl+]
    ld [wC196], a
    jr Jump_000_1C93

Jump_000_1C8F::
    ld a, [hl+]
    ld [wC197], a

Jump_000_1C93::
    call Func_000_1D47
    call Func_000_1CB7
    call Func_000_1CA1
    pop af
    ld [rROMB0], a
    ret

Func_000_1CA1::
    ldh a, [hFF90]
    cp a, $19
    ret nz
    ld a, [wCC37]
    ret nz
    ld de, $00D1
    call Func_000_181B
    ret nc
    ld a, $0B
    ld [wC90D], a
    ret

Func_000_1CB7::
    ld a, [wCC37]
    bit 5, a
    ret nz
    bit 1, a
    ret z
    ldh a, [hFF90]
    cp a, $01
    jr z, Jump_000_1CCB
    cp a, $02
    jr z, Jump_000_1CE2
    ret

Jump_000_1CCB::
    ld de, vTiles2 + $500
    ld hl, vTiles2 + $510
    ld b, $10
    call Func_000_1CF9
    ld de, $1D07
    ld hl, vTiles2 + $120
    ld b, $40
    call Func_000_1CF9
    ret

Jump_000_1CE2::
    ld de, vTiles2 + $400
    ld hl, vTiles2 + $410
    ld b, $10
    call Func_000_1CF9
    ld de, $1D07
    ld hl, vTiles2 + $2A0
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
    ldh a, [hFF90]
    cp a, $30
    jr z, Jump_000_1D51
    cp a, $B8
    jr nz, Jump_000_1D5C

Jump_000_1D51::
    ld a, $11
    ld [wC195], a
    ld a, $2C
    ld [wC197], a
    ret

Jump_000_1D5C::
    cp a, $63
    jr c, Jump_000_1D6F
    cp a, $67
    jr nc, Jump_000_1D6F
    ld a, $22
    ld [wC195], a
    ld a, $30
    ld [wC197], a
    ret

Jump_000_1D6F::
    cp a, $70
    jr nz, Jump_000_1D7E
    ld a, $12
    ld [wC195], a
    ld a, $2C
    ld [wC197], a
    ret

Jump_000_1D7E::
    ret

Func_000_1D7F::
    ldh a, [hFF90]
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $11
    ld [rROMB0], a
    ldh a, [hFFC6]
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
    ld a, [wC5FA]
    ld c, a
    ld a, [hl+]
    ldh [hFFC6], a
    cp a, c
    jr z, Jump_000_1DC0
    jr nc, Jump_000_1DC7

Jump_000_1DC0::
    pop af
    ld [rROMB0], a
    ld a, $01
    ret

Jump_000_1DC7::
    ld a, [wC5FC]
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
    ld [rROMB0], a
    ldh a, [hFFC6]
    ld c, a
    sla a
    add a, c
    ld c, a
    ld a, [wC5FC]
    call Func_000_1682
    ld a, [wC5FA]
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
    ld [rROMB0], a
    ld a, $01
    ret

Jump_000_1E23::
    pop af
    ld [rROMB0], a
    xor a, a
    ret

Func_000_1E29::
    push hl
    ld de, wC198
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
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld de, wD000
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
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

Func_000_1EA5::
    ld de, wC198
    ld a, [wC8CB]
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
    ldh a, [rSTAT]
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
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
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
    ldh a, [rSTAT]
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
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

Func_000_1F49::
    push bc
    call Func_000_24C5
    ld c, $A5
    call Func_000_1682
    ld bc, sA000
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
    ld de, hFFC6

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
    ld de, hFFC6

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
    ldh [hFFC6], a
    pop hl
    ret

Func_000_1F89::
    push hl
    call Func_000_1FD1
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl]
    ldh [hFFC7], a
    pop hl
    ret

Func_000_1F95::
    push hl
    call Func_000_1FD1
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, [hl+]
    ldh [hFFC7], a
    ld a, [hl+]
    ldh [hFFC8], a
    pop hl
    ret

Func_000_1FA4::
    push hl
    push de
    call Func_000_1FD1
    ld de, wC8CF
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
    ld bc, sA000
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
    ld de, $4001
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    pop af
    ld [rROMB0], a
    pop hl
    call Func_000_0CF5
    pop de
    pop bc
    ld a, [wIsCGB]
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
    ld hl, wC49F
    add a, l
    ld l, a
    jr nc, Jump_000_2032
    inc h

Jump_000_2032::
    ld c, $10
    call Func_000_0B18
    ret

Func_000_2038::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
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
    ld [rROMB0], a
    pop hl
    ld a, $02
    ldh [rSVBK], a
    ld bc, $0606

Jump_000_2066::
    push hl
    push bc

Jump_000_2068::
    di
    ld a, [de]
    push bc
    ld c, a
    ldh a, [hFFC6]
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
    ldh [rSVBK], a
    pop af
    ld [rROMB0], a
    ret

Func_000_2090::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $38
    ld [rROMB0], a
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
    ld [rROMB0], a
    ld a, $01
    ldh [rVBK], a
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
    ldh a, [hFFC6]
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
    ld [rROMB0], a
    ret
    ds $24, $00

Func_000_210D::
    push hl
    ld hl, wC8C1
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
    ld hl, wC8C0
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
    ld hl, hFFC9
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    ld hl, wC8CF
    ld c, $0B

Jump_000_21AF::
    push bc
    ld a, [hl+]
    cp a, $F0
    jr nz, Jump_000_21BB
    pop bc
    pop af
    ld [rROMB0], a
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
    ldh a, [rSTAT]
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
    ldh a, [rSTAT]
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
    ldh a, [rSTAT]
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
    ld [rROMB0], a
    ret

Func_000_222B::
    ld a, $90
    ld [wC8CF], a
    ld [wC8D0], a
    ld [wC8D1], a
    ld [wC8D2], a
    ld [wC8D3], a
    ld a, $F0
    ld [wC8D4], a
    ld de, vTiles1 + $500
    call Func_000_21A1
    ld de, vTiles1 + $550
    call Func_000_21A1
    ld de, vTiles1 + $5A0
    call Func_000_21A1
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    ret z
    ld b, a
    ld hl, wC6FE
    ld de, vTiles1 + $500

Jump_000_2264::
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
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
    ld [rRAMG], a
    ret

Func_000_228A::
    ld a, [wC6FD]
    or a, a
    ret z
    ld b, a
    ld hl, wC701
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld hl, vTiles0 + $100
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld de, wC6FE

Jump_000_22A5::
    push bc
    push de
    ld a, $0A
    ld [rRAMG], a
    push de
    ld a, [de]
    ld c, $55
    call Func_000_1F80
    pop de
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_000_2304
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFCA]
    ld c, a
    ldh a, [hFFCB]
    ld b, a
    ld a, $FF
    ld [bc], a
    inc bc
    ld [bc], a
    ld de, $545E
    ld b, $7E
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    call Func_000_0CF5
    ld a, [wIsCGB]
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
    ld hl, wC4DF
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
    ld [rRAMG], a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld l, e
    ld h, d
    ldh a, [hFFCA]
    ld c, a
    ldh a, [hFFCB]
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $04
    ld [rROMB0], a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    pop af
    ld [rROMB0], a
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    call Func_000_0CF5
    ld a, [wIsCGB]
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
    ld hl, wC4DF
    add a, l
    ld l, a
    jr nc, Jump_000_235C
    inc h

Jump_000_235C::
    push hl
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
    pop hl
    ld c, $08
    call Func_000_0B18

Jump_000_2378::
    ldh a, [hFFC9]
    inc a
    ldh [hFFC9], a
    ldh a, [hFFCA]
    add a, $02
    ldh [hFFCA], a
    ldh a, [hFFCB]
    adc a, $00
    ldh [hFFCB], a
    pop de
    inc de
    pop bc
    dec b
    jp nz, Jump_000_22A5
    ret

Func_000_2391::
    ldh [hFFCC], a
    ld c, $6F
    call Func_000_1F80
    call Func_000_23BD
    ld a, $09
    call Func_000_1682
    ld b, l
    ldh a, [hFFCC]
    ld c, $72
    call Func_000_1F80
    call Func_000_23BD
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    ldh a, [hFFCC]
    ld c, $70
    call Func_000_1F80
    call Func_000_23BD
    ld a, c
    add a, b
    ret

Func_000_23BD::
    ldh a, [hFFC6]
    ld c, $00
    cp a, $C0
    ret nc
    inc c
    cp a, $40
    ret nc
    inc c
    ret

Func_000_23CA:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [hFFC7]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [hFFC8]
    or a, a
    jr nz, Jump_000_23E4
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_000_23E4
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ret

Jump_000_23E4::
    ld c, $00
    ldh a, [hFFC9]
    or a, a
    jr z, Jump_000_23EF
    ld [de], a
    inc de
    ld c, $01

Jump_000_23EF::
    ld b, $03
    ld hl, hFFC8

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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $08
    ld [rROMB0], a
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $08
    ld [rROMB0], a

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
    ld [rROMB0], a
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $09
    ld [rROMB0], a
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
    ld [rROMB0], a
    ret

Func_000_24C5::
    push bc
    ld b, a
    ld a, [wC58A]
    or a, a
    jr z, Jump_000_24D7
    ld a, [wC5DB]
    cp a, $04
    jr nz, Jump_000_24D7
    ld a, b
    pop bc
    ret

Jump_000_24D7::
    ld a, b
    pop bc
    ld hl, wC6FE
    and a, $7F
    add a, l
    ld l, a
    jr nc, Jump_000_24E3
    inc h

Jump_000_24E3::
    ld a, [hl]
    ret

Func_000_24E5::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld hl, wC49F
    ld c, $40
    call Func_000_0B18
    ld a, $7F
    ld [wC526], a
    ret

Func_000_24F8::
    push bc
    push de
    push hl
    ldh a, [hFFA1]
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
    ld a, [wC5DB]
    cp a, $01
    jr nz, Jump_000_253C
    ld a, [wC5DC]
    and a, $0F
    cp a, $06
    ret z

Jump_000_253C::
    ld hl, hFFA1
    ld a, [hl+]
    sub a, $09
    cpl
    ldh [hFFD2], a
    ld a, [hl]
    sbc a, $00
    cpl
    ldh [hFFD3], a
    ld hl, hFFA5
    ld a, [hl+]
    sub a, $11
    cpl
    ldh [hFFD4], a
    ld a, [hl]
    sbc a, $00
    cpl
    ldh [hFFD5], a
    ret

Jump_000_255B::
    push af
    push bc
    push de
    push hl
    ld hl, Func_01B_4001
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
    ldh a, [rSVBK]
    ld d, a
    xor a, a
    ldh [rSVBK], a
    push de
    ld a, [wC5E1]
    and a, $03
    rst $00
    dw Jump_000_2582
    dw Jump_000_2589
    dw Jump_000_258B
    dw Jump_000_25AA

Jump_000_2582::
    pop af
    ldh [rSVBK], a
    pop de
    pop hl
    pop af
    reti

Jump_000_2589::
    jr Jump_000_2582

Jump_000_258B::
    ldh a, [rLY]
    ld hl, wC0F0
    add a, l
    ld l, a
    jr nc, Jump_000_2595
    inc h

Jump_000_2595::
    ld a, [hl]
    ldh [rSCX], a
    ldh a, [rLYC]
    add a, $02
    cp a, $90
    jr c, Jump_000_25A6
    ldh a, [hFFA1]
    ldh [rSCX], a
    ld a, $00

Jump_000_25A6::
    ldh [rLYC], a
    jr Jump_000_2582

Jump_000_25AA::
    ldh a, [rLY]
    ld hl, wC0F0
    add a, l
    ld l, a
    jr nc, Jump_000_25B4
    inc h

Jump_000_25B4::
    ld a, [hl]
    ldh [rSCY], a
    ldh a, [rLYC]
    add a, $02
    cp a, $81
    jr c, Jump_000_25C5
    ldh a, [hFFA5]
    ldh [rSCY], a
    ld a, $00

Jump_000_25C5::
    ldh [rLYC], a
    jr Jump_000_2582

Func_000_25C9::
    push de
    call Func_000_290E
    ld a, [wC52D]
    ld [wC531], a
    ld [wC535], a
    ld a, [wC52E]
    ld [wC532], a
    ld [wC536], a
    pop de
    call Func_000_2E40
    ld a, e
    ld [wC533], a
    ld [wC537], a
    ld a, d
    ld [wC534], a
    ld [wC538], a
    ld a, $01
    ld [wC52B], a
    xor a, a
    ld [wC52C], a
    ld [wC54F], a
    ret

Func_000_25FE::
    call Func_000_2E40
    ld a, [wC53D]
    ld l, a
    ld a, [wC53E]
    ld h, a

Jump_000_2609::
    ld a, [de]
    ld [hl+], a
    inc de
    cp a, $F0
    jr nz, Jump_000_2609
    ret

Func_000_2611::
    ld hl, wC52B
    set 1, [hl]

Jump_000_2616::
    call Func_000_2620
    ld a, [wC52B]
    or a, a
    jr nz, Jump_000_2616
    ret

Func_000_2620::
    ld a, [wC52C]
    bit 7, a
    jr z, Func_000_2637

Jump_000_2627::
    ld hl, wC52B
    set 1, [hl]
    call Func_000_2637
    ld a, [wC52C]
    bit 7, a
    jr nz, Jump_000_2627
    ret

Func_000_2637::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wC52A]
    ld [rROMB0], a
    ld a, [wC52C]
    bit 2, a
    jp nz, Jump_000_2847
    ld a, [wC52B]
    or a, a
    jp z, Jump_000_2875
    bit 5, a
    jr z, Jump_000_266E
    ld c, $BD
    ld a, [wC5F0]
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
    ld a, [wC52B]
    bit 2, a
    jp z, Jump_000_2764
    ld a, [wC550]
    cp a, $E6
    jr z, Jump_000_2685
    ld a, [wC550]
    cp a, $FF
    jp nz, Jump_000_274A

Jump_000_2685::
    ld a, [wC563]
    ld b, a
    ld a, [wC567]
    or a, b
    bit 6, a
    jr z, Jump_000_26A2
    ld a, [wC552]
    and a, $01
    xor a, $01
    ld [wC552], a
    ld a, $69
    call Func_000_1278
    jr Jump_000_26B5

Jump_000_26A2::
    bit 7, a
    jr z, Jump_000_26B5
    ld a, [wC552]
    and a, $01
    xor a, $01
    ld [wC552], a
    ld a, $69
    call Func_000_1278

Jump_000_26B5::
    ld c, $BB
    ld b, $C3
    ld a, [wC552]
    or a, a
    jr z, Jump_000_26C3
    ld c, $C3
    ld b, $BB

Jump_000_26C3::
    ld a, [wC5F0]
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
    ld a, [wC562]
    ld b, a
    ld a, [wC566]
    or a, b
    bit 0, a
    jr z, Jump_000_2711
    ld a, [wC552]
    or a, a
    jr nz, Jump_000_2716
    ld a, [wC550]
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
    ld [wC552], a

Jump_000_271B::
    ld hl, wC52B
    res 2, [hl]
    res 1, [hl]
    push de
    ld hl, vBGMap0
    ldh a, [hFFA5]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hFFA1]
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
    ld a, [wC562]
    ld b, a
    ld a, [wC566]
    or a, b
    and a, $F7
    jp z, Jump_000_2875
    ld hl, wC52B
    res 2, [hl]
    res 1, [hl]
    call Func_000_2BFA
    jp Jump_000_2875

Jump_000_2764::
    bit 6, a
    jr z, Jump_000_278B
    ld a, [wC53B]
    dec a
    ld [wC53B], a
    or a, a
    jp z, Jump_000_2780
    ld a, [wC562]
    ld b, a
    ld a, [wC566]
    or a, b
    and a, $F7
    jp z, Jump_000_2875

Jump_000_2780::
    ld hl, wC52B
    res 6, [hl]
    call Func_000_2BFA
    jp Jump_000_2875

Jump_000_278B::
    bit 7, a
    jr z, Jump_000_27A2
    ld a, [wC53C]
    dec a
    ld [wC53C], a
    or a, a
    jp nz, Jump_000_2875
    ld hl, wC52B
    res 7, [hl]
    jp Jump_000_2875

Jump_000_27A2::
    ld a, [wC533]
    ld l, a
    ld a, [wC534]
    ld h, a
    ld a, [hl]
    cp a, $8D
    jr z, Jump_000_2816
    cp a, $8E
    jr z, Jump_000_2816
    cp a, $E0
    jr nc, Jump_000_282C
    ld a, [wC52B]
    bit 1, a
    jr nz, Jump_000_27E5
    ld a, [wC562]
    ld b, a
    ld a, [wC566]
    or a, b
    and a, $F7
    jr z, Jump_000_27CF
    ld hl, wC52C
    set 7, [hl]

Jump_000_27CF::
    ld a, [wC964]
    ld b, a
    ld a, [wC52B]
    bit 3, a
    jr z, Jump_000_27DE
    ld a, [wC539]
    ld b, a

Jump_000_27DE::
    ld a, [wC54F]
    cp a, b
    jp c, Jump_000_2875

Jump_000_27E5::
    xor a, a
    ld [wC54F], a
    ld hl, wC52C
    res 1, [hl]
    call Func_000_2E5D
    ld a, [hl]
    cp a, $E0
    jr nc, Jump_000_282C
    call Func_000_287E
    ld a, [wC52C]
    bit 0, a
    jr z, Jump_000_2875
    ld a, b
    cp a, $90
    jr z, Jump_000_2875
    cp a, $9A
    jr z, Jump_000_2875
    ld a, [wC556]
    call Func_000_1278
    ld hl, wC52C
    set 1, [hl]
    jr Jump_000_2875

Jump_000_2816::
    ld a, [wC533]
    add a, $01
    ld [wC533], a
    ld a, [wC534]
    adc a, $00
    ld [wC534], a
    ld a, [hl]
    call Func_000_28AB
    jr Jump_000_2875

Jump_000_282C::
    ld a, [wC533]
    add a, $01
    ld [wC533], a
    ld a, [wC534]
    adc a, $00
    ld [wC534], a
    ld a, [hl]
    call Func_000_2950
    ld hl, wC52C
    res 1, [hl]
    jr Jump_000_2875

Jump_000_2847::
    ld a, [wSoundChannelSlots]
    ld hl, wDC01
    and a, [hl]
    ld hl, wDC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    jr nz, Jump_000_2875
    ld hl, wC52C
    res 2, [hl]

Jump_000_2875::
    ld hl, wC54F
    inc [hl]
    pop af
    ld [rROMB0], a
    ret

Func_000_287E::
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    call Func_000_28F4
    ld c, $08

Jump_000_288D::
    di

Jump_000_288E::
    ldh a, [rSTAT]
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
    ld [wC531], a
    ld a, h
    ld [wC532], a
    pop af
    ld [rROMB0], a
    ret

Func_000_28AB::
    ld l, a
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
    call Func_000_28BD
    pop af
    ld [rROMB0], a
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
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_000_28D0
    ld a, [de]
    or a, [hl]
    ld [hl+], a
    jr Jump_000_28E6

Jump_000_28DB::
    ldh a, [rSTAT]
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
    ld [wC531], a
    ld a, h
    ld [wC532], a
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
    ld a, [wC531]
    ld l, a
    ld a, [wC532]
    ld h, a
    ret

Func_000_290E::
    ld hl, wC52F
    ld a, [hl+]
    or a, [hl]
    ret z
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    ld a, [wC530]
    ld c, a

Jump_000_2920::
    ld a, [wC52F]
    ld b, a

Jump_000_2924::
    push bc
    ld b, $10
    ld de, $2940

Jump_000_292A::
    di

Jump_000_292B::
    ldh a, [rSTAT]
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
    ld [wC550], a
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
    ld hl, wC52C
    res 7, [hl]
    call Func_000_2E5D
    ld a, [hl]
    call Func_000_1278
    ld hl, wC52C
    set 2, [hl]
    ret

Jump_000_29A8::
    ld hl, wC52C
    res 7, [hl]
    call Func_000_2E5D
    ld a, [hl]
    call Func_000_122D
    ld hl, wC52C
    set 2, [hl]
    ret

Jump_000_29BA::
    jp Func_000_2D33

Jump_000_29BD::
    call Func_000_2D33
    ld a, $01
    ld [wC552], a
    ld a, $FF
    ld [wC550], a
    ret

Jump_000_29CB::
    call Func_000_2E5D
    ld d, $00
    ld e, [hl]
    call Func_000_2E5D
    ld c, [hl]
    ld a, [wC530]
    call Func_000_1682
    add hl, de
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, [wC52D]
    ld e, a
    ld a, [wC52E]
    ld d, a
    add hl, de
    ld a, l
    ld [wC531], a
    ld a, h
    ld [wC532], a
    ld a, l
    ld [wC535], a
    ld a, h
    ld [wC536], a
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
    ld hl, Func_002_604B
    ld b, $02
    rst $10
    ret
    db $CD, $78, $12, $C9

Jump_000_2A25::
    ld hl, wC52C
    set 0, [hl]
    ld a, $6B
    ld [wC556], a
    ret

Jump_000_2A30::
    ld hl, wC52C
    set 0, [hl]
    ld a, $6A
    ld [wC556], a
    ret

Jump_000_2A3B::
    ld hl, wC52C
    res 7, [hl]
    ld a, [wC964]
    cp a, $07
    jr z, Jump_000_2A59
    ld hl, $2A66
    add a, l
    ld l, a
    jr nc, Jump_000_2A4F
    inc h

Jump_000_2A4F::
    ld a, [hl]
    ld [wC53C], a
    ld hl, wC52B
    set 7, [hl]
    ret

Jump_000_2A59::
    ld hl, wC52C
    res 7, [hl]
    ld hl, wC52B
    set 2, [hl]
    set 5, [hl]
    ret
    db $06, $0C, $14, $1A, $20, $28, $30

Jump_000_2A6D::
    ld hl, wC52C
    set 7, [hl]
    ret

Jump_000_2A73::
    ld a, [wC52D]
    ld e, a
    ld a, [wC52E]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    ld a, [wC554]
    ld l, a
    ld a, [wC555]
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
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    call Func_000_3095
    ld a, [wC530]
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
    ld a, [wC52D]
    ld e, a
    ld a, [wC52E]
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
    ld a, [wC535]
    ld l, a
    ld a, [wC536]
    ld h, a
    ld a, l
    ld [wC531], a
    ld a, h
    ld [wC532], a
    ld hl, wC52B
    res 1, [hl]
    ret

Jump_000_2B09::
    ld a, [wC530]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wC52D]
    ld e, a
    ld a, [wC52E]
    ld d, a
    add hl, de
    ld a, [wC535]
    ld e, a
    ld a, [wC536]
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
    ld [wC531], a
    ld a, h
    ld [wC532], a
    ld a, l
    ld [wC535], a
    ld a, h
    ld [wC536], a
    call Func_000_2E5D
    ret

Jump_000_2B45::
    ld a, [wC554]
    ld l, a
    ld a, [wC555]
    ld h, a
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    call Func_000_3095
    ld a, [wC52D]
    ld e, a
    ld a, [wC52E]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
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
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    call Func_000_3095
    ld a, [wC530]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wC52D]
    ld e, a
    ld a, [wC52E]
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
    ld hl, wC52B
    set 7, [hl]
    ld a, $04
    ld [wC53C], a
    ret

Jump_000_2BCD::
    ld a, [wC52B]
    bit 4, a
    jp z, Jump_000_2BF1
    ld a, [wC52B]
    res 4, a
    ld [wC52B], a
    call Func_000_2BFA
    ld a, [wC537]
    ld l, a
    ld a, [wC538]
    ld h, a
    ld a, l
    ld [wC533], a
    ld a, h
    ld [wC534], a
    ret

Jump_000_2BF1::
    xor a, a
    ld [wC52B], a
    xor a, a
    ld [wC52C], a
    ret

Func_000_2BFA::
    ld a, [wC52B]
    bit 5, a
    ret z
    res 5, a
    ld [wC52B], a
    ld hl, $0060
    call Func_000_305E
    ld b, $09
    call Func_000_3048
    ld a, $B4
    call Func_000_1211
    ld a, [wC5DB]
    cp a, $04
    ret z
    ld a, $69
    call Func_000_1278
    ret

Jump_000_2C21::
    ld a, [wC530]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wC535]
    ld e, a
    ld a, [wC536]
    ld d, a
    add hl, de
    ld a, l
    ld [wC531], a
    ld a, h
    ld [wC532], a
    ld a, l
    ld [wC535], a
    ld a, h
    ld [wC536], a
    ret

Jump_000_2C48::
    call Func_000_2BFA
    call Func_000_2C6A
    call Func_000_290E

Jump_000_2C51::
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    ld a, l
    ld [wC531], a
    ld a, h
    ld [wC532], a
    ld a, l
    ld [wC535], a
    ld a, h
    ld [wC536], a
    ret

Func_000_2C6A::
    ld hl, wC52C
    res 7, [hl]
    ld hl, wC52B
    res 1, [hl]
    ret

Jump_000_2C75::
    ld hl, wC52B
    set 1, [hl]
    ret

Jump_000_2C7B::
    ld hl, wC60C
    ld de, wC53F
    ld b, $0A

Jump_000_2C83::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_2C83
    ld a, $F0
    ld [de], a
    ld hl, wC52B
    set 4, [hl]
    ld a, [wC533]
    ld l, a
    ld a, [wC534]
    ld h, a
    ld a, l
    ld [wC537], a
    ld a, h
    ld [wC538], a
    ld hl, wC53F
    ld a, l
    ld [wC533], a
    ld a, h
    ld [wC534], a
    ret

Jump_000_2CAD::
    ld hl, wC52B
    set 2, [hl]
    ld hl, wC52C
    res 7, [hl]
    ret

Jump_000_2CB8::
    ld hl, wC52B
    set 3, [hl]
    call Func_000_2E5D
    ld a, [hl]
    ld [wC539], a
    ret

Jump_000_2CC5::
    ld hl, wC52B
    set 4, [hl]
    ld a, [wC533]
    ld l, a
    ld a, [wC534]
    ld h, a
    ld a, l
    ld [wC537], a
    ld a, h
    ld [wC538], a
    ld a, [wC537]
    add a, $01
    ld [wC537], a
    ld a, [wC538]
    adc a, $00
    ld [wC538], a
    ld de, wC130
    ld a, [hl]
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, l
    ld [wC533], a
    ld a, h
    ld [wC534], a
    ret

Jump_000_2CFD::
    ld hl, wC52B
    set 5, [hl]
    ret

Jump_000_2D03::
    ld hl, wC52B
    set 6, [hl]
    call Func_000_2E5D
    ld a, [hl]
    ld [wC53B], a
    ld hl, wC52C
    res 7, [hl]
    ret

Jump_000_2D15::
    ld hl, wC52B
    set 7, [hl]
    call Func_000_2E5D
    ld a, [hl]
    ld [wC53C], a
    ld hl, wC52C
    res 7, [hl]
    ret

Jump_000_2D27::
    ld hl, wC52C
    set 0, [hl]
    ret

Jump_000_2D2D::
    ld hl, wC52C
    res 0, [hl]
    ret

Func_000_2D33::
    ld hl, wC52C
    res 7, [hl]
    ld a, $6C
    call Func_000_1278
    call Func_000_2D4A
    ld hl, wC52B
    set 2, [hl]
    xor a, a
    ld [wC552], a
    ret

Func_000_2D4A::
    call Func_000_2DD6
    ld de, Data_01F_4180
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4330
    ld hl, vTiles1 + $6F0
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
    ld a, [wIsCGB]
    or a, a
    ret z
    ld de, $2E1D
    push bc
    ld a, $01
    ldh [rVBK], a
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
    ldh [rVBK], a
    pop bc
    pop hl
    ret

Func_000_2DD6::
    ld hl, vTiles1 + $6E0
    ld de, wC89E
    ld c, $10
    call Func_000_2DED
    ld hl, vTiles1 + $6F0
    ld de, wC8AE
    ld c, $10
    call Func_000_2DED
    ret

Func_000_2DED::
    ldh a, [rSTAT]
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
    ld a, [BANK_NUMBER_BYTE]
    ld [wC52A], a
    ld a, [wC528]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wC529]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ret

Func_000_2E5D::
    ld a, [wC533]
    ld l, a
    ld a, [wC534]
    ld h, a
    ld a, l
    add a, $01
    ld [wC533], a
    ld a, h
    adc a, $00
    ld [wC534], a
    ret

Func_000_2E72:: ; heuristic: follows a terminator; C0
    ld a, h
    ld [wC528], a
    ld a, l
    ld [wC529], a
    ld hl, Func_008_4001
    ld b, $08
    rst $10
    ret

Func_000_2E81::
    ld a, e
    ld [wC53D], a
    ld a, d
    ld [wC53E], a
    ld a, h
    ld [wC528], a
    ld a, l
    ld [wC529], a
    ld hl, Func_008_4016
    ld b, $08
    rst $10
    ret

Func_000_2E98::
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
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
    ldh [hFFCC], a
    ld e, $40
    ld d, $42
    call Func_000_2F36
    or a, a
    jp nz, Jump_000_2F03
    ld a, $01
    ldh [hFFCC], a
    ld e, $A0
    ld d, $86
    call Func_000_2F36
    or a, a
    jr nz, Jump_000_2F11
    ld a, $00
    ldh [hFFCC], a
    ld e, $10
    ld d, $27
    call Func_000_2F36
    or a, a
    jr nz, Jump_000_2F1F
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    jp Func_000_2F84

Jump_000_2F03::
    ld a, $0F
    ldh [hFFCC], a
    ld e, $40
    ld d, $42
    call Func_000_2F5A
    call Func_000_2FDC

Jump_000_2F11::
    ld a, $01
    ldh [hFFCC], a
    ld e, $A0
    ld d, $86
    call Func_000_2F5A
    call Func_000_2FDC

Jump_000_2F1F::
    ld a, $00
    ldh [hFFCC], a
    ld e, $10
    ld d, $27
    call Func_000_2F5A
    call Func_000_2FDC
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    ld b, a
    jp Jump_000_2FA7

Func_000_2F36::
    ldh a, [hFFC6]
    ld [wC0A0], a
    ldh a, [hFFC7]
    ld [wC0A1], a
    ldh a, [hFFC8]
    ld [wC0A2], a
    call Func_000_2F5A
    push af
    ld a, [wC0A0]
    ldh [hFFC6], a
    ld a, [wC0A1]
    ldh [hFFC7], a
    ld a, [wC0A2]
    ldh [hFFC8], a
    pop af
    ret

Func_000_2F5A::
    push hl
    ldh a, [hFFCC]
    ld l, a
    ld h, $FF

Jump_000_2F60::
    inc h
    ldh a, [hFFC6]
    sub a, e
    ldh [hFFC6], a
    ldh a, [hFFC7]
    sbc a, d
    ldh [hFFC7], a
    ldh a, [hFFC8]
    sbc a, l
    ldh [hFFC8], a
    jr nc, Jump_000_2F60
    ldh a, [hFFC6]
    add a, e
    ldh [hFFC6], a
    ldh a, [hFFC7]
    adc a, d
    ldh [hFFC7], a
    ldh a, [hFFC8]
    adc a, l
    ldh [hFFC8], a
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
    ld [wC554], a
    ld a, h
    ld [wC555], a
    ld a, [wC52D]
    ld e, a
    ld a, [wC52E]
    ld d, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    ld a, [wC554]
    ld l, a
    ld a, [wC555]
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
    ld a, [wC554]
    add a, l
    ld l, a
    ld a, [wC555]
    adc a, h
    and a, $03
    ld h, a
    ld a, [wC555]
    and a, $FC
    or a, h
    ld h, a
    ret

Func_000_3072::
    push hl
    ldh a, [hFFA5]
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hFFA1]
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, $1F
    ld [rROMB0], a
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
    ld [rROMB0], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $0030CC, $1C4

Func_000_3290::
    ld bc, $0000
    call Func_000_32DB
    ld a, $80
    ldh [rNR52], a
    xor a, a
    ldh [rNR51], a
    ld [wDD09], a
    ld a, $77
    ldh [rNR50], a
    ld hl, wSoundChannelSlots
    ld de, $0020
    ld b, $06
    ld a, $FF

Jump_000_32AE::
    ld [hl+], a
    ld [hl-], a
    add hl, de
    dec b
    jr nz, Jump_000_32AE
    ld hl, wSoundLabelSlots
    ld b, $48
    xor a, a

Jump_000_32BA::
    ld [hl+], a
    dec b
    jr nz, Jump_000_32BA
    xor a, a
    ld [wDD15], a
    ld [wDD19], a
    ret

Func_000_32C6:: ; heuristic: follows a terminator; C0
    xor a, a
    ld [wDD15], a
    ld a, [wDD16]
    ld [wDD09], a
    ret

Func_000_32D1:: ; heuristic: follows a terminator; C0
    ld a, $04
    ld [wDD15], a
    xor a, a
    ld [wDD09], a
    ret

Func_000_32DB::
    ld a, b
    ld [wDD12], a
    ld a, c
    ld [wDD13], a
    xor a, a
    ld [wDD14], a
    ret

Func_000_32E8::
    ld a, [wSoundChannelIndex]
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
    ld a, [wDD14]
    or a, b
    ld [wDD14], a
    ret

Func_000_32FE::
    ld a, [wDD14]
    ld hl, wDD12
    and a, [hl]
    cp a, [hl]
    jr nz, Jump_000_3332
    ld hl, wDC06
    ld a, [wDD13]
    and a, $0F
    ld b, a
    ld a, [wDD12]

Jump_000_3314::
    srl a
    ld [wDD14], a
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
    ld a, [wDD14]
    and a, a
    jr nz, Jump_000_3314
    xor a, a
    ld [wDD12], a

Jump_000_3332::
    xor a, a
    ld [wDD14], a
    ret

Func_000_3337:: ; heuristic: follows a terminator; C0
    call Func_000_3340
    call Func_000_3340
    call Func_000_3340

Func_000_3340::
    push bc
    push de
    push hl
    ld [wSoundId], a
    ld hl, $3E24
    jr Jump_000_335D

Func_000_334B::
    call Func_000_3354

Func_000_334E::
    call Func_000_3354

Func_000_3351::
    call Func_000_3354

; C2 static reading, and 495 emulated sound starts agree (E-0018): starts sound id A (kept in $DD10). Finds A's range in SoundBankTable, switches to that bank, takes the 4-byte record at (array + 4*(A - first id)), and copies it into the channel-state slot at $DC00 + record byte 0 (record byte 1 to slot +2, the track pointer to +3/+4, this bank to +5). Returns A + 1.
Func_000_3354::
    push bc
    push de
    push hl
    ld [wSoundId], a
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
    ld a, [BANK_NUMBER_BYTE]
    push af
    dec hl
    ld a, [hl-]
    ld [rROMB0], a
    ld d, [hl]
    dec hl
    ld e, [hl]
    dec hl
    ld a, [wSoundId]
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
    ld hl, wSoundChannelSlots
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
    ld a, [wDD09]
    and a, b
    ld [wDD09], a

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
    ld a, [BANK_NUMBER_BYTE]
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
    ld [rROMB0], a
    ld a, [wSoundId]
    inc a
    pop hl
    pop de
    pop bc
    ret

; C1 (E-0018): appears to be the sound engine's update routine. It switches to the bank in $FFDD, walks the channel-state slots at $DC00 and writes the sound registers (including $FF1A). Identified from those writes and from the banks it reads at runtime ($40-$43 via the tables above); not decoded further.
Func_000_33E8::
    ld a, [BANK_NUMBER_BYTE]
    push af
    ld a, [wDD15]
    ld [wSoundChannelIndex], a
    xor a, a
    ld [wDD08], a
    ld hl, wDD0E
    inc [hl]
    ld hl, wSoundChannelSlots

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
    ldh a, [hSoundBank]
    ld [rROMB0], a
    ldh a, [hFFDA]
    and a, $03
    ld [wSoundHwChannel], a
    ld b, a
    add a, a
    add a, a
    add a, b
    ld [wDD0D], a
    inc b
    ld a, $88

Jump_000_343C::
    rlca
    dec b
    jr nz, Jump_000_343C
    ld [wDD0B], a
    ld [wDD0C], a
    ldh a, [hTrackPosLo]
    ld b, a
    ldh a, [hTrackPosHi]
    or a, b
    and a, a
    jp z, Jump_000_3554
    call Func_000_39F8
    call Func_000_3A7A
    ldh a, [hFFE6]
    ld b, a
    ldh a, [hFFE7]
    inc a
    cp a, b
    jr c, Jump_000_3460
    ld a, b

Jump_000_3460::
    ldh [hFFE7], a
    ld hl, hFFDF
    ldh a, [hFFDE]
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
    ldh a, [hFFF0]
    and a, a
    jr z, Jump_000_347F
    dec a
    ldh [hFFF0], a

Jump_000_347F::
    ldh a, [hFFE1]
    and a, a
    jr nz, Jump_000_34BA
    ldh a, [hFFF3]
    and a, $F0
    jr z, Jump_000_349C
    ld hl, hFFF2
    dec [hl]
    jr nz, Jump_000_34A8
    ldh a, [hFFED]
    and a, $F0
    ld c, a
    ldh a, [hFFE0]
    and a, $0F
    or a, c
    ldh [hFFE0], a

Jump_000_349C::
    call Func_000_32E8

Jump_000_349F::
    ldh a, [hFFEF]
    ldh [hFFF0], a
    call Func_000_35CD
    jr Jump_000_34C7

Jump_000_34A8::
    ldh a, [hFFF3]
    and a, $0F
    dec a
    cp a, [hl]
    jr nz, Jump_000_34C7
    call Func_000_3DC8
    ldh a, [hFFE0]
    call Func_000_3A2F
    jr Jump_000_34C7

Jump_000_34BA::
    dec a
    ldh [hFFE1], a
    jr nz, Jump_000_34C7
    ldh a, [hFFF3]
    and a, $F0
    jr nz, Jump_000_34C7
    jr Jump_000_349C

Jump_000_34C7::
    ld a, [wDD19]
    and a, a
    jr z, Jump_000_3502
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, Jump_000_3502
    ld a, [wSoundChannelIndex]
    cp a, $02
    jr c, Jump_000_3502
    ld a, [wDD0B]
    ld b, a
    ld a, [wDD08]
    and a, b
    jr nz, Jump_000_3502
    ld a, [wDD17]
    ld b, a
    ldh a, [hFFE2]
    cp a, b
    jr z, Jump_000_3502
    ld e, a
    ld [wDD17], a
    swap e
    xor a, a
    ld [wDD19], a
    ldh [rNR30], a
    ld d, a
    call Func_000_3D8D
    ld a, $80
    ldh [rNR30], a

Jump_000_3502::
    ld a, [wDD0B]
    ld b, a
    ld a, [wDD08]
    or a, b
    ld [wDD08], a
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
    ld a, [wSoundChannelIndex]
    inc a
    ld [wSoundChannelIndex], a
    cp a, $06
    jp c, Jump_000_33FD
    ld a, [wDD08]
    ld b, a
    ld a, [wDD09]
    and a, b
    ld [wDD09], a
    ldh [rNR51], a
    pop af
    ld [rROMB0], a
    call Func_000_32FE
    ret

; C2 static reading (E-0019): channel start. Reads the 4-byte track header (byte 0 low nibble -> $FFDF, byte 1 -> duty bits of $FFDE (wave: $FFE6), byte 2 swapped -> $FFE0, byte 3 -> $FFE2) and begins playback at event 2 ($FFD8 = 2).
Jump_000_3554::
    ldh a, [hTrackBaseLo]
    ld l, a
    ldh a, [hTrackBaseHi]
    ld h, a
    ld a, [hl+]
    and a, $0F
    ld d, a
    ldh [hFFDF], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3593
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    or a, d

Jump_000_356D::
    ldh [hFFDE], a
    ld a, [hl+]
    swap a
    ldh [hFFE0], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3599
    ld a, [hl+]
    ldh [hFFE2], a

Jump_000_357E::
    xor a, a
    ldh [hFFE3], a
    ldh [hFFE4], a
    ldh [hFFE5], a
    ldh [hFFE8], a
    ldh [hTrackPosHi], a
    dec a
    ldh [hFFEE], a
    ld a, $02
    ldh [hTrackPosLo], a
    jp Jump_000_349F

Jump_000_3593::
    ld a, [hl+]
    ldh [hFFE6], a
    ld a, d
    jr Jump_000_356D

Jump_000_3599::
    xor a, a
    ldh [rNR30], a
    ld d, a
    ldh a, [hFFE2]
    ld e, a
    cp a, $FF
    jr nz, Jump_000_35A8
    ld e, [hl]
    ld a, e
    ldh [hFFE2], a

Jump_000_35A8::
    ld [wDD17], a
    swap e
    ld hl, $30CC
    push de
    ldh a, [hFFF1]
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

; C2 static reading and 5,154 emulated fetches agree (E-0019): fetches the next track event of the current channel. The position in $FFD8/$FFD9 counts 2-byte events from the track start ($FFDB/$FFDC), the event address is base + 2*position, and the first byte selects the command (see tools/sound_tracks.py).
Func_000_35CD::
    ldh a, [hTrackPosLo]
    ld l, a
    ldh a, [hTrackPosHi]
    ld h, a
    add hl, hl
    ldh a, [hTrackBaseLo]
    ld e, a
    ldh a, [hTrackBaseHi]
    ld d, a
    add hl, de

Jump_000_35DB::
    ldh a, [hTrackPosLo]
    add a, $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc a, $00
    ldh [hTrackPosHi], a
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
    ldh a, [hTrackPosLo]
    ld [hl+], a
    ldh a, [hTrackPosHi]
    ld [hl], a
    pop hl

Jump_000_3610::
    inc hl
    jr Jump_000_35DB

Jump_000_3613::
    ldh [hTrackPosLo], a
    ldh [hTrackPosHi], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, Jump_000_362A
    ld a, [wSoundChannelIndex]
    cp a, $02
    jr nc, Jump_000_362A
    ld a, $FF
    ld [wDD19], a

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
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_364E
    ld a, b
    ldh [hFFE8], a
    ld a, [hl]
    ldh [hFFE9], a
    ldh [hFFEA], a

Jump_000_364E::
    inc hl
    jr Jump_000_35DB

Jump_000_3651::
    and a, $0F
    ld b, a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3669
    ldh a, [hFFE0]
    and a, $0F
    jr nz, Jump_000_3669
    ld a, [hl]
    ldh [hFFE6], a
    ld a, b
    swap a
    ldh [hFFE5], a

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
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a

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
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a
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
    ldh [hFFE0], a
    ld a, [wDD0B]
    ld b, a
    ld a, [wDD08]
    and a, b
    jp nz, Jump_000_35DB
    call Func_000_3A2F
    jp Jump_000_35DB

Jump_000_36C3::
    cp a, $A1
    jr nz, Jump_000_3712
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_36D4
    ld a, [hl+]
    ldh [hFFE2], a
    jp Jump_000_35DB

Jump_000_36D4::
    ld a, [hl+]
    ld e, a
    ldh [hFFE2], a
    ld a, [wDD0B]
    ld b, a
    ld a, [wDD08]
    and a, b
    jr z, Jump_000_36E5
    jp Jump_000_35DB

Jump_000_36E5::
    xor a, a
    ldh [rNR30], a
    ld d, a
    push hl
    ld a, e
    ld [wDD17], a
    swap e
    ld hl, $30CC
    push de
    ldh a, [hFFF1]
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
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_372D
    ld a, [hl+]
    rrca
    rrca
    and a, $C0
    ld d, a
    ldh a, [hFFDE]
    and a, $3F
    or a, d
    ldh [hFFDE], a
    jp Jump_000_35DB

Jump_000_372D::
    ld a, [hl+]
    ldh [hFFE6], a
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
    ldh [hFFEF], a
    ldh [hFFF0], a
    ld a, b
    add a, $10
    and a, $F0
    ld e, a
    ldh a, [hFFDA]
    and a, $0F
    or a, e

Jump_000_3751::
    ldh [hFFDA], a
    jp Jump_000_35DB

Jump_000_3756::
    ldh a, [hFFDA]
    and a, $0F
    jr Jump_000_3751

Jump_000_375C::
    cp a, $A5
    jr nz, Jump_000_376E
    ld a, [hl+]
    cp a, $01
    jr nz, Jump_000_3769
    ldh a, [hFFEE]
    swap a

Jump_000_3769::
    ldh [hFFEE], a
    jp Jump_000_35DB

Jump_000_376E::
    cp a, $A6
    jr nz, Jump_000_3778
    ld a, [hl+]
    ldh [rNR50], a
    jp Jump_000_35DB

Jump_000_3778::
    cp a, $A7
    jr nz, Jump_000_3782
    ld a, [hl]
    ldh [hFFE1], a
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
    ldh [hFFF1], a
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
    ldh a, [hFFE4]
    jr Jump_000_37B9

Jump_000_37B6::
    ld a, [wDD18]

Jump_000_37B9::
    sla a
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ldh [hTrackPosLo], a
    ld a, [hl]
    ldh [hTrackPosHi], a
    jp Func_000_35CD

Jump_000_37CA::
    cp a, $80
    jr nc, Jump_000_37D3
    ldh [hFFE4], a
    jp Jump_000_35DB

Jump_000_37D3::
    sub a, $80
    ld [wDD18], a
    jp Jump_000_35DB

Jump_000_37DB::
    ldh a, [hFFE4]
    inc a
    ldh [hFFE4], a
    jp Jump_000_35DB

Jump_000_37E3::
    ldh a, [hFFE4]
    dec a
    ldh [hFFE4], a
    jp Jump_000_35DB

Jump_000_37EB::
    ld a, [wDD18]
    inc a
    ld [wDD18], a
    jp Jump_000_35DB

Jump_000_37F5::
    ld a, [wDD18]
    dec a
    ld [wDD18], a
    jp Jump_000_35DB

Jump_000_37FF::
    cp a, $AA
    jr nz, Jump_000_3829
    ld a, [hl+]
    ld c, a
    and a, $F0
    jr z, Jump_000_381F
    swap a
    ldh [hFFF2], a
    or a, $F0
    ldh [hFFF3], a
    ld a, c
    and a, $0F
    ld c, a
    ldh a, [hFFED]
    and a, $F0
    or a, c
    ldh [hFFED], a
    jp Jump_000_35DB

Jump_000_381F::
    xor a, a
    ldh [hFFF2], a
    ldh [hFFED], a
    ldh [hFFF3], a
    jp Jump_000_35DB

Jump_000_3829::
    cp a, $AC
    jr nz, Jump_000_3867
    ldh a, [hFFF4]
    sub a, $01
    jr z, Jump_000_3855
    jr nc, Jump_000_3836
    ld a, [hl]

Jump_000_3836::
    ldh [hFFF4], a
    ldh a, [hTrackPosLo]
    sub a, $01
    ldh [hFFF5], a
    ldh a, [hTrackPosHi]
    sbc a, $00
    ldh [hFFF6], a
    inc hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    srl h
    rr l
    ld a, l
    ldh [hTrackPosLo], a
    ld a, h
    ldh [hTrackPosHi], a
    jp Func_000_35CD

Jump_000_3855::
    xor a, a
    ldh [hFFF4], a
    ldh a, [hTrackPosLo]
    add a, $01
    ldh [hTrackPosLo], a
    ldh a, [hTrackPosHi]
    adc a, $00
    ldh [hTrackPosHi], a
    jp Func_000_35CD

Jump_000_3867::
    cp a, $AD
    jr nz, Jump_000_3876
    ldh a, [hFFF5]
    ldh [hTrackPosLo], a
    ldh a, [hFFF6]
    ldh [hTrackPosHi], a
    jp Func_000_35CD

Jump_000_3876::
    cp a, $AE
    jr nz, Jump_000_3888
    ld a, [hl+]
    and a, $10
    ld b, a
    ldh a, [hFFDE]
    and a, $EF
    or a, b
    ldh [hFFDE], a
    jp Jump_000_35DB

Jump_000_3888::
    cp a, $AF
    jr nz, Jump_000_389C
    ld a, [hl+]
    and a, $0F
    ldh [hFFDF], a
    ld b, a
    ldh a, [hFFDE]
    and a, $F0
    or a, b
    ldh [hFFDE], a
    jp Jump_000_35DB

Jump_000_389C::
    inc hl
    jp Jump_000_35DB
    db $00, $01, $11, $12, $14, $23, $07, $15, $17, $32, $33, $60, $61, $45, $53, $62

Jump_000_38B0::
    xor a, a
    ldh [hFFEB], a
    ld a, $80
    ldh [hFFEC], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_38C2
    call Func_000_3B39
    ret

Jump_000_38C2::
    call Func_000_3B51
    xor a, a
    ldh [rNR30], a
    ret

Jump_000_38C9::
    ld b, a
    ldh a, [hFFF3]
    and a, $F0
    jr z, Jump_000_38DF
    push de
    ldh a, [hFFF3]
    and a, $0F
    ldh [hFFF2], a
    ld c, a
    ld a, [hl]
    sub a, c
    ldh [hFFE1], a
    pop de
    jr Jump_000_38E2

Jump_000_38DF::
    ld a, [hl]
    ldh [hFFE1], a

Jump_000_38E2::
    ld a, [wSoundHwChannel]
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
    ldh a, [hFFDE]
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

; C2 (E-0019: formula matched 1,928 of 1,928 emulated notes): pitch for a note event. The semitone (low nibble of the first byte, 0-11) indexes the period table at $3B5C ($3B74 when $FFDE bit 4 is set), the value is shifted right by the octave (high nibble) and subtracted from $0800 to give the frequency register value in HL. Noise-channel notes use $38A0.
Jump_000_3938::
    xor a, a
    ldh [hFFE7], a
    call Func_000_3B51
    ld a, [wSoundHwChannel]
    cp a, $02
    jr nz, Jump_000_394C
    call Func_000_3D7C
    ld a, $80
    ldh [rNR30], a

Jump_000_394C::
    push hl
    call Func_000_3A21
    pop hl
    ld a, [wSoundHwChannel]
    and a, a
    ldh a, [hFFE2]
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
    ldh [hFFEB], a
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_39AB
    cp a, $02
    jr nc, Jump_000_3989
    ldh a, [hFFDE]
    and a, $C0
    or a, $3F
    ld c, $11
    call Func_000_3A4E

Jump_000_3989::
    ld a, h
    and a, $07
    or a, $80

Jump_000_398E::
    ldh [hFFEC], a
    ld c, $14
    call Func_000_3A4E
    call Func_000_3A5D

Jump_000_3998::
    ld a, [wDD0C]
    ld b, a
    cpl
    ld c, a
    ldh a, [hFFEE]
    and a, b
    ld b, a
    ld a, [wDD09]
    and a, c
    or a, b
    ld [wDD09], a
    ret

Jump_000_39AB::
    xor a, a
    ldh [rNR31], a
    ldh a, [rNR52]
    and a, $04
    jr z, Jump_000_3989
    ld a, h
    and a, $07
    jr Jump_000_398E

Func_000_39B9::
    ld a, [wSoundHwChannel]
    cp a, $02
    ret z
    ldh a, [hFFE8]
    and a, a
    ret z
    ld hl, hFFEA
    dec [hl]
    ret nz
    ldh a, [hFFE0]
    swap a
    cp a, $10
    ret nc
    and a, $0F
    ld b, a
    ldh a, [hFFE9]
    ldh [hFFEA], a
    ld hl, hFFE8
    ld a, [hl]
    bit 7, a
    jr nz, Jump_000_39EC
    dec [hl]
    ld a, b
    cp a, $0F
    ret z
    ldh a, [hFFE0]
    add a, $10
    ldh [hFFE0], a
    jp Func_000_3A2F

Jump_000_39EC::
    inc [hl]
    ld a, b
    and a, a
    ret z
    ldh a, [hFFE0]
    sub a, $10
    ldh [hFFE0], a
    jr Func_000_3A2F

Func_000_39F8::
    call Func_000_3B51
    ld a, [wSoundHwChannel]
    cp a, $03
    ret z
    ldh a, [hFFF0]
    and a, a
    ret nz
    ldh a, [hFFDA]
    and a, $F0
    ret z
    sub a, $10
    ld b, a
    ld a, [wDD0E]
    and a, $0F
    or a, b
    ld e, a
    ld d, $00
    ld hl, $3C8C
    add hl, de
    ldh a, [hFFEB]
    add a, [hl]
    ld c, $13
    jr Func_000_3A4E

Func_000_3A21::
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3A57
    ldh a, [hFFE5]
    and a, a
    jr nz, Jump_000_3A94
    ldh a, [hFFE0]

Func_000_3A2F::
    ld b, a
    and a, $07
    jr nz, Jump_000_3A38
    ld a, b
    or a, $08
    ld b, a

Jump_000_3A38::
    ld a, [wDD0D]
    add a, $12
    ld c, a
    ldh a, [c]
    cp a, b
    ret z
    ld a, b
    ldh [c], a
    ldh a, [hFFEC]
    ld c, $14
    call Func_000_3A4E
    call Func_000_3A5D
    ret

Func_000_3A4E::
    ld b, a
    ld a, [wDD0D]
    add a, c
    ld c, a
    ld a, b
    ldh [c], a
    ret

Jump_000_3A57::
    ldh a, [hFFE0]
    ld c, $12
    jr Func_000_3A4E

Func_000_3A5D::
    ld c, $11
    ld a, [wDD0D]
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
    ld hl, hFFE0
    cp a, [hl]
    ret c
    and a, $60
    ldh [rNR32], a
    ret

Func_000_3A7A::
    call Func_000_3B51
    ldh a, [hFFEB]
    and a, a
    jr nz, Jump_000_3A89
    ldh a, [hFFEC]
    and a, $7F
    jp z, Func_000_3B39

Jump_000_3A89::
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3A94
    ldh a, [hFFE5]
    and a, a
    ret z

Jump_000_3A94::
    ldh a, [hFFE6]
    and a, a
    ret z
    ld e, $00
    ld c, a
    ldh a, [hFFE7]
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
    ld a, [wSoundHwChannel]
    cp a, $02
    jr z, Jump_000_3A69
    ldh a, [hFFE5]
    or a, e
    ld e, a
    ld d, $00
    push de
    ldh a, [hFFF1]
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
    ldh a, [hFFE0]
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
    ld a, [wDD0D]
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
    ld a, [wDD0B]
    cpl
    ld b, a
    ld a, [wDD09]
    and a, b
    ld [wDD09], a
    ret

Func_000_3B51::
    ld a, [wDD0B]
    ld b, a
    ld a, [wDD08]
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
    ld a, [wDD17]
    ld b, a
    ldh a, [hFFE2]
    cp a, b
    ret z
    ld [wDD17], a
    ld e, a
    swap e
    xor a, a
    ldh [rNR30], a

Func_000_3D8D::
    ld d, a
    ld hl, $30CC
    push de
    ldh a, [hFFF1]
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
    ld de, rWAVE
    ld b, $10

Jump_000_3DA7::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_000_3DA7
    ret

; C2 static reading (E-0019): address of a label slot: HL = $DCC0 + channel*12 + (B & $0F)*3. A slot holds a repeat counter and a saved position (2 bytes); used by the FD, B0 and B1-BF commands.
Func_000_3DAE::
    ld a, [wSoundChannelIndex]
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
    ld hl, wSoundLabelSlots
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ret

Func_000_3DC8::
    push de
    push bc
    ldh a, [hFFED]
    and a, $0F
    inc a
    ld d, a
    ld bc, $0000
    ldh a, [hFFE0]
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
    ldh a, [hFFE0]
    ld d, a
    and a, $F0
    ld e, a
    ldh a, [hFFED]
    and a, $0F
    or a, e
    ldh [hFFED], a
    ld a, d
    and a, $0F
    or a, c
    ldh [hFFE0], a
    pop bc
    pop de
    ret

; E-0018 (C2: static reading of Func_000_3354, and 495 emulated sound starts read exactly the banks this table names). Func_000_3354 takes the first entry whose first byte is greater than the sound id; the PREVIOUS entry gives the base id, record array and bank. A first byte of $FF ends the table.
; record: first sound id of this range; record array in that bank; ROM bank holding the records and tracks
SoundBankTable::
    db $00 ; entry 0
    dw SoundRecords_Bank40
    db $40
    db $1C ; entry 1
    dw SoundRecords_Bank41
    db $41
    db $31 ; entry 2
    dw SoundRecords_Bank42
    db $42
    db $A8 ; entry 3
    dw SoundRecords_Bank43
    db $43
    db $FF, $FF

Func_000_3E25::
    push hl
    push bc
    ld c, a
    call Func_000_3E54
    jr c, Jump_000_3E50
    ld a, c
    ld hl, wD80C
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
    ld hl, wDA63
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
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
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
    ld a, [wC58A]
    or a, a
    jr nz, Func_000_3EDE
    call Func_000_095B
    ret

Func_000_3EDE::
    push hl
    ld a, [wC5BA]
    ld l, a
    ld a, [wC5BB]
    ld h, a
    ld a, l
    ld [wC5E7], a
    ld a, h
    ld [wC5E8], a
    call Func_000_095B
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    ld a, l
    ld [wC5BA], a
    ld a, h
    ld [wC5BB], a
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
    ld bc, wD0D5
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
    ld a, [wDAAC]
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
