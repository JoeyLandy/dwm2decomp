SECTION "Bank 73", ROMX[$4000], BANK[$73]
    db $73

; 1 call site from 1 routine (e.g. Func_010_499B)
; reads: wC935
Func_073_4001::
    ld a, [wC935]
    and a, $0F
    rst $00
    dw Jump_073_4E03
    dw Jump_073_4D8D
    dw Jump_073_4D20
    dw Jump_073_4CA0
    dw Jump_073_4BC3
    dw Jump_073_4B68
    dw Jump_073_4647
    dw Jump_073_4A82
    dw Jump_073_45D0
    dw Jump_073_4840
    dw Jump_073_411F
    dw Jump_073_4098
    dw Jump_073_4027
    dw Jump_073_4027
    dw Jump_073_4027
    dw Jump_073_4027

Jump_073_4027::
    ld a, [wC923]
    rst $00
    dw Jump_073_403F
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4053
    dw Func_073_4E5D
    dw Func_073_4E9C
    dw Func_073_4E5D
    dw Jump_073_4111
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_403F::
    ld a, [wC935]
    and a, $0F
    sub a, $0C
    add a, $3A
    ld l, a
    ld h, $00
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4053::
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_407B
    ld hl, $003E
    call StoreHLInWC924_B73
    ld a, [wC935]
    and a, $0F
    sub a, $0C
    add a, a
    ld hl, $4090
    add a, l
    ld l, a
    jr nc, Jump_073_406F
    inc h

Jump_073_406F::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_073_407B::
    ld a, [wC935]
    and a, $0F
    sub a, $0C
    add a, $3F
    ld l, a
    ld h, $00
    call StoreHLInWC924_B73
    ld a, $06
    ld [wC923], a
    ret
    db $93, $01, $96, $01, $99, $01, $9C, $01

Jump_073_4098::
    ld a, [wC923]
    rst $00
    dw Jump_073_40BA
    dw Func_073_4E5D
    dw Jump_073_40C5
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_40E2
    dw Func_073_4E5D
    dw Jump_073_4E41
    dw Func_073_4E48
    dw Func_073_4E67
    dw Func_073_4E9C
    dw Func_073_4E5D
    dw Jump_073_4111
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_40BA::
    ld hl, $4037
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_40C5::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_40D6
    ld hl, vTiles0 + $49
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_40D6::
    ld hl, vTiles0 + $48
    call StoreHLInWC924_B73
    ld a, $0D
    ld [wC923], a
    ret

Jump_073_40E2::
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4105
    ld hl, $0038
    call StoreHLInWC924_B73
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_4100
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_073_4100::
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4105::
    ld hl, $0039
    call StoreHLInWC924_B73
    ld a, $0B
    ld [wC923], a
    ret

Jump_073_4111::
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ld hl, wC923
    inc [hl]
    ret

Jump_073_411F::
    ld a, [wC923]
    rst $00
    dw Jump_073_43B3
    dw Func_073_4E5D
    dw Jump_073_4387
    dw Func_073_4E5D
    dw Func_073_42F1
    dw Func_073_42D8
    dw Func_073_42C2
    dw Func_073_4269
    dw Func_073_4139
    db $5D, $4E, $9C, $4E

; no direct call (reached through a table, a jump or a vector)
; reads: wC921, wC46B, wC46C, wC46D
; writes: wC921, wC928, hFFC6, hFFC7
; points at: wC923
Func_073_4139:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $3C
    ret nz
    farcall Func_002_5F22
    farcall Func_05F_6DDB
    ld b, $46
    ld de, $4001
    ld hl, vTiles1
    call DecompressToVRAM
    call Func_000_222B
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld a, [wC46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4174
    inc d

Jump_073_4174::
    ld a, [de]
    ld c, a
    ld a, [wC46C]
    and a, $F0
    swap a
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_4185
    inc d

Jump_073_4185::
    ld a, [de]
    cp a, c
    jp nz, Jump_073_4220
    ld a, [wC46D]
    and a, $F0
    swap a
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_4199
    inc d

Jump_073_4199::
    ld a, [de]
    cp a, c
    jp nz, Jump_073_4227
    ld a, [wC46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_41AD
    inc d

Jump_073_41AD::
    ld a, [de]
    or a, a
    jr nz, Jump_073_41C3
    ld hl, $0032
    call StoreHLInWC924_B73
    ld a, $1E
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_41C3::
    dec a
    jr nz, Jump_073_41D8
    ld hl, $0030
    call StoreHLInWC924_B73
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_41D8::
    dec a
    jr nz, Jump_073_41F1
    ld hl, $0031
    call StoreHLInWC924_B73
    ld hl, $03E8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_41F1::
    dec a
    jr nz, Jump_073_420A
    ld hl, $0044
    call StoreHLInWC924_B73
    ld hl, $01F4
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_420A::
    ld hl, $0045
    call StoreHLInWC924_B73
    ld hl, $00C8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_4220::
    ld hl, $0035
    call StoreHLInWC924_B73
    ret

Jump_073_4227::
    ld a, [wC46B]
    and a, $F0
    swap a
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4236
    inc d

Jump_073_4236::
    ld a, [de]
    or a, a
    jr nz, Jump_073_4250
    ld hl, $0046
    call StoreHLInWC924_B73
    ld hl, $0064
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

Jump_073_4250::
    dec a
    jr nz, Jump_073_4220
    ld hl, $0047
    call StoreHLInWC924_B73
    ld hl, $0032
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7EC2
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC5F0, wC46E
; points at: wC46B, wC923, wC46C, wC46D
Func_073_4269:: ; heuristic: target of a pointer table; C0
    call Func_073_43BE
    ld a, [wC5F0]
    and a, $01
    jr z, Jump_073_42A7
    ld a, [wC46E]
    dec a
    jr nz, Jump_073_4288
    ld hl, wC46B
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, wC923
    dec [hl]
    jr Jump_073_42A7

Jump_073_4288::
    dec a
    jr nz, Jump_073_429A
    ld hl, wC46C
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, wC923
    dec [hl]
    jr Jump_073_42A7

Jump_073_429A::
    ld hl, wC46D
    call Func_073_42AB
    or a, a
    jr z, Jump_073_42A7
    ld hl, wC923
    inc [hl]

Jump_073_42A7::
    call Func_073_441D
    ret

; 3 call sites from 1 routine (e.g. Func_073_4269)
Func_073_42AB::
    ld a, [hl]
    and a, $0F
    jr z, Jump_073_42BF
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_42BD
    xor a, a
    ld [hl], a

Jump_073_42BD::
    xor a, a
    ret

Jump_073_42BF::
    ld a, $01
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC562
; points at: wC46E, wC923
Func_073_42C2:: ; heuristic: target of a pointer table; C0
    ld a, [wC562]
    bit 0, a
    jr z, Jump_073_42D1
    ld hl, wC46E
    inc [hl]
    ld hl, wC923
    inc [hl]

Jump_073_42D1::
    call Func_073_43BE
    call Func_073_441D
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC921
; writes: wC921
; points at: wC923
Func_073_42D8:: ; heuristic: target of a pointer table; C0
    call Func_073_43BE
    call Func_073_441D
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $1E
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCD04, wIsCGB
; writes: wC46B, wC46C, wC46D, wC46E, rSVBK
; points at: wC198, wC923
Func_073_42F1:: ; heuristic: target of a pointer table; C0
    farcall Func_002_5EEE
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    swap a
    ld [wC46B], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    swap a
    ld [wC46C], a
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    swap a
    ld [wC46D], a
    xor a, a
    ld [wC46E], a
    call Func_073_441D
    ld de, $4378
    ld hl, wC198
    ld b, $03

Jump_073_432D::
    push hl
    ld a, [de]
    inc de
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
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_4363
    push hl
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    xor a, a
    ldh [rSVBK], a
    pop hl

Jump_073_4363::
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_073_436A
    inc h

Jump_073_436A::
    dec b
    jr nz, Jump_073_432D
    farcall Func_05F_6DDB
    ld hl, wC923
    inc [hl]
    ret
    db $B0, $B1, $B1, $B1, $B2, $B6, $A4, $A5, $A6, $B7, $B3, $B4, $B4, $B4, $B5

Jump_073_4387::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_43A7
    ld hl, $002F
    call StoreHLInWC924_B73
    ld hl, $0064
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, wC923
    inc [hl]
    ret

Jump_073_43A7::
    ld hl, $0036
    call StoreHLInWC924_B73
    ld a, $09
    ld [wC923], a
    ret

Jump_073_43B3::
    ld hl, wC923
    inc [hl]
    ld hl, $002E
    call StoreHLInWC924_B73
    ret

; 3 call sites from 3 routines (e.g. Func_073_4269, Func_073_42C2, Func_073_42D8)
; reads: wC5F0, wC46E, wC46B, wC46C, wC46D
; writes: wC46B, wC46C, wC46D
Func_073_43BE::
    ld a, [wC5F0]
    and a, $01
    ret z
    ld a, [wC46E]
    cp a, $03
    ret z
    or a, a
    jr nz, Jump_073_43E5
    ld a, [wC46B]
    add a, $02
    ld [wC46B], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_43E5
    ld a, [wC46B]
    and a, $0F
    ld [wC46B], a

Jump_073_43E5::
    ld a, [wC46E]
    cp a, $02
    jr z, Jump_073_4404
    ld a, [wC46C]
    add a, $01
    ld [wC46C], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_4404
    ld a, [wC46C]
    and a, $0F
    ld [wC46C], a

Jump_073_4404::
    ld a, [wC46D]
    add a, $04
    ld [wC46D], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, Jump_073_441C
    ld a, [wC46D]
    and a, $0F
    ld [wC46D], a

Jump_073_441C::
    ret

; 4 call sites from 4 routines (e.g. Func_073_4269, Func_073_42C2, Func_073_42D8, Func_073_42F1)
; reads: wC46B, wC46C, wC46D
; writes: hFFC6, hFFC7
Func_073_441D::
    ld hl, vTiles1 + $240
    ld a, [wC46B]
    and a, $F0
    swap a
    push af
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4430
    inc d

Jump_073_4430::
    ld a, [de]
    ldh [hFFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_443B
    ld a, $00

Jump_073_443B::
    ld de, $453A
    add a, e
    ld e, a
    jr nc, Jump_073_4443
    inc d

Jump_073_4443::
    ld a, [de]
    ldh [hFFC7], a
    ld a, [wC46B]
    call Func_073_44A5
    ld a, [wC46C]
    and a, $F0
    swap a
    push af
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_445C
    inc d

Jump_073_445C::
    ld a, [de]
    ldh [hFFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_4467
    ld a, $00

Jump_073_4467::
    ld de, $4544
    add a, e
    ld e, a
    jr nc, Jump_073_446F
    inc d

Jump_073_446F::
    ld a, [de]
    ldh [hFFC7], a
    ld a, [wC46C]
    call Func_073_44A5
    ld a, [wC46D]
    and a, $F0
    swap a
    push af
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_4488
    inc d

Jump_073_4488::
    ld a, [de]
    ldh [hFFC6], a
    pop af
    inc a
    cp a, $0A
    jr nz, Jump_073_4493
    ld a, $00

Jump_073_4493::
    ld de, $454E
    add a, e
    ld e, a
    jr nc, Jump_073_449B
    inc d

Jump_073_449B::
    ld a, [de]
    ldh [hFFC7], a
    ld a, [wC46D]
    call Func_073_44A5
    ret

; 3 call sites from 1 routine (e.g. Func_073_441D)
; reads: hFFC7, hFFC8, hFFC6
; writes: hFFC8
Func_073_44A5::
    and a, $0E
    ldh [hFFC8], a
    or a, a
    jr z, Jump_073_44CE
    ldh a, [hFFC7]
    swap a
    ld de, $44EA
    add a, e
    ld e, a
    jr nc, Jump_073_44B8
    inc d

Jump_073_44B8::
    ldh a, [hFFC8]
    ld c, a
    ld a, $10
    sub a, c
    add a, e
    ld e, a
    jr nc, Jump_073_44C3
    inc d

Jump_073_44C3::
    ldh a, [hFFC8]
    ld b, a

Jump_073_44C6::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_073_44C6

Jump_073_44CE::
    ldh a, [hFFC8]
    ld c, a
    ld a, $10
    sub a, c
    ld b, a
    ldh a, [hFFC6]
    swap a
    ld de, $44EA
    add a, e
    ld e, a
    jr nc, Jump_073_44E1
    inc d

Jump_073_44E1::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_073_44E1
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CC4EA, $E6

Jump_073_45D0::
    ld a, [wC923]
    rst $00
    dw Jump_073_45E4
    dw Func_073_4E5D
    dw Func_073_45EF
    dw Func_073_4E20
    dw Func_073_4635
    dw Func_073_463C
    db $5D, $4E, $9C, $4E

Jump_073_45E4::
    ld hl, wC923
    inc [hl]
    ld hl, $4021
    call StoreHLInWC924_B73
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wC923
Func_073_45EF:: ; heuristic: target of a pointer table; C0
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4629
    ld hl, vTiles0 + $23
    call StoreHLInWC924_B73
    ld a, $FF
    db $EA, $93

; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, hFFC7
; points at: wC923
Func_073_45FF:: ; heuristic: target of a pointer table; C0
    adc a, $EA
    sub a, h
    adc a, $EA
    sub a, l
    adc a, $EA
    sub a, [hl]
    adc a, $EA
    sub a, a
    adc a, $EA
    sbc a, b
    adc a, $EA
    sbc a, c
    adc a, $EA
    sbc a, d
    adc a, $21
    ret z
    nop
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4629::
    ld hl, vTiles0 + $22
    call StoreHLInWC924_B73
    ld a, $06
    ld [wC923], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_073_4635:: ; heuristic: target of a pointer table; C0
    farcall Func_012_653F
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC923
Func_073_463C:: ; heuristic: target of a pointer table; C0
    ld hl, $0052
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4647::
    ld a, [wC923]
    rst $00
    dw Jump_073_47FD
    dw Func_073_4E5D
    dw Jump_073_47DB
    dw Func_073_4E5D
    dw Jump_073_46B3
    dw Func_073_4E5D
    dw Func_073_4E9C
    INCBIN "dwm2-cobi-us.gbc", $1CC659, $5A

Jump_073_46B3::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $0F
    cp a, $0D
    jr nc, Jump_073_46B3
    ld [wC46C], a
    inc a
    ld [wC8C0], a
    xor a, a
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC17E
    call Func_000_23CA
    ld a, [wC46B]
    ld c, a
    ld a, [wC46C]
    cp a, c
    jr nz, Jump_073_46EA
    ld hl, vTiles0 + $18
    call StoreHLInWC924_B73
    jp Jump_073_4797

Jump_073_46EA::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_46FD
    ld a, [wC46B]
    ld c, a
    ld a, [wC46C]
    cp a, c
    jp c, Jump_073_4791
    jr Jump_073_470A

Jump_073_46FD::
    ld a, [wC46B]
    ld c, a
    ld a, [wC46C]
    cp a, c
    db $D2

; no direct call (reached through a table, a jump or a vector)
; reads: wC922, wC921, wC46D, wCD03
; writes: wC922, wC46D, wC928, wC923, wC921, wC8C0, wC8C1, wC8C2
; points at: wC152, wC181, wC016
Func_073_4706:: ; heuristic: target of a pointer table; C0
    sub a, c
    ld b, a
    jr Jump_073_470A

Jump_073_470A::
    ld a, [wC922]
    inc a
    ld [wC922], a
    ld a, [wC921]
    ld [wC46D], a
    ld a, [wC922]
    cp a, $05
    jr nz, Jump_073_473F
    ld hl, vTiles0 + $1C
    call StoreHLInWC924_B73
    ld a, [wC46D]
    ld de, wC152
    call Func_000_2431
    ld a, [wC46D]
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, $0E
    ld [wC923], a
    ret

Jump_073_473F::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    ld hl, $4822
    add a, l
    ld l, a
    jr nc, Jump_073_474F
    inc h

Jump_073_474F::
    ld a, [wC922]
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_073_4759
    inc h

Jump_073_4759::
    ld a, [hl]
    ld [wC921], a
    ld de, wC152
    call Func_000_2431
    ld a, [wC922]
    sla a
    ld hl, $4836
    add a, l
    ld l, a
    jr nc, Jump_073_4770
    inc h

Jump_073_4770::
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl]
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC181
    call Func_000_23CA
    ld hl, wC016
    call StoreHLInWC924_B73
    ld a, $08
    ld [wC923], a
    ret

Jump_073_4791::
    ld hl, vTiles0 + $17
    call StoreHLInWC924_B73

Jump_073_4797::
    ld a, [wC922]
    add a, a
    ld hl, $4836
    add a, l
    ld l, a
    jr nc, Jump_073_47A3
    inc h

Jump_073_47A3::
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl]
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    ld a, [wC8C0]
    ld c, a
    ld a, [wC617]
    sub a, c
    ld [wC617], a
    ld a, [wC8C1]
    ld c, a
    ld a, [wC618]
    sbc a, c
    ld [wC618], a
    ld a, [wC619]
    sbc a, $00
    ld [wC619], a
    call Func_000_173A
    ld de, wC181
    call Func_000_23CA
    ld hl, wC923
    inc [hl]
    ret

Jump_073_47DB::
    ld hl, wC923
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_47F1
    ld a, $06
    ld [wC46B], a
    ld hl, wC014
    call StoreHLInWC924_B73
    ret

Jump_073_47F1::
    ld hl, vTiles0 + $15
    call StoreHLInWC924_B73
    ld a, $10
    ld [wC923], a
    ret

Jump_073_47FD::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    ld hl, $4822
    add a, l
    ld l, a
    jr nc, Jump_073_480D
    inc h

Jump_073_480D::
    ld a, [hl]
    ld [wC921], a
    ld de, wC152
    call Func_000_2431
    ld hl, $4013
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret
    db $03, $22, $28, $2A, $0B, $25, $05, $2B, $0C, $23, $27, $2C, $11, $12, $26, $1E
    db $0D, $0E, $0F, $10, $64, $00, $2C, $01, $58, $02, $E8, $03, $DC, $05

Jump_073_4840::
    ld a, [wC923]
    rst $00
    dw Jump_073_4860
    dw Func_073_4E5D
    dw Jump_073_486B
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4888
    dw Func_073_4E5D
    dw Jump_073_48A0
    dw Func_073_4E5D
    dw Jump_073_48F8
    dw Func_073_4E5D
    dw Jump_073_493C
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4860::
    ld hl, wC923
    inc [hl]
    ld hl, $4024
    call StoreHLInWC924_B73
    ret

Jump_073_486B::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_487C
    ld hl, vTiles0 + $51
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_487C::
    ld hl, vTiles0 + $50
    call StoreHLInWC924_B73
    ld a, $0C
    ld [wC923], a
    ret

Jump_073_4888::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4899
    ld hl, $0025
    call StoreHLInWC924_B73
    ret

Jump_073_4899::
    ld hl, $0053
    call StoreHLInWC924_B73
    ret

Jump_073_48A0::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_48E9
    ld a, $00
    call Func_073_4956
    ld a, $00
    call Func_073_49E6
    ld a, $00
    call Func_073_4A0F
    ld a, [wC6FD]
    dec a
    jr nz, Jump_073_48CB

Jump_073_48BF::
    ld hl, $0026
    call StoreHLInWC924_B73
    ld a, $0C
    ld [wC923], a
    ret

Jump_073_48CB::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FF]
    ld c, $55
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_073_48BF
    ld hl, $4026
    call StoreHLInWC924_B73
    ret

Jump_073_48E9::
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ld a, $0C
    ld [wC923], a
    ret

Jump_073_48F8::
    ld hl, wC923
    inc [hl]
    ld a, $01
    call Func_073_4956
    ld a, $01
    call Func_073_49E6
    ld a, $01
    call Func_073_4A0F
    ld a, [wC6FD]
    dec a
    dec a
    jr nz, Jump_073_491E

Jump_073_4912::
    ld hl, vTiles0 + $26
    call StoreHLInWC924_B73
    ld a, $0C
    ld [wC923], a
    ret

Jump_073_491E::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC700]
    ld c, $55
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_073_4912
    ld hl, wC026
    call StoreHLInWC924_B73
    ret

Jump_073_493C::
    ld hl, wC923
    inc [hl]
    ld hl, vTiles0 + $26
    call StoreHLInWC924_B73
    ld a, $02
    call Func_073_4956
    ld a, $02
    call Func_073_49E6
    ld a, $02
    call Func_073_4A0F
    ret

; 3 call sites from 1 routine (e.g. Func_073_4706)
; reads: hFFC6, hFFC7
; writes: rRAMG, hFFC8
; points at: wC6FE
Func_073_4956::
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_073_495E
    inc h

Jump_073_495E::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ldh [hFFC8], a
    ld a, [hl]
    ld c, $5D
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld b, $01
    ld a, [hl]
    ld c, $61
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $02
    ld a, [hl]
    ld c, $63
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $03
    ld a, [hl]
    ld c, $65
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $04
    ld a, [hl]
    ld c, $67
    call LoadSRAMRecordWord
    call Func_073_49B1
    ld b, $05
    ld a, [hl]
    ld c, $69
    call LoadSRAMRecordWord
    call Func_073_49B1
    xor a, a
    ld [rRAMG], a
    call Func_073_49C5
    ret

; 5 call sites from 1 routine (e.g. Func_073_4956)
; reads: hFFC7, hFFC6
; writes: hFFC8
Func_073_49B1::
    ldh a, [hFFC7]
    cp a, d
    jr c, Jump_073_49BB
    ret nz
    ldh a, [hFFC6]
    cp a, e
    ret nc

Jump_073_49BB::
    ld a, b
    ldh [hFFC8], a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ret

; 1 call site from 1 routine (e.g. Func_073_4956)
; reads: hFFC8
; writes: wC921, wC529, wC528, wC53D, wC53E
; points at: wC152
Func_073_49C5::
    ldh a, [hFFC8]
    ld [wC921], a
    add a, $28
    ld [wC529], a
    ld a, $05
    ld [wC528], a
    ld hl, wC152
    ld a, l
    ld [wC53D], a
    ld a, h
    ld [wC53E], a
    farcall Func_009_4008
    ret

; 3 call sites from 1 routine (e.g. Func_073_4706)
; writes: rRAMG
; points at: wC6FE, wC8CF, wC147
Func_073_49E6::
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_073_49EE
    inc h

Jump_073_49EE::
    ld a, $0A
    ld [rRAMG], a
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    xor a, a
    ld [rRAMG], a
    ld hl, wC8CF
    ld de, wC147
    ld b, $0A

Jump_073_4A05::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_073_4A05
    ld a, $F0
    ld [de], a
    ret

; 3 call sites from 1 routine (e.g. Func_073_4706)
; reads: wC921, hFFC6, hFFC7, hFFC9, hFFC8
; writes: rRAMG, hFFC8, hFFC9, wC8C0, wC8C1, wC8C2
; points at: wC6FE, wC17E
Func_073_4A0F::
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_073_4A17
    inc h

Jump_073_4A17::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC921]
    ld de, $4A7C
    add a, e
    ld e, a
    jr nc, Jump_073_4A27
    inc d

Jump_073_4A27::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    add a, $14
    ldh [hFFC8], a
    ldh a, [hFFC7]
    adc a, $00
    ldh [hFFC9], a
    ldh a, [hFFC9]
    cp a, $03
    jr nz, Jump_073_4A4E
    ldh a, [hFFC8]
    cp a, $E8
    jr c, Jump_073_4A4E
    ld de, $03E7
    ld a, e
    ldh [hFFC8], a
    ld a, d
    ldh [hFFC9], a

Jump_073_4A4E::
    ld a, [hl]
    call SRAMRecordAddress
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC8]
    sub a, c
    ld [wC8C0], a
    ldh a, [hFFC7]
    ld c, a
    ldh a, [hFFC9]
    sbc a, c
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC17E
    call Func_000_23CA
    ret
    db $5D, $61, $63, $65, $67, $69

Jump_073_4A82::
    ld a, [wC923]
    rst $00
    dw Jump_073_4A9E
    dw Func_073_4E5D
    dw Jump_073_4AA9
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4AC6
    dw Func_073_4E5D
    dw Jump_073_4ADE
    dw Func_073_4E5D
    dw Func_073_4E9C
    dw Func_073_4E5D
    dw Jump_073_4B2B

Jump_073_4A9E::
    ld hl, wC923
    inc [hl]
    ld hl, $401D
    call StoreHLInWC924_B73
    ret

Jump_073_4AA9::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4ABA
    ld hl, vTiles0 + $4B
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4ABA::
    ld hl, vTiles0 + $4A
    call StoreHLInWC924_B73
    ld a, $08
    ld [wC923], a
    ret

Jump_073_4AC6::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4AD7
    ld hl, $001E
    call StoreHLInWC924_B73
    ret

Jump_073_4AD7::
    ld hl, $001F
    call StoreHLInWC924_B73
    ret

Jump_073_4ADE::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4B21
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    add a, $19
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wC928]
    ld de, wC152
    call Func_000_2431
    ld a, [wC634]
    or a, a
    jr z, Jump_073_4B15
    cp a, $FF
    jr z, Jump_073_4B15
    ld hl, $001B
    call StoreHLInWC924_B73
    ret

Jump_073_4B15::
    ld hl, $401B
    call StoreHLInWC924_B73
    ld a, $0A
    ld [wC923], a
    ret

Jump_073_4B21::
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ret

Jump_073_4B2B::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    add a, $19
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wC928]
    ld de, wC152
    call Func_000_2431
    ld a, [wC634]
    or a, a
    jr z, Jump_073_4B5D
    cp a, $FF
    jr z, Jump_073_4B5D
    ld hl, vTiles0 + $1B
    call StoreHLInWC924_B73
    ld a, $08
    ld [wC923], a
    ret

Jump_073_4B5D::
    ld hl, wC01B
    call StoreHLInWC924_B73
    ld hl, wC923
    dec [hl]
    ret

Jump_073_4B68::
    ld a, [wC923]
    rst $00
    dw Jump_073_4B80
    dw Func_073_4E5D
    dw Jump_073_4B8B
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4BA8
    dw Func_073_4E5D
    dw Jump_073_4C1B
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4B80::
    ld hl, wC923
    inc [hl]
    ld hl, $4010
    call StoreHLInWC924_B73
    ret

Jump_073_4B8B::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4B9C
    ld hl, vTiles0 + $4F
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4B9C::
    ld hl, vTiles0 + $4E
    call StoreHLInWC924_B73
    ld a, $08
    ld [wC923], a
    ret

Jump_073_4BA8::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4BB9
    db $21

; no direct call (reached through a table, a jump or a vector)
; points at: wCD00
Func_073_4BB3:: ; heuristic: target of a pointer table; C0
    ld de, wCD00
    ret c
    ld c, [hl]
    ret

Jump_073_4BB9::
    ld hl, $0012
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ret

Jump_073_4BC3::
    ld a, [wC923]
    rst $00
    dw Jump_073_4BDB
    dw Func_073_4E5D
    dw Jump_073_4BE6
    dw Func_073_4E5D
    dw Jump_073_5194
    dw Jump_073_4C03
    dw Func_073_4E5D
    dw Jump_073_4C1B
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4BDB::
    ld hl, wC923
    inc [hl]
    ld hl, $400B
    call StoreHLInWC924_B73
    ret

Jump_073_4BE6::
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4BF7
    ld hl, vTiles0 + $4D
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4BF7::
    ld hl, vTiles0 + $4C
    call StoreHLInWC924_B73
    ld a, $08
    ld [wC923], a
    ret

Jump_073_4C03::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4C14
    ld hl, $000C
    call StoreHLInWC924_B73
    ret

Jump_073_4C14::
    ld hl, $000E
    call StoreHLInWC924_B73
    ret

Jump_073_4C1B::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_073_4C53
    call NextTableByte
    ld a, [wC5E7]
    cp a, $10
    jr c, $4C41

Jump_073_4C2F::
    ld hl, $000D
    call StoreHLInWC924_B73
    ld a, $29
    ld [wC928], a
    farcall Func_05F_6C8C
    ret
    db $21

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: wC928
Func_073_4C42:: ; heuristic: target of a pointer table; C0
    sbc a, d
    ld l, b
    ld b, $12
    rst $10
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_073_4C2F
    ld hl, $0043
    call StoreHLInWC924_B73
    ret

Jump_073_4C53::
    ld hl, $000F
    call StoreHLInWC924_B73
    call Func_073_4C5D
    ret

; 5 call sites from 5 routines (e.g. Func_073_4C42, Func_073_4BB3, Func_073_4A0F, Func_073_4706, ...)
; reads: wC617, wC618, wC619, wC8C0, wC8C1, wC8C2
; writes: wC8C0, wC8C1, wC8C2
; points at: wC17E
Func_073_4C5D::
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    farcall Func_012_7F1C
    ld a, [wC617]
    ld c, a
    ld a, [wC8C0]
    sub a, c
    ld [wC8C0], a
    ld a, [wC618]
    ld c, a
    ld a, [wC8C1]
    sbc a, c
    ld [wC8C1], a
    ld a, [wC619]
    ld c, a
    ld a, [wC8C2]
    sbc a, c
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC17E
    call Func_000_23CA
    ret

Jump_073_4CA0::
    ld a, [wC923]
    rst $00
    dw Jump_073_4CAE
    dw Func_073_4E5D
    dw Jump_073_4CE5
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4CAE::
    ld hl, wC923
    inc [hl]
    ld hl, $4008
    call StoreHLInWC924_B73
    call Func_073_4FD2
    ld a, [wC921]
    ld de, wC152
    call Func_000_2431
    ld a, [wC921]
    call Func_073_4FB7
    ld e, l

; no direct call (reached through a table, a jump or a vector)
; writes: wC8C0, wC8C1, wC8C2
; points at: wC17E
Func_073_4CCB:: ; heuristic: target of a pointer table; C0
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC17E
    call Func_000_23CA
    ret

Jump_073_4CE5::
    ld hl, wC923
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4D19
    ld a, [wC921]
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wC921]
    call Func_073_4FB7
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, vTiles0 + $9
    call StoreHLInWC924_B73
    ret

Jump_073_4D19::
    ld hl, vTiles0 + $A
    call StoreHLInWC924_B73
    ret

Jump_073_4D20::
    ld a, [wC923]
    rst $00
    dw Jump_073_4D36
    dw Func_073_4E5D
    dw Jump_073_4D41
    dw Func_073_4E20
    dw Jump_073_4E41
    dw Jump_073_4D5B
    dw Func_073_4E67
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4D36::
    ld hl, wC923
    inc [hl]
    ld hl, $4005
    call StoreHLInWC924_B73
    ret

Jump_073_4D41::
    ld hl, wC923
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4D52
    ld hl, vTiles0 + $27
    call StoreHLInWC924_B73
    ret

Jump_073_4D52::
    ld hl, wC923
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4D5B::
    ld hl, wC923
    inc [hl]
    ld a, [wC924]
    cp a, $27
    jr nz, Jump_073_4D82
    ld hl, $03E8
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    farcall Func_012_64F8
    ld hl, $0006
    call StoreHLInWC924_B73
    ret

Jump_073_4D82::
    ld hl, vTiles0 + $7
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4D8D::
    ld a, [wC923]
    rst $00
    dw Jump_073_4D9B
    dw Func_073_4E5D
    dw Jump_073_4DCD
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4D9B::
    ld hl, wC923
    inc [hl]
    ld hl, $4002
    call StoreHLInWC924_B73
    call Func_073_4FD2
    ld a, [wC921]
    ld de, wC152
    call Func_000_2431
    ld a, [wC921]
    call Func_073_4FB7
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    ld de, wC17E
    call Func_000_23CA
    ret

Jump_073_4DCD::
    ld hl, wC923
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_073_4DFC
    ld a, [wC921]
    ld [wC928], a
    farcall Func_05F_6C8C
    ld a, [wC921]
    call Func_073_4FB7
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7E84
    ld hl, vTiles0 + $3
    call StoreHLInWC924_B73
    ret

Jump_073_4DFC::
    ld hl, vTiles0 + $4
    call StoreHLInWC924_B73
    ret

Jump_073_4E03::
    ld a, [wC923]
    rst $00
    dw Jump_073_4E15
    dw Func_073_4E20
    dw Jump_073_4E41
    dw Func_073_4E48
    dw Func_073_4E67
    dw Func_073_4E5D
    dw Func_073_4E9C

Jump_073_4E15::
    ld hl, $0000
    call StoreHLInWC924_B73
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wC49F, wC0F0, wC923
Func_073_4E20:: ; heuristic: target of a pointer table; C0
    xor a, a
    call Func_073_4FA9
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_4E37
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_073_4E37::
    ld a, $7A
    call StoreWC60B
    ld hl, wC923
    inc [hl]
    ret

Jump_073_4E41::
    farcall Func_012_653F
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC921
; points at: wC923
Func_073_4E48:: ; heuristic: follows a terminator; C0
    farcall Func_012_64F8
    ld hl, $0001
    call StoreHLInWC924_B73
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC923
Func_073_4E5D:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_073_4FA9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC921
; writes: wC921, hFF8D, wC527
; points at: wC923
Func_073_4E67:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    or a, a
    jr nz, Jump_073_4E76
    inc a
    ld [wC921], a
    ld a, $0E
    ldh [hFF8D], a
    ret

Jump_073_4E76::
    farcall Func_002_5E85
    farcall Func_002_5E85
    call Func_000_222B
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_073_6038)
; reads: wC921
; writes: wCB7D, wC921, wC919, wC935
Func_073_4E9C:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_073_4EA9
    bit 3, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EA9::
    cp a, $3C
    jr nc, Jump_073_4EB3
    bit 2, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EB3::
    bit 1, a
    jr z, Jump_073_4EB9
    jr Jump_073_4EC0

Jump_073_4EB9::
    ld a, $01
    ld [wCB7D], a
    jr Jump_073_4EC4

Jump_073_4EC0::
    xor a, a
    ld [wCB7D], a

Jump_073_4EC4::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    ld a, $80
    ld [wC919], a
    xor a, a
    ld [wC935], a
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 76 call sites from 14 routines (e.g. Func_073_4E48, Func_073_4C42, Func_073_4BB3, Func_073_4706, ...)
; writes: wC924, wC925, wC926
StoreHLInWC924_B73::
Func_073_4ED8:: ; address name
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FA9)
; reads: wC926
Func_073_4EE5:: ; heuristic: follows a terminator; C0
    push af
    ld a, [wC926]
    cp a, $FF
    jr nz, Jump_073_4EEF
    pop af
    ret

Jump_073_4EEF::
    rst $00
    dw Jump_073_4EF8
    dw Jump_073_4F3C
    dw Jump_073_4F59
    dw Jump_073_4F90

Jump_073_4EF8::
    pop af
    or a, a
    jr nz, Jump_073_4F02
    farcall Func_004_4470

Jump_073_4F02::
    ld a, [wC925]
    bit 7, a
    jr nz, Jump_073_4F37
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call StoreWC60B
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_073_4F37
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_073_4F37::
    ld hl, wC926
    inc [hl]
    ret

Jump_073_4F3C::
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC924]
    ld [wC529], a
    ld a, $05
    ld [wC528], a
    farcall Func_009_4001
    ld hl, wC926
    inc [hl]
    ret

Jump_073_4F59::
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC925]
    bit 6, a
    jr z, Jump_073_4F6D
    ld a, $FF
    ld [wC926], a
    ret

Jump_073_4F6D::
    ld a, $69
    call StoreWC60B
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_073_4F8B
    ld a, $82
    ld [wC8CB], a

Jump_073_4F8B::
    ld hl, wC926
    inc [hl]
    ret

Jump_073_4F90::
    ld a, [wC8CB]
    and a, $03
    jr z, Jump_073_4F99
    pop af
    ret

Jump_073_4F99::
    pop af
    or a, a
    jr nz, Jump_073_4FA3
    farcall Func_004_449F

Jump_073_4FA3::
    ld a, $FF
    ld [wC926], a
    ret

; 2 call sites from 2 routines (e.g. Func_073_4E5D, Func_073_4E20)
; reads: wC926
Func_073_4FA9::
    call Func_073_4EE5
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_073_4FB5
    sub a, a
    ret

Jump_073_4FB5::
    scf
    ret

; 5 call sites from 3 routines (e.g. Func_073_4CCB, Func_073_516B, Func_073_4C5D)
Func_073_4FB7::
    ld c, $0D
    call Multiply8
    ld a, l
    add a, $C3
    ld l, a
    ld a, h
    adc a, $4C
    ld h, a
    ld e, l
    ld d, h
    ld b, $16
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    ret

; 2 call sites from 2 routines (e.g. Func_073_4CCB, Func_073_4C5D)
; reads: wC92C, wC6FD, wD7AA, hFFC9, hFFC8
; writes: wC921
Func_073_4FD2::
    farcall Func_05F_6CA9
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_4FE8
    ld a, $0C
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_4FE8::
    farcall Func_05F_6D0D
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_4FFE
    ld a, $08
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_4FFE::
    farcall Func_05F_6CDB
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_5014
    ld a, $06
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5014::
    ld a, [wC6FD]
    cp a, $03
    jr z, Jump_073_505C
    farcall Func_01D_5E3F
    ld a, [wD7AA]
    cp a, $03
    jr nc, Jump_073_5032
    ld a, $19
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5032::
    ld a, [wD7AA]
    cp a, $03
    jr c, Jump_073_5047
    cp a, $06
    jr nc, Jump_073_5047
    ld a, $1A
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5047::
    ld a, [wD7AA]
    cp a, $06
    jr c, Jump_073_505C
    cp a, $0B
    jr nc, Jump_073_505C
    ld a, $1B
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_505C::
    call Func_073_5117
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_506A
    ldh a, [hFFC8]
    cp a, $65
    jr c, Jump_073_5074

Jump_073_506A::
    ld a, $05
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_5074::
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_508C
    ldh a, [hFFC8]
    cp a, $65
    jr nc, Jump_073_508C
    or a, a
    jr z, Jump_073_508C
    ld a, $04
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_508C::
    call Func_073_50C3
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_509A
    ldh a, [hFFC8]
    cp a, $65
    jr c, Jump_073_50A4

Jump_073_509A::
    ld a, $03
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_50A4::
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_073_50BD
    ldh a, [hFFC8]
    cp a, $33
    jr c, Jump_073_50BD
    cp a, $64
    jr nc, Jump_073_50BD
    ld a, $02
    ld [wC921], a
    call Func_073_516B
    or a, a
    ret nz

Jump_073_50BD::
    ld a, $01
    ld [wC921], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6, hFFC7, hFFC8, hFFC9
; writes: hFFC8, hFFC9, rRAMG
; points at: wC6FE
Func_073_50C3::
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_073_5112
    ld b, a
    ld hl, wC6FE

Jump_073_50DB::
    ld a, [hl]
    ld c, $5D
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    sub a, l
    ldh [hFFC8], a
    ldh a, [hFFC9]
    sbc a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_073_50DB

Jump_073_5112::
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6, hFFC7, hFFC8, hFFC9
; writes: hFFC8, hFFC9, rRAMG
; points at: wC6FE
Func_073_5117::
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_073_5166
    ld b, a
    ld hl, wC6FE

Jump_073_512F::
    ld a, [hl]
    ld c, $61
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    sub a, l
    ldh [hFFC8], a
    ldh a, [hFFC9]
    sbc a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_073_512F

Jump_073_5166::
    xor a, a
    ld [rRAMG], a
    ret

; 10 call sites from 1 routine (e.g. Func_073_4FD2)
; reads: wC935, wC619, wC618, wC617
Func_073_516B::
    call Func_073_4FB7
    ld a, [wC935]
    and a, $0F
    dec a
    jr z, Jump_073_517B
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de

Jump_073_517B::
    ld a, [wC619]
    or a, a
    jr z, Jump_073_5184

Jump_073_5181::
    ld a, $01
    ret

Jump_073_5184::
    ld a, [wC618]
    cp a, h
    jr c, Jump_073_5192
    jr nz, Jump_073_5181
    ld a, [wC617]
    cp a, l
    jr nc, Jump_073_5181

Jump_073_5192::
    xor a, a
    ret

Jump_073_5194::
    ld hl, wC923
    inc [hl]
    ld a, $06
    ld [wC903], a
    ld a, $01
    ld [wC905], a
    ld a, $03
    ld [wC5DC], a
    xor a, a
    ld [wC904], a
    ld a, $02
    ld [wC8C7], a
    farcall Func_002_5EEE
    farcall Func_00A_476E
    ret

; 1 call site from 1 routine (e.g. Func_010_4F31)
; reads: wC923
Func_073_51BD::
    ld a, [wC923]
    rst $00
    dw Jump_073_52EE
    dw Jump_073_7AC6
    dw Jump_073_52B9
    dw Jump_073_52B2
    dw Jump_073_7AC6
    dw Jump_073_5265
    dw Jump_073_524B
    dw Jump_073_51FB
    dw Jump_073_53D8
    dw Jump_073_51D7
    dw Jump_073_51FB

Jump_073_51D7::
    ld a, [wC922]
    ld c, a
    ld a, [wCB8A]
    add a, c
    ld [wCB8A], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $10
    ret nz
    xor a, a
    ld [wCB86], a
    ld hl, wCB8C
    call Func_073_7A4C
    ld hl, wC923
    inc [hl]
    ret

Jump_073_51FB::
    ldh a, [hFF90]
    sub a, $C8
    add a, a
    ld hl, $5215
    add a, l
    ld l, a
    jr nc, Jump_073_5208
    inc h

Jump_073_5208::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret
    db $00, $00, $00, $00, $D4, $01, $D9, $01, $DD, $01, $6A, $01, $6E, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $74, $01, $78, $01, $7C, $01, $D5, $00, $D9, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $DF, $00, $F8, $00, $FC, $00, $F2, $01
    db $F6, $01, $00, $00, $00, $00

Jump_073_524B::
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wCB7D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5265::
    ldh a, [hFF90]
    cp a, $CE
    jr z, Jump_073_5278
    cp a, $D7
    jr z, Jump_073_528A
    cp a, $E0
    jr z, Jump_073_529C
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5278::
    ld a, $0A
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld de, $0206
    call SetFlagBit
    jr Jump_073_52AC

Jump_073_528A::
    ld a, $0B
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld de, $0207
    call SetFlagBit
    jr Jump_073_52AC

Jump_073_529C::
    ld a, $0C
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld de, $0208
    call SetFlagBit

Jump_073_52AC::
    ld a, $08
    ld [wC923], a
    ret

Jump_073_52B2::
    ld de, $5342
    call Func_073_52F5
    ret

Jump_073_52B9::
    ldh a, [hFF90]
    sub a, $C8
    ld de, $52D3
    add a, e
    ld e, a
    jr nc, Jump_073_52C5
    inc d

Jump_073_52C5::
    ld a, [de]
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret
    db $00, $00, $20, $21, $22, $23, $24, $00, $00, $00, $00, $25, $26, $27, $28, $29
    db $00, $00, $00, $00, $2A, $2B, $2C, $2D, $2E, $00, $00

Jump_073_52EE::
    ld de, $530C
    call Func_073_52F5
    ret

; 2 call sites from 1 routine (e.g. Func_073_51BD)
; reads: hFF90
; points at: wC923
Func_073_52F5::
    ldh a, [hFF90]
    sub a, $C8
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_073_52FF
    inc d

Jump_073_52FF::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CD30C, $6C

; 1 call site from 1 routine (e.g. Func_010_4F2A)
; reads: hFFC6, wCC3F
; writes: hFFC6, hFFC7, wCC3F, wCB9A, wCB9B, wC919
Func_073_5378::
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $09
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, [wCC3F]
    set 1, a
    ld [wCC3F], a
    ld a, $50
    ld [wCB9A], a
    ld a, $70
    ld [wCB9B], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4F23)
; reads: wC923
Func_073_53AB::
    ld a, [wC923]
    rst $00
    dw Jump_073_53D8
    dw Jump_073_53B3

Jump_073_53B3::
    ld a, [wC922]
    ld c, a
    ld a, [wCB8A]
    add a, c
    ld [wCB8A], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $10
    ret nz
    xor a, a
    ld [wCB86], a
    ld hl, wCB8C
    call Func_073_7A4C
    ld a, $80
    ld [wC919], a
    ret

Jump_073_53D8::
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, wC923
    inc [hl]
    ldh a, [hFF8E]
    cp a, $30
    jr nz, Jump_073_53EE
    ldh a, [hFF91]
    cp a, $20
    jr z, Jump_073_5412

Jump_073_53EE::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC8F0

Jump_073_53F5::
    push hl
    ld a, [hl+]
    cp a, $30
    jr nz, Jump_073_5400
    ld a, [hl]
    cp a, $20
    jr z, Jump_073_5411

Jump_073_5400::
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_073_53F5
    ld a, $FF
    ld [wC922], a
    ld a, $03
    ld [wCB86], a
    ret

Jump_073_5411::
    pop hl

Jump_073_5412::
    ld a, $01
    ld [wC922], a
    ld a, $01
    ld [wCB86], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4F1C)
; reads: wCB8B
; writes: wCBAB, wCB86, wCB96, wCB8B, wCB9B, wC919
; points at: wCB8C, wCB9C
Func_073_541D::
    ld a, $10
    ld [wCBAB], a
    xor a, a
    ld [wCB86], a
    ld [wCB96], a
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld a, [wCB8B]
    inc a
    inc a
    ld [wCB8B], a
    ld [wCB9B], a
    cp a, $B0
    ret nz
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4F0E)
; reads: wC923
Func_073_5449::
    ld a, [wC923]
    rst $00
    dw Jump_073_5509
    dw Jump_073_54CA
    dw Jump_073_54BF
    dw Jump_073_7AC6
    dw Jump_073_54BA
    dw Jump_073_54AF
    dw Jump_073_7AC6
    dw Jump_073_546C
    dw Jump_073_5461
    dw Func_073_7AD0

Jump_073_5461::
    ld hl, $0782
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_546C::
    ld a, [wCB8B]
    cp a, $40
    jr z, Jump_073_5488
    xor a, a
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_073_5488::
    xor a, a
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_54AF::
    ld hl, $0781
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_54BA::
    ld hl, wC923
    inc [hl]
    ret

Jump_073_54BF::
    ld hl, $0780
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_54CA::
    ld a, [wCB8A]
    cp a, $50
    jr z, Jump_073_54E6
    xor a, a
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_073_54E6::
    xor a, a
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $03
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5509::
    ldh a, [hFF8E]
    cp a, $40
    jr nz, Jump_073_5515
    ldh a, [hFF91]
    cp a, $40
    jr z, Jump_073_5541

Jump_073_5515::
    ld a, [wC6FD]
    or a, a
    jr z, Jump_073_5535
    ld b, a
    ld hl, wC8F0

Jump_073_551F::
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, Jump_073_552A
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_5540

Jump_073_552A::
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_073_5532
    inc h

Jump_073_5532::
    dec b
    jr nz, Jump_073_551F

Jump_073_5535::
    ld a, $02
    ld [wCB86], a
    ld a, $02
    ld [wC923], a
    ret

Jump_073_5540::
    pop hl

Jump_073_5541::
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4F38)
; reads: wC923
Func_073_5546::
    ld a, [wC923]
    rst $00
    dw Jump_073_555E
    dw Jump_073_554E

Jump_073_554E::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_555E::
    ld a, $05
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $20
    ld [wCBD4], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4F00)
; reads: wC923
; writes: hFF90, hFF8F, hFF92, wC8C8, wC8C9, wC8C6, wC919
Func_073_5577::
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_559E
    ld a, $A9
    ldh [hFF90], a
    ld a, $01
    ldh [hFF8F], a
    xor a, a
    ldh [hFF92], a
    ld a, $60
    ld [wC8C8], a
    ld a, $10
    ld [wC8C9], a
    ld a, $02
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_559E::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4EF9)
; reads: hFFC6
; writes: hFFC6, hFFC7, wC919
Func_073_55A4::
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $07
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4EEB)
; reads: wC923
Func_073_55C5::
    ld a, [wC923]
    rst $00
    dw Jump_073_5659
    dw Jump_073_7AC6
    dw Jump_073_562C
    dw Jump_073_55D1

Jump_073_55D1::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [wCB8B]
    sub a, h
    ld [wCB8B], a
    ld a, [wCB9B]
    sub a, h
    ld [wCB9B], a
    ld a, $00
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $C0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $C0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wC919], a
    ret

Jump_073_562C::
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld a, $01
    ld [wCB96], a
    ld a, [wCB9A]
    cp a, $60
    jr z, Jump_073_5643
    inc a
    ld [wCB9A], a
    ret

Jump_073_5643::
    ld hl, wCB9C
    call Func_073_7A4C
    ld hl, $0300
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5659::
    ld a, $02
    ldh [hFFC6], a
    ld a, $40
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ld a, [wCBAB]
    cp a, $40
    jr z, Jump_073_5670
    ld a, $30

Jump_073_5670::
    ld [wCBBB], a
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, [wCB7D]
    dec a
    dec a
    ld [wCB7D], a
    xor a, a
    ld [wCB96], a
    ld hl, $0725
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4EE4)
; reads: wC923
Func_073_568E::
    ld a, [wC923]
    rst $00
    dw Jump_073_56F6
    dw Jump_073_56DB
    dw Jump_073_56BD
    dw Jump_073_569A

Jump_073_569A::
    ld a, [wCBAB]
    dec a
    ld [wCBAB], a
    ld a, [wCB9B]
    dec a
    ld [wCB9B], a
    cp a, $50
    ret nz
    ld hl, wCB9C
    call Func_073_7A4C
    ld hl, wCBAC
    call Func_073_7A4C
    ld a, $80
    ld [wC919], a
    ret

Jump_073_56BD::
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    ld a, [wCB9A]
    inc a
    ld [wCB9A], a
    cp a, $60
    ret nz
    ld a, $02
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_56DB::
    ld a, [wCB9A]
    inc a
    ld [wCB9A], a
    ld a, [wCBAB]
    dec a
    ld [wCBAB], a
    cp a, $60
    ret nz
    ld a, $01
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_56F6::
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld hl, wCBAC
    call SetBit2AtHL_B73
    ld a, [wCBAB]
    dec a
    ld [wCBAB], a
    ld a, [wCB9B]
    dec a
    ld [wCB9B], a
    cp a, $60
    ret nz
    ld a, $01
    ld [wCB96], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E20)
; reads: wC923
Func_073_571D::
    ld a, [wC923]
    rst $00
    dw Func_073_619B
    dw Func_073_619B
    dw Func_073_619B
    dw Jump_073_5729

Jump_073_5729::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E19)
; reads: wC923
; writes: hFF90, hFF8F, hFF92, wC8C8, wC8C9, wC8C6, wC919
Func_073_572F::
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_575B
    ld a, $28
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ld a, $01
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $04
    call Func_000_0DF2
    ret

Jump_073_575B::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E0B)
; reads: wC923
Func_073_5761::
    ld a, [wC923]
    rst $00
    dw Jump_073_5873
    dw Jump_073_5873
    dw Jump_073_5873
    dw Jump_073_5825
    dw Jump_073_57EA
    dw Jump_073_57C5
    dw Jump_073_5773

Jump_073_5773::
    ld hl, wC240
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wC254
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [wC6FD]
    dec a
    jr z, Jump_073_57B0
    ld hl, wC266
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wC27A
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [wC6FD]
    dec a
    dec a
    jr z, Jump_073_57B0
    ld hl, wC290
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wC2A4
    ld [hl], $2D
    inc hl
    ld [hl], $2E

Jump_073_57B0::
    farcall Func_05F_6DDB
    ld a, $01
    ld [wC94D], a
    xor a, a
    ld [wC195], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_57C5::
    ld a, [wC8FB]
    cp a, $60
    jr z, Jump_073_57D1
    ld hl, wC8FB
    inc [hl]
    ret

Jump_073_57D1::
    ld a, $01
    ld [wC8F9], a
    ld a, [wC8FA]
    inc a
    ld [wC8FA], a
    cp a, $40
    ret nz
    ld a, $02
    ld [wC8F9], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_57EA::
    ld a, [wC8F5]
    cp a, $30
    jr z, Jump_073_57FC
    ld a, [wC8F5]
    dec a
    ld [wC8F5], a
    ld [wC8FA], a
    ret

Jump_073_57FC::
    xor a, a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a
    ld [wC8FB], a
    cp a, $50
    ret nz
    ld a, $01
    ld [wC8F4], a
    ld hl, wC923
    inc [hl]
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $06
    ld [wC923], a
    ret

Jump_073_5825::
    ld a, [wC8F1]
    cp a, $40
    jr z, Jump_073_5845
    ld a, $02
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F1]
    dec a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ret

Jump_073_5845::
    ld a, $03
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    cp a, $40
    ret nz
    xor a, a
    ld [wC8EF], a
    ld hl, wC923
    inc [hl]
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $06
    ld [wC923], a
    ret

Jump_073_5873::
    farcall Func_012_61EF
    ret

; 1 call site from 1 routine (e.g. Func_010_4E04)
; reads: wC923
Func_073_587A::
    ld a, [wC923]
    rst $00
    dw Jump_073_58E0
    dw Jump_073_6C0C
    dw Jump_073_58BC
    dw Jump_073_58B1
    dw Jump_073_5888

Jump_073_5888::
    ld hl, wCBD3
    inc [hl]
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $2C
    ldh [hFFC6], a
    farcall Func_012_7DCE
    farcall Func_012_7DF1
    ld a, $80
    ld [wC919], a
    ret

Jump_073_58B1::
    ld b, $5A
    call Func_073_7A2B
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_073_58BC::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_58E0::
    ld a, $10
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $50
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4DEF)
; reads: hFFC6
; writes: hFFC6, hFFC7, wCB7D, wC919
Func_073_58FE::
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wCB7D], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4DE8)
; reads: wC921
; writes: wCB9B, wC921, hFFC6, wC919
Func_073_5919::
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_073_5926
    bit 1, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5926::
    cp a, $3C
    jr nc, Jump_073_5930
    bit 2, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5930::
    bit 3, a
    jr z, Jump_073_5936
    jr Jump_073_593D

Jump_073_5936::
    ld a, $20
    ld [wCB9B], a
    jr Jump_073_5942

Jump_073_593D::
    ld a, $E0
    ld [wCB9B], a

Jump_073_5942::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    ld a, $20
    ld [wCB9B], a
    ld a, $36
    ldh [hFFC6], a
    farcall Func_012_7DCE
    farcall Func_012_7DF1
    ld a, $37
    ldh [hFFC6], a
    farcall Func_012_7DCE
    farcall Func_012_7DF1
    ld a, $38
    ldh [hFFC6], a
    farcall Func_012_7DCE
    farcall Func_012_7DF1
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 2 routines (e.g. Func_010_4DD3, Func_010_4DDA)
; reads: wC923
Func_073_5987::
    ld a, [wC923]
    rst $00
    dw Jump_073_59E6
    dw Jump_073_59AF
    dw Jump_073_5991

Jump_073_5991::
    farcall Func_012_6990
    ld a, $05
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_59AF::
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ldh a, [hFF91]
    dec a
    ldh [hFF91], a
    cp a, $C0
    ret nz
    ld hl, hFF8C
    call Func_073_7A4C
    ld a, $19
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_59E6::
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $00
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4DC5)
; reads: wC923
Func_073_5A16::
    ld a, [wC923]
    rst $00
    dw Jump_073_5A48
    dw Jump_073_5A3D
    dw Jump_073_7AC6
    dw Jump_073_5A22

Jump_073_5A22::
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wCB7D], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_5A3D::
    ld hl, $0480
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5A48::
    ld a, $1C
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E3C)
; reads: hFF8E, wC6FD, wC92C
; writes: wC92A, wC928, wC929, wC919
; points at: wC8F0
Func_073_5A57:: ; heuristic: follows a terminator; C0
    ldh a, [hFF8E]
    cp a, $40
    jr z, Jump_073_5A9C
    cp a, $60
    jr z, Jump_073_5A90
    ld a, [wC6FD]
    ld b, a
    ld hl, wC8F0

Jump_073_5A68::
    push hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A77
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A85
    pop hl
    jr Jump_073_5A9C

Jump_073_5A77::
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_5A85
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_5A85
    pop hl
    jr Jump_073_5A90

Jump_073_5A85::
    pop hl
    ld a, $05
    add a, l
    ld l, a
    jr nc, Jump_073_5A8D
    inc h

Jump_073_5A8D::
    dec b
    jr nz, Jump_073_5A68

Jump_073_5A90::
    ld a, $03
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    jr Jump_073_5AA6

Jump_073_5A9C::
    ld a, $01
    ld [wC92A], a
    ld a, $60
    ld [wC928], a

Jump_073_5AA6::
    xor a, a
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4DBE)
; reads: hFFC6
; writes: hFFC6, hFFC7, wCB7D, wC919
Func_073_5ABB::
    xor a, a
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wCB7D], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4DB7)
; reads: wCC3B
; writes: wCC3B, wC919
Func_073_5AD6::
    ld a, [wCC3B]
    set 2, a
    ld [wCC3B], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4DB0)
; reads: wC923
Func_073_5AE4::
    ld a, [wC923]
    rst $00
    dw Jump_073_5C1F
    dw Jump_073_5BAE
    dw Func_073_5B66
    dw Jump_073_5B47
    dw Jump_073_5AF2

Jump_073_5AF2::
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wCB7D], a
    ld a, [wCC3B]
    set 1, a
    ld [wCC3B], a
    ld a, $66
    call StoreWC60B
    ld hl, wC19A
    ld [hl], $56
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $58
    inc hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_073_5B2A
    inc h

Jump_073_5B2A::
    ld [hl], $59
    inc hl
    ld [hl], $5A
    inc hl
    ld [hl], $5A
    inc hl
    ld [hl], $5B
    farcall Func_05F_6DDB
    ld de, $00B1
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

Jump_073_5B47::
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_073_5B66)
; reads: wC922, wC921, wCB8B, wCB8A
; writes: wC921
; points at: wCB8B, wC923, wCB8A
Func_073_5B66::
    ld a, [wC922]
    or a, a
    jr nz, Jump_073_5B72
    ld hl, wCB8B
    inc [hl]
    jr Jump_073_5B88

Jump_073_5B72::
    dec a
    jr nz, Jump_073_5B7B
    ld hl, wCB8A
    inc [hl]
    jr Jump_073_5B88

Jump_073_5B7B::
    dec a
    jr nz, Jump_073_5B84
    ld hl, wCB8B
    dec [hl]
    jr Jump_073_5B88

Jump_073_5B84::
    ld hl, wCB8A
    dec [hl]

Jump_073_5B88::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $10
    ret nz
    xor a, a
    ld [wC921], a
    ld a, [wCB8B]
    cp a, $30
    jr nz, Jump_073_5BA9
    ld a, [wCB8A]
    cp a, $80
    jr nz, Jump_073_5BA9
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5BA9::
    ld hl, wC923
    dec [hl]
    ret

Jump_073_5BAE::
    ld a, [wC924]
    ld d, a
    ld a, [wCB8A]
    add a, d
    ld b, a
    ld a, [wC925]
    ld d, a
    ld a, [wCB8B]
    add a, d
    ld c, a
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
    jr nc, Jump_073_5BD1
    inc h

Jump_073_5BD1::
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    jr nc, Jump_073_5BDF
    inc h

Jump_073_5BDF::
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
    jr nc, Jump_073_5BF3
    inc h

Jump_073_5BF3::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

Jump_073_5BFD::
    ld a, [de]
    inc de
    ld c, a
    ld a, [wC192]
    cp a, c
    jr c, Jump_073_5C08
    jr Jump_073_5C13

Jump_073_5C08::
    dec b
    jr nz, Jump_073_5BFD
    call Func_073_5B66
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5C13::
    ld hl, wCB8C
    call Func_073_7A4C
    ld a, $80
    ld [wC919], a
    ret

Jump_073_5C1F::
    ldh a, [hFF8E]
    swap a
    and a, $0F
    sub a, $05
    and a, $03
    sla a
    sla a
    ld hl, $5C4F
    add a, l
    ld l, a
    jr nc, Jump_073_5C35
    inc h

Jump_073_5C35::
    ld a, [hl+]
    ld [wC922], a
    ld [wCB86], a
    ld a, [hl+]
    ld [wC924], a
    ld a, [hl]
    ld [wC925], a
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, wC923
    inc [hl]
    ret
    db $03, $F0, $00, $00, $02, $00, $F0, $00, $00, $00, $10, $00, $01, $10, $00, $00

; 1 call site from 1 routine (e.g. Func_010_4DA9)
; reads: hFF8E, hFF91, wC1EA, wC1F8, wC28A, wC298, wCC3B
; writes: wCC3B, wC919
; points at: wC1EA, wC28A, wC298, wC1C8, wC1F8
Func_073_5C5F::
    ldh a, [hFF8E]
    cp a, $30
    jr nz, Jump_073_5C8D
    ldh a, [hFF91]
    cp a, $30
    jr nz, Jump_073_5C7F
    ld hl, wC1EA
    call Func_073_5D09
    ld hl, wC28A
    call Func_073_5D09
    ld hl, wC298
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5C7F::
    ld hl, wC28A
    call Func_073_5D09
    ld hl, wC298
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5C8D::
    ldh a, [hFF91]
    cp a, $30
    jr nz, Jump_073_5CA1
    ld hl, wC1F8
    call Func_073_5D09
    ld hl, wC28A
    call Func_073_5D09
    jr Jump_073_5CAD

Jump_073_5CA1::
    ld hl, wC1F8
    call Func_073_5D09
    ld hl, wC298
    call Func_073_5D09

Jump_073_5CAD::
    ld a, [wC1EA]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [wC1F8]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [wC28A]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, [wC298]
    cp a, $10
    jr nz, Jump_073_5CFD
    ld a, $66
    call StoreWC60B
    ld hl, wC1C8
    ld [hl], $46
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $48
    inc hl
    ld a, $10
    add a, l
    ld l, a
    jr nc, Jump_073_5CE4
    inc h

Jump_073_5CE4::
    ld [hl], $49
    inc hl
    ld [hl], $4A
    inc hl
    ld [hl], $4A
    inc hl
    ld [hl], $4B
    ld a, [wCC3B]
    set 0, a
    ld [wCC3B], a
    ld de, $00B0
    call SetFlagBit

Jump_073_5CFD::
    farcall Func_05F_6DDB
    ld a, $80
    ld [wC919], a
    ret

; 9 call sites from 1 routine (e.g. Func_073_5C5F)
; reads: wIsCGB
; writes: rSVBK
Func_073_5D09::
    push hl
    call Func_073_5D48
    call Func_073_5D48
    call Func_073_5D48
    call Func_073_5D48
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $04
    ld a, [hl]
    cp a, $18
    ld c, $05
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    call Func_073_5D65
    call Func_073_5D65
    call Func_073_5D65
    call Func_073_5D65
    ld a, $00
    ldh [rSVBK], a
    ret

; 4 call sites from 1 routine (e.g. Func_073_5D09)
Func_073_5D48::
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, Jump_073_5D51
    sub a, $18

Jump_073_5D51::
    ld [hl+], a
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, Jump_073_5D5B
    sub a, $18

Jump_073_5D5B::
    ld [hl-], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_073_5D63
    inc h

Jump_073_5D63::
    ld a, [hl]
    ret

; 4 call sites from 1 routine (e.g. Func_073_5D09)
Func_073_5D65::
    ld a, c
    ld [hl+], a
    ld [hl-], a
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_073_5D6F
    inc h

Jump_073_5D6F::
    ld a, [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E35)
; reads: hFF90, hFF8F, hFFC6
; writes: hFFC6, hFFC7, wCB7D, wC919
Func_073_5D71:: ; heuristic: follows a terminator; C0
    xor a, a
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    ldh a, [hFF90]
    cp a, $8C
    jr z, Jump_073_5D88
    ldh a, [hFF8F]
    cp a, $01
    jr nz, Jump_073_5D88
    ld a, $50
    ldh [hFFC7], a

Jump_073_5D88::
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wCB7D], a
    ld a, $80
    ld [wC919], a
    ld de, $00C5
    ldh a, [hFF90]
    cp a, $8C
    jr z, Jump_073_5DAB
    inc de
    ldh a, [hFF8F]
    or a, a
    jr z, Jump_073_5DAB
    inc de

Jump_073_5DAB::
    call SetFlagBit
    ret

; 1 call site from 1 routine (e.g. Func_010_4DA2)
; reads: wC923
; writes: hFF90, hFF8F, hFF92, wC8C8, wC8C9, wC8C6, wC919
Func_073_5DAF::
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_5DD7
    ld a, $82
    ldh [hFF90], a
    ld a, $01
    ldh [hFF8F], a
    ld a, $02
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_5DD7::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D9B)
; reads: wC923
Func_073_5DDD::
    ld a, [wC923]
    rst $00
    dw Jump_073_5E97
    dw Jump_073_5E51
    dw Jump_073_5E11
    dw Jump_073_5DF8
    dw Jump_073_5DED
    dw Func_073_7AD0

Jump_073_5DED::
    ld hl, $0433
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5DF8::
    xor a, a
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_5E11::
    ld hl, wCB8A
    inc [hl]
    ld a, [wC921]
    and a, $01
    jr nz, Jump_073_5E20
    ld hl, wCB8A
    inc [hl]

Jump_073_5E20::
    ld hl, wC921
    inc [hl]
    call Func_073_5E73
    add a, $10
    ldh [hFF91], a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ld a, [wCB8A]
    ldh [hFF8E], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld a, [wCB8B]
    cp a, $C0
    ret c
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_5E51::
    ld hl, wCB8A
    inc [hl]
    ld a, [wC921]
    and a, $01
    jr nz, Jump_073_5E60
    ld hl, wCB8A
    inc [hl]

Jump_073_5E60::
    ld hl, wC921
    inc [hl]
    call Func_073_5E73
    cp a, $70
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 2 call sites from 1 routine (e.g. Func_073_5DDD)
; reads: wC924, wC925, wCB8B
; writes: wC924, wC925, wCB8B
Func_073_5E73::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    sub a, $18
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [wC925]
    ld h, a
    ld a, [wCB8B]
    add a, h
    ld [wCB8B], a
    ret

Jump_073_5E97::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, $05C0
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D94)
; reads: wC923
Func_073_5EB3::
    ld a, [wC923]
    rst $00
    dw Jump_073_5F1D
    dw Jump_073_5EDF
    dw Jump_073_5EBD

Jump_073_5EBD::
    ld hl, wCB8A
    dec [hl]
    ld hl, wC921
    inc [hl]
    call Func_073_5EF9
    add a, $10
    ld [wCB9B], a
    ld a, [wCB8A]
    ld [wCB9A], a
    ld a, [wCB8A]
    cp a, $E0
    ret nz
    ld a, $80
    ld [wC919], a
    ret

Jump_073_5EDF::
    ld hl, wCB8A
    dec [hl]
    ld hl, wC921
    inc [hl]
    call Func_073_5EF9
    ld a, [wCB8A]
    cp a, $40
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 2 call sites from 1 routine (e.g. Func_073_5EB3)
; reads: wC924, wC925, wCB8B
; writes: wC924, wC925, wCB8B
Func_073_5EF9::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [wC925]
    ld h, a
    ld a, [wCB8B]
    add a, h
    ld [wCB8B], a
    ret

Jump_073_5F1D::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, wCB8C
    call SetBit2AtHL_B73
    ld hl, $03C0
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D8D)
; writes: wC919
; points at: wC26A, wC27E
Func_073_5F39::
    ld hl, wC26A
    ld [hl], $68
    inc hl
    ld [hl], $69
    ld hl, wC27E
    ld [hl], $6A
    inc hl
    ld [hl], $6B
    farcall Func_05F_6DDB
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wC6FD, wCBB6, wCBBA, wCBBB
; writes: hFFC7, hFFC8, hFFC9, wC527, wC919
; points at: wC6FD, wC8EF, wC6FE, wCB7D
Func_073_5F55:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $02
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld hl, wC6FD
    inc [hl]
    ld a, [wC6FD]
    dec a
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, wC8EF
    add a, l
    ld l, a
    jr nc, Jump_073_5F7C
    inc h

Jump_073_5F7C::
    ld a, [wCBB6]
    ld [hl+], a
    ld a, [wCBBA]
    ld [hl+], a
    ld a, [wCBBB]
    ld [hl], a
    ld a, [wC6FD]
    dec a
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_073_5F94
    inc h

Jump_073_5F94::
    ld a, [wD7F5]
    ld [hl], a
    farcall Func_002_5E85
    farcall Func_002_5E85
    call Func_000_222B
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld hl, wCB7D
    dec [hl]
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D78)
; reads: wC923
Func_073_5FBC::
    ld a, [wC923]
    rst $00
    dw Jump_073_5FE4
    dw Jump_073_5FC4

Jump_073_5FC4::
    ld a, $80
    ld [wCBCF], a
    ld a, [wC921]
    and a, $03
    jr nz, Jump_073_5FD4
    ld hl, wCBD4
    dec [hl]

Jump_073_5FD4::
    ld b, $5A
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_5FE4::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld hl, $6020
    ld de, $00D1
    call TestFlagBit
    jr nc, Jump_073_5FFC
    ld hl, $602C

Jump_073_5FFC::
    ldh a, [hFF90]
    ld c, a

Jump_073_5FFF::
    push hl
    ld a, [hl]
    cp a, c
    jr nz, Jump_073_601B
    inc hl
    ld a, [hl]
    and a, $F0
    ld [wCBD3], a
    ld a, [hl]
    and a, $0F
    swap a
    add a, $F8
    ld [wCBD4], a
    pop hl
    ld hl, wC923
    inc [hl]
    ret

Jump_073_601B::
    pop hl
    inc hl
    inc hl
    jr Jump_073_5FFF
    db $06, $31, $12, $44, $00, $63, $02, $24, $16, $53, $1A, $43, $06, $31, $12, $44
    db $00, $53, $02, $24, $16, $42, $1A, $43

; 1 call site from 1 routine (e.g. Func_010_4D55)
; reads: wC923
Func_073_6038::
    ld a, [wC923]
    rst $00
    dw Jump_073_604F
    dw Jump_073_6040

Jump_073_6040::
    ld a, [wC921]
    and a, $01
    jr z, Jump_073_604B
    ld hl, wCB8B
    inc [hl]

Jump_073_604B::
    call Func_073_4E9C
    ret

Jump_073_604F::
    ld hl, wCB8C
    call Func_073_7A3D
    ld b, $1E
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ld de, $0098
    call TestFlagBit
    jr c, Jump_073_6072
    ld de, $0098
    call SetFlagBit
    ret

Jump_073_6072::
    ld de, $0099
    call SetFlagBit
    ret

; 1 call site from 1 routine (e.g. Func_010_4D40)
; reads: wC923
Func_073_6079::
    ld a, [wC923]
    rst $00
    dw Jump_073_60CD
    dw Jump_073_60A7
    dw Jump_073_6083

Jump_073_6083::
    ld b, $78
    call Func_073_7A2B
    ret nc
    ld a, $40
    ld [wCBAB], a
    ld a, $50
    ld [wCB9B], a
    xor a, a
    ld [wCBCF], a
    ld a, $03
    ld [wCB7D], a
    ld a, $00
    call StoreWC60B
    ld a, $80
    ld [wC919], a
    ret

Jump_073_60A7::
    ld a, [wCBAB]
    inc a
    inc a
    ld [wCBAB], a
    ld a, [wCB9B]
    dec a
    dec a
    ld [wCB9B], a
    cp a, $48
    ret nz
    xor a, a
    ld [wCB7D], a
    ld a, $80
    ld [wCBCF], a
    ld a, $7D
    call StoreWC60B
    ld hl, wC923
    inc [hl]
    ret

Jump_073_60CD::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld hl, wCBAB
    dec [hl]
    ld a, [wCB9B]
    inc a
    ld [wCB9B], a
    cp a, $58
    ret nz
    ld a, $0C
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $48
    ld [wCBD4], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D1D)
; reads: wC5F0, wCB9B
; writes: wCB7D, wCB9B, wC919
Func_073_60FE::
    ld a, [wC5F0]
    bit 2, a
    jr z, Jump_073_610C
    ld a, $01
    ld [wCB7D], a
    jr Jump_073_6111

Jump_073_610C::
    ld a, $02
    ld [wCB7D], a

Jump_073_6111::
    ld a, [wCB9B]
    inc a
    ld [wCB9B], a
    cp a, $70
    ret nz
    ld a, $02
    ld [wCB7D], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D16)
; reads: wC923
Func_073_6126::
    ld a, [wC923]
    rst $00
    dw Jump_073_618F
    dw Jump_073_6188
    dw Jump_073_6181
    dw Jump_073_6132

Jump_073_6132::
    ld a, [wC925]
    swap a
    and a, $0F
    sla a
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    ld a, [wC924]
    swap a
    and a, $0F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_073_6153
    inc h

Jump_073_6153::
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    push hl
    ld [hl], $44
    inc hl
    ld [hl], $45
    ld a, $13
    add a, l
    ld l, a
    jr nc, Jump_073_6168
    inc h

Jump_073_6168::
    ld [hl], $46
    inc hl
    ld [hl], $47
    pop hl
    farcall Func_05F_6DDB
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wC195], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_6181::
    farcall Func_012_5B9A
    ret

Jump_073_6188::
    farcall Func_012_5C27
    ret

Jump_073_618F::
    ld a, $10
    ld [wC195], a
    farcall Func_012_5C31
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC195
Func_073_619B:: ; heuristic: follows a terminator; C0
    ld a, $10
    ld [wC195], a
    farcall Func_012_61EF
    ret

; 1 call site from 1 routine (e.g. Func_010_4D0F)
; reads: wC923
Func_073_61A7::
    ld a, [wC923]
    rst $00
    dw Jump_073_62D7
    dw Jump_073_62B0
    dw Jump_073_628C
    dw Jump_073_625D
    dw Jump_073_6252
    dw Jump_073_622D
    dw Jump_073_7AC6
    dw Jump_073_620B
    dw Jump_073_7AC6
    dw Jump_073_61BF

Jump_073_61BF::
    ld a, $80
    ld [wC919], a
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wCB96], a
    ld de, $0191
    call TestFlagBit
    jr c, Jump_073_61EC
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_073_61E0
    or a, a
    jr z, Jump_073_61E0
    ret

Jump_073_61E0::
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_61EC::
    farcall Func_012_6990
    ld a, $04
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld de, $0135
    call SetFlagBit
    ret

Jump_073_620B::
    ld de, $0191
    call TestFlagBit
    jr c, Jump_073_6218
    ld hl, $0D3F
    jr Jump_073_621B

Jump_073_6218::
    ld hl, $0D4B

Jump_073_621B::
    call StoreHLInWC924_B73b
    ld a, $00
    ld [wCB96], a
    ld a, $02
    ld [wCBB6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_622D::
    ld a, [wC921]
    swap a
    and a, $01
    add a, a
    inc a
    ld [wCBB6], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld hl, $0D3E
    call StoreHLInWC924_B73b
    ret

Jump_073_6252::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_073_625D::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, [wC937]
    ld [hl+], a
    ld a, [wC938]
    ld [hl+], a
    ld a, [wC939]
    ld [hl], a
    ld hl, $00B9
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_05F_6D3F
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_628C::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr z, Jump_073_62A2
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_62A2::
    dec hl
    dec hl
    ld [hl], $01
    ld a, $50
    ld [wCBBB], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_62B0::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_62C6
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_62C6::
    dec hl
    ld a, [hl]
    cp a, $20
    jr z, Jump_073_62D2
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Jump_073_62D2::
    ld hl, wC923
    inc [hl]
    ret

Jump_073_62D7::
    ld hl, $00B9
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8EF
    add a, l
    ld l, a
    jr nc, Jump_073_62F6
    inc h

Jump_073_62F6::
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [hl+]
    ld [wC937], a
    ld a, [hl+]
    ld [wC938], a
    ld a, [hl]
    ld [wC939], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D08)
; reads: wC923
Func_073_630F::
    ld a, [wC923]
    rst $00
    dw Jump_073_653D
    dw Jump_073_651C
    dw Jump_073_64FF
    dw Jump_073_64DC
    dw Jump_073_64BA
    dw Jump_073_649E
    dw Jump_073_647A
    dw Jump_073_651C
    dw Jump_073_645D
    dw Jump_073_64DC
    dw Jump_073_64BA
    dw Jump_073_6441
    dw Jump_073_647A
    dw Jump_073_640A
    dw Jump_073_63FF
    dw Jump_073_63DA
    dw Jump_073_7AC6
    dw Jump_073_6387
    dw Jump_073_7AC6
    dw Jump_073_633B

Jump_073_633B::
    ld a, $80
    ld [wC919], a
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld de, $0134
    call TestFlagBit
    jr c, Jump_073_6368
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_073_635C
    or a, a
    jr z, Jump_073_635C
    ret

Jump_073_635C::
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ret

Jump_073_6368::
    farcall Func_012_6990
    ld a, $04
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld de, $0135
    call SetFlagBit
    ret

Jump_073_6387::
    ld de, $0134
    call TestFlagBit
    jr c, Jump_073_6394
    ld hl, $0D46
    jr Jump_073_6397

Jump_073_6394::
    ld hl, $0D16

Jump_073_6397::
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ld a, [wCB9A]
    cp a, $50
    jr nz, Jump_073_63B0
    ld a, $03
    ld [wCB86], a
    ld a, $01
    ld [wCB96], a
    ret

Jump_073_63B0::
    cp a, $70
    jr nz, Jump_073_63BF
    ld a, $01
    ld [wCB86], a
    ld a, $03
    ld [wCB96], a
    ret

Jump_073_63BF::
    ld a, [wCB9B]
    cp a, $20
    jr nz, Jump_073_63D0
    ld a, $02
    ld [wCB86], a
    xor a, a
    ld [wCB96], a
    ret

Jump_073_63D0::
    xor a, a
    ld [wCB86], a
    ld a, $02
    ld [wCB96], a
    ret

Jump_073_63DA::
    ld a, [wC921]
    swap a
    and a, $01
    add a, a
    inc a
    ld [wCB96], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld hl, $0D15
    call StoreHLInWC924_B73b
    ret

Jump_073_63FF::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_073_640A::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, [wC937]
    ld [hl+], a
    ld a, [wC938]
    ld [hl+], a
    ld a, [wC939]
    ld [hl], a
    ld hl, $005A
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_05F_6D3F
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wCB96], a
    ld hl, wCB7D
    inc [hl]
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6441::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_6459
    ld a, $50
    ld [wCB9A], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6459::
    call Func_073_65A4
    ret

Jump_073_645D::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, Jump_073_6476
    ld a, $20
    ld [wCB9B], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6476::
    call Func_073_659D
    ret

Jump_073_647A::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_6494
    ld a, $30
    ld [wCB9B], a
    ld a, $0D
    ld [wC923], a
    ret

Jump_073_6494::
    jr nc, Jump_073_649A
    call Func_073_6596
    ret

Jump_073_649A::
    call Func_073_659D
    ret

Jump_073_649E::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, Jump_073_64B6
    ld a, $70
    ld [wCB9A], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_64B6::
    call Func_073_65AA
    ret

Jump_073_64BA::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, Jump_073_64CE

Jump_073_64C9::
    ld hl, wC923
    inc [hl]
    ret

Jump_073_64CE::
    cp a, $40
    jr z, Jump_073_64C9
    jr nc, Jump_073_64D8
    call Func_073_6596
    ret

Jump_073_64D8::
    call Func_073_659D
    ret

Jump_073_64DC::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_64F5
    ld a, $60
    ld [wCB9A], a
    ld a, $0D
    ld [wC923], a
    ret

Jump_073_64F5::
    jr nc, Jump_073_64FB
    call Func_073_65AA
    ret

Jump_073_64FB::
    call Func_073_65A4
    ret

Jump_073_64FF::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6518
    ld a, $40
    ld [wCB9B], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6518::
    call Func_073_6596
    ret

Jump_073_651C::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, Jump_073_652F

Jump_073_652A::
    ld hl, wC923
    inc [hl]
    ret

Jump_073_652F::
    cp a, $50
    jr z, Jump_073_652A
    jr nc, Jump_073_6539
    call Func_073_65AA
    ret

Jump_073_6539::
    call Func_073_65A4
    ret

Jump_073_653D::
    ld hl, $005A
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8EF
    add a, l
    ld l, a
    jr nc, Jump_073_655C
    inc h

Jump_073_655C::
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [hl+]
    ld [wC937], a
    ld a, [hl+]
    ld [wC938], a
    ld a, [hl]
    ld [wC939], a
    ld hl, wCB7D
    dec [hl]
    ldh a, [hFF98]
    or a, a
    jr nz, Jump_073_657E
    ld hl, wC923
    inc [hl]
    ret

Jump_073_657E::
    dec a
    jr nz, Jump_073_6587
    ld a, $04
    ld [wC923], a
    ret

Jump_073_6587::
    dec a
    jr nz, Jump_073_6590
    ld a, $07
    ld [wC923], a
    ret

Jump_073_6590::
    ld a, $0A
    ld [wC923], a
    ret

; 3 call sites from 1 routine (e.g. Func_073_630F)
Func_073_6596::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

; 3 call sites from 1 routine (e.g. Func_073_630F)
Func_073_659D::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; 3 call sites from 1 routine (e.g. Func_073_630F)
Func_073_65A4::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; 3 call sites from 1 routine (e.g. Func_073_630F)
Func_073_65AA::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

; 1 call site from 1 routine (e.g. Func_010_4CFA)
; reads: wC923
Func_073_65B0::
    ld a, [wC923]
    rst $00
    dw Jump_073_6729
    dw Jump_073_6705
    dw Jump_073_66EA
    dw Jump_073_66D1
    dw Jump_073_66B6
    dw Jump_073_6688
    dw Jump_073_666A
    dw Jump_073_66D1
    dw Jump_073_664F
    dw Jump_073_6618
    dw Jump_073_65ED
    dw Jump_073_65CC

Jump_073_65CC::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, $80
    ld [wC919], a
    ret

Jump_073_65ED::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, [wC937]
    ld [hl+], a
    ld a, [wC938]
    ld [hl+], a
    ld a, [wC939]
    ld [hl], a
    ld hl, $0002
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_05F_6D3F
    xor a, a
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6618::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6641
    dec hl
    ld [hl], $02
    ld a, $02
    ld [wCB86], a
    ld a, $40
    ld [wCB8A], a
    ld a, $50
    ld [wCB8B], a
    ld a, $0E
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6641::
    jr nc, Jump_073_6649
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_6649::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Jump_073_664F::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_6663
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6663::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

Jump_073_666A::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_073_667C
    cp a, $50
    jr nz, Jump_073_6682

Jump_073_667C::
    ld a, $07
    ld [wC923], a
    ret

Jump_073_6682::
    ld a, $08
    ld [wC923], a
    ret

Jump_073_6688::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_66A8
    dec hl
    ld [hl], $00
    ld a, $40
    ld [wCB8A], a
    ld a, $0E
    ldh [hFF8D], a
    ld a, $0A
    ld [wC923], a
    ret

Jump_073_66A8::
    jr nc, Jump_073_66B0
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_66B0::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

Jump_073_66B6::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_66CA
    ld hl, wC923
    inc [hl]
    ret

Jump_073_66CA::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

Jump_073_66D1::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
    jr nz, Jump_073_66E4
    ld hl, wC923
    inc [hl]
    ret

Jump_073_66E4::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

Jump_073_66EA::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, Jump_073_66FE
    ld hl, wC923
    inc [hl]
    ret

Jump_073_66FE::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

Jump_073_6705::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, Jump_073_6719
    ld a, $02
    ld [wC923], a
    ret

Jump_073_6719::
    cp a, $50
    jr nz, Jump_073_6723
    ld a, $03
    ld [wC923], a
    ret

Jump_073_6723::
    ld a, $04
    ld [wC923], a
    ret

Jump_073_6729::
    ld hl, $0002
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall Func_012_7D95
    ldh a, [hFFC6]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8EF
    add a, l
    ld l, a
    jr nc, Jump_073_6748
    inc h

Jump_073_6748::
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, [hl+]
    ld [wC937], a
    ld a, [hl+]
    ld [wC938], a
    ld a, [hl]
    ld [wC939], a
    ldh a, [hFF91]
    cp a, $50
    jr nz, Jump_073_6767

Jump_073_6762::
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6767::
    ldh a, [hFF91]
    cp a, $30
    jr nz, Jump_073_6773

Jump_073_676D::
    ld a, $06
    ld [wC923], a
    ret

Jump_073_6773::
    ld hl, wC924
    inc hl
    inc hl
    ld a, [wC924]
    cp a, $40
    jr z, Jump_073_6783
    jr c, Jump_073_676D
    jr Jump_073_6762

Jump_073_6783::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC8F0

Jump_073_678A::
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, Jump_073_6798
    ld a, [hl]
    cp a, $30
    jr nz, Jump_073_6798
    pop hl
    jr Jump_073_676D

Jump_073_6798::
    pop hl
    dec b
    jr nz, Jump_073_678A
    jr Jump_073_6762
    db $C9

; 1 call site from 1 routine (e.g. Func_010_4CD7)
; reads: wC923
Func_073_679F::
    ld a, [wC923]
    rst $00
    dw Jump_073_6927
    dw Jump_073_691C
    dw Jump_073_6910
    dw Jump_073_68B8
    dw Jump_073_691C
    dw Jump_073_691C
    dw Jump_073_6896
    dw Jump_073_691C
    dw Jump_073_6931
    dw Jump_073_6910
    dw Jump_073_683F
    dw Jump_073_691C
    dw Jump_073_691C
    dw Jump_073_6835
    dw Jump_073_691C
    dw Jump_073_6931
    dw Jump_073_6910
    dw Jump_073_67FC
    dw Jump_073_691C
    dw Jump_073_691C
    dw Jump_073_67D5
    dw Jump_073_67CF

Jump_073_67CF::
    ld a, $80
    ld [wC919], a
    ret

Jump_073_67D5::
    ld a, [wCC39]
    set 1, a
    ld [wCC39], a
    ld a, $40
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ldh a, [hFF8E]
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_67FC::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $14
    jr nz, Jump_073_680F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]

Jump_073_680F::
    ld a, [wC921]
    bit 0, a
    jr z, Jump_073_6826
    ld de, $77D0
    ld b, $56
    call Func_073_6882
    ld de, $5ADB
    ld b, $56
    jp Func_073_6875

Jump_073_6826::
    ld de, $7827
    ld b, $56
    call Func_073_6882
    ld de, $5B8F
    ld b, $56
    jr Func_073_6875

Jump_073_6835::
    ld a, $05
    ldh [hFF8F], a
    ld a, $04
    ldh [hFF92], a
    jr Jump_073_689E

Jump_073_683F::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $14
    jr nz, Jump_073_6852
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]

Jump_073_6852::
    ld a, [wC921]
    bit 0, a
    jr z, Jump_073_6868
    ld de, $7ABA
    ld b, $56
    call Func_073_6882
    ld de, $61F0
    ld b, $56
    jr Func_073_6875

Jump_073_6868::
    ld de, $6D99
    ld b, $56
    call Func_073_6882
    ld de, $4301
    ld b, $56

; 1 call site from 1 routine (e.g. Func_073_6882)
; points at: wC198
Func_073_6875::
    ld hl, wC198
    call DecompressToVRAM
    farcall Func_05F_6DDB
    ret

; 5 call sites from 2 routines (e.g. Func_073_679F, Func_073_6882)
; reads: wIsCGB
; writes: rSVBK
; points at: wD000
Func_073_6882::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a
    ret

Jump_073_6896::
    ld a, $06
    ldh [hFF8F], a
    ld a, $05
    ldh [hFF92], a

Jump_073_689E::
    ld a, $30
    ldh [hFF90], a
    ldh a, [hFF8E]
    ld [wC8C8], a
    ld a, $E0
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_68B8::
    ld a, [wC921]
    ld b, a
    ld a, $06
    call Func_000_16BF
    add a, a
    add a, a
    ld hl, $68F8
    add a, l
    ld l, a
    jr nc, Jump_073_68CB
    inc h

Jump_073_68CB::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    push hl
    call Func_073_6875
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    call Func_073_6882
    farcall Func_05F_6DDB
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $09
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret
    db $06, $47, $42, $4C, $FB, $47, $CB, $4C, $EE, $48, $3C, $4D, $FB, $47
    dw Func_073_4CCB
    dw Func_073_4706
    dw Func_073_4C42
    dw Func_073_45FF
    dw Func_073_4BB3

Jump_073_6910::
    ld a, $B4
    ld [wC928], a
    farcall Func_00F_729C
    ret

Jump_073_691C::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6927::
    ld a, $02
    call Func_000_122D
    ld a, $70
    call StoreWC60B

Jump_073_6931::
    ld a, $48
    ld [wCB8A], a
    farcall Func_05F_6E09
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4CD0)
; reads: wCC39
; writes: wC242, wC243, wC256, wC257, wCC39, wC919
Func_073_6941::
    ld a, $58
    ld [wC242], a
    ld a, $59
    ld [wC243], a
    ld a, $5A
    ld [wC256], a
    ld a, $5B
    ld [wC257], a
    farcall Func_05F_6DDB
    ld a, [wCC39]
    set 0, a
    ld [wCC39], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4CC9)
; reads: wC923
Func_073_6969::
    ld a, [wC923]
    rst $00
    dw Jump_073_6A71
    dw Jump_073_6A2B
    dw Jump_073_6A0B
    dw Jump_073_69E3
    dw Jump_073_69C8
    dw Jump_073_69AB
    dw Jump_073_698E
    dw Jump_073_697F
    dw Func_073_4E9C

Jump_073_697F::
    ld a, [wC8FB]
    inc a
    ld [wC8FB], a
    cp a, $40
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Jump_073_698E::
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wC8FA], a
    ld a, $30
    ld [wC8FB], a
    xor a, a
    ld [wC8F9], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_69AB::
    ld a, [wC8F1]
    inc a
    ld [wC8F1], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wC8F5], a
    ld a, $30
    ld [wC8F6], a
    xor a, a
    ld [wC8F4], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_69C8::
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wC8F0], a
    ld a, $30
    ld [wC8F1], a
    xor a, a
    ld [wC8EF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_69E3::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $01
    ret nz
    ld a, [wCB8B]
    inc a
    ld [wCB8B], a
    cp a, $30
    ret nz
    ld a, $40
    ldh [hFF8E], a
    ld a, $30
    ldh [hFF91], a
    xor a, a
    ldh [hFF98], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6A0B::
    farcall Func_002_541B
    farcall Func_002_5BD7
    ld a, [wC468]
    bit 7, a
    ret nz
    xor a, a
    ld [wCB8B], a
    ld a, $01
    ld [wCB7D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6A2B::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $01
    ret nz
    ld a, [wCB8B]
    inc a
    ld [wCB8B], a
    cp a, $80
    ret nz
    ld a, $80
    ld [wC468], a
    ld a, $08
    ld [wC46A], a
    ld hl, hFF92
    inc [hl]
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, hFF80
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall Func_002_541B
    farcall Func_002_5BD7
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6A71::
    ld a, $30
    ldh [hFF90], a
    ld a, $05
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $E0
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; 1 call site from 1 routine (e.g. Func_010_4CB4)
; reads: wC923
Func_073_6A91::
    ld a, [wC923]
    rst $00
    dw Jump_073_6A99
    dw Jump_073_6AB8

Jump_073_6A99::
    ld a, $36
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_6AB8::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4CAD)
; reads: wC923
; writes: hFF90, hFF8F, hFF92, wC8C8, wC8C9, wC8C6, wC919
Func_073_6ABE::
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_6AE9
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_6AE9
    ld a, $3C
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $50
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    ld a, $04
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_6AE9::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4CA6)
; reads: wC923
; writes: wC919
Func_073_6AEF::
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_6AF9
    call Func_073_6B1F
    ret

Jump_073_6AF9::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C9F)
; reads: wC923
Func_073_6AFF::
    ld a, [wC923]
    rst $00
    dw Jump_073_6D22
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6CD1
    dw Jump_073_6CCA
    dw Func_073_6C77
    dw Jump_073_6B46
    dw Jump_073_7AC6
    dw Func_073_6B1F
    dw Jump_073_6B19

Jump_073_6B19::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_073_6AEF)
; writes: hFF90, hFF8F, hFF92, wC8C8, wC8C9, wC8C6
Func_073_6B1F::
    ld a, $41
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ld a, $01
    ldh [hFF92], a
    ld a, $70
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld de, $006F
    call SetFlagBit
    ret

Jump_073_6B46::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $01
    ld [wCB96], a
    ld hl, wC923
    inc [hl]
    ld hl, $0849
    call StoreHLInWC924_B73b
    ret

; 1 call site from 1 routine (e.g. Func_010_4C98)
; reads: wC923
Func_073_6B5B::
    ld a, [wC923]
    rst $00
    dw Jump_073_6D22
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6CD1
    dw Jump_073_6B87
    dw Jump_073_6B80
    dw Jump_073_6B77
    dw Jump_073_6B71

Jump_073_6B71::
    ld a, $80
    ld [wC919], a
    ret

Jump_073_6B77::
    call Func_073_6C77
    ld a, $E0
    ld [wCB9A], a
    ret

Jump_073_6B80::
    farcall Func_05F_6E58
    ret

Jump_073_6B87::
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld hl, hFF8C
    call Func_073_7A3D
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C91)
; reads: wC923
Func_073_6B98::
    ld a, [wC923]
    rst $00
    dw Jump_073_6D22
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6D1B
    dw Jump_073_6CD1
    dw Jump_073_6CCA
    dw Func_073_6C77
    dw Jump_073_6C3E
    dw Jump_073_6BB6
    dw Jump_073_6C21
    dw Jump_073_6C0C
    dw Jump_073_6BC6
    dw Jump_073_6BB6

Jump_073_6BB6::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $E0
    ld [wCB9A], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_6BC6::
    ld a, [wCBD3]
    inc a
    inc a
    ld [wCBD3], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wCBCF], a
    ld a, $2C
    ld [wC928], a
    farcall Func_05F_6C8C
    ld de, $006E
    call SetFlagBit
    ld hl, $0813
    call StoreHLInWC924_B73b
    xor a, a
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6C0C::
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    ld a, $65
    call StoreWC60B
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6C21::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $10
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $80
    ld [wCBCF], a
    ld a, $0E
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6C3E::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $01
    ld [wCB96], a
    ld hl, wC923
    inc [hl]
    ld de, $006E
    call TestFlagBit
    jr nc, Jump_073_6C5B
    ld hl, $0815
    call StoreHLInWC924_B73b
    ret

Jump_073_6C5B::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_073_6C6C
    or a, a
    jr z, Jump_073_6C6C
    ld hl, $0814
    call StoreHLInWC924_B73b
    ret

Jump_073_6C6C::
    ld hl, $0812
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_073_6B5B)
; reads: hFF8E
; writes: wC8EF, wC8F4, wC8F9, hFF98, hFF8E, wC921, wCB9A
; points at: hFF8C, wC8F0, wC8F6, wC8FB, wC923
Func_073_6C77::
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld a, $03
    ld [wC8EF], a
    xor a, a
    ld [wC8F4], a
    ld a, $02
    ld [wC8F9], a
    ld a, $01
    ldh [hFF98], a
    ld hl, wC8F0
    dec [hl]
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8FB
    dec [hl]
    ldh a, [hFF8E]
    inc a
    ldh [hFF8E], a
    cp a, $70
    ret nz
    ld a, $03
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld hl, hFF8C
    call Func_073_7A4C
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld a, $30
    ld [wCB9A], a
    ld hl, $0886
    call StoreHLInWC924_B73b
    ret

Jump_073_6CCA::
    farcall Func_05F_6EC3
    ret

Jump_073_6CD1::
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld a, $01
    ld [wC8EF], a
    ld a, $02
    ld [wC8F4], a
    xor a, a
    ld [wC8F9], a
    ld a, $03
    ldh [hFF98], a
    ld hl, wC8F0
    inc [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    inc [hl]
    ldh a, [hFF8E]
    dec a
    ldh [hFF8E], a
    cp a, $60
    ret nz
    xor a, a
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld hl, hFF8C
    call Func_073_7A4C
    ld hl, wC923
    inc [hl]
    xor a, a
    ld [wC921], a
    ld [wC92D], a
    ret

Jump_073_6D1B::
    farcall Func_012_61EF
    ret

Jump_073_6D22::
    ldh a, [hFF91]
    cp a, $40
    jr z, Jump_073_6D34
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6A94
    ret

Jump_073_6D34::
    ldh a, [hFF8E]
    cp a, $70
    jr z, Jump_073_6D4D
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6ABF
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ldh [hFF98], a

Jump_073_6D4D::
    ld hl, wC923
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $1CED52, $C5

; 1 call site from 1 routine (e.g. Func_010_4C6E)
; reads: wC923
Func_073_6E17::
    ld a, [wC923]
    rst $00
    dw Jump_073_6E40
    dw Jump_073_4E41
    dw Jump_073_6E29
    dw Jump_073_6E23

Jump_073_6E23::
    ld a, $80
    ld [wC919], a
    ret

Jump_073_6E29::
    ldh a, [hFF8E]
    ld [wC8C8], a
    ldh a, [hFF91]
    ld [wC8C9], a
    ldh a, [hFF98]
    inc a
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_6E40::
    xor a, a
    ldh [hFFB9], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_073_6E55
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_073_6E55::
    ld a, $7A
    call StoreWC60B
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C36)
; reads: hFFC6, wC836
; writes: hFFC6, wC836, wC919
; points at: wC61D
Func_073_6E5F::
    ld a, $19
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1A
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1B
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ld a, $1C
    ldh [hFFC6], a
    farcall Func_012_7DCE
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_073_6EA0
    ret

Jump_073_6EA0::
    ld hl, wC61D
    ldh a, [hFFC6]
    add a, l
    ld l, a
    jr nc, Jump_073_6EAA
    inc h

Jump_073_6EAA::
    ld [hl], $30
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C67)
; reads: wC923
Func_073_6EBA::
    ld a, [wC923]
    rst $00
    dw Jump_073_6EC8
    dw Jump_073_6EC2

Jump_073_6EC2::
    ld a, $80
    ld [wC919], a
    ret

Jump_073_6EC8::
    ld a, [wCC38]
    or a, $02
    ld [wCC38], a
    ldh a, [hFF8E]
    ld [wC8C8], a
    ldh a, [hFF91]
    ld [wC8C9], a
    ldh a, [hFF98]
    inc a
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; 1 call site from 1 routine (e.g. Func_010_4C4B)
; reads: wC923
Func_073_6EE7::
    ld a, [wC923]
    rst $00
    dw Jump_073_6EEF
    dw Jump_073_6F04

Jump_073_6EEF::
    ld b, $5A
    call Func_073_7A2B
    ret nc
    ld a, $05
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6F04::
    ld b, $28
    call Func_073_7A2B
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C1A)
; reads: hFF8E, hFF91, wCBD4
; writes: wCBCF, wCBD3, wCBD4, wC919
; points at: wCBD3, wCBD4
Func_073_6F14::
    ldh a, [hFF8E]
    cp a, $50
    jr nz, Jump_073_6F24
    ld hl, wCBD3
    inc [hl]
    ld hl, wCBD4
    inc [hl]
    jr Jump_073_6F40

Jump_073_6F24::
    cp a, $30
    jr nz, Jump_073_6F32
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    inc [hl]
    jr Jump_073_6F40

Jump_073_6F32::
    ldh a, [hFF91]
    cp a, $20
    jr z, Jump_073_6F40
    ld a, [wCBD4]
    inc a
    inc a
    ld [wCBD4], a

Jump_073_6F40::
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C13)
; reads: wC923
; writes: wCBCF, wC919
; points at: wC923, wCBD4
Func_073_6F5B::
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_6F6B
    ld a, $80
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6F6B::
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C44)
; reads: wC923
Func_073_6F7C::
    ld a, [wC923]
    rst $00
    dw Jump_073_7007
    dw Jump_073_6FC5
    dw Jump_073_6FB1
    dw Jump_073_6F88

Jump_073_6F88::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $3C
    ret nz
    ld a, $72
    call StoreWC60B
    ldh a, [hFF98]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld a, $40
    ld [wCB8A], a
    ld de, $0019
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

Jump_073_6FB1::
    ld a, $01
    ld [wC8F4], a
    ld a, [wC8F5]
    inc a
    ld [wC8F5], a
    cp a, $B0
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6FC5::
    ld a, [wC921]
    or a, a
    jr nz, Jump_073_6FE2
    ld a, [wC8F5]
    cp a, $50
    jr nz, Jump_073_6FD8
    ld a, $01
    ld [wC921], a
    ret

Jump_073_6FD8::
    ld a, $01
    ld [wC8F4], a
    ld hl, wC8F5
    inc [hl]
    ret

Jump_073_6FE2::
    ld a, [wC8F6]
    cp a, $40
    jr nz, Jump_073_6FF2
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_6FF2::
    jr nc, Jump_073_6FFD
    xor a, a
    ld [wC8F4], a
    ld hl, wC8F6
    inc [hl]
    ret

Jump_073_6FFD::
    ld a, $02
    ld [wC8F4], a
    ld hl, wC8F6
    dec [hl]
    ret

Jump_073_7007::
    ld hl, wC923
    inc [hl]
    ld a, [wC8F5]
    cp a, $40
    jr nz, Jump_073_701E
    ld a, [wC8F6]
    cp a, $20
    jr nz, Jump_073_701E
    xor a, a
    ld [wC921], a
    ret

Jump_073_701E::
    ld a, $01
    ld [wC921], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4BFE)
; reads: wC923
Func_073_7024::
    ld a, [wC923]
    rst $00
    dw Func_073_734D
    dw Jump_073_733B
    dw Jump_073_733B
    dw Jump_073_7AC6
    dw Jump_073_7329
    dw Jump_073_7329
    dw Jump_073_7AC6
    dw Jump_073_7317
    dw Jump_073_7317
    dw Jump_073_7AC6
    dw Func_073_734D
    dw Jump_073_7300
    dw Jump_073_72D6
    dw Jump_073_7AC6
    dw Jump_073_72A9
    dw Jump_073_724F
    dw Jump_073_7223
    dw Jump_073_71F6
    dw Jump_073_71DB
    dw Jump_073_71BC
    dw Jump_073_71DB
    dw Jump_073_7180
    dw Jump_073_715A
    dw Jump_073_70D3
    dw Jump_073_70C2
    dw Jump_073_7AC6
    dw Jump_073_70A9
    dw Jump_073_7095
    dw Jump_073_7062

Jump_073_7062::
    ld a, [wC921]
    inc a
    cp a, $1E
    jr z, Jump_073_706E
    ld [wC921], a
    ret

Jump_073_706E::
    dec a
    ld [wC921], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ldh [hFF98], a
    ld [wC8EF], a
    ld de, $000C
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

Jump_073_7095::
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_70A9::
    ld a, $68
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ldh [hFF98], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_70C2::
    ld b, $B4
    call Func_073_7A2B
    ret nc
    ld hl, $005C
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_70D3::
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_073_70E5
    xor a, a
    ld [wC928], a
    farcall Func_05F_6936
    ret

Jump_073_70E5::
    ld a, [wC921]
    or a, a
    jr nz, Jump_073_70F0
    ld a, $65
    call StoreWC60B

Jump_073_70F0::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    and a, $01
    jr nz, Jump_073_7111
    ld a, [wCB86]
    inc a
    and a, $03
    ld [wCB86], a

Jump_073_7111::
    ld a, [wCB8A]
    cp a, $40
    jr z, Jump_073_711D
    dec a
    dec a
    ld [wCB8A], a

Jump_073_711D::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    jr z, Jump_073_7138
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ret

Jump_073_7138::
    ld a, $72
    call StoreWC60B
    ld de, $7AD4
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wCB81], a
    xor a, a
    ld [wCB86], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_715A::
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB86
    call Func_073_7A51
    ld b, $78
    call Func_073_7A2B
    ret nc
    ld hl, $005B
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_7180::
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB86
    call Func_073_7A51
    ld hl, wC921
    inc [hl]
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_71BC::
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB86
    call Func_073_7A51
    ld de, wCB9B
    ld hl, $005A
    call Func_073_7A7F
    ret

Jump_073_71DB::
    ld a, $01
    call Func_073_7AB2
    push af
    ld de, wCB86
    call Func_073_7A51
    ld hl, wC921
    inc [hl]
    pop af
    ret nc
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_71F6::
    ld a, $02
    ld [wC8EF], a
    ld a, $70
    ld [wC8F0], a
    ld a, $40
    ld [wC8F1], a
    farcall Func_012_6B22
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld a, $80
    ld [wCBCF], a
    ld de, wCB8B
    ld hl, $0059
    call Func_073_7A7F
    ret

Jump_073_7223::
    ld a, $02
    ld [wCBA6], a
    ld hl, wCBAB
    inc [hl]
    ld de, wCBAB
    call Func_073_7A5D
    ret nc
    ld de, $000B
    call SetFlagBit
    ldh a, [hFF8E]
    ld [wC8C8], a
    ldh a, [hFF91]
    ld [wC8C9], a
    ld a, $04
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_073_724F::
    ld hl, wCBAA
    dec [hl]
    ld de, wCB9B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    and a, $01
    jr z, Jump_073_728D

Jump_073_728D::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ldh [hFFC6], a
    farcall Func_012_6AD9
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_72A9::
    ld a, [wC8F1]
    dec a
    dec a
    ld [wC8F1], a
    cp a, $38
    jr z, Jump_073_72B9
    call Func_073_736B
    ret

Jump_073_72B9::
    ld a, $80
    ld [wCB9A], a
    ld a, $60
    ld [wCBAA], a
    ld a, $70
    ld [wCBD3], a
    ld a, $63
    call StoreWC60B
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_72D6::
    ld a, [wC5F0]
    and a, $03
    ret nz
    ld a, [wC8F1]
    inc a
    ld [wC8F1], a
    cp a, $48
    ret nz
    ld hl, wC923
    inc [hl]
    ld de, $0001
    call TestFlagBit
    jr c, Jump_073_72F9
    ld hl, $0058
    call StoreHLInWC924_B73b
    ret

Jump_073_72F9::
    ld hl, $005E
    call StoreHLInWC924_B73b
    ret

Jump_073_7300::
    call Func_073_736B
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    cp a, $70
    ret nz
    ld a, $02
    ld [wC8EF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_7317::
    ld de, wCB9B
    call Func_073_7A5D
    ret nc
    ld hl, $0055
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_7329::
    ld de, wCBAB
    call Func_073_7A5D
    ret nc
    ld hl, $0054
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

Jump_073_733B::
    ld de, wCB9B
    call Func_073_7A5D
    ret nc
    ld hl, $0053
    call StoreHLInWC924_B73b
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_00F_40E9)
; reads: wC921
; writes: wCBCF
; points at: wCB9C, wCBAC, wC923
Func_073_734D::
    ld hl, wCB9C
    call SetBit2AtHL_B73
    ld hl, wCBAC
    call SetBit2AtHL_B73
    ld a, $80
    ld [wCBCF], a
    call Func_073_736B
    ld a, [wC921]
    or a, a
    ret nz
    ld hl, wC923
    inc [hl]
    ret

; 3 call sites from 2 routines (e.g. Func_073_7024, Func_073_734D)
; reads: wC921, wCB9A, wCBAA, wCBD3
; writes: wCB9A, wCBAA, wCBD3
; points at: wC921
Func_073_736B::
    ld a, [wC921]
    and a, $3F
    ld hl, $7526
    add a, l
    ld l, a
    jr nc, Jump_073_7378
    inc h

Jump_073_7378::
    ld a, [hl]
    ld c, a
    ld a, [wC921]
    and a, $40
    jr z, Jump_073_7386
    ld a, c
    xor a, $FF
    inc a
    ld c, a

Jump_073_7386::
    ld a, [wCB9A]
    add a, c
    ld [wCB9A], a
    ld a, [wCBAA]
    add a, c
    ld [wCBAA], a
    ld a, [wCBD3]
    add a, c
    ld [wCBD3], a
    ld hl, wC921
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4BF7)
; reads: wC923
Func_073_73A0::
    ld a, [wC923]
    rst $00
    dw Jump_073_7566
    dw Jump_073_74EC
    dw Jump_073_74DA
    dw Jump_073_74DA
    dw Jump_073_74EC
    dw Jump_073_74EC
    dw Jump_073_74DA
    dw Jump_073_74DA
    dw Jump_073_74EC
    dw Jump_073_741E
    dw Jump_073_73BA

Jump_073_73BA::
    ld a, [wC921]
    or a, a
    jr nz, Jump_073_73F9
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $E0
    ld [wCBAA], a
    ld hl, wC921
    inc [hl]
    ret

Jump_073_73F9::
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $E0
    ld [wCB9A], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_741E::
    ld a, [wC921]
    or a, a
    jr nz, Jump_073_7429
    ld a, $65
    call StoreWC60B

Jump_073_7429::
    ld a, [wC921]
    ld hl, $749A
    add a, l
    ld l, a
    jr nc, Jump_073_7434
    inc h

Jump_073_7434::
    ld a, [hl]
    ld [wCBD3], a
    ld a, [wC921]
    push af
    srl a
    ld [wC921], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    pop af
    ld [wC921], a
    ldh a, [hFF8E]
    cp a, $00
    jr nz, Jump_073_746A
    ld hl, hFF8C
    call Func_073_7A4C
    ld hl, wCBAC
    call Func_073_7A4C
    jr Jump_073_7476

Jump_073_746A::
    dec a
    dec a
    ldh [hFF8E], a
    ld a, [wCBAA]
    inc a
    inc a
    ld [wCBAA], a

Jump_073_7476::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $40
    ret nz
    xor a, a
    ld [wCBCF], a
    ld a, $68
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld hl, wC923
    inc [hl]
    xor a, a
    ld [wC921], a
    ld [wC922], a
    ret
    db $21, $22, $23, $23, $24, $25, $26, $27, $28, $29, $2A, $2A, $2B, $2C, $2D, $2E
    db $2F, $30, $30, $31, $32, $33, $34, $35, $35, $36, $37, $38, $39, $39, $3A, $3B
    db $3C, $3C, $3D, $3E, $3E, $3F, $40, $40, $41, $42, $42, $43, $44, $44, $45, $46
    db $46, $47, $48, $48, $49, $4A, $4A, $4B, $4C, $4C, $4D, $4E, $4E, $4F, $50, $50

Jump_073_74DA::
    ld a, [wC921]
    ld hl, $7526
    add a, l
    ld l, a
    jr nc, Jump_073_74E5
    inc h

Jump_073_74E5::
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr Jump_073_74F9

Jump_073_74EC::
    ld a, [wC921]
    ld hl, $7526
    add a, l
    ld l, a
    jr nc, Jump_073_74F7
    inc h

Jump_073_74F7::
    ld a, [hl]
    ld c, a

Jump_073_74F9::
    ld a, [wCBAA]
    add a, c
    ld [wCBAA], a
    ldh a, [hFF8E]
    add a, c
    ldh [hFF8E], a
    ld a, [wC8F0]
    add a, c
    ld [wC8F0], a
    ld a, [wCBD3]
    add a, c
    ld [wCBD3], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $40
    ret nz
    ld hl, wC923
    inc [hl]
    xor a, a
    ld [wC921], a
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

Jump_073_7566::
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6ABF
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wC8EF], a
    ld hl, hFF8C
    call SetBit2AtHL_B73
    ld hl, wCBAC
    call SetBit2AtHL_B73
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C05)
; reads: wC923, hFF8E, hFF91
; writes: wCBD3, wCBD4, wCBCF, wC919
; points at: wC923, wCBD3, wCBD4
Func_073_758C:: ; heuristic: follows a terminator; C0
    ld a, [wC923]
    or a, a
    jr nz, Jump_073_75A6
    ldh a, [hFF8E]
    ld [wCBD3], a
    ldh a, [hFF91]
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_75A6::
    ldh a, [hFF8E]
    cp a, $30
    jr nz, Jump_073_75B2
    ld hl, wCBD3
    inc [hl]
    jr Jump_073_75CC

Jump_073_75B2::
    cp a, $50
    jr nz, Jump_073_75BC
    ld hl, wCBD3
    dec [hl]
    jr Jump_073_75CC

Jump_073_75BC::
    ldh a, [hFF91]
    cp a, $20
    jr nz, Jump_073_75C8
    ld hl, wCBD4
    inc [hl]
    jr Jump_073_75CC

Jump_073_75C8::
    ld hl, wCBD4
    dec [hl]

Jump_073_75CC::
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4BF0)
; reads: wC923
Func_073_75DD::
    ld a, [wC923]
    rst $00
    dw Jump_073_764E
    dw Jump_073_7639
    dw Jump_073_75F5
    dw Jump_073_75E9

Jump_073_75E9::
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld a, $80
    ld [wC919], a
    ret

Jump_073_75F5::
    ldh a, [hFF8E]
    cp a, $00
    jr z, Jump_073_760B
    dec a
    dec a
    ldh [hFF8E], a
    ld a, [wC8F0]
    cp a, $00
    jr z, Jump_073_760B
    dec a
    dec a
    ld [wC8F0], a

Jump_073_760B::
    ld a, $80
    ld [wCBCF], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, $50
    ld [wCBD4], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_7639::
    ld a, [wCBAA]
    dec a
    dec a
    ld [wCBAA], a
    cp a, $30
    ret nz
    ld a, $63
    call StoreWC60B
    ld hl, wC923
    inc [hl]
    ret

Jump_073_764E::
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    cp a, $40
    ret nz
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4BE9)
; reads: wC923
Func_073_765D::
    ld a, [wC923]
    rst $00
    dw Jump_073_77A5
    dw Jump_073_7765
    dw Jump_073_775A
    dw Jump_073_7741
    dw Jump_073_775A
    dw Jump_073_7719
    dw Jump_073_775A
    dw Jump_073_7713
    dw Jump_073_775A
    dw Jump_073_7719
    dw Jump_073_775A
    dw Jump_073_7713
    dw Jump_073_775A
    dw Jump_073_7709
    dw Jump_073_7AC6
    dw Jump_073_76B8
    dw Jump_073_7683

Jump_073_7683::
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wC919], a
    ret

Jump_073_76B8::
    ld a, [wCBAA]
    cp a, $40
    jr z, Jump_073_76CB
    ld a, $83
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    jr Jump_073_76D5

Jump_073_76CB::
    ld a, $82
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a

Jump_073_76D5::
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_7709::
    ld de, wCB8B
    ld hl, $0039
    call Func_073_7A7F
    ret

Jump_073_7713::
    ld hl, wCBD3
    inc [hl]
    jr Jump_073_771D

Jump_073_7719::
    ld hl, wCBD3
    dec [hl]

Jump_073_771D::
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_7741::
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    ld a, $03
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_775A::
    ld b, $1E
    call Func_073_7A2B
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_073_7765::
    ld a, [wCB9A]
    cp a, $30
    jr z, Jump_073_7781
    ld a, $01
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54

Jump_073_7781::
    ld a, $02
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_77A5::
    ld hl, wC921
    inc [hl]
    ld a, [wC921]
    cp a, $3C
    jr nz, Jump_073_77B6
    ld a, $50
    ld [wCBAA], a
    ret

Jump_073_77B6::
    cp a, $78
    jr nz, Jump_073_77C0
    ld a, $20
    ld [wCB9A], a
    ret

Jump_073_77C0::
    cp a, $B4
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4BE2)
; reads: wC923
Func_073_77CC::
    ld a, [wC923]
    rst $00
    dw Jump_073_78E7
    dw Jump_073_78CC
    dw Jump_073_78B2
    dw Jump_073_787B
    dw Jump_073_77EA
    dw Jump_073_77DC

Jump_073_77DC::
    call Func_073_79CE
    ld a, [wC922]
    or a, a
    ret nz
    ld a, $80
    ld [wC919], a
    ret

Jump_073_77EA::
    call Func_073_79CE
    ld a, [wCB9B]
    cp a, $30
    jr z, Jump_073_7800
    ld a, $82
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    jr Jump_073_780A

Jump_073_7800::
    ld a, $83
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a

Jump_073_780A::
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC924]
    or a, a
    jr nz, Jump_073_783B
    ld a, $02
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wC924], a
    ret

Jump_073_783B::
    ld a, [wCBAB]
    cp a, $30
    jr z, Jump_073_7858
    ld a, $02
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_073_7858::
    ld a, $02
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_787B::
    call Func_073_79CE
    ld a, $02
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $83
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_073_78B2::
    call Func_073_78F5
    call Func_073_79B8
    ld b, $A0
    call Func_073_7A2B
    ret nc
    ld a, $40
    ld [wC922], a
    xor a, a
    ld [wC924], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_78CC::
    call Func_073_78F5
    call Func_073_79B8
    ld b, $80
    call Func_073_7A2B
    ret nc
    ld a, $81
    ld [wC924], a
    ld a, $80
    ld [wC925], a
    ld hl, wC923
    inc [hl]
    ret

Jump_073_78E7::
    ld a, $01
    ld [wC924], a
    xor a, a
    ld [wC925], a
    ld hl, wC923
    inc [hl]
    ret

; 2 call sites from 1 routine (e.g. Func_073_77CC)
; reads: wC924, wC92C, wC925
; writes: wC92A, wC928, wC929, wC924, wC925
Func_073_78F5::
    ld b, $00
    ld a, [wC924]
    bit 7, a
    jr z, Jump_073_7900
    ld b, $80

Jump_073_7900::
    and a, $03
    jr nz, Jump_073_7911
    ld a, b
    or a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_793C

Jump_073_7911::
    dec a
    jr nz, Jump_073_7921
    ld a, b
    or a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_793C

Jump_073_7921::
    dec a
    jr nz, Jump_073_7931
    ld a, b
    or a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    jr Jump_073_793C

Jump_073_7931::
    ld a, b
    or a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a

Jump_073_793C::
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_7956
    ld a, [wC924]
    inc a
    and a, $83
    ld [wC924], a

Jump_073_7956::
    ld b, $00
    ld a, [wC925]
    bit 7, a
    jr z, Jump_073_7961
    ld b, $80

Jump_073_7961::
    and a, $03
    jr nz, Jump_073_7972
    ld a, b
    or a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_799D

Jump_073_7972::
    dec a
    jr nz, Jump_073_7982
    ld a, b
    or a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_073_799D

Jump_073_7982::
    dec a
    jr nz, Jump_073_7992
    ld a, b
    or a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    jr Jump_073_799D

Jump_073_7992::
    ld a, b
    or a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a

Jump_073_799D::
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    jr z, Jump_073_79B7
    ld a, [wC925]
    inc a
    and a, $83
    ld [wC925], a

Jump_073_79B7::
    ret

; 2 call sites from 1 routine (e.g. Func_073_77CC)
; reads: wC925
; writes: wCB86
Func_073_79B8::
    ld a, [wC925]
    and a, $03
    ld hl, $79CA
    add a, l
    ld l, a
    jr nc, Jump_073_79C5
    inc h

Jump_073_79C5::
    ld a, [hl]
    ld [wCB86], a
    ret
    db $01, $00, $03, $02

; 3 call sites from 1 routine (e.g. Func_073_77CC)
; reads: wC5F0, wC922, wC921
; writes: wC921, wCB86
; points at: wC922
Func_073_79CE::
    ld a, [wC5F0]
    and a, $08
    jr nz, Jump_073_79D9
    ld hl, wC922
    dec [hl]

Jump_073_79D9::
    ld a, [wC922]
    swap a
    and a, $0F
    ld c, a
    ld a, [wC921]
    add a, c
    ld [wC921], a
    swap a
    and a, $03
    ld c, a
    ld a, $03
    sub a, c
    ld [wCB86], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4BDB)
; reads: wC923
Func_073_79F4::
    ld a, [wC923]
    rst $00
    dw Jump_073_7A11
    dw Jump_073_79FC

Jump_073_79FC::
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_073_7A5D
    ret nc
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wC919], a
    ret

Jump_073_7A11::
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld b, $3C
    call Func_073_7A2B
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; 19 call sites from 16 routines (e.g. Func_073_79F4, Func_073_77CC, Func_073_765D, Func_073_75DD, ...)
; reads: wC921
; writes: wC921
Func_073_7A2B::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, b
    jr z, Jump_073_7A37
    sub a, a
    ret

Jump_073_7A37::
    xor a, a
    ld [wC921], a
    scf
    ret

; 2 call sites from 2 routines (e.g. Func_073_6B5B, Func_073_6038)
Func_073_7A3D:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_073_7A42:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 17 call sites from 12 routines (e.g. Func_073_73A0, Func_073_734D, Func_073_6C77, Func_073_6B5B, ...)
SetBit2AtHL_B73:: ; heuristic: follows a terminator; C0
Func_073_7A47:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; 11 call sites from 8 routines (e.g. Func_073_73A0, Func_073_6C77, Func_073_5B66, Func_073_5987, ...)
Func_073_7A4C:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; 4 call sites from 1 routine (e.g. Func_073_7024)
; reads: wC921
Func_073_7A51:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; 13 call sites from 8 routines (e.g. Func_073_79F4, Func_073_765D, Func_073_758C, Func_073_7024, ...)
; reads: wC921
; writes: wC928, wC929, wC921
Func_073_7A5D::
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    jr z, Jump_073_7A79
    sub a, a
    ret

Jump_073_7A79::
    xor a, a
    ld [wC921], a
    scf
    ret

; 3 call sites from 2 routines (e.g. Func_073_765D, Func_073_7024)
; reads: wC921
; writes: wC928, wC929, wC921
; points at: wC923
Func_073_7A7F:: ; heuristic: follows a terminator; C0
    push hl
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    pop hl
    cp a, $20
    ret nz
    call StoreHLInWC924_B73b
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 25 call sites from 12 routines (e.g. Func_073_7A7F, Func_073_7024, Func_073_6B98, Func_073_6C77, ...)
; writes: wC924, wC925, wC926
StoreHLInWC924_B73b::
Func_073_7AA5:: ; address name
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; 7 call sites from 5 routines (e.g. Func_073_7AB2, Func_073_7AD0, Func_073_7024, Func_073_6B98, ...)
; reads: wC926
; writes: wC928
Func_073_7AB2:: ; heuristic: follows a terminator; C0
    ld [wC928], a
    farcall Func_05F_6936
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_073_7AC4
    sub a, a
    ret

Jump_073_7AC4::
    scf
    ret

Jump_073_7AC6::
    xor a, a
    call Func_073_7AB2
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC919
Func_073_7AD0:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_073_7AB2
    ret nc
    ld a, $80
    ld [wC919], a
    ret
    ds $525, $00
