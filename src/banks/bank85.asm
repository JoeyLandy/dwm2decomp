SECTION "Bank 85", ROMX[$4000], BANK[$85]
    db $85

; 1 call site from 1 routine (e.g. Func_010_4F4D)
; reads: wC923
Func_085_4001::
    ld a, [wC923]
    rst $00
    dw Jump_085_402D
    dw Jump_085_4009

Jump_085_4009::
    ld a, $00
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $60
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB86], a
    ld a, $80
    ld [wC919], a
    ret

Jump_085_402D::
    ld hl, wC923
    inc [hl]
    ld a, [wCB8A]
    cp a, $50
    ret z
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4F46)
; writes: wCB7D, wC919
Func_085_403D::
    xor a, a
    ld [wCB7D], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C8A)
; reads: wC923
Func_085_4047::
    ld a, [wC923]
    rst $00
    dw Jump_085_41CC
    dw Jump_085_57E9
    dw Jump_085_4174
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_43CA
    dw Jump_085_57E9
    dw Jump_085_4159
    dw Jump_085_43AB
    dw Jump_085_4390
    dw Jump_085_437D
    dw Jump_085_437D
    dw Jump_085_437D
    dw Jump_085_412F
    dw Jump_085_40C3
    dw Jump_085_4093
    dw Jump_085_4071
    dw Jump_085_423C
    dw Jump_085_4231

Jump_085_4071::
    ld a, $05
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $01
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld hl, $4D52
    call StoreHLInWC924_B85
    ld hl, wCB7D
    dec [hl]
    ld hl, wC923
    dec [hl]
    ret

Jump_085_4093::
    xor a, a
    call Func_085_57D5
    ret nc
    farcall Func_002_5F22
    ld hl, wCB7D
    dec [hl]
    farcall Func_05F_6DDB
    farcall Func_004_449F
    xor a, a
    ldh [hFFB9], a
    farcall Func_002_6050
    ld de, $0078
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

Jump_085_40C3::
    ld a, $05
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $02
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld hl, wC6FD
    inc [hl]
    ld a, [wC92E]
    dec a
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, wC8EF
    add_a_to_hl
    ld a, [wCB86]
    ld [hl+], a
    ld a, [wCB8A]
    ld [hl+], a
    ld a, [wCB8B]
    ld [hl], a
    ld a, [wC92E]
    dec a
    ld hl, wC6FE
    add_a_to_hl
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
    ld hl, $4D51
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_412F::
    farcall Func_002_5F22
    call Func_085_4555
    ld a, [wC92E]
    cp a, $03
    jr nz, Jump_085_4145
    ld a, $10
    ld [wC923], a
    ret

Jump_085_4145::
    push af
    call Func_085_45CB
    pop af
    ld hl, wC92E
    inc [hl]
    ld hl, wC6FD
    dec [hl]
    ld hl, wC923
    inc [hl]
    jp Jump_085_40C3

Jump_085_4159::
    ld de, vTiles1 + $6E0
    call Func_000_21A1
    xor a, a
    ld [wC92D], a
    ld [wC92E], a
    call Func_085_4505
    farcall Func_004_4470
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4174::
    ld a, [wC552]
    or a, a
    jr nz, Jump_085_41C1
    farcall Func_05F_6D78
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_085_4192
    ld hl, vTiles1 + $557
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4192::
    ld a, [wC6FD]
    cp a, $03
    jr z, Jump_085_41B2
    ld hl, vTiles0 + $1B8
    call StoreHLInWC924_B85
    farcall Func_002_5EEE
    ld a, [wC6FD]
    inc a
    ld [wC92E], a
    ld a, $11
    ld [wC923], a
    ret

Jump_085_41B2::
    ld hl, vTiles1 + $511
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_085_41C1::
    ld hl, vTiles1 + $512
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_41CC::
    ld a, $1C
    ld [wC8CF], a
    ld [wC147], a
    ld a, $34
    ld [wC8D0], a
    ld [wC148], a
    ld a, $38
    ld [wC8D1], a
    ld [wC149], a
    ld a, $2C
    ld [wC8D2], a
    ld [wC14A], a
    ld a, $3D
    ld [wC8D3], a
    ld [wC14B], a
    ld a, $F0
    ld [wC8D4], a
    ld [wC14C], a
    ld hl, $4D0F
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D7F)
; reads: wC923
Func_085_4207::
    ld a, [wC923]
    rst $00
    dw Func_085_442D
    dw Jump_085_57E9
    dw Func_085_43D5
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_43CA
    dw Jump_085_57E9
    dw Func_085_43AF
    dw Jump_085_43AB
    dw Jump_085_4390
    dw Jump_085_437D
    dw Jump_085_437D
    dw Jump_085_437D
    dw Func_085_4307
    dw Func_085_429B
    dw Func_085_426B
    dw Func_085_4249
    dw Jump_085_423C
    dw Jump_085_4231

Jump_085_4231::
    xor a, a
    call Func_085_57D5
    ret nc
    ld a, $0E
    ld [wC923], a
    ret

Jump_085_423C::
    ld hl, wCB96
    call Func_085_4339
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5
; writes: hFFC7, hFFC8, hFFC9
; points at: wCB7D, wC923
Func_085_4249:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $01
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld hl, $4D52
    call StoreHLInWC924_B85
    ld hl, wCB7D
    dec [hl]
    ld hl, wC923
    dec [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: hFFB9, wC919
; points at: wCB7D
Func_085_426B:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_085_57D5
    ret nc
    farcall Func_002_5F22
    ld hl, wCB7D
    dec [hl]
    farcall Func_05F_6DDB
    farcall Func_004_449F
    xor a, a
    ldh [hFFB9], a
    farcall Func_002_6050
    ld de, $005C
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wC92E, wCB96, wCB9A, wCB9B
; writes: hFFC7, hFFC8, hFFC9, wC527
; points at: wC6FD, wC8EF, wC6FE, wCB7D, wC923
Func_085_429B:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $02
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld hl, wC6FD
    inc [hl]
    ld a, [wC92E]
    dec a
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, wC8EF
    add_a_to_hl
    ld a, [wCB96]
    ld [hl+], a
    ld a, [wCB9A]
    ld [hl+], a
    ld a, [wCB9B]
    ld [hl], a
    ld a, [wC92E]
    dec a
    ld hl, wC6FE
    add_a_to_hl
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
    ld hl, $4D51
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC92E, wD7F5, wCB96, wCB9A, wCB9B
; writes: wC923, hFFC7, hFFC8, hFFC9, wC527
; points at: wCB96, wC92E, wC6FD, wC923, wC8EF, wC6FE, wCB7D
Func_085_4307:: ; heuristic: follows a terminator; C0
    ld hl, wCB96
    call Func_085_4339
    or a, a
    ret z
    farcall Func_002_5F22
    call Func_085_4555
    ld a, [wC92E]
    cp a, $03
    jr nz, Jump_085_4325
    ld a, $10
    ld [wC923], a
    ret

Jump_085_4325::
    push af
    call Func_085_45CB
    pop af
    ld hl, wC92E
    inc [hl]
    ld hl, wC6FD
    dec [hl]
    ld hl, wC923
    inc [hl]
    jp Func_085_429B

; 2 call sites from 2 routines (e.g. Func_085_4207, Func_085_4307)
; reads: wC921
; writes: wC921
Func_085_4339::
    ld a, [hl]
    or a, a
    jr nz, Jump_085_4347
    ld a, $05
    add_a_to_hl
    inc [hl]
    jr Jump_085_4369

Jump_085_4347::
    dec a
    jr nz, Jump_085_4354
    ld a, $04
    add_a_to_hl
    inc [hl]
    jr Jump_085_4369

Jump_085_4354::
    dec a
    jr nz, Jump_085_4361
    ld a, $05
    add_a_to_hl
    dec [hl]
    jr Jump_085_4369

Jump_085_4361::
    ld a, $04
    add_a_to_hl
    dec [hl]

Jump_085_4369::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $10
    jr z, Jump_085_4376
    xor a, a
    ret

Jump_085_4376::
    xor a, a
    ld [wC921], a
    ld a, $01
    ret

Jump_085_437D::
    ld a, [wC92E]
    cp a, $03
    jr nz, Jump_085_4389
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4389::
    farcall Func_012_61EF
    ret

Jump_085_4390::
    farcall Func_002_5F22
    call Func_085_4555
    ld hl, wCD56
    call StoreHLInWC924_B85
    farcall Func_004_449F
    ld a, $01
    ld [wC923], a
    ret

Jump_085_43AB::
    call Func_085_446D
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC92D, wC92E
; points at: wC923
Func_085_43AF:: ; heuristic: follows a terminator; C0
    ld de, vTiles1 + $6E0
    call Func_000_21A1
    xor a, a
    ld [wC92D], a
    ld [wC92E], a
    call Func_085_4505
    farcall Func_004_4470
    ld hl, wC923
    inc [hl]
    ret

Jump_085_43CA::
    ld hl, $4D50
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC552, wD7F5, wC6FD
; writes: wC92E, wC923
; points at: wC923
Func_085_43D5:: ; heuristic: follows a terminator; C0
    ld a, [wC552]
    or a, a
    jr nz, Jump_085_4422
    farcall Func_05F_6D78
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_085_43F3
    ld hl, vTiles1 + $555
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_43F3::
    ld a, [wC6FD]
    cp a, $03
    jr z, Jump_085_4413
    ld hl, vTiles0 + $1B8
    call StoreHLInWC924_B85
    farcall Func_002_5EEE
    ld a, [wC6FD]
    inc a
    ld [wC92E], a
    ld a, $11
    ld [wC923], a
    ret

Jump_085_4413::
    ld hl, vTiles0 + $1B9
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4422::
    ld hl, vTiles0 + $1BA
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC8CF, wC147, wC8D0, wC148, wC8D1, wC149, wC8D2, wC14A, ...
; points at: wC923
Func_085_442D:: ; heuristic: follows a terminator; C0
    ld a, $0B
    ld [wC8CF], a
    ld [wC147], a
    ld a, $2C
    ld [wC8D0], a
    ld [wC148], a
    ld a, $2C
    ld [wC8D1], a
    ld [wC149], a
    ld a, $31
    ld [wC8D2], a
    ld [wC14A], a
    ld a, $32
    ld [wC8D3], a
    ld [wC14B], a
    ld a, $90
    ld [wC8D4], a
    ld a, $F0
    ld [wC8D5], a
    ld [wC14C], a
    ld hl, $41B7
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_085_4339)
; reads: wC562, wC5F0
; points at: wC923, wC92E
Func_085_446D::
    ld a, [wC562]
    bit 1, a
    jr z, Jump_085_4479
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4479::
    bit 0, a
    jr z, Jump_085_4493
    call Func_085_44D2
    ld a, $BC
    call WriteVRAMByte
    ld a, $69
    call StoreWC60B
    ld hl, wC923
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4493::
    bit 6, a
    jr z, Jump_085_44AA
    call Func_085_44D2
    ld a, $C3
    call WriteVRAMByte
    ld hl, wC92E
    dec [hl]
    ld a, $69
    call StoreWC60B
    jr Jump_085_44BF

Jump_085_44AA::
    bit 7, a
    jr z, Jump_085_44BF
    call Func_085_44D2
    ld a, $C3
    call WriteVRAMByte
    ld hl, wC92E
    inc [hl]
    ld a, $69
    call StoreWC60B

Jump_085_44BF::
    call Func_085_44D2
    ld c, $BB
    ld a, [wC5F0]
    bit 3, a
    jr z, Jump_085_44CD
    ld c, $C3

Jump_085_44CD::
    ld a, c
    call WriteVRAMByte
    ret

; 4 call sites from 1 routine (e.g. Func_085_446D)
; reads: wC92E, hScrollY, hScrollX
; writes: wC92E
Func_085_44D2::
    ld a, [wC92E]
    and a, $03
    ld [wC92E], a
    swap a
    add a, $08
    ld c, a
    ldh a, [hScrollY]
    add a, c
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $98
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    ldh a, [hScrollX]
    add a, $08
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; 2 call sites from 2 routines (e.g. Func_085_4047, Func_085_43AF)
; reads: wIsCGB
; writes: rSVBK
; points at: wC198, wD000
Func_085_4505::
    farcall Func_002_5EEE
    ld hl, wC198
    ld de, $4583
    ld b, $09

Jump_085_4513::
    push hl
    ld c, $08

Jump_085_4516::
    ld a, [de]
    inc de
    ld [hl+], a
    dec c
    jr nz, Jump_085_4516
    pop hl
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, Jump_085_4513
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_085_454C
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    ld b, $09

Jump_085_4536::
    push hl
    ld c, $08

Jump_085_4539::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_085_4539
    pop hl
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, Jump_085_4536
    xor a, a
    ldh [rSVBK], a

Jump_085_454C::
    call Func_085_4555
    ld a, $6C
    call StoreWC60B
    ret

; 4 call sites from 4 routines (e.g. Func_085_4047, Func_085_4339, Func_085_4505, Func_085_4307)
; reads: hScrollY, hScrollX
Func_085_4555::
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_085_457D
    inc d

Jump_085_457D::
    ld l, e
    ld h, d
    call Func_000_1EA5
    ret
    INCBIN "dwm2-cobi-us.gbc", $214583, $48

; 2 call sites from 2 routines (e.g. Func_085_4047, Func_085_4307)
; reads: hFFC6, hFFC7
; writes: rRAMG
; points at: wC6FE
Func_085_45CB::
    ld hl, wC6FE
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [hl]
    push af
    ld c, $5D
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, $5B
    call SRAMRecordAddress
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl], a
    pop af
    push af
    ld c, $61
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, $5F
    call SRAMRecordAddress
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl], a
    pop af
    push af
    ld c, $55
    call SRAMRecordAddress
    xor a, a
    ld [hl], a
    pop af
    ld c, $00
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C21)
; reads: wC923
Func_085_4617::
    ld a, [wC923]
    rst $00
    dw Jump_085_46B0
    dw Jump_085_4684
    dw Jump_085_4658
    dw Jump_085_4623

Jump_085_4623::
    ld a, $01
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $03
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

Jump_085_4658::
    ld a, $01
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    jr Jump_085_46DA

Jump_085_4684::
    ld a, $02
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    jr Jump_085_46DA

Jump_085_46B0::
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54

Jump_085_46DA::
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4EBA)
; reads: wC923, wC921
; writes: hFFC6, wCBD3, wCBD4, wC921, wCBCF, wC919
; points at: wC923
Func_085_46E4:: ; heuristic: follows a terminator; C0
    ld a, [wC923]
    or a, a
    jr nz, Jump_085_4703
    ld a, $05
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $50
    ld [wCBD3], a
    ld a, $10
    ld [wCBD4], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4703::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $28
    ret nz
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4EAC)
; reads: wC923
Func_085_4717::
    ld a, [wC923]
    rst $00
    dw Jump_085_4725
    dw Jump_085_471F

Jump_085_471F::
    ld a, $80
    ld [wC919], a
    ret

Jump_085_4725::
    farcall Func_002_5EEE
    ld a, $01
    ld [wC8C7], a
    ld a, $02
    ld [wC5DB], a
    ld a, $0C
    ld [wC5DC], a
    xor a, a
    ld [wC5DD], a
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    xor a, a
    ld [wC91F], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4ECF)
; reads: hFF92, hFF8F
; writes: wC919
; points at: wCB86
Func_085_4755:: ; heuristic: follows a terminator; C0
    ld a, $80
    ld [wC919], a
    ldh a, [hFF92]
    cp a, $02
    ret z
    ld de, $4783
    or a, a
    jr z, Jump_085_4768
    ld de, $478F

Jump_085_4768::
    ldh a, [hFF8F]
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_085_4771
    inc d

Jump_085_4771::
    ld hl, wCB86

Jump_085_4774::
    ld a, [de]
    cp a, $FF
    ret z
    ld [hl], a
    ld a, $10
    add_a_to_hl
    inc de
    jr Jump_085_4774
    db $00, $00, $01, $FF, $00, $FF, $FF, $FF, $03, $01, $00, $FF, $01, $03, $02, $FF
    db $01, $FF, $FF, $FF, $02, $02, $01, $FF

; 1 call site from 1 routine (e.g. Func_010_4EDD)
; reads: wC923
Func_085_479B::
    ld a, [wC923]
    rst $00
    dw Jump_085_480A
    dw Jump_085_47E3
    dw Jump_085_47E3
    dw Jump_085_47E3
    dw Jump_085_47B1
    dw Jump_085_47AB

Jump_085_47AB::
    ld a, $80
    ld [wC919], a
    ret

Jump_085_47B1::
    ld a, $E0
    ldh [hFF8E], a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    xor a, a
    ldh [hFF8D], a
    ld a, $48
    ldh [hFF90], a
    ld a, $08
    ldh [hFF8F], a
    ld a, $07
    ldh [hFF92], a
    ld a, $40
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_085_47E3::
    ld a, [wC921]
    swap a
    ld c, a
    ld a, $10
    sub a, c
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ldh a, [hFF8D]
    add a, a
    or a, $01
    ldh [hFF8D], a
    ld hl, wC921
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_085_480A::
    ld a, $65
    call StoreWC60B
    ld a, $01
    ldh [hFF8D], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4ED6)
; reads: wC921
; writes: wCBCF, wC921, wC919
Func_085_481C::
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_085_4829
    bit 3, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4829::
    cp a, $3C
    jr nc, Jump_085_4833
    bit 2, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4833::
    bit 1, a
    jr z, Jump_085_4839
    jr Jump_085_4840

Jump_085_4839::
    ld a, $80
    ld [wCBCF], a
    jr Jump_085_4844

Jump_085_4840::
    xor a, a
    ld [wCBCF], a

Jump_085_4844::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    xor a, a
    ld [wCBCF], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E90)
; reads: hFF8E, hFF98
; writes: wC919
Func_085_4858::
    ld b, $00
    ldh a, [hFF8E]
    ld c, a
    ldh a, [hFF98]
    cp a, $01
    jr z, Jump_085_4869
    cp a, $03
    jr z, Jump_085_486F
    jr Jump_085_4873

Jump_085_4869::
    ld a, c
    add a, $10
    ld c, a
    jr Jump_085_4873

Jump_085_486F::
    ld a, c
    sub a, $10
    ld c, a

Jump_085_4873::
    ld hl, $489C

Jump_085_4876::
    ld a, [hl]
    cp a, c
    jr z, Jump_085_487E
    inc hl
    inc b
    jr Jump_085_4876

Jump_085_487E::
    ld de, $01CF
    ld a, b
    add a, e
    ld e, a
    jr nc, Jump_085_4887
    inc d

Jump_085_4887::
    call SetFlagBit
    farcall Func_084_43B8
    farcall Func_05F_6DDB
    ld a, $80
    ld [wC919], a
    ret
    db $20, $40, $50, $80

; 1 call site from 1 routine (e.g. Func_010_4E82)
; reads: wC923
Func_085_48A0::
    ld a, [wC923]
    rst $00
    dw Jump_085_493E
    dw Jump_085_48C2
    dw Jump_085_57E9
    dw Jump_085_48AE
    dw Func_085_57F3

Jump_085_48AE::
    ld hl, $0B9D
    ld a, [wC921]
    or a, a
    jr nz, Jump_085_48BA
    ld hl, $0BC2

Jump_085_48BA::
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_48C2::
    ld a, [wD092]
    or a, a
    jr nz, Jump_085_4932
    ld de, $003B
    call SetFlagBit
    ld a, $09
    ldh [hFFC6], a
    farcall Func_085_5B23
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_085_4912
    farcall Func_012_6990
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_085_48F5

Jump_085_48E9::
    ld hl, $0B9E
    call StoreHLInWC924_B85
    ld a, $04
    ld [wC923], a
    ret

Jump_085_48F5::
    ld a, $09
    ldh [hFFC7], a
    ld de, $0205
    call TestFlagBit
    jr nc, Jump_085_4905
    ld a, $49
    ldh [hFFC7], a

Jump_085_4905::
    farcall Func_012_6955
    ld a, $01
    ld [wC921], a
    jr Jump_085_4921

Jump_085_4912::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_085_48E9
    xor a, a
    ld [wC921], a

Jump_085_4921::
    ld de, $003C
    call SetFlagBit
    ld hl, $0B9C
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4932::
    ld hl, $0B97
    call StoreHLInWC924_B85
    ld a, $04
    ld [wC923], a
    ret

Jump_085_493E::
    ld a, $30
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E7B)
; reads: wC923
Func_085_494D::
    ld a, [wC923]
    rst $00
    dw Jump_085_49EB
    dw Jump_085_496F
    dw Jump_085_57E9
    dw Jump_085_495B
    dw Func_085_57F3

Jump_085_495B::
    ld hl, $0B93
    ld a, [wC921]
    or a, a
    jr nz, Jump_085_4967
    ld hl, $0BC2

Jump_085_4967::
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_496F::
    ld a, [wD092]
    or a, a
    jr nz, Jump_085_49DF
    ld de, $0039
    call SetFlagBit
    ld a, $07
    ldh [hFFC6], a
    farcall Func_085_5B23
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_085_49BF
    farcall Func_012_6990
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_085_49A2

Jump_085_4996::
    ld hl, $0B94
    call StoreHLInWC924_B85
    ld a, $04
    ld [wC923], a
    ret

Jump_085_49A2::
    ld a, $07
    ldh [hFFC7], a
    ld de, $0203
    call TestFlagBit
    jr nc, Jump_085_49B2
    ld a, $47
    ldh [hFFC7], a

Jump_085_49B2::
    farcall Func_012_6955
    ld a, $01
    ld [wC921], a
    jr Jump_085_49CE

Jump_085_49BF::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_085_4996
    xor a, a
    ld [wC921], a

Jump_085_49CE::
    ld de, $003A
    call SetFlagBit
    ld hl, $0B92
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_49DF::
    ld hl, $0B97
    call StoreHLInWC924_B85
    ld a, $04
    ld [wC923], a
    ret

Jump_085_49EB::
    ld a, $2F
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4EC1)
; reads: wC923
Func_085_49FA::
    ld a, [wC923]
    rst $00
    dw Jump_085_4A1C
    dw Jump_085_4A04
    dw Func_085_57F3

Jump_085_4A04::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_085_4A15
    ld hl, $0D82
    call StoreHLInWC924_B85
    ret

Jump_085_4A15::
    ld hl, $0D83
    call StoreHLInWC924_B85
    ret

Jump_085_4A1C::
    ld a, $15
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4EC8)
; reads: wC923
Func_085_4A2B::
    ld a, [wC923]
    rst $00
    dw Jump_085_4A58
    dw Jump_085_4A35
    dw Func_085_57F3

Jump_085_4A35::
    ld hl, wC923
    inc [hl]
    ld a, [wD092]
    or a, a
    jr nz, Jump_085_4A51
    ld hl, $0BB1
    call StoreHLInWC924_B85
    ld a, $01
    ld [wC894], a
    ld de, $0038
    call SetFlagBit
    ret

Jump_085_4A51::
    ld hl, $0BB2
    call StoreHLInWC924_B85
    ret

Jump_085_4A58::
    ld de, $0037
    call SetFlagBit
    ld a, $14
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E74)
; reads: wC923, hFF8E
; writes: wC919, hFF8F, hFF92, wC8C9, wC8C6, hFF90, wC8C8
Func_085_4A6D::
    ld a, [wC923]
    or a, a
    jr z, Jump_085_4A79
    ld a, $80
    ld [wC919], a
    ret

Jump_085_4A79::
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    ldh a, [hFF8E]
    cp a, $20
    jr nz, Jump_085_4ABC
    ld a, $0F
    ldh [hFF90], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_085_4AAB
    ld a, $20
    ld [wC8C8], a
    farcall Func_05F_6C5A
    ld a, $04
    call Func_000_0DF2
    ret

Jump_085_4AAB::
    ld a, $20
    ld [wC8C8], a
    farcall Func_05F_6C5A
    ld a, $04
    call Func_000_0DF2
    ret

Jump_085_4ABC::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_085_4AD9
    ld a, $10
    ldh [hFF90], a
    ld a, $70
    ld [wC8C8], a
    farcall Func_05F_6C5A
    ld a, $04
    call Func_000_0DF2
    ret

Jump_085_4AD9::
    ld a, $0F
    ldh [hFF90], a
    ld a, $70
    ld [wC8C8], a
    farcall Func_05F_6C5A
    ld a, $04
    call Func_000_0DF2
    ret

; 1 call site from 1 routine (e.g. Func_010_4E6D)
; reads: wC923
; writes: wCB7D, wC919
; points at: wCB9B, wC923
Func_085_4AEE::
    ld a, [wC923]
    or a, a
    jr nz, Jump_085_4B09
    ld hl, wCB9B
    inc [hl]
    ld de, wCB9B
    call Func_085_5780
    ret nc
    ld a, $01
    ld [wCB7D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4B09::
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E66)
; reads: wC923
Func_085_4B0F::
    ld a, [wC923]
    rst $00
    dw Jump_085_4C00
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_4BC7
    dw Jump_085_57E9
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4CC6
    dw Jump_085_4BBD
    dw Jump_085_4BBD
    dw Jump_085_57E9
    dw Jump_085_4BB2
    dw Jump_085_57E9
    dw Jump_085_4B6F
    dw Jump_085_4B33

Jump_085_4B33::
    xor a, a
    ldh [hFF8D], a
    ld a, $01
    ld [wC92A], a
    ld a, $01
    ld [wC929], a
    ld a, $C0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $03
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $01
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld de, $002B
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

Jump_085_4B6F::
    ld a, $01
    ld [wC929], a
    ld a, [wC921]
    or a, a
    jr nz, Jump_085_4B94
    ld a, $01
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_085_4B94::
    ld a, $00
    ld [wC92A], a
    ld a, $40
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

Jump_085_4BB2::
    ld hl, $0BA7
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4BBD::
    ld de, wCBAB
    ld hl, $0BA6
    call Func_085_57A2
    ret

Jump_085_4BC7::
    ld a, [wC552]
    or a, a
    jr nz, Jump_085_4BEC
    ld hl, vTiles1 + $3A5
    call StoreHLInWC924_B85
    ld a, [wCB96]
    add a, a
    ld hl, $4BF8
    add_a_to_hl
    ld a, [hl+]
    ld [wCBAA], a
    ld a, [hl]
    ld [wCBAB], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4BEC::
    ld hl, vTiles1 + $595
    call StoreHLInWC924_B85
    ld a, $01
    ld [wC923], a
    ret
    db $D0, $10, $C0, $20, $D0, $30, $E0, $20

Jump_085_4C00::
    farcall Func_05F_6D78
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_085_4C18
    ld hl, $0BA3
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4C18::
    ld hl, $4BA4
    call StoreHLInWC924_B85
    ld a, $02
    ld [wC923], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E5F)
; reads: wC923
Func_085_4C24::
    ld a, [wC923]
    rst $00
    dw Jump_085_4D69
    dw Func_085_57F3
    dw Jump_085_57E9
    dw Jump_085_4D30
    dw Jump_085_57E9
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4D29
    dw Jump_085_4CC6
    dw Jump_085_4CBC
    dw Jump_085_4CBC
    dw Jump_085_57E9
    dw Jump_085_4C46
    dw Jump_085_57E9
    dw Func_085_57F3

Jump_085_4C46::
    ld a, [wC921]
    or a, a
    jr nz, Jump_085_4C51
    ld a, $65
    call StoreWC60B

Jump_085_4C51::
    ld a, [wC921]
    push af
    sra a
    ld [wC921], a
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    pop af
    ld [wC921], a
    ld a, [wC921]
    and a, $01
    jr nz, Jump_085_4C7F
    ld a, [wCBA6]
    inc a
    and a, $03
    ld [wCBA6], a

Jump_085_4C7F::
    ld a, [wCBAA]
    dec a
    dec a
    ld [wCBAA], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $40
    ret nz
    ld hl, $0B2C
    call StoreHLInWC924_B85
    ld a, $04
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $01
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld de, $002A
    call SetFlagBit
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4CBC::
    ld de, wCBAB
    ld hl, $0B2B
    call Func_085_57A2
    ret

Jump_085_4CC6::
    ld a, $0E
    ldh [hFF8D], a
    ld a, [wC921]
    or a, a
    jr nz, Jump_085_4CD5
    ld a, $65
    call StoreWC60B

Jump_085_4CD5::
    ld a, [wC921]
    push af
    sra a
    ld [wC921], a
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    pop af
    ld [wC921], a
    ld a, [wC921]
    and a, $01
    jr nz, Jump_085_4D03
    ld a, [wCBA6]
    inc a
    and a, $03
    ld [wCBA6], a

Jump_085_4D03::
    ld a, [wCBAA]
    inc a
    inc a
    ld [wCBAA], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $40
    ret nz
    ld a, $72
    call StoreWC60B
    ld a, [wCB96]
    ld [wCBA6], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4D29::
    farcall Func_012_61EF
    ret

Jump_085_4D30::
    ld a, [wC552]
    or a, a
    jr nz, Jump_085_4D55
    ld hl, vTiles1 + $32A
    call StoreHLInWC924_B85
    ld a, [wCB96]
    add a, a
    ld hl, $4D61
    add_a_to_hl
    ld a, [hl+]
    ld [wCBAA], a
    ld a, [hl]
    ld [wCBAB], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4D55::
    ld hl, vTiles1 + $595
    call StoreHLInWC924_B85
    ld a, $01
    ld [wC923], a
    ret
    db $D0, $10, $C0, $20, $D0, $30, $E0, $20

Jump_085_4D69::
    farcall Func_05F_6D78
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_085_4D81
    ld hl, $0B28
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4D81::
    ld hl, $4B29
    call StoreHLInWC924_B85
    ld a, $02
    ld [wC923], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E58)
; reads: wD7F5
; writes: hFFC7, hFFC8, hFFC9, wC919
Func_085_4D8D::
    ld a, $01
    ldh [hFFC7], a
    ld a, [wD7F5]
    ldh [hFFC8], a
    ld a, $01
    ldh [hFFC9], a
    farcall Func_001_6E46
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4EB3)
; reads: wC923
Func_085_4DA6::
    ld a, [wC923]
    rst $00
    dw Jump_085_4EAA
    dw Jump_085_4E1F
    dw Jump_085_4DE8
    dw Jump_085_4DB2

Jump_085_4DB2::
    ld a, [wC921]
    and a, $07
    jr nz, Jump_085_4DD8
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    swap a
    ld hl, wCB86
    add_a_to_hl
    push hl
    call NextRandomSeed
    ld a, [wCD04]
    and a, $01
    add a, a
    inc a
    pop hl
    ld [hl], a

Jump_085_4DD8::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $3C
    ret nz
    ld a, $80
    ld [wC919], a
    ret

Jump_085_4DE8::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $01
    ret nz
    xor a, a
    ld [wC921], a
    ld a, [wC922]
    cp a, $05
    jr z, Jump_085_4E06
    inc a
    ld [wC922], a
    ld hl, wC923
    dec [hl]
    ret

Jump_085_4E06::
    ld a, [wCC38]
    set 3, a
    ld [wCC38], a
    ld hl, wC923
    inc [hl]
    ld de, $0056
    call TestFlagBit
    ret c
    ld a, $80
    ld [wC919], a
    ret

Jump_085_4E1F::
    ld a, [wC922]
    add a, a
    add a, a
    add a, a
    ld hl, $4E7A
    add_a_to_hl
    ld a, [wC921]
    and a, $01
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $93
    ld hl, wC198
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_085_4E61
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld b, $93
    ld hl, wD000
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

Jump_085_4E61::
    farcall Func_05F_6DDB
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $04
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret
    db $91, $5A
    dw Data_085_6124
    db $36, $5B
    dw Data_085_6153
    db $36, $5B
    dw Data_085_6153
    db $E9, $5B
    dw Data_085_6194
    db $E9, $5B
    dw Data_085_6194
    db $99, $5C
    dw Data_085_61CF
    db $99, $5C
    dw Data_085_61CF
    db $4B, $5D
    dw Data_085_6208
    db $4B, $5D
    dw Data_085_6208
    db $F5, $5D
    dw Data_085_623C
    db $F5, $5D
    dw Data_085_623C
    db $96, $5E
    dw Data_085_6266

Jump_085_4EAA::
    ld de, $0056
    call TestFlagBit
    jr nc, Jump_085_4F0B
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $03
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z

Jump_085_4F0B::
    xor a, a
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4EF2)
; reads: wC923
Func_085_4F14::
    ld a, [wC923]
    rst $00
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F9E
    dw Jump_085_4F8E
    dw Jump_085_57E9
    dw Jump_085_4F52
    dw Jump_085_4F3A
    dw Jump_085_4F34
    dw Jump_085_4F2E

Jump_085_4F2E::
    ld a, $80
    ld [wC919], a
    ret

Jump_085_4F34::
    ld b, $1E
    call Func_085_4FD8
    ret

Jump_085_4F3A::
    ld a, [wCBAA]
    inc a
    inc a
    inc a
    inc a
    ld [wCBAA], a
    cp a, $60
    ret nz
    ld hl, wCBAC
    call ClearBit1AtHL_Bank85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4F52::
    ld a, $03
    ld [wCB86], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $04
    ret c
    push af
    ld a, $66
    call StoreWC60B
    xor a, a
    ld [wCB86], a
    pop af
    cp a, $08
    ret nz
    ld a, $01
    ld [wCB86], a
    ld hl, wCBAC
    call ClearBit2AtHL_Bank85
    ld hl, wCBAC
    call SetBit1AtHL_Bank85
    ld a, $03
    ld [wCBA6], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4F8E::
    ld a, $03
    ld [wCB86], a
    ld hl, $0737
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_4F9E::
    ld hl, wCBAC
    call Func_085_576A
    ld a, [wC921]
    or a, a
    jr nz, Jump_085_4FBE
    ld a, [wCBAB]
    inc a
    ld [wCBAB], a
    cp a, $48
    ret nz
    ld a, $63
    call StoreWC60B
    ld hl, wC921
    inc [hl]
    ret

Jump_085_4FBE::
    ld a, [wCBAB]
    dec a
    dec a
    ld [wCBAB], a
    cp a, $40
    ret nz
    farcall Func_05F_6E09
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_085_4F14)
; reads: wC5F0, hScrollX, hFFA2, wC921
; writes: hScrollX, hFFA2, wC921
; points at: wC923
Func_085_4FD8::
    ld a, [wC5F0]
    and a, $03
    bit 0, a
    jr nz, Jump_085_5003
    dec a
    add a, a
    ld c, a
    bit 7, a
    jr z, Jump_085_4FF8
    cpl
    inc a
    ld c, a
    ldh a, [hScrollX]
    sub a, c
    ldh [hScrollX], a
    ldh a, [hFFA2]
    sbc a, $00
    ldh [hFFA2], a
    jr Jump_085_5003

Jump_085_4FF8::
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a
    ldh a, [hFFA2]
    adc a, $00
    ldh [hFFA2], a

Jump_085_5003::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, b
    ret nz
    xor a, a
    ldh [hScrollX], a
    ldh [hFFA2], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4F3F)
; reads: wC923
Func_085_501A::
    ld a, [wC923]
    rst $00
    dw Jump_085_5022
    dw Func_085_57F3

Jump_085_5022::
    ld hl, wC923
    inc [hl]
    ldh a, [hFF90]
    ld c, a
    ld de, $5041

Jump_085_502C::
    ld a, [de]
    cp a, $FF
    ret z
    ld a, [de]
    cp a, c
    jr z, Jump_085_5038
    inc de
    inc de
    jr Jump_085_502C

Jump_085_5038::
    inc de
    ld a, [de]
    ld l, a
    ld h, $0C
    call StoreHLInWC924_B85
    ret
    db $CA, $4A, $CB, $4B, $CC, $4C, $CD, $4D, $D3, $4E, $D4, $4F, $D5, $50, $D6, $51
    db $DC, $52, $DD, $53, $DE, $54, $DF, $55, $FF

; 1 call site from 1 routine (e.g. Func_010_4E89)
; reads: hFF98
; writes: wC8EF, wC919
Func_085_505A::
    ldh a, [hFF98]
    ld [wC8EF], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E27)
; reads: wC923
Func_085_5065::
    ld a, [wC923]
    rst $00
    dw Jump_085_5086
    dw Jump_085_57E9
    dw Jump_085_506F

Jump_085_506F::
    xor a, a
    ld [wC923], a
    ld a, [wC922]
    inc a
    ld [wC922], a
    ld c, a
    ld a, [wC6FD]
    cp a, c
    ret nz
    ld a, $80
    ld [wC919], a
    ret

Jump_085_5086::
    ld hl, wC923
    inc [hl]
    ld a, $0A
    ld [rRAMG], a
    ld hl, wC6FE
    ld a, [wC922]
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, $01
    call Func_000_1FA4
    ld hl, wC8CF
    ld de, wC147
    ld b, $0A

Jump_085_50A9::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_085_50A9
    ld a, $F0
    ld [de], a
    pop af
    push af
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld e, a
    pop af
    ld c, $57
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC6]
    cp a, e
    jr nz, Jump_085_50D2
    ld hl, wCA56
    call StoreHLInWC924_B85
    ret

Jump_085_50D2::
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wC17E
    ld a, [wC8C1]
    or a, a
    jr z, Jump_085_50E3
    ld [de], a
    inc de

Jump_085_50E3::
    ld a, [wC8C2]
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ld hl, wCA55
    call StoreHLInWC924_B85
    ret

; 1 call site from 1 routine (e.g. Func_010_4F07)
; reads: wC923
Func_085_50F2::
    ld a, [wC923]
    rst $00
    dw Jump_085_521E
    dw Jump_085_51FB
    dw Jump_085_57E9
    dw Jump_085_51DC
    dw Jump_085_51A5
    dw Jump_085_5173
    dw Jump_085_57E9
    dw Jump_085_5123
    dw Jump_085_510A
    dw Func_085_57F3

Jump_085_510A::
    ld a, $E0
    ld [wCB8B], a
    ld a, $20
    ld [wCB9B], a
    ld hl, $078D
    call StoreHLInWC924_B85
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5123::
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_085_5130
    bit 1, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_5130::
    cp a, $3C
    jr nc, Jump_085_513A
    bit 2, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_513A::
    bit 3, a
    jr z, Jump_085_5140
    jr Jump_085_514C

Jump_085_5140::
    ld a, $20
    ld [wCB8B], a
    ld a, $E0
    ld [wCB9B], a
    jr Jump_085_5156

Jump_085_514C::
    ld a, $E0
    ld [wCB8B], a
    ld a, $20
    ld [wCB9B], a

Jump_085_5156::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    ld a, $E0
    ld [wCB8B], a
    ld a, $20
    ld [wCB9B], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5173::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $01
    jr z, Jump_085_5181
    call Func_085_5190

Jump_085_5181::
    ld a, [wC921]
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_085_50F2)
; reads: wC5E8
; writes: wCB9A
Func_085_5190::
    call NextTableByte
    ld a, [wC5E8]
    and a, $03
    cp a, $03
    jr z, Func_085_5190
    dec a
    ld c, a
    ld a, $40
    add a, c
    ld [wCB9A], a
    ret

Jump_085_51A5::
    ld a, [wC922]
    and a, $03
    cp a, $03
    jr z, Jump_085_51B9
    ld de, $015F
    add a, e
    ld e, a
    jr nc, Jump_085_51B6
    inc d

Jump_085_51B6::
    call SetFlagBit

Jump_085_51B9::
    ld de, $0162
    call TestFlagBit
    jr c, Jump_085_51C7
    ld a, $80
    ld [wC919], a
    ret

Jump_085_51C7::
    ld de, $0163
    call SetFlagBit
    ld hl, $0779
    call StoreHLInWC924_B85
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_51DC::
    ld a, [wC922]
    and a, $03
    ld de, $51F7
    add a, e
    ld e, a
    jr nc, Jump_085_51E9
    inc d

Jump_085_51E9::
    ld a, [de]
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret
    db $0D, $0E, $0F, $10

Jump_085_51FB::
    ld a, [wC922]
    and a, $03
    add a, a
    ld de, $5216
    add a, e
    ld e, a
    jr nc, Jump_085_5209
    inc d

Jump_085_5209::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret
    db $6C, $07, $6F, $07, $72, $07, $75, $07

Jump_085_521E::
    ld hl, wC923
    inc [hl]
    xor a, a
    ld [wC922], a
    ld de, $015F
    call TestFlagBit
    ret nc
    ld hl, wC922
    inc [hl]
    ld de, $0160
    call TestFlagBit
    ret nc
    ld hl, wC922
    inc [hl]
    ld de, $0161
    call TestFlagBit
    ret nc
    ld hl, wC922
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4DE1)
; reads: wC923
Func_085_5248::
    ld a, [wC923]
    rst $00
    dw Jump_085_5302
    dw Jump_085_52ED
    dw Jump_085_52C8
    dw Jump_085_5290
    dw Jump_085_57E9
    dw Jump_085_5302
    dw Jump_085_52ED
    dw Jump_085_52C8
    dw Jump_085_5290
    dw Jump_085_57E9
    dw Jump_085_5302
    dw Jump_085_52ED
    dw Jump_085_52C8
    dw Jump_085_5290
    dw Jump_085_57E9
    dw Jump_085_526C

Jump_085_526C::
    ld hl, wC61D

Jump_085_526F::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_085_527A
    or a, a
    jr z, Jump_085_527A
    inc hl
    jr Jump_085_526F

Jump_085_527A::
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $38
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ld a, $80
    ld [wC919], a
    ret

Jump_085_5290::
    ld a, [wCB86]
    or a, a
    jr nz, Jump_085_52A0
    ld a, [wCBD4]
    inc a
    inc a
    ld [wCBD4], a
    jr Jump_085_52B8

Jump_085_52A0::
    dec a
    jr nz, Jump_085_52AD
    ld hl, wCBD3
    inc [hl]
    ld hl, wCBD4
    inc [hl]
    jr Jump_085_52B8

Jump_085_52AD::
    dec a
    jr z, Jump_085_52B8
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    inc [hl]

Jump_085_52B8::
    ld de, wCBD4
    call Func_085_5780
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_52C8::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $3C
    ret nz
    ld a, [wC922]
    ld hl, $052C
    add_a_to_hl
    call StoreHLInWC924_B85
    xor a, a
    ld [wC921], a
    ld hl, wC922
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_085_52ED::
    ld a, $80
    ld [wCBCF], a
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_085_5780
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5302::
    ld a, [wC922]
    ld hl, $5329
    add_a_to_hl
    ld a, [hl]
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
Func_085_5329:: ; heuristic: follows a terminator; C0
    inc bc
    ld [$FA0A], sp
    inc hl
    ret
    db $C7, $DF, $53, $E9, $57
    dw Func_085_53C3
    dw Func_085_53A2
    dw Func_085_5361
    dw Func_085_533C

; no direct call (reached through a table, a jump or a vector)
; reads: hFF90, hFF8F
; writes: wCB7D, wC919
Func_085_533C:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wCB7D], a
    ldh a, [hFF90]
    cp a, $96
    jr nz, Jump_085_534B
    ld de, $0201
    jr Jump_085_5358

Jump_085_534B::
    ld de, $00B9
    ldh a, [hFF8F]
    or a, a
    jr z, Jump_085_5358
    inc de
    dec a
    jr z, Jump_085_5358
    inc de

Jump_085_5358::
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFF90, wC92C
; writes: wC928, wC929, wC92A, wCB86
; points at: wC923
Func_085_5361:: ; heuristic: target of a pointer table; C0
    ld a, $E0
    ld [wC928], a
    xor a, a
    ld [wC929], a
    ldh a, [hFF90]
    cp a, $96
    jr z, Jump_085_5389
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5389::
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFF90, hFFC6
; writes: hFFC7, hFFC6, wC923
Func_085_53A2:: ; heuristic: target of a pointer table; C0
    ld a, $20
    ldh [hFFC7], a
    ldh a, [hFF90]
    cp a, $96
    jr nz, Jump_085_53B0
    ld a, $40
    ldh [hFFC7], a

Jump_085_53B0::
    xor a, a
    ldh [hFFC6], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $05
    ld [wC923], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC922
; writes: wC923, hFFC6
; points at: wC923
Func_085_53C3:: ; heuristic: target of a pointer table; C0
    ld a, [wC922]
    cp a, $01
    jr nz, Jump_085_53D0
    ld a, $04
    ld [wC923], a
    ret

Jump_085_53D0::
    ld a, $1B
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFF93, hFF95, hFF94
; writes: wC922
; points at: wC923
Func_085_53DF:: ; heuristic: follows a terminator; C0
    ld hl, wC923
    inc [hl]
    ldh a, [hFF93]
    bit 7, a
    jr z, Jump_085_53ED
    and a, $01
    jr z, Jump_085_53F9

Jump_085_53ED::
    ld a, $00
    ld [wC922], a
    ld hl, $0473
    call StoreHLInWC924_B85
    ret

Jump_085_53F9::
    ldh a, [hFF95]
    cp a, $00
    jr nz, Jump_085_53ED
    ldh a, [hFF94]
    cp a, $D6
    jr nz, Jump_085_5411
    ld a, $01
    ld [wC922], a
    ld hl, $0475
    call StoreHLInWC924_B85
    ret

Jump_085_5411::
    cp a, $EC
    jr nz, Jump_085_53ED
    ld a, $02
    ld [wC922], a
    ld hl, $0474
    call StoreHLInWC924_B85
    ret

; 1 call site from 1 routine (e.g. Func_010_4CBB)
; reads: wC923
Func_085_5421::
    ld a, [wC923]
    rst $00
    dw Jump_085_542B
    dw Jump_085_57E9
    dw Jump_085_5441

Jump_085_542B::
    ld hl, wC923
    inc [hl]
    ldh a, [hFF90]
    cp a, $43
    jr z, Jump_085_543A
    ld hl, wC923
    inc [hl]
    ret

Jump_085_543A::
    ld hl, $085D
    call StoreHLInWC924_B85
    ret

Jump_085_5441::
    ldh a, [hFF90]
    cp a, $37
    jr nz, Jump_085_544B
    ld a, $10
    jr Jump_085_5455

Jump_085_544B::
    cp a, $42
    jr nz, Jump_085_5453
    ld a, $60
    jr Jump_085_5455

Jump_085_5453::
    ld a, $30

Jump_085_5455::
    ldh [hFFC7], a
    ld a, $00
    ldh [hFFC6], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wCB7D], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C60)
; reads: wC923
Func_085_546F::
    ld a, [wC923]
    rst $00
    dw Jump_085_55D0
    dw Jump_085_55C7
    dw Jump_085_57E9
    dw Jump_085_5581
    dw Jump_085_5562
    dw Jump_085_554F
    dw Jump_085_5514
    dw Jump_085_57E9
    dw Jump_085_5485

Jump_085_5485::
    ld a, $01
    ld [wC929], a
    ld b, $03
    ld hl, wCB9A

Jump_085_548F::
    push bc
    push hl
    ld a, [hl]
    cp a, $50
    jr z, Jump_085_54A8
    ld a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    jr Jump_085_54B8

Jump_085_54A8::
    ld a, $00
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall Func_05F_6B54

Jump_085_54B8::
    ld hl, wC929
    inc [hl]
    pop hl
    ld a, $10
    add_a_to_hl
    pop bc
    dec b
    jr nz, Jump_085_548F
    ld a, [wCBBA]
    cp a, $50
    jr nz, Jump_085_54D4
    ld a, $01
    ld [wC921], a

Jump_085_54D4::
    ld a, [wC921]
    or a, a
    ret z
    ld a, [wCBCA]
    cp a, $50
    jr z, Jump_085_54F1
    ld a, $03
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_085_54F1::
    ld a, $00
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCB7D], a
    xor a, a
    ldh [hFF8D], a
    ld a, $80
    ld [wC919], a
    ret

Jump_085_5514::
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $03
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $04
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $0186
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_554F::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5562::
    ld a, $02
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5581::
    ld a, [wC921]
    and a, $0F
    jr nz, Jump_085_55A9
    call NextRandomSeed
    ld a, [wCD03]
    and a, $03
    inc a
    swap a
    ld hl, wCB86
    add_a_to_hl
    push hl
    call NextTableByte
    ld a, [wC5E8]
    and a, $01
    sla a
    inc a
    pop hl
    ld [hl], a

Jump_085_55A9::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $F0
    ret nz
    ld a, $02
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_55C7::
    ld a, $0E
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_55D0::
    ld a, $26
    ldh [hFF90], a
    xor a, a
    ldh [hFF8F], a
    ldh [hFF92], a
    ld a, $60
    ld [wC8C8], a
    ld a, $20
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld hl, $0185
    call StoreHLInWC924_B85
    ret

; 1 call site from 1 routine (e.g. Func_010_4C52)
; reads: wC923
Func_085_55F5::
    ld a, [wC923]
    rst $00
    dw Jump_085_566F
    dw Jump_085_566F
    dw Jump_085_5664
    dw Jump_085_57E9
    dw Jump_085_5647
    dw Jump_085_561E
    dw Jump_085_5607

Jump_085_5607::
    ld a, [wCB9B]
    dec a
    dec a
    ld [wCB9B], a
    cp a, $10
    ret nz
    ld hl, wCB9C
    call ClearBit1AtHL_Bank85
    ld a, $80
    ld [wC919], a
    ret

Jump_085_561E::
    xor a, a
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wCB9C
    call SetBit1AtHL_Bank85
    ld a, $63
    call StoreWC60B
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5647::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $01
    ret z
    ld a, [wCB8B]
    inc a
    ld [wCB8B], a
    cp a, $60
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_085_5664::
    ld hl, $0172
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_566F::
    ld de, wCB8B
    call Func_085_5780
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C0C)
; reads: wC923
Func_085_567B::
    ld a, [wC923]
    rst $00
    dw Jump_085_571A
    dw Jump_085_57E9
    dw Jump_085_56FF
    dw Jump_085_57E9
    dw Jump_085_5689

Jump_085_5689::
    ld a, [wC921]
    or a, a
    jr nz, Jump_085_5694
    ld a, $65
    call StoreWC60B

Jump_085_5694::
    ld a, [wC922]
    or a, a
    jr nz, Jump_085_56A4
    ld a, [wCBD3]
    dec a
    dec a
    ld [wCBD3], a
    jr Jump_085_56B3

Jump_085_56A4::
    ld a, [wC921]
    ld hl, $56DF
    add_a_to_hl
    ld a, [hl]
    ld [wCBD3], a

Jump_085_56B3::
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
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
    ld a, $80
    ld [wC919], a
    ret
    db $42, $45, $47, $4A, $4C, $4F, $51, $54, $56, $59, $5B, $5E, $60, $63, $65, $68
    db $6A, $6D, $6F, $72, $74, $77, $79, $7C, $7E, $81, $83, $86, $88, $8B, $8D, $90

Jump_085_56FF::
    ld a, $80
    ld [wCBCF], a
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_085_5780
    ret nc
    ld hl, $0084
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ret

Jump_085_571A::
    ld a, $02
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld hl, $0083
    call StoreHLInWC924_B85
    ld hl, wC923
    inc [hl]
    ldh a, [hFF8E]
    or a, a
    jr nz, Jump_085_574E
    ld a, $01
    ldh [hFF98], a
    ld [wC8EF], a
    ld a, $03
    ld [wCB86], a
    xor a, a
    ld [wC922], a
    ret

Jump_085_574E::
    ld a, $03
    ldh [hFF98], a
    ld [wC8EF], a
    ld a, $01
    ld [wCB86], a
    ld a, $01
    ld [wC922], a
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. Func_085_55F5, Func_085_4F14)
SetBit1AtHL_Bank85:: ; heuristic: follows a terminator; C0
Func_085_5760:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. Func_085_55F5, Func_085_4F14)
ClearBit1AtHL_Bank85:: ; heuristic: follows a terminator; C0
Func_085_5765:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; 1 call site from 1 routine (e.g. Func_085_4F14)
Func_085_576A:: ; heuristic: follows a terminator; C0
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. Func_085_4F14)
ClearBit2AtHL_Bank85:: ; heuristic: follows a terminator; C0
Func_085_576F:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC921
Func_085_5774:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; 5 call sites from 4 routines (e.g. Func_085_567B, Func_085_55F5, Func_085_5248, Func_085_4AEE)
; reads: wC921
; writes: wC928, wC929, wC921
Func_085_5780::
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
    jr z, Jump_085_579C
    sub a, a
    ret

Jump_085_579C::
    xor a, a
    ld [wC921], a
    scf
    ret

; 2 call sites from 2 routines (e.g. Func_085_4C24, Func_085_4B0F)
; reads: wC921
; writes: wC928, wC929, wC921
; points at: wC923
Func_085_57A2:: ; heuristic: follows a terminator; C0
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
    call StoreHLInWC924_B85
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 56 call sites from 25 routines (e.g. Func_085_567B, Func_085_57A2, Func_085_55F5, Func_085_546F, ...)
; writes: wC924, wC925, wC926
StoreHLInWC924_B85::
Func_085_57C8:: ; address name
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; 5 call sites from 5 routines (e.g. Func_085_57D5, Func_085_57F3, Func_085_4207, Func_085_4047, ...)
; reads: wC926
; writes: wC928
Func_085_57D5::
    ld [wC928], a
    farcall Func_05F_6936
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_085_57E7
    sub a, a
    ret

Jump_085_57E7::
    scf
    ret

Jump_085_57E9::
    xor a, a
    call Func_085_57D5
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC919
Func_085_57F3:: ; heuristic: follows a terminator; C0
    xor a, a
    call Func_085_57D5
    ret nc
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD, hFFC6
; writes: hFFC6, rRAMG
; points at: wC6FE
Func_085_57FE:: ; heuristic: follows a terminator; C0
    ld a, [wC6FD]
    or a, a
    jr nz, Jump_085_5808

Jump_085_5804::
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_5808::
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wC6FE

Jump_085_5811::
    push bc
    ld a, [hl]
    ld c, $6F
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hFFC6]
    cp a, $C0
    jr c, Jump_085_582D
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_085_5837

Jump_085_582D::
    inc hl
    dec b
    jr nz, Jump_085_5811
    xor a, a
    ld [rRAMG], a
    jr Jump_085_5804

Jump_085_5837::
    xor a, a
    ld [rRAMG], a
    ld a, $01
    ldh [hFFC6], a
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: wC6FD, hFFC6, hFFC7
; writes: rRAMG, hFFC6
; points at: wC6FE
Func_085_5840::
    ld a, [wC6FD]
    or a, a
    jr nz, Jump_085_584E

Jump_085_5846::
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_584E::
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wC6FE

Jump_085_5857::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_085_5875
    push bc
    ld a, [hl]
    ld c, $6B
    call LoadSRAMRecordWord
    pop bc
    ldh a, [hFFC6]
    ld c, a
    ldh a, [hFFC7]
    or a, c
    jr nz, Jump_085_5846

Jump_085_5875::
    inc hl
    dec b
    jr nz, Jump_085_5857
    xor a, a
    ld [rRAMG], a
    ld a, $01
    ldh [hFFC6], a
    ret

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: hFF93, hFF94, hFF95, wC6FD, hFFC6, hFFC7
; writes: hFFC6, rRAMG
; points at: wC6FE
Func_085_5882::
    ldh a, [hFF93]
    bit 7, a
    jr z, Jump_085_58B3
    and a, $01
    jr nz, Jump_085_58B3
    ld de, $5912
    ldh a, [hFF94]
    ld l, a
    ldh a, [hFF95]
    ld h, a

Jump_085_5895::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_58B2
    ld a, [de]
    cp a, l
    jr nz, Jump_085_58AD
    inc de
    ld a, [de]
    cp a, h
    jr nz, Jump_085_58AD
    pop de
    ld a, $01
    ldh [hFFC6], a
    ret

Jump_085_58AD::
    pop de
    inc de
    inc de
    jr Jump_085_5895

Jump_085_58B2::
    pop de

Jump_085_58B3::
    ld a, [wC6FD]
    or a, a
    jr nz, Jump_085_58BD
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_58BD::
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wC6FE

Jump_085_58C6::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_085_58FD
    push bc
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    pop bc
    ld de, $5912

Jump_085_58DF::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_58FC
    ldh a, [hFFC6]
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_085_58F7
    inc de
    ldh a, [hFFC7]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_085_5909

Jump_085_58F7::
    pop de
    inc de
    inc de
    jr Jump_085_58DF

Jump_085_58FC::
    pop de

Jump_085_58FD::
    inc hl
    dec b
    jr nz, Jump_085_58C6
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_5909::
    pop de
    ld a, [wC6FD]
    sub a, b
    inc a
    ldh [hFFC6], a
    ret
    db $09, $00, $0E, $00, $11, $00, $12, $00, $16, $00, $18, $00, $19, $00, $2B, $00
    db $38, $00, $40, $00, $41, $00, $94, $00, $C6, $00, $EC, $00, $01, $01, $05, $01
    db $19, $01, $1B, $01, $1F, $01, $20, $01, $24, $01, $26, $01, $27, $01, $29, $01
    db $2A, $01, $2F, $01, $30, $01, $35, $01, $37, $01, $00, $00

; 1 call site from 1 routine (e.g. Func_013_405C)
; reads: hFF93, hFF94, hFF95
; writes: hFFC6
Func_085_594E::
    ld de, $0000
    call TestFlagBit
    jr c, Jump_085_598C
    ldh a, [hFF93]
    bit 7, a
    jr z, Jump_085_5960
    and a, $01
    jr z, Jump_085_5964

Jump_085_5960::
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_5964::
    ld de, $5991
    ldh a, [hFF94]
    ld l, a
    ldh a, [hFF95]
    ld h, a

Jump_085_596D::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr nz, Jump_085_597B
    pop de
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_597B::
    ld a, [de]
    cp a, l
    jr nz, Jump_085_5987
    inc de
    ld a, [de]
    cp a, h
    jr nz, Jump_085_5987
    pop de
    jr Jump_085_598C

Jump_085_5987::
    pop de
    inc de
    inc de
    jr Jump_085_596D

Jump_085_598C::
    ld a, $02
    ldh [hFFC6], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $215991, $43
    dw Data_085_5A00
    dw Data_085_5B00
    dw Data_085_6500
    dw Data_085_6A00
    dw Data_085_6D00
    dw Data_085_6F00
    dw Data_085_7000
    dw Data_085_7100
    dw Data_085_7300
    dw Data_085_7400
    dw Data_085_7600
    db $00, $84, $00, $8D, $00, $8E, $00, $91, $00, $92, $00, $93, $00, $94, $00, $95
    db $00, $96, $00, $97, $00, $99

Data_085_5A00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $215A00, $75

; 3 call sites from 1 routine (e.g. Func_013_405C)
; reads: hFF93, hFF95, hFF94
; writes: hFFC6, hFFC7
Func_085_5A75::
    ldh a, [hFF93]
    bit 7, a
    jr z, Jump_085_5A7F
    and a, $01
    jr z, Jump_085_5A83

Jump_085_5A7F::
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_5A83::
    ldh a, [hFF95]
    cp a, $00
    jr nz, Jump_085_5A91
    ldh a, [hFF94]
    cp a, $F6
    jr c, Jump_085_5A7F
    jr Jump_085_5A98

Jump_085_5A91::
    dec a
    jr nz, Jump_085_5A7F
    cp a, $11
    jr nc, Jump_085_5A7F

Jump_085_5A98::
    ld a, $01
    ldh [hFFC7], a
    ret

; 1 call site from 1 routine (e.g. Func_013_746A)
; reads: wC6FD, hFFC6, hFFC7
; writes: rRAMG, hFFC6
; points at: wC6FE
Func_085_5A9D:: ; heuristic: follows a terminator; C0
    ld a, [wC6FD]
    or a, a
    ret z
    ld b, a
    ld a, $0A
    ld [rRAMG], a
    ld hl, wC6FE

Jump_085_5AAB::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop bc
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_085_5AE2
    push bc
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    pop bc
    ld de, $5AF8

Jump_085_5AC4::
    push de
    ld a, [de]
    inc de
    ld c, a
    ld a, [de]
    dec de
    or a, c
    jr z, Jump_085_5AE1
    ldh a, [hFFC6]
    ld c, a
    ld a, [de]
    cp a, c
    jr nz, Jump_085_5ADC
    inc de
    ldh a, [hFFC7]
    ld c, a
    ld a, [de]
    cp a, c
    jr z, Jump_085_5AEE

Jump_085_5ADC::
    pop de
    inc de
    inc de
    jr Jump_085_5AC4

Jump_085_5AE1::
    pop de

Jump_085_5AE2::
    inc hl
    dec b
    jr nz, Jump_085_5AAB
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hFFC6], a
    ret

Jump_085_5AEE::
    pop de
    xor a, a
    ld [rRAMG], a
    ld a, $01
    ldh [hFFC6], a
    ret
    db $61, $01, $64, $01, $67, $01, $69, $01

Data_085_5B00:: ; heuristic: target of a monotone pointer table; C0
    db $74, $01, $00, $00

; 13 call sites from 8 routines (e.g. Func_013_5C0B, Func_013_5EF4, Func_013_70D9, Func_013_7598, ...)
; writes: hFFC6, hFFC7
; points at: wD09D
Func_085_5B04::
    farcall Func_016_5AC0
    ld hl, $0000
    ld de, wD09D
    ld b, $0B

Jump_085_5B12::
    ld a, [de]
    add_a_to_hl
    inc de
    dec b
    jr nz, Jump_085_5B12
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ret

; 4 call sites from 3 routines (e.g. Func_013_7598, Func_085_48A0, Func_085_494D)
; reads: hFFC6
; writes: hFFC6
; points at: wC707
Func_085_5B23:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    ld c, a
    ld hl, wC707
    ld b, $20

Jump_085_5B2B::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_085_5B4E
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_085_5B45
    pop hl
    ld a, [hl]
    and a, $3F
    cp a, c
    jr nz, Jump_085_5B46
    ld a, $01
    ldh [hFFC6], a
    ret

Jump_085_5B45::
    pop hl

Jump_085_5B46::
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_085_5B2B
    ret

Jump_085_5B4E::
    pop hl
    xor a, a
    ldh [hFFC6], a
    ret

; 3 call sites from 2 routines (e.g. Func_002_4628, Func_012_469E)
; reads: hFF90, wC94A, wD7FF, wC82C, hFFC6, hFFC7, wCD04
; writes: wCB8A, wCB9A, wCBAA, wCBBA, wCB8B, wCB9B, wCBAB, wCBBB, ...
; points at: wCFDD, hFFC6, wCB91
Func_085_5B53::
    ldh a, [hFF90]
    cp a, $0B
    ret nz
    ld a, [wC94A]
    bit 7, a
    jr nz, Jump_085_5B67
    ld a, [wD7FF]
    or a, a
    jr z, Jump_085_5BA9
    jr Jump_085_5B6B

Jump_085_5B67::
    and a, $03
    jr z, Jump_085_5BA9

Jump_085_5B6B::
    ld a, $50
    ld [wCB8A], a
    ld [wCB9A], a
    ld [wCBAA], a
    ld [wCBBA], a
    ld a, $00
    ld [wCB8B], a
    ld a, $F0
    ld [wCB9B], a
    ld a, $E0
    ld [wCBAB], a
    ld a, $D0
    ld [wCBBB], a
    xor a, a
    ld [wCB86], a
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    ld a, $30
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    xor a, a
    ld [wCB7D], a

Jump_085_5BA9::
    ld a, [wC94A]
    bit 7, a
    jr nz, Jump_085_5BD0
    ld a, [wC82C]
    add a, a
    add a, a
    ld hl, $5C5E
    add_a_to_hl
    ld a, [wD7FF]
    add_a_to_hl
    ld a, [hl]
    ld [wCB81], a
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    jr Jump_085_5BE9

Jump_085_5BD0::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $1F
    ld hl, $5C72
    add_a_to_hl
    ld a, [hl]
    ld [wCB81], a
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a

Jump_085_5BE9::
    ld a, $01
    ldh [hFFC8], a
    ld a, $04
    ldh [hFFC9], a
    ld hl, vTiles0 + $400
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld b, $00
    ld de, wCFDD
    ld hl, vTiles0 + $500

Jump_085_5C08::
    push hl
    push de
    push bc
    ld a, b
    add a, $05
    ldh [hFFC9], a
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld a, [de]
    ld [wCFE6], a
    inc de
    ld a, [de]
    ld [wCFE7], a
    ld a, $02
    ldh [hFFC6], a
    ld de, hFFC6
    ld c, $00
    farcall Func_034_4008
    pop bc
    push bc
    ld a, b
    swap a
    ld hl, wCB91
    add_a_to_hl
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl], a
    xor a, a
    ldh [hFFC8], a
    farcall Func_004_431F
    pop bc
    pop de
    pop hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    inc de
    inc de
    inc b
    ld a, b
    cp a, $03
    jr nz, Jump_085_5C08
    ret
    db $06, $19, $18, $00, $15, $09, $16, $00, $14, $1E, $2A, $00, $0D, $2B, $12, $00
    db $28, $11, $20, $00, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $10, $11, $12, $13
    db $14, $15, $16, $1A, $1B, $1C, $1D, $21, $24, $25, $26, $28, $29, $2A, $2E, $2F
    db $33, $38, $39, $3D

; 1 call site from 1 routine (e.g. Func_012_5AE9)
; reads: wC8FE, wC935, wC634, wC5E7, wC195, wC924, wC925, wCD04, ...
; writes: wC956, wC919, wC922, wC8FE, wC8FF, wC900, wC921
; points at: wC923
Func_085_5C92::
    ld a, [wC8FE]
    cp a, $FF
    jr nz, Jump_085_5CB4
    ld a, [wC935]
    bit 7, a
    jr nz, Jump_085_5CB4
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_085_5CAA
    or a, a
    jr nz, Jump_085_5CB4

Jump_085_5CAA::
    call NextRandomSeed
    ld a, [wC5E7]
    and a, $1F
    jr z, Jump_085_5CBE

Jump_085_5CB4::
    xor a, a
    ld [wC956], a
    ld a, $80
    ld [wC919], a
    ret

Jump_085_5CBE::
    ld a, [wC195]
    swap a
    and a, $0F
    dec a
    jr nz, Jump_085_5CFC
    call Func_085_5D6F
    cp a, $05
    jr nc, Jump_085_5CD8
    ld a, $80
    ld [wC956], a
    ld a, $2C
    jr Jump_085_5D41

Jump_085_5CD8::
    farcall Func_061_4001
    call NextRandomSeed
    ld a, [wCD04]
    and a, $1F
    sub a, $10
    ld c, a
    ld a, [wCD05]
    add a, c
    bit 7, a
    jr z, Jump_085_5CF3
    ld a, $01

Jump_085_5CF3::
    or a, $80
    ld [wC956], a
    ld a, $2C
    jr Jump_085_5D41

Jump_085_5CFC::
    push af
    ld a, $80
    ld [wC956], a
    call Func_085_5D6F
    cp a, $32
    jr nc, Jump_085_5D0D
    ld a, $00
    jr Jump_085_5D2F

Jump_085_5D0D::
    cp a, $46
    jr nc, Jump_085_5D15
    ld a, $01
    jr Jump_085_5D2F

Jump_085_5D15::
    cp a, $50
    jr nc, Jump_085_5D1D
    ld a, $02
    jr Jump_085_5D2F

Jump_085_5D1D::
    cp a, $5A
    jr nc, Jump_085_5D25
    ld a, $03
    jr Jump_085_5D2F

Jump_085_5D25::
    cp a, $5F
    jr nc, Jump_085_5D2D
    ld a, $04
    jr Jump_085_5D2F

Jump_085_5D2D::
    ld a, $05

Jump_085_5D2F::
    ld c, a
    pop af
    dec a
    and a, $01
    add a, a
    add a, a
    add a, a
    add a, c
    ld hl, $5D7C
    add_a_to_hl
    ld a, [hl]

Jump_085_5D41::
    ld [wC922], a
    ld hl, $5D8C
    add_a_to_hl
    ld a, [hl]
    or a, a
    jp z, Jump_085_5CB4
    ld [wC8FE], a
    farcall Func_012_7179
    ld a, [wC924]
    ld [wC8FF], a
    ld a, [wC925]
    ld [wC900], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 2 call sites from 1 routine (e.g. Func_085_5C92)
; reads: wCD03
Func_085_5D6F::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $7F
    cp a, $63
    jr nc, Func_085_5D6F
    ret
    db $19, $1A, $1B, $1B, $1C, $2C, $00, $00, $01, $07, $28, $22, $0C, $2C, $00, $00
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0A, $06, $00, $01

; 1 call site from 1 routine (e.g. Func_013_7A9A)
; reads: wC6FD
; writes: rRAMG
; points at: wC6FE
Func_085_5DB9::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_085_5DC5::
    push hl
    ld a, [hl]
    ld c, $69
    call SRAMRecordAddress
    push hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, $0064
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, d
    cp a, $03
    jr c, Jump_085_5DE7
    jr nz, Jump_085_5DE4
    ld a, e
    cp a, $E7
    jr c, Jump_085_5DE7

Jump_085_5DE4::
    ld de, $03E7

Jump_085_5DE7::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_085_5DC5
    xor a, a
    ld [rRAMG], a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC7CC
Func_085_5DF5:: ; heuristic: follows a terminator; C0
    ld a, c
    ld de, $5E11
    or a, a
    jr z, Jump_085_5E05
    ld de, $5E41
    dec a
    jr z, Jump_085_5E05
    ld de, $5E71

Jump_085_5E05::
    ld b, $30
    ld hl, wC7CC

Jump_085_5E0A::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_085_5E0A
    ret
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $3F
    ds $21, $00
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $FF, $FF
    db $1F, $E0, $FF, $FF, $FF, $00, $FF, $FF, $FF, $03, $F8, $FF, $FF, $FF, $C1
    ds $11, $00
    db $FE, $FF, $FF, $07, $F0, $FF, $FF, $FF, $87, $FF, $FF, $FF, $7F, $FC, $FF, $FF
    db $1F, $E0, $FF, $FF, $FF, $00, $FF, $FF, $FF, $03, $F8, $FF, $FF, $FF, $C1, $FF
    db $FF, $FF, $01, $FE, $FF, $FF, $FF, $F1, $FF, $FF, $FF, $8F, $FF, $FF, $1F
    ds $284, $00

Data_085_6124:: ; heuristic: target of a monotone pointer table; C0
    ds $2F, $00

Data_085_6153:: ; heuristic: target of a monotone pointer table; C0
    ds $41, $00

Data_085_6194:: ; heuristic: target of a monotone pointer table; C0
    ds $3B, $00

Data_085_61CF:: ; heuristic: target of a monotone pointer table; C0
    ds $39, $00

Data_085_6208:: ; heuristic: target of a monotone pointer table; C0
    ds $34, $00

Data_085_623C:: ; heuristic: target of a monotone pointer table; C0
    ds $2A, $00

Data_085_6266:: ; heuristic: target of a monotone pointer table; C0
    ds $29A, $00

Data_085_6500:: ; heuristic: target of a monotone pointer table; C0
    ds $500, $00

Data_085_6A00:: ; heuristic: target of a monotone pointer table; C0
    ds $300, $00

Data_085_6D00:: ; heuristic: target of a monotone pointer table; C0
    ds $200, $00

Data_085_6F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_085_7000:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_085_7100:: ; heuristic: target of a monotone pointer table; C0
    ds $200, $00

Data_085_7300:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_085_7400:: ; heuristic: target of a monotone pointer table; C0
    ds $200, $00

Data_085_7600:: ; heuristic: target of a monotone pointer table; C0
    ds $A00, $00
