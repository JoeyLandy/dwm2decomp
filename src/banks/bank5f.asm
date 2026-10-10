SECTION "Bank 5F", ROMX[$4000], BANK[$5F]
    INCBIN "dwm2-cobi-us.gbc", $17C000, $2936

; 6 call sites from 6 routines (e.g. Func_05F_77C7, Func_00F_7F75, Func_012_6828, Func_073_7024, ...)
; reads: wC926
Func_05F_6936::
    ld a, [wC926]
    cp a, $FF
    jr nz, Jump_05F_693E
    ret

Jump_05F_693E::
    rst $00
    dw Jump_05F_6947
    dw Jump_05F_698D
    dw Jump_05F_69A2
    dw Jump_05F_69D2

Jump_05F_6947::
    ld a, [wC928]
    or a, a
    jr nz, Jump_05F_6953
    farcall Func_004_4470

Jump_05F_6953::
    ld a, [wC925]
    bit 7, a
    jr nz, Jump_05F_6988
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
    jr c, Jump_05F_6988
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_05F_6988::
    ld hl, wC926
    inc [hl]
    ret

Jump_05F_698D::
    ld a, [wC925]
    bit 7, a
    jr nz, Jump_05F_699A
    ld a, [wC8CB]
    and a, $03
    ret nz

Jump_05F_699A::
    call Func_05F_69F3
    ld hl, wC926
    inc [hl]
    ret

Jump_05F_69A2::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC925]
    bit 6, a
    jr nz, Jump_05F_69CD
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
    jr c, Jump_05F_69CD
    ld a, $82
    ld [wC8CB], a

Jump_05F_69CD::
    ld hl, wC926
    inc [hl]
    ret

Jump_05F_69D2::
    ld a, [wC925]
    bit 6, a
    jr nz, Jump_05F_69E1
    ld a, [wC8CB]
    and a, $03
    jr z, Jump_05F_69E1
    ret

Jump_05F_69E1::
    ld a, [wC928]
    or a, a
    jr nz, Jump_05F_69ED
    farcall Func_004_449F

Jump_05F_69ED::
    ld a, $FF
    ld [wC926], a
    ret

; 1 call site from 1 routine (e.g. Func_05F_6936)
; reads: wC924, wC925, wCC44
; writes: wStringIndex, wStringCategory
Func_05F_69F3::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a

; 1 call site from 1 routine (e.g. Func_05F_7969)
; reads: wCC44
; writes: wStringIndex, wStringCategory
Func_05F_69FB::
    ld a, [wCC44]
    cp a, $80
    jr z, Jump_05F_6A07
    bit 7, a
    jp nz, Jump_05F_6A85

Jump_05F_6A07::
    ld a, h
    and a, $3F
    ld h, a
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld a, h
    rst $00
    dw Jump_05F_6A31
    dw Jump_05F_6A38
    dw Jump_05F_6A3F
    dw Jump_05F_6A46
    dw Jump_05F_6A4D
    dw Jump_05F_6A54
    dw Jump_05F_6A5B
    dw Jump_05F_6A5B
    dw Jump_05F_6A62
    dw Jump_05F_6A69
    dw Jump_05F_6A69
    dw Jump_05F_6A70
    dw Jump_05F_6A77
    dw Jump_05F_6A7E

Jump_05F_6A31::
    farcall BeginStringDisplay_Bank28
    ret

Jump_05F_6A38::
    farcall Func_029_4001
    ret

Jump_05F_6A3F::
    farcall Func_02A_4001
    ret

Jump_05F_6A46::
    farcall Func_02B_4001
    ret

Jump_05F_6A4D::
    farcall Func_02C_4001
    ret

Jump_05F_6A54::
    farcall Func_02D_4001
    ret

Jump_05F_6A5B::
    farcall Func_02E_4001
    ret

Jump_05F_6A62::
    farcall Func_07C_4001
    ret

Jump_05F_6A69::
    farcall Func_080_4001
    ret

Jump_05F_6A70::
    farcall Func_082_4001
    ret

Jump_05F_6A77::
    farcall BeginStringDisplay_Bank86
    ret

Jump_05F_6A7E::
    farcall Func_089_4001
    ret

Jump_05F_6A85::
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank28
    ret

; 11 call sites from 7 routines (e.g. Func_00F_4FA1, Func_00F_6681, Func_00F_67BA, Func_00F_7625, ...)
; reads: hFF8C, hFF91, wC928
; writes: hFF8C, hFF98, hFF91, wC92C
Func_05F_6A94:: ; heuristic: follows a terminator; C0
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    xor a, a
    ldh [hFF98], a
    ldh a, [hFF91]
    call Func_05F_6B43
    ld a, [wC928]
    ld c, a
    ldh a, [hFF91]
    inc a
    ldh [hFF91], a
    cp a, c
    jr z, Jump_05F_6AB3
    xor a, a
    ld [wC92C], a
    ret

Jump_05F_6AB3::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wC92C], a
    ret

; 7 call sites from 6 routines (e.g. Func_00F_4FA1, Func_00F_5C3B, Func_00F_67BA, Func_00F_7E1E, ...)
; reads: hFF8C, hFF8E, wC928
; writes: hFF8C, hFF98, hFF8E, wC92C
Func_05F_6ABF:: ; heuristic: follows a terminator; C0
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $01
    ldh [hFF98], a
    ldh a, [hFF8E]
    call Func_05F_6B43
    ld a, [wC928]
    ld c, a
    ldh a, [hFF8E]
    inc a
    ldh [hFF8E], a
    cp a, c
    jr z, Jump_05F_6ADF
    xor a, a
    ld [wC92C], a
    ret

Jump_05F_6ADF::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wC92C], a
    ret

; 15 call sites from 8 routines (e.g. Func_00F_4FA1, Func_00F_5C3B, Func_00F_5F06, Func_00F_6681, ...)
; reads: hFF8C, hFF91, wC928
; writes: hFF8C, hFF98, hFF91, wC92C
Func_05F_6AEB:: ; heuristic: follows a terminator; C0
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $02
    ldh [hFF98], a
    ldh a, [hFF91]
    call Func_05F_6B43
    ld a, [wC928]
    ld c, a
    ldh a, [hFF91]
    dec a
    ldh [hFF91], a
    cp a, c
    jr z, Jump_05F_6B0B
    xor a, a
    ld [wC92C], a
    ret

Jump_05F_6B0B::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wC92C], a
    ret

; 16 call sites from 8 routines (e.g. Func_00F_40E9, Func_00F_4FA1, Func_00F_5C3B, Func_00F_67BA, ...)
; reads: hFF8C, hFF8E, wC928
; writes: hFF8C, hFF98, hFF8E, wC92C
Func_05F_6B17:: ; heuristic: follows a terminator; C0
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $03
    ldh [hFF98], a
    ldh a, [hFF8E]
    call Func_05F_6B43
    ld a, [wC928]
    ld c, a
    ldh a, [hFF8E]
    dec a
    ldh [hFF8E], a
    cp a, c
    jr z, Jump_05F_6B37
    xor a, a
    ld [wC92C], a
    ret

Jump_05F_6B37::
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    ld a, $01
    ld [wC92C], a
    ret

; 5 call sites from 5 routines (e.g. Func_05F_6A94, Func_05F_6ABF, Func_05F_6AEB, Func_05F_6B17, ...)
Func_05F_6B43::
    and a, $0F
    jr nz, Jump_05F_6B4D
    farcall Func_002_5923

Jump_05F_6B4D::
    farcall Func_002_5946
    ret

; 145 call sites from 36 routines (e.g. Func_00F_4001, Func_00F_40E9, Func_00F_4774, Func_00F_47F5, ...)
; reads: wC929, wC92A, wC928
; writes: wC92C
; points at: wCB8C
Func_05F_6B54:: ; heuristic: follows a terminator; C0
    ld a, [wC929]
    swap a
    ld hl, wCB8C
    add_a_to_hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    push hl
    push hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld a, [wC92A]
    ld b, a
    and a, $03
    jr nz, Jump_05F_6B83
    ld [hl], $00
    pop hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, Jump_05F_6B80
    inc a

Jump_05F_6B80::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6B83::
    dec a
    jr nz, Jump_05F_6B95
    ld [hl], $01
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, Jump_05F_6B92
    inc a

Jump_05F_6B92::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6B95::
    dec a
    jr nz, Jump_05F_6BA6
    ld [hl], $02
    pop hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, Jump_05F_6BA3
    dec a

Jump_05F_6BA3::
    ld [hl], a
    jr Jump_05F_6BB3

Jump_05F_6BA6::
    ld [hl], $03
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, Jump_05F_6BB2
    dec a

Jump_05F_6BB2::
    ld [hl], a

Jump_05F_6BB3::
    push af
    ld a, [wC928]
    ld c, a
    pop af
    cp a, c
    jr z, Jump_05F_6BC2
    xor a, a
    ld [wC92C], a
    pop hl
    ret

Jump_05F_6BC2::
    pop hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ld a, $01
    ld [wC92C], a
    ret

; 66 call sites from 42 routines (e.g. Func_05F_73A8, Func_00F_40E9, Func_00F_47F5, Func_00F_5D9D, ...)
; reads: wC928, wC929, wC921
Func_05F_6BCD::
    ld a, [wC928]
    ld e, a
    ld a, [wC929]
    ld d, a
    ld a, [wC921]
    srl a
    ld hl, Func_05F_6BE8
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [de]
    add a, c
    ld [de], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC921, hFFC6, hFFC7
; writes: wC921, hFFC6
; points at: wCB8B
Func_05F_6BE8:: ; heuristic: follows a terminator; C0
    cp a, $FF
    rst $38
    nop
    rst $38
    nop
    rst $38
    nop
    nop
    ld bc, $0100
    nop
    ld bc, $0201

; 20 call sites from 19 routines (e.g. Func_00F_4FA1, Func_00F_56CD, Func_00F_59E6, Func_00F_5AF3, ...)
; reads: wC921, hFFC6, hFFC7
; writes: wC921, hFFC6
; points at: wCB8B
Func_05F_6BF8::
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_05F_6C05
    bit 3, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C05::
    cp a, $3C
    jr nc, Jump_05F_6C0F
    bit 2, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C0F::
    bit 1, a
    jr z, Jump_05F_6C15
    jr Jump_05F_6C26

Jump_05F_6C15::
    ldh a, [hFFC6]
    swap a
    ld hl, wCB8B
    add_a_to_hl
    ldh a, [hFFC7]
    ld [hl], a
    jr Jump_05F_6C34

Jump_05F_6C26::
    ldh a, [hFFC6]
    swap a
    ld hl, wCB8B
    add_a_to_hl
    ld [hl], $E0

Jump_05F_6C34::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    jr z, Jump_05F_6C43
    xor a, a
    ldh [hFFC6], a
    ret

Jump_05F_6C43::
    ldh a, [hFFC6]
    swap a
    ld hl, wCB8B
    add_a_to_hl
    ld [hl], $E0
    xor a, a
    ld [wC921], a
    ld a, $01
    ldh [hFFC6], a
    ret

; 52 call sites from 41 routines (e.g. Func_00F_4FA1, Func_00F_5404, Func_00F_57EA, Func_00F_64F3, ...)
; writes: wC5DC, wC8C5, wC921
; points at: wC923
Func_05F_6C5A:: ; heuristic: follows a terminator; C0
    ld a, $0F
    call StartPaletteFade
    ld a, $04
    ld [wC5DC], a
    xor a, a
    ld [wC8C5], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 5 call sites from 5 routines (e.g. Func_012_4030, Func_012_4705, Func_012_590D, Func_012_59DE, ...)
; writes: wC5DC, wC904, wC8C7
Func_05F_6C71:: ; heuristic: follows a terminator; C0
    ld a, $03
    ld [wC5DC], a
    xor a, a
    ld [wC904], a
    ld a, $02
    ld [wC8C7], a
    farcall Func_002_5EEE
    farcall Func_00A_476E
    ret

; 16 call sites from 13 routines (e.g. Func_00F_7093, Func_012_6247, Func_012_630E, Func_012_63D4, ...)
; reads: wC928, wC836
; writes: wC836
; points at: wC61D
Func_05F_6C8C::
    push hl
    ld hl, wC61D

Jump_05F_6C90::
    ld a, [hl]
    or a, a
    jr z, Jump_05F_6C9B
    cp a, $FF
    jr z, Jump_05F_6C9B
    inc hl
    jr Jump_05F_6C90

Jump_05F_6C9B::
    ld a, [wC928]
    ld [hl], a
    pop hl
    ld a, [wC836]
    set 6, a
    ld [wC836], a
    ret

; 5 call sites from 4 routines (e.g. Func_004_58C2, Func_004_612B, Func_013_49D5, Func_073_4FD2)
; reads: wC6FD, hFFC6
; writes: rRAMG, wC92C
; points at: wC6FE
Func_05F_6CA9::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_05F_6CC8
    ld b, a
    ld hl, wC6FE

Jump_05F_6CB8::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_05F_6CD1
    inc hl
    dec b
    jr nz, Jump_05F_6CB8

Jump_05F_6CC8::
    xor a, a
    ld [wC92C], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_05F_6CD1::
    ld a, $01
    ld [wC92C], a
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6
; writes: rRAMG, wC92C
; points at: wC6FE
Func_05F_6CDB:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_05F_6CFA
    ld b, a
    ld hl, wC6FE

Jump_05F_6CEA::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 2, a
    jr nz, Jump_05F_6D03
    inc hl
    dec b
    jr nz, Jump_05F_6CEA

Jump_05F_6CFA::
    xor a, a
    ld [wC92C], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_05F_6D03::
    ld a, $01
    ld [wC92C], a
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_073_4FD2)
; reads: wC6FD, hFFC6
; writes: rRAMG, wC92C
; points at: wC6FE
Func_05F_6D0D:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    or a, a
    jr z, Jump_05F_6D2C
    ld b, a
    ld hl, wC6FE

Jump_05F_6D1C::
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 0, a
    jr nz, Jump_05F_6D35
    inc hl
    dec b
    jr nz, Jump_05F_6D1C

Jump_05F_6D2C::
    xor a, a
    ld [wC92C], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_05F_6D35::
    ld a, $01
    ld [wC92C], a
    xor a, a
    ld [rRAMG], a
    ret

; 3 call sites from 3 routines (e.g. Func_073_61A7, Func_073_630F, Func_073_65B0)
; reads: hFF8D, hFFC6
; writes: hFF8D, wD7F1, wD7F2, wC527
; points at: wC6FE
Func_05F_6D3F:: ; heuristic: follows a terminator; C0
    farcall Func_012_7D95
    ldh a, [hFF8D]
    or a, $0E
    ldh [hFF8D], a
    ldh a, [hFFC6]
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    call Func_000_222B
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ldh a, [hFF8D]
    and a, $F1
    ldh [hFF8D], a
    ret

; 7 call sites from 6 routines (e.g. Func_013_5EF4, Func_013_78DE, Func_085_4047, Func_085_43D5, ...)
; reads: wD7F5, wC7C7
; writes: wD7F1, wD7F2, wD7F5
Func_05F_6D78::
    ld a, $FF
    ld [wD7F1], a
    ld a, $01
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    cp a, $FF
    ret z
    ld a, [wC7C7]
    and a, $03
    ld hl, Func_05F_6DA8
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wD7F5]
    cp a, c
    ret c
    ld a, $FF
    ld [wD7F5], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; points at: wC707
Func_05F_6DA8:: ; heuristic: follows a terminator; C0
    ld a, [bc]
    inc d
    ld e, $1E

; 10 call sites from 8 routines (e.g. Func_004_6F9A, Func_00F_5404, Func_00F_57EA, Func_00F_67BA, ...)
; reads: hFFC6
; points at: wC707
Func_05F_6DAC::
    ldh a, [hFFC6]
    ld c, a
    ld hl, wC707

Jump_05F_6DB2::
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_05F_6DCF
    cp a, $FF
    jr nz, Jump_05F_6DBE
    pop hl
    ret

Jump_05F_6DBE::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_05F_6DCF
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $3F
    cp a, c
    jr z, Jump_05F_6DD6

Jump_05F_6DCF::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_05F_6DB2

Jump_05F_6DD6::
    set 6, a
    ld [hl], a
    pop hl
    ret

; 23 call sites from 23 routines (e.g. Func_00F_40E9, Func_00F_4FA1, Func_00F_631F, Func_00F_64F3, ...)
; reads: hScrollY, hScrollX
Func_05F_6DDB::
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
    jr nc, Jump_05F_6E03
    inc d

Jump_05F_6E03::
    ld l, e
    ld h, d
    call Func_000_1E29
    ret

; 9 call sites from 9 routines (e.g. Func_00F_4FA1, Func_00F_5404, Func_00F_60E6, Func_00F_631F, ...)
; reads: hScrollY, hScrollX
Func_05F_6E09::
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
    push de
    ldh a, [hScrollX]
    sub a, $08
    call Func_05F_6E35
    pop de
    ldh a, [hScrollX]
    add a, $A0
    call Func_05F_6E35
    ret

; 2 call sites from 1 routine (e.g. Func_05F_6E09)
Func_05F_6E35::
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_05F_6E40
    inc d

Jump_05F_6E40::
    ld l, e
    ld h, d
    ld b, $12

Jump_05F_6E44::
    ld a, $C4
    call WriteVRAMByte
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec b
    jr nz, Jump_05F_6E44
    ret

; 1 call site from 1 routine (e.g. Func_073_6B5B)
; reads: wC92D
Func_05F_6E58::
    ld a, [wC92D]
    rst $00
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E97
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E93
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E8F
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6E7E
    dw Jump_05F_6EEE
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6EE3

Jump_05F_6E7E::
    xor a, a
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_6E8F::
    ld a, $02
    jr Jump_05F_6E99

Jump_05F_6E93::
    ld a, $01
    jr Jump_05F_6E99

Jump_05F_6E97::
    ld a, $03

Jump_05F_6E99::
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $40
    ret nz
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_073_6C77)
; reads: wC92D
Func_05F_6EC3::
    ld a, [wC92D]
    rst $00
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_701C
    dw Jump_05F_6FE7
    dw Jump_05F_6F6B
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6F46
    dw Jump_05F_7009
    dw Jump_05F_6EEE
    dw Jump_05F_6F46
    dw Jump_05F_7009
    dw Jump_05F_7009
    dw Jump_05F_6EE3

Jump_05F_6EE3::
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld hl, wC923
    inc [hl]
    ret

Jump_05F_6EEE::
    ld de, hFF91
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld de, wC8F1
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld de, wC8FB
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
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_6F46::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ldh a, [hFF98]
    inc a
    and a, $03
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    or a, a
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_6F6B::
    ld a, [wC921]
    and a, $07
    jr nz, Jump_05F_6F8C
    ldh a, [hFF98]
    dec a
    and a, $03
    ldh [hFF98], a
    bit 0, a
    jr z, Jump_05F_6F81
    inc a
    inc a
    and a, $03

Jump_05F_6F81::
    ld [wC8EF], a
    ld hl, wC8F0
    dec [hl]
    ld hl, hFF8E
    inc [hl]

Jump_05F_6F8C::
    ld a, [wC921]
    and a, $03
    jr nz, Jump_05F_6FDC
    ld a, [wC921]
    srl a
    srl a
    ld c, a
    ld a, $1F
    sub a, c
    sla a
    ld hl, Data_05F_7092
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [wC8FA]
    add a, c
    ld [wC8FA], a
    ld a, [wC8F5]
    sub a, c
    ld [wC8F5], a
    ld a, [hl]
    ld c, a
    ld a, [wC8FB]
    add a, c
    ld [wC8FB], a
    ld a, [wC8F6]
    sub a, c
    ld [wC8F6], a
    ld a, [wC921]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_6FDC
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_6FDC::
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    ld hl, wC921
    inc [hl]
    ret

Jump_05F_6FE7::
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld de, wC8FB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD

Jump_05F_7009::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_701C::
    ld a, [wC921]
    and a, $07
    jr nz, Jump_05F_703D
    ldh a, [hFF98]
    inc a
    and a, $03
    ldh [hFF98], a
    bit 0, a
    jr z, Jump_05F_7032
    inc a
    inc a
    and a, $03

Jump_05F_7032::
    ld [wC8EF], a
    ld hl, wC8F0
    inc [hl]
    ld hl, hFF8E
    dec [hl]

Jump_05F_703D::
    ld hl, Data_05F_7092
    call Func_05F_7044
    ret

; 1 call site from 1 routine (e.g. Func_05F_6EC3)
; reads: wC921, wC8F5, wC8FA, wC8F6, wC8FB
; writes: wC8F5, wC8FA, wC8F6, wC8FB, wC921
; points at: wC92D, wC921
Func_05F_7044::
    ld a, [wC921]
    and a, $03
    jr nz, Jump_05F_708D
    ld a, [wC921]
    srl a
    srl a
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [wC8F5]
    add a, c
    ld [wC8F5], a
    ld a, [wC8FA]
    sub a, c
    ld [wC8FA], a
    ld a, [hl]
    ld c, a
    ld a, [wC8F6]
    add a, c
    ld [wC8F6], a
    ld a, [wC8FB]
    sub a, c
    ld [wC8FB], a
    ld a, [wC921]
    srl a
    srl a
    cp a, $1F
    jr nz, Jump_05F_708D
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_708D::
    ld hl, wC921
    inc [hl]
    ret

Data_05F_7092:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $00, $FF, $00, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $00, $FF, $00, $FE
    db $00, $FE, $00, $FF, $01, $FE, $01, $FF, $01, $FF, $02, $FF, $01, $00, $02, $00
    db $02, $00, $01, $00, $02, $01, $01, $01, $01, $01, $01, $02, $00, $01, $00, $02
    db $00, $02, $00, $01, $FF, $02, $FF, $01, $FF, $01, $FE, $01, $FF, $00, $FE, $00

; 2 call sites from 2 routines (e.g. Func_00F_5F06, Func_00F_772E)
; reads: wC92D
Func_05F_70D2::
    ld a, [wC92D]
    rst $00
    dw Jump_05F_7345
    dw Jump_05F_72E4
    dw Jump_05F_72B3
    dw Jump_05F_7280
    dw Jump_05F_7195
    dw Jump_05F_7172
    dw Jump_05F_7138
    dw Jump_05F_70E6

Jump_05F_70E6::
    ld a, $01
    ld [wC8EF], a
    ld a, [wC8F0]
    inc a
    ld [wC8F0], a
    ld a, [wC921]
    and a, $01
    jr nz, Jump_05F_7105
    ld a, $02
    ld [wC8F4], a
    ld a, [wC8F6]
    dec a
    ld [wC8F6], a

Jump_05F_7105::
    ld hl, wC921
    inc [hl]
    ld a, $03
    ld [wC8F9], a
    ld a, [wC8FA]
    dec a
    ld [wC8FA], a
    ldh a, [hFF8E]
    ld c, a
    ld a, [wC8FA]
    cp a, c
    ret nz
    xor a, a
    ldh [hFF98], a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hFF8C]
    and a, $FB
    ldh [hFF8C], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_05F_7138::
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wCBCF], a
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld a, $02
    ldh [hFF98], a
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_7172::
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    xor a, a
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_7195::
    ld a, [wC931]
    ld l, a
    ld a, [wC932]
    ld h, a
    dec hl
    ld a, l
    ld [wC931], a
    ld a, h
    ld [wC932], a
    ld a, l
    or a, h
    jr nz, Jump_05F_71B2
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]

Jump_05F_71B2::
    ld b, $03
    ld hl, wC8EF
    ld de, wC92E

Jump_05F_71BA::
    push hl
    push de
    ld a, [de]
    or a, a
    jr nz, Jump_05F_71D4
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hFF91]
    add a, $10
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $01
    ld [de], a
    jr Jump_05F_7231

Jump_05F_71D4::
    dec a
    jr nz, Jump_05F_71F4
    ld a, [wC5F0]
    srl a
    srl a
    srl a
    and a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hFF8E]
    add a, $20
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $02
    ld [de], a
    jr Jump_05F_7231

Jump_05F_71F4::
    dec a
    jr nz, Jump_05F_720A
    ld a, $02
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [hFF91]
    cp a, c
    jr nz, Jump_05F_7231
    ld a, $03
    ld [de], a
    jr Jump_05F_7231

Jump_05F_720A::
    ld a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [hFF8E]
    sub a, $20
    cp a, c
    jr nz, Jump_05F_721B
    xor a, a
    ld [de], a

Jump_05F_721B::
    ldh a, [hFF8E]
    sub a, $20
    ld c, a
    ld a, [hl]
    sub a, c
    ld de, Data_05F_7240
    add a, e
    ld e, a
    jr nc, Jump_05F_722A
    inc d

Jump_05F_722A::
    ld a, [de]
    ld c, a
    ldh a, [hFF91]
    sub a, c
    inc hl
    ld [hl], a

Jump_05F_7231::
    pop de
    inc de
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jp nz, Jump_05F_71BA
    ret

Data_05F_7240:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $11, $00
    db $01, $05, $08, $0A, $0C, $0D, $0E, $0E, $0F, $0F, $10, $10, $10, $11, $11, $11
    db $11, $10, $10, $10, $0F, $0F, $0E, $0E, $0D, $0C, $0A, $08, $05, $01
    ds $11, $00

Jump_05F_7280::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ld a, $00
    ld [wC92E], a
    ld a, $01
    ld [wC92F], a
    ld a, $03
    ld [wC930], a
    ld hl, $0320
    ld a, l
    ld [wC931], a
    ld a, h
    ld [wC932], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_72B3::
    ld a, $80
    ld [wCBCF], a
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall Func_05F_6BCD
    ld a, [wCBD4]
    dec a
    ld [wCBD4], a
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_72E4::
    ld a, $03
    ld [wC8EF], a
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    ld a, [wC921]
    and a, $01
    jr nz, Jump_05F_7303
    ld a, $00
    ld [wC8F4], a
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a

Jump_05F_7303::
    ld hl, wC921
    inc [hl]
    ld a, $01
    ld [wC8F9], a
    ld a, [wC8FA]
    inc a
    ld [wC8FA], a
    ldh a, [hFF8E]
    ld c, a
    ld a, [wC8FA]
    sub a, c
    cp a, $20
    ret nz
    xor a, a
    ldh [hFF98], a
    ld [wC8EF], a
    inc a
    ld [wC8F4], a
    ld a, $03
    ld [wC8F9], a
    ld a, $0B
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_7345::
    ldh a, [hFF8C]
    or a, $04
    ldh [hFF8C], a
    ldh a, [hFF8E]
    call Func_05F_6B43
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

; 4 call sites from 4 routines (e.g. Func_00F_4FA1, Func_00F_57EA, Func_00F_67BA, Func_00F_72D9)
; reads: wC92D
Func_05F_7363::
    ld a, [wC92D]
    rst $00
    dw Jump_05F_7700
    dw Jump_05F_76D6
    dw Jump_05F_766C
    dw Jump_05F_7631
    dw Jump_05F_7617
    dw Jump_05F_75EC
    dw Jump_05F_75D2
    dw Jump_05F_7593
    dw Jump_05F_7554
    dw Jump_05F_753A
    dw Jump_05F_750C
    dw Jump_05F_74CD
    dw Jump_05F_746F
    dw Jump_05F_743D
    dw Jump_05F_742F
    dw Jump_05F_73B2
    dw Jump_05F_753A
    dw Jump_05F_738B

Jump_05F_738B::
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; points at: wC92D
Func_05F_7390:: ; heuristic: follows a terminator; C0
    ld a, [wC552]
    or a, a
    jr nz, Jump_05F_739E
    ld a, $06
    ld hl, wC92D
    inc [hl]
    jr Jump_05F_73A4

Jump_05F_739E::
    ld a, $07
    ld hl, wC92D
    dec [hl]

Jump_05F_73A4::
    call Func_05F_7761
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC92D
Func_05F_73A8:: ; heuristic: follows a terminator; C0
    ld a, $05
    call Func_05F_7761
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_73B2::
    ld a, [wC921]
    or a, a
    jr nz, Jump_05F_73BD
    ld a, $65
    call StoreWC60B

Jump_05F_73BD::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call Func_05F_6BCD
    ld a, [wC921]
    and a, $01
    jr nz, Jump_05F_73D6
    ld hl, wCB8A
    inc [hl]

Jump_05F_73D6::
    ld a, [wC921]
    and a, $01
    jr nz, Jump_05F_73E6
    ld a, [wCB86]
    inc a
    and a, $03
    ld [wCB86], a

Jump_05F_73E6::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    jr z, Jump_05F_7402
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ret

Jump_05F_7402::
    ld a, $72
    call StoreWC60B
    ld de, Data_07D_7AD4
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wCB81], a
    xor a, a
    ld [wCB86], a
    ld a, $04
    call Func_05F_7761
    ld a, [wC933]
    ld [wC6FD], a
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_742F::
    xor a, a
    call Func_05F_77C7
    ret nc
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_743D::
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, $03
    call Func_05F_7761
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_746F::
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld a, [wC922]
    add a, $01
    ld [wC922], a
    sra a
    sra a
    sra a
    sra a
    ld c, a
    ld a, [wC921]
    add a, c
    ld [wC921], a
    cp a, $18
    jr c, Jump_05F_74A5
    xor a, a
    ld [wC921], a
    xor a, a
    ld [wCBCF], a
    jr Jump_05F_74AA

Jump_05F_74A5::
    ld a, $80
    ld [wCBCF], a

Jump_05F_74AA::
    ld a, [wC922]
    sra a
    sra a
    sra a
    sra a
    cp a, $30
    ret c
    xor a, a
    ld [wCBCF], a
    ld a, $30
    ld [wCBD4], a
    xor a, a
    ld [wC921], a
    ld [wC922], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_74CD::
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call Func_05F_6BCD
    ld a, [wC921]
    bit 0, a
    jr nz, Jump_05F_74F6
    ld hl, wCBD4
    inc [hl]

Jump_05F_74F6::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld [wC922], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_750C::
    call NextTableByte
    ld a, [wC5E7]
    and a, $03
    jr z, Jump_05F_750C
    dec a
    dec a
    add a, $40
    ld [wCBD3], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $B4
    ret nz
    ld a, $40
    ld [wCBD3], a
    ld a, $72
    call StoreWC60B
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_753A::
    xor a, a
    call Func_05F_77C7
    ret nc
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld a, $11
    ld [wC92D], a
    ret

Jump_05F_7554::
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call Func_05F_6BCD
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    inc [hl]
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, $02
    call Func_05F_7761
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_7593::
    farcall Func_012_6B22
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B33
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call Func_05F_6BCD
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $01
    jr nz, Jump_05F_75C3
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a

Jump_05F_75C3::
    ld a, [wC921]
    cp a, $20
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_75D2::
    xor a, a
    call Func_05F_77C7
    ret nc
    ld de, Data_07D_41E1
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $02
    ld [wCB81], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_75EC::
    ld de, wCBD4
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    call Func_05F_6BCD
    ld hl, wCBD4
    dec [hl]
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, $01
    call Func_05F_7761
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_7617::
    xor a, a
    call Func_05F_77C7
    ret nc
    ld a, $80
    ld [wCBCF], a
    ld a, [wC6FD]
    ld [wC933], a
    ld a, $01
    ld [wC6FD], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_7631::
    ld a, [wC921]
    or a, a
    jr nz, Jump_05F_7646
    inc a
    ld [wC921], a
    ld a, $0E
    ldh [hFF8D], a
    farcall Func_012_64F8
    ret

Jump_05F_7646::
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
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_766C::
    ld a, [wC921]
    srl a
    srl a
    and a, $01
    jr z, Jump_05F_7697
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76BE
    ld hl, wC0F0
    ld de, wC49F
    ld bc, $0040
    call CopyBytes
    jr Jump_05F_76B9

Jump_05F_7697::
    ld hl, wC5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76BE
    ld b, $40
    ld hl, wC0F0
    ld de, wC49F

Jump_05F_76B1::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_05F_76B1

Jump_05F_76B9::
    ld a, $7F
    ld [wC526], a

Jump_05F_76BE::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $1E
    ret nz
    ld a, $00
    call Func_05F_7761
    xor a, a
    ld [wC921], a
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_76D6::
    ld a, $03
    ldh [hFF98], a
    ld a, $01
    ld [wCB86], a
    xor a, a
    call Func_05F_77C7
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_05F_76F6
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_05F_76F6::
    ld a, $7A
    call StoreWC60B
    ld hl, wC92D
    inc [hl]
    ret

Jump_05F_7700::
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6AD9
    ld de, $0021
    call TestFlagBit
    jr c, Jump_05F_771D
    ld a, $00
    ld [wC92E], a
    ld a, $03
    ldh [hFFC6], a
    jr Jump_05F_774C

Jump_05F_771D::
    ld de, $0022
    call TestFlagBit
    jr c, Jump_05F_7730
    ld a, $01
    ld [wC92E], a
    ld a, $08
    ldh [hFFC6], a
    jr Jump_05F_774C

Jump_05F_7730::
    ld de, $0023
    call TestFlagBit
    jr c, Jump_05F_7743
    ld a, $02
    ld [wC92E], a
    ld a, $0A
    ldh [hFFC6], a
    jr Jump_05F_774C

Jump_05F_7743::
    ld a, $03
    ld [wC92E], a
    ld a, $0F
    ldh [hFFC6], a

Jump_05F_774C::
    farcall Func_012_6B98
    ld a, $50
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld hl, wC92D
    inc [hl]
    ret

; 7 call sites from 2 routines (e.g. Func_05F_73A8, Func_05F_7390)
; reads: wC92E
; writes: wC924, wC925, wC926
Func_05F_7761::
    sla a
    ld de, Data_05F_7787
    add a, e
    ld e, a
    jr nc, Jump_05F_776B
    inc d

Jump_05F_776B::
    ld a, [wC92E]
    swap a
    add a, e
    ld e, a
    jr nc, Jump_05F_7775
    inc d

Jump_05F_7775::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

Data_05F_7787:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $01, $27, $01, $28, $01, $29, $01, $2A, $01, $00, $00, $00, $00, $00, $00
    db $A8, $02, $A9, $02, $AA, $02, $AB, $02, $AC, $02, $00, $00, $00, $00, $00, $00
    db $A8, $02, $E9, $02, $AA, $02, $AB, $02, $EC, $02, $00, $00, $00, $00, $00, $00
    db $34, $05, $35, $05, $36, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; 5 call sites from 1 routine (e.g. Func_05F_73A8)
; reads: wC926
; writes: wC928
Func_05F_77C7::
    ld [wC928], a
    call Func_05F_6936
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_05F_77D6
    sub a, a
    ret

Jump_05F_77D6::
    scf
    ret

; 2 call sites from 1 routine (e.g. Func_010_49C5)
; reads: wC921, wC923, wC922
; writes: wC923, wC922, wC920, wC919
Func_05F_77D8::
    ld c, $10
    ld a, [wC921]
    and a, $0F
    call Multiply8
    ld a, l
    add a, $7F
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a
    push hl
    ld a, $0D
    add_a_to_hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    dec hl
    dec hl
    ld a, [wC921]
    swap a
    and a, $0F
    jr z, Jump_05F_7809
    dec a
    jr z, Jump_05F_780F
    dec a
    jr z, Jump_05F_7814
    jr Jump_05F_781A

Jump_05F_7809::
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_780F::
    ld a, [hl]
    inc a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_7814::
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_781A::
    ld a, [hl]
    dec a
    ld [hl], a
    jr Jump_05F_781F

Jump_05F_781F::
    pop hl
    ld a, $07
    add_a_to_hl
    ld a, [wC921]
    swap a
    and a, $0F
    ld [hl], a
    ld a, [wC923]
    inc a
    cp a, $10
    jr z, Jump_05F_783B
    ld [wC923], a
    ret

Jump_05F_783B::
    xor a, a
    ld [wC923], a
    ld a, [wC922]
    dec a
    ld [wC922], a
    ret nz
    ld a, $06
    add_a_to_hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_49C5)
; reads: wC921, wC922
; writes: wC921, wC922, wC920, wC919
Func_05F_785C::
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    ld h, a
    dec hl
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, l
    or a, a
    ret nz
    cp a, h
    ret nz
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_49C5)
; reads: wC468, hFF8C, wC922, wC921, wC55E
; writes: wC55E, wC562, wC919, wC922
Func_05F_787C::
    xor a, a
    ld [wC55E], a
    ld [wC562], a
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wC922]
    or a, a
    jr nz, Jump_05F_789A
    ld a, $80
    ld [wC919], a
    ret

Jump_05F_789A::
    dec a
    ld [wC922], a
    ld a, [wC921]
    or a, a
    jr nz, Jump_05F_78AD
    ld a, [wC55E]
    set 7, a
    ld [wC55E], a
    ret

Jump_05F_78AD::
    dec a
    jr nz, Jump_05F_78B9
    ld a, [wC55E]
    set 4, a
    ld [wC55E], a
    ret

Jump_05F_78B9::
    dec a
    jr nz, Jump_05F_78C5
    ld a, [wC55E]
    set 6, a
    ld [wC55E], a
    ret

Jump_05F_78C5::
    ld a, [wC55E]
    set 5, a
    ld [wC55E], a
    ret

; 1 call site from 1 routine (e.g. Func_010_49C5)
; reads: wC921, wC922
; writes: wC919
; points at: hFF98, wC8EF
Func_05F_78CE::
    ld a, [wC921]
    bit 7, a
    jr nz, Jump_05F_78EE
    or a, a
    jr nz, Jump_05F_78DD
    ld hl, hFF98
    jr Jump_05F_78FD

Jump_05F_78DD::
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8EF
    add_a_to_hl
    jr Jump_05F_78FD

Jump_05F_78EE::
    and a, $7F
    ld c, $10
    call Multiply8
    ld a, l
    add a, $86
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a

Jump_05F_78FD::
    ld a, [wC922]
    ld [hl], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4BCD)
; reads: wC922, wC921
; writes: wC921, wC920, wC919
; points at: hFF91, wC8F1, wCB8B
Func_05F_7907:: ; heuristic: follows a terminator; C0
    ld a, [wC922]
    bit 7, a
    jr nz, Jump_05F_7927
    or a, a
    jr nz, Jump_05F_7916
    ld de, hFF91
    jr Jump_05F_7933

Jump_05F_7916::
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld de, wC8F1
    add a, e
    ld e, a
    jr nc, Jump_05F_7925
    inc d

Jump_05F_7925::
    jr Jump_05F_7933

Jump_05F_7927::
    and a, $7F
    swap a
    ld de, wCB8B
    add a, e
    ld e, a
    jr nc, Jump_05F_7933
    inc d

Jump_05F_7933::
    ld a, [wC921]
    srl a
    ld hl, Data_05F_7959
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [de]
    add a, c
    ld [de], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Data_05F_7959:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FF, $FF, $00, $FF, $00, $FF, $00, $00, $01, $00, $01, $00, $01, $01, $02

; 1 call site from 1 routine (e.g. Func_010_49EE)
; reads: wC923
Func_05F_7969::
    ld a, [wC923]
    rst $00
    dw Jump_05F_7977
    dw Jump_05F_7A02
    dw Jump_05F_7A42
    dw Jump_05F_7A5D
    dw Jump_05F_7A8C

Jump_05F_7977::
    ld a, [wC921]
    cp a, $03
    jr z, Jump_05F_7987
    ld a, [wC922]
    ld de, wC152
    call Func_000_2431

Jump_05F_7987::
    ld hl, wC923
    inc [hl]
    ld a, [wC921]
    push af
    ld c, a
    add a, a
    add a, c
    add a, $A0
    ld [wC921], a
    ld a, [wC924]
    ld e, a
    ld a, [wC925]
    ld d, a
    call TestFlagBit
    jr nc, Jump_05F_79AE
    pop af
    ld hl, wC921
    inc [hl]
    xor a, a
    ld [wC922], a
    ret

Jump_05F_79AE::
    pop af
    cp a, $03
    jr z, Jump_05F_79F5
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_05F_79BE
    cp a, $00
    jr nz, Jump_05F_79E8

Jump_05F_79BE::
    ld hl, wC61D

Jump_05F_79C1::
    ld a, [hl]
    or a, a
    jr z, Jump_05F_79CC
    cp a, $FF
    jr z, Jump_05F_79CC
    inc hl
    jr Jump_05F_79C1

Jump_05F_79CC::
    ld a, [wC922]
    ld [hl], a
    ld a, [wC836]
    set 6, a
    ld [wC836], a

Jump_05F_79D8::
    ld a, [wC924]
    ld e, a
    ld a, [wC925]
    ld d, a
    call SetFlagBit
    xor a, a
    ld [wC922], a
    ret

Jump_05F_79E8::
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    xor a, a
    ld [wC922], a
    ret

Jump_05F_79F5::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_05F_79E8
    jr Jump_05F_79D8

Jump_05F_7A02::
    ld a, [wC922]
    bit 7, a
    jr nz, Jump_05F_7A3D
    farcall Func_004_4470
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
    jr c, Jump_05F_7A3D
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_05F_7A3D::
    ld hl, wC923
    inc [hl]
    ret

Jump_05F_7A42::
    ld a, [wC922]
    bit 7, a
    jr nz, Jump_05F_7A4F
    ld a, [wC8CB]
    and a, $03
    ret nz

Jump_05F_7A4F::
    ld a, [wC921]
    ld l, a
    ld h, $00
    call Func_05F_69FB
    ld hl, wC923
    inc [hl]
    ret

Jump_05F_7A5D::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC922]
    bit 6, a
    jr nz, Jump_05F_7A87
    ld a, $69
    call StoreWC60B
    xor a, a
    ldh [hFFB9], a
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ldh a, [hFF91]
    cp a, $48
    jr c, Jump_05F_7A87
    ld a, $82
    ld [wC8CB], a

Jump_05F_7A87::
    ld hl, wC923
    inc [hl]
    ret

Jump_05F_7A8C::
    ld a, [wC8CB]
    and a, $03
    ret nz
    farcall Func_084_43B8
    farcall Func_05F_6DDB
    farcall Func_004_449F
    xor a, a
    ld [wC920], a
    xor a, a
    ld [wC91F], a
    ld a, $00
    ld [wC5DC], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4BD4)
; reads: wC923, wC921
; writes: hFFC6, wC920, wC919
; points at: wC923
Func_05F_7AB2:: ; heuristic: follows a terminator; C0
    ld a, [wC923]
    or a, a
    jr nz, Jump_05F_7AC8
    ld a, [wC921]
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

Jump_05F_7AC8::
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld a, [wC921]
    rst $00
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B3B
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40
    dw Jump_05F_7B40

Jump_05F_7B3B::
    xor a, a
    ld [wSpriteSlotCount], a
    ret

Jump_05F_7B40::
    ret
    ds $4BF, $00
