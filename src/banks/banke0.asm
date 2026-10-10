SECTION "Bank E0", ROMX[$4000], BANK[$E0]
    db $E0

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case0C)
; reads: wC5FE
Func_0E0_4001::
    ld a, [wC5FE]
    rst $00
    dw Func_0E0_4001_Case00
    dw Func_0E0_4001_Case01
    dw Func_0E0_4001_Case02
    dw Func_0E0_4001_Case03
    dw Func_0E0_4001_Case04
    dw Func_0E0_4001_Case05

; entry 0 of the `rst $00` table in Func_0E0_4001
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC5FE
Func_0E0_4001_Case00::
Jump_0E0_4011:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $2101
    ld a, $02
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    call Func_0E0_42A6
    ld hl, vTiles2 + $10
    ld de, $1001
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call Func_0E0_4279
    call FillTilesFromRequest
    ld de, $42D3
    ld bc, $1412
    ld hl, vBGMap0

Jump_0E0_4043::
    push bc
    push hl

Jump_0E0_4045::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0E0_4045
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0E0_4043
    call Func_0E0_41C7
    call Func_0E0_41E9
    call Func_0E0_421F
    call Func_0E0_425A
    ld hl, wC5FE
    inc [hl]
    ld a, $BB
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

; entry 1 of the `rst $00` table in Func_0E0_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wC5F8
; writes: wC5FE, wC5F8
Func_0E0_4001_Case01::
Jump_0E0_406F:: ; address name
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, Jump_0E0_407C
    ld a, $05
    ld [wC5FE], a
    ret

Jump_0E0_407C::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, Jump_0E0_408A
    ld a, $04
    ld hl, vBGMap0 + $182
    jr Jump_0E0_40A6

Jump_0E0_408A::
    bit 7, a
    jr z, Jump_0E0_4095
    ld a, $02
    ld hl, vBGMap0 + $A2
    jr Jump_0E0_40A6

Jump_0E0_4095::
    and a, $30
    ret z
    ld a, [wC5F8]
    and a, $01
    xor a, $01
    ld [wC5F8], a
    call Func_0E0_41C7
    ret

Jump_0E0_40A6::
    ld [wC5FE], a
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $42
    call WriteVRAMByte
    ret

; entry 2 of the `rst $00` table in Func_0E0_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wC5F9
; writes: wC5FE, wC5F9
Func_0E0_4001_Case02::
Jump_0E0_40B7:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    jr z, Jump_0E0_40C4
    ld a, $05
    ld [wC5FE], a
    ret

Jump_0E0_40C4::
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_0E0_40D3
    xor a, a
    ld [wC5F9], a
    call Func_0E0_41E9
    ret

Jump_0E0_40D3::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, Jump_0E0_40E1
    ld a, $01
    ld hl, vBGMap0 + $42
    jr Jump_0E0_4112

Jump_0E0_40E1::
    bit 7, a
    jr z, Jump_0E0_40EC
    ld a, $03
    ld hl, vBGMap0 + $122
    jr Jump_0E0_4112

Jump_0E0_40EC::
    bit 5, a
    jr z, Jump_0E0_40FF
    ld a, [wC5F9]
    dec a
    cp a, $FF
    jr nz, Jump_0E0_40FA
    ld a, $E3

Jump_0E0_40FA::
    ld [wC5F9], a
    jr Jump_0E0_410E

Jump_0E0_40FF::
    bit 4, a
    ret z
    ld a, [wC5F9]
    inc a
    cp a, $E4
    jr nz, Jump_0E0_410B
    xor a, a

Jump_0E0_410B::
    ld [wC5F9], a

Jump_0E0_410E::
    call Func_0E0_41E9
    ret

Jump_0E0_4112::
    ld [wC5FE], a
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $A2
    call WriteVRAMByte
    ret

; entry 3 of the `rst $00` table in Func_0E0_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wC5FA
; writes: wC5FE, wC5FA
Func_0E0_4001_Case03::
Jump_0E0_4123:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    jr z, Jump_0E0_4130
    ld a, $05
    ld [wC5FE], a
    ret

Jump_0E0_4130::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, Jump_0E0_413E
    ld a, $02
    ld hl, vBGMap0 + $A2
    jr Jump_0E0_4164

Jump_0E0_413E::
    bit 7, a
    jr z, Jump_0E0_4149
    ld a, $04
    ld hl, vBGMap0 + $182
    jr Jump_0E0_4164

Jump_0E0_4149::
    bit 5, a
    jr z, Jump_0E0_4156
    ld a, [wC5FA]
    dec a
    ld [wC5FA], a
    jr Jump_0E0_4160

Jump_0E0_4156::
    bit 4, a
    ret z
    ld a, [wC5FA]
    inc a
    ld [wC5FA], a

Jump_0E0_4160::
    call Func_0E0_421F
    ret

Jump_0E0_4164::
    ld [wC5FE], a
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $122
    call WriteVRAMByte
    ret

; entry 4 of the `rst $00` table in Func_0E0_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wD894
; writes: wC5FE, wD894
Func_0E0_4001_Case04::
Jump_0E0_4175:: ; address name
    ld a, [wJoypadPressed]
    bit 2, a
    jr z, Jump_0E0_4182
    ld a, $05
    ld [wC5FE], a
    ret

Jump_0E0_4182::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, Jump_0E0_4190
    ld a, $03
    ld hl, vBGMap0 + $122
    jr Jump_0E0_41AC

Jump_0E0_4190::
    bit 7, a
    jr z, Jump_0E0_419B
    ld a, $01
    ld hl, vBGMap0 + $42
    jr Jump_0E0_41AC

Jump_0E0_419B::
    and a, $30
    ret z
    ld a, [wD894]
    and a, $01
    xor a, $01
    ld [wD894], a
    call Func_0E0_425A
    ret

Jump_0E0_41AC::
    ld [wC5FE], a
    ld a, $BB
    call WriteVRAMByte
    ld a, $C3
    ld hl, vBGMap0 + $182
    call WriteVRAMByte
    ret

; entry 5 of the `rst $00` table in Func_0E0_4001
; no direct call (reached through a table, a jump or a vector)
; writes: wC5FE, wC5FD
Func_0E0_4001_Case05::
Jump_0E0_41BD:: ; address name
    xor a, a
    ld [wC5FE], a
    ld a, $03
    ld [wC5FD], a
    ret

; 2 call sites from 2 routines (e.g. Func_0E0_4001_Case01, Func_0E0_4001_Case00)
; reads: wC5F8
Func_0E0_41C7::
    ld a, [wC5F8]
    and a, $01
    xor a, $01
    ld de, $41E6
    add a, e
    ld e, a
    jr nc, Jump_0E0_41D6
    inc d

Jump_0E0_41D6::
    ld a, [de]
    ld hl, vBGMap0 + $69
    call WriteVRAMByte
    inc de
    ld a, [de]
    ld hl, vBGMap0 + $6D
    call WriteVRAMByte
    ret
    db $BB, $C3, $BB

; 3 call sites from 2 routines (e.g. Func_0E0_4001_Case02, Func_0E0_4001_Case00)
; reads: wC5F9
; writes: wStringCategory, wStringIndex
; points at: wC130
Func_0E0_41E9::
    ld a, [wC5F9]
    swap a
    and a, $0F
    add a, $01
    ld hl, vBGMap0 + $CA
    call WriteVRAMByteInc
    ld a, [wC5F9]
    and a, $0F
    add a, $01
    call WriteVRAMByte
    ld de, wC130
    ld a, [wC5F9]
    ld l, a
    ld h, $04
    call Func_000_2E81
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ret

; 2 call sites from 2 routines (e.g. Func_0E0_4001_Case03, Func_0E0_4001_Case00)
; reads: wC5FA, wC8C0, wC8C1, wC8C2
Func_0E0_421F::
    ld a, [wC5FA]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld c, $00
    ld hl, vBGMap0 + $14A
    ld a, [wC8C0]
    or a, a
    jr z, Jump_0E0_4239
    ld c, $01
    add a, $E0
    jr Jump_0E0_423B

Jump_0E0_4239::
    ld a, $C3

Jump_0E0_423B::
    call WriteVRAMByteInc
    ld a, [wC8C1]
    or a, a
    jr nz, Jump_0E0_4248
    bit 0, c
    jr z, Jump_0E0_424C

Jump_0E0_4248::
    add a, $E0
    jr Jump_0E0_424E

Jump_0E0_424C::
    ld a, $C3

Jump_0E0_424E::
    call WriteVRAMByteInc
    ld a, [wC8C2]
    add a, $E0
    call WriteVRAMByte
    ret

; 2 call sites from 2 routines (e.g. Func_0E0_4001_Case04, Func_0E0_4001_Case00)
; reads: wD894
Func_0E0_425A::
    ld a, [wD894]
    and a, $01
    xor a, $01
    ld de, $41E6
    add a, e
    ld e, a
    jr nc, Jump_0E0_4269
    inc d

Jump_0E0_4269::
    ld a, [de]
    ld hl, vBGMap0 + $1A9
    call WriteVRAMByte
    inc de
    ld a, [de]
    ld hl, vBGMap0 + $1AD
    call WriteVRAMByte
    ret

; 3 call sites from 2 routines (e.g. Func_0E0_4001_Case00, Func_0E0_4C7E_Case00)
; writes: wC52D, wC52E, wC52F, wC530
Func_0E0_4279::
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4001_Case00)
; writes: wC52D, wC52E, wC52F, wC530
Func_0E0_42A6::
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank09
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $ED, $EE, $EF, $F0, $F1, $F2, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F3
    db $F4, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $ED, $EE, $EF, $FB, $FC, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $E0
    db $E0, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $80, $81, $82, $83, $84, $85, $86, $87, $88, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $FD, $FE, $FF, $00, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $BE, $E2, $E5, $E5, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $F8, $F9, $FA, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F3
    db $F4, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

; 2 call sites from 2 routines (e.g. Func_031_6564, Func_0A0_6A25)
; reads: wC5FD
Func_0E0_443B::
    ld a, [wC5FD]
    rst $00
    dw Func_0E0_443B_Case00
    dw Func_0E0_443B_Case01
    dw Func_0E0_443B_Case02
    dw Func_0E0_443B_Case03
    dw Func_0E0_443B_Case04
    dw Func_0E0_443B_Case05
    dw Func_0E0_443B_Case06
    dw Func_0E0_4804
    dw Func_0E0_443B_Case08
    dw Func_0E0_443B_Case09
    dw Func_0E0_443B_Case0A
    dw Func_0E0_443B_Case0B
    dw Func_0E0_443B_Case0C
    dw Func_0E0_443B_Case0D

; entry 0 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wC5FE
; writes: wStringCategory, wStringIndex
; points at: wC5FD
Func_0E0_443B_Case00::
Jump_0E0_445B:: ; address name
    ld hl, vTiles1 + $6D0
    ld de, $2301
    ld a, $02
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    call Func_0E0_5553
    call Func_0E0_50EE
    ld hl, $448A
    ld a, [wC5FE]
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BB
    call WriteVRAMByte
    ld hl, wC5FD
    inc [hl]
    ret
    db $24, $98, $2A, $98

; entry 1 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wC5FE
; points at: wD89F, wC5FD
Func_0E0_443B_Case01::
Jump_0E0_448E:: ; address name
    ld a, [wC5FE]
    or a, a
    jr nz, Jump_0E0_4498
    ld c, $00
    jr Jump_0E0_449A

Jump_0E0_4498::
    ld c, $04

Jump_0E0_449A::
    call Func_0E0_44B3
    inc c
    call Func_0E0_44B3
    inc c
    call Func_0E0_44B3
    ld hl, vBGMap0 + $20B
    ld de, wD89F
    call Func_0E0_459A
    ld hl, wC5FD
    inc [hl]
    ret

; 3 call sites from 1 routine (e.g. Func_0E0_443B_Case01)
; writes: hFFC6, hFFC7
; points at: wBattleSlotOut, wBattleHP, wBattleMaxHP, wBattleMP, wBattleMaxMP, wD8B7, wBattleATK, wBattleDEF, ...
Func_0E0_44B3::
    ld a, c
    and a, $03
    ld hl, $4652
    add a, a
    add_a_to_hl
    deref_hl
    ld a, c
    ld de, wBattleSlotOut
    add a, e
    ld e, a
    jr nc, Jump_0E0_44CB
    inc d

Jump_0E0_44CB::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0E0_452D
    ld de, wBattleHP
    call Func_0E0_4593
    ld de, wBattleMaxHP
    call Func_0E0_4593
    ld de, wBattleMP
    call Func_0E0_4593
    ld de, wBattleMaxMP
    call Func_0E0_4593
    inc hl
    ld de, wD8B7
    call Func_0E0_456B
    ld de, wBattleATK
    call Func_0E0_455F
    ld de, wBattleDEF
    call Func_0E0_455F
    ld de, wBattleAGL
    call Func_0E0_455F
    ld de, wBattleINT
    call Func_0E0_455F
    ld de, wSlotPersonalityHi
    call Func_0E0_456B
    ld de, wSlotPersonalityMid
    call Func_0E0_456B
    ld de, wSlotPersonalityLo
    call Func_0E0_456B
    ld de, wD980
    call Func_0E0_456B
    dec hl
    ld de, wD93F
    call Func_0E0_4593
    call Func_0E0_4603
    call Func_0E0_462B
    ret

Jump_0E0_452D::
    xor a, a
    ldh [hFFC6], a
    ldh [hFFC7], a
    call Func_0E0_459D
    call Func_0E0_459D
    call Func_0E0_459D
    call Func_0E0_459D
    inc hl
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    call Func_0E0_4583
    dec hl
    call Func_0E0_459D
    ret

; 4 call sites from 1 routine (e.g. Func_0E0_44B3)
Func_0E0_455F::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0E0_4566
    inc d

Jump_0E0_4566::
    call Func_0E0_45EE
    jr Func_0E0_4583

; 5 call sites from 1 routine (e.g. Func_0E0_44B3)
; writes: wC8C0, wC8C1, wC8C2
Func_0E0_456B::
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0E0_4571
    inc d

Jump_0E0_4571::
    push hl
    ld a, [de]
    ld [wC8C0], a
    xor a, a
    ld [wC8C1], a
    ld [wC8C2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    pop hl

; 9 call sites from 1 routine (e.g. Func_0E0_44B3)
Func_0E0_4583::
    ld b, $00
    push hl
    call Func_0E0_45BE
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; 5 call sites from 1 routine (e.g. Func_0E0_44B3)
Func_0E0_4593::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Func_0E0_459A
    inc d

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case01)
Func_0E0_459A::
    call Func_0E0_45EE

; 5 call sites from 1 routine (e.g. Func_0E0_44B3)
Func_0E0_459D::
    push hl
    call Func_0E0_45AB
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; 1 call site from 1 routine (e.g. Func_0E0_459D)
; reads: hFFC7, hFFC6
Func_0E0_45AB::
    ld b, $00
    ldh a, [hFFC7]
    swap a
    and a, $0F
    or a, a
    jr z, Jump_0E0_45BD
    add a, $E0
    call WriteVRAMByte
    ld b, $01

Jump_0E0_45BD::
    inc hl

; 1 call site from 1 routine (e.g. Func_0E0_4583)
; reads: hFFC7, hFFC6
Func_0E0_45BE::
    ldh a, [hFFC7]
    and a, $0F
    or a, a
    jr nz, Jump_0E0_45C9
    bit 0, b
    jr z, Jump_0E0_45D0

Jump_0E0_45C9::
    add a, $E0
    call WriteVRAMByte
    ld b, $01

Jump_0E0_45D0::
    inc hl
    ldh a, [hFFC6]
    swap a
    and a, $0F
    or a, a
    jr nz, Jump_0E0_45DE
    bit 0, b
    jr z, Jump_0E0_45E3

Jump_0E0_45DE::
    add a, $E0
    call WriteVRAMByte

Jump_0E0_45E3::
    inc hl
    ldh a, [hFFC6]
    and a, $0F
    add a, $E0
    call WriteVRAMByte
    ret

; 2 call sites from 2 routines (e.g. Func_0E0_459A, Func_0E0_455F)
; writes: wC8C0, wC8C1, wC8C2
Func_0E0_45EE::
    push hl
    ld a, [de]
    ld [wC8C0], a
    inc de
    ld a, [de]
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_0E0_44B3)
; points at: wDA53
Func_0E0_4603::
    ld a, c
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ld hl, $465E
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, c
    and a, $03
    ld hl, $4658
    add a, a
    add_a_to_hl
    deref_hl
    pop af
    call WriteVRAMByte
    ret

; 1 call site from 1 routine (e.g. Func_0E0_44B3)
; points at: wD8AF
Func_0E0_462B::
    ld a, c
    ld de, wD8AF
    add a, e
    ld e, a
    jr nc, Jump_0E0_4634
    inc d

Jump_0E0_4634::
    ld a, c
    and a, $03
    ld hl, $464C
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [de]
    and a, $01
    add a, $CC
    call WriteVRAMByte
    ret
    db $C6, $98, $CC, $98, $D2, $98, $42, $98, $48, $98, $4E, $98, $46, $99, $4C, $99
    db $52, $99, $0B, $0A, $09, $08, $EF

; entry 2 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wD88F, wD890, wBattleActor, wBattleTarget, wBattleActionId, wC5FE
; writes: wD88F, wD890, wC5FD, wC5FE, wD802
; points at: wD09D, wC5FD
Func_0E0_443B_Case02::
Jump_0E0_4663:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    jr z, Jump_0E0_46A3
    ld hl, wD09D
    ld a, [wD88F]
    ld [hl+], a
    ld a, [wD890]
    ld [hl+], a
    ld a, [wBattleActor]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld [hl+], a
    ld a, [wBattleActionId]
    ld [hl], a
    ld a, $01
    ld [wD88F], a
    ld a, $01
    ld [wD890], a
    ld a, $0A
    ld [wC5FD], a
    call Func_0E0_50FD
    call Func_0E0_4FCE
    xor a, a
    ld [wC5FE], a
    call Func_0E0_4ABB
    ld a, $FF
    ld [wD802], a
    ret

Jump_0E0_46A3::
    ld a, [wJoypadPressed]
    and a, $08
    jr z, Jump_0E0_46AF
    ld hl, wC5FD
    inc [hl]
    ret

Jump_0E0_46AF::
    ld a, [wJoypadPressed]
    and a, $30
    jr z, Jump_0E0_46C4
    ld a, [wC5FE]
    inc a
    and a, $01
    ld [wC5FE], a
    xor a, a
    ld [wC5FD], a
    ret

Jump_0E0_46C4::
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_0E0_46D1
    ld a, $04
    ld [wC5FD], a
    ret

Jump_0E0_46D1::
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld a, $07
    ld [wC5FD], a
    ret

; entry 3 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wD88F, wC57F
; writes: wC5FC
; points at: wScreenTileBuffer, wD095
Func_0E0_443B_Case03::
Jump_0E0_46DD:: ; address name
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    ld bc, $1412

Jump_0E0_46E6::
    push bc
    push hl

Jump_0E0_46E8::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0E0_46E8
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub a, b
    add a, e
    ld e, a
    jr nc, Jump_0E0_46FE
    inc d

Jump_0E0_46FE::
    dec c
    jr nz, Jump_0E0_46E6
    ld a, [wD88F]
    ld b, a
    ld c, $00
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0E0_4710
    ld c, $04

Jump_0E0_4710::
    ld a, c
    ld hl, wD095
    add_a_to_hl
    ld [hl], $07
    inc c
    dec b
    jr nz, Jump_0E0_4710
    xor a, a
    ld [wC5FC], a
    ret

; entry 4 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
Func_0E0_443B_Case04::
Jump_0E0_4724:: ; address name
    call Func_0E0_4804
    ret

; entry 5 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; points at: wDA72, wDA79, wDA80, wDA8E, wDA95, wDA9C, wC5FD
Func_0E0_443B_Case05::
Jump_0E0_4728:: ; address name
    ld hl, vBGMap0 + $61
    ld de, wDA72
    call Func_0E0_4763
    ld hl, vBGMap0 + $67
    ld de, wDA79
    call Func_0E0_4763
    ld hl, vBGMap0 + $6D
    ld de, wDA80
    call Func_0E0_4763
    ld hl, vBGMap0 + $141
    ld de, wDA8E
    call Func_0E0_4763
    ld hl, vBGMap0 + $147
    ld de, wDA95
    call Func_0E0_4763
    ld hl, vBGMap0 + $14D
    ld de, wDA9C
    call Func_0E0_4763
    ld hl, wC5FD
    inc [hl]
    ret

; 6 call sites from 1 routine (e.g. Func_0E0_443B_Case05)
Func_0E0_4763::
    ld a, [de]
    ld c, a
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    call Func_0E0_47EB
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47E0
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47E6
    call Func_0E0_47EB
    call Func_0E0_47F0
    call Func_0E0_47E0
    call Func_0E0_47E6
    ld a, l
    add a, $1B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_0E0_47EB
    ld a, c
    rlca
    rlca
    jr Jump_0E0_47F1

; 6 call sites from 1 routine (e.g. Func_0E0_4763)
Func_0E0_47E0::
    inc de
    ld a, [de]
    rlca
    rlca
    jr Jump_0E0_47F1

; 7 call sites from 1 routine (e.g. Func_0E0_4763)
Func_0E0_47E6::
    ld a, [de]
    swap a
    jr Jump_0E0_47F1

; 7 call sites from 1 routine (e.g. Func_0E0_4763)
Func_0E0_47EB::
    ld a, [de]
    rrca
    rrca
    jr Jump_0E0_47F1

; 6 call sites from 1 routine (e.g. Func_0E0_4763)
Func_0E0_47F0::
    ld a, [de]

Jump_0E0_47F1::
    and a, $03
    add a, $E0
    call WriteVRAMByteInc
    ret

; entry 6 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wC5FD
Func_0E0_443B_Case06::
Jump_0E0_47F9:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    xor a, a
    ld [wC5FD], a
    ret

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case04)
; points at: wC5FD
Func_0E0_4804::
    ld de, $4946
    ld hl, vBGMap0 + $20
    ld bc, $1410

Jump_0E0_480D::
    push bc
    push hl

Jump_0E0_480F::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0E0_480F
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0E0_480D
    ld hl, wC5FD
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; points at: wD989, wD999, wD9A9, wD9C9, wD9D9, wD9E9, wC5FD
Func_0E0_443B_Case08::
Jump_0E0_4825:: ; address name
    ld de, wD989
    ld hl, vBGMap0 + $62
    call Func_0E0_4863
    ld de, wD999
    ld hl, vBGMap0 + $68
    call Func_0E0_4863
    ld de, wD9A9
    ld hl, vBGMap0 + $6E
    call Func_0E0_4863
    ld de, wD9C9
    ld hl, vBGMap0 + $142
    call Func_0E0_4863
    ld de, wD9D9
    ld hl, vBGMap0 + $148
    call Func_0E0_4863
    ld de, wD9E9
    ld hl, vBGMap0 + $14E
    call Func_0E0_4863
    call Func_0E0_489C
    ld hl, wC5FD
    inc [hl]
    ret

; 6 call sites from 1 routine (e.g. Func_0E0_443B_Case08)
Func_0E0_4863::
    push hl
    call Func_0E0_4870
    pop hl
    ld a, l
    add a, $03
    ld l, a
    ld a, h
    adc a, $00
    ld h, a

; 1 call site from 1 routine (e.g. Func_0E0_4863)
Func_0E0_4870::
    ld b, $04

Jump_0E0_4872::
    ld a, [de]
    swap a
    and a, $0F
    call Func_0E0_488E
    ld a, [de]
    and a, $0F
    call Func_0E0_488E
    ld a, l
    add a, $1E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc de
    inc de
    dec b
    jr nz, Jump_0E0_4872
    ret

; 2 call sites from 1 routine (e.g. Func_0E0_4870)
Func_0E0_488E::
    cp a, $0A
    jr nc, Jump_0E0_4896
    add a, $E0
    jr Jump_0E0_4898

Jump_0E0_4896::
    sub a, $02

Jump_0E0_4898::
    call WriteVRAMByteInc
    ret

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case08)
; points at: wD0ED
Func_0E0_489C::
    ld de, $004E
    ld hl, wD0ED
    add hl, de
    add hl, de
    add hl, de
    ld b, $00
    call Func_0E0_48B7
    add hl, de
    ld b, $01
    call Func_0E0_48B7
    add hl, de
    ld b, $02
    call Func_0E0_48B7
    ret

; 3 call sites from 1 routine (e.g. Func_0E0_489C)
; reads: hFFC8, hFFC7, hFFC6
; writes: wC8C0, wC8C1, wC8C2
Func_0E0_48B7::
    push af
    push bc
    push de
    push hl
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl+]
    ld [wC8C1], a
    ld a, [hl]
    ld [wC8C2], a
    call Number24ToPackedBCD
    pop hl
    pop de
    pop bc
    pop af
    push hl
    ld a, b
    ld hl, $4935
    add a, a
    add_a_to_hl
    deref_hl
    ld b, $00
    ldh a, [hFFC8]
    and a, $0F
    or a, a
    jr z, Jump_0E0_48EC
    add a, $E0
    call WriteVRAMByte
    ld b, $01

Jump_0E0_48EC::
    inc hl
    ldh a, [hFFC7]
    swap a
    and a, $0F
    or a, a
    jr nz, Jump_0E0_48FA
    bit 0, b
    jr z, Jump_0E0_4901

Jump_0E0_48FA::
    add a, $E0
    call WriteVRAMByte
    ld b, $01

Jump_0E0_4901::
    inc hl
    ldh a, [hFFC7]
    and a, $0F
    or a, a
    jr nz, Jump_0E0_490D
    bit 0, b
    jr z, Jump_0E0_4914

Jump_0E0_490D::
    add a, $E0
    call WriteVRAMByte
    ld b, $01

Jump_0E0_4914::
    inc hl
    ldh a, [hFFC6]
    swap a
    and a, $0F
    or a, a
    jr nz, Jump_0E0_4922
    bit 0, b
    jr z, Jump_0E0_4929

Jump_0E0_4922::
    add a, $E0
    call WriteVRAMByte
    ld b, $01

Jump_0E0_4929::
    inc hl
    ldh a, [hFFC6]
    and a, $0F
    add a, $E0
    call WriteVRAMByte
    pop hl
    ret
    db $E2, $99, $E8, $99, $EE, $99

; entry 9 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wC5FD
Func_0E0_443B_Case09::
Jump_0E0_493B:: ; address name
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    xor a, a
    ld [wC5FD], a
    ret
    db $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $F8, $C3, $F9, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

; entry 10 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wD802, wJoypadPressed
; writes: wD88F, wD890, wBattleActor, wBattleTarget, wBattleActionId, wC5FD, wC5FE, wC5FF, ...
; points at: wC5FE, wD09D
Func_0E0_443B_Case0A::
Jump_0E0_4A86:: ; address name
    ld a, [wD802]
    cp a, $FF
    jr z, Jump_0E0_4A94
    farcall Func_03A_54DC
    ret

Jump_0E0_4A94::
    ld a, [wJoypadPressed]
    and a, $10
    jr z, Jump_0E0_4AA8
    ld hl, wC5FE
    inc [hl]
    ld a, [hl]
    cp a, $3C
    jr nz, Func_0E0_4ABB
    xor a, a
    ld [hl], a
    jr Func_0E0_4ABB

Jump_0E0_4AA8::
    ld a, [wJoypadPressed]
    and a, $20
    jr z, Jump_0E0_4AE7
    ld hl, wC5FE
    dec [hl]
    ld a, [hl]
    cp a, $FF
    jr nz, Func_0E0_4ABB
    ld a, $3B
    ld [hl], a

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case02)
Func_0E0_4ABB::
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_0E0_4AC6
    add a, $E0
    jr Jump_0E0_4AC8

Jump_0E0_4AC6::
    sub a, $02

Jump_0E0_4AC8::
    ld hl, vBGMap0 + $8A
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_0E0_4ADB
    add a, $E0
    jr Jump_0E0_4ADD

Jump_0E0_4ADB::
    sub a, $02

Jump_0E0_4ADD::
    ld hl, vBGMap0 + $89
    call WriteVRAMByte
    call Func_0E0_4FCE
    ret

Jump_0E0_4AE7::
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_0E0_4AF8
    farcall Func_03A_548F
    call Func_0E0_558E
    ret

Jump_0E0_4AF8::
    ld a, [wJoypadPressed]
    and a, $04
    jr z, Jump_0E0_4B2D
    ld hl, wD09D
    ld a, [hl+]
    ld [wD88F], a
    ld a, [hl+]
    ld [wD890], a
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl]
    ld [wBattleActionId], a
    ld a, $0B
    ld [wC5FD], a
    xor a, a
    ld [wC5FE], a
    call Func_0E0_510C
    call Func_0E0_4F28
    xor a, a
    ld [wC5FF], a
    call Func_0E0_4EFD
    ret

Jump_0E0_4B2D::
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld hl, wD09D
    ld a, [hl+]
    ld [wD88F], a
    ld a, [hl+]
    ld [wD890], a
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl]
    ld [wBattleActionId], a
    xor a, a
    ld [wC5FD], a
    ld a, $FF
    ld [wD802], a
    ret

; entry 11 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC0A2, wC0A0, wC0A1, wC5FE, wC5FF
; writes: wC5FF, wC0A2, wD88F, wD890, wBattleActor, wBattleTarget, wBattleActionId, wC5FD, ...
; points at: wC5FE, wC5FF, wBattleStatus, wD09D
Func_0E0_443B_Case0B::
Jump_0E0_4B54:: ; address name
    call Func_0E0_4C7E
    ld a, [wJoypadPressed]
    and a, $08
    jr z, Jump_0E0_4B74
    ld hl, wC5FE
    inc [hl]
    ld a, [hl]
    cp a, $08
    jr nz, Jump_0E0_4B69
    xor a, a
    ld [hl], a

Jump_0E0_4B69::
    call Func_0E0_4F28
    xor a, a
    ld [wC5FF], a
    call Func_0E0_4EFD
    ret

Jump_0E0_4B74::
    ld a, [wJoypadPressed]
    and a, $20
    jr z, Jump_0E0_4B9C
    ld a, [wC0A2]
    call WriteVRAMByte
    ld hl, wC5FF
    ld a, [hl]
    and a, $0F
    dec a
    and a, $0F
    cp a, $0F
    jr nz, Jump_0E0_4B93
    ld a, [hl]
    and a, $F0
    or a, $07

Jump_0E0_4B93::
    push af
    ld a, [hl]
    and a, $F0
    pop bc
    or a, b
    ld [hl], a
    jr Jump_0E0_4C10

Jump_0E0_4B9C::
    ld a, [wJoypadPressed]
    and a, $10
    jr z, Jump_0E0_4BC2
    ld a, [wC0A2]
    call WriteVRAMByte
    ld hl, wC5FF
    ld a, [hl]
    and a, $0F
    inc a
    and a, $0F
    cp a, $08
    jr nz, Jump_0E0_4BB9
    ld a, [hl]
    and a, $F0

Jump_0E0_4BB9::
    push af
    ld a, [hl]
    and a, $F0
    pop bc
    or a, b
    ld [hl], a
    jr Jump_0E0_4C10

Jump_0E0_4BC2::
    ld a, [wJoypadPressed]
    and a, $40
    jr z, Jump_0E0_4BEB
    ld a, [wC0A2]
    call WriteVRAMByte
    ld hl, wC5FF
    ld a, [hl]
    and a, $F0
    sub a, $10
    and a, $F0
    cp a, $F0
    jr nz, Jump_0E0_4BE2
    ld a, [hl]
    and a, $0F
    or a, $80

Jump_0E0_4BE2::
    push af
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a
    jr Jump_0E0_4C10

Jump_0E0_4BEB::
    ld a, [wJoypadPressed]
    and a, $80
    jr z, Jump_0E0_4C14
    ld a, [wC0A2]
    call WriteVRAMByte
    ld hl, wC5FF
    ld a, [hl]
    and a, $F0
    add a, $10
    and a, $F0
    cp a, $90
    jr nz, Jump_0E0_4C09
    ld a, [hl]
    and a, $0F

Jump_0E0_4C09::
    push af
    ld a, [hl]
    and a, $0F
    pop bc
    or a, b
    ld [hl], a

Jump_0E0_4C10::
    call Func_0E0_4EFD
    ret

Jump_0E0_4C14::
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_0E0_4C6B
    ld a, [wC0A2]
    xor a, $01
    ld [wC0A2], a
    ld a, [wC0A0]
    ld l, a
    ld a, [wC0A1]
    ld h, a
    ld a, [wC0A2]
    call WriteVRAMByte
    ld a, [wC5FE]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [wC5FF]
    ld e, a
    swap a
    and a, $0F
    ld c, a
    ld b, $00
    add hl, bc
    ld a, [wC0A2]
    and a, $01
    jr z, Jump_0E0_4C5C
    ld a, e
    ld de, $4C76
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_0E0_4C58
    inc d

Jump_0E0_4C58::
    ld a, [de]
    or a, [hl]
    ld [hl], a
    ret

Jump_0E0_4C5C::
    ld a, e
    ld de, $4C6E
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_0E0_4C67
    inc d

Jump_0E0_4C67::
    ld a, [de]
    and a, [hl]
    ld [hl], a
    ret

Jump_0E0_4C6B::
    jp Jump_0E0_4B2D
    db $FE, $FD, $FB, $F7, $EF, $DF, $BF, $7F, $01, $02, $04, $08, $10, $20, $40, $80

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case0B)
; reads: wC0A0, wC0A1, wFrameCounterLo, wC0A2
Func_0E0_4C7E::
    ld a, [wC0A0]
    ld l, a
    ld a, [wC0A1]
    ld h, a
    ld a, [wFrameCounterLo]
    bit 3, a
    ld a, $C3
    jr z, Jump_0E0_4C92
    ld a, [wC0A2]

Jump_0E0_4C92::
    call WriteVRAMByte
    ret

; entry 12 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
Func_0E0_443B_Case0C::
Jump_0E0_4C96:: ; address name
    call Func_0E0_4001
    ret

; entry 13 of the `rst $00` table in Func_0E0_443B
; no direct call (reached through a table, a jump or a vector)
; reads: wC5FE
Func_0E0_443B_Case0D::
Jump_0E0_4C9A:: ; address name
    ld a, [wC5FE]
    rst $00
    dw Func_0E0_4C7E_Case00
    dw Func_0E0_4C7E_Case01
    dw Func_0E0_4C7E_Case02
    dw Func_0E0_4C7E_Case03
    dw Func_0E0_4C7E_Case04
    dw Func_0E0_4C7E_Case05

; entry 0 of the `rst $00` table in Func_0E0_4C7E
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wBattleActor, wC5FE
Func_0E0_4C7E_Case00::
Jump_0E0_4CAA:: ; address name
    ld hl, vTiles2 + $10
    ld de, $1001
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call Func_0E0_4279
    ld hl, vTiles1
    ld de, $1201
    ld a, $0E
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call Func_0E0_4279
    ld de, $4D95
    ld bc, $1412
    ld hl, vBGMap0

Jump_0E0_4CD9::
    push bc
    push hl

Jump_0E0_4CDB::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_0E0_4CDB
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_0E0_4CD9
    xor a, a
    ld [wBattleActor], a
    ld a, $01
    ld [wC5FE], a
    ret

; entry 1 of the `rst $00` table in Func_0E0_4C7E
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wPersonalityIndex, wC5FE
Func_0E0_4C7E_Case01::
Jump_0E0_4CF6:: ; address name
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_BankE0
    ld [wPersonalityIndex], a
    farcall Func_0E0_56C7
    ld a, $02
    ld [wC5FE], a
    ret

; entry 2 of the `rst $00` table in Func_0E0_4C7E
; no direct call (reached through a table, a jump or a vector)
; writes: wC5FE
Func_0E0_4C7E_Case02::
Jump_0E0_4D0B:: ; address name
    farcall Func_0E0_572D
    ld a, $03
    ld [wC5FE], a
    ret

; entry 3 of the `rst $00` table in Func_0E0_4C7E
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wBattleActor
; writes: wC5FE, wBattleActor
; points at: wBattleSubPhase
Func_0E0_4C7E_Case03::
Jump_0E0_4D17:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_0E0_4D2A
    ld a, $04
    ld [wC5FE], a
    xor a, a
    ld hl, wBattleSubPhase
    ld [hl+], a
    ld [hl], a
    ret

Jump_0E0_4D2A::
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr z, Jump_0E0_4D37
    ld a, $01
    ld [wC5FE], a
    ret

Jump_0E0_4D37::
    bit 5, a
    jr z, Jump_0E0_4D4F

Jump_0E0_4D3B::
    ld a, [wBattleActor]
    dec a
    and a, $07
    ld [wBattleActor], a
    call CarryUnlessWDA63SlotEmpty
    jr z, Jump_0E0_4D3B
    ld a, $01
    ld [wC5FE], a
    ret

Jump_0E0_4D4F::
    bit 4, a
    jr z, Jump_0E0_4D67

Jump_0E0_4D53::
    ld a, [wBattleActor]
    inc a
    and a, $07
    ld [wBattleActor], a
    call CarryUnlessWDA63SlotEmpty
    jr z, Jump_0E0_4D53
    ld a, $01
    ld [wC5FE], a
    ret

Jump_0E0_4D67::
    bit 2, a
    jr z, Jump_0E0_4D71
    ld a, $05
    ld [wC5FE], a
    ret

Jump_0E0_4D71::
    ret

; entry 4 of the `rst $00` table in Func_0E0_4C7E
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wC5FE, wC5FD
; points at: wDA1C
Func_0E0_4C7E_Case04::
Jump_0E0_4D72:: ; address name
    xor a, a
    ld [wBattleActor], a
    ld [wC5FE], a
    ld a, $03
    ld [wC5FD], a
    ld a, $FF
    ld hl, wDA1C
    ld bc, $0010
    jp FillBytes

; entry 5 of the `rst $00` table in Func_0E0_4C7E
; no direct call (reached through a table, a jump or a vector)
; writes: wC5FE
Func_0E0_4C7E_Case05::
Jump_0E0_4D89:: ; address name
    farcall Func_0E0_5A35
    ld a, $02
    ld [wC5FE], a
    ret
    db $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $80, $81, $82, $01, $C3, $C3, $9B, $9C, $9D, $9E, $9F, $A0
    db $A1, $A2, $C3, $C3, $B7, $B6, $C3, $C3, $8B, $8C, $C3, $C3, $C3, $C3, $ED, $EE
    db $EF, $F0, $F1, $F2, $F3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    INCBIN "dwm2-cobi-us.gbc", $380DE4, $DE
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

; 3 call sites from 2 routines (e.g. Func_0E0_443B_Case0B, Func_0E0_4ABB)
; reads: wC5FF
; writes: wC0A0, wC0A1, wC0A2
Func_0E0_4EFD::
    ld a, [wC5FF]
    ld b, a
    and a, $0F
    ld c, a
    ld a, b
    swap a
    and a, $0F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld b, $00
    add hl, bc
    ld bc, vBGMap0 + $89
    add hl, bc
    ld a, l
    ld [wC0A0], a
    ld a, h
    ld [wC0A1], a
    call WaitForVRAMAccess
    ld a, [hl]
    ld [wC0A2], a
    ret

; 2 call sites from 2 routines (e.g. Func_0E0_443B_Case0B, Func_0E0_4ABB)
; reads: wC5FE, wD868, wD869
; writes: wD868, wD869
; points at: wBattleStatus
Func_0E0_4F28::
    ld a, [wC5FE]
    call Func_0E0_4F86
    ld hl, vBGMap0 + $89
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld c, $00
    ld a, [wC5FE]
    ld hl, wBattleStatus
    call AddAx9ToHL

Jump_0E0_4F44::
    ld d, [hl]
    ld b, $00

Jump_0E0_4F47::
    push hl
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    ld a, l
    add a, b
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, d
    and a, $01
    add a, $E0
    call WriteVRAMByte
    pop hl
    srl d
    inc b
    ld a, b
    cp a, $08
    jr nz, Jump_0E0_4F47
    push hl
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    ld de, $0020
    add hl, de
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $09
    jr nz, Jump_0E0_4F44
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4F28)
Func_0E0_4F86::
    add a, a
    ld hl, $4F9E
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0 + $27
    ld bc, $0401
    ld a, $E0
    call Func_000_15DE
    ret
    dw Data_0E0_4FAE
    dw Data_0E0_4FB2
    dw Data_0E0_4FB6
    dw Data_0E0_4FBA
    dw Data_0E0_4FBE
    dw Data_0E0_4FC2
    dw Data_0E0_4FC6
    dw Data_0E0_4FCA

Data_0E0_4FAE:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E0

Data_0E0_4FB2:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E1

Data_0E0_4FB6:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E2

Data_0E0_4FBA:: ; heuristic: target of a monotone pointer table; C0
    db $F5, $F6, $F7, $E3

Data_0E0_4FBE:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E0, $C3

Data_0E0_4FC2:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E1, $C3

Data_0E0_4FC6:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E2, $C3

Data_0E0_4FCA:: ; heuristic: target of a monotone pointer table; C0
    db $F8, $F9, $E3, $C3

; 2 call sites from 2 routines (e.g. Func_0E0_4ABB, Func_0E0_443B_Case02)
Func_0E0_4FCE::
    call Func_0E0_4FDB
    call Func_0E0_502B
    farcall Func_03A_53B9
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4FCE)
; reads: wC5F9, wRecordBufferData, wC8C0, wC8C1, wC8C2
; writes: wD868, wRecordBuffer, wCFED, wD869, wD86A, wD86B
; points at: wRecordBufferData
Func_0E0_4FDB::
    ld a, $00
    ld [wD868], a
    ld a, [wC5F9]
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    ld a, $01
    ld [wD869], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C0]
    add a, $E0
    ld hl, vBGMap0 + $204
    call WriteVRAMByte
    ld a, [wC8C1]
    add a, $E0
    ld hl, vBGMap0 + $205
    call WriteVRAMByte
    ld a, [wC8C2]
    add a, $E0
    ld hl, vBGMap0 + $206
    call WriteVRAMByte
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4FCE)
; reads: wC5F9, wCFF7, wCFF8, wC8C0, wC8C1, wC8C2, wCFF9, wCFFB, ...
; writes: wRecordBuffer, wCFED
Func_0E0_502B::
    ld a, [wC5F9]
    ld [wRecordBuffer], a
    xor a, a
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF8]
    ld h, a
    push hl
    call HLToDecimalDigits
    ld a, [wC8C0]
    add a, $E0
    ld hl, vBGMap0 + $1C3
    call WriteVRAMByte
    ld a, [wC8C1]
    add a, $E0
    ld hl, vBGMap0 + $1C4
    call WriteVRAMByte
    ld a, [wC8C2]
    add a, $E0
    ld hl, vBGMap0 + $1C5
    call WriteVRAMByte
    pop hl
    ld a, [wCFF9]
    ld c, a
    ld b, $00
    add hl, bc
    call HLToDecimalDigits
    ld a, [wC8C0]
    add a, $E0
    ld hl, vBGMap0 + $1E3
    call WriteVRAMByte
    ld a, [wC8C1]
    add a, $E0
    ld hl, vBGMap0 + $1E4
    call WriteVRAMByte
    ld a, [wC8C2]
    add a, $E0
    ld hl, vBGMap0 + $1E5
    call WriteVRAMByte
    ld a, [wCFFB]
    ld l, a
    ld a, [wCFFC]
    ld h, a
    push hl
    call HLToDecimalDigits
    ld a, [wC8C0]
    add a, $E0
    ld hl, vBGMap0 + $1C7
    call WriteVRAMByte
    ld a, [wC8C1]
    add a, $E0
    ld hl, vBGMap0 + $1C8
    call WriteVRAMByte
    ld a, [wC8C2]
    add a, $E0
    ld hl, vBGMap0 + $1C9
    call WriteVRAMByte
    pop hl
    ld a, [wCFFD]
    ld c, a
    ld b, $00
    add hl, bc
    call HLToDecimalDigits
    ld a, [wC8C0]
    add a, $E0
    ld hl, vBGMap0 + $1E7
    call WriteVRAMByte
    ld a, [wC8C1]
    add a, $E0
    ld hl, vBGMap0 + $1E8
    call WriteVRAMByte
    ld a, [wC8C2]
    add a, $E0
    ld hl, vBGMap0 + $1E9
    call WriteVRAMByte
    ret

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case00)
Func_0E0_50EE::
    ld hl, vBGMap0
    ld de, $511B
    ld bc, $1412
    ld a, $E0
    call Func_000_15DE
    ret

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case02)
Func_0E0_50FD::
    ld hl, vBGMap0
    ld de, $5283
    ld bc, $1412
    ld a, $E0
    call Func_000_15DE
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4ABB)
Func_0E0_510C::
    ld hl, vBGMap0
    ld de, $53EB
    ld bc, $1412
    ld a, $E0
    call Func_000_15DE
    ret
    db $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $C3, $C3, $F5, $F6, $F7, $C3, $C3, $C3, $F8, $F9, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6, $EB, $C3, $C3, $C3, $C3, $C3, $EB, $C3, $C3, $C3
    db $C3, $C3, $EB, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3, $C3, $C3, $C3, $C3, $EC, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    INCBIN "dwm2-cobi-us.gbc", $381192, $DE
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $0E, $09, $0F, $C3, $0C, $0D, $0D, $0C, $0A, $FF
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    INCBIN "dwm2-cobi-us.gbc", $38130E, $CA
    ds $12, $B4
    db $B5, $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $C3, $C3, $09, $F0, $FF, $C3, $E0, $E1, $E2, $E3, $E4, $E5
    db $E6, $E7, $C3, $C3, $B7, $B6
    ds $12, $C3
    INCBIN "dwm2-cobi-us.gbc", $38143A, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

; 1 call site from 1 routine (e.g. Func_0E0_443B_Case00)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530
Func_0E0_5553::
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank09
    pop de
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4ABB)
; reads: wC5FE
Func_0E0_558E::
    ld a, [wC5FE]
    ld hl, $55BF
    add_a_to_hl
    ld a, [hl]
    call QueueSoundEffect
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wBattleTarget, wBattleActionId, wDAD3
Func_0E0_559E:: ; heuristic: follows a terminator; C0
    add a, a
    add a, a
    ld hl, $55FB
    add_a_to_hl
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl+]
    ld [wBattleActionId], a
    ld a, [hl]
    ld [wDAD3], a
    farcall Func_03A_5762
    ret

; no direct call (reached through a table, a jump or a vector)
Func_0E0_55BF:: ; heuristic: follows a terminator; C0
    adc a, c
    adc a, e
    adc a, e
    adc a, l
    adc a, l
    adc a, a
    sub a, b
    reti
    INCBIN "dwm2-cobi-us.gbc", $3815C7, $100

; 1 call site from 1 routine (e.g. Func_0E0_4C7E_Case01)
; reads: wBattleActor, wC58A, wC5BA, wC5BB, wC5E7, wC5E8
; writes: wC5E7, wC5E8, wC5BA, wC5BB
; points at: wDA1C
Func_0E0_56C7::
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld a, $FF
    ld [hl+], a
    ld [hl], a
    ld a, [wC58A]
    or a, a
    jr z, Jump_0E0_570B
    ld a, [wC5BA]
    ld l, a
    ld a, [wC5BB]
    ld h, a
    push hl
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    push hl
    farcall Func_030_4595
    call Func_0E0_5715
    pop hl
    ld a, l
    ld [wC5E7], a
    ld a, h
    ld [wC5E8], a
    pop hl
    ld a, l
    ld [wC5BA], a
    ld a, h
    ld [wC5BB], a
    ret

Jump_0E0_570B::
    farcall Func_030_4595
    call Func_0E0_5715
    ret

; 2 call sites from 1 routine (e.g. Func_0E0_56C7)
; reads: wBattleActor
; points at: wDA1D
Func_0E0_5715::
    ld a, [wBattleActor]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_0E0_572C
    farcall Func_039_4001

Jump_0E0_572C::
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4C7E_Case02)
; reads: wBattleActor, wC58A, hFFC9, hFFC8
; writes: wC52D, wC52E, wC52F, wC530, wStringIndex, wStringCategory, wC8C0, wC8C1, ...
; points at: wDA43, wDA53, wD988, wD2AD, wDA1C, wDA3F, hFFFC, wCFDE
Func_0E0_572D::
    call Func_0E0_5992
    ld hl, $5A05
    call Func_000_0B0D
    ld d, h
    ld e, l
    ld hl, vBGMap0 + $23
    ld b, $04

Jump_0E0_573D::
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, Jump_0E0_573D
    ld hl, vTiles1 + $1B0
    ld de, $0801
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wBattleActor]
    and a, $03
    cp a, $03
    jr z, Jump_0E0_578A
    ld a, [wBattleActor]
    ld hl, wDA43
    add_a_to_hl
    ld a, [hl]
    and a, $03
    add a, $02
    ld [wStringIndex], a
    ld a, $0E
    ld [wStringCategory], a
    ld hl, vTiles1 + $1B0
    ld de, $0801
    call Func_0E0_5A79

Jump_0E0_578A::
    ld a, [wBattleActor]
    ld de, wDA53
    add a, e
    ld e, a
    jr nc, Jump_0E0_5795
    inc d

Jump_0E0_5795::
    ld a, [de]
    add a, $8D
    ld hl, vBGMap0 + $46
    di
    call WriteVRAMByte
    ei
    ld hl, vTiles1 + $6D0
    ld de, $0701
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wBattleActor]
    call PersonalityIndexOfSlot_BankE0
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, vTiles1 + $6D0
    ld de, $0701
    call Func_0E0_5A79
    ld a, [wC58A]
    cp a, $01
    ld a, [wBattleActor]
    jr z, Jump_0E0_57DE
    sub a, $04
    jr nc, Jump_0E0_57F0

Jump_0E0_57DE::
    ld a, $C3
    ld hl, vBGMap0 + $1AF
    di
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByte
    ei
    jr Jump_0E0_581A

Jump_0E0_57F0::
    ld de, wCFDE
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_0E0_57F9
    inc d

Jump_0E0_57F9::
    ld hl, vBGMap0 + $1AF
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    dec de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei

Jump_0E0_581A::
    ld a, [wBattleActor]
    swap a
    ld hl, wD988
    add_a_to_hl
    ld d, h
    ld e, l
    ld hl, vBGMap0 + $A2
    ld b, $08

Jump_0E0_582E::
    push hl
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    inc hl
    inc de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    pop hl
    push de
    ld de, $0020
    add hl, de
    pop de
    inc de
    dec b
    jr nz, Jump_0E0_582E
    ld de, wD2AD
    ld hl, vBGMap0 + $A8
    ld b, $0A

Jump_0E0_5861::
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    and a, c
    cp a, $FF
    jr nz, Jump_0E0_5898
    ld a, [de]
    and a, $F0
    swap a
    push hl
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    dec de
    ld a, [de]
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    pop hl
    inc de
    jr Jump_0E0_58C4

Jump_0E0_5898::
    push hl
    push de
    push bc
    ld a, c
    ld [wC8C0], a
    ld a, [de]
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    pop bc
    pop de
    pop hl
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFC8]
    or a, c
    jr z, Jump_0E0_58BB
    ld a, $99
    ldh [hFFC7], a
    ldh [hFFC6], a

Jump_0E0_58BB::
    push bc
    push hl
    ld c, $00
    call Func_0E0_59C0
    pop hl
    pop bc

Jump_0E0_58C4::
    inc de
    push de
    ld de, $0020
    add hl, de
    pop de
    dec b
    jr nz, Jump_0E0_5861
    ld a, $04
    ld [wStringCategory], a
    ld a, [wBattleActor]
    add a, a
    ld hl, wDA1C
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    or a, a
    jr nz, Jump_0E0_58F0
    ld a, $0E
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a

Jump_0E0_58F0::
    ld hl, vTiles1 + $120
    ld de, $0901
    call Func_0E0_5A79
    ld a, [wBattleActor]
    add a, a
    ld de, wDA1C
    add a, e
    ld e, a
    jr nc, Jump_0E0_5905
    inc d

Jump_0E0_5905::
    ld a, [de]
    ld hl, vBGMap0 + $202
    and a, $F0
    swap a
    inc a
    di
    call WriteVRAMByteInc
    ei
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    call Func_0E0_59A4
    ld hl, $5A05
    call Func_000_0B0D
    ld d, h
    ld e, l
    ld hl, vBGMap0 + $20F
    ld b, $04

Jump_0E0_592C::
    di
    ld a, [de]
    call WriteVRAMByteInc
    ei
    inc de
    dec b
    jr nz, Jump_0E0_592C
    ld b, $03
    ld c, $01
    ld hl, wDA3F

Jump_0E0_593D::
    push bc
    push hl
    ld b, $03

Jump_0E0_5941::
    ld a, [hl+]
    cp a, c
    jr nz, Jump_0E0_596D
    ld de, $FFFC
    add hl, de
    ld a, [hl]
    ld [wC8C0], a
    xor a, a
    ld [wC8C1], a
    ld [wC8C2], a
    push bc
    call Number24ToPackedBCD
    pop bc
    swap c
    ld b, $00
    ld hl, vBGMap0 + $8F
    add hl, bc
    add hl, bc
    push bc
    push hl
    ld c, $00
    call Func_0E0_59D4
    pop hl
    pop bc
    jr Jump_0E0_5970

Jump_0E0_596D::
    dec b
    jr nz, Jump_0E0_5941

Jump_0E0_5970::
    pop hl
    pop bc
    inc c
    dec b
    jr nz, Jump_0E0_593D
    ld hl, vBGMap0 + $131
    ld de, wDA3F
    ld b, $03

Jump_0E0_597E::
    ld a, [de]
    and a, $0F
    inc a
    di
    call WriteVRAMByte
    ei
    push de
    ld de, $0020
    add hl, de
    pop de
    inc de
    dec b
    jr nz, Jump_0E0_597E
    ret

; 1 call site from 1 routine (e.g. Func_0E0_572D)
; reads: wC58A, wBattleActor
; points at: wC57F
Func_0E0_5992::
    ld a, [wC58A]
    ld hl, wC57F
    cp a, $01
    ld a, [wBattleActor]
    ret nz
    bit 1, [hl]
    ret z
    xor a, $04
    ret

; 1 call site from 1 routine (e.g. Func_0E0_572D)
; reads: wBattleActor, wC58A
; points at: wDA1D, wC57F
Func_0E0_59A4::
    ld a, [wBattleActor]
    add a, a
    ld de, wDA1D
    add a, e
    ld e, a
    jr nc, Jump_0E0_59B0
    inc d

Jump_0E0_59B0::
    ld a, [wC58A]
    ld hl, wC57F
    cp a, $01
    ld a, [de]
    ret nz
    bit 1, [hl]
    ret z
    xor a, $04
    ret

; 1 call site from 1 routine (e.g. Func_0E0_572D)
; reads: hFFC7, hFFC6
Func_0E0_59C0::
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, Jump_0E0_59CE
    ld a, $C2

Jump_0E0_59CE::
    inc a
    di
    call WriteVRAMByteInc
    ei

; 1 call site from 1 routine (e.g. Func_0E0_572D)
; reads: hFFC7, hFFC6
Func_0E0_59D4::
    ldh a, [hFFC7]
    and a, $0F
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, Jump_0E0_59E0
    ld a, $C2

Jump_0E0_59E0::
    inc a
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC6]
    and a, $F0
    swap a
    ld b, a
    or a, c
    ld c, a
    ld a, b
    jr nz, Jump_0E0_59F4
    ld a, $C2

Jump_0E0_59F4::
    inc a
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC6]
    and a, $0F
    inc a
    di
    call WriteVRAMByteInc
    ei
    ret
    dw Data_0E0_5A15
    dw Data_0E0_5A19
    dw Data_0E0_5A1D
    dw Data_0E0_5A21
    dw Data_0E0_5A25
    dw Data_0E0_5A29
    dw Data_0E0_5A2D
    dw Data_0E0_5A31

Data_0E0_5A15:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $01

Data_0E0_5A19:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $02

Data_0E0_5A1D:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $03

Data_0E0_5A21:: ; heuristic: target of a monotone pointer table; C0
    db $80, $81, $82, $04

Data_0E0_5A25:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $01, $C3

Data_0E0_5A29:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $02, $C3

Data_0E0_5A2D:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $03, $C3

Data_0E0_5A31:: ; heuristic: target of a monotone pointer table; C0
    db $83, $84, $04, $C3

; 1 call site from 1 routine (e.g. Func_0E0_4C7E_Case05)
; reads: wC58A, wC5BA, wC5BB, wC5E7, wC5E8
; writes: wC5E7, wC5E8, wC5BA, wC5BB
Func_0E0_5A35::
    ld a, [wC58A]
    or a, a
    jr z, Jump_0E0_5A6C
    ld a, [wC5BA]
    ld l, a
    ld a, [wC5BB]
    ld h, a
    push hl
    ld a, [wC5E7]
    ld l, a
    ld a, [wC5E8]
    ld h, a
    push hl
    farcall Func_030_5440
    farcall Func_039_4001
    pop hl
    ld a, l
    ld [wC5E7], a
    ld a, h
    ld [wC5E8], a
    pop hl
    ld a, l
    ld [wC5BA], a
    ld a, h
    ld [wC5BB], a
    ret

Jump_0E0_5A6C::
    farcall Func_030_5440
    farcall Func_039_4001
    ret

; 3 call sites from 1 routine (e.g. Func_0E0_572D)
; writes: wC52D, wC52E, wC52F, wC530
Func_0E0_5A79::
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret
    db $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $7B, $EA, $2F, $C5, $7A, $EA, $30, $C5
    db $21, $0F, $40, $06, $09, $D7, $21, $00, $88, $7D, $EA, $2D, $C5, $7C, $EA, $2E
    db $C5, $21, $02, $12, $7D, $EA, $2F, $C5, $7C, $EA, $30, $C5, $C9

; only called from DebugStaffRoll_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugStaffRoll_Update)
; reads: wD09D, wD09F, wD09E
DebugStaffRoll_Update_Sub01::
Func_0E0_5AD3:: ; address name
    ld a, [wD09D]
    or a, a
    jp z, Jump_0E0_6FF7
    farcall Func_002_5074
    call IncrementSpriteSlotCounters
    ld a, [wD09F]
    dec a
    rst $00
    dw Func_0E0_5AD3_Case00
    dw Func_0E0_5AD3_Case01
    dw Func_0E0_5AD3_Case02
    dw Func_0E0_5AD3_Case03
    dw Func_0E0_5AD3_Case04

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD09E
Func_0E0_5AD3_Case00::
Jump_0E0_5AF2:: ; address name
    ld a, [wD09E]
    rst $00
    dw Func_0E0_5AD3_Table2_Case00
    dw Func_0E0_5AD3_Table2_Case01
    dw Func_0E0_5AD3_Table2_Case02
    dw Func_0E0_5AD3_Table2_Case03
    dw Func_0E0_5AD3_Table2_Case04
    dw Func_0E0_5AD3_Table2_Case05
    dw Func_0E0_5AD3_Table2_Case06
    dw Func_0E0_5AD3_Table2_Case07
    dw Func_0E0_5AD3_Table2_Case08
    dw Func_0E0_5AD3_Table2_Case09
    dw Func_0E0_5AD3_Table2_Case0A
    dw Func_0E0_5AD3_Table2_Case0B
    dw Func_0E0_5AD3_Table2_Case0C
    dw Func_0E0_5AD3_Table2_Case0D
    dw Func_0E0_5AD3_Table2_Case0E
    dw Func_0E0_5AD3_Table2_Case0F

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount, wC90D
; points at: wScreenTileBuffer, wD000, wC49F, wC4DF, wC4E7, wC4EF, wC4F7, wSpriteSlots, ...
Func_0E0_5AD3_Table2_Case00::
Jump_0E0_5B16:: ; address name
    ld b, $7D
    ld de, Data_07D_4001
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_40FA
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_41E1
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7E
    ld de, Data_07E_4F22
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $93
    ld de, Data_093_4001
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $46
    ld de, Data_046_496B
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0E0_5BB2
    ld a, $02
    ldh [rSVBK], a
    ld b, $46
    ld de, Data_046_5301
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $48
    ld de, Data_048_4001
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, wC4DF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, wC4E7
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, wC4EF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4C0D
    ld hl, wC4F7
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_0E0_5BB2::
    ld hl, vBGMap0
    call Func_000_1E29
    ld a, $03
    ld [wSpriteSlotCount], a
    ld a, $01
    ld [wC90D], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $0A
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table2_Case01::
Jump_0E0_5C32:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, $03
    ld de, $6050
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A7
; writes: wD0A7
; points at: wD09E
Func_0E0_5AD3_Table2_Case02::
Jump_0E0_5C58:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A7]
    inc a
    ld [wD0A7], a
    and a, $01
    ret nz
    ld a, $03
    ld de, $6060
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wD0A7], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case03::
Jump_0E0_5C7B:: ; address name
    call DrawSpriteSlots
    ld a, $03
    ld de, $6050
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case04::
Jump_0E0_5C91:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $6020
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ld a, $00
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case05::
Jump_0E0_5CB5:: ; address name
    call DrawSpriteSlots
    ld a, $03
    ld de, $6040
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wD0A7
; points at: wD09E
Func_0E0_5AD3_Table2_Case06::
Jump_0E0_5CD1:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $6030
    call Func_0E0_74D8
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wD0A7], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case09::
Jump_0E0_5CEA:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5040
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case0A::
Jump_0E0_5D14:: ; address name
    call DrawSpriteSlots
    ld a, $01
    ld de, $1040
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ld a, $01
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case0B::
Jump_0E0_5D46:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $5000
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5000
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 12 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case0C::
Jump_0E0_5D7F:: ; address name
    call DrawSpriteSlots
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $00
    ld de, $6030
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 13 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case0D::
Jump_0E0_5D9F:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $4030
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case0E::
Jump_0E0_5DCA:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wC90D, wD09D, wD09E
Func_0E0_5AD3_Table2_Case0F::
Jump_0E0_5DDD:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $4000
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4000
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wC90D], a
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wD09D], a
    xor a, a
    ld [wD09E], a
    ret

; entry 7 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table2_Case07::
Jump_0E0_5E07:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A7
; writes: wD0A7
; points at: wD09E
Func_0E0_5AD3_Table2_Case08::
Jump_0E0_5E24:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A7]
    inc a
    ld [wD0A7], a
    and a, $01
    ret nz
    ld a, $02
    ld de, $6030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $6040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD09E
Func_0E0_5AD3_Case01::
Jump_0E0_5E4B:: ; address name
    ld a, [wD09E]
    rst $00
    dw Func_0E0_5AD3_Table3_Case00
    dw Func_0E0_5AD3_Table3_Case01
    dw Func_0E0_5AD3_Table3_Case02
    dw Func_0E0_5AD3_Table3_Case03
    dw Func_0E0_5AD3_Table3_Case04
    dw Func_0E0_5AD3_Table3_Case05
    dw Func_0E0_5AD3_Table3_Case06
    dw Func_0E0_5AD3_Table3_Case07
    dw Func_0E0_5AD3_Table3_Case08
    dw Func_0E0_5AD3_Table3_Case09
    dw Func_0E0_5AD3_Table3_Case06
    dw Func_0E0_5AD3_Table3_Case07
    dw Func_0E0_5AD3_Table3_Case08
    dw Func_0E0_5AD3_Table3_Case09
    dw Func_0E0_5AD3_Table3_Case06
    dw Func_0E0_5AD3_Table3_Case07
    dw Func_0E0_5AD3_Table3_Case08
    dw Func_0E0_5AD3_Table3_Case09
    dw Func_0E0_5AD3_Table3_Case06
    dw Func_0E0_5AD3_Table3_Case07
    dw Func_0E0_5AD3_Table3_Case14
    dw Func_0E0_5AD3_Table3_Case15
    dw Func_0E0_5AD3_Table3_Case16
    dw Func_0E0_5AD3_Table3_Case17
    dw Func_0E0_5AD3_Table3_Case18
    dw Func_0E0_5AD3_Table3_Case19

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount, wC90D
; points at: wScreenTileBuffer, wD000, wC49F, wC4DF, wC4E7, wC4EF, wSpriteSlots, wD09E
Func_0E0_5AD3_Table3_Case00::
Jump_0E0_5E83:: ; address name
    ld b, $7D
    ld de, Data_07D_4001
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_40FA
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_41E1
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $46
    ld de, Data_046_7025
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $46
    ld de, Data_046_777A
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0E0_5F07
    ld a, $02
    ldh [rSVBK], a
    ld b, $46
    ld de, Data_046_7A9D
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $48
    ld de, Data_048_4081
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, wC4DF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, wC4E7
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, wC4EF
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_0E0_5F07::
    ld hl, vBGMap0
    call Func_000_1E29
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $01
    ld [wC90D], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $70
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wD09E
Func_0E0_5AD3_Table3_Case01::
Jump_0E0_5F6F:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $00
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $01
    ld de, $6030
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3
; writes: wD0A3
; points at: wD09E
Func_0E0_5AD3_Table3_Case02::
Jump_0E0_5F91:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    srl a
    swap a
    and a, $07
    ld hl, $5FE3
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wD0A3]
    srl a
    swap a
    and a, $07
    ld hl, $5FE8
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    cp a, $9F
    ret c
    xor a, a
    ld [wD0A3], a
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret
    db $03, $02, $03, $00, $03, $01, $00, $01, $02, $01

; entry 3 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table3_Case03::
Jump_0E0_5FED:: ; address name
    call DrawSpriteSlots
    ld a, $03
    ld [wSpriteSlotCount], a
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wCB92, wD0A3
; writes: wD0A3, wCB92
; points at: wD09E
Func_0E0_5AD3_Table3_Case04::
Jump_0E0_5FFE:: ; address name
    call DrawSpriteSlots
    ld d, $60
    ld a, [wCB92]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, Jump_0E0_6022
    call StepWD0A2Mod15
    ret nz
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_6022::
    ld a, [wD0A3]
    ld c, a
    ld b, $00
    inc a
    ld [wD0A3], a
    ld hl, $6038
    add hl, bc
    ld a, [wCB92]
    add a, [hl]
    ld [wCB92], a
    ret
    db $FE, $FE, $FE, $FF, $FF, $FF, $00, $00, $00, $00, $01, $01, $01, $02, $02, $02

; entry 5 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table3_Case05::
Jump_0E0_6048:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $6050
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 22 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCB92
; writes: wCB92, wD0A3
; points at: wD09E
Func_0E0_5AD3_Table3_Case16::
Jump_0E0_605D:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, [wD0A3]
    cp a, $20
    jr nc, Jump_0E0_6086
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wCB92]
    add a, [hl]
    ld [wCB92], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_6086::
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 20 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table3_Case14::
Jump_0E0_6093:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $02
    ld de, $4030
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 21 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3
; writes: wD0A3
; points at: wD09E
Func_0E0_5AD3_Table3_Case15::
Jump_0E0_60C0:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    and a, $03
    ret nz
    ld a, $02
    ld de, $3030
    call StepSpriteSlotToward
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 24 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wCB91, wCB96
; writes: wSpriteSlotCount, wCB91, wCB96
; points at: wD09E
Func_0E0_5AD3_Table3_Case18::
Jump_0E0_60DF:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, [wCB91]
    cp a, $F0
    jr nz, Jump_0E0_6113
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $03
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_6113::
    sub a, $02
    ld [wCB91], a
    ld a, [wCB96]
    inc a
    ld [wCB96], a
    ret

; entry 25 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wCB81, wCB86, wCB89, wCB8E
; writes: wCB81, wCB86, wSpriteSlotCount, wC90D, wD09D, wD09E, wCB89, wCB8E
Func_0E0_5AD3_Table3_Case19::
Jump_0E0_6120:: ; address name
    call DrawSpriteSlots
    ld a, [wCB81]
    cp a, $F0
    jr z, Jump_0E0_6136
    sub a, $01
    ld [wCB81], a
    ld a, [wCB86]
    inc a
    ld [wCB86], a

Jump_0E0_6136::
    ld a, [wCB89]
    cp a, $F0
    jr nz, Jump_0E0_6158
    ld a, $02
    ld [wSpriteSlotCount], a
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wC90D], a
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wD09D], a
    xor a, a
    ld [wD09E], a
    ret

Jump_0E0_6158::
    sub a, $01
    ld [wCB89], a
    ld a, [wCB8E]
    inc a
    ld [wCB8E], a
    ret

; entry 6 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wCB92, wD0A3
; writes: wD0A3, wCB92
; points at: wD09E
Func_0E0_5AD3_Table3_Case06::
Jump_0E0_6165:: ; address name
    call DrawSpriteSlots
    ld d, $50
    ld a, [wCB92]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, Jump_0E0_617E
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_617E::
    ld a, [wD0A3]
    ld c, a
    ld b, $00
    inc a
    ld [wD0A3], a
    ld hl, $6038
    add hl, bc
    ld a, [wCB92]
    add a, [hl]
    ld [wCB92], a
    ret

; entry 9 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wCB92, wD0A3
; writes: wD0A3, wCB92
; points at: wD09E
Func_0E0_5AD3_Table3_Case09::
Jump_0E0_6194:: ; address name
    call DrawSpriteSlots
    ld d, $60
    ld a, [wCB92]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, Jump_0E0_61AD
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_61AD::
    ld a, [wD0A3]
    ld c, a
    ld b, $00
    inc a
    ld [wD0A3], a
    ld hl, $6038
    add hl, bc
    ld a, [wCB92]
    add a, [hl]
    ld [wCB92], a
    ret

; entry 7 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wCB92, wD0A3
; writes: wD0A3, wCB92
; points at: wD09E
Func_0E0_5AD3_Table3_Case07::
Jump_0E0_61C3:: ; address name
    call DrawSpriteSlots
    ld d, $40
    ld a, [wCB92]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, Jump_0E0_61DC
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_61DC::
    ld a, [wD0A3]
    ld c, a
    ld b, $00
    inc a
    ld [wD0A3], a
    ld hl, $6038
    add hl, bc
    ld a, [wCB92]
    add a, [hl]
    ld [wCB92], a
    ret

; entry 8 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wCB92, wD0A3
; writes: wD0A3, wCB92
; points at: wD09E
Func_0E0_5AD3_Table3_Case08::
Jump_0E0_61F2:: ; address name
    call DrawSpriteSlots
    ld d, $50
    ld a, [wCB92]
    ld e, a
    ld a, $02
    call StepSpriteSlotToward
    jr nz, Jump_0E0_620B
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_620B::
    ld a, [wD0A3]
    ld c, a
    ld b, $00
    inc a
    ld [wD0A3], a
    ld hl, $6038
    add hl, bc
    ld a, [wCB92]
    add a, [hl]
    ld [wCB92], a
    ret

; entry 23 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCB82, wCB8A
; writes: wCB82, wCB8A, wD0A3
; points at: wD09E
Func_0E0_5AD3_Table3_Case17::
Jump_0E0_6221:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $10
    jr nc, Jump_0E0_624A
    and a, $07
    ld c, a
    ld b, $00
    ld hl, $625E
    add hl, bc
    ld a, [wCB82]
    add a, [hl]
    ld [wCB82], a
    ld a, [wCB8A]
    add a, [hl]
    ld [wCB8A], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_624A::
    call StepWD0A2Mod15
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret
    db $FD, $FE, $FF, $00, $00, $01, $02, $03

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD09E
Func_0E0_5AD3_Case02::
Jump_0E0_6266:: ; address name
    ld a, [wD09E]
    rst $00
    dw Func_0E0_5AD3_Table4_Case00
    dw Func_0E0_5AD3_Table4_Case01
    dw Func_0E0_5AD3_Table4_Case02
    dw Func_0E0_5AD3_Table4_Case03
    dw Func_0E0_5AD3_Table4_Case04
    dw Func_0E0_5AD3_Table4_Case05
    dw Func_0E0_5AD3_Table4_Case06
    dw Func_0E0_5AD3_Table4_Case07
    dw Func_0E0_5AD3_Table4_Case08
    dw Func_0E0_5AD3_Table4_Case09
    dw Func_0E0_5AD3_Table4_Case0A
    dw Func_0E0_5AD3_Table4_Case0B
    dw Func_0E0_5AD3_Table4_Case0C
    dw Func_0E0_5AD3_Table4_Case0D
    dw Func_0E0_5AD3_Table4_Case0E
    dw Func_0E0_5AD3_Table4_Case0F
    dw Func_0E0_5AD3_Table4_Case10
    dw Func_0E0_5AD3_Table4_Case11
    dw Func_0E0_5AD3_Table4_Case12
    dw Func_0E0_5AD3_Table4_Case13
    dw Func_0E0_5AD3_Table4_Case14
    dw Func_0E0_5AD3_Table4_Case15
    dw Func_0E0_5AD3_Table4_Case16
    dw Func_0E0_5AD3_Table4_Case17
    dw Func_0E0_5AD3_Table4_Case18
    dw Func_0E0_5AD3_Table4_Case19
    dw Func_0E0_5AD3_Table4_Case1A

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wD000, wC49F, wC4DF, wC4E7, wC4EF, wC4F7, wC4FF, ...
Func_0E0_5AD3_Table4_Case00::
Jump_0E0_62A0:: ; address name
    ld b, $7D
    ld de, Data_07D_4001
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_40FA
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7E
    ld de, Data_07E_48D6
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $21
    ld de, Data_021_7548
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_42BD
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_41E1
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld b, $48
    ld de, Data_048_4DDC
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $48
    ld de, Data_048_523C
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0E0_636C
    ld a, $02
    ldh [rSVBK], a
    ld b, $48
    ld de, Data_048_54BF
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $48
    ld de, Data_048_5138
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, wC4DF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, wC4E7
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B2D
    ld hl, wC4EF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $27
    ld de, Data_027_7850
    ld hl, wC4F7
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B4D
    ld hl, wC4FF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, wC507
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_0E0_636C::
    ld hl, vBGMap0
    call Func_000_1E29
    ld a, $02
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $5F
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A5
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wD09E
Func_0E0_5AD3_Table4_Case01::
Jump_0E0_6417:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $00
    ld de, $4070
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4080
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3
; writes: wD0A3, wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table4_Case02::
Jump_0E0_6439:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    srl a
    swap a
    and a, $07
    ld hl, $6490
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wD0A3]
    srl a
    swap a
    and a, $07
    ld hl, $6495
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    cp a, $9F
    ret c
    xor a, a
    ld [wD0A3], a
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, wD09E
    inc [hl]
    ret
    db $03, $02, $01, $02, $03, $01, $00, $03, $00, $01

; entry 3 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table4_Case03::
Jump_0E0_649A:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $4020
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case04::
Jump_0E0_64B0:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $4030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4020
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table4_Case0A::
Jump_0E0_64DE:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $5020
    call StepSpriteSlotToward
    ret nz
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case0B::
Jump_0E0_64F4:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $5030
    call StepSpriteSlotToward
    ld a, $05
    ld de, $5020
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 17 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCB82, wCB8A
; writes: wCB82, wCB8A, wD0A3
; points at: wD09E
Func_0E0_5AD3_Table4_Case11::
Jump_0E0_6514:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $10
    jr nc, Jump_0E0_653D
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wCB82]
    add a, [hl]
    ld [wCB82], a
    ld a, [wCB8A]
    add a, [hl]
    ld [wCB8A], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_653D::
    ld a, $05
    ld c, $00
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 22 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCBA2, wCBAA
; writes: wCBA2, wCBAA, wD0A3
; points at: wD09E
Func_0E0_5AD3_Table4_Case16::
Jump_0E0_6551:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $10
    jr nc, Jump_0E0_657A
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wCBA2]
    add a, [hl]
    ld [wCBA2], a
    ld a, [wCBAA]
    add a, [hl]
    ld [wCBAA], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_657A::
    call StepWD0A2Mod30
    ret nz
    ld a, $04
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $02
    call SetSpriteSlotByte5
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 23 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table4_Case17::
Jump_0E0_6595:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $5020
    call StepSpriteSlotToward
    ld a, $04
    call StepSpriteSlotToward
    ld a, $05
    ld de, $5010
    call StepSpriteSlotToward
    ld a, $05
    call StepSpriteSlotToward
    ret nz
    ld a, $05
    ld [wSpriteSlotCount], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 24 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table4_Case18::
Jump_0E0_65BD:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $5010
    call StepSpriteSlotToward
    ld a, $04
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 25 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: sA070, wD09E
Func_0E0_5AD3_Table4_Case19::
Jump_0E0_65F8:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, sA070
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4070
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case05::
Jump_0E0_6626:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $3030
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4030
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case06::
Jump_0E0_664D:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $3030
    call StepSpriteSlotToward
    ret nz
    ld a, $03
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case07::
Jump_0E0_666D:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $3050
    call StepSpriteSlotToward
    ld a, $03
    ld de, $3040
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case08::
Jump_0E0_668D:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $2050
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table4_Case09::
Jump_0E0_66A5:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $2040
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld a, $05
    ld [wSpriteSlotCount], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 12 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case0C::
Jump_0E0_66DB:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $6030
    call StepSpriteSlotToward
    ld a, $05
    ld de, $5030
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 13 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case0D::
Jump_0E0_6702:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $6040
    call StepSpriteSlotToward
    ld a, $05
    ld de, $6030
    call StepSpriteSlotToward
    ret nz
    ld a, $05
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case0E::
Jump_0E0_6722:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $6050
    call StepSpriteSlotToward
    ld a, $05
    ld de, $6040
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 15 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case0F::
Jump_0E0_6742:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $7050
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $02
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 16 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case10::
Jump_0E0_675A:: ; address name
    call DrawSpriteSlots
    ld a, $04
    ld de, $7040
    call StepSpriteSlotToward
    ret nz
    ld a, $04
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $03
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 26 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wD09D, wD09E
; points at: sA070
Func_0E0_5AD3_Table4_Case1A::
Jump_0E0_677D:: ; address name
    call DrawSpriteSlots
    ld a, $01
    ld de, sA070
    call StepSpriteSlotToward
    ld a, $00
    ld de, sA070
    call StepSpriteSlotToward
    ret nz
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wD09D], a
    xor a, a
    ld [wD09E], a
    ret

; entry 18 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCBAA
; writes: wCBAA, wD0A3
; points at: wD09E
Func_0E0_5AD3_Table4_Case12::
Jump_0E0_67B1:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $10
    jr nc, Jump_0E0_67D3
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wCBAA]
    add a, [hl]
    ld [wCBAA], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_67D3::
    call StepWD0A2Mod60
    ret nz
    ld a, $05
    ld c, $01
    call SetSpriteSlotByte5
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 19 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case13::
Jump_0E0_67E7:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld a, $04
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $05
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 20 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table4_Case14::
Jump_0E0_6801:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod30
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 21 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wD0A4
; writes: wD0A3, wD0A4
; points at: wD09E
Func_0E0_5AD3_Table4_Case15::
Jump_0E0_680D:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    and a, $07
    ret nz
    ld a, $04
    ld de, $7050
    call StepSpriteSlotToward
    ld a, $05
    ld de, $6050
    call StepSpriteSlotToward
    ret nz
    ld a, [wD0A4]
    inc a
    ld [wD0A4], a
    cp a, $03
    ret c
    xor a, a
    ld [wD0A3], a
    ld [wD0A4], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD09E
Func_0E0_5AD3_Case03::
Jump_0E0_6841:: ; address name
    ld a, [wD09E]
    rst $00
    dw Func_0E0_5AD3_Table5_Case00
    dw Func_0E0_5AD3_Table5_Case01
    dw Func_0E0_5AD3_Table5_Case02
    dw Func_0E0_5AD3_Table5_Case03
    dw Func_0E0_5AD3_Table5_Case04
    dw Func_0E0_5AD3_Table5_Case05
    dw Func_0E0_5AD3_Table5_Case06
    dw Func_0E0_5AD3_Table5_Case07
    dw Func_0E0_5AD3_Table5_Case08
    dw Func_0E0_5AD3_Table5_Case09
    dw Func_0E0_5AD3_Table5_Case0A

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wD000, wC49F, wC4DF, wC4E7, wC4EF, wC4F7, wC4FF, ...
Func_0E0_5AD3_Table5_Case00::
Jump_0E0_685B:: ; address name
    ld b, $7D
    ld de, Data_07D_4001
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_40FA
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_42BD
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_41E1
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_4EB6
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_4B4A
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld b, $7E
    ld de, Data_07E_52BC
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld b, $48
    ld de, Data_048_55DA
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $48
    ld de, Data_048_5C7D
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jp z, Jump_0E0_694D
    ld a, $02
    ldh [rSVBK], a
    ld b, $48
    ld de, Data_048_61F2
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $94
    ld de, Data_094_4001
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $48
    ld de, Data_048_5138
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, wC4DF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, wC4E7
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B4D
    ld hl, wC4EF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, wC4F7
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B2D
    ld hl, wC4FF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B1D
    ld hl, wC507
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4C65
    ld hl, wC50F
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_0E0_694D::
    ld hl, vBGMap0
    call Func_000_1E29
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $12
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $0E
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $15
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $06
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $60
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wD09E
Func_0E0_5AD3_Table5_Case01::
Jump_0E0_6A10:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $00
    ld de, $4050
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4060
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3
; writes: wD0A3, wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table5_Case02::
Jump_0E0_6A32:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    srl a
    swap a
    and a, $07
    ld hl, $6490
    add_a_to_hl
    ld c, [hl]
    ld a, $00
    call SetSpriteSlotByte5
    ld a, [wD0A3]
    srl a
    swap a
    and a, $07
    ld hl, $6495
    add_a_to_hl
    ld c, [hl]
    ld a, $01
    call SetSpriteSlotByte5
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    cp a, $9F
    ret c
    xor a, a
    ld [wD0A3], a
    ld a, $00
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $07
    ld [wSpriteSlotCount], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
; points at: wD09E
Func_0E0_5AD3_Table5_Case03::
Jump_0E0_6A89:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod45
    ret nz
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    ld a, $06
    ld [wSpriteSlotCount], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table5_Case04::
Jump_0E0_6AA1:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4050
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCBAA
; writes: wCBAA, wCBAC, wD0A3, wSpriteSlotCount, wCB9A
; points at: wD09E
Func_0E0_5AD3_Table5_Case05::
Jump_0E0_6ABE:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $10
    jr nc, Jump_0E0_6AED
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wCBAA]
    add a, [hl]
    ld [wCBAA], a
    ld a, [wD0A3]
    srl a
    srl a
    ld hl, $6B06
    ld [wCBAC], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_6AED::
    ld a, $05
    ld [wSpriteSlotCount], a
    ld a, [wCBAA]
    add a, [hl]
    ld [wCB9A], a
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret
    db $03, $02, $01, $00

; entry 6 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCBA2
; writes: wCBA2, wCBA4, wD0A3, wSpriteSlotCount, wCB92
; points at: wD09E
Func_0E0_5AD3_Table5_Case06::
Jump_0E0_6B0A:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $10
    jr nc, Jump_0E0_6B39
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wCBA2]
    add a, [hl]
    ld [wCBA2], a
    ld a, [wD0A3]
    srl a
    srl a
    ld hl, $6B52
    ld [wCBA4], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_6B39::
    ld a, $04
    ld [wSpriteSlotCount], a
    ld a, [wCBA2]
    add a, [hl]
    ld [wCB92], a
    call StepWD0A2Mod30
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret
    db $02, $01, $00, $03

; entry 7 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table5_Case07::
Jump_0E0_6B56:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $02
    ld de, $5040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5030
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $02
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table5_Case08::
Jump_0E0_6B99:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $50A0
    call StepSpriteSlotToward
    ld a, $03
    ld de, $50A0
    call StepSpriteSlotToward
    ret nz
    ld a, $00
    ld c, $00
    call SetSpriteSlotByte5
    ld a, $01
    ld c, $02
    call SetSpriteSlotByte5
    call StepWD0A2Mod30
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table5_Case09::
Jump_0E0_6BC4:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $40A0
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $00
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 10 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wD09D, wD09E
Func_0E0_5AD3_Table5_Case0A::
Jump_0E0_6BE4:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, $40A0
    call StepSpriteSlotToward
    ld a, $01
    ld de, $40B0
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wD09D], a
    xor a, a
    ld [wD09E], a
    ret

; entry 4 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD09E
Func_0E0_5AD3_Case04::
Jump_0E0_6C0A:: ; address name
    ld a, [wD09E]
    rst $00
    dw Func_0E0_5AD3_Table6_Case00
    dw Func_0E0_5AD3_Table6_Case01
    dw Func_0E0_5AD3_Table6_Case02
    dw Func_0E0_5AD3_Table6_Case03
    dw Func_0E0_5AD3_Table6_Case04
    dw Func_0E0_5AD3_Table6_Case05
    dw Func_0E0_5AD3_Table6_Case06
    dw Func_0E0_5AD3_Table6_Case07
    dw Func_0E0_5AD3_Table6_Case08
    dw Func_0E0_5AD3_Table6_Case09
    dw Func_0E0_5AD3_Table6_Case0A
    dw Func_0E0_5AD3_Table6_Case0B
    dw Func_0E0_5AD3_Table6_Case0C
    dw Func_0E0_5AD3_Table6_Case0D
    dw Func_0E0_5AD3_Table6_Case0E

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rSVBK, wSpriteSlotCount
; points at: wScreenTileBuffer, wD000, wC49F, wC4DF, wC4E7, wC4EF, wC4F7, wSpriteSlots, ...
Func_0E0_5AD3_Table6_Case00::
Jump_0E0_6C2C:: ; address name
    ld b, $7D
    ld de, Data_07D_4001
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_40FA
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_42BD
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld b, $7D
    ld de, Data_07D_41E1
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    ld b, $49
    ld de, Data_049_4C1B
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $49
    ld de, Data_049_531F
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0E0_6CC8
    ld a, $02
    ldh [rSVBK], a
    ld b, $49
    ld de, Data_049_572D
    ld hl, wD000
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $49
    ld de, Data_049_52BB
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BA5
    ld hl, wC4DF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4BAD
    ld hl, wC4E7
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B4D
    ld hl, wC4EF
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7E
    ld de, Data_07E_4B45
    ld hl, wC4F7
    ld c, $08
    call CopyFromBankWaitVRAM

Jump_0E0_6CC8::
    ld hl, vBGMap0
    call Func_000_1E29
    ld a, $04
    ld [wSpriteSlotCount], a
    ld hl, wSpriteSlots
    ld a, $01
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $A0
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $B0
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $10
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $20
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $50
    ld [hl+], a
    ld a, $40
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $30
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    call Func_0E0_75BF
    ld a, $FC
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wD09E
Func_0E0_5AD3_Table6_Case01::
Jump_0E0_6D43:: ; address name
    call DrawSpriteSlots
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $00
    ld de, vTiles0 + $40
    call StepSpriteSlotToward
    ld a, $01
    ld de, vTiles2 + $40
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
    ret nz
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wD0A4
; writes: wD0A3, wD0A4
; points at: wD09E
Func_0E0_5AD3_Table6_Case02::
Jump_0E0_6D73:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    and a, $03
    ret nz
    ld a, $00
    ld de, $7040
    call StepSpriteSlotToward
    ld a, $01
    ld de, vTiles0 + $40
    call StepSpriteSlotToward
    ret nz
    ld a, [wD0A4]
    inc a
    ld [wD0A4], a
    cp a, $07
    ret c
    xor a, a
    ld [wD0A3], a
    ld [wD0A4], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wD0A4
; writes: wD0A3, wD0A4
; points at: wD09E
Func_0E0_5AD3_Table6_Case03::
Jump_0E0_6DA7:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    and a, $03
    ret nz
    ld a, $02
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld a, [wD0A4]
    inc a
    ld [wD0A4], a
    cp a, $07
    ret c
    cp a, $0F
    jr c, Jump_0E0_6DDF
    xor a, a
    ld [wD0A3], a
    ld [wD0A4], a
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_6DDF::
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    ret

; entry 9 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCB92, wCB9A
; writes: wCB92, wCB9A, wD0A3
; points at: wD09E
Func_0E0_5AD3_Table6_Case09::
Jump_0E0_6DEE:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $20
    jr nc, Jump_0E0_6E12
    and a, $1F
    ld c, a
    ld b, $00
    ld hl, $6E83
    add hl, bc
    ld a, [wCB92]
    add a, [hl]
    ld [wCB92], a
    ld e, a
    ld d, $10
    ld a, $02
    call StepSpriteSlotToward
    jr Jump_0E0_6E29

Jump_0E0_6E12::
    ld a, $02
    ld de, $10A0
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward
    ld a, $02
    call StepSpriteSlotToward

Jump_0E0_6E29::
    ld a, [wD0A3]
    sub a, $10
    jr c, Jump_0E0_6E4E
    cp a, $20
    jr nc, Jump_0E0_6E5E
    and a, $1F
    ld c, a
    ld b, $00
    ld hl, $6E83
    add hl, bc
    ld a, [wCB9A]
    add a, [hl]
    ld [wCB9A], a
    ld e, a
    ld d, $10
    ld a, $03
    call StepSpriteSlotToward
    jr Jump_0E0_6E56

Jump_0E0_6E4E::
    ld a, $03
    ld de, $3040
    call StepSpriteSlotToward

Jump_0E0_6E56::
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_6E5E::
    ld a, $03
    ld de, $10A0
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ld a, $03
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod30
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret
    db $FD, $FD, $FD, $FD, $FE, $FE, $FE, $FE, $FF, $FF, $FF, $FF, $00, $00, $00, $00
    db $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03

; entry 10 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3, wCB82, wCB8A
; writes: wCB82, wCB8A, wD0A3
; points at: wD09E
Func_0E0_5AD3_Table6_Case0A::
Jump_0E0_6EA3:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    cp a, $10
    jr nc, Jump_0E0_6ECC
    and a, $0F
    ld c, a
    ld b, $00
    ld hl, $6038
    add hl, bc
    ld a, [wCB82]
    add a, [hl]
    ld [wCB82], a
    ld a, [wCB8A]
    add a, [hl]
    ld [wCB8A], a
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    ret

Jump_0E0_6ECC::
    cp a, $20
    push af
    inc a
    ld [wD0A3], a
    pop af
    ret c
    ld a, $00
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 11 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table6_Case0B::
Jump_0E0_6EEF:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 13 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: sA040, wD09E
Func_0E0_5AD3_Table6_Case0D::
Jump_0E0_6EFB:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, sA040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld a, $01
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 14 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; writes: wD09D, wD09E
; points at: sA040
Func_0E0_5AD3_Table6_Case0E::
Jump_0E0_6F1B:: ; address name
    call DrawSpriteSlots
    ld a, $00
    ld de, sA040
    call StepSpriteSlotToward
    ld a, $01
    ld de, sA040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wD09D], a
    xor a, a
    ld [wD09E], a
    ret

; entry 5 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table6_Case05::
Jump_0E0_6F41:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld a, $02
    ld c, $03
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $03
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 12 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3
; writes: wD0A3
; points at: wD09E
Func_0E0_5AD3_Table6_Case0C::
Jump_0E0_6F5B:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    and a, $03
    ret nz
    ld a, $00
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $01
    ld de, $5040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wD0A3], a
    ld a, $00
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table6_Case04::
Jump_0E0_6F8D:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld a, $02
    ld c, $01
    call SetSpriteSlotByte5
    ld a, $03
    ld c, $01
    call SetSpriteSlotByte5
    ld hl, wD09E
    inc [hl]
    ret

; entry 6 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table6_Case06::
Jump_0E0_6FA7:: ; address name
    call DrawSpriteSlots
    call StepWD0A2Mod60
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

; entry 7 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A3
; writes: wD0A3
; points at: wD09E
Func_0E0_5AD3_Table6_Case07::
Jump_0E0_6FB3:: ; address name
    call DrawSpriteSlots
    ld a, [wD0A3]
    inc a
    ld [wD0A3], a
    and a, $03
    ret nz
    ld a, $02
    ld de, $4040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $5040
    call StepSpriteSlotToward
    ret nz
    call StepWD0A2Mod15
    ret nz
    xor a, a
    ld [wD0A3], a
    ld hl, wD09E
    inc [hl]
    ret

; entry 8 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; points at: wD09E
Func_0E0_5AD3_Table6_Case08::
Jump_0E0_6FDE:: ; address name
    call DrawSpriteSlots
    ld a, $02
    ld de, $3040
    call StepSpriteSlotToward
    ld a, $03
    ld de, $4040
    call StepSpriteSlotToward
    ret nz
    ld hl, wD09E
    inc [hl]
    ret

Jump_0E0_6FF7::
    ld a, [wD09F]
    or a, a
    jr z, Jump_0E0_7007
    ld a, [wD09E]
    rst $00
    dw Func_0E0_5AD3_Table7_Case00
    dw Func_0E0_5AD3_Table7_Case01
    dw Func_0E0_5AD3_Table7_Case02

Jump_0E0_7007::
    ld a, [wD09E]
    rst $00
    dw Func_0E0_5AD3_Table8_Case00
    dw Func_0E0_5AD3_Table8_Case01
    dw Func_0E0_5AD3_Table8_Case02

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A1, wD09F, wD0A5, wD0A6, wD0A7, wD0A9, wD0AA, wIsCGB, ...
; writes: wD0A1, wD0A5, wD0A6, wD0AD, wD0AE, wD0A9, wD0AA, wD0A7, ...
; points at: wD09E, wD0A8
Func_0E0_5AD3_Table7_Case00::
Jump_0E0_7011:: ; address name
    ld a, [wD0A1]
    or a, a
    jr nz, Jump_0E0_7036
    ld hl, vTiles2 + $7F0
    ld de, $0101
    call FillTilesRequest
    ld a, [wD09F]
    dec a
    ld hl, $7649
    call Func_000_0B0D
    ld a, [hl+]
    ld [wD0A1], a
    ld a, l
    ld [wD0A5], a
    ld a, h
    ld [wD0A6], a

Jump_0E0_7036::
    ld a, [wD0A5]
    ld l, a
    ld a, [wD0A6]
    ld h, a
    ld a, [hl+]
    cp a, $FE
    jp nz, Jump_0E0_719F
    ld a, l
    ld [wD0AD], a
    ld a, h
    ld [wD0AE], a
    ld bc, vTiles1
    ld a, c
    ld [wD0A9], a
    ld a, b
    ld [wD0AA], a
    xor a, a
    ld [wD0A7], a

Jump_0E0_705B::
    ld a, [hl+]
    ld c, a
    cp a, $FF
    jp z, Jump_0E0_70EB
    ld a, [wD0A7]
    add a, c
    ld [wD0A7], a
    ld a, c
    or a, a
    jr nz, Jump_0E0_7070
    inc hl
    jr Jump_0E0_70A5

Jump_0E0_7070::
    push hl
    ld a, [wD0A9]
    ld l, a
    ld a, [wD0AA]
    ld h, a
    ld de, $1202
    call FillTilesRequest
    ld a, [wD0A9]
    ld l, a
    ld a, [wD0AA]
    ld h, a
    ld de, $0240
    add hl, de
    ld a, l
    ld [wD0A9], a
    ld a, h
    ld [wD0AA], a
    pop hl
    xor a, a
    ld [wStringCategory], a
    ld a, [hl+]
    ld [wStringIndex], a
    cp a, $FF
    jr z, Jump_0E0_70A5
    push hl
    call ShowString_BankE0
    pop hl

Jump_0E0_70A5::
    ld a, [hl+]
    ld c, a
    ld a, [wD0A7]
    add a, c
    ld a, a
    ld [wD0A7], a
    ld a, c
    or a, a
    jr nz, Jump_0E0_70B6
    inc hl
    jr Jump_0E0_705B

Jump_0E0_70B6::
    push hl
    ld a, [wD0A9]
    ld l, a
    ld a, [wD0AA]
    ld h, a
    ld de, $1201
    call FillTilesRequest
    ld a, [wD0A9]
    ld l, a
    ld a, [wD0AA]
    ld h, a
    ld de, $0120
    add hl, de
    ld a, l
    ld [wD0A9], a
    ld a, h
    ld [wD0AA], a
    pop hl
    ld a, $01
    ld [wStringCategory], a
    ld a, [hl+]
    ld [wStringIndex], a
    push hl
    call ShowString_BankE0
    pop hl
    jp Jump_0E0_705B

Jump_0E0_70EB::
    ld a, l
    ld [wD0A5], a
    ld a, h
    ld [wD0A6], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0E0_710C
    ld a, $01
    ldh [rVBK], a
    ld a, $00
    ld hl, vBGMap0
    ld bc, $1412
    call Func_0E0_758B
    ld a, $00
    ldh [rVBK], a

Jump_0E0_710C::
    ld a, $7F
    ld hl, vBGMap0
    ld bc, $1412
    call Func_0E0_758B
    ld bc, vBGMap0 + $41
    ld a, c
    ld [wD0AB], a
    ld a, b
    ld [wD0AC], a
    ld bc, $0080
    ld a, c
    ld [wD0A9], a
    ld a, b
    ld [wD0AA], a

Jump_0E0_712D::
    ld a, [wD0AD]
    ld l, a
    ld a, [wD0AE]
    ld h, a
    ld a, [hl]
    cp a, $FF
    jp z, Jump_0E0_7259
    ld a, [wD0AB]
    ld l, a
    ld a, [wD0AC]
    ld h, a
    ld a, [wD0A9]
    ld b, a
    add a, $24
    ld [wD0A9], a
    ld a, b
    ld b, $12
    ld c, $02
    ld de, $0020
    call Func_0E0_740E
    ld a, l
    and a, $E0
    add a, $01
    ld l, a
    push hl
    ld a, [wD0AD]
    ld l, a
    ld a, [wD0AE]
    ld h, a
    ld a, [hl+]
    cp a, $01
    ld a, [hl+]
    ld a, [hl+]
    ld a, [hl+]
    ld a, l
    ld [wD0AD], a
    ld a, h
    ld [wD0AE], a
    pop hl
    jr z, Jump_0E0_717B
    ld de, $0020
    add hl, de

Jump_0E0_717B::
    ld a, [wD0A9]
    ld b, a
    add a, $12
    ld [wD0A9], a
    ld a, b
    ld de, $0040
    ld b, $12
    ld c, $01
    call Func_0E0_740E
    ld a, l
    and a, $E0
    add a, $01
    ld l, a
    ld a, l
    ld [wD0AB], a
    ld a, h
    ld [wD0AC], a
    jr Jump_0E0_712D

Jump_0E0_719F::
    ld [wD0A7], a
    or a, a
    jr nz, Jump_0E0_71A8
    inc hl
    jr Jump_0E0_71C4

Jump_0E0_71A8::
    push hl
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    pop hl
    xor a, a
    ld [wStringCategory], a
    ld a, [hl+]
    ld [wStringIndex], a
    cp a, $FF
    jr z, Jump_0E0_71C4
    push hl
    call ShowString_BankE0
    pop hl

Jump_0E0_71C4::
    ld a, [hl+]
    ld [wD0A8], a
    or a, a
    jr nz, Jump_0E0_71CE
    inc hl
    jr Jump_0E0_71E7

Jump_0E0_71CE::
    push hl
    ld hl, vTiles1 + $240
    ld de, $1206
    call FillTilesRequest
    pop hl
    ld a, $01
    ld [wStringCategory], a
    ld a, [hl+]
    ld [wStringIndex], a
    push hl
    call ShowString_BankE0
    pop hl

Jump_0E0_71E7::
    ld a, l
    ld [wD0A5], a
    ld a, h
    ld [wD0A6], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0E0_7208
    ld a, $01
    ldh [rVBK], a
    ld a, $00
    ld hl, vBGMap0
    ld bc, $1412
    call Func_0E0_758B
    ld a, $00
    ldh [rVBK], a

Jump_0E0_7208::
    ld a, $7F
    ld hl, vBGMap0
    ld bc, $1412
    call Func_0E0_758B
    ld hl, wD0A8
    ld a, [hl-]
    add a, a
    add a, [hl]
    ld b, a
    ld a, $12
    sub a, b
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, vBGMap0
    add hl, de
    ld de, $0001
    add hl, de
    ld de, $0020
    ld b, $12
    ld a, [wD0A7]
    ld c, a
    or a, a
    jr z, Jump_0E0_7240
    ld a, $80
    call Func_0E0_740E

Jump_0E0_7240::
    ld a, l
    and a, $E0
    ld l, a
    ld de, $0041
    add hl, de
    ld de, $0040
    ld b, $12
    ld a, [wD0A8]
    ld c, a
    or a, a
    jr z, Jump_0E0_7259
    ld a, $A4
    call Func_0E0_740E

Jump_0E0_7259::
    ld hl, wD09E
    inc [hl]
    ld a, [wSGBActive]
    or a, a
    ld hl, $01A4
    jr z, Jump_0E0_7269
    ld hl, $012C

Jump_0E0_7269::
    ld a, [wD0A5]
    ld e, a
    ld a, [wD0A6]
    ld d, a
    dec de
    dec de
    dec de
    ld a, [de]
    cp a, $00
    jr z, Jump_0E0_72AC
    cp a, $05
    jr z, Jump_0E0_72AC
    cp a, $0F
    jr z, Jump_0E0_72AC
    cp a, $13
    jr z, Jump_0E0_72AC
    cp a, $14
    jr z, Jump_0E0_72AC
    cp a, $15
    jr z, Jump_0E0_72AC
    cp a, $16
    jr z, Jump_0E0_72AC
    cp a, $17
    jr z, Jump_0E0_72AC
    cp a, $18
    jr z, Jump_0E0_72AC
    cp a, $19
    jr z, Jump_0E0_72AC
    cp a, $1A
    jr z, Jump_0E0_72AC
    cp a, $1B
    cp a, $20
    jr c, Jump_0E0_72AF
    ld hl, $FFFF
    jr Jump_0E0_72AF

Jump_0E0_72AC::
    ld hl, $012C

Jump_0E0_72AF::
    ld a, l
    ld [wD0A2], a
    ld a, h
    ld [wD0A3], a
    call Func_0E0_75BF
    ld a, $FC
    call StartPaletteFade
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A2, wD0A3, wDC40, wC6FD
; writes: wD0A2, wD0A3, hMapId, hMapScreenX, hMapScreenY, hPlayerX, wC8F0, hPlayerY, ...
; points at: wD0A2, wD09E, wDC41, wDC60, wDC80, wModeChangeRequest
Func_0E0_5AD3_Table7_Case01::
Jump_0E0_72C0:: ; address name
    ld hl, wD0A2
    ld a, [hl+]
    and a, [hl]
    cp a, $FF
    jr z, Jump_0E0_72DB
    ld a, [wD0A2]
    sub a, $01
    ld [wD0A2], a
    ld a, [wD0A3]
    sbc a, $00
    ld [wD0A3], a
    jr Jump_0E0_732E

Jump_0E0_72DB::
    ld a, [wDC40]
    ld hl, wDC41
    and a, [hl]
    ld hl, wDC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, $10
    call StartPaletteFade
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $B0
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld a, $40
    ldh [hPlayerY], a
    ld [wC8F1], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, [wC6FD]
    ld [wC933], a
    ld de, $019F
    call SetFlagBit
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

Jump_0E0_732E::
    ld hl, wD0A2
    ld a, [hl+]
    or a, [hl]
    ret nz
    ld a, $04
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wD0A1
; writes: wD0A1, wD09E
; points at: wD09F, wD09D
Func_0E0_5AD3_Table7_Case02::
Jump_0E0_733E:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wD0A1]
    dec a
    ld [wD0A1], a
    jr z, Jump_0E0_7351
    xor a, a
    ld [wD09E], a
    ret

Jump_0E0_7351::
    ld hl, wD09F
    inc [hl]
    ld hl, wD09D
    inc [hl]
    xor a, a
    ld [wD09E], a
    ret

; entry 0 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wSGBActive
; writes: wStringCategory, wStringIndex, rVBK, wD0A2, wD0A3
; points at: wC49F, wD09E
Func_0E0_5AD3_Table8_Case00::
Jump_0E0_735E:: ; address name
    ld hl, vTiles2 + $7F0
    ld de, $0101
    call FillTilesRequest
    ld hl, vTiles1
    ld de, $0E02
    call FillTilesRequest
    ld a, $02
    ld [wStringCategory], a
    xor a, a
    ld [wStringIndex], a
    call ShowString_BankE0
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_0E0_73A2
    ld b, $48
    ld de, Data_048_4001
    ld hl, wC49F
    ld c, $08
    call CopyFromBankWaitVRAM
    ld a, $01
    ldh [rVBK], a
    ld a, $00
    ld hl, vBGMap0
    ld bc, $1412
    call Func_0E0_758B
    ld a, $00
    ldh [rVBK], a

Jump_0E0_73A2::
    ld a, $7F
    ld hl, vBGMap0
    ld bc, $1412
    call Func_0E0_758B
    ld a, $80
    ld hl, vBGMap0 + $E3
    ld de, $0040
    ld bc, $0E02
    call Func_0E0_740E
    ld a, [wSGBActive]
    or a, a
    ld hl, $0168
    jr z, Jump_0E0_73C7
    ld hl, $00F0

Jump_0E0_73C7::
    ld a, l
    ld [wD0A2], a
    ld a, h
    ld [wD0A3], a
    call Func_0E0_75BF
    ld a, $FC
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wD0A2, wD0A3
; writes: wD0A2, wD0A3
; points at: wD0A2, wD09E
Func_0E0_5AD3_Table8_Case01::
Jump_0E0_73DC:: ; address name
    ld a, [wD0A2]
    sub a, $01
    ld [wD0A2], a
    ld a, [wD0A3]
    sbc a, $00
    ld [wD0A3], a
    ld hl, wD0A2
    ld a, [hl+]
    or a, [hl]
    ret nz
    ld a, $04
    call StartPaletteFade
    ld hl, wD09E
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_0E0_5AD3
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wD09E
; points at: wD09F, wD09D
Func_0E0_5AD3_Table8_Case02::
Jump_0E0_73FC:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wD09F
    inc [hl]
    ld hl, wD09D
    inc [hl]
    xor a, a
    ld [wD09E], a
    ret

; 5 call sites from 2 routines (e.g. Func_0E0_5AD3_Table8_Case00, Func_0E0_5AD3_Table7_Case00)
Func_0E0_740E::
    push bc
    push hl

Jump_0E0_7410::
    di
    call WriteVRAMByteInc
    ei
    inc a
    dec b
    jr nz, Jump_0E0_7410
    pop hl
    pop bc
    add hl, de
    dec c
    jr nz, Func_0E0_740E
    ret

; for each of the wSpriteSlotCount 8-byte slots at wSpriteSlots: loads hSpriteSetIndex, hSpriteOriginX (+8), hSpriteOriginY, hSpriteAttrXor, hSpriteTileOffset and hSpriteSubIndex from the slot, then far-calls the routine chosen by the slot's first byte from the 3-byte entries at $7477
; 80 call sites from 80 routines (e.g. Func_0E0_5AD3_Table2_Case0F, Func_0E0_5AD3_Table2_Case0E, Func_0E0_5AD3_Table2_Case0D, Func_0E0_5AD3_Table2_Case0C, ...)
; reads: wSpriteSlotCount, hSpriteAttrXor
; writes: hSpriteSetIndex, hSpriteOriginX, hSpriteOriginY, hSpriteAttrXor, hSpriteTileOffset, hSpriteSubIndex
; points at: wSpriteSlots
DrawSpriteSlots::
Func_0E0_7420:: ; address name
    ld a, [wSpriteSlotCount]
    or a, a
    ret z
    ld b, a
    ld hl, wSpriteSlots

Jump_0E0_7429::
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    ldh [hSpriteSetIndex], a
    ld a, [hl+]
    add a, $08
    ldh [hSpriteOriginX], a
    ld a, [hl+]
    ldh [hSpriteOriginY], a
    ld a, [hl+]
    ldh [hSpriteAttrXor], a
    ld a, [hl+]
    ld b, a
    ld a, [hl+]
    ldh [hSpriteTileOffset], a
    ld a, [hl+]
    ld e, a
    ld a, c
    cp a, $02
    ld a, b
    jr z, Jump_0E0_745E
    ld a, e
    and a, $20
    srl a
    swap a
    ld e, a
    ld a, b
    cp a, $03
    jr nz, Jump_0E0_745C
    ldh a, [hSpriteAttrXor]
    or a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

Jump_0E0_745C::
    add a, a
    add a, e

Jump_0E0_745E::
    ldh [hSpriteSubIndex], a
    ld b, $00
    push hl
    ld hl, $7477
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    ld l, e
    ld h, d
    rst $10
    pop hl
    pop bc
    dec b
    jr nz, Jump_0E0_7429
    ret
    db $01, $40, $25, $01, $40, $7F, $0A, $70, $7F

; adds 1 to byte 7 of each of the 8 slots at wSpriteSlots
; 1 call site from 1 routine (e.g. DebugStaffRoll_Update_Sub01)
; points at: wSpriteSlots
IncrementSpriteSlotCounters::
Func_0E0_7480:: ; address name
    ld b, $08
    ld hl, wSpriteSlots

Jump_0E0_7485::
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc [hl]
    inc hl
    dec b
    jr nz, Jump_0E0_7485
    ret

; A = slot number, D = target X, E = target Y: moves the slot's X and Y bytes one step toward the target and adds 1 to its byte 7; returns A = 1 (non-zero) if either moved
; 116 call sites from 58 routines (e.g. Func_0E0_5AD3_Table2_Case0F, Func_0E0_5AD3_Table2_Case0D, Func_0E0_5AD3_Table2_Case0C, Func_0E0_5AD3_Table2_Case0B, ...)
; points at: wSpriteSlots
StepSpriteSlotToward::
Func_0E0_7492:: ; address name
    ld c, $00
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, d
    jr z, Jump_0E0_74AF
    jr c, Jump_0E0_74AB
    dec a
    jr Jump_0E0_74AC

Jump_0E0_74AB::
    inc a

Jump_0E0_74AC::
    ld [hl], a
    ld c, $01

Jump_0E0_74AF::
    inc hl
    ld a, [hl]
    cp a, e
    jr z, Jump_0E0_74BD
    jr c, Jump_0E0_74B9
    dec a
    jr Jump_0E0_74BA

Jump_0E0_74B9::
    inc a

Jump_0E0_74BA::
    ld [hl], a
    ld c, $01

Jump_0E0_74BD::
    inc hl
    inc hl
    inc hl
    inc hl
    inc [hl]
    ld a, c
    or a, a
    ret

; A = slot number: byte 5 of the slot = C
; 91 call sites from 45 routines (e.g. Func_0E0_5AD3_Table2_Case0E, Func_0E0_5AD3_Table2_Case0D, Func_0E0_5AD3_Table2_Case0C, Func_0E0_5AD3_Table2_Case0B, ...)
; points at: wSpriteSlots
SetSpriteSlotByte5::
Func_0E0_74C5:: ; address name
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld [hl], c
    ret

; 1 call site from 1 routine (e.g. Func_0E0_5AD3_Table2_Case06)
; reads: wD0A7
; writes: wD0A7
; points at: wSpriteSlots
Func_0E0_74D8::
    ld c, $00
    swap a
    srl a
    ld hl, wSpriteSlots
    add_a_to_hl
    inc hl
    inc hl
    ld a, [hl]
    ld b, a
    cp a, d
    jr z, Jump_0E0_7513
    jr c, Jump_0E0_7501
    push hl
    ld a, [wD0A7]
    ld hl, $7535
    add_a_to_hl
    ld a, b
    sub a, [hl]
    pop hl
    ld [hl], a
    jr Jump_0E0_7511

Jump_0E0_7501::
    push hl
    ld a, [wD0A7]
    ld hl, $7535
    add_a_to_hl
    ld a, b
    add a, [hl]
    pop hl
    ld [hl], a

Jump_0E0_7511::
    ld c, $01

Jump_0E0_7513::
    inc hl
    ld a, [hl]
    cp a, e
    jr z, Jump_0E0_7532
    ld b, a
    push hl
    ld a, [wD0A7]
    ld hl, $7542
    add_a_to_hl
    ld a, b
    sub a, [hl]
    pop hl
    ld [hl], a
    ld a, [wD0A7]
    inc a
    ld [wD0A7], a
    ld c, $01

Jump_0E0_7532::
    ld a, c
    or a, a
    ret
    db $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $00, $02, $02, $02
    db $02, $01, $01, $01, $01, $01, $01, $01, $01, $00

; wD0A2 += 1, reset to 0 when it reaches 15
; 31 call sites from 31 routines (e.g. Func_0E0_5AD3_Table2_Case0F, Func_0E0_5AD3_Table2_Case0E, Func_0E0_5AD3_Table2_Case0D, Func_0E0_5AD3_Table2_Case0B, ...)
; reads: wD0A2
; writes: wD0A2
StepWD0A2Mod15::
Func_0E0_754F:: ; address name
    ld a, [wD0A2]
    inc a
    ld [wD0A2], a
    cp a, $0F
    ret c
    xor a, a
    ld [wD0A2], a
    ret

; wD0A2 += 1, reset to 0 when it reaches 30
; 8 call sites from 8 routines (e.g. Func_0E0_5AD3_Table3_Case05, Func_0E0_5AD3_Table4_Case16, Func_0E0_5AD3_Table4_Case14, Func_0E0_5AD3_Table5_Case08, ...)
; reads: wD0A2
; writes: wD0A2
StepWD0A2Mod30::
Func_0E0_755E:: ; address name
    ld a, [wD0A2]
    inc a
    ld [wD0A2], a
    cp a, $1E
    ret c
    xor a, a
    ld [wD0A2], a
    ret

; wD0A2 += 1, reset to 0 when it reaches 45
; 1 call site from 1 routine (e.g. Func_0E0_5AD3_Table5_Case03)
; reads: wD0A2
; writes: wD0A2
StepWD0A2Mod45::
Func_0E0_756D:: ; address name
    ld a, [wD0A2]
    inc a
    ld [wD0A2], a
    cp a, $2D
    ret c
    xor a, a
    ld [wD0A2], a
    ret

; wD0A2 += 1, reset to 0 when it reaches 60
; 6 call sites from 6 routines (e.g. Func_0E0_5AD3_Table4_Case13, Func_0E0_5AD3_Table4_Case12, Func_0E0_5AD3_Table6_Case0B, Func_0E0_5AD3_Table6_Case06, ...)
; reads: wD0A2
; writes: wD0A2
StepWD0A2Mod60::
Func_0E0_757C:: ; address name
    ld a, [wD0A2]
    inc a
    ld [wD0A2], a
    cp a, $3C
    ret c
    xor a, a
    ld [wD0A2], a
    ret

; 6 call sites from 2 routines (e.g. Func_0E0_5AD3_Table8_Case00, Func_0E0_5AD3_Table7_Case00)
Func_0E0_758B::
    push bc
    push hl

Jump_0E0_758D::
    di
    push af
    call WaitForVRAMAccess
    pop af
    ld [hl], a
    ei
    push af
    ld a, l
    push af
    inc l
    ld a, l
    and a, $1F
    ld l, a
    pop af
    and a, $E0
    or a, l
    ld l, a
    pop af
    dec b
    jr nz, Jump_0E0_758D
    pop hl
    push af
    ld a, h
    and a, $9C
    ld c, a
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $03
    or a, c
    ld h, a
    pop af
    pop bc
    dec c
    jr nz, Func_0E0_758B
    ret

; 7 call sites from 7 routines (e.g. Func_0E0_5AD3_Table8_Case00, Func_0E0_5AD3_Table7_Case00, Func_0E0_5AD3_Table2_Case00, Func_0E0_5AD3_Table3_Case00, ...)
; reads: wC5E9, wC5EA, wC5EB, wSGBActive, wC51F, wC520
; writes: rBGP, rOBP0, rOBP1, wC577, wC578, wC579, wC57A, wC57B, ...
; points at: wC5E9, wD040, wC4FF
Func_0E0_75BF::
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
    call Func_000_0DCA
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_0E0_7640
    xor a, a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, [wC51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wC577], a
    ld a, h
    ld [wC578], a
    inc hl
    ld a, l
    ld [wC579], a
    ld a, h
    ld [wC57A], a
    inc hl
    ld a, l
    ld [wC57B], a
    ld a, h
    ld [wC57C], a
    inc hl
    ld a, l
    ld [wC57D], a
    ld a, h
    ld [wC57E], a
    ld a, $B1
    ld [wSGBPacketBuffer], a
    ld a, [wC520]
    ld [wC480], a
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall Func_017_421A
    ld hl, $7641
    ld de, wC4FF
    ld bc, $0008
    call CopyBytes

Jump_0E0_7640::
    ret
    INCBIN "dwm2-cobi-us.gbc", $383641, $9F

; if wC528 < 1, BeginStringDisplay with DE = $76FC; otherwise far-calls Func_0A2_49E2
; 1 call site from 1 routine (e.g. ShowString_BankE0)
; reads: wStringCategory
BeginStringDisplay_BankE0::
Func_0E0_76E0:: ; address name
    ld a, [wStringCategory]
    cp a, $01
    jr c, Jump_0E0_76EE
    ld hl, BeginStringDisplay_BankE0_Sub01
    ld b, $A2

Jump_0E0_76EC::
    rst $10
    ret

Jump_0E0_76EE::
    ld de, $76FC
    call BeginStringDisplay
    ret

; Func_0E0_76E0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 5 call sites from 2 routines (e.g. Func_0E0_5AD3_Table8_Case00, Func_0E0_5AD3_Table7_Case00)
ShowString_BankE0::
Func_0E0_76F5:: ; address name
    call BeginStringDisplay_BankE0
    call RunStringDisplayToEnd
    ret
    db $FE, $76
    dw Func_0E0_7740
    dw Func_0E0_7753
    dw Func_0E0_7776
    dw Func_0E0_7795
    dw Func_0E0_77A6
    dw Func_0E0_77C6
    dw Func_0E0_77D9
    dw Func_0E0_77F9
    dw Func_0E0_780B
    dw Func_0E0_7828
    db $39, $78, $49, $78
    dw Func_0E0_7861
    dw Func_0E0_787B
    dw Func_0E0_788B
    dw Func_0E0_789A
    dw Func_0E0_78AC
    dw Func_0E0_78BA
    dw Func_0E0_78CD
    dw Func_0E0_78E0
    dw Func_0E0_78F0
    dw Func_0E0_7900
    dw Func_0E0_7910
    dw Func_0E0_7920
    dw Func_0E0_7930
    dw Func_0E0_7940
    dw Func_0E0_7950
    dw Func_0E0_7960
    dw Func_0E0_797E
    dw Func_0E0_798C
    dw Func_0E0_79AA
    dw $79B9
    dw Func_0E0_79BA

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7740:: ; heuristic: target of a pointer table; C0
    ld c, $21
    ld c, $0C
    ld e, $1D
    ld [de], a
    rra
    ld c, $90
    dec c
    ld [de], a
    dec de
    ld c, $0C
    dec e
    jr Jump_0E0_776D
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7753:: ; heuristic: target of a pointer table; C0
    inc e
    inc c
    ld c, $17
    ld a, [bc]
    dec de
    ld [de], a
    jr Jump_0E0_76EC
    db $B6, $90, $10, $0A, $16, $0E, $F1, $90, $90, $90, $90, $90, $90, $90, $90, $90
    db $0D

Jump_0E0_776D::
    ld c, $1C
    ld [de], a
    db $10, $17 ; stop
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7776:: ; heuristic: target of a pointer table; C0
    inc c
    ld de, $1B0A
    ld a, [bc]
    inc c
    dec e
    ld c, $1B
    sub a, b
    or a, [hl]
    pop af
    sub a, b
    sub a, b
    ld d, $18
    rla
    inc e
    dec e
    ld c, $1B
    sub a, b
    dec c
    ld c, $1C
    ld [de], a
    db $10, $17 ; stop
    ld c, $1B
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7795:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    ld d, $1E
    inc e
    ld [de], a
    inc c
    sub a, b
    inc c
    jr Jump_0E0_77B6
    db $19, $18, $1C, $0E, $1B, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_77A6:: ; heuristic: target of a pointer table; C0
    dec d
    jr Jump_0E0_77B5

; no direct call (reached through a table, a jump or a vector)
Func_0E0_77A9:: ; heuristic: follows a terminator; C0
    ld a, [bc]
    dec d
    ld [de], a
    inc hl
    ld a, [bc]
    dec e
    ld [de], a
    jr Jump_0E0_77C9
    db $F1, $90, $90

Jump_0E0_77B5::
    sub a, b

Jump_0E0_77B6::
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    inc e
    add hl, de
    ld c, $0C
    ld [de], a
    ld a, [bc]
    dec d
    ld [de], a
    inc e
    dec e
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_77C6:: ; heuristic: target of a pointer table; C0
    sub a, b
    ld c, $17

Jump_0E0_77C9::
    ld [de], a
    ld hl, $0A90
    ld d, $0E
    dec de
    ld [de], a
    inc c
    ld a, [bc]
    sub a, b
    ld [de], a
    rla
    inc c
    or a, l
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_77D9:: ; heuristic: target of a pointer table; C0
    dec d
    jr Jump_0E0_77E8

; no direct call (reached through a table, a jump or a vector)
Func_0E0_77DC:: ; heuristic: follows a terminator; C0
    ld a, [bc]
    dec d
    ld [de], a
    inc hl
    ld a, [bc]
    dec e
    ld [de], a
    jr Jump_0E0_77FC
    db $F1, $90, $90

Jump_0E0_77E8::
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld d, $0A
    rla
    ld a, [bc]
    db $10, $0E ; stop
    dec de
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_77F9:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    add hl, de

Jump_0E0_77FC::
    dec de
    jr Jump_0E0_780C
    db $1E, $0C, $1D, $90, $16, $0A, $17, $0A, $10, $0E, $1B, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_780B:: ; heuristic: target of a pointer table; C0
    ld a, [bc]

Jump_0E0_780C::
    inc e
    inc e
    ld [de], a
    inc e
    dec e
    ld a, [bc]
    rla
    dec e
    pop af
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    jr Jump_0E0_7829
    db $1E, $0C, $1D, $90, $16, $0A, $17, $0A, $10, $0E, $1B, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7828:: ; heuristic: target of a pointer table; C0
    sub a, b

Jump_0E0_7829::
    sub a, b
    sub a, b
    ld a, [de]
    ld a, [bc]
    sub a, b
    dec e
    dec de
    ld a, [bc]
    rla
    inc e
    dec d
    ld a, [bc]
    dec e
    jr Jump_0E0_7853
    db $F0, $90, $90, $90, $19, $15, $0A, $22, $90, $1D, $0E, $1C, $1D, $0E, $1B, $1C
    db $F0, $1C, $0A, $15, $0E, $1C, $9E, $16, $0A, $1B, $14

Jump_0E0_7853::
    ld c, $1D
    ld [de], a
    rla
    db $10, $F1 ; stop
    ld d, $0A
    rla
    ld a, [bc]
    db $10, $0E ; stop
    dec de
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7861:: ; heuristic: target of a pointer table; C0
    ld a, [bc]
    inc c
    inc c
    jr Jump_0E0_7884
    db $17, $1D, $12, $17, $10, $9E, $0C, $1B, $0E, $0D, $12, $1D, $F1, $16, $0A, $17
    db $0A, $10, $0E, $1B, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_787B:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    sbc a, [hl]
    dec de
    sub a, b
    ld a, [bc]

Jump_0E0_7884::
    rla
    ld a, [bc]
    dec d
    ld [hl+], a
    inc e
    dec e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_788B:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    ld c, $1C
    ld [de], a
    dec c
    ld c, $17
    dec e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_789A:: ; heuristic: target of a pointer table; C0
    sub a, b
    ld c, $17
    ld [de], a
    ld hl, $0C90
    jr Jump_0E0_78BE
    db $19, $18, $1B, $0A, $1D, $12, $18, $17, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_78AC:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    dec de
    dec e
    jr nz, Jump_0E0_78CF
    dec de
    inc d
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_78BA:: ; heuristic: target of a pointer table; C0
    sub a, b
    dec e
    ld c, $0C

Jump_0E0_78BE::
    ld de, $1217
    inc c
    ld a, [bc]
    dec d
    sub a, b
    inc e
    ld e, $19
    add hl, de
    jr Jump_0E0_78E6
    db $1D, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_78CD:: ; heuristic: target of a pointer table; C0
    sub a, b
    dec e

Jump_0E0_78CF::
    ld c, $0C
    ld de, $1217
    inc c
    ld a, [bc]
    dec d
    sub a, b
    inc e
    ld e, $19
    add hl, de
    jr Jump_0E0_78F9
    db $1D, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_78E0:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]

Jump_0E0_78E6::
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_78F0:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e

Jump_0E0_78F9::
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7900:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7910:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7920:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7930:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7940:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0E0_7950:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec d
    ld a, [bc]
    ld [hl+], a
    sub a, b
    dec e
    ld c, $1C
    dec e
    ld c, $1B
    inc e
    db $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0
Func_0E0_7960:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    inc e
    inc e
    ld [de], a
    inc e
    dec e
    ld a, [bc]
    rla
    dec e
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    jr Jump_0E0_7985
    db $1E, $0C, $0E, $1B, $1C, $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0
Func_0E0_797E:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de

Jump_0E0_7985::
    jr Jump_0E0_7994
    db $1E, $0C, $0E, $1B, $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0
Func_0E0_798C:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld c, $21
    ld c, $0C

Jump_0E0_7994::
    ld e, $1D
    ld [de], a
    rra
    ld c, $F1
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de
    jr Jump_0E0_79B1
    db $1E, $0C, $0E, $1B, $1C, $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0
Func_0E0_79AA:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    add hl, de
    dec de

Jump_0E0_79B1::
    ld c, $1C
    ld [de], a
    dec c
    ld c, $17
    dec e
    ldh a, [hFFF0]

; no direct call (reached through a table, a jump or a vector)
Func_0E0_79BA:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    cp a, b
    ld [bc], a
    nop
    nop
    ld bc, $0E90
    rla
    ld [de], a
    ld hl, $21F0
    rst $38
    ret c
    jr Jump_0E0_79F6
    db $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E, $21, $EF, $D8, $18, $19, $21
    db $BF, $D8, $18, $14, $21, $DF, $D8, $18, $0F, $21, $1F, $D9, $18, $0A, $21, $53
    db $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_0E0_79F6::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; no direct call (reached through a table, a jump or a vector)
AddDoubleAToHL_BankE0:: ; heuristic: follows a terminator; C0
Func_0E0_7A00:: ; address name
    add a, a
    add_a_to_hl
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleActor
Func_0E0_7A07:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0E0_7A1C
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0E0_7A1C
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_0E0_7A1C::
    ld a, [wBattleActor]
    cp a, $04
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wC57F, wBattleTarget
Func_0E0_7A22:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_0E0_7A37
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_0E0_7A37
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_0E0_7A37::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $383A3D, $43

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. Func_0E0_572D, Func_0E0_4C7E_Case01)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_BankE0::
Func_0E0_7A80:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0E0_7A9C
    ld l, $09
    cp a, $40
    jr nc, Jump_0E0_7A9C
    ld l, $12

Jump_0E0_7A9C::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0E0_7AB7
    ld l, $03
    cp a, $40
    jr nc, Jump_0E0_7AB7
    ld l, $06

Jump_0E0_7AB7::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_0E0_7AD2
    ld l, $01
    cp a, $40
    jr nc, Jump_0E0_7AD2
    ld l, $02

Jump_0E0_7AD2::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
Func_0E0_7AD7:: ; heuristic: follows a terminator; C0
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0E0_7AF1
    ld a, [hl]
    and a, $0C
    jr nz, Jump_0E0_7AF1
    xor a, a
    jr Jump_0E0_7AF2

Jump_0E0_7AF1::
    scf

Jump_0E0_7AF2::
    ld a, c
    pop bc
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
Func_0E0_7AF6:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_0E0_7B05
    ld a, [hl]
    and a, $0C

Jump_0E0_7B05::
    pop hl
    ret
    ds $4F9, $00
