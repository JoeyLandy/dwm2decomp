SECTION "Bank 1E", ROMX[$4000], BANK[$1E]
    db $1E

; 2 call sites from 2 routines (e.g. Func_00D_7115, Func_010_65F0)
; reads: wD788
Func_01E_4001::
    ld a, [wD788]
    rst $00
    dw Jump_01E_400D
    dw Jump_01E_403F
    dw Jump_01E_4046
    dw Jump_01E_4062

Jump_01E_400D::
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_01E_7428
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_402B
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_01E_7431

Jump_01E_402B::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

Jump_01E_403F::
    farcall Func_015_4001
    ret

Jump_01E_4046::
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

Jump_01E_4062::
    farcall Func_015_4001
    ret

; 18 call sites from 16 routines (e.g. Func_00D_4B41, Func_00D_711C, Func_00D_74FC, Func_010_65E9, ...)
; reads: wD780
Func_01E_4069::
    ld a, [wD780]
    rst $00
    dw Jump_01E_408B
    dw Jump_01E_40D1
    dw Jump_01E_412A
    dw Jump_01E_422D
    dw Jump_01E_4234
    dw Jump_01E_4C78
    dw Jump_01E_506C
    dw Jump_01E_568E
    dw Jump_01E_65B8
    dw Jump_01E_5B50
    dw Jump_01E_60F4
    dw Jump_01E_6298
    dw Jump_01E_600F
    dw Jump_01E_625A
    dw Jump_01E_5FAA

Jump_01E_408B::
    ld hl, wD780
    ld bc, $006F

Jump_01E_4091::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01E_4091
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_01E_7428
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_40B6
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_01E_7431

Jump_01E_40B6::
    ld a, $03
    ld [wD7F0], a
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD7FC], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_40D1::
    ld a, [wD781]
    rst $00
    dw Jump_01E_40DD
    dw Jump_01E_40E4
    dw Jump_01E_40F2
    dw Jump_01E_4100

Jump_01E_40DD::
    farcall Func_01D_6C8A
    ret

Jump_01E_40E4::
    ld hl, $778C
    ld de, $77CE
    call Func_01E_7454
    ld hl, wD781
    inc [hl]
    ret

Jump_01E_40F2::
    farcall Func_01D_5E79
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4100::
    ld de, $79C8
    ld hl, wC364
    ld bc, $0B0B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    farcall Func_01D_5E3F
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_01E_412A::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_01E_4146
    bit 7, a
    jr nz, Jump_01E_4174
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_01E_418E
    bit 1, a
    jp nz, Jump_01E_41D0
    call Func_01E_41DF
    ret

Jump_01E_4146::
    call Func_01E_41FD
    ld a, [wD786]
    and a, a
    jr nz, Jump_01E_415D
    ld a, $04
    ld [wD786], a
    call Func_01E_41DF
    ld a, $69
    call StoreWC60B
    ret

Jump_01E_415D::
    dec a

Jump_01E_415E::
    ld [wD786], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    call Func_01E_41F9
    ld a, $69
    call StoreWC60B
    ret

Jump_01E_4174::
    call Func_01E_41FD
    ld a, [wD786]
    cp a, $04
    jr c, Jump_01E_418B
    xor a, a
    ld [wD786], a
    call Func_01E_41DF
    ld a, $69
    call StoreWC60B
    ret

Jump_01E_418B::
    inc a
    jr Jump_01E_415E

Jump_01E_418E::
    ld a, $69
    call StoreWC60B
    call Func_01E_4201
    ld c, $00

Jump_01E_4198::
    ld a, c
    ld b, $C3
    ld hl, $7880
    push bc
    push hl
    call Func_01E_741A
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01E_4198
    ld a, [wD786]
    cp a, $04
    jr z, Jump_01E_41D0
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_41D0::
    ld a, $04
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 3 call sites from 1 routine (e.g. Func_01E_4069)
; reads: wC564, wD787, wD786
; writes: wD787
Func_01E_41DF::
    ld a, [wC564]
    cp a, $14
    jr c, Func_01E_41F9
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, Func_01E_41F9
    cp a, $18
    jr c, Func_01E_41FD
    xor a, a
    ld [wD787], a

; 1 call site from 1 routine (e.g. Func_01E_4069)
; reads: wD786
Func_01E_41F9::
    ld b, $BB
    jr Jump_01E_4203

; 2 call sites from 1 routine (e.g. Func_01E_4069)
; reads: wD786
Func_01E_41FD::
    ld b, $C3
    jr Jump_01E_4203

; 1 call site from 1 routine (e.g. Func_01E_4069)
; reads: wD786
Func_01E_4201::
    ld b, $BC

Jump_01E_4203::
    ld a, [wD786]
    add a, a
    ld hl, $4223
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

Jump_01E_422D::
    farcall Func_01D_6B32
    ret

Jump_01E_4234::
    ld a, [wD781]
    rst $00
    dw Jump_01E_429A
    dw Jump_01E_4371
    dw Jump_01E_439E
    dw Jump_01E_43C2
    dw Jump_01E_43E0
    dw Jump_01E_440A
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_44A1
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4720
    dw Jump_01E_473B
    dw Jump_01E_47B2
    dw Jump_01E_4831
    dw Jump_01E_4890
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Func_01E_49EA
    dw Func_01E_4A32
    dw Jump_01E_4A39
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_4A74
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4B05
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4B42
    dw Jump_01E_4B5D
    dw Jump_01E_4BE1
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42

Jump_01E_429A::
    ld a, [wD782]
    and a, a
    jp z, Jump_01E_42A9
    cp a, $01
    jp z, Func_01E_42C6
    jp Jump_01E_430D

Jump_01E_42A9::
    ld de, $4333
    ld hl, wC364
    ld bc, $0807
    call Func_01E_748E
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_6074)
; reads: wC6FD, wD782
; writes: rRAMG2, rRAMB, wC8D9, wD782
; points at: wC6FE
Func_01E_42C6::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld b, $00

Jump_01E_42D1::
    push bc
    ld hl, wC6FE
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    pop bc
    push bc
    ld a, b
    add a, a
    ld hl, $436B
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call Func_000_21A1
    pop bc
    inc b
    ld a, [wC6FD]
    cp a, b
    jr nz, Jump_01E_42D1
    xor a, a
    ld [rRAMG2], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_430D::
    farcall Func_01D_5E79
    ld hl, wC378
    ld c, $28
    call Func_01E_7646
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $00, $8D, $50, $8D, $A0, $8D

Jump_01E_4371::
    ld a, [wD7AB]
    ld hl, wD789
    add_a_to_hl
    ld a, [hl]
    ld b, a
    push af
    call Func_01E_75C5
    ld de, $795C
    ld hl, wC36C
    ld bc, $0C09
    call Func_01E_748E
    pop af
    ld b, a
    ld [wD7F1], a
    call Func_01E_75EB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_439E::
    ld hl, vTiles1 + $270
    ld bc, $0901
    call Func_000_1881
    ld hl, vTiles1 + $780
    ld bc, $0501
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wD781
    inc [hl]
    ret

Jump_01E_43C2::
    ld a, [wD7AB]
    ld hl, wD789
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_43E0::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD7AB]
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_440A::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_65F6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_4426
    cp a, $FE
    jr z, Jump_01E_442C
    cp a, $FF
    jr z, Jump_01E_4442
    ret

Jump_01E_4426::
    ld a, $01
    ld [wD781], a
    ret

Jump_01E_442C::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4442::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $05
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4463::
    ld c, $0D
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call Func_01E_75F2
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_447F::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4493::
    ld hl, $7810
    ld de, $7824
    call Func_01E_7454
    ld hl, wD781
    inc [hl]
    ret

Jump_01E_44A1::
    ld a, $03
    ld [wD781], a
    ld a, $01
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_44B5::
    ld hl, $7864
    ld de, $7872
    call Func_01E_7454
    ld hl, wD781
    inc [hl]
    ret

Jump_01E_44C3::
    ld de, $44EF
    ld hl, wC410
    ld bc, $0805
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7AD], a
    ld [wD7AE], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD7AF, wD7AB
; writes: wD7B0, wD7AF, wD7B1, wD7AB
Func_01E_44EF:: ; heuristic: follows a terminator; C0
    or a, b
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, c
    or a, d
    or a, [hl]
    jp Jump_01E_7170
    db $72, $73, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $74, $75
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_4517::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_01E_4533
    bit 7, a
    jr nz, Jump_01E_454D
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_01E_455D
    bit 1, a
    jp nz, Jump_01E_4687
    call Func_01E_469D
    ret

Jump_01E_4533::
    call Func_01E_46BB
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_01E_4540
    ld a, $01
    jr Jump_01E_4541

Jump_01E_4540::
    dec a

Jump_01E_4541::
    ld [wD7AD], a
    call Func_01E_46B7
    ld a, $69
    call StoreWC60B
    ret

Jump_01E_454D::
    call Func_01E_46BB
    ld a, [wD7AD]
    cp a, $01
    jr c, Jump_01E_455A
    xor a, a
    jr Jump_01E_4541

Jump_01E_455A::
    inc a
    jr Jump_01E_4541

Jump_01E_455D::
    ld a, $69
    call StoreWC60B
    call Func_01E_46BF
    ld a, [wD7AD]
    and a, a
    jp nz, Jump_01E_460F
    ld a, [wD780]
    cp a, $07
    jp z, Jump_01E_45EC
    cp a, $04
    jr z, Jump_01E_45B1
    cp a, $05
    jr z, Jump_01E_457C

Jump_01E_457C::
    ld a, [wD781]
    cp a, $13
    jr c, Jump_01E_45A3
    cp a, $42
    jr c, Jump_01E_4595
    ld a, $05
    ld [wD7B2], a
    ld a, $44
    ld [wD7B3], a
    ld a, $09
    jr Jump_01E_45D2

Jump_01E_4595::
    ld a, $05
    ld [wD7B2], a
    ld a, $2C
    ld [wD7B3], a
    ld a, $08
    jr Jump_01E_45D2

Jump_01E_45A3::
    ld a, $05
    ld [wD7B2], a
    ld a, $12
    ld [wD7B3], a
    ld a, $09
    jr Jump_01E_45D2

Jump_01E_45B1::
    ld a, [wD781]
    cp a, $10
    jr nc, Jump_01E_45C6
    ld a, $04
    ld [wD7B2], a
    ld a, $0C
    ld [wD7B3], a
    ld a, $08
    jr Jump_01E_45D2

Jump_01E_45C6::
    ld a, $04
    ld [wD7B2], a
    ld a, $25
    ld [wD7B3], a
    ld a, $09

Jump_01E_45D2::
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld [wD7FA], a
    call Func_01E_7745
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_45EC::
    ld a, [wD781]
    cp a, $16
    jr nz, Jump_01E_4601
    ld a, $07
    ld [wD7B2], a
    ld a, $16
    ld [wD7B3], a
    ld a, $0A
    jr Jump_01E_45D2

Jump_01E_4601::
    ld a, $07
    ld [wD7B2], a
    ld a, $2E
    ld [wD7B3], a
    ld a, $0B
    jr Jump_01E_45D2

Jump_01E_460F::
    ld a, [wD780]
    cp a, $07
    jr nz, Jump_01E_465C
    ld a, [wD7B7]
    and a, a
    jr nz, Jump_01E_4655
    ld a, [wD7AB]
    and a, a
    jr nz, Jump_01E_465C
    ld a, [wC6FD]
    cp a, $02
    jr nc, Jump_01E_465C
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld a, [wC6FE]
    cp a, b
    jr nz, Jump_01E_465C
    ld a, $03
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4655::
    ld a, [wD781]
    inc a
    ld [wD781], a

Jump_01E_465C::
    ld a, [wD780]
    cp a, $04
    jr nz, Jump_01E_4670
    ld a, [wD781]
    cp a, $0C
    jr nz, Jump_01E_4670
    farcall Func_002_470B

Jump_01E_4670::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4687::
    ld a, $02
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_44EF)
; reads: wC564, wD7AE, wD7AD
; writes: wD7AE
Func_01E_469D::
    ld a, [wC564]
    cp a, $14
    jr c, Func_01E_46B7
    ld a, [wD7AE]
    inc a
    ld [wD7AE], a
    cp a, $10
    jr c, Func_01E_46B7
    cp a, $18
    jr c, Func_01E_46BB
    xor a, a
    ld [wD7AE], a

; 1 call site from 1 routine (e.g. Func_01E_44EF)
; reads: wD7AD
Func_01E_46B7::
    ld b, $BB
    jr Jump_01E_46C1

; 2 call sites from 1 routine (e.g. Func_01E_44EF)
; reads: wD7AD
Func_01E_46BB::
    ld b, $C3
    jr Jump_01E_46C1

; 1 call site from 1 routine (e.g. Func_01E_44EF)
; reads: wD7AD
Func_01E_46BF::
    ld b, $BC

Jump_01E_46C1::
    ld a, [wD7AD]
    add a, a
    ld hl, $46E1
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $2D, $01, $6D, $01

; 5 call sites from 2 routines (e.g. Func_01E_4A32, Func_01E_46E5)
; reads: wD7AB, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC410
Func_01E_46E5::
    ld de, $4718
    ld hl, wC410
    ld bc, $0801
    call Func_01E_748E
    ld c, $04
    ld hl, $028C
    ld de, $00C0
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_01E_75F2
    ld a, [wD7AB]
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_4720::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $05
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_473B::
    ld a, [wD7AB]
    ld hl, wD789
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, $01
    ldh [hFFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ldh [hFFC6], a
    ld a, [hl]
    ld c, $55
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ld [rRAMG2], a
    ld a, [wC6FD]
    and a, a
    jr z, Jump_01E_4774
    dec a
    ld [wC6FD], a

Jump_01E_4774::
    farcall Func_01D_5E79
    ld hl, wD789
    ld de, wC6FE
    ld b, $03

Jump_01E_4782::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01E_4782
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_01E_46E5
    ld a, $06
    ld [wD781], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AC], a
    ld [wD7AE], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_47B2::
    farcall Func_01D_6D70
    ld d, c
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
    ld c, $00

Jump_01E_47C7::
    ld a, [hl]
    cp a, $01
    jr z, Jump_01E_47DA

Jump_01E_47CC::
    ld a, $A5
    add_a_to_hl
    inc c
    ld a, c
    cp a, d
    jr c, Jump_01E_47C7
    jr Jump_01E_47EC

Jump_01E_47DA::
    push hl
    ld a, $6E
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, Jump_01E_47E9
    pop hl
    jr Jump_01E_47CC

Jump_01E_47E9::
    pop hl
    jr Jump_01E_4817

Jump_01E_47EC::
    xor a, a
    ld [wD7FA], a
    ld a, $01
    ld [wD780], a
    ld a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD786]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4817::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4831::
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call StoreWC60B
    ld de, $4872
    ld hl, wC412
    ld bc, $0605
    call Func_01E_748E
    ld a, [wD786]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ret
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $F3, $A6, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Jump_01E_4890::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01E_48A4
    cp a, $FF
    jr z, Jump_01E_48C4
    ret

Jump_01E_48A4::
    call Func_01E_48E3
    ld a, $01
    ld [wD7FA], a
    ld a, $01
    ld [wD780], a
    ld a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_48C4::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_01E_48A4
    call Func_01E_48E3
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 1 routine (e.g. Func_01E_46E5)
; reads: wIsCGB, rSVBK
; writes: rSVBK
; points at: wC412, wC246, wD27A, wD0AE
Func_01E_48E3::
    ld hl, wC412
    ld de, wC246
    ld c, $05
    call Func_01E_4918
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_490B
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wD27A
    ld de, wD0AE
    ld c, $05
    call Func_01E_4918
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

Jump_01E_490B::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ret

; 2 call sites from 1 routine (e.g. Func_01E_48E3)
Func_01E_4918::
    push bc
    push hl
    push de
    ld bc, $0006
    call Func_01E_7428
    pop de
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01E_492F
    inc d

Jump_01E_492F::
    dec c
    jr nz, Func_01E_4918
    ret

Jump_01E_4933::
    ld de, $495A
    ld hl, wC364
    ld bc, $080B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [wD7AF], a
    ld [wD7AE], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $07895A, $58

Jump_01E_49B2::
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call Func_000_1881
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld hl, vTiles1 + $700
    ld bc, $0501
    call Func_000_1881
    ld hl, vTiles1 + $4E0
    ld bc, $0201
    call Func_000_1881
    ld de, $7A41
    ld hl, wC364
    ld bc, $080B
    call Func_01E_748E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 4 call sites from 1 routine (e.g. Func_01E_5C63)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC42E, wC42F
Func_01E_49EA::
    farcall Func_01D_5ECE
    jr Func_01E_49F8

Jump_01E_49F2::
    farcall Func_01D_5F2D

; 5 call sites from 2 routines (e.g. Func_01E_5C63, Func_01E_6074)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC42E, wC42F
Func_01E_49F8::
    call Func_01E_7163
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01E_4A2A
    ld de, $0142
    call Func_01E_7530
    ld hl, wC42E
    call Func_01E_7556
    ld de, $0143
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    call Func_01E_7564
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    call Func_01E_759A

Jump_01E_4A2A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_5C63)
Func_01E_4A32::
    farcall Func_01F_5C15
    ret

Jump_01E_4A39::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    push af
    call Func_01E_75C5
    ld de, $795C
    ld hl, wC36C
    ld bc, $0C09
    call Func_01E_748E
    pop af
    ld b, a
    ld [wD7F1], a
    call Func_01E_75EB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4A5E::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4A74::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_4A98
    cp a, $FC
    jr z, Jump_01E_4A98
    cp a, $FD
    jr z, Jump_01E_4AD7
    cp a, $FE
    jr z, Jump_01E_4AA1
    cp a, $FF
    jr z, Jump_01E_4AA9
    ret

Jump_01E_4A98::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_01E_4AA1::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4AA9::
    ld a, [wD781]
    add a, $08
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4AD7::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01E_4AE0::
    ld hl, $7838
    ld de, $784E
    call Func_01E_7454
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4AF1::
    farcall Func_01D_62AD
    farcall Func_01D_5E79
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4B05::
    ld de, $79C8
    ld hl, wC364
    ld bc, $0B0B
    call Func_01E_748E
    ld a, [wD786]
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    farcall Func_01D_5E3F
    ld a, $11
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4B42::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $1B
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4B5D::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC6FE]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF
    ld de, wC130
    ld c, $00

Jump_01E_4B7B::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_4B89
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01E_4B7B

Jump_01E_4B89::
    ld a, $90
    ld [de], a
    inc de
    ld a, $3A
    ld [de], a
    inc de
    ld a, $2C
    ld [de], a
    inc de
    ld a, $37
    ld [de], a
    inc de
    ld a, $2B
    ld [de], a
    inc de
    ld a, $90
    ld [de], a
    inc de
    push de
    call Func_01E_76EB
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    pop de
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF

Jump_01E_4BB4::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_4BBE
    ld [de], a
    inc de
    inc hl
    jr Jump_01E_4BB4

Jump_01E_4BBE::
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4BE1::
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, $01
    ldh [hFFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ldh [hFFC6], a
    ld a, [hl]
    ld c, $55
    ld b, $01
    call Func_01E_76DA
    call Func_01E_76EB
    push hl
    ld a, $02
    ldh [hFFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ld [rRAMG2], a
    pop hl
    ld a, [hl]
    ld [wC6FE], a
    farcall Func_01D_5E79
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_01E_46E5
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

Jump_01E_4C42::
    ld de, $79C8
    ld hl, wC364
    ld bc, $0B0B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    farcall Func_01D_5E3F
    xor a, a
    ld [wD781], a
    ld a, $02
    ld [wD780], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4C78::
    ld a, [wD781]
    rst $00
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Func_01E_49EA
    dw Func_01E_4A32
    dw Jump_01E_4A39
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_4A74
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4D1C
    dw Jump_01E_4D37
    dw Jump_01E_4D5B
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42
    dw Jump_01E_4831
    dw Jump_01E_4890
    dw Jump_01E_429A
    dw Jump_01E_4371
    dw Jump_01E_439E
    dw Jump_01E_43C2
    dw Jump_01E_43E0
    dw Jump_01E_4DB5
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4E0E
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4E4B
    dw Jump_01E_4F9D
    dw Jump_01E_4E66
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Func_01E_49EA
    dw Func_01E_4A32
    dw Jump_01E_4A39
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_4F31
    dw Jump_01E_4EA3
    dw Jump_01E_4EC3
    dw Jump_01E_4ED4
    dw Jump_01E_4FAC
    dw Jump_01E_4371
    dw Jump_01E_439E
    dw Jump_01E_43C2
    dw Jump_01E_4EFE
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Func_01E_46E5
    dw Jump_01E_4FBB
    dw Jump_01E_4FD6
    dw Jump_01E_4FF7
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42

Jump_01E_4D1C::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $08
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4D37::
    farcall Func_002_470B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4D5B::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_76EB
    ld a, $02
    ldh [hFFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    ld a, [wC6FD]
    ld hl, wC6FE
    add_a_to_hl
    push hl
    call Func_01E_76EB
    ld a, [hl]
    pop hl
    ld [hl], a
    ld a, [wC6FD]
    inc a
    ld [wC6FD], a
    xor a, a
    ld [rRAMG2], a
    farcall Func_01D_5E79
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_01E_46E5
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

Jump_01E_4DB5::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_65F6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_4DD1
    cp a, $FE
    jr z, Jump_01E_4DD7
    cp a, $FF
    jr z, Jump_01E_4DED
    ret

Jump_01E_4DD1::
    ld a, $21
    ld [wD781], a
    ret

Jump_01E_4DD7::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4DED::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $05
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4E0E::
    ld de, $79C8
    ld hl, wC364
    ld bc, $0B0B
    call Func_01E_748E
    ld a, [wD786]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    farcall Func_01D_5E3F
    ld a, $1E
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4E4B::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $25
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4E66::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld hl, wD789
    add_a_to_hl
    ld a, [hl]
    ld [wD7B4], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    farcall Func_01D_5ECE
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret
    db $C9

Jump_01E_4EA3::
    ld de, $7A99
    ld hl, wC364
    ld bc, $080B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4EC3::
    ld hl, $7838
    ld de, $784E
    call Func_01E_7454
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4ED4::
    ld de, $7AF1
    ld hl, wC364
    ld bc, $080B
    call Func_01E_748E
    ld a, [wD7B5]
    ld [wD7AB], a
    xor a, a
    ld [wD7AF], a
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4EFE::
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    ld a, $25
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    farcall Func_01D_5E79
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4F31::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_4F55
    cp a, $FC
    jr z, Jump_01E_4F55
    cp a, $FD
    jr z, Jump_01E_4F94
    cp a, $FE
    jr z, Jump_01E_4F5E
    cp a, $FF
    jr z, Jump_01E_4F66
    ret

Jump_01E_4F55::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_01E_4F5E::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_4F66::
    ld a, [wD781]
    add a, $09
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4F94::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01E_4F9D::
    call Func_01E_46E5
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    ret

Jump_01E_4FAC::
    ld a, [wD782]
    and a, a
    jp z, Jump_01E_42A9
    cp a, $01
    jp z, Func_01E_42C6
    jp Jump_01E_430D

Jump_01E_4FBB::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $39
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_4FD6::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF
    ld de, wC130
    ld c, $00
    jp Jump_01E_4B7B

Jump_01E_4FF7::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_76EB
    ld a, $02
    ldh [hFFC6], a
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    ld a, $01
    ldh [hFFC6], a
    ld a, [wD7B4]
    ld c, $00
    ld b, $01
    call Func_01E_76DA
    xor a, a
    ldh [hFFC6], a
    ld a, [wD7B4]
    ld c, $55
    ld b, $01
    call Func_01E_76DA
    ld a, [wD7B5]
    ld hl, wC6FE
    add_a_to_hl
    push hl
    call Func_01E_76EB
    ld a, [hl]
    pop hl
    ld [hl], a
    xor a, a
    ld [wD7B5], a
    ld [wD7B4], a
    xor a, a
    ld [rRAMG2], a
    farcall Func_01D_5E79
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_01E_46E5
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

Jump_01E_506C::
    ld a, [wD781]
    rst $00
    dw Jump_01E_50AE
    dw Jump_01E_50BE
    dw Jump_01E_512E
    dw Jump_01E_51E6
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Jump_01E_49F2
    dw Func_01E_4A32
    dw Jump_01E_525F
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_5290
    dw Jump_01E_5300
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_536A
    dw Jump_01E_540F
    dw Jump_01E_5429
    dw Jump_01E_5430
    dw Jump_01E_54D6
    dw Jump_01E_5518
    dw Jump_01E_556A
    dw Jump_01E_557C
    dw Jump_01E_559E
    dw Jump_01E_5300
    dw Jump_01E_55F3
    dw Jump_01E_5654

Jump_01E_50AE::
    ld hl, $793C
    ld de, $791C
    call Func_01E_7454
    ld a, [wD781]
    inc a
    ld [wD781], a

Jump_01E_50BE::
    ld de, $7BBE
    ld hl, wC40B
    ld bc, $0D05
    call Func_01E_748E
    ld a, $6C
    call StoreWC60B
    farcall Func_01D_5F2D
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC429
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD7B9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC451
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD786]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [wD7B7], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_512E::
    farcall Func_01D_642A
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FD
    ret z
    cp a, $FE
    jr z, Jump_01E_5145
    cp a, $FF
    jr z, Jump_01E_5162
    ret

Jump_01E_5145::
    ld a, $03
    ld [wD7FA], a
    xor a, a
    ld [wD7B7], a
    ld [wD7B8], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5162::
    ld a, [wD7B7]
    and a, a
    jr nz, Jump_01E_5199
    call Func_01E_7778
    ld a, [wD7B7]
    ld b, $BC
    ld hl, $788A
    call Func_01E_741A
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5199::
    ld a, [wD7B9]
    and a, a
    jr nz, Jump_01E_51AE
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_51AE::
    call Func_01E_7778
    ld a, [wD7B7]
    ld b, $BC
    ld hl, $788A
    call Func_01E_741A
    ld a, $01
    ld [wD7FA], a
    ld a, [wD780]
    cp a, $07
    jr z, Jump_01E_51D7
    ld a, $15
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_51D7::
    ld a, $22
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_51E6::
    ld c, $05
    ld hl, $0273
    ld de, $00A7
    xor a, a
    ld [wD7F1], a
    ld a, $0D
    ld [wD7F2], a
    call Func_01E_75F2
    ld a, [wD786]
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, $79C8
    ld hl, wC364
    ld bc, $0B0B
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    farcall Func_01D_5E3F
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_525F::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    ld de, $795C
    ld hl, wC36C
    ld bc, $0C09
    call Func_01E_748E
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    call Func_01E_75EB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5290::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_52B4
    cp a, $FC
    jr z, Jump_01E_52B4
    cp a, $FD
    jr z, Jump_01E_52F7
    cp a, $FE
    jr z, Jump_01E_52BD
    cp a, $FF
    jr z, Jump_01E_52C9
    ret

Jump_01E_52B4::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_01E_52BD::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7AB], a
    ret

Jump_01E_52C9::
    ld a, [wD781]
    add a, $08
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_52F7::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01E_5300::
    ld c, $09
    ld hl, $01D4
    ld de, $0008
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call Func_01E_75F2
    ld de, $5343
    ld hl, wC40B
    ld bc, $0D03
    call Func_01E_748E
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC429
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BC, $7C
    db $7D, $7E, $DF, $7F, $FE, $FF, $76, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $B7

Jump_01E_536A::
    ld de, $79C8
    ld hl, wC364
    ld bc, $0B0B
    call Func_01E_748E
    ld a, [wD786]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140B
    ld de, $01CC
    call Func_01E_74C8
    farcall Func_01D_5E3F
    ld de, $7BBE
    ld hl, wC40B
    ld bc, $0D05
    call Func_01E_748E
    ld a, $6C
    call StoreWC60B
    farcall Func_01D_5F2D
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC429
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD7B9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC451
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD786]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    xor a, a
    ld [wD7B7], a
    ld a, $02
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_540F::
    ld a, $06
    ld [wD7B2], a
    ld a, $0C
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0A
    ld [wD780], a
    call Func_01E_7745
    ret

Jump_01E_5429::
    farcall Func_01D_6C9F
    ret

Jump_01E_5430::
    ld de, $5461
    ld hl, wC36B
    ld bc, $0D09
    call Func_01E_748E
    ld a, [wD7B7]
    ld b, $BC
    ld hl, $788A
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    farcall Func_01D_6026
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $079461, $75

Jump_01E_54D6::
    ld hl, vTiles1 + $3F0
    ld bc, $0401
    call Func_000_1881
    ld hl, vTiles1 + $470
    ld bc, $0501
    call Func_000_1881
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld hl, vTiles1 + $6A0
    ld bc, $0401
    call Func_000_1881
    ld hl, vTiles1 + $750
    ld bc, $0801
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5518::
    ld de, $7B49
    ld hl, wC36B
    ld bc, $0D09
    call Func_01E_748E
    call Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01E_5556
    ld de, $010E
    call Func_01E_7530
    ld hl, wC412
    call Func_01E_7556
    ld de, $010F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    call Func_01E_7564
    ld hl, wC413
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    call Func_01E_759A

Jump_01E_5556::
    call Func_01E_750F
    ld bc, $1409
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_556A::
    xor a, a
    ld [wD7F5], a
    farcall Func_01D_6088
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_557C::
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD7F1], a
    ld [wD7F2], a
    farcall Func_01D_6320
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_559E::
    ld a, $01
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_55C3
    cp a, $FC
    jr z, Jump_01E_55C3
    cp a, $FD
    jr z, Jump_01E_55CC
    cp a, $FE
    jr z, Jump_01E_55CD
    cp a, $FF
    jr z, Jump_01E_55D9
    ret

Jump_01E_55C3::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01E_55CC::
    ret

Jump_01E_55CD::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7AB], a
    ret

Jump_01E_55D9::
    ld a, $06
    ld [wD7B2], a
    ld a, $1B
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    ld [wD780], a
    call Func_01E_7745
    ret

Jump_01E_55F3::
    ld de, $7BFF
    ld hl, wC36B
    ld bc, $0408
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $1409
    ld de, $01CC
    call Func_01E_74C8
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4120
    ld hl, vTiles1 + $750
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4170
    ld hl, vTiles1 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_41A0
    ld hl, vTiles1 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5654::
    ld a, $9E
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, $6DC4
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall Func_01D_6C14
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7B7]
    ld b, $C3
    ld hl, $788A
    call Func_01E_741A
    ld a, $02
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_568E::
    ld a, [wD781]
    rst $00
    dw Jump_01E_50AE
    dw Jump_01E_50BE
    dw Jump_01E_5708
    dw Jump_01E_51E6
    dw Jump_01E_4933
    dw Jump_01E_49B2
    dw Jump_01E_49F2
    dw Func_01E_4A32
    dw Jump_01E_525F
    dw Jump_01E_439E
    dw Jump_01E_4A5E
    dw Jump_01E_43E0
    dw Jump_01E_5290
    dw Jump_01E_5300
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_536A
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Jump_01E_5774
    dw Jump_01E_57EB
    dw Jump_01E_581C
    dw Jump_01E_586E
    dw Jump_01E_4463
    dw Jump_01E_447F
    dw Jump_01E_4493
    dw Jump_01E_4933
    dw Jump_01E_4AE0
    dw Jump_01E_4AF1
    dw Jump_01E_4C42
    dw Jump_01E_5429
    dw Jump_01E_5430
    dw Jump_01E_54D6
    dw Jump_01E_5518
    dw Jump_01E_556A
    dw Jump_01E_557C
    dw Jump_01E_58B0
    dw Jump_01E_5300
    dw Jump_01E_55F3
    dw Jump_01E_5654
    dw Jump_01E_44B5
    dw Jump_01E_44C3
    dw Jump_01E_4517
    dw Jump_01E_592B
    dw Jump_01E_5994
    dw Jump_01E_59D4
    dw Jump_01E_5A05
    dw Jump_01E_5A16
    dw Jump_01E_4463
    dw Jump_01E_5B06
    dw Jump_01E_5A88
    dw Jump_01E_5AB0
    dw Jump_01E_4493
    dw Jump_01E_4AF1
    dw Jump_01E_5B32

Jump_01E_5708::
    farcall Func_01D_642A
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FD
    ret z
    cp a, $FE
    jp z, Jump_01E_5145
    cp a, $FF
    jr z, Jump_01E_5720
    ret

Jump_01E_5720::
    ld a, [wD7B7]
    and a, a
    jp nz, Jump_01E_5199
    farcall Func_01D_5F2D
    ld a, [wD7A9]
    cp a, $02
    jr nc, Jump_01E_5743
    ld a, $04
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5743::
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    call Func_01E_7778
    ld a, [wD7B7]
    ld b, $BC
    ld hl, $788A
    call Func_01E_741A
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5774::
    ld de, $7BBE
    ld hl, wC40B
    ld bc, $0D05
    call Func_01E_748E
    ld de, $57DC
    ld hl, wC40B
    ld bc, $0D01
    call Func_01E_748E
    ld de, $57E9
    ld hl, wC41F
    ld bc, $0102
    call Func_01E_748E
    farcall Func_01D_5F2D
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC429
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD7B9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC451
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    db $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B7, $B5

Jump_01E_57EB::
    ld a, [wD7AB]
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, [wD7B7]
    ld b, $BC
    ld hl, $788A
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $0C
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_581C::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_76EB
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF
    ld de, wC130
    ld c, $00

Jump_01E_583B::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01E_5849
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01E_583B

Jump_01E_5849::
    ld a, $F0
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_586E::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_76EB
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ld [wD7F2], a
    farcall Func_014_7E96
    farcall Func_01D_5E79
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_01E_5A4D
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

Jump_01E_58B0::
    ld a, $01
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_58D5
    cp a, $FC
    jr z, Jump_01E_58D5
    cp a, $FD
    jr z, Jump_01E_58DE
    cp a, $FE
    jr z, Jump_01E_58DF
    cp a, $FF
    jr z, Jump_01E_58FD
    ret

Jump_01E_58D5::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01E_58DE::
    ret

Jump_01E_58DF::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7AB], a
    ld a, $01
    ld [wD7FA], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_58FD::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $788E
    call Func_01E_741A
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_592B::
    ld de, $7BBE
    ld hl, wC40B
    ld bc, $0D05
    call Func_01E_748E
    ld de, $5987
    ld hl, wC40B
    ld bc, $0D01
    call Func_01E_748E
    farcall Func_01D_5F2D
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC429
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD7B9]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    ld hl, wC451
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_5994::
    farcall Func_01D_6026
    call Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01E_59CC
    ld de, $010E
    call Func_01E_7530
    ld hl, wC412
    call Func_01E_7556
    ld de, $010F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    call Func_01E_7564
    ld hl, wC413
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    call Func_01E_759A

Jump_01E_59CC::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_59D4::
    ld a, [wD7AB]
    ld b, $C3
    ld hl, $788E
    call Func_01E_741A
    ld a, [wD7B7]
    ld b, $BC
    ld hl, $788A
    call Func_01E_741A
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, $28
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5A05::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5A16::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_76F3
    ld a, [hl]
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ld [wD7F2], a
    farcall Func_014_7E96
    farcall Func_01D_5E79
    call Func_01E_5A4D
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wD7AC], a
    ld [wD7AE], a
    ret

; 2 call sites from 1 routine (e.g. Func_01E_4A32)
; reads: wD7AB, wD781
; writes: wD7F1, wD7F2, wD781
; points at: wC410
Func_01E_5A4D::
    ld de, $5A80
    ld hl, wC410
    ld bc, $0801
    call Func_01E_748E
    ld c, $05
    ld hl, $0287
    ld de, $00BB
    xor a, a
    ld [wD7F1], a
    ld a, $0D
    ld [wD7F2], a
    call Func_01E_75F2
    ld a, [wD7AB]
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Jump_01E_5A88::
    ld a, $9E
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, $6DC4
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall Func_01D_6C14
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5AB0::
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4120
    ld hl, vTiles1 + $750
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4170
    ld hl, vTiles1 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_41A0
    ld hl, vTiles1 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5B06::
    ld de, $7BFF
    ld hl, wC36B
    ld bc, $0408
    call Func_01E_748E
    ld de, $7C1F
    ld hl, wC40B
    ld bc, $0403
    call Func_01E_748E
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5B32::
    farcall Func_01D_5E3F
    xor a, a
    ld [wD781], a
    ld a, $02
    ld [wD780], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5B50::
    ld a, [wD781]
    rst $00
    dw Func_01E_65FE
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_5B96
    dw Func_01E_667C
    dw Jump_01E_669D
    dw Jump_01E_5BD0
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Func_01E_6810
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_5D1F
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_5DC5
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_5F1D

Jump_01E_5B96::
    call Func_01E_750F
    ld de, $6717
    ld a, $14
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01E_5BC8
    ld de, $0142
    call Func_01E_7530
    ld de, $0143
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    call Func_01E_7564

Jump_01E_5BC8::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5BD0::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5BDC
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5C78

Jump_01E_5BDC::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5C00
    cp a, $FC
    jr z, Jump_01E_5C00
    cp a, $FD
    jr z, Jump_01E_5C08
    cp a, $FE
    jr z, Jump_01E_5C0E
    cp a, $FF
    jr z, Jump_01E_5C16
    ret

Jump_01E_5C00::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_5C08::
    ld a, $04
    ld [wD781], a
    ret

Jump_01E_5C0E::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5C16::
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $651B
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, $0E
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_5C63)
; reads: wD782
; writes: wD782
Func_01E_5C37::
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call Func_000_1881
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld hl, vTiles1 + $700
    ld bc, $0501
    call Func_000_1881
    ld hl, vTiles1 + $4E0
    ld bc, $0201
    call Func_000_1881
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_5C63)
; reads: wD781, wD782
; writes: wD781, wD782
Func_01E_5C63::
    call Func_01E_7163
    call Func_01E_4A32
    ld a, [wD781]
    dec a
    ld [wD781], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_5C78::
    call Func_01E_49EA
    ld a, $04
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_01E_5C85::
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld c, $05
    ld hl, $7880
    call Func_01E_7406
    ld a, [wDataBank]
    cp a, $1F
    jr z, Jump_01E_5CB3
    ld a, [wD7B2]
    cp a, $04
    jr z, Jump_01E_5CCA
    cp a, $05
    jr nz, Jump_01E_5CD5
    ld a, [wD7B3]
    cp a, $2F
    jr c, Jump_01E_5CD5
    jr Jump_01E_5CCA

Jump_01E_5CB3::
    ld a, [wD780]
    cp a, $0A
    jr nz, Jump_01E_5CCA
    ld a, [wD7B2]
    cp a, $06
    jr z, Jump_01E_5CD5
    ld a, [wC920]
    cp a, $E8
    jr z, Jump_01E_5CCA
    jr Jump_01E_5CD5

Jump_01E_5CCA::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A

Jump_01E_5CD5::
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    call Func_01E_750F
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_01E_74C8
    call Func_01E_7763
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_5D1F::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5D2B
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5DBD

Jump_01E_5D2B::
    ld a, [wC5DB]
    cp a, $05
    jr z, Jump_01E_5D38
    farcall Func_01D_5C35

Jump_01E_5D38::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5D5C
    cp a, $FC
    jr z, Jump_01E_5D5C
    cp a, $FD
    jr z, Jump_01E_5D67
    cp a, $FE
    jr z, Jump_01E_5D7E
    cp a, $FF
    jr z, Jump_01E_5D72
    ret

Jump_01E_5D5C::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_5D67::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5D72::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_01E_5D7E::
    xor a, a
    ldh [hFFBA], a
    call Func_01E_750F
    ld de, $0068
    add hl, de
    ld de, $662B
    ld a, $0C
    ld [wD7F3], a
    ld a, $0F
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $653F
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, $04
    ld [wD781], a
    ret

Jump_01E_5DBD::
    call Func_01E_49EA
    xor a, a
    ld [wD782], a
    ret

Jump_01E_5DC5::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5DD1
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5E88

Jump_01E_5DD1::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01E_5DF5
    cp a, $FC
    jr z, Jump_01E_5DF5
    cp a, $FD
    jr z, Jump_01E_5DFD
    cp a, $FE
    jr z, Jump_01E_5E06
    cp a, $FF
    jr z, Jump_01E_5E17
    ret

Jump_01E_5DF5::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_5DFD::
    ld a, [wD781]
    sub a, $02
    ld [wD781], a
    ret

Jump_01E_5E06::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call Func_000_1881
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5E17::
    ld hl, vTiles2 + $730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall Func_01D_6D07
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6E47
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld hl, vTiles2 + $6C0
    ld bc, $0201
    call Func_000_1881
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6D6F
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld hl, vTiles2 + $200
    ld bc, $0805
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    ret

Jump_01E_5E88::
    call Func_01E_49EA
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_01E_5E98::
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6B4F
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6C27
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5ED6::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call Func_000_1881
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6C5F
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6D37
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_5F1D::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5F29
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_5F99

Jump_01E_5F29::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    jr z, Jump_01E_5F4D
    cp a, $FB
    jr z, Jump_01E_5F5A
    cp a, $FC
    jr z, Jump_01E_5F5A
    cp a, $FD
    jr z, Jump_01E_5F65
    cp a, $FE
    jr z, Jump_01E_5F87
    cp a, $FF
    jr z, Jump_01E_5F90

Jump_01E_5F4D::
    ld a, [wC5DB]
    cp a, $05
    ret z
    farcall Func_01D_5BF2
    ret

Jump_01E_5F5A::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_5F65::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    ld hl, vTiles2 + $200
    ld bc, $0805
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_5F87::
    xor a, a
    ldh [hFFBA], a
    ld a, $17
    ld [wD781], a
    ret

Jump_01E_5F90::
    xor a, a
    ldh [hFFBA], a
    ld a, $07
    ld [wD781], a
    ret

Jump_01E_5F99::
    call Func_01E_49EA
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    jp Jump_01E_5F65

Jump_01E_5FAA::
    ld a, [wD781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6055
    dw Jump_01E_6646
    dw Jump_01E_5FF0
    dw Jump_01E_616A
    dw Jump_01E_669D
    dw Jump_01E_6183
    dw Jump_01E_60E1
    dw Jump_01E_60EC
    dw Jump_01E_60EC
    dw Jump_01E_619F
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_61C5
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_61F1
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6225

Jump_01E_5FF0::
    call Func_01E_750F
    ld de, $69E7
    ld a, $14
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_600F::
    ld a, [wD781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6055
    dw Jump_01E_6646
    dw Jump_01E_5B96
    dw Jump_01E_616A
    dw Jump_01E_669D
    dw Jump_01E_6183
    dw Jump_01E_60E1
    dw Jump_01E_60EC
    dw Jump_01E_60EC
    dw Jump_01E_619F
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_61C5
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_61F1
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6225

Jump_01E_6055::
    ld hl, $7898
    ld de, $78DA
    call Func_01E_7454
    call Func_01E_6074
    call Func_01E_5C37
    call Func_01E_5C63
    call Func_01E_49F8
    xor a, a
    ld [wD782], a
    ld a, $02
    ld [wD781], a
    ret

; 2 call sites from 2 routines (e.g. Func_01E_6074, Func_01E_5C63)
Func_01E_6074::
    ld c, $00
    ld b, $10

Jump_01E_6078::
    push bc
    ld a, c
    ld de, $60B1
    add a, e
    ld e, a
    jr nc, Jump_01E_6082
    inc d

Jump_01E_6082::
    ld a, [de]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    add a, a
    ld de, $60C1
    add a, e
    ld e, a
    jr nc, Jump_01E_609E
    inc d

Jump_01E_609E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    inc c
    dec b
    jr nz, Jump_01E_6078
    ret
    db $A3, $54, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $A3
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

Jump_01E_60E1::
    call Func_01E_65FE
    call Func_01E_42C6
    xor a, a
    ld [wD782], a
    ret

Jump_01E_60EC::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_60F4::
    ld a, [wD781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_5B96
    dw Jump_01E_616A
    dw Jump_01E_669D
    dw Jump_01E_6183
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Jump_01E_613A
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_5C85
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_61C5
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_61F1
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6225

Jump_01E_613A::
    ld hl, $793C
    ld de, $791C
    call Func_01E_7454
    farcall Func_01D_5F2D
    call Func_01E_76EB
    push hl
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    pop hl
    push hl
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    call Func_01E_75EB
    pop hl
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_616A::
    call Func_01E_667C
    ld a, $01
    ld [wD7F1], a
    farcall Func_01D_6AA5
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    ret

Jump_01E_6183::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5BDC
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_618F

Jump_01E_618F::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $04
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_01E_619F::
    ld hl, $793C
    ld de, $791C
    call Func_01E_7454
    call Func_01E_6810
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    ret

Jump_01E_61B4::
    call Func_01E_65FE
    ld de, Data_01F_4A70
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

Jump_01E_61C5::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5D2B
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_61D1

Jump_01E_61D1::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $01
    ld [wD7F1], a
    farcall Func_01D_6AA5
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    xor a, a
    ld [wD782], a
    ret

Jump_01E_61F1::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5DD1
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_61FD

Jump_01E_61FD::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $01
    ld [wD7F1], a
    farcall Func_01D_6AA5
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_01E_6225::
    ld a, [wD782]
    rst $00
    dw Jump_01E_5F29
    dw Func_01E_5C37
    dw Func_01E_5C63
    dw Jump_01E_6231

Jump_01E_6231::
    call Func_01E_49F8
    call Func_01E_7702
    ld a, $01
    ld [wD7F1], a
    farcall Func_01D_6AA5
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    jp Jump_01E_5F65

Jump_01E_625A::
    ld a, [wD781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6282
    dw Jump_01E_6646
    dw Jump_01E_62C0
    dw Jump_01E_62EF
    dw Jump_01E_6325
    dw Jump_01E_6399
    dw Jump_01E_6437
    dw Jump_01E_6492
    dw Jump_01E_60E1
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Jump_01E_64AD
    dw Jump_01E_54D6
    dw Jump_01E_6519
    dw Jump_01E_556A
    dw Jump_01E_656F
    dw Jump_01E_64BE

Jump_01E_6282::
    ld hl, $7898
    ld de, $78DA
    call Func_01E_7454
    call Func_01E_6074
    xor a, a
    ld [wD782], a
    ld a, $02
    ld [wD781], a
    ret

Jump_01E_6298::
    ld a, [wD781]
    rst $00
    dw Jump_01E_61B4
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_62C0
    dw Jump_01E_62EF
    dw Jump_01E_6325
    dw Jump_01E_6399
    dw Jump_01E_6437
    dw Jump_01E_6492
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Jump_01E_64AD
    dw Jump_01E_54D6
    dw Jump_01E_6519
    dw Jump_01E_556A
    dw Jump_01E_656F
    dw Jump_01E_64BE

Jump_01E_62C0::
    ld hl, vTiles2 + $200
    ld bc, $1304
    call Func_000_1881
    ld de, Data_01F_4A40
    ld hl, vTiles1 + $6D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD7AF]
    add a, a
    add a, a
    ld b, a
    ld a, [wD7AB]
    add a, b
    ld [wD7AB], a
    xor a, a
    ld [wD7AF], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_62EF::
    farcall Func_01D_6D07
    call Func_01E_750F
    ld de, $6E7F
    ld a, $14
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_76F3
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    farcall Func_01D_682A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6325::
    call Func_01E_76F3
    ld a, [hl]
    ld b, a
    call Func_01E_6D70
    call Func_01E_6FEB
    ld a, $F0
    ldh [hFFBA], a
    call Func_01E_750F
    ld de, $0069
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, $6C
    ld [hl], a
    ei
    ld de, $0120
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $6D
    ld [hl], a
    ei
    ld a, [wD7A9]
    cp a, $02
    jr c, Jump_01E_6391
    ld de, Data_01F_4AA0
    ld hl, vTiles2 + $20
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4AE0
    ld hl, vTiles2 + $30
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call Func_01E_750F
    ld de, $0012
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, $02
    ld [hl], a
    ei
    ld de, $0220
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $03
    ld [hl], a
    ei

Jump_01E_6391::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6399::
    ld a, [wD782]
    and a, a
    jp nz, Jump_01E_63D3
    call Func_01E_6D0F
    call Func_01E_76F3
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    push de
    ld hl, vTiles2 + $480
    ld c, $01
    call Func_000_1FE3
    pop de
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_63D3::
    call Func_01E_76F3
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_640A
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    push de
    ld a, $7F
    ld [wC526], a
    call Func_000_0829
    ld a, $01
    ldh [hFFC6], a
    call Func_01E_750F
    ld de, $0041
    add hl, de
    pop de
    call Func_000_2090

Jump_01E_640A::
    pop hl
    xor a, a
    ld [rRAMG2], a
    call Func_01E_750F
    ld de, $0041
    add hl, de
    ld de, $64F7
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $01
    ld [wD7F7], a
    call Func_01E_6D2B
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6437::
    farcall Func_01D_64D6
    ld a, [wD7F9]
    and a, a
    jr z, Jump_01E_644F
    cp a, $FD
    jr z, Jump_01E_6471
    cp a, $FE
    jr z, Jump_01E_6483
    cp a, $FF
    jr z, Jump_01E_6483

Jump_01E_644F::
    ld a, [wC58A]
    and a, a
    jr z, Jump_01E_645D
    ld a, [wC581]
    cp a, $08
    jr nz, Jump_01E_645D
    ret

Jump_01E_645D::
    call Func_01E_76F3
    ld c, $00
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    farcall Func_01D_6899
    ret

Jump_01E_6471::
    ld a, [wD7B9]
    cp a, $02
    jr c, Jump_01E_644F
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6483::
    call Func_01E_7732
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

Jump_01E_6492::
    ld hl, vTiles2 + $200
    ld bc, $0805
    call Func_000_1881
    ld hl, vTiles2 + $480
    ld bc, $0904
    call Func_000_1881
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01E_64AD::
    ld hl, $793C
    ld de, $791C
    call Func_01E_7454
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_64BE::
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    call Func_01E_750F
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_01E_74C8
    call Func_01E_7763
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD7B2]
    cp a, $07
    ret nz
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_6519::
    ld de, $7B49
    ld hl, wC36B
    ld bc, $0D09
    call Func_01E_748E
    call Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01E_6552
    ld a, [wD7B2]
    cp a, $07
    jr z, Jump_01E_6559
    ld hl, wC412
    call Func_01E_7556
    ld hl, wC413
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    call Func_01E_759A

Jump_01E_654A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6552::
    ld a, [wD7B2]
    cp a, $07
    jr nz, Jump_01E_654A

Jump_01E_6559::
    ld de, $6567
    ld hl, wC410
    ld bc, $0801
    call Func_01E_748E
    jr Jump_01E_654A
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2

Jump_01E_656F::
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_01D_6320
    ld a, [wD786]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A
    ld a, [wD7B2]
    cp a, $07
    jr z, Jump_01E_65A5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_65A5::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $788E
    call Func_01E_741A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_65B8::
    ld a, [wD781]
    rst $00
    dw Func_01E_65FE
    dw Jump_01E_6635
    dw Jump_01E_6646
    dw Jump_01E_664E
    dw Func_01E_667C
    dw Jump_01E_669D
    dw Jump_01E_6753
    dw Func_01E_65FE
    dw Jump_01E_679E
    dw Jump_01E_67B1
    dw Func_01E_6810
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_6870
    dw Jump_01E_68D3
    dw Jump_01E_6840
    dw Jump_01E_685A
    dw Jump_01E_68E4
    dw Jump_01E_6907
    dw Jump_01E_6920
    dw Jump_01E_694D
    dw Jump_01E_69AD
    dw Jump_01E_6A57
    dw Jump_01E_5E98
    dw Jump_01E_5ED6
    dw Jump_01E_6A70
    dw Jump_01E_6B10
    dw Jump_01E_6B1F
    dw Jump_01E_6BC6
    dw Jump_01E_6C1F
    dw Jump_01E_6C69
    dw Jump_01E_6C97
    dw Jump_01E_6CAB

; 2 call sites from 1 routine (e.g. Func_01E_6074)
; reads: wD781
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, hFFA1, ...
Func_01E_65FE::
    call Func_01E_750F
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, $5E12
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
    xor a, a
    ldh [hFFA1], a
    ldh [hFFA5], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6635::
    ld hl, $7898
    ld de, $78DA
    call Func_01E_7454
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6646::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_664E::
    call Func_01E_750F
    ld de, $5E37
    ld a, $14
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0020
    add hl, de
    call Func_000_24F8
    ld c, $40
    call Func_01E_7646
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_6074)
; reads: wD781
; writes: rRAMG2, rRAMB, wD781
Func_01E_667C::
    call Func_01E_76EB
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_725D
    call Func_01E_7332
    call Func_01E_7399
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_669D::
    ld a, [wD782]
    and a, a
    jp nz, Jump_01E_66EF
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $651B
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_76EB
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    push de
    ld hl, vTiles2 + $200
    ld c, $01
    call Func_000_1FE3
    pop de
    pop hl
    xor a, a
    ld [rRAMG2], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_66EF::
    call Func_01E_76EB
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_6726
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    push de
    ld a, $7F
    ld [wC526], a
    call Func_000_0829
    ld a, $01
    ldh [hFFC6], a
    call Func_01E_750F
    ld de, $0161
    add hl, de
    pop de
    call Func_000_2090

Jump_01E_6726::
    pop hl
    xor a, a
    ld [rRAMG2], a
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $64AF
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    ld a, $01
    ld [wD7F7], a
    call Func_01E_6D2B
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6753::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_65F6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_676F
    cp a, $FE
    jr z, Jump_01E_6775
    cp a, $FF
    jr z, Jump_01E_677D
    ret

Jump_01E_676F::
    ld a, $04
    ld [wD781], a
    ret

Jump_01E_6775::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_677D::
    call Func_01E_750F
    ld de, $0161
    add hl, de
    ld de, $651B
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, $0E
    ld [wD781], a
    ret

Jump_01E_679E::
    farcall Func_01D_5D47
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_67B1::
    ld hl, $7864
    ld de, $7872
    call Func_01E_7454
    xor a, a
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, $01
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, $02
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, [wD780]
    cp a, $08
    jr z, Jump_01E_67F2
    ld a, $03
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A
    ld a, $04
    ld b, $C3
    ld hl, $7880
    call Func_01E_741A

Jump_01E_67F2::
    ld a, [wD780]
    cp a, $0A
    jr z, Jump_01E_6808
    cp a, $0B
    jr z, Jump_01E_6808
    ld a, [wD7AB]
    ld b, $BC
    ld hl, $7880
    call Func_01E_741A

Jump_01E_6808::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_6074)
; reads: wD780, wD781
; writes: wD7F1, wD781
Func_01E_6810::
    ld a, [wD780]
    cp a, $08
    jr nz, Jump_01E_681F
    farcall Func_01D_5E79
    jr Jump_01E_6825

Jump_01E_681F::
    farcall Func_01D_5ECE

Jump_01E_6825::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    call Func_01E_75EB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6840::
    ld hl, vTiles1 + $270
    ld bc, $0901
    call Func_000_1881
    ld hl, vTiles1 + $780
    ld bc, $0501
    call Func_000_1881
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_685A::
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6870::
    farcall Func_01D_5E79
    call Func_01E_76F3
    ld a, [hl]
    ld b, a
    call Func_01E_75C5
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_01E_750F
    ld bc, $140D
    ld de, $01CC
    call Func_01E_74C8
    call Func_01E_750F
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_01E_74C8
    call Func_01E_7763
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_01E_68D3::
    ld hl, vTiles2 + $200
    ld bc, $0F02
    call Func_000_1881
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_68E4::
    call Func_01E_750F
    ld de, $0068
    add hl, de
    ld de, $6577
    ld a, $0C
    ld [wD7F3], a
    ld a, $0F
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6907::
    call Func_01E_76EB
    ld a, [hl]
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_6D42
    pop hl
    call Func_01E_6EE2
    xor a, a
    ld [rRAMG2], a

Jump_01E_6920::
    call Func_01E_76EB
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld b, a
    ld a, $6D
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld a, $EA
    ld [wD7F3], a
    ld a, $C7
    ld [wD7F4], a
    call Func_01E_70EF
    pop hl
    call Func_01E_6F17
    xor a, a
    ld [rRAMG2], a

Jump_01E_694D::
    call Func_01E_76EB
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    ld [wD7F1], a
    ldh a, [hFFC7]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall Func_01D_6973
    ld a, $F0
    ldh [hFFBA], a
    farcall Func_01D_5DBC
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $66DF
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    ret

Jump_01E_69AD::
    call Func_01E_76EB
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    ld [wD7F1], a
    ldh a, [hFFC7]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld a, $90
    ld [wD7F4], a
    ld a, $40
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    farcall Func_01D_6A3D
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_65F6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_6A01
    cp a, $FE
    jr z, Jump_01E_6A18
    cp a, $FF
    jr z, Jump_01E_6A0C
    ret

Jump_01E_6A01::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6A0C::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_01E_6A18::
    xor a, a
    ldh [hFFBA], a
    call Func_01E_750F
    ld de, $0068
    add hl, de
    ld de, $662B
    ld a, $0C
    ld [wD7F3], a
    ld a, $0F
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $653F
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, $04
    ld [wD781], a
    ret

Jump_01E_6A57::
    call Func_01E_76EB
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_725D
    xor a, a
    ld [rRAMG2], a
    ld a, $0F
    ld [wD781], a
    ret

Jump_01E_6A70::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_76EB
    ld a, [hl]
    ldh [hFFCB], a
    ld c, $34
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $FF
    jr z, Jump_01E_6A8F
    and a, a
    jr z, Jump_01E_6A8F
    jr Jump_01E_6AB7

Jump_01E_6A8F::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $92
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    ld a, $08
    ld [wC528], a
    ld a, $0E
    ld [wC529], a
    farcall Func_008_402B
    jr Jump_01E_6AFF

Jump_01E_6AB7::
    ld hl, vTiles2 + $200
    ld c, $34
    ld b, $08
    ld a, $01
    ld [wC52F], a
    ld a, $09
    ld [wC530], a
    ld a, $04
    ld [wC528], a

Jump_01E_6ACD::
    push bc
    push hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ldh a, [hFFCB]
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, a
    jr z, Jump_01E_6AE7
    cp a, $FF
    jr z, Jump_01E_6AE7
    jr Jump_01E_6AEC

Jump_01E_6AE7::
    call FillTilesFromRequest
    jr Jump_01E_6AF5

Jump_01E_6AEC::
    ld [wC529], a
    farcall Func_008_402B

Jump_01E_6AF5::
    pop hl
    ld bc, $0090
    add hl, bc
    pop bc
    inc c
    dec b
    jr nz, Jump_01E_6ACD

Jump_01E_6AFF::
    xor a, a
    ld [rRAMG2], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12

Jump_01E_6B10::
    farcall Func_01D_5DF9
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

Jump_01E_6B1F::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_65F6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FD
    jr z, Jump_01E_6B3B
    cp a, $FE
    jr z, Jump_01E_6B44
    cp a, $FF
    jr z, Jump_01E_6B55
    ret

Jump_01E_6B3B::
    ld a, [wD781]
    sub a, $02
    ld [wD781], a
    ret

Jump_01E_6B44::
    ld hl, vTiles2 + $200
    ld bc, $1504
    call Func_000_1881
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6B55::
    ld hl, vTiles2 + $730
    ld de, Data_01F_42D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    farcall Func_01D_6D07
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $6E47
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld hl, vTiles2 + $6C0
    ld bc, $0201
    call Func_000_1881
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $6D6F
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld hl, vTiles2 + $200
    ld bc, $0805
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    ret

Jump_01E_6BC6::
    ld a, [wD782]
    and a, a
    jr nz, Jump_01E_6C0A
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $5E13
    ld a, $0C
    ld [wD7F3], a
    ld a, $03
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_750F
    ld de, $0160
    add hl, de
    ld de, $66DF
    ld a, $08
    ld [wD7F3], a
    ld a, $07
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01E_6C0A::
    ld hl, $7864
    ld de, $7872
    call Func_01E_7454
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01E_6C1F::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    call Func_01E_76EB
    ld a, [hl]
    ld b, a
    push bc
    call Func_01E_725D
    xor a, a
    ld [rRAMG2], a
    ld hl, vTiles1 + $270
    ld bc, $0901
    call Func_000_1881
    pop bc
    ld a, b
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $11
    ld [wD781], a
    ret

Jump_01E_6C69::
    call Func_01E_750F
    ld de, $0008
    add hl, de
    ld de, $63D7
    ld a, $0C
    ld [wD7F3], a
    ld a, $12
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    call Func_01E_76EB
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    push hl
    farcall Func_01D_682A
    pop hl

Jump_01E_6C97::
    ld b, [hl]
    call Func_01E_6D70
    call Func_01E_6FEB
    ld a, $F0
    ldh [hFFBA], a
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

Jump_01E_6CAB::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_65F6
    ld a, [wD7F9]
    and a, a
    jr z, Jump_01E_6CC7
    cp a, $FD
    jr z, Jump_01E_6CDB
    cp a, $FE
    jr z, Jump_01E_6CFD
    cp a, $FF
    jr z, Jump_01E_6D06

Jump_01E_6CC7::
    call Func_01E_76EB
    ld c, $00
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    farcall Func_01D_6899
    ret

Jump_01E_6CDB::
    xor a, a
    ldh [hFFBA], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    ld hl, vTiles2 + $200
    ld bc, $0805
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_01E_6CFD::
    xor a, a
    ldh [hFFBA], a
    ld a, $17
    ld [wD781], a
    ret

Jump_01E_6D06::
    xor a, a
    ldh [hFFBA], a
    ld a, $07
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_6074)
; writes: wD7F3, wD7F4, wD7F7
Func_01E_6D0F::
    call Func_01E_750F
    ld de, $0041
    add hl, de
    ld de, $651B
    ld a, $06
    ld [wD7F3], a
    ld a, $06
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    call Func_01E_6D2B
    ret

; 27 call sites from 7 routines (e.g. Func_01E_6810, Func_01E_667C, Func_01E_65FE, Func_01E_5A4D, ...)
; writes: wD7F5, wD7F6, wD7F1, wD7F2
Func_01E_6D2B::
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01F_5D2A
    ret

; 1 call site from 1 routine (e.g. Func_01E_6810)
; writes: wC529, wC528
; points at: wC52D
Func_01E_6D42::
    ld a, [hl]
    call Func_000_2391
    ld c, a
    ld [wC529], a
    ld a, $07
    ld [wC528], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $92
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $09
    farcall Func_008_402B
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

; 3 call sites from 3 routines (e.g. Func_01E_6074, Func_01E_6810, Func_01E_6FE3)
; reads: hFFC6, hFFC7
; writes: rRAMG2, rRAMB, wC8CF, wC8D0, wC8D1, wC8D2, wC8D9, wD7F1, ...
Func_01E_6D70::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $10
    and a, a
    jr nz, Jump_01E_6D8C
    ld de, $6ED2
    jr Jump_01E_6D8F

Jump_01E_6D8C::
    ld de, $6EDA

Jump_01E_6D8F::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_01E_6DC5
    ld a, $98
    ld [wC8CF], a
    ld a, $98
    ld [wC8D0], a
    ld a, $98
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
    push de
    ld de, vTiles2 + $200
    call Func_000_21A1
    pop de
    pop bc
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_01E_6DC3
    inc d

Jump_01E_6DC3::
    jr Jump_01E_6DF3

Jump_01E_6DC5::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles2 + $200
    call Func_000_21A1
    pop de
    pop bc
    push bc
    ld a, $92
    ld [wD7F1], a
    ld a, $50
    ld [wD7F2], a
    ld a, [de]
    inc de
    push de
    ld [wD7F3], a
    call Func_01E_6E84
    pop de
    pop bc

Jump_01E_6DF3::
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call Func_000_1FA4
    ld de, vTiles2 + $2F0
    ld a, $F0
    ld [wC8D9], a
    call Func_000_21A1
    pop de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_01E_6E3E
    ld a, $98
    ld [wC8CF], a
    ld a, $98
    ld [wC8D0], a
    ld a, $98
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
    push de
    ld de, vTiles2 + $340
    call Func_000_21A1
    pop de
    pop bc
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_01E_6E3C
    inc d

Jump_01E_6E3C::
    jr Jump_01E_6E6C

Jump_01E_6E3E::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld c, a
    inc de
    push de
    ld a, b
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles2 + $340
    call Func_000_21A1
    pop de
    pop bc
    push bc
    ld a, $93
    ld [wD7F1], a
    ld a, $90
    ld [wD7F2], a
    ld a, [de]
    inc de
    push de
    ld [wD7F3], a
    call Func_01E_6E84
    pop de
    pop bc

Jump_01E_6E6C::
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    call Func_000_1FA4
    ld de, vTiles2 + $430
    ld a, $F0
    ld [wC8D9], a
    call Func_000_21A1
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; 2 call sites from 1 routine (e.g. Func_01E_6D70)
; reads: wD7F3, hFFC6, hFFC7, wDataBank, wD7F1, wD7F2
; writes: wDataBank
; points at: wC8CF
Func_01E_6E84::
    push bc
    ld a, [wD7F3]
    ld c, a
    ld a, b
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld bc, $0004
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wC8CF
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD7F1]
    ld d, a
    ld a, [wD7F2]
    ld e, a
    call Func_000_21A1
    pop bc
    ret
    db $1A, $8E, $1A, $1E, $1C, $99, $1C, $29, $1C, $99, $1C, $29, $1A, $8E, $1A, $1E

; 1 call site from 1 routine (e.g. Func_01E_6810)
; writes: wC8D9
Func_01E_6EE2::
    push hl
    ld hl, $2940
    ld de, vTiles2 + $290
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    ld hl, $2940
    call Func_01E_7443
    pop hl
    ld a, [hl]
    ld c, $0F
    call Func_000_1FA4
    ld de, vTiles2 + $290
    ld a, $F0
    ld [wC8D9], a
    call Func_000_21A1
    ret

; 1 call site from 1 routine (e.g. Func_01E_6810)
; reads: hFFC6, hFFC7, hFFC8, wD00F
; writes: wC8C0, wC8C1, wC8C2, wD006, wD007, hFFC6, hFFC7, wD7F1, ...
; points at: hFFC8
Func_01E_6F17::
    call Func_01E_76EB
    push hl
    ld a, [hl]
    ld c, $58
    call Func_000_1F95
    ldh a, [hFFC6]
    ld [wC8C0], a
    ldh a, [hFFC7]
    ld [wC8C1], a
    ldh a, [hFFC8]
    ld [wC8C2], a
    call Func_000_173A
    call Func_01E_768E
    call Func_01E_750F
    ld de, $018C
    add hl, de
    call Func_000_24F8
    call Func_01E_76C7
    pop hl
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordWord
    ldh a, [hFFC7]
    ld b, a
    ldh a, [hFFC6]
    cp a, b
    jp nc, Jump_01E_6FC9
    ldh a, [hFFC6]
    ld b, a
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [wD006], a
    ldh a, [hFFC7]
    ld [wD007], a
    farcall Func_035_4001
    ld a, [wD00F]
    ldh [hFFC6], a
    pop bc
    ld a, b
    ldh [hFFC7], a
    farcall Func_019_7380
    ld de, hFFC8
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    pop hl
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, $58
    call Func_000_1F95
    pop de
    pop bc
    ldh a, [hFFC6]
    ld l, a
    ld a, c
    sub a, l
    ld c, a
    ldh a, [hFFC7]
    ld l, a
    ld a, b
    sbc a, l
    ld b, a
    ldh a, [hFFC8]
    ld l, a
    ld a, e
    sbc a, l
    ld e, a
    ld a, c
    ld [wC8C0], a
    ld a, b
    ld [wC8C1], a
    ld a, e
    ld [wC8C2], a
    call Func_000_173A
    call Func_01E_768E

Jump_01E_6FBA::
    call Func_01E_750F
    ld de, $020C
    add hl, de
    call Func_000_24F8
    call Func_01E_76C7
    pop hl
    ret

Jump_01E_6FC9::
    ld a, $E3
    ld [wD7F1], a
    ld [wD7F2], a
    ld [wD7F3], a
    ld [wD7F4], a
    ld [wD7F5], a
    ld [wD7F6], a
    xor a, a
    ld [wD7F7], a
    jr Jump_01E_6FBA

; 1 call site from 1 routine (e.g. Func_0F0_5E2C)
Func_01E_6FE3::
    ld b, e
    call Func_01E_6D70
    call Func_01E_6FEB
    ret

; 3 call sites from 3 routines (e.g. Func_01E_6074, Func_01E_6810, Func_01E_6FE3)
; reads: hFFC6, hFFC7, rSTAT
; writes: rRAMG2, rRAMB, wD7F1, wD7F5, wD7F2, wD7F3, wD7F4
Func_01E_6FEB::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $10
    and a, a
    jr nz, Jump_01E_7007
    ld de, $70D7
    jr Jump_01E_700A

Jump_01E_7007::
    ld de, $70DD

Jump_01E_700A::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_01E_702A
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6C0
    call Func_01E_7443
    pop de
    inc de
    inc de
    inc de
    jr Jump_01E_7067

Jump_01E_702A::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [wD7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wD7F5], a
    xor a, a
    ld [wD7F2], a
    ld a, $6A
    ld [wD7F3], a
    ld a, $6C
    ld [wD7F4], a
    call Func_01E_70E3
    pop de
    pop bc
    push bc
    call Func_01E_70C9
    inc de
    inc de
    push de
    call Func_01E_750F
    ld de, $006E
    add hl, de
    call Func_000_24F8
    di

Jump_01E_705D::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_705D
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_01E_7067::
    pop bc
    push bc
    ld a, [de]
    ld c, a
    ld a, b
    push de
    call LoadSRAMRecordWord
    pop de
    ldh a, [hFFC7]
    cp a, $FF
    jr nz, Jump_01E_7087
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6D0
    call Func_01E_7443
    pop de
    inc de
    inc de
    inc de
    jr Jump_01E_70C3

Jump_01E_7087::
    inc de
    pop bc
    push bc
    ld a, [de]
    ld [wD7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wD7F5], a
    ld a, $01
    ld [wD7F2], a
    ld a, $8A
    ld [wD7F3], a
    ld a, $6D
    ld [wD7F4], a
    call Func_01E_70E3
    pop de
    pop bc
    push bc
    call Func_01E_70C9
    push de
    call Func_01E_750F
    ld de, $018E
    add hl, de
    call Func_000_24F8
    di

Jump_01E_70B9::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_70B9
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_01E_70C3::
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; 2 call sites from 1 routine (e.g. Func_01E_6FEB)
; points at: wCDCC, wCCCD
Func_01E_70C9::
    ld a, [de]
    cp a, $98
    jr z, Jump_01E_70D3
    ld bc, wCDCC
    jr Jump_01E_70D6

Jump_01E_70D3::
    ld bc, wCCCD

Jump_01E_70D6::
    ret
    db $1A, $98, $1A, $1C, $A3, $1C, $1C, $A3, $1C, $1A, $98, $1A

; 2 call sites from 1 routine (e.g. Func_01E_6FEB)
; reads: wD7F1, hFFC6, wD7F2, wD7F3, rSTAT, wC8C1, wC8C2
Func_01E_70E3::
    push bc
    ld c, b
    farcall Func_00E_612E
    pop bc
    jp Jump_01E_710A

; 1 call site from 1 routine (e.g. Func_01E_6810)
; reads: hFFC6, wD7F4, wD7F1, wD7F2, wD7F3, rSTAT, wC8C1, wC8C2
; writes: wD09D, wD09E
Func_01E_70EF::
    push bc
    ld c, $0D
    ld a, b
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F4]
    ld [wD09E], a
    farcall Func_016_7A48
    pop bc

Jump_01E_710A::
    ld a, [wD7F1]
    ld c, a
    ld a, b
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, a
    jr nz, Jump_01E_7118
    ret

Jump_01E_7118::
    push af
    call Func_01E_750F
    ld a, [wD7F2]
    ld d, a
    ld a, [wD7F3]
    ld e, a
    add hl, de
    call Func_000_24F8
    di

Jump_01E_7129::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7129
    ld a, $1E
    ld [hl+], a
    ei
    pop af
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    pop hl
    ld a, [wC8C1]
    cp a, $E3
    jr z, Jump_01E_7154
    di

Jump_01E_7147::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7147
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ei

Jump_01E_7154::
    di

Jump_01E_7155::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7155
    ld a, [wC8C2]
    add a, $E0
    ld [hl+], a
    ei
    ret

; 12 call sites from 12 routines (e.g. Func_01E_49F8, Func_01E_5C63, Func_014_4BA0, Func_015_4182, ...)
; reads: wD7A9, wD7AF, wD7AB
; writes: wD7B0, wD7AF, wD7B1, wD7AB
Func_01E_7163::
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    ld a, $05
    call DivideHLByA
    push af
    and a, a

Jump_01E_7170::
    jr z, Jump_01E_7173
    inc l

Jump_01E_7173::
    ld a, l
    ld [wD7B0], a
    ld a, [wD7AF]
    inc a
    cp a, l
    jr c, Jump_01E_71AE
    pop af
    push af
    and a, a
    jr nz, Jump_01E_7193
    ld a, [wD7AF]
    inc a
    cp a, l
    jr z, Jump_01E_71AE
    ld a, [wD7AF]
    dec a
    ld [wD7AF], a
    jr Jump_01E_71AE

Jump_01E_7193::
    pop af
    dec a
    ld [wD7B1], a
    ld b, a
    ld a, [wD7AB]
    cp a, b
    jr c, Jump_01E_71B4
    jr z, Jump_01E_71B4
    push bc
    push hl
    call Func_01E_71B5
    pop hl
    pop bc
    ld a, b
    ld [wD7AB], a
    jr Jump_01E_71B4

Jump_01E_71AE::
    pop af
    ld a, $04
    ld [wD7B1], a

Jump_01E_71B4::
    ret

; 1 call site from 1 routine (e.g. Func_01E_7163)
; reads: wD7AB
Func_01E_71B5::
    ld b, $C3
    ld a, [wD7AB]
    add a, a
    ld hl, $71D7
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01

; 11 call sites from 9 routines (e.g. Func_01E_4A32, Func_01E_6074, Func_00D_491A, Func_015_512C, ...)
; reads: wD7A9, wD7AF, wD7AB
; writes: wD7B0, wD7AF, wD7B1, wD7AB
Func_01E_71E1::
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01E_71F1
    inc l

Jump_01E_71F1::
    ld a, l
    ld [wD7B0], a
    ld a, [wD7AF]
    inc a
    cp a, l
    jr c, Jump_01E_722C
    pop af
    push af
    and a, a
    jr nz, Jump_01E_7211
    ld a, [wD7AF]
    inc a
    cp a, l
    jr z, Jump_01E_722C
    ld a, [wD7AF]
    dec a
    ld [wD7AF], a
    jr Jump_01E_722C

Jump_01E_7211::
    pop af
    dec a
    ld [wD7B1], a
    ld b, a
    ld a, [wD7AB]
    cp a, b
    jr c, Jump_01E_7232
    jr z, Jump_01E_7232
    push bc
    push hl
    call Func_01E_7233
    pop hl
    pop bc
    ld a, b
    ld [wD7AB], a
    jr Jump_01E_7232

Jump_01E_722C::
    pop af
    ld a, $03
    ld [wD7B1], a

Jump_01E_7232::
    ret

; 1 call site from 1 routine (e.g. Func_01E_71E1)
; reads: wD7AB
Func_01E_7233::
    ld b, $C3
    ld a, [wD7AB]
    add a, a
    ld hl, $7255
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $28, $00, $68, $00, $A8, $00, $E8, $00

; 3 call sites from 2 routines (e.g. Func_01E_667C, Func_01E_6810)
; reads: hFFC7, hFFC6, wC8C1, wC8C2
Func_01E_725D::
    push hl
    ld a, [hl]
    ld c, $56
    ld b, $02
    call LoadSRAMRecordWord
    call Func_01E_750F
    ld de, $0029
    add hl, de
    call Func_000_24F8
    ldh a, [hFFC7]
    ld b, a
    ldh a, [hFFC6]
    cp a, b
    jr c, Jump_01E_7282
    di
    call WaitForVRAMAccess
    ld a, $6F
    ld [hl], a
    ei
    jr Jump_01E_728A

Jump_01E_7282::
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl], a
    ei

Jump_01E_728A::
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $EA
    ld [hl+], a
    ld a, $ED
    ld [hl+], a
    ei
    push hl
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_01E_75B3
    pop hl
    ld a, [wC8C1]
    add a, $E0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld a, [wC8C2]
    add a, $E0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    pop de
    ld l, e
    ld h, d
    call Func_01E_7306
    ldh a, [hFFC6]
    push af
    bit 0, a
    call nz, Func_01E_7317
    pop af
    inc hl
    push af
    bit 2, a
    call nz, Func_01E_7320
    pop af
    inc hl
    bit 7, a
    call nz, Func_01E_7329
    inc hl
    inc hl
    ld e, l
    ld d, h
    pop hl
    push hl
    push de
    ld a, [hl]
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    pop de
    ld l, e
    ld h, d
    ldh a, [hFFC6]
    and a, $01
    add a, $CC
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_01E_725D)
Func_01E_7306::
    push hl
    ld e, $C3
    ld c, $03

Jump_01E_730B::
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    dec c
    jr nz, Jump_01E_730B
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_01E_725D)
Func_01E_7317::
    di
    call WaitForVRAMAccess
    ld a, $C0
    ld [hl], a
    ei
    ret

; 1 call site from 1 routine (e.g. Func_01E_725D)
Func_01E_7320::
    di
    call WaitForVRAMAccess
    ld a, $C1
    ld [hl], a
    ei
    ret

; 1 call site from 1 routine (e.g. Func_01E_725D)
Func_01E_7329::
    di
    call WaitForVRAMAccess
    ld a, $C2
    ld [hl], a
    ei
    ret

; 1 call site from 1 routine (e.g. Func_01E_667C)
; reads: hFFC6, hFFC7, wC8C0, wC8C1, wC8C2
Func_01E_7332::
    push hl
    call Func_01E_750F
    ld de, $0070
    add hl, de
    call Func_000_24F8
    ld e, l
    ld d, h
    pop hl
    ld c, $00

Jump_01E_7342::
    push bc
    push hl
    push de
    ld a, c
    ld de, $7394
    add a, e
    ld e, a
    jr nc, Jump_01E_734E
    inc d

Jump_01E_734E::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call HLToDecimalDigits
    call Func_01E_75B3
    pop de
    ld l, e
    ld h, d
    di
    call WaitForVRAMAccess
    ld a, [wC8C0]
    add a, $E0
    ld [hl+], a
    ei
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
    ld [hl+], a
    ei
    ld a, $40
    add a, e
    ld e, a
    jr nc, Jump_01E_738B
    inc d

Jump_01E_738B::
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01E_7342
    ret
    db $63, $65, $67, $69, $6B

; 1 call site from 1 routine (e.g. Func_01E_667C)
; reads: hFFC6, hFFC7, wC8C0, wC8C1, wC8C2
Func_01E_7399::
    ld c, $00

Jump_01E_739B::
    push hl
    ld a, [hl]
    ld b, a
    push bc
    ld a, c
    ld hl, $73FA
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, b
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call HLToDecimalDigits
    call Func_01E_75B3
    pop bc
    ld a, c
    add a, a
    ld hl, $73FE
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, [wC8C0]
    add a, $E0
    ld [hl+], a
    ei
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
    pop hl
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_01E_739B
    ret
    db $5B, $5D, $5F, $61, $CC, $01, $D0, $01, $0C, $02, $10, $02

; 1 call site from 1 routine (e.g. Func_01E_5C63)
Func_01E_7406::
    ld a, c
    ld b, a
    ld c, $00

Jump_01E_740A::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call Func_01E_741A
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_01E_740A
    ret

; 41 call sites from 10 routines (e.g. Func_01E_4069, Func_01E_4A32, Func_01E_46E5, Func_01E_42C6, ...)
Func_01E_741A::
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

; 4 call sites from 4 routines (e.g. Func_01E_4069, Func_01E_4918, Func_01E_75F2, Func_01E_4001)
Func_01E_7428::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_01E_7428
    ret

; 3 call sites from 3 routines (e.g. Func_01E_4069, Func_01E_75F2, Func_01E_4001)
; writes: rSVBK
Func_01E_7431::
    ld a, $02
    ldh [rSVBK], a

Jump_01E_7435::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01E_7435
    xor a, a
    ldh [rSVBK], a
    ret

; 7 call sites from 2 routines (e.g. Func_01E_6FEB, Func_01E_6EE2)
; reads: rSTAT
Func_01E_7443::
    ld c, $10

Jump_01E_7445::
    di

Jump_01E_7446::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7446
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_01E_7445
    ret

; 14 call sites from 8 routines (e.g. Func_01E_4069, Func_01E_4A32, Func_01E_42C6, Func_01E_6074, ...)
; writes: wD784
Func_01E_7454::
    ld b, $00

Jump_01E_7456::
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_01E_7486
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    pop de
    push de
    push hl
    ld l, e
    ld h, d
    ld a, b
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    pop bc
    inc b
    jr Jump_01E_7456

Jump_01E_7486::
    pop de
    pop hl
    pop bc
    xor a, a
    ld [wD784], a
    ret

; 33 call sites from 8 routines (e.g. Func_01E_4069, Func_01E_4A32, Func_01E_4201, Func_01E_42C6, ...)
; reads: wIsCGB
; writes: rSVBK
Func_01E_748E::
    push hl
    push bc

Jump_01E_7490::
    push bc
    push hl

Jump_01E_7492::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01E_7492
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_01E_7490
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

Jump_01E_74B4::
    push bc
    push hl

Jump_01E_74B6::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01E_74B6
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_01E_74B4
    xor a, a
    ldh [rSVBK], a
    ret

; 38 call sites from 11 routines (e.g. Func_01E_4069, Func_01E_4A32, Func_01E_46E5, Func_01E_42C6, ...)
; reads: wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wC198, wD000
Func_01E_74C8::
    push de
    push bc
    push hl
    ld hl, wC198
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call Func_000_18A5
    pop hl
    push hl
    ld a, l
    cp a, $00
    jr nz, Jump_01E_74EE
    ld a, h
    cp a, $98
    jr nz, Jump_01E_74EE
    ld a, l
    add a, $C1
    ld [wC554], a
    ld a, h
    adc a, $01
    ld [wC555], a

Jump_01E_74EE::
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

; 86 call sites from 27 routines (e.g. Func_01E_7564, Func_01E_4201, Func_01E_71B5, Func_01E_7233, ...)
; reads: hFFA5, hFFA1
Func_01E_750F::
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
    add_a_to_hl
    ret

; 4 call sites from 3 routines (e.g. Func_01E_49F8, Func_01E_4A32, Func_01E_5A4D)
Func_01E_7530::
    push de
    call Func_01E_750F
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; 4 call sites from 3 routines (e.g. Func_01E_49F8, Func_01E_4A32, Func_01E_6074)
Func_01E_7556::
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; 11 call sites from 10 routines (e.g. Func_01E_49F8, Func_01E_4A32, Func_01E_5A4D, Func_00D_5800, ...)
; reads: wD7F1, wD7F2, wD7AF, wD7B0
Func_01E_7564::
    ld a, [wD7F1]
    ld d, a
    ld a, [wD7F2]
    ld e, a
    push de
    call Func_01E_750F
    pop de
    add hl, de
    push hl
    call Func_000_24F8
    ld a, [wD7AF]
    inc a
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    ld a, [wD7B0]
    ld b, a
    pop hl
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E0
    ld [hl], a
    ei
    ret

; 20 call sites from 17 routines (e.g. Func_01E_49F8, Func_01E_4A32, Func_01E_6074, Func_00D_491A, ...)
; reads: wD7F1, wD7F2, wD7AF, wD7B0
Func_01E_759A::
    ld a, [wD7F1]
    ld h, a
    ld a, [wD7F2]
    ld l, a
    ld a, [wD7AF]
    inc a
    add a, $E0
    ld [hl+], a
    inc hl
    ld a, [wD7B0]
    ld b, a
    ld a, b
    add a, $E0
    ld [hl], a
    ret

; 21 call sites from 12 routines (e.g. Func_01E_4A32, Func_01E_7399, Func_01E_7332, Func_01E_725D, ...)
; points at: wC8C0
Func_01E_75B3::
    ld hl, wC8C0
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_75C4
    add a, $E3
    ld [hl+], a
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_75C4
    add a, $E3
    ld [hl], a

Jump_01E_75C4::
    ret

; 8 call sites from 4 routines (e.g. Func_01E_42C6, Func_01E_4A32, Func_01E_6810, Func_01E_6074)
; reads: hFFC6
; writes: rRAMG2, rRAMB, wD09D, wD09E
Func_01E_75C5::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $0F
    ld [wD09D], a
    ld a, $C7
    ld [wD09E], a
    farcall Func_016_7A48
    xor a, a
    ld [rRAMG2], a
    ret

; 5 call sites from 4 routines (e.g. Func_01E_42C6, Func_01E_4A32, Func_01E_6810, Func_01E_6074)
Func_01E_75EB::
    farcall Func_01D_5B4D
    ret

; 5 call sites from 4 routines (e.g. Func_01E_46E5, Func_01E_5A4D, Func_01E_42C6, Func_01E_4A32)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wC198, wD000
Func_01E_75F2::
    push bc
    push hl
    push de
    ld de, wC198
    add hl, de
    pop de
    push de
    push hl
    ld hl, wC198
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call Func_01E_7428
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01E_7633
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call Func_01E_7431
    pop de
    pop hl

Jump_01E_7633::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01E_7642
    inc d

Jump_01E_7642::
    dec c
    jr nz, Func_01E_75F2
    ret

; 2 call sites from 2 routines (e.g. Func_01E_42C6, Func_01E_65FE)
; reads: hFFC6, rSTAT, wC6FD
; writes: rRAMG2, rRAMB
; points at: wD789
Func_01E_7646::
    ld b, $00

Jump_01E_7648::
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld c, $00
    ld b, $01
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    cp a, $02
    jr nz, Jump_01E_7684
    pop hl
    pop bc
    push bc
    di

Jump_01E_7672::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01E_7672
    ld a, b
    add a, $E1
    ld [hl], a
    ei
    ld a, c
    add_a_to_hl
    push hl

Jump_01E_7684::
    pop hl
    pop bc
    inc b
    ld a, [wC6FD]
    cp a, b
    jr nz, Jump_01E_7648
    ret

; 6 call sites from 4 routines (e.g. Func_01E_6F17, Func_00C_7098, Func_01C_4AC4, Func_0F2_4B05)
; points at: hFFC9, wD7F1
Func_01E_768E::
    ld de, hFFC9
    ld hl, wD7F1
    ld a, [de]
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl], a
    ld c, $06
    ld hl, wD7F1

Jump_01E_76BC::
    ld a, [hl]
    and a, a
    jr nz, Jump_01E_76C6
    add a, $E3
    ld [hl+], a
    dec c
    jr nz, Jump_01E_76BC

Jump_01E_76C6::
    ret

; 2 call sites from 1 routine (e.g. Func_01E_6F17)
; points at: wD7F1
Func_01E_76C7::
    ld de, wD7F1
    ld c, $07

Jump_01E_76CC::
    di
    call WaitForVRAMAccess
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_01E_76CC
    ret

; 9 call sites from 2 routines (e.g. Func_01E_4A32, Func_01E_46E5)
; points at: hFFC6
Func_01E_76DA::
    push hl
    push de
    call SRAMRecordAddress
    ld de, hFFC6

Jump_01E_76E2::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01E_76E2
    pop de
    pop hl
    ret

; 30 call sites from 5 routines (e.g. Func_01E_4A32, Func_01E_6810, Func_01E_667C, Func_01E_6074, ...)
; reads: wD7F5, wD7F6
Func_01E_76EB::
    farcall Func_01D_5D84
    jr Jump_01E_76F9

; 8 call sites from 4 routines (e.g. Func_01E_4A32, Func_01E_6810, Func_01E_6074, Func_0F1_5B38)
; reads: wD7F5, wD7F6
Func_01E_76F3::
    farcall Func_01D_5DA1

Jump_01E_76F9::
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ret

; 4 call sites from 1 routine (e.g. Func_01E_6074)
; writes: wC378, wC3A0, wC3C8, wC3F0, wC418
Func_01E_7702::
    call Func_01E_750F
    ld de, $0020
    add hl, de
    call Func_000_24F8
    ld c, $05

Jump_01E_770E::
    di
    call WaitForVRAMAccess
    ld a, $B6
    ld [hl], a
    ei
    ld a, $40
    add_a_to_hl
    dec c
    jr nz, Jump_01E_770E
    ld a, $B6
    ld [wC378], a
    ld [wC3A0], a
    ld [wC3C8], a
    ld [wC3F0], a
    ld [wC418], a
    ret

; 1 call site from 1 routine (e.g. Func_01E_6074)
; reads: wD7AB
; writes: wD7AB, wD7AF
Func_01E_7732::
    ld a, [wD7AB]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    ld [wD7AB], a
    ld a, l
    ld [wD7AF], a
    ret

; 10 call sites from 8 routines (e.g. Func_01E_4A32, Func_01E_44EF, Func_00D_47F7, Func_014_4880, ...)
; reads: hFFB9, hFF8D, wCB7D
; writes: wD7BC, hFFB9, hFFBA, wD7BA, wD7BB, hFF8D, wCB7D
Func_01E_7745::
    ldh a, [hFFB9]
    ld [wD7BC], a
    xor a, a
    ldh [hFFB9], a
    ldh [hFFBA], a
    ldh a, [hFF8D]
    ld [wD7BA], a
    ld a, [wCB7D]
    ld [wD7BB], a
    ld a, $FF
    ldh [hFF8D], a
    xor a, a
    ld [wCB7D], a
    ret

; 5 call sites from 5 routines (e.g. Func_01E_6810, Func_01E_6074, Func_01E_5C63, Func_00D_4C9C, ...)
; reads: wD7BC, wD7BA, wD7BB
; writes: hFFB9, hFFBA, hFF8D, wCB7D
Func_01E_7763::
    ld a, [wD7BC]
    ldh [hFFB9], a
    ld a, $80
    ldh [hFFBA], a
    ld a, [wD7BA]
    ldh [hFF8D], a
    ld a, [wD7BB]
    ld [wCB7D], a
    ret

; 3 call sites from 1 routine (e.g. Func_01E_4A32)
Func_01E_7778::
    xor a, a
    ld b, $C3
    ld hl, $788A
    call Func_01E_741A
    ld a, $01
    ld b, $C3
    ld hl, $788A
    call Func_01E_741A
    ret
    INCBIN "dwm2-cobi-us.gbc", $07B78C, $49F
    ds $3D5, $00
