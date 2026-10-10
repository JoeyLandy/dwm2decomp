SECTION "Bank 0C", ROMX[$4000], BANK[$0C]
    db $0C

; 1 call site from 1 routine (e.g. Func_010_6644)
; reads: wD780
Func_00C_4001::
    ld a, [wD780]
    rst $00
    dw Func_00C_4027
    dw Func_00C_404A
    dw Func_00C_4087
    dw Func_00C_4092
    dw Func_00C_40E6
    dw Func_00C_41D7
    dw Func_00C_433D
    dw Func_00C_4360
    dw Func_00C_43CE
    dw Func_00C_443D
    dw Func_00C_4448
    dw Func_00C_4492
    dw Func_00C_449D
    dw Func_00C_4609
    dw Func_00C_4650
    dw Func_00C_4676
    db $84, $46

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD7F0
; points at: wD780
Func_00C_4027:: ; heuristic: target of a pointer table; C0
    ld hl, wD780
    ld bc, $0020

Jump_00C_402D::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_402D
    ld a, $09
    ld [wD7F0], a
    ld a, [wD780]
    inc a
    db $EA, $80

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC919
Func_00C_403F:: ; heuristic: target of a pointer table; C0
    rst $10
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFB9, hFFBA, rSTAT, wD780
; writes: hScrollY, hScrollX, wD799, wD79A, hFFBA, hFFB9, hFF8D, wD780
Func_00C_404A:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ldh a, [hFFB9]
    ld [wD799], a
    ldh a, [hFFBA]
    ld [wD79A], a
    ld a, $90
    ldh [hFFBA], a
    ld a, $01
    ldh [hFFB9], a
    ld a, $0F
    ldh [hFF8D], a
    ld hl, vTiles0
    ld bc, $0800

Jump_00C_406E::
    di

Jump_00C_406F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_00C_406F
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_406E
    call Func_00C_511B
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_00C_4087:: ; heuristic: target of a pointer table; C0
    call Func_00C_5269
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD786, wD780
; writes: wC445, wD780
; points at: wC364
Func_00C_4092:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_56D9
    ld hl, wC364
    ld bc, $090D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wD787]
    and a, a
    jr z, Jump_00C_40A9
    ld a, $C3
    ld [wC445], a

Jump_00C_40A9::
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    call Func_00C_4F74
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD7F5, wD780
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD780, wC52D, wC52E, wC52F, ...
; points at: wC7FC, wD78E
Func_00C_40E6:: ; heuristic: target of a pointer table; C0
    call BGMapAddressAtScroll_Bank0C
    ld de, $0182
    add hl, de
    ld a, [wD787]
    add a, $E1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    ld c, $00

Jump_00C_40FC::
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD787, wD780
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD780, wC52D, wC52E, wC52F, ...
; points at: wC7FC, wD78E
Func_00C_4102:: ; heuristic: target of a pointer table; C0
    add a, b
    ld b, a
    ld a, c
    add a, b
    add a, a
    ld hl, Data_00C_5916
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $00

Jump_00C_4114::
    ld a, d
    cp a, $FF
    jp z, Jump_00C_41AA
    push de
    push bc
    ld a, e
    ld [wD7F1], a
    ld a, d
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall Func_015_68FA
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_00C_4141

Jump_00C_413C::
    pop bc
    inc b
    push bc
    jr Jump_00C_4159

Jump_00C_4141::
    pop bc
    pop de
    push de
    push bc
    ld a, e
    ld [wD006], a
    ld a, d
    ld [wD007], a
    farcall Func_016_5A7E
    ld a, c
    and a, a
    jr z, Jump_00C_4159
    jr Jump_00C_413C

Jump_00C_4159::
    pop bc
    pop de
    inc de
    ld a, [wD787]
    add a, a
    ld l, a
    add a, a
    add a, l
    ld l, a
    ld a, c
    add a, l
    add a, a
    ld hl, Data_00C_592E
    add_a_to_hl
    push de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld a, d
    cp a, h
    jr c, Jump_00C_4114
    jr nz, Jump_00C_417F
    ld a, e
    cp a, l
    jr c, Jump_00C_4114

Jump_00C_417F::
    push bc
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wD78E
    add_a_to_hl
    pop bc
    ld a, c
    add_a_to_hl
    ld a, b
    ld [hl], a
    ld a, [wD787]
    and a, a
    jr z, Jump_00C_41A2
    ld b, $05
    jr Jump_00C_41A4

Jump_00C_41A2::
    ld b, $06

Jump_00C_41A4::
    inc c
    ld a, c
    cp a, b
    jp c, Jump_00C_40FC

Jump_00C_41AA::
    xor a, a
    ld [wD7F1], a
    call Func_00C_5085
    ld a, $01
    ld [wD7F1], a
    call Func_00C_5085
    ld a, [wD780]
    inc a
    ld [wD780], a
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

; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD780, wD787, wD786
; writes: wD780, wD7FA, hFFB9, hFFBA, wC920, wC919, wC456, wD786, ...
; points at: wD78E
Func_00C_41D7:: ; heuristic: target of a pointer table; C0
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_00C_41FB
    bit 5, a
    jr nz, Jump_00C_4229
    bit 6, a
    jr nz, Jump_00C_4236
    bit 7, a
    jr nz, Jump_00C_425C
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00C_4278
    bit 1, a
    jp nz, Jump_00C_42D3
    call Func_00C_42F0
    ret

Jump_00C_41FB::
    ld a, [wD787]
    cp a, $01
    db $38

; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD780
; writes: wD787, wD786, wD780
Func_00C_4201:: ; heuristic: target of a pointer table; C0
    inc bc

; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD780
; writes: wD787, wD786, wD780
Func_00C_4202:: ; heuristic: target of a pointer table; C0
    xor a, a
    jr Jump_00C_4206
    db $3C

Jump_00C_4206::
    ld [wD787], a
    cp a, $01
    jr c, Jump_00C_4218
    ld a, [wD786]
    cp a, $05
    jr c, Jump_00C_4218
    dec a
    ld [wD786], a

Jump_00C_4218::
    call Func_00C_430A
    ld a, $69
    call QueueSoundEffect
    ld a, [wD780]
    sub a, $03
    ld [wD780], a
    ret

Jump_00C_4229::
    ld a, [wD787]
    and a, a
    jr nz, Jump_00C_4233
    ld a, $01
    jr Jump_00C_4206

Jump_00C_4233::
    dec a
    jr Jump_00C_4206

Jump_00C_4236::
    call Func_00C_430E
    ld a, [wD787]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_4244
    inc d

Jump_00C_4244::
    ld a, [de]
    ld b, a
    ld a, [wD786]
    and a, a
    jr nz, Jump_00C_424F
    ld a, b
    jr Jump_00C_4250

Jump_00C_424F::
    dec a

Jump_00C_4250::
    ld [wD786], a
    call Func_00C_430A
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_425C::
    call Func_00C_430E
    ld a, [wD787]
    ld de, Data_00C_56D7
    add a, e
    ld e, a
    jr nc, Jump_00C_426A
    inc d

Jump_00C_426A::
    ld a, [de]
    ld b, a
    ld a, [wD786]
    cp a, b
    jr c, Jump_00C_4275
    xor a, a
    jr Jump_00C_4250

Jump_00C_4275::
    inc a
    jr Jump_00C_4250

Jump_00C_4278::
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD786]
    add a, b
    ld hl, wD78E
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr nz, Jump_00C_42A2
    call Func_00C_4312
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_42A2::
    ld a, $69
    call QueueSoundEffect
    call Func_00C_4312
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wD787]
    add a, $E1
    ld [wC456], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    add a, $04
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_42D3::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $02
    ld [wD7FA], a
    ld a, $02
    ldh [hFFB9], a
    xor a, a
    ldh [hFFBA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_00C_41D7)
; reads: wJoypadRepeatTimer, wD785, wD786
; writes: wD785
Func_00C_42F0::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Func_00C_430A
    ld a, [wD785]
    inc a
    ld [wD785], a
    cp a, $10
    jr c, Func_00C_430A

; no direct call (reached through a table, a jump or a vector)
; reads: wD786
; writes: wD785
Func_00C_4302:: ; heuristic: target of a pointer table; C0
    cp a, $18
    jr c, Func_00C_430E
    xor a, a
    ld [wD785], a

; 2 call sites from 1 routine (e.g. Func_00C_4202)
; reads: wD786
Func_00C_430A::
    ld b, $BB
    jr Jump_00C_4314

; 2 call sites from 1 routine (e.g. Func_00C_4202)
; reads: wD786
Func_00C_430E::
    ld b, $C3
    jr Jump_00C_4314

; 2 call sites from 1 routine (e.g. Func_00C_4202)
; reads: wD786
Func_00C_4312::
    ld b, $BC

Jump_00C_4314::
    ld a, [wD786]
    add a, a
    ld hl, Data_00C_4331
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_4331:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $61, $01

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: hFF90, wC527, wD780
Func_00C_433D:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    ld a, $11
    ldh [hFF90], a
    call Func_000_1C0C
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    farcall Func_069_4001
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD799, wD79A, wD780
; writes: hFFB9, hFFBA, hFF8D, wD780, wC52D, wC52E, wC52F, wC530, ...
; points at: wC364, wScreenTileBuffer, wD1CC, wD000
Func_00C_4360:: ; heuristic: target of a pointer table; C0
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call Func_00C_52D0
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_437E
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

Jump_00C_437E::
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    ld a, [wD799]
    ldh [hFFB9], a
    ld a, [wD79A]
    ldh [hFFBA], a
    xor a, a
    ldh [hFF8D], a
    ld a, [wD780]
    inc a
    ld [wD780], a
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
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7F0, wC920, wC919
; points at: wD780, wC130
Func_00C_43CE:: ; heuristic: target of a pointer table; C0
    ld hl, $2940
    ld de, vTiles1 + $500
    call CopyTileBytesToVRAM_Bank0C
    call Func_00C_4424
    call Func_00C_4424
    call Func_00C_4424
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    farcall Func_01D_62AD
    farcall Func_016_7A64
    xor a, a
    ld [wD7F0], a
    ld hl, wD780
    ld bc, $0020

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC919
; points at: wC130
Func_00C_4402:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_00C_4402
    ld hl, wC130
    ld b, $10

Jump_00C_440E::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00C_440E
    farcall Func_002_470B
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 3 call sites from 1 routine (e.g. Func_00C_43CE)
Func_00C_4424::
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ld hl, $2940
    call CopyTileBytesToVRAM_Bank0C
    ret

; no direct call (reached through a table, a jump or a vector)
Func_00C_443D:: ; heuristic: target of a pointer table; C0
    call Func_00C_5283
    db $FA

; no direct call (reached through a table, a jump or a vector)
; writes: wD780
Func_00C_4441:: ; heuristic: target of a pointer table; C0
    add a, b
    rst $10
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD78A, wD780
; writes: wC465, wD780
; points at: wC36C
Func_00C_4448:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_574E
    ld hl, wC36C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_445F
    inc d

Jump_00C_445F::
    ld a, [de]
    add a, $E1
    ld [wC465], a
    ld a, [wD78A]
    ld hl, Data_00C_590A
    ld b, $BB
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD78A]
    ld hl, Data_00C_590A
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call Func_00C_4EC7
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_00C_4492:: ; heuristic: target of a pointer table; C0
    call Func_00C_501F
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD780, wD78A, wD78B
; writes: wD780, wD7FA, wD78A, wD78B, wC920, wC919
Func_00C_449D:: ; heuristic: target of a pointer table; C0
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Func_00C_44C3
    bit 5, a
    jr nz, Jump_00C_451C
    bit 6, a
    jp nz, Jump_00C_4533
    bit 7, a
    jp nz, Jump_00C_4550
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00C_4563
    bit 1, a
    jp nz, Jump_00C_459F
    call Func_00C_45BC
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD78B, wD78A, wD780
; writes: wD78B, wD78A, wD780
Func_00C_44C3:: ; heuristic: target of a pointer table; C0
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_44CE
    inc d

Jump_00C_44CE::
    ld a, [de]
    ld b, a
    ld a, [wD78B]
    cp a, b
    jr c, Jump_00C_44D9
    xor a, a
    jr Jump_00C_44DA

Jump_00C_44D9::
    inc a

Jump_00C_44DA::
    ld [wD78B], a
    push af
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_44E9
    inc d

Jump_00C_44E9::
    ld a, [de]
    ld b, a
    pop af
    cp a, b
    jr c, Jump_00C_450B
    call Func_00C_506C
    ld b, a
    ld a, [wD78A]
    cp a, b
    jr c, Jump_00C_450B
    ld a, b
    ld [wD78A], a
    ld a, [wD780]
    db $D6

; no direct call (reached through a table, a jump or a vector)
; writes: wD780
Func_00C_4501:: ; heuristic: target of a pointer table; C0
    inc bc

; no direct call (reached through a table, a jump or a vector)
; writes: wD780
Func_00C_4502:: ; heuristic: target of a pointer table; C0
    ld [wD780], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_450B::
    call Func_00C_45D6
    ld a, [wD780]
    sub a, $03
    ld [wD780], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_451C::
    ld a, [wD78B]
    and a, a
    jr nz, Jump_00C_4530
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_452D
    inc d

Jump_00C_452D::
    ld a, [de]
    jr Jump_00C_44DA

Jump_00C_4530::
    dec a
    jr Jump_00C_44DA

Jump_00C_4533::
    call Func_00C_45DA
    call Func_00C_506C
    ld b, a
    ld a, [wD78A]
    and a, a
    jr nz, Jump_00C_4543
    ld a, b
    jr Jump_00C_4544

Jump_00C_4543::
    dec a

Jump_00C_4544::
    ld [wD78A], a
    call Func_00C_45D6
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_4550::
    call Func_00C_45DA
    call Func_00C_506C
    ld b, a
    ld a, [wD78A]
    cp a, b
    jr c, Jump_00C_4560
    xor a, a
    jr Jump_00C_4544

Jump_00C_4560::
    inc a
    jr Jump_00C_4544

Jump_00C_4563::
    call Func_00C_52EC
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_456F
    inc d

Jump_00C_456F::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    call Func_00C_52FB
    pop hl
    add_a_to_hl
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_459B
    ld a, $69
    call QueueSoundEffect
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_459B::
    call Func_00C_45D6
    ret

Jump_00C_459F::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wD78A], a
    ld [wD78B], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_00C_449D)
; reads: wJoypadRepeatTimer, wD789, wD78A
; writes: wD789
Func_00C_45BC::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Func_00C_45D6
    ld a, [wD789]
    inc a
    ld [wD789], a
    cp a, $10
    jr c, Func_00C_45D6
    cp a, $18
    jr c, Func_00C_45DA
    xor a, a
    ld [wD789], a

; 3 call sites from 1 routine (e.g. Func_00C_4502)
; reads: wD78A
Func_00C_45D6::
    ld b, $BB
    jr Jump_00C_45E0

; 2 call sites from 1 routine (e.g. Func_00C_4502)
; reads: wD78A
Func_00C_45DA::
    ld b, $C3
    jr Jump_00C_45E0
    db $06, $BC

Jump_00C_45E0::
    ld a, [wD78A]
    add a, a
    ld hl, Data_00C_45FD
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_45FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $00, $69, $00, $A9, $00, $E9, $00, $29, $01, $69, $01

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD7F1, wD780, wC52D, wC52E, wC52F
; points at: wC36C
Func_00C_4609:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_57EA
    ld hl, wC36C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, $01
    ld [wD7F1], a
    call Func_00C_5085
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    db $EA, $30

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC919
Func_00C_4645:: ; heuristic: target of a pointer table; C0
    push bc
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD786
; writes: wD780, wC920, wC919
Func_00C_4650:: ; heuristic: target of a pointer table; C0
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $C3
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, $05
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_00C_4676:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    call Func_00C_511B
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret
    db $FA, $81, $D7, $C7
    dw Func_00C_46A4
    dw Func_00C_4778
    dw Func_00C_490A
    dw Func_00C_49B5
    dw Func_00C_49DA
    dw Func_00C_4AA6
    dw Func_00C_4B12
    dw Func_00C_4B5C
    dw Func_00C_4B95
    dw Func_00C_4CE2
    dw Func_00C_4CFB
    dw Func_00C_4D6B
    dw Func_00C_4D7C
    dw Func_00C_4DD6

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wC52D, wC52E, wC52F, wC530, wD781, wD782
Func_00C_46A4:: ; heuristic: target of a pointer table; C0
    call Func_00C_529D
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
    call FillTilesFromRequest
    ld hl, Data_00C_4718
    ld de, vTiles2 + $610
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    call CopyTileBytesToVRAM_Bank0C
    ld de, Data_01F_41D0
    ld hl, vTiles2 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4170
    ld hl, vTiles2 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4160
    ld hl, vTiles2 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4110
    ld hl, vTiles2 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Data_00C_4718:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $030718, $60

; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wIsCGB, wD781
; writes: wC52D, wC52E, wC52F, wC530, rSVBK, wC526, wD781, wD782
; points at: wC364, wC300, wD1CC, wD168, wC381, wC3BD, wC3E5, wC40D, ...
Func_00C_4778:: ; heuristic: target of a pointer table; C0
    ld a, [wD782]
    and a, a
    jr nz, Jump_00C_47E9
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld de, Data_0F1_5C14
    ld hl, vTiles1
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5D44
    ld hl, wC364
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5D9C
    ld hl, wC300
    ld b, $F1
    call DecompressToVRAM
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_47E9
    ld a, $02
    ldh [rSVBK], a
    ld de, Data_0F1_5DBC
    ld hl, wD1CC
    ld b, $F1
    call DecompressToVRAM
    ld de, Data_0F1_5DEE
    ld hl, wD168
    ld b, $F1
    call DecompressToVRAM
    xor a, a
    ldh [rSVBK], a
    farcall Func_0F1_5C05
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes

Jump_00C_47E9::
    ld de, Data_00C_48AB
    ld hl, wC381
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48B5
    ld hl, wC3BD
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD781
; writes: rSVBK, wD781, wD782
; points at: wC3E5, wC40D, wC435, wC45D, wC315, wC33D, wD79C, wC408, ...
Func_00C_4801:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_48BF
    ld hl, wC3E5
    ld bc, $0A01
    call CopyRectTo20ByteRows_Bank0C
    ld de, $48C9
    ld hl, wC40D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, $48D2
    ld hl, wC435
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, $48DB
    ld hl, wC45D
    ld bc, $0901
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48E4
    ld hl, wC315
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    ld de, Data_00C_48F6
    ld hl, wC33D
    ld bc, $1201
    call CopyRectTo20ByteRows_Bank0C
    call Func_00C_534A
    ld de, wD79C
    ld hl, wC408
    ld bc, $0201
    call CopyRectTo20ByteRows_Bank0C
    call Func_00C_54F3
    ld de, wD79C
    ld hl, wC430
    ld bc, $0401
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_4883
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD298
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    xor a, a
    ldh [rSVBK], a

Jump_00C_4883::
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Data_00C_48AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E

Data_00C_48B5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $42, $30, $31, $32, $33, $34, $35, $36, $37, $38

Data_00C_48BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $43, $39, $3A, $3B, $3C, $3D, $3E
    dw Func_00C_403F
    dw Func_00C_4441
    dw Func_00C_4645
    dw $4847
    dw Func_00C_4A49
    db $4B
    dw $4D4C
    dw Func_00C_4F4E
    dw Func_00C_5150
    dw Func_00C_5352
    dw Func_00C_5554
    dw Func_00C_5756
    db $58, $59, $5A, $5B, $5C, $5D, $5E

Data_00C_48E4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1
    db $B2, $B3

Data_00C_48F6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3
    db $C4, $C5, $7E, $7F

; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wIsCGB, wD781
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wC526, ...
Func_00C_490A:: ; heuristic: target of a pointer table; C0
    ld a, [wD782]
    and a, a
    jp nz, Jump_00C_4957
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_00C_651B
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $00
    ld [wD7F7], a
    farcall Func_01F_5D2A
    call Func_00C_5050
    ld e, l
    ld d, h
    push de
    db $21, $20

; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wD782
Func_00C_4948:: ; heuristic: target of a pointer table; C0
    sub a, b
    ld c, $04
    call Func_000_1FE3
    pop de
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_00C_4957::
    call Func_00C_5050
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_497A
    ld e, l
    ld d, h
    push de
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes
    ld a, $04
    ldh [hFFC6], a
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    pop de
    call Func_000_2090

Jump_00C_497A::
    call BGMapAddressAtScroll_Bank0C
    ld de, $0021
    add hl, de
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_00C_64D3
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $01
    ld [wD7F7], a
    farcall Func_01F_5D2A
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD781
Func_00C_49B5:: ; heuristic: target of a pointer table; C0
    call Func_00C_5050
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall Func_01D_6973
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530, wD09D, wD09E, ...
Func_00C_49DA:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    ld a, h
    add a, $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles2 + $260
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    call Func_00C_52EC
    and a, $0F
    ld [wD09D], a
    ld a, $2F
    ld [wD09E], a
    farcall Func_016_7A48
    call Func_00C_52EC
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $670
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    call Func_00C_5050
    ld a, l
    ld [wD7F1], a
    ld a, h
    db $EA

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530, wD781
; points at: wD7F5
Func_00C_4A49:: ; heuristic: target of a pointer table; C0
    ldh a, [c]
    rst $10
    farcall Func_00E_5C2B
    farcall Func_0F2_5181
    ld a, $04
    ld [wStringCategory], a
    ld hl, wD7F5
    ld c, $00

Jump_00C_4A61::
    push hl
    push bc
    ld a, [hl]
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, Data_00C_4AA0
    add a, e
    ld e, a
    jr nc, Jump_00C_4A71
    inc d

Jump_00C_4A71::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_00C_4A61
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_00C_4AA0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $94, $D0, $94, $60, $95

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530, wD781
Func_00C_4AA6:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    call Func_00C_530A
    cp a, $FF
    jr z, Jump_00C_4B0A
    ld de, Data_01F_4990
    ld hl, vTiles2 + $420
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4990
    ld hl, vTiles2 + $430
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    ld hl, vTiles2 + $390
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    farcall ShowString_Bank0B

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00C_4B01:: ; heuristic: target of a pointer table; C0
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_00C_4B0A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00C_4B12:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    push hl
    sla l
    rl h
    ld de, Data_00C_599F
    add hl, de
    ld a, $42
    call Func_00C_4E75
    pop hl
    push hl
    sla l
    rl h
    ld de, Data_00C_5F9F
    add hl, de
    ld a, $43
    call Func_00C_4E75
    pop hl
    push hl
    sla l
    rl h
    ld de, Data_00C_599F
    add hl, de
    ld de, vTiles2 + $300
    call Func_00C_4E16
    pop hl
    sla l
    rl h

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00C_4B4A:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_5F9F
    add hl, de
    ld de, vTiles2 + $390
    call Func_00C_4E16
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530, wD781
Func_00C_4B5C:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    call Func_00C_5050
    ld a, $10
    add_a_to_hl
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD786, wJoypadPressedRepeat, wJoypadPressed, wD781, wD78A, wD78B
; writes: wD781, wD78B, wD78A, wC52D, wC52E, wC52F, wC530, wD782
; points at: wD78E
Func_00C_4B95:: ; heuristic: target of a pointer table; C0
    call Func_00C_4FC2
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD786]
    add a, b
    ld hl, wD78E
    add_a_to_hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_00C_4BBD
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_00C_4BCB
    bit 5, a
    jp nz, Jump_00C_4C4F

Jump_00C_4BBD::
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_00C_4CD5
    bit 1, a
    jp nz, Jump_00C_4CDA
    ret

Jump_00C_4BCB::
    ld a, [wD78A]
    cp a, $05
    jr c, Jump_00C_4BF8
    xor a, a
    ld [wD78A], a
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4BE1
    inc d

Jump_00C_4BE1::
    ld a, [de]
    ld b, a
    ld a, [wD78B]
    cp a, b
    jr c, Jump_00C_4BF2

Jump_00C_4BE9::
    xor a, a
    ld [wD78A], a
    ld [wD78B], a
    jr Jump_00C_4BFC

Jump_00C_4BF2::
    inc a
    ld [wD78B], a
    jr Jump_00C_4BFC

Jump_00C_4BF8::
    inc a
    ld [wD78A], a

Jump_00C_4BFC::
    call Func_00C_5050
    push hl
    call Func_00C_52EC
    add a, a
    ld hl, Data_00C_592E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, Jump_00C_4C1C
    jr nz, Jump_00C_4BE9
    ld a, l
    cp a, e
    jr c, Jump_00C_4C1C
    jr Jump_00C_4BE9

Jump_00C_4C1C::
    call Func_00C_5050
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_4BCB
    ld a, $69
    call QueueSoundEffect
    call Func_00C_529D
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, $01
    ld [wD781], a
    ld [wD782], a
    ret

Jump_00C_4C4F::
    ld a, [wD78A]
    and a, a
    jr nz, Jump_00C_4C7E
    ld a, [wD78B]
    and a, a
    jr nz, Jump_00C_4C72

Jump_00C_4C5B::
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_4C66
    inc d

Jump_00C_4C66::
    ld a, [de]
    ld [wD78B], a
    call Func_00C_506C
    ld [wD78A], a
    jr Jump_00C_4C82

Jump_00C_4C72::
    dec a
    ld [wD78B], a
    call Func_00C_506C
    ld [wD78A], a
    jr Jump_00C_4C82

Jump_00C_4C7E::
    dec a
    ld [wD78A], a

Jump_00C_4C82::
    call Func_00C_5050
    push hl
    call Func_00C_52EC
    add a, a
    ld hl, Data_00C_592E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, h
    cp a, d
    jr c, Jump_00C_4CA2
    jr nz, Jump_00C_4C5B
    ld a, l
    cp a, e
    jr c, Jump_00C_4CA2
    jr nz, Jump_00C_4C5B

Jump_00C_4CA2::
    call Func_00C_5050
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_4C4F
    ld a, $69
    call QueueSoundEffect
    call Func_00C_529D
    ld hl, vTiles1 + $220
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, $01
    ld [wD781], a
    ld [wD782], a
    ret

Jump_00C_4CD5::
    ld a, $69
    call QueueSoundEffect

Jump_00C_4CDA::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00C_4CE2:: ; heuristic: target of a pointer table; C0
    call Func_00C_5177
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    call Func_00C_511B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC364
Func_00C_4CFB:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_56D9
    ld hl, wC364
    db $01

; no direct call (reached through a table, a jump or a vector)
; reads: wD787, wD786, wD78A, wD781
; writes: wC445, wC456, wC52D, wC52E, wC52F, wC530, wC526, wD781
; points at: wC36C
Func_00C_4D02:: ; heuristic: target of a pointer table; C0
    dec c
    add hl, bc
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wD787]
    and a, a
    jr z, Jump_00C_4D12
    ld a, $C3
    ld [wC445], a

Jump_00C_4D12::
    ld a, [wD786]
    ld hl, Data_00C_58FE
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    ld a, [wD787]
    add a, $E1
    ld [wC456], a
    ld de, Data_00C_574E
    ld hl, wC36C
    ld bc, $0C0D
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wD78A]
    ld b, $BC
    ld hl, Data_00C_590A
    call StoreBAtWordTableEntry_Bank0C
    call Func_00C_5269
    call Func_00C_5283
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
    call FillTilesFromRequest
    ld a, $7F
    ld [wC526], a
    call UploadBGPalettes
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
Func_00C_4D6B:: ; heuristic: target of a pointer table; C0
    call Func_00C_5543
    call Func_00C_4F74
    call Func_00C_4EC7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD781, wC52D, wC52E
; points at: wC300
Func_00C_4D7C:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7F1], a
    call Func_00C_5085
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld de, Data_00C_589A
    ld hl, wC300
    ld bc, $1405
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    call Func_00C_501F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    db $21, $02

; no direct call (reached through a table, a jump or a vector)
; writes: wC52F, wC530, wC920, wC919
Func_00C_4DC3:: ; heuristic: target of a pointer table; C0
    ld [de], a
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD78A
; writes: wD781, wD780, wC52D, wC52E
Func_00C_4DD6:: ; heuristic: target of a pointer table; C0
    ld a, [wD78A]
    ld b, $C3
    ld hl, Data_00C_590A
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140C
    ld de, $01CC
    call Func_00C_51F5
    xor a, a
    ld [wD781], a
    ld a, $0C
    ld [wD780], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    db $21

; no direct call (reached through a table, a jump or a vector)
; writes: wC52F, wC530, wC920, wC919
Func_00C_4E02:: ; heuristic: target of a pointer table; C0
    ld [bc], a
    ld [de], a
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 2 routines (e.g. Func_00C_4B4A, Func_00C_4B12)
; writes: wStringIndex, wStringCategory, wC52D, wC52E, wC52F, wC530
Func_00C_4E16::
    push de
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, Jump_00C_4E42
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    pop de
    ld a, e
    ld [wC52D], a
    ld a, d
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    ret

Jump_00C_4E42::
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00C_4E53
    and a, $0F
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    jr Jump_00C_4E5A

Jump_00C_4E53::
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a

Jump_00C_4E5A::
    pop de
    ld a, e
    ld [wC52D], a
    ld a, d
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank0B
    ret

; 2 call sites from 1 routine (e.g. Func_00C_4B12)
; reads: wD7F5
; writes: wD7F6, wD7F7, wD09D, wD09E
Func_00C_4E75::
    push af
    inc hl
    ld a, [hl-]
    cp a, $FE
    jr z, Jump_00C_4E8F
    ld a, [hl+]
    ld [wD7F6], a
    ld a, [hl]
    ld [wD7F7], a
    farcall Func_00E_615A
    ld a, [wD7F5]
    jr Jump_00C_4E94

Jump_00C_4E8F::
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00C_4EA4

Jump_00C_4E94::
    and a, $0F
    ld [wD09D], a
    pop af
    ld [wD09E], a
    farcall Func_016_7A48
    ret

Jump_00C_4EA4::
    pop af
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld de, vTiles2
    add hl, de
    ld de, Data_01F_4990
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; 2 call sites from 2 routines (e.g. Func_00C_4D6B, Func_00C_4448)
; reads: wD78B
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530
Func_00C_4EC7::
    call Func_00C_52EC
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_4ED3
    inc d

Jump_00C_4ED3::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD78B]
    add a, a
    ld b, a
    add a, a
    add a, b
    add_a_to_hl
    ld c, $00

Jump_00C_4EE6::
    push hl
    push bc
    call Func_00C_530A
    and a, a
    jr z, Jump_00C_4F26
    pop bc
    pop hl
    push hl
    push bc
    ld a, h
    add a, $02
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, Data_00C_4F68

; no direct call (reached through a table, a jump or a vector)
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
Func_00C_4F01:: ; heuristic: target of a pointer table; C0
    add a, e

; no direct call (reached through a table, a jump or a vector)
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
Func_00C_4F02:: ; heuristic: target of a pointer table; C0
    ld e, a
    jr nc, Jump_00C_4F06
    inc d

Jump_00C_4F06::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    jr Jump_00C_4F57

Jump_00C_4F26::
    pop bc
    push bc
    xor a, a
    ld [wStringCategory], a
    ld [wStringIndex], a
    ld a, c
    add a, a
    ld de, Data_00C_4F68
    add a, e
    ld e, a
    jr nc, Jump_00C_4F39
    inc d

Jump_00C_4F39::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h

; no direct call (reached through a table, a jump or a vector)
; writes: wC530, wStringCategory, wStringIndex, wC52D, wC52E, wC52F
Func_00C_4F4E:: ; heuristic: target of a pointer table; C0
    ld [wC530], a
    farcall ShowString_Bank0B

Jump_00C_4F57::
    pop bc
    pop hl
    inc hl
    push hl
    inc c
    call Func_00C_506C
    inc a
    ld b, a
    pop hl
    ld a, c
    cp a, b
    jp c, Jump_00C_4EE6
    ret

Data_00C_4F68:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $92, $90, $92, $20, $93, $B0, $93, $40, $94, $D0, $94

; 2 call sites from 2 routines (e.g. Func_00C_4D6B, Func_00C_4092)
; reads: wD787
; writes: wD09D, wD09E
Func_00C_4F74::
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld de, Data_00C_4FAA
    add a, e
    ld e, a
    jr nc, Jump_00C_4F83
    inc d

Jump_00C_4F83::
    ld c, $00

Jump_00C_4F85::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00C_4FA2
    push de
    push bc
    ld [wD09D], a
    cp a, $06
    jr c, Jump_00C_4F95
    sub a, $06

Jump_00C_4F95::
    inc a
    inc a
    ld [wD09E], a
    farcall Func_016_7A48
    pop bc
    pop de

Jump_00C_4FA2::
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_00C_4F85
    ret

Data_00C_4FAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $FF, $20, $90, $70, $90
    db $C0, $90, $10, $91, $60, $91, $B0, $91

; 5 call sites from 5 routines (e.g. Func_00C_4B95, Func_00C_4B5C, Func_00C_4B12, Func_00C_4AA6, ...)
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6, hSpriteSubIndex
Func_00C_4FC2::
    call Func_00C_5050
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld a, $10
    ld [wD7F4], a
    ld a, $6C
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    xor a, a
    ldh [hSpriteSubIndex], a
    farcall Func_01D_6A36
    ld a, $24
    ld [wD7F4], a
    ld a, $6C
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    ld a, $04
    ldh [hSpriteSubIndex], a
    ld hl, $6A36
    db $06

; no direct call (reached through a table, a jump or a vector)
; writes: wD7F4, wD7F5, wD7F6, hSpriteSubIndex
Func_00C_5002:: ; heuristic: target of a pointer table; C0
    dec e
    rst $10
    ld a, $38
    ld [wD7F4], a
    ld a, $6C
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    ld a, $02
    ldh [hSpriteSubIndex], a
    farcall Func_01D_6A36
    ret

; 2 call sites from 2 routines (e.g. Func_00C_4D7C, Func_00C_4492)
; reads: wD78B
Func_00C_501F::
    call BGMapAddressAtScroll_Bank0C
    ld de, $018F
    add hl, de
    push hl
    ld a, [wD78B]
    add a, $E1
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call Func_00C_52EC
    ld de, Data_00C_5944
    add a, e
    ld e, a
    jr nc, Jump_00C_5043
    inc d

Jump_00C_5043::
    ld a, [de]
    add a, $E1
    ld b, a
    pop hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; 15 call sites from 11 routines (e.g. Func_00C_54F3, Func_00C_534A, Func_00C_4B95, Func_00C_4FC2, ...)
Func_00C_5050::
    call Func_00C_52EC
    add a, a
    ld de, Data_00C_5916
    add a, e
    ld e, a
    jr nc, Jump_00C_505C
    inc d

Jump_00C_505C::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    push hl
    call Func_00C_52FB
    pop hl
    add_a_to_hl
    ret

; 6 call sites from 4 routines (e.g. Func_00C_4F4E, Func_00C_44C3, Func_00C_4B95, Func_00C_4502)
; reads: wD78B
Func_00C_506C::
    call Func_00C_52EC
    add a, a
    ld hl, Data_00C_594F
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wD78B]
    add a, e
    ld e, a
    jr nc, Jump_00C_5083
    inc d

Jump_00C_5083::
    ld a, [de]
    ret

; 4 call sites from 3 routines (e.g. Func_00C_4102, Func_00C_4D7C, Func_00C_4609)
; reads: wD787, wC8C1, wD7F1, wC8C2
; writes: wC8C1
; points at: wD78E
Func_00C_5085::
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld hl, wD78E
    add_a_to_hl
    ld a, [wD787]
    and a, a
    jr nz, Jump_00C_509E
    ld b, $06
    jr Jump_00C_50A0

Jump_00C_509E::
    ld b, $05

Jump_00C_50A0::
    ld c, $00

Jump_00C_50A2::
    push hl
    push bc
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_00C_50B6
    add a, $E3
    ld [wC8C1], a

Jump_00C_50B6::
    call BGMapAddressAtScroll_Bank0C
    pop bc
    push bc
    ld a, c
    add a, a
    push hl
    push af
    ld a, [wD7F1]
    and a, a
    jr z, Jump_00C_50D6
    ld hl, Data_00C_510F
    pop af
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld l, e
    ld h, d
    jr Jump_00C_50E4

Jump_00C_50D6::
    ld hl, Data_00C_5103
    pop af
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de

Jump_00C_50E4::
    di
    call WaitForVRAMAccess
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00C_50A2
    ret

Data_00C_5103:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $26, $00, $66, $00, $A6, $00, $E6, $00, $26, $01, $66, $01

Data_00C_510F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7E, $C3, $A6, $C3, $CE, $C3, $F6, $C3, $1E, $C4, $46, $C4

; 3 call sites from 3 routines (e.g. Func_00C_4CE2, Func_00C_4676, Func_00C_404A)
; reads: wIsCGB
; writes: rSVBK
; points at: wC364, wD1CC
Func_00C_511B::
    ld hl, wC364
    ld bc, $0104

Jump_00C_5121::
    ld a, $C3
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_5121
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_5144
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD1CC
    ld bc, $0104

Jump_00C_5139::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_5139
    ld a, $00
    ldh [rSVBK], a

Jump_00C_5144::
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 14 call sites from 4 routines (e.g. Func_00C_5177, Func_00C_46A4, Func_00C_43CE, Func_00C_4424)
; reads: rSTAT
CopyTileBytesToVRAM_Bank0C::
Func_00C_5145:: ; address name
    ld c, $10

Jump_00C_5147::
    di

Jump_00C_5148::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_00C_5148
    ld a, [hl+]
    ld [de], a

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_5150:: ; heuristic: target of a pointer table; C0
    inc de
    ei
    dec c
    jr nz, Jump_00C_5147
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 40 call sites from 33 routines (e.g. Func_00C_7002, Func_00C_4312, Func_00C_5085, Func_00C_6901, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank0C::
Func_00C_5156:: ; address name
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; 4 call sites from 4 routines (e.g. Func_00C_4CE2, Func_00C_4676, Func_00C_433D, Func_00C_404A)
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7
Func_00C_5177::
    ld hl, Data_00C_51AB
    ld de, vTiles1 + $430
    call CopyTileBytesToVRAM_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, Data_00C_5E12
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $20
    ld [wD7F3], a
    ld a, $20
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall Func_01F_5D9A
    ret

Data_00C_51AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 23 call sites from 14 routines (e.g. Func_00C_4D02, Func_00C_7098, Func_00C_6DC5, Func_00C_6BB4, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank0C::
Func_00C_51BB:: ; address name
    push hl
    push bc

Jump_00C_51BD::
    push bc
    push hl

Jump_00C_51BF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00C_51BF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00C_51BD
    pop bc
    pop hl
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_00C_51E1::
    push bc
    push hl

Jump_00C_51E3::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_51E3
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00C_51E1
    xor a, a
    ldh [rSVBK], a
    ret

; 28 call sites from 21 routines (e.g. Func_00C_7002, Func_00C_6674, Func_00C_6E0C, Func_00C_6DC5, ...)
; reads: wStringIndex, wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wScreenTileBuffer, wD000
Func_00C_51F5::
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call Func_000_18A5
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld [wC554], a
    ld a, h
    adc a, $01
    ld [wC555], a
    ld a, [wStringIndex]
    cp a, $18
    jr z, Jump_00C_5226
    cp a, $12
    jr z, Jump_00C_5226
    ld a, $C1
    ld [wC554], a
    ld a, $99
    ld [wC555], a

Jump_00C_5226::
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call Func_000_18A5
    xor a, a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; 1 call site from 1 routine (e.g. Func_00C_6A04)
Func_00C_5247::
    ld a, c
    ld b, a
    ld c, $00

Jump_00C_524B::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank0C
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00C_524B
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 12 call sites from 9 routines (e.g. Func_00C_4D02, Func_00C_6BE3, Func_00C_5247, Func_00C_680B, ...)
StoreBAtWordTableEntry_Bank0C::
Func_00C_525B:: ; address name
    push bc
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; 2 call sites from 2 routines (e.g. Func_00C_4D02, Func_00C_4087)
; writes: wC52D, wC52E, wC52F, wC530
Func_00C_5269::
    ld hl, vTiles2 + $20
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1702
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ret

; 2 call sites from 2 routines (e.g. Func_00C_4D02, Func_00C_443D)
; writes: wC52D, wC52E, wC52F, wC530
Func_00C_5283::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $5301
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ret

; 3 call sites from 2 routines (e.g. Func_00C_4B95, Func_00C_46A4)
; writes: wC52D, wC52E, wC52F, wC530
Func_00C_529D::
    ld hl, vTiles2
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, Data_00C_6101
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $670
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ret

; 4 call sites from 4 routines (e.g. Func_00C_72CC, Func_00C_6FCB, Func_00C_66D7, Func_00C_4360)
Func_00C_52D0::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_00C_52D0
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 4 call sites from 4 routines (e.g. Func_00C_72CC, Func_00C_6FCB, Func_00C_66D7, Func_00C_4360)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank0C::
Func_00C_52D9:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_00C_52DD::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00C_52DD
    ld a, $00
    ldh [rSVBK], a
    ret

; 15 call sites from 9 routines (e.g. Func_00C_506C, Func_00C_5050, Func_00C_44C3, Func_00C_501F, ...)
; reads: wD787, wD786
Func_00C_52EC::
    push bc
    ld a, [wD787]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD786]
    add a, b
    pop bc
    ret

; 2 call sites from 2 routines (e.g. Func_00C_5050, Func_00C_4502)
; reads: wD78B, wD78A
Func_00C_52FB::
    push bc
    ld a, [wD78B]
    add a, a
    ld b, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD78A]
    add a, b
    pop bc
    ret

; 5 call sites from 4 routines (e.g. Func_00C_4EC7, Func_00C_4B95, Func_00C_4AA6, Func_00C_4502)
; reads: wD7F5
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD006, wD007
; points at: wC7FC
Func_00C_530A::
    push hl
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall Func_015_68FA
    ld a, [wD7F5]
    cp a, $FF
    jr nz, Jump_00C_532F
    pop hl
    ld a, $FF
    ret

Jump_00C_532F::
    pop hl
    push hl
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    farcall Func_016_5A7E
    ld a, c
    and a, a
    jr nz, Jump_00C_5346
    pop hl
    xor a, a
    ret

Jump_00C_5346::
    pop hl
    ld a, $FE
    ret

; 1 call site from 1 routine (e.g. Func_00C_4801)
; points at: wD79C
Func_00C_534A::
    call Func_00C_5050
    ld de, Data_00C_536A
    add hl, de
    ld a, [hl]

; no direct call (reached through a table, a jump or a vector)
; points at: wD79C
Func_00C_5352:: ; heuristic: target of a pointer table; C0
    ld hl, $54DF
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $02
    ld hl, wD79C

Jump_00C_5363::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_5363
    ret

Data_00C_536A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03136A, $A4
    ds $14, $00
    INCBIN "dwm2-cobi-us.gbc", $031422, $BD
    dw Func_00C_54E9
    dw Func_00C_54EB
    dw Func_00C_54ED
    dw Func_00C_54EF
    dw Func_00C_54F1

; no direct call (reached through a table, a jump or a vector)
; points at: wD79C
Func_00C_54E9:: ; heuristic: target of a pointer table; C0
    ld a, h
    add a, b

; no direct call (reached through a table, a jump or a vector)
; points at: wD79C
Func_00C_54EB:: ; heuristic: target of a pointer table; C0
    ld a, l
    add a, b

; no direct call (reached through a table, a jump or a vector)
; points at: wD79C
Func_00C_54ED:: ; heuristic: target of a pointer table; C0
    ld a, [hl]
    add a, b

; no direct call (reached through a table, a jump or a vector)
; points at: wD79C
Func_00C_54EF:: ; heuristic: target of a pointer table; C0
    ld a, [hl]
    ld a, [hl]

; no direct call (reached through a table, a jump or a vector)
; points at: wD79C
Func_00C_54F1:: ; heuristic: target of a pointer table; C0
    ld a, a
    add a, b

; 1 call site from 1 routine (e.g. Func_00C_4801)
; points at: wD79C
Func_00C_54F3::
    call Func_00C_5050
    ld de, Data_00C_5562
    add hl, de
    ld a, [hl]
    add a, a
    ld hl, $5513
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld b, $04
    ld hl, wD79C

Jump_00C_550C::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_550C
    ret
    dw Func_00C_5523
    dw Func_00C_5527
    dw Func_00C_552B
    dw Func_00C_552F
    dw Func_00C_5533
    dw Func_00C_5537
    dw Func_00C_553B
    dw Func_00C_553F

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_5523:: ; heuristic: target of a pointer table; C0
    add a, c
    add a, b
    add a, b
    add a, b

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_5527:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, b
    add a, b
    add a, b

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_552B:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, c
    add a, b
    add a, b

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_552F:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, b
    add a, b

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_5533:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, c
    add a, b

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_5537:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, d
    add a, b

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_553B:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, d
    add a, c

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_553F:: ; heuristic: target of a pointer table; C0
    add a, d
    add a, d
    add a, d
    add a, d

; 1 call site from 1 routine (e.g. Func_00C_4D6B)
; reads: rSTAT
Func_00C_5543::
    ld hl, Data_00C_555C
    ld b, $80
    ld c, $68
    ld a, b
    ldh [c], a
    ld c, $69
    ld d, $06

Jump_00C_5550::
    ldh a, [rSTAT]
    and a, $02

; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
Func_00C_5554:: ; heuristic: target of a pointer table; C0
    jr nz, Jump_00C_5550
    ld a, [hl+]
    ldh [c], a
    dec d
    jr nz, Jump_00C_5550
    ret

Data_00C_555C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $86, $7D, $FF, $7F, $E1, $7F

Data_00C_5562:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $031562, $79

Data_00C_55DB:: ; heuristic: bank from RAM variable $D7FE; C0
    INCBIN "dwm2-cobi-us.gbc", $0315DB, $FC

Data_00C_56D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $04

Data_00C_56D9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0316D9, $75

Data_00C_574E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1

; no direct call (reached through a table, a jump or a vector)
Func_00C_5756:: ; heuristic: target of a pointer table; C0
    or a, c
    or a, c
    or a, c
    or a, d
    or a, [hl]
    jp Jump_000_2120
    INCBIN "dwm2-cobi-us.gbc", $03175E, $5D
    dw Func_00C_44C3
    dw Func_00C_4645
    dw $4847
    dw Func_00C_4A49
    db $4B, $4C, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6
    dw Func_00C_4DC3
    dw Func_00C_4F4E
    dw Func_00C_5150
    dw Func_00C_5352
    dw Func_00C_5554
    db $B7, $B3, $B4, $B4, $B4, $B4, $B4, $C5, $C3, $BE, $C3, $C6, $B5

Data_00C_57EA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0317EA, $B0

Data_00C_589A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Data_00C_58FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

Data_00C_590A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $C3, $A9, $C3, $D1, $C3, $F9, $C3, $21, $C4, $49, $C4

Data_00C_5916:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $24, $00, $47, $00, $6A, $00, $8D, $00, $B0, $00, $D3, $00, $F6, $00
    db $19, $01, $3C, $01, $5F, $01, $FF, $FF

Data_00C_592E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1B, $00, $43, $00, $67, $00, $85, $00, $A8, $00, $CA, $00, $F1, $00, $11, $01
    db $39, $01, $5C, $01, $75, $01

Data_00C_5944:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $05, $05, $04, $04, $04, $04, $04, $05, $05, $03

Data_00C_594F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00C_5965
    dw Data_00C_596A
    dw Data_00C_5970
    dw Data_00C_5976
    dw Data_00C_597B
    dw Data_00C_5980
    dw Data_00C_5985
    dw Data_00C_598A
    dw Data_00C_598F
    dw Data_00C_5995
    dw Data_00C_599B

Data_00C_5965:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $01

Data_00C_596A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $00

Data_00C_5970:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_5976:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_597B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_5980:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $01

Data_00C_5985:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05

Data_00C_598A:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $02

Data_00C_598F:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_5995:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $05, $05, $01

Data_00C_599B:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $05, $03

Data_00C_599F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE
    db $00, $FE, $00, $FE, $FE, $FE, $00, $FE, $00, $FE, $00, $FE, $01, $00, $00, $FE
    db $00, $FE, $00, $FE, $11, $00, $10, $00, $04, $00, $0B, $00, $15, $00, $13, $00
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $0319E7, $C2
    ds $10, $FE
    db $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE
    db $04, $FE, $94, $00, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $9C, $00, $04, $FE
    db $04, $FE, $04, $FE, $9E, $00, $9F, $00, $96, $00, $04, $FE, $A2, $00, $FE, $FE
    db $FE, $FE, $04, $FE, $99, $00
    ds $10, $FE
    db $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE
    db $05, $FE, $B0, $00, $FE, $FE, $B4, $00, $B5, $00, $05, $FE, $B3, $00, $05, $FE
    db $05, $FE, $B8, $00, $C1, $00, $C5, $00, $B7, $00, $05, $FE, $C4, $00, $05, $FE
    db $C6, $00, $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $031B45, $7C
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $031BD1, $6B
    dw Func_00C_4B01
    dw Func_00C_4201
    dw Func_00C_4B01
    dw Func_00C_4501
    dw $5201
    dw Func_00C_4801
    dw Func_00C_4F01
    db $01, $54, $01, $52, $01, $09, $FE, $58, $01, $09, $FE, $45, $01, $FE, $FE, $FE
    db $FE, $FE, $FE, $0B, $01, $5F, $01, $60, $01, $08, $01, $ED, $00, $63, $01, $62
    db $01, $5F, $01, $66, $01, $EE, $00, $68, $01, $68, $01, $6A, $01, $6B, $01, $65
    db $01, $6B, $01, $6E, $01, $6F, $01, $70, $01, $69, $01, $72, $01
    ds $18, $FE
    db $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE, $00, $FE
    db $00, $FE, $00, $FE, $FE, $FE, $00, $FE, $00, $FE, $00, $FE, $01, $00, $00, $FE
    db $00, $FE, $00, $FE, $11, $00, $10, $00, $04, $00, $0B, $00, $15, $00, $13, $00
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $031CE7, $C2
    ds $10, $FE
    db $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE, $04, $FE
    db $04, $FE, $94, $00, $04, $FE, $8D, $00, $04, $FE, $04, $FE, $04, $FE, $04, $FE
    db $04, $FE, $04, $FE, $9E, $00, $9F, $00, $96, $00, $04, $FE, $A2, $00, $FE, $FE
    db $FE, $FE, $04, $FE, $99, $00
    ds $10, $FE
    db $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE, $05, $FE
    db $05, $FE, $B0

Data_00C_5E12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $FE, $FE, $B4, $00, $B5, $00, $05, $FE, $B3, $00, $05, $FE, $05, $FE, $B8
    db $00, $C1, $00, $C5, $00, $B7, $00, $05, $FE, $C4, $00, $05, $FE, $C6, $00, $B1
    db $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $031E45, $7C
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $031ED1, $6B
    dw Func_00C_4B01
    dw Func_00C_4201
    dw Func_00C_4B01
    dw Func_00C_4501
    dw $5201
    dw Func_00C_4801
    dw Func_00C_4F01
    db $01, $54, $01, $52, $01, $09, $FE, $58, $01, $09, $FE, $45, $01, $FE, $FE, $FE
    db $FE, $FE, $FE, $0B, $01, $5F, $01, $60, $01, $08, $01, $ED, $00, $63, $01, $62
    db $01, $5F, $01, $66, $01, $EE, $00, $68, $01, $68, $01, $6A, $01, $6B, $01, $65
    db $01, $6B, $01, $6E, $01, $6F, $01, $70, $01, $69, $01, $72, $01
    ds $18, $FE

Data_00C_5F9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $FE, $01, $FE, $02, $FE, $03, $FE, $04, $FE, $05, $FE, $06, $FE, $07, $FE
    db $08, $FE, $09, $FE, $FE, $FE, $4A, $00, $48, $00, $32, $01, $2B, $00, $4D, $00
    db $0A, $FE, $24, $01, $11, $00, $5C, $00, $02, $FE, $DC, $00, $07, $FE, $24, $01
    db $17, $00, $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $031FE7, $C1
    ds $11, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $02, $FE, $40, $01, $1D, $01, $D3, $00, $92, $00, $01, $FE, $80, $00
    db $4A, $00, $0D, $00, $9E, $00, $9F, $00, $07, $FE, $0A, $FE, $EA, $00, $FE, $FE
    db $FE, $FE, $B6, $00, $06, $00
    ds $10, $FE
    db $00, $FE

Data_00C_6101:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $FE, $02, $FE, $03, $FE, $04, $FE, $06, $FE, $07, $FE, $08, $FE, $09, $FE
    db $00, $FE, $FE, $FE, $04, $FE, $08, $FE, $49, $01, $06, $FE, $F6, $00, $FB, $00
    db $07, $FE, $07, $FE, $06, $FE, $B7, $00, $DC, $00, $C4, $00, $0A, $FE, $08, $01
    db $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $032145, $7C
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $0321D1, $B6
    ds $1A, $FE
    db $01, $FE, $02, $FE, $03, $FE, $04, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $FE, $FE, $4A, $00, $48, $00, $32, $01, $2B, $00, $4D, $00, $0A, $FE
    db $24, $01, $11, $00, $5C, $00, $02, $FE, $DC, $00, $07, $FE, $24, $01, $17, $00
    db $18, $00
    ds $14, $FE
    INCBIN "dwm2-cobi-us.gbc", $0322E7, $C1
    ds $11, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $05, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $02, $FE, $B2, $00, $02, $FE, $D3, $00, $92, $00, $01, $01, $80, $00
    db $4A, $00, $0D, $00, $9E, $00, $9F, $00, $07, $FE, $0A, $FE, $EA, $00, $FE, $FE
    db $FE, $FE, $B6, $00, $06, $00
    ds $10, $FE
    db $00, $FE, $01, $FE, $02, $FE, $03, $FE, $04, $FE, $06, $FE, $07, $FE, $08, $FE
    db $09, $FE, $00, $FE, $FE, $FE, $04, $FE, $08, $FE, $45, $01, $06, $FE, $F6, $00
    db $FB, $00, $07, $FE, $07, $FE, $06, $FE, $B7, $00, $DC, $00, $C4, $00, $0A, $FE
    db $08, $01, $B1, $00
    ds $12, $FE
    INCBIN "dwm2-cobi-us.gbc", $032445, $7C
    ds $10, $FE
    db $00, $FE

Data_00C_64D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0324D3, $48

Data_00C_651B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03251B, $6C
    ds $18, $FE

; 1 call site from 1 routine (e.g. Func_010_664B)
; reads: wD780
Func_00C_659F::
    ld a, [wD780]
    rst $00
    dw Func_00C_66D7
    dw Func_00C_67E5
    dw Func_00C_680B
    dw Func_00C_6922
    dw Func_00C_694B
    dw Func_00C_6A04
    dw Func_00C_6A21
    dw Func_00C_6A29
    dw Func_00C_6A6A
    dw Func_00C_6A21
    dw Func_00C_6AC4
    dw Func_00C_6AC8
    dw Func_00C_6ACF
    dw Func_00C_6B10
    dw Func_00C_6B18
    dw Func_00C_6B2E
    dw Func_00C_6B78
    dw Func_00C_6BB4
    dw Func_00C_6BE3
    dw Func_00C_6CD0
    dw Func_00C_6D05
    dw Func_00C_6D0D
    dw Func_00C_6922
    dw Func_00C_6D4C
    dw Func_00C_6DC5
    dw Func_00C_6E0C
    dw Func_00C_6E42
    dw Func_00C_6E59
    dw Func_00C_6EB0
    dw Func_00C_6A21
    dw Func_00C_6EB4
    dw Func_00C_6A6A
    dw Func_00C_6A21
    dw Func_00C_6ED3
    dw Func_00C_6ED7
    dw Func_00C_6F26
    dw Func_00C_6F5E
    dw Func_00C_6922
    dw Func_00C_6674
    dw Func_00C_65F3

; no direct call (reached through a table, a jump or a vector)
; reads: wD7FC, hFFC6
; writes: wD7F1, wD7FA, wC920, wC919, wD7FC
Func_00C_65F3:: ; heuristic: target of a pointer table; C0
    ld a, [wD7FC]
    add a, a
    ld hl, Data_00C_75D2
    add_a_to_hl
    ld e, [hl]
    inc hl

; no direct call (reached through a table, a jump or a vector)
; reads: wD7FC, hFFC6
; writes: wD7F1, wD7FA, wC920, wC919, wD7FC
Func_00C_6601:: ; heuristic: target of a pointer table; C0
    ld d, [hl]
    push de
    ld b, $1F
    call Func_00C_73B3
    pop de
    ld b, $00

Jump_00C_660B::
    ld a, [de]
    cp a, $FF
    jp z, Jump_00C_665E
    cp a, l
    jr nc, Jump_00C_6618
    inc de
    inc b
    jr Jump_00C_660B

Jump_00C_6618::
    ld a, [wD7FC]
    add a, a
    ld hl, Data_00C_7602
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a, e
    ld e, a
    jr nc, Jump_00C_662D
    inc d

Jump_00C_662D::
    ld a, [de]
    cp a, $FE
    jr z, Jump_00C_663F
    cp a, $FD
    jr z, Jump_00C_6655
    ld [wD7F1], a
    call Func_00C_755C
    jp Jump_00C_6663

Jump_00C_663F::
    farcall Func_012_689A
    ldh a, [hFFC6]
    and a, a
    jr z, Jump_00C_664E
    ld a, $01
    jr Jump_00C_6663

Jump_00C_664E::
    call Func_00C_75BC
    ld a, $03
    jr Jump_00C_6663

Jump_00C_6655::
    call Func_00C_750F
    call Func_00C_755C
    jp Jump_00C_6663

Jump_00C_665E::
    call Func_00C_75BC
    ld a, $03

Jump_00C_6663::
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    xor a, a
    ld [wD7FC], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD780
; writes: wD780, wC920, wC919, wD7FA, wD7F1, wD7F2
Func_00C_6674:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6688
    cp a, $FF
    jr z, Jump_00C_66C0
    ret

Jump_00C_6688::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD780]
    dec a
    ld [wD780], a
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00C_72CC
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_66C0::
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_00C_6688
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wC82C, wD7FB, wD780
; writes: wD7F0, wD780, wD7FA, wC52D, wC52E, wC52F, wC530, wC920, ...
; points at: wD780, wC364, wScreenTileBuffer, wD1CC, wD000
Func_00C_66D7:: ; heuristic: target of a pointer table; C0
    ld hl, wD780
    ld b, $6F

Jump_00C_66DC::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_66DC
    ld hl, wC364
    ld de, wScreenTileBuffer
    ld bc, $0104
    call Func_00C_52D0
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_66FF
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank0C

Jump_00C_66FF::
    ld a, $0A

; no direct call (reached through a table, a jump or a vector)
; reads: wC82C, wD7FB, wD780
; writes: wD7F0, wD780, wD7FA, wC52D, wC52E, wC52F, wC530, wC920, ...
Func_00C_6701:: ; heuristic: target of a pointer table; C0
    ld [wD7F0], a
    ld a, [wC82C]
    cp a, $05
    jr nc, Jump_00C_6770
    and a, a
    jr nz, Jump_00C_673F
    ld a, [wD7FB]
    cp a, $1F
    jr z, Jump_00C_6717
    ld a, $1D

Jump_00C_6717::
    ld [wD780], a
    ld a, $02
    ld [wD7FA], a
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
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_673F::
    xor a, a
    ld [wD7FA], a
    ld [wStringCategory], a
    ld a, $17
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0A01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank33_649E
    ld a, [wD780]
    inc a
    ld [wD780], a
    jr Jump_00C_67B5

Jump_00C_6770::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1A
    ld [wStringIndex], a
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0A01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank33_649E
    ld hl, vTiles1 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, $18
    ld [wStringIndex], a
    farcall ShowString_Bank33_649E
    ld a, $0B
    ld [wD780], a

Jump_00C_67B5::
    ld a, [wD7FB]
    cp a, $08
    jr z, Jump_00C_67C2
    cp a, $1B
    jr z, Jump_00C_67C2
    jr Jump_00C_67C5

Jump_00C_67C2::
    ld [wD780], a

Jump_00C_67C5::
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
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC3B4
Func_00C_67E5:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_762E
    ld hl, wC3B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call Func_00C_7064
    call Func_00C_7098
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    db $CD

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_00C_6801:: ; heuristic: target of a pointer table; C0
    push af
    ld d, c
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wC82C, wD786, wD780
; writes: wD7FA, wC920, wC919, wC130, wC131, wD780, wD786
Func_00C_680B:: ; heuristic: target of a pointer table; C0
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_00C_6825
    bit 7, a
    jr nz, Jump_00C_683F
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, Jump_00C_684F
    bit 0, a
    jr nz, Jump_00C_685E
    call Func_00C_68D5
    ret

Jump_00C_6825::
    call Func_00C_68F3
    ld a, [wD786]
    and a, a
    jr nz, Jump_00C_6832
    ld a, $03
    jr Jump_00C_6833

Jump_00C_6832::
    dec a

Jump_00C_6833::
    ld [wD786], a
    call Func_00C_68EF
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_683F::
    call Func_00C_68F3
    ld a, [wD786]
    cp a, $03
    jr c, Jump_00C_684C
    xor a, a
    jr Jump_00C_6833

Jump_00C_684C::
    inc a
    jr Jump_00C_6833

Jump_00C_684F::
    ld a, $03
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_685E::
    call Func_00C_68EF
    ld a, [wC82C]
    dec a
    ld b, a
    ld a, [wD786]
    cp a, b
    jr c, Jump_00C_687D
    jr z, Jump_00C_688C
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_687D::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_688C::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD786]
    ld hl, Data_00C_68D1
    add_a_to_hl
    ld a, [hl]
    ld [wC130], a
    ld a, $F0
    ld [wC131], a
    ld a, [wD786]
    ld hl, Data_00C_784F
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Data_00C_68D1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

; 1 call site from 1 routine (e.g. Func_00C_680B)
; reads: wJoypadRepeatTimer, wD787, wD786
; writes: wD787
Func_00C_68D5::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Func_00C_68EF
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, Func_00C_68EF
    cp a, $18
    jr c, Func_00C_68F3
    xor a, a
    ld [wD787], a

; 2 call sites from 1 routine (e.g. Func_00C_680B)
; reads: wD786
Func_00C_68EF::
    ld b, $BB
    jr Jump_00C_68F9

; 2 call sites from 1 routine (e.g. Func_00C_680B)
; reads: wD786
Func_00C_68F3::
    ld b, $C3
    jr Jump_00C_68F9
    db $06, $BC

Jump_00C_68F9::
    ld a, [wD786]
    sla a
    ld hl, Data_00C_691A

; no direct call (reached through a table, a jump or a vector)
Func_00C_6901:: ; heuristic: target of a pointer table; C0
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_691A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $E2, $00, $22, $01, $62, $01

; 1 call site from 1 routine (e.g. Func_00C_6AC8)
; reads: wD780
; writes: wD780, wD7FA
; points at: wC412
Func_00C_6922:: ; heuristic: target of a pointer table; C0
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_00C_7831
    ld hl, wC412
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7FA], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD786, wD7F1, wD780
; writes: wD7F3, wD7F2, wD7F1, wD7FA, wD780, wC920, wC919
Func_00C_694B:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_695F
    cp a, $FF
    jr z, Jump_00C_6978
    ret

Jump_00C_695F::
    call Func_00C_69D5
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_6978::
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_00C_695F
    ld a, [wD786]
    sla a
    ld de, Data_00C_7871
    add a, e
    ld e, a
    jr nc, Jump_00C_698B
    inc d

Jump_00C_698B::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_00C_69BF
    ld a, $01
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_69BF::
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 3 call sites from 3 routines (e.g. Func_00C_6ACF, Func_00C_6A04, Func_00C_694B)
; writes: wD7F1, wD7F2
; points at: wC412
Func_00C_69D5::
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00C_72CC
    ld de, Data_00C_76C7
    ld hl, wC412
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD780
Func_00C_6A04:: ; heuristic: target of a pointer table; C0
    call Func_00C_69D5
    ld c, $04
    ld hl, Data_00C_784F
    call Func_00C_5247
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, $02
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_00C_6A21:: ; heuristic: target of a pointer table; C0
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD780, wD78E
; writes: wD7F3, wD7F2, wD7F1, wD780, wD7FB, wD7FF, wD7FC
Func_00C_6A29:: ; heuristic: target of a pointer table; C0
    call Func_00C_7478
    ld a, [wD786]
    sla a
    ld de, Data_00C_7871
    add a, e
    ld e, a
    jr nc, Jump_00C_6A39
    inc d

Jump_00C_6A39::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall Func_015_683C
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld [wD7FB], a
    ld a, [wD78E]
    ld [wD7FF], a
    ld a, [wD786]
    ld [wD7FC], a
    call Func_00C_6FCB
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD7FF, wD780, wC82C
; writes: wC920, wC919, wD780, wC82C, wD7FA, wD7FC, wD7FB, wD7FF
Func_00C_6A6A:: ; heuristic: target of a pointer table; C0
    ld a, [wD092]
    and a, a
    jr nz, Jump_00C_6AA1
    ld a, [wD7FF]
    cp a, $02
    jr nc, Jump_00C_6A8B
    call Func_00C_704B
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00C_6A8B::
    ld a, [wC82C]
    inc a
    ld [wC82C], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    jr Jump_00C_6AAF

Jump_00C_6AA1::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a

Jump_00C_6AAF::
    xor a, a
    ld [wD7FC], a
    ld [wD7FB], a
    ld [wD7FF], a
    ld a, [wC82C]
    and a, a
    ret z
    ld a, $22
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
Func_00C_6AC4:: ; heuristic: target of a pointer table; C0
    call Func_00C_7478
    ret

; no direct call (reached through a table, a jump or a vector)
Func_00C_6AC8:: ; heuristic: target of a pointer table; C0
    call Func_00C_7098
    call Func_00C_6922
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD780
; writes: wD7FA, wD780, wC920, wC919
Func_00C_6ACF:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6AE3
    cp a, $FF
    jr z, Jump_00C_6AF2
    ret

Jump_00C_6AE3::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_6AF2::
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_00C_6AE3
    call Func_00C_69D5
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_00C_6B10:: ; heuristic: target of a pointer table; C0
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780, wD7FA, wC920, wC919
Func_00C_6B18:: ; heuristic: target of a pointer table; C0
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD7F1, wD7F2, wD780, wC920, wC919
Func_00C_6B2E:: ; heuristic: target of a pointer table; C0
    ld b, $00
    ld c, $03
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_00C_72CC
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [wD7F1], a
    ld a, $0D
    ld [wD7F2], a
    call Func_00C_72CC
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD780]
    sub a, $04
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780, wC920, wC919
; points at: wC3B4
Func_00C_6B78:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_76D6
    ld hl, wC3B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call Func_00C_7098
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_74DB
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
; points at: wC3B4
Func_00C_6BB4:: ; heuristic: target of a pointer table; C0
    ld de, Data_00C_76D6
    ld hl, wC3B4
    ld bc, $1109
    call CopyRectTo20ByteRows_Bank0C
    call Func_00C_7098
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD786, wD780
; writes: wC130, wC131, wD780, wD7FA, wC920, wC919, wD786
Func_00C_6BE3:: ; heuristic: target of a pointer table; C0
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_00C_6BFD
    bit 7, a
    jr nz, Jump_00C_6C17
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, Jump_00C_6C27
    bit 0, a
    jr nz, Jump_00C_6C36
    call Func_00C_6C83
    ret

Jump_00C_6BFD::
    call Func_00C_6CA1
    ld a, [wD786]
    and a, a
    jr nz, Jump_00C_6C0A
    ld a, $03
    jr Jump_00C_6C0B

Jump_00C_6C0A::
    dec a

Jump_00C_6C0B::
    ld [wD786], a
    call Func_00C_6C9D
    ld a, $69
    call QueueSoundEffect
    ret

Jump_00C_6C17::
    call Func_00C_6CA1
    ld a, [wD786]
    cp a, $03
    jr c, Jump_00C_6C24
    xor a, a
    jr Jump_00C_6C0B

Jump_00C_6C24::
    inc a
    jr Jump_00C_6C0B

Jump_00C_6C27::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_6C36::
    call Func_00C_6C9D
    ld a, $69
    call QueueSoundEffect
    ld a, [wD786]
    ld hl, Data_00C_6C7F
    add_a_to_hl
    ld a, [hl]
    ld [wC130], a
    ld a, $F0
    ld [wC131], a
    ld a, [wD786]
    ld hl, Data_00C_7857
    ld b, $BC
    call StoreBAtWordTableEntry_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Data_00C_6C7F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0B, $0A, $1C

; 1 call site from 1 routine (e.g. Func_00C_6BE3)
; reads: wJoypadRepeatTimer, wD787, wD786
; writes: wD787
Func_00C_6C83::
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Func_00C_6C9D
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, Func_00C_6C9D
    cp a, $18
    jr c, Func_00C_6CA1
    xor a, a
    ld [wD787], a

; 2 call sites from 1 routine (e.g. Func_00C_6BE3)
; reads: wD786
Func_00C_6C9D::
    ld b, $BB
    jr Jump_00C_6CA7

; 2 call sites from 1 routine (e.g. Func_00C_6BE3)
; reads: wD786
Func_00C_6CA1::
    ld b, $C3
    jr Jump_00C_6CA7
    db $06, $BC

Jump_00C_6CA7::
    ld a, [wD786]
    sla a
    ld hl, Data_00C_6CC8
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank0C
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00C_6CC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $00, $E1, $00, $21, $01, $61, $01

; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1, wD7F2, wD780, wD78A, wC920, wC919
Func_00C_6CD0:: ; heuristic: target of a pointer table; C0
    ld b, $00
    ld c, $05
    ld hl, $01E0
    ld de, $0014
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_00C_72CC
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, $0D
    ld [wD780], a
    xor a, a
    ld [wD78A], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
Func_00C_6D05:: ; heuristic: target of a pointer table; C0
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD780
; writes: wD78C, wD78A, wD586, wD587, wD780, wD7FA, wC920, wC919
Func_00C_6D0D:: ; heuristic: target of a pointer table; C0
    ld a, [wD786]
    inc a
    inc a
    ld [wD78C], a
    ld a, $02
    ld [wD78A], a
    ld a, [wD786]
    add a, a
    ld hl, Data_00C_6D44
    add_a_to_hl
    ld a, [hl]
    ld [wD586], a
    inc hl
    ld a, [hl]
    ld [wD587], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Data_00C_6D44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E8, $03, $D0, $07, $B8, $0B, $88, $13

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F9, wD7FA, wD586, wD587, wD7F1, wD780
; writes: wD7F1, wD7F2, wD7F3, wD7FA, wD780, wC920, wC919
Func_00C_6D4C:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00C_6D60
    cp a, $FF
    jr z, Jump_00C_6D76
    ret

Jump_00C_6D60::
    ld a, $02
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_6D76::
    ld a, [wD7FA]
    and a, a
    jr nz, Jump_00C_6D60
    ld a, [wD586]
    ld [wD7F1], a
    ld a, [wD587]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_00C_6DAF
    ld a, $01
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_6DAF::
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1, wD7F2, wD780, wD78A, wD78C, wC920, wC919
; points at: wC412
Func_00C_6DC5:: ; heuristic: target of a pointer table; C0
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00C_72CC
    ld de, Data_00C_776F
    ld hl, wC412
    ld bc, $0305
    call CopyRectTo20ByteRows_Bank0C
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call Func_00C_74DB
    ld a, $11
    ld [wD780], a
    xor a, a
    ld [wD78A], a
    ld [wD78C], a

; no direct call (reached through a table, a jump or a vector)
; writes: wC920, wC919
Func_00C_6E02:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD587, wD586, wD780
; writes: wD7F3, wD7F2, wD7F1, wD780, wC920, wC919
Func_00C_6E0C:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wD7F3], a
    ld a, [wD587]
    ld [wD7F2], a
    ld a, [wD586]
    ld [wD7F1], a
    farcall Func_015_683C
    call Func_00C_7098
    call BGMapAddressAtScroll_Bank0C
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD78C, wD780
; writes: wD7FC, wD780, wD7FB
Func_00C_6E42:: ; heuristic: target of a pointer table; C0
    ld a, [wD78C]
    ld [wD7FC], a
    call Func_00C_73C7
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld [wD7FB], a
    call Func_00C_6FCB
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD588, wD780
; writes: wD7FA, wC920, wC919, wD7FB, wD780, wD7FF, wD7F3, wD7F2, ...
Func_00C_6E59:: ; heuristic: target of a pointer table; C0
    ld a, [wD092]
    and a, a
    jr nz, Jump_00C_6EA2
    ld a, [wD588]
    cp a, $02
    jr nc, Jump_00C_6E85
    call Func_00C_703D
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld a, [wD780]
    ld [wD7FB], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00C_6E85::
    call Func_00C_73C6
    xor a, a

Jump_00C_6E89::
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    xor a, a
    ld [wD7FB], a
    ld [wD7FF], a
    ld a, $23
    ld [wD780], a
    ret

Jump_00C_6EA2::
    xor a, a
    ld [wD7F3], a
    ld [wD7F2], a
    ld [wD7F1], a
    ld a, $02
    jr Jump_00C_6E89

; no direct call (reached through a table, a jump or a vector)
Func_00C_6EB0:: ; heuristic: target of a pointer table; C0
    call Func_00C_7402
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD780, wD78E, wD786
; writes: wD780, wD7FB, wD7FF, wD7FC
Func_00C_6EB4:: ; heuristic: target of a pointer table; C0
    call Func_00C_741F
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld [wD7FB], a
    ld a, [wD78E]
    xor a, a
    ld [wD7FF], a
    ld a, [wD786]
    xor a, a
    ld [wD7FC], a
    call Func_00C_6FCB
    ret

; no direct call (reached through a table, a jump or a vector)
Func_00C_6ED3:: ; heuristic: target of a pointer table; C0
    call Func_00C_741F
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wC82C, wD780
; writes: wD7FA, wC920, wC919, wD780
Func_00C_6ED7:: ; heuristic: target of a pointer table; C0
    ld a, [wD092]
    and a, a
    jr nz, Func_00C_6F02
    ld a, [wC82C]
    dec a
    dec a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld a, [wC82C]
    cp a, $01
    jr c, Jump_00C_6F01
    cp a, $05
    jr nc, Jump_00C_6F01
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a

Jump_00C_6F01::
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC82C
; writes: wD7FA, wC920, wC919
Func_00C_6F02:: ; heuristic: target of a pointer table; C0
    ld a, [wC82C]
    cp a, $03
    jr nc, Jump_00C_6F17
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_6F17::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD092, wD780
; writes: wD7FA, wC920, wC919, wD780
Func_00C_6F26:: ; heuristic: target of a pointer table; C0
    ld a, [wD092]
    and a, a
    jr nz, Jump_00C_6F2E
    jr Jump_00C_6F30

Jump_00C_6F2E::
    jr Jump_00C_6F49

Jump_00C_6F30::
    call Func_00C_701C
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ret

Jump_00C_6F49::
    farcall Func_002_470B
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC82C, wC836, hFFC6
; writes: hFFC7, wC836, wD7FA, wC920, wC919, wC892
; points at: wC130, wC60C
Func_00C_6F5E:: ; heuristic: target of a pointer table; C0
    ld a, [wC82C]
    cp a, $01
    jr nz, Jump_00C_6F8B
    ld de, $0188
    call SetFlagBit
    farcall Func_012_6990
    ld a, $03
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld de, $012F
    call SetFlagBit
    jr Jump_00C_6F99

Jump_00C_6F8B::
    farcall Func_012_689A
    ldh a, [hFFC6]
    ld [wC892], a
    and a, a
    jr z, Jump_00C_6FBC

Jump_00C_6F99::
    ld hl, wC130
    ld de, wC60C
    ld b, $0A

Jump_00C_6FA1::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00C_6FAB
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00C_6FA1

Jump_00C_6FAB::
    ld a, $F0
    ld [hl], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00C_6FBC::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 4 call sites from 4 routines (e.g. Func_00C_6EB4, Func_00C_6E42, Func_00C_6A29, Func_00D_74AD)
; reads: wIsCGB
; writes: wD7F1, wD7F2
; points at: wC300, wC29C, wD168, wD104
Func_00C_6FCB::
    ld b, $00
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call Func_00C_72CC
    ld hl, wC300
    ld de, wC29C
    ld bc, $0064
    call Func_00C_52D0
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_6FFF
    ld hl, wD168
    ld de, wD104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank0C

Jump_00C_6FFF::
    call BGMapAddressAtScroll_Bank0C

; no direct call (reached through a table, a jump or a vector)
Func_00C_7002:: ; heuristic: target of a pointer table; C0
    ld bc, $140D
    ld de, $01CC
    call Func_00C_51F5
    call BGMapAddressAtScroll_Bank0C
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00C_51F5
    ret

; 1 call site from 1 routine (e.g. Func_00C_6F26)
; reads: wD7FC
; writes: wC130, wC131
Func_00C_701C::
    farcall Func_002_470B
    ld a, [wD7FC]
    ld hl, Data_00C_7037
    add_a_to_hl
    ld a, [hl]
    ld [wC130], a
    ld a, $F0
    ld [wC131], a
    ret

Data_00C_7037:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $0C, $0C, $0B, $0A, $1C

; 3 call sites from 3 routines (e.g. Func_00C_6E59, Func_012_4420, Func_012_445A)
; reads: wD588, wD7FC
; writes: wD588, wD78C
Func_00C_703D::
    ld a, [wD588]
    inc a
    ld [wD588], a
    ld a, [wD7FC]
    ld [wD78C], a
    ret

; 5 call sites from 3 routines (e.g. Func_00C_6A6A, Func_012_459F, Func_012_46D8)
; reads: wD7FF, wD7FC, wD78E
; writes: wD78E, wD786, wD7FA, wD7FF
Func_00C_704B::
    ld a, [wD7FF]
    inc a
    ld [wD78E], a
    ld a, [wD7FC]
    ld [wD786], a
    ld a, $01
    ld [wD7FA], a
    ld a, [wD78E]
    ld [wD7FF], a
    ret

; 1 call site from 1 routine (e.g. Func_00C_67E5)
; reads: wC82C
; points at: wC3C9, wC3F1, wC419, wC441
Func_00C_7064::
    ld hl, wC3C9
    ld a, [wC82C]
    cp a, $02
    jr c, Jump_00C_7071
    ld a, $AD
    ld [hl], a

Jump_00C_7071::
    ld a, [wC82C]
    cp a, $03
    jr c, Jump_00C_707E
    ld hl, wC3F1
    ld a, $AD
    ld [hl], a

Jump_00C_707E::
    ld a, [wC82C]
    cp a, $04
    jr c, Jump_00C_708B
    ld hl, wC419
    ld a, $AD
    ld [hl], a

Jump_00C_708B::
    ld a, [wC82C]
    cp a, $05
    ret c
    ld hl, wC441
    ld a, $AD
    ld [hl], a
    ret

; 5 call sites from 5 routines (e.g. Func_00C_6E0C, Func_00C_6BB4, Func_00C_6B78, Func_00C_6AC8, ...)
; reads: wC617, wC618, wC619
; writes: wC8C0, wC8C1, wC8C2
; points at: wC370, wC386, wD7F3
Func_00C_7098::
    ld de, Data_00C_777E
    ld hl, wC370
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank0C
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Number24ToPackedBCD
    farcall Func_01E_768E
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_00C_70C7::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00C_70C7
    ret

; 1 call site from 1 routine (e.g. Func_00C_74DB)
; reads: wC6FD
; points at: wD580
Func_00C_70D3::
    ld hl, $0000
    ld de, wD580
    ld c, $00

Jump_00C_70DB::
    push de
    push bc
    ld a, [de]
    add a, l
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop bc
    pop de
    inc de
    inc c
    ld a, [wC6FD]
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_00C_70DB
    ld a, [wC6FD]
    call DivideHLByA
    ld a, h
    and a, a
    ret z
    ld h, $00
    ld l, $FF
    ret

; 1 call site from 1 routine (e.g. Func_00C_74DB)
; reads: hFFC6, wC6FD
; writes: wD580, wD581, wD582, rRAMG2, rRAMB
; points at: wC6FE, wD580
Func_00C_70FE::
    xor a, a
    ld [wD580], a

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wC6FD
; writes: wD581, wD582, rRAMG2, rRAMB
; points at: wC6FE, wD580
Func_00C_7102:: ; heuristic: target of a pointer table; C0
    ld [wD581], a
    ld [wD582], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wC6FE
    ld c, $00

Jump_00C_7116::
    push bc
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $5D
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call LoadSRAMRecordWord
    ld hl, $0000
    call Func_00C_7246
    ld c, l
    ld b, h
    pop hl
    pop de
    push de
    push hl
    push bc
    ld a, [de]
    ld c, $69
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    srl h
    rr l
    ld c, l
    ld b, h
    pop hl
    add hl, bc
    ld a, $32
    call DivideHLByA
    ld a, h
    and a, a
    jr z, Jump_00C_7187
    ld h, $00
    ld l, $63
    jr Jump_00C_7190

Jump_00C_7187::
    ld a, l
    cp a, $64
    jr c, Jump_00C_7190
    ld h, $00
    ld l, $63

Jump_00C_7190::
    pop de
    pop bc
    push bc
    push de
    ld de, wD580
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00C_719D
    inc d

Jump_00C_719D::
    ld a, l
    ld [de], a
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $5D
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    ld hl, $0000
    push hl
    ld a, [de]
    ld c, $61
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $63
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $65
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $67
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $69
    call LoadSRAMRecordWord
    pop hl
    call Func_00C_7246
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld c, $18
    call Multiply8
    ld b, h
    ld c, l
    pop hl
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, $32
    call DivideHLByA
    ld a, h
    and a, a
    jr z, Jump_00C_721B
    ld h, $00
    ld l, $63
    jr Jump_00C_7224

Jump_00C_721B::
    ld a, l
    cp a, $64
    jr c, Jump_00C_7224
    ld h, $00
    ld l, $63

Jump_00C_7224::
    pop de
    pop bc
    push bc
    push de
    ld de, wD580
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_00C_7231
    inc d

Jump_00C_7231::
    ld a, [de]
    add a, l
    ld [de], a
    pop de
    pop bc
    inc de
    inc c
    ld a, [wC6FD]
    ld b, a
    ld a, c
    cp a, b
    jp c, Jump_00C_7116
    xor a, a
    ld [rRAMG2], a
    ret

; 12 call sites from 1 routine (e.g. Func_00C_7102)
; reads: hFFC6, hFFC7
Func_00C_7246::
    ldh a, [hFFC6]
    add a, l
    ld l, a
    ldh a, [hFFC7]
    adc a, h
    ld h, a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wC6FD
; writes: rRAMG2, rRAMB
; points at: wC6FE
Func_00C_724F:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wC6FE
    ld de, $0000
    ld c, $00

Jump_00C_7260::
    push bc
    push hl
    push de
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    pop de
    ldh a, [hFFC6]
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, [wC6FD]
    ld b, a
    ld a, c
    cp a, b
    jr c, Jump_00C_7260
    xor a, a
    ld [rRAMG2], a
    ld a, d
    and a, a
    jr nz, Jump_00C_729E
    ld a, e
    cp a, $DC
    jr nc, Jump_00C_729E
    cp a, $B5
    jr nc, Jump_00C_72A2
    cp a, $8B
    jr nc, Jump_00C_72A6
    cp a, $5B
    jr nc, Jump_00C_72AA
    cp a, $31
    jr nc, Jump_00C_72AE
    xor a, a
    jr Jump_00C_72B0

Jump_00C_729E::
    ld a, $05
    jr Jump_00C_72B0

Jump_00C_72A2::
    ld a, $04
    jr Jump_00C_72B0

Jump_00C_72A6::
    ld a, $03
    jr Jump_00C_72B0

Jump_00C_72AA::
    ld a, $02
    jr Jump_00C_72B0

Jump_00C_72AE::
    ld a, $01

Jump_00C_72B0::
    sla a
    ld de, Func_00C_72C0
    add a, e
    ld e, a
    jr nc, Jump_00C_72BA
    inc d

Jump_00C_72BA::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
Func_00C_72C0:: ; heuristic: follows a terminator; C0
    sub a, b
    ld bc, $0258
    jr nz, Jump_00C_72C9
    or a, b
    inc b
    ld a, b

Jump_00C_72C9::
    dec b
    ld a, b
    dec b

; 7 call sites from 6 routines (e.g. Func_00C_6674, Func_00C_6FCB, Func_00C_6DC5, Func_00C_6CD0, ...)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
Func_00C_72CC::
    push bc
    push hl
    push de
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call Func_00C_52D0
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00C_7311
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank0C
    pop de
    pop hl

Jump_00C_7311::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_00C_7320
    inc d

Jump_00C_7320::
    inc b
    ld a, b
    cp a, c
    jr c, Func_00C_72CC
    ret

; 1 call site from 1 routine (e.g. Func_00C_73F5)
; reads: wD588, wD7FC
; points at: wD589, wD5B1
Func_00C_7326::
    ld hl, wD589
    ld b, $28

Jump_00C_732B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00C_732B
    ld a, [wD588]
    ld b, a
    ld c, $00

Jump_00C_7336::
    push bc
    ld b, $1F
    call Func_00C_73B3

Jump_00C_733C::
    ld de, Data_00C_78FF
    ld a, [wD7FC]
    add a, e
    ld e, a
    jr nc, Jump_00C_7347
    inc d

Jump_00C_7347::
    ld a, [de]
    ld b, a

Jump_00C_7349::
    ld a, l
    cp a, b
    jr c, Jump_00C_7351
    sub a, b
    ld l, a
    jr Jump_00C_733C

Jump_00C_7351::
    push hl
    ld hl, wD589
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr c, Jump_00C_7363
    pop hl
    inc l
    jr Jump_00C_7349

Jump_00C_7363::
    inc a
    ld [hl], a
    pop hl
    ld b, l
    ld hl, Data_00C_7905
    ld a, [wD7FC]
    sla a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, b
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_00C_737E
    inc d

Jump_00C_737E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    pop bc
    push bc
    ld a, b
    sla a
    ld l, a
    sla a
    add a, l
    ld hl, wD5B1
    add_a_to_hl
    ld a, c
    sla a
    add_a_to_hl
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop bc
    inc c
    ld a, c
    cp a, $03
    jp c, Jump_00C_7336
    ld c, $00
    inc b
    ld a, b
    cp a, $03
    jp c, Jump_00C_7336
    ret

; 3 call sites from 3 routines (e.g. Func_00C_6601, Func_00C_750F, Func_00C_7326)
; reads: wC5E7
Func_00C_73B3::
    push bc
    call NextTableByte
    pop bc
    ld a, [wC5E7]
    ld l, a
    rl a
    and a, b
    ld h, a
    ld a, $52
    call DivideHLByA
    ret

; 1 call site from 1 routine (e.g. Func_00C_6E59)
Func_00C_73C6::
    ret

; 1 call site from 1 routine (e.g. Func_00C_6E42)
; reads: wC919, wC91A, wC91B, wD588
; writes: wC91C, wC91D, wC91E, wC917, wC916, wD7FD, hFFB9, wC903, ...
; points at: wD5B1, wCFDD
Func_00C_73C7::
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $1F
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    xor a, a
    ldh [hFFB9], a
    farcall Func_004_449F

; 2 call sites from 2 routines (e.g. Func_012_4420, Func_012_445A)
; reads: wD588
; writes: wC903, wCFDC
; points at: wD5B1, wCFDD
Func_00C_73F5::
    ld a, $04
    ld [wC903], a
    ld a, $02
    ld [wCFDC], a
    call Func_00C_7326

; 1 call site from 1 routine (e.g. Func_00C_6EB0)
; reads: wD588
; points at: wD5B1, wCFDD
Func_00C_7402::
    ld a, [wD588]
    sla a
    ld b, a
    sla a
    add a, b
    ld hl, wD5B1
    add_a_to_hl
    ld de, wCFDD
    ld b, $06

Jump_00C_7418::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_7418
    ret

; 2 call sites from 2 routines (e.g. Func_00C_6ED3, Func_00C_6EB4)
; reads: wC919, wC91A, wC91B, wD78E
; writes: wC91C, wC91D, wC91E, wC917, wC916, wD7FD, hFFB9, wC903, ...
; points at: wCFDD
Func_00C_741F::
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $18
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    xor a, a
    ldh [hFFB9], a
    farcall Func_004_449F

; 2 call sites from 2 routines (e.g. Func_012_459F, Func_012_46D8)
; reads: wD78E
; writes: wC903, wCFDC
; points at: wCFDD
Func_00C_744D::
    ld a, $04
    ld [wC903], a
    ld a, $02
    ld [wCFDC], a
    ld hl, Data_00C_787D
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wD78E]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00C_7467
    inc d

Jump_00C_7467::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wCFDD
    ld b, $06

Jump_00C_7471::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_7471
    ret

; 2 call sites from 2 routines (e.g. Func_00C_6AC4, Func_00C_6A29)
; reads: wC919, wC91A, wC91B, wD786, wD78E
; writes: wC91C, wC91D, wC91E, wC917, wC916, wD7FD, hFFB9, wC903, ...
; points at: wCFDD
Func_00C_7478::
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $18
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    xor a, a
    ldh [hFFB9], a
    farcall Func_004_449F

; 2 call sites from 2 routines (e.g. Func_012_459F, Func_012_46D8)
; reads: wD786, wD78E
; writes: wC903, wCFDC
; points at: wCFDD
Func_00C_74A6::
    ld a, $04
    ld [wC903], a
    ld a, $02
    ld [wCFDC], a
    ld a, [wD786]
    sla a
    ld hl, Data_00C_7897
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wD78E]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00C_74CA
    inc d

Jump_00C_74CA::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wCFDD
    ld b, $06

Jump_00C_74D4::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00C_74D4
    ret

; 2 call sites from 2 routines (e.g. Func_00C_6DC5, Func_00C_6B78)
; writes: wD7FA
Func_00C_74DB::
    call Func_00C_70FE
    call Func_00C_70D3
    ld a, l
    cp a, $50
    jr nc, Jump_00C_74FA
    cp a, $3C
    jr nc, Jump_00C_74FD
    cp a, $28
    jr nc, Jump_00C_7501
    cp a, $1E
    jr nc, Jump_00C_7505
    cp a, $00
    jr nc, Jump_00C_7509
    ld a, $05
    jr Jump_00C_750B

Jump_00C_74FA::
    xor a, a
    jr Jump_00C_750B

Jump_00C_74FD::
    ld a, $01
    jr Jump_00C_750B

Jump_00C_7501::
    ld a, $02
    jr Jump_00C_750B

Jump_00C_7505::
    ld a, $03
    jr Jump_00C_750B

Jump_00C_7509::
    ld a, $04

Jump_00C_750B::
    ld [wD7FA], a
    ret

; 1 call site from 1 routine (e.g. Func_00C_6601)
; writes: wD7F1
Func_00C_750F::
    ld b, $1F
    call Func_00C_73B3
    ld c, l
    ld a, l
    and a, $03
    sla a
    ld hl, Data_00C_7538
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, c

Jump_00C_7526::
    cp a, $07
    jr c, Jump_00C_752E
    sub a, $07
    jr Jump_00C_7526

Jump_00C_752E::
    add a, e
    ld e, a
    jr nc, Jump_00C_7533
    inc d

Jump_00C_7533::
    ld a, [de]
    ld [wD7F1], a
    ret

Data_00C_7538:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $75, $47, $75, $4E, $75, $55, $75, $40, $41, $42, $43, $44, $45, $46, $47
    dw Func_00C_4948
    dw Func_00C_4B4A
    dw $4D4C
    dw Func_00C_4F4E
    dw Func_00C_5150
    dw Func_00C_5352
    db $5A, $5B, $5C, $5D, $5E, $5F, $60, $61

; 2 call sites from 1 routine (e.g. Func_00C_6601)
; reads: wD7F1
; writes: wD7F1
; points at: wC61D
Func_00C_755C::
    ld hl, wC61D
    ld c, $18

Jump_00C_7561::
    ld a, [hl]
    and a, a
    jr z, Jump_00C_757E
    cp a, $FF
    jr z, Jump_00C_757E
    inc hl
    dec c
    jr nz, Jump_00C_7561
    ld a, [wD7F1]
    push af
    call Func_00C_75BC
    pop af
    ld [wD7F1], a
    call Func_00C_7587
    ld a, $02
    ret

Jump_00C_757E::
    ld a, [wD7F1]
    ld [hl], a
    call Func_00C_7587
    xor a, a
    ret

; 2 call sites from 1 routine (e.g. Func_00C_755C)
; reads: wD7F1
; points at: wC140
Func_00C_7587::
    ld de, Data_008_403C
    ld b, $08
    call Func_000_18D6
    ld c, l
    ld b, h
    ld a, [wD7F1]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld l, c
    ld h, b
    add hl, de
    ld e, l
    ld d, h
    ld b, $08
    call Func_000_18D6
    ld e, l
    ld d, h
    ld hl, wC140

Jump_00C_75AA::
    ld b, $08
    call ReadByteInBank
    ld a, c
    cp a, $F0
    jr z, Jump_00C_75B8
    ld [hl+], a
    inc de
    jr Jump_00C_75AA

Jump_00C_75B8::
    ld a, $F0
    ld [hl+], a
    ret

; 3 call sites from 2 routines (e.g. Func_00C_755C, Func_00C_6601)
; writes: wD7F1, wD7F2, wD7F3
Func_00C_75BC::
    ld hl, $1770
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_01C_45B0
    ret

Data_00C_75D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DE, $75, $DE, $75, $DE, $75, $E7, $75, $F0, $75, $F9, $75, $19, $23, $2D, $37
    db $41, $4B, $5F, $64, $FF, $14, $1F, $2A, $35, $40, $4B, $5A, $64, $FF, $0F, $17
    db $1F, $27, $2F, $37, $50, $64, $FF, $0A, $15, $20, $2B, $36, $41, $50, $64, $FF

Data_00C_7602:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $76, $0E, $76, $0E, $76, $16, $76, $1E, $76, $26, $76, $01, $53, $05, $0C
    db $24, $0B, $1C, $44, $02, $18, $0F, $10, $13, $15, $45, $FE, $03, $0D, $11, $12
    db $17, $2C, $FD, $FE, $23, $2C, $0D, $0E, $17, $FD, $1E, $FE

Data_00C_762E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03362E, $99

Data_00C_76C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $E0, $BF, $B7, $C3, $C3, $B7, $E0, $BF, $B7, $B4, $B4, $B5

Data_00C_76D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0336D6, $99

Data_00C_776F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $B7, $BF, $C3, $B7, $C3, $C3, $B7, $BF, $C3, $B7, $B4, $B4, $B5

Data_00C_777E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03377E, $B3

Data_00C_7831:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $AE, $AF, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_00C_784F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

Data_00C_7857:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4, $8D, $C3, $8F, $C3, $91, $C3, $8D, $C3
    db $8F, $C3, $91, $C3, $B5, $C3, $B7, $C3, $B9, $C3

Data_00C_7871:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $00, $F4, $01, $E8, $03, $88, $13, $02, $04, $08, $10

Data_00C_787D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7F, $78, $85, $78, $8B, $78, $91, $78, $83, $00, $84, $00, $83, $00, $85, $00
    db $86, $00, $87, $00, $88, $00, $89, $00, $88, $00

Data_00C_7897:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $033897, $68

Data_00C_78FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $27, $27, $27, $27, $27, $27

Data_00C_7905:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $033905, $8F
    dw Func_00C_6601
    dw Func_00C_6701
    dw Func_00C_6801
    dw Func_00C_6901
    INCBIN "dwm2-cobi-us.gbc", $03399C, $5A
    dw Func_00C_4102
    dw Func_00C_4202
    dw Func_00C_4302
    dw Func_00C_4402
    dw Func_00C_4502
    db $02, $FF, $01, $00, $02, $01, $02, $02, $02, $03, $02, $04, $02, $46, $02, $47
    db $02, $48, $02, $49, $02, $4A, $02, $4B, $02, $4C
    dw Func_00C_4D02
    dw Func_00C_4E02
    dw Func_00C_4F02
    dw Func_00C_5002
    db $02, $51, $02, $52, $02, $53, $02, $54, $02, $55, $02, $56, $02, $57, $02, $67
    db $02, $68, $02, $69, $02, $6A, $02, $6B, $02, $6C, $02, $6D
    dw Func_00C_6E02
    dw Func_00C_6F02
    dw Func_00C_7002
    dw Func_00C_7102
    INCBIN "dwm2-cobi-us.gbc", $033A46, $201
    ds $3B9, $00
