SECTION "Bank 15", ROMX[$4000], BANK[$15]
    db $15

; 4 call sites from 3 routines (e.g. Func_00D_50F1, Func_010_660C, Func_01E_4001)
; reads: wD788
Func_015_4001::
    ld a, [wD788]
    rst $00
    dw Jump_015_400D
    dw Jump_015_403F
    dw Jump_015_4076
    dw Jump_015_40AE

Jump_015_400D::
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_015_66AF
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_402B
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_015_66B8

Jump_015_402B::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

Jump_015_403F::
    ld hl, Data_015_72A9
    ld de, Data_015_72FF
    call Func_015_6374
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld [wD780], a
    ld [wD781], a
    ld [wC46B], a
    ld a, [wD788]
    inc a
    ld [wD788], a
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

Jump_015_4076::
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

Jump_015_40AE::
    farcall Func_01D_62AD
    farcall Func_016_7A64
    xor a, a
    ld [wD7F0], a
    ld [wD788], a
    ld bc, $006F
    ld hl, wD780

Jump_015_40C7::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_40C7
    ld hl, wC130
    ld b, $10

Jump_015_40D3::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_015_40D3
    farcall Func_002_470B
    ld a, $80
    ldh [hFFBA], a
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

; 27 call sites from 14 routines (e.g. Func_00D_473A, Func_00D_7195, Func_00D_719C, Func_00D_7590, ...)
; reads: wD780
Func_015_40FA::
    ld a, [wD780]
    rst $00
    dw Jump_015_4124
    dw Jump_015_4167
    dw Jump_015_41E1
    dw Jump_015_41E5
    dw Jump_015_422B
    dw Jump_015_50D1
    dw Jump_015_55D2
    dw Jump_015_56B0
    dw Jump_015_5E30
    dw Jump_015_5E62
    dw Jump_015_5ECC
    dw Jump_015_5EF6
    dw Jump_015_5FD9
    dw Jump_015_600C
    dw Jump_015_600C
    dw Jump_015_6028
    dw Jump_015_61B6
    dw Jump_015_62D9
    dw Jump_015_625C

Jump_015_4124::
    ld hl, wD780
    ld bc, $006F

Jump_015_412A::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_412A
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_015_66AF
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_414F
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_015_66B8

Jump_015_414F::
    ld a, $05
    ld [wD7F0], a
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4167::
    ld a, [wD781]
    rst $00
    dw Func_015_4171
    dw Func_015_4182
    dw Jump_015_41BD

; 4 call sites from 3 routines (e.g. Func_015_4C0C, Func_015_4439, Func_015_5A67)
; reads: wD781
; writes: wD781
Func_015_4171::
    ld hl, Data_015_72A9
    ld de, Data_015_72C5
    call Func_015_6374
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 6 call sites from 4 routines (e.g. Func_015_4C0C, Func_015_47A7, Func_015_512C, Func_015_5A67)
; reads: wD781
; writes: wD781
; points at: wC370, wC617, wC8C0, wC386, wD7F3
Func_015_4182::
    ld de, Data_015_7291
    ld hl, wC370
    ld bc, $0803
    call Func_015_65B7
    ld hl, wC617
    ld de, wC8C0
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    call Func_000_173A
    call Func_015_6676
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_015_41AA::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_015_41AA
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_41BD::
    ld de, Data_015_6F6B
    ld hl, wC364
    ld bc, $0807
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140B
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_015_41E1::
    call Func_015_6478
    ret

Jump_015_41E5::
    ld a, [wD786]
    and a, a
    jr z, Jump_015_41ED
    jr Jump_015_41F5

Jump_015_41ED::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_015_41F5::
    farcall Func_01D_6026
    ld a, [wD7B9]
    and a, a
    jr nz, Jump_015_4215
    ld a, $01
    ld [wD7FA], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4215::
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

Jump_015_422B::
    ld a, [wD781]
    rst $00
    dw Jump_015_42B3
    dw Jump_015_434C
    dw Jump_015_4363
    dw Jump_015_43AC
    dw Jump_015_43BD
    dw Jump_015_43F4
    dw Jump_015_4418
    dw Jump_015_444D
    dw Jump_015_4467
    dw Jump_015_44D3
    dw Jump_015_451B
    dw Jump_015_5358
    dw Jump_015_4550
    dw Jump_015_4570
    dw Jump_015_53B3
    dw Jump_015_45A5
    dw Jump_015_45B9
    dw Jump_015_45DC
    dw Jump_015_46D3
    dw Jump_015_4712
    dw Jump_015_4716
    dw Jump_015_4739
    dw Jump_015_4768
    dw Jump_015_43AC
    dw Func_015_4771
    dw Jump_015_479C
    dw Func_015_47A7
    dw Jump_015_47CF
    dw Jump_015_47E1
    dw Func_015_4439
    dw Jump_015_48AE
    dw Jump_015_491A
    dw Jump_015_4987
    dw Jump_015_4550
    dw Jump_015_4570
    dw Jump_015_53B3
    dw Jump_015_49C9
    dw Jump_015_4A2A
    dw Jump_015_4A4D
    dw Jump_015_4B02
    dw Jump_015_4BBE
    dw Jump_015_4C80
    dw Func_015_4C0C
    dw Jump_015_4C1D
    dw Jump_015_4C2E
    dw Jump_015_61F5
    dw Jump_015_5811
    dw Jump_015_4CE3
    dw Jump_015_4D2B
    dw Jump_015_4D6E
    dw Jump_015_4D46
    dw Jump_015_4D96
    dw Jump_015_4DB0
    dw Jump_015_5358
    dw Jump_015_4E47
    dw Jump_015_4D2B
    dw Jump_015_4D6E
    dw Jump_015_4D46
    dw Jump_015_4DE5
    dw Jump_015_4DF3
    dw Jump_015_4E1D
    dw Jump_015_6203
    dw Jump_015_57CB
    dw Jump_015_4F9A
    dw Jump_015_501D
    dw Jump_015_5030

Jump_015_42B3::
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_015_6791
    ld de, Data_015_42F4
    ld hl, wC364
    ld bc, $080B
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD7AE], a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_015_42F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0542F4, $58

Jump_015_434C::
    call Func_015_6A1A
    ld de, Data_015_747D
    ld hl, wC364
    ld bc, $080B
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4363::
    farcall Func_01D_5F2D

Jump_015_4369::
    farcall Func_01E_7163
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_43A4
    ld de, $0142
    call Func_015_6742
    ld hl, wC42E
    call Func_015_6772
    ld de, $0143
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01E_7564
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_015_43A4::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_43AC::
    farcall Func_01F_5C15
    xor a, a
    ld [wD7F1], a
    farcall Func_01D_6AA5
    ret

Jump_015_43BD::
    farcall Func_01D_5D84
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call Func_015_6866
    ld de, Data_015_74D5
    ld hl, wC3BC
    ld bc, $0C09
    call Func_015_65B7
    pop af
    ld [wD7F1], a
    ld hl, wC3D6
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    call Func_015_688D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_43F4::
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

Jump_015_4418::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_015_4439)
; reads: wD781
; writes: wD781
Func_015_4439::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_444D::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_015_73A1
    call Func_015_66CA
    call Func_015_4439
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_015_73A1
    call Func_015_66CA
    ret

Jump_015_4467::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_448B
    cp a, $FC
    jr z, Jump_015_448B
    cp a, $FD
    jr z, Jump_015_44CA
    cp a, $FE
    jr z, Jump_015_4494
    cp a, $FF
    jr z, Jump_015_449C
    ret

Jump_015_448B::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_015_4494::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_449C::
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
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

Jump_015_44CA::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_015_44D3::
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $09
    ld [wD7F2], a
    call Func_015_6791
    ld c, $09
    ld hl, $0224
    ld de, $0058
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call Func_015_6791
    ld de, Data_015_6FA3
    ld hl, wC364
    ld bc, $0807
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_451B::
    call Func_015_4171
    ld de, Data_015_6F6B
    ld hl, wC364
    ld bc, $0807
    call Func_015_65B7
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4550::
    ld de, Data_015_7379
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4570::
    ld a, $6C
    call StoreWC60B
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call Func_015_6374
    ld de, Data_015_7351
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [wD7FA], a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_45A5::
    ld de, Data_015_7505
    ld hl, wC40C
    ld bc, $0C05
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_45B9::
    ld c, $05
    ld hl, Data_015_73A1
    call Func_015_67E5
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $08
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_45DC::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    ld [wD7F5], a
    ld hl, wD789
    ld c, $00

Jump_015_4606::
    push hl
    push bc
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    ld b, a
    ld a, [wD7F5]
    cp a, b
    jr nz, Jump_015_463F
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr nz, Jump_015_4606
    pop hl
    ld a, $03
    ld [wD7FA], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_463F::
    pop bc
    pop hl
    pop hl
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $0A
    jr nc, Jump_015_466B
    pop hl
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_466B::
    pop hl
    ld a, [wC6FD]
    cp a, $02
    jr nc, Jump_015_4696
    ld a, [hl]
    ld b, a
    ld a, [wC6FE]
    cp a, b
    jr nz, Jump_015_4696
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4696::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7B4], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_46D3::
    ld a, $B6
    ld [wC378], a
    ld [wC3A0], a
    ld [wC3C8], a
    ld de, Data_015_7541
    ld hl, wC394
    ld bc, $0C03
    call Func_015_65B7
    ld de, Data_015_7505
    ld hl, wC40C
    ld bc, $0C05
    call Func_015_65B7
    ld c, $05
    ld hl, Data_015_73A1
    call Func_015_67E5
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4712::
    call Func_015_66D8
    ret

Jump_015_4716::
    call Func_015_69E3
    ld de, Data_015_7565
    ld hl, wC394
    ld bc, $0C03
    call Func_015_65B7
    ld de, Data_015_7589
    ld hl, wC40C
    ld bc, $0C05
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4739::
    ld hl, vTiles1 + $240
    ld bc, $0301
    call Func_000_1881
    ld hl, vTiles1 + $700
    ld bc, $0501
    call Func_000_1881
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call Func_000_1881
    ld de, Data_015_747D
    ld hl, wC364
    ld bc, $080B
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4768::
    call Func_015_69C6
    call Func_015_693F
    jp Jump_015_4369

; 2 call sites from 2 routines (e.g. Func_015_4C0C, Func_015_47A7)
; reads: wD781
; writes: wD7F1, wD7F2, wD7F3, wD781
; points at: wC426
Func_015_4771::
    farcall Func_01D_5D84
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [wD7F1], a
    call Func_015_6866
    pop af
    ld [wD7F1], a
    ld hl, wC426
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    call Func_015_688D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_479C::
    call Func_015_69E3
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_015_47A7, Func_015_60BF)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wCFA8, wCFA9, wD781
Func_015_47A7::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall Func_015_6A36
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_47CF::
    call Func_015_6A82
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_47E1::
    xor a, a
    ld [wD7F1], a
    farcall Func_00E_5688
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7F7]
    cp a, $FF
    jr nz, Jump_015_47FF
    ld a, [wD7F6]
    cp a, $FF
    jr z, Jump_015_485A

Jump_015_47FF::
    ld a, [wD7F6]
    ld [wD7F1], a
    ld [wD006], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld [wD007], a
    ld de, Data_015_75C5
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    call Func_015_68FA
    ld a, [wD7F5]
    cp a, $FF
    jr z, Jump_015_487A
    ld a, [wD7F6]
    ld [wD7F1], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld hl, wC7FC
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    call Func_015_68FA
    cp a, $FF
    jr z, Jump_015_487A
    ld a, [wD7F6]
    ld [wD006], a
    ld a, [wD7F7]
    ld [wD007], a
    farcall Func_016_5A7E
    ld a, c
    and a, a
    jr nz, Jump_015_487A

Jump_015_485A::
    ld c, $00
    ld hl, wC8CF

Jump_015_485F::
    ld a, $98
    ld [hl+], a
    inc c
    ld a, c
    cp a, $09
    jr c, Jump_015_485F
    ld a, $F0
    ld [hl], a
    ld de, Data_01F_4990
    ld hl, vTiles1 + $490
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    jr Jump_015_4899

Jump_015_487A::
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    call Func_015_6ACA
    ld hl, wCADD
    ld a, [hl]
    and a, $0F
    ld [wD09D], a
    ld a, $C9
    ld [wD09E], a
    farcall Func_016_7A48

Jump_015_4899::
    ld c, $00
    ld a, $04
    ld [wD7F5], a
    farcall Func_01D_6129
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_48AE::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_48D2
    cp a, $FC
    jr z, Jump_015_48D2
    cp a, $FD
    jr z, Jump_015_4911
    cp a, $FE
    jr z, Jump_015_48DB
    cp a, $FF
    jr z, Jump_015_48E3
    ret

Jump_015_48D2::
    ld a, [wD781]
    sub a, $09
    ld [wD781], a
    ret

Jump_015_48DB::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_48E3::
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
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

Jump_015_4911::
    ld a, [wD781]
    sub a, $06
    ld [wD781], a
    ret

Jump_015_491A::
    ld c, $03
    ld hl, $01FC
    ld de, $0030
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call Func_015_6791
    ld a, $B7
    ld [wC393], a
    ld [wC3A7], a
    call Func_015_4182
    ld de, Data_015_74D5
    ld hl, wC3BC
    ld bc, $0C01
    call Func_015_65B7
    ld de, Data_015_7511
    ld hl, wC420
    ld bc, $0C04
    call Func_015_65B7
    ld de, Data_015_4985
    ld hl, wC393
    ld bc, $0102
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Data_015_4985:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B7, $B7

Jump_015_4987::
    ld a, $9D
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, Func_015_6DE6
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall Func_01D_6C14
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    xor a, a
    ld [wD7FA], a
    ld [wD7AD], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld a, $01
    ld [wD781], a
    ret

Jump_015_49C9::
    ld de, Data_015_75F5
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_69FE
    call Func_015_47A7
    ld de, Data_015_7589
    ld hl, wC40C
    ld bc, $0C05
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_4771
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $25
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

Jump_015_4A2A::
    ld c, $05
    ld hl, Data_015_73A1
    call Func_015_67E5
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $1E
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4A4D::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    cp a, $0A
    jr nc, Jump_015_4A88
    ld a, $03
    ld [wD7FA], a
    ld a, $24
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4A88::
    ld a, [wC6FD]
    cp a, $03
    jr z, Jump_015_4AED
    cp a, $01
    jr z, Jump_015_4AD6
    ld a, [wD7B4]
    ld b, a
    ld a, [wC6FE]
    cp a, b
    jr z, Jump_015_4AA5
    ld a, [wC6FF]
    cp a, b
    jr z, Jump_015_4AA5
    jr Jump_015_4AED

Jump_015_4AA5::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld b, [hl]
    ld a, [wC6FE]
    cp a, b
    jr z, Jump_015_4AC2
    ld a, [wC6FF]
    cp a, b
    jr z, Jump_015_4AC2
    jr Jump_015_4AED

Jump_015_4AC2::
    ld a, $02
    ld [wD7FA], a
    ld a, $24
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4AD6::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld b, [hl]
    ld a, [wC6FE]
    cp a, b
    jr nz, Jump_015_4AED
    jr Jump_015_4AC2

Jump_015_4AED::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4B02::
    ld hl, wCADB
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld hl, wC7FC
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    call Func_015_68FA
    cp a, $FF
    jr nz, Jump_015_4B21
    jr Jump_015_4B55

Jump_015_4B21::
    ld hl, wCADB
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    farcall Func_016_5A7E
    ld a, c
    and a, a
    jr z, Jump_015_4B38
    jr Jump_015_4B55

Jump_015_4B38::
    ld hl, wCADB
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld hl, Data_015_75C5
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    call Func_015_68FA
    cp a, $FF
    jr nz, Jump_015_4BA7

Jump_015_4B55::
    ld de, wCADB
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_015_6ACA
    ld hl, wC8CF
    ld de, wC130

Jump_015_4B66::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_4B70
    ld [de], a
    inc de
    inc hl
    jr Jump_015_4B66

Jump_015_4B70::
    ld a, $A2
    ld [de], a
    inc de
    ld hl, wCB3D
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_015_68DC
    ld a, [wC8C1]
    cp a, $E3
    jr z, Jump_015_4B8A
    ld [de], a
    inc de

Jump_015_4B8A::
    ld a, [wC8C2]
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4BA7::
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4BBE::
    ld hl, wCADB
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    call Func_015_68FA
    cp a, $FF
    jr z, Jump_015_4BF7
    ld hl, wCADB
    ld a, [hl+]
    ld [wD006], a
    ld a, [hl]
    ld [wD007], a
    farcall Func_016_5A7E
    ld a, c
    and a, a
    jr nz, Jump_015_4BF7
    ld a, $01
    ld [wD7FA], a
    jr Jump_015_4BFB

Jump_015_4BF7::
    xor a, a
    ld [wD7FA], a

Jump_015_4BFB::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_015_4C0C)
; reads: wC58A, wD781
; writes: wD781
Func_015_4C0C::
    ld a, [wC58A]
    and a, a
    jr z, Jump_015_4C15
    call Func_015_645F

Jump_015_4C15::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4C1D::
    ld a, [wC58A]
    and a, a
    jr z, Jump_015_4C26
    call Func_015_6B00

Jump_015_4C26::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4C2E::
    call Func_015_63D3
    ld a, [wD782]
    cp a, $02
    jr z, Jump_015_4C4D
    cp a, $03
    jr z, Jump_015_4C66
    call Func_015_642D
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_015_4C4D::
    ld a, [wC58A]
    and a, a
    jr z, Jump_015_4C5E
    ld a, $0D
    ld [wC529], a
    farcall Func_01B_4C86

Jump_015_4C5E::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_015_4C66::
    ld a, [wC52B]
    and a, a
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4C80::
    ld a, [wD782]
    and a, a
    jr nz, Jump_015_4C8A
    call Func_015_6EA5
    ret

Jump_015_4C8A::
    xor a, a
    ld [wD782], a
    ld a, [wC58A]
    and a, a
    jr z, Jump_015_4CD9
    ld de, Data_015_75F5
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_69FE
    call Func_015_47A7
    ld de, Data_015_7589
    ld hl, wC40C
    ld bc, $0C05
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_4771
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1

Jump_015_4CD9::
    ld a, $2A
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ret

Jump_015_4CE3::
    ld a, [wC58A]
    and a, a
    jr z, Jump_015_4D1E
    farcall Func_01D_6540
    ld a, [wD7F9]
    cp a, $FE
    jr z, Jump_015_4CFE
    cp a, $FF
    jr z, Jump_015_4D14
    call Func_015_63D3
    ret

Jump_015_4CFE::
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

Jump_015_4D14::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_015_4CFE
    call Func_015_63D3

Jump_015_4D1E::
    ld a, [wD781]
    add a, $07
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_015_4D2B::
    ld de, Data_015_761D
    ld hl, wC412
    ld bc, $0605
    call Func_015_65B7
    call Func_015_4C0C
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ret

Jump_015_4D46::
    ld a, $9D
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, Func_015_6DE6
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

Jump_015_4D6E::
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call Func_015_6791
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4D96::
    call Func_015_4171
    call Func_015_4182
    ld de, Data_015_6F6B
    ld hl, wC364
    ld bc, $0807
    call Func_015_65B7
    ld a, [wD781]
    dec a
    ld [wD781], a
    ret

Jump_015_4DB0::
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4DE5::
    call Func_015_4171
    call Func_015_4182
    ld a, [wD781]
    dec a
    ld [wD781], a
    ret

Jump_015_4DF3::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4E1D::
    ld hl, wCB3D
    ld a, [hl]
    ldh [hFFC6], a
    call Func_015_67F9
    call Func_015_6822
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4E47::
    ld a, [wD782]
    and a, a
    jr z, Jump_015_4EB1
    cp a, $01
    jr z, Jump_015_4E87
    cp a, $02
    jr z, Jump_015_4E6B
    ld a, [wC52B]
    and a, a
    jr z, Jump_015_4E5F
    call Func_015_63D3
    ret

Jump_015_4E5F::
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4E6B::
    call Func_015_63D3
    ld a, [wC58A]
    and a, a
    jr z, Jump_015_4E7F
    ld a, $0E
    ld [wC529], a
    farcall Func_01B_4C86

Jump_015_4E7F::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_015_4E87::
    call Func_015_63D3
    ld a, [wC58A]
    and a, a
    jr z, Jump_015_4E9C
    farcall Func_002_7347
    ld a, [wC8C3]
    bit 7, a
    ret z

Jump_015_4E9C::
    xor a, a
    ld [wD7FA], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_4EB1::
    call Func_015_63D3
    ld a, [wD7B4]
    ld b, a
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld b, [hl]
    push bc
    ld a, b
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    pop bc
    ld a, [wD7B4]
    cp a, b
    jr c, Jump_015_4EDE
    dec a

Jump_015_4EDE::
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    ld [wD7B4], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    ld de, wCAD0
    ld b, $A5

Jump_015_4F07::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_4F07
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld hl, wCADB
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld de, wC7FC
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    call Func_015_68F3
    ld hl, wD7E0
    ld b, $07

Jump_015_4F36::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_4F36
    farcall Func_016_5AAF
    call Func_015_6E64
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wC6FD
; points at: wC6FE
Func_015_4F4C:: ; heuristic: follows a terminator; C0
    ld hl, wC6FE
    ld c, $00

Jump_015_4F51::
    ld a, [hl]
    cp a, b
    jr nz, Jump_015_4F61
    ld a, $FF
    ld [hl], a
    ld a, [wC6FD]
    dec a
    ld [wC6FD], a
    jr Jump_015_4F69

Jump_015_4F61::
    inc hl
    inc c
    ld a, [wC6FD]
    cp a, c
    jr nz, Jump_015_4F51

Jump_015_4F69::
    ld hl, wC6FE
    ld de, wC6FE
    ld c, $00

Jump_015_4F71::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_015_4F78
    jr Jump_015_4F7A

Jump_015_4F78::
    ld [de], a
    inc de

Jump_015_4F7A::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_4F71
    ld hl, wC6FE
    ld c, $00

Jump_015_4F86::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_015_4F90
    cp a, b
    jr z, Jump_015_4F90
    jr Jump_015_4F92

Jump_015_4F90::
    xor a, a
    ld [hl], a

Jump_015_4F92::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_4F86
    ret

Jump_015_4F9A::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_015_4FAE
    cp a, $FF
    jr z, Jump_015_4FC4
    ret

Jump_015_4FAE::
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

Jump_015_4FC4::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_015_4FAE
    ld hl, wCB3D
    ld a, [hl]
    ldh [hFFC6], a
    call Func_015_680F
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_015_5003
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

Jump_015_5003::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_501D::
    xor a, a
    ld [wD781], a
    ld a, $0A
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5030::
    ld hl, wCB3D
    ld a, [hl]
    ldh [hFFC6], a
    call Func_015_680F
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    call Func_015_683C
    ld hl, wD7BE
    ld c, $00

Jump_015_504D::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_504D
    farcall Func_01D_6026
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD7B1], a
    ld [wD7B0], a
    ld hl, wD789
    ld a, [wD7B4]
    ld b, a
    ld c, $00

Jump_015_5071::
    ld a, [hl]
    cp a, b
    jr z, Jump_015_5084
    inc c
    inc hl
    ld a, [wD7AB]
    inc a
    ld [wD7AB], a
    ld a, [wD7A9]
    cp a, c
    jr nz, Jump_015_5071

Jump_015_5084::
    ld a, [wD7AB]
    srl a
    srl a
    ld [wD7AF], a
    ld a, [wD7AB]

Jump_015_5091::
    cp a, $04
    jr c, Jump_015_5099
    sub a, $04
    jr Jump_015_5091

Jump_015_5099::
    ld [wD7AB], a
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6E
    call SRAMRecordAddress
    xor a, a
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [wD781], a
    ld a, $08
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_50D1::
    ld a, [wD781]
    rst $00
    dw Jump_015_50F7
    dw Jump_015_50FB
    dw Func_015_512C
    dw Jump_015_5165
    dw Jump_015_51D6
    dw Jump_015_51E9
    dw Jump_015_520D
    dw Jump_015_52BD
    dw Jump_015_52FF
    dw Jump_015_5358
    dw Jump_015_5376
    dw Jump_015_5387
    dw Jump_015_53B3
    dw Jump_015_6074
    dw Jump_015_54E6
    dw Jump_015_5504
    dw Jump_015_556A

Jump_015_50F7::
    call Func_015_66DF
    ret

Jump_015_50FB::
    ld de, Data_015_6FDB
    ld hl, wC3BB
    ld bc, $0D09
    call Func_015_65B7
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    farcall Func_01D_6026
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_015_5A67)
; reads: wD781
; writes: wD781
; points at: wC52D
Func_015_512C::
    ld hl, vTiles1 + $400
    ld bc, $0301
    call Func_000_1881
    ld hl, vTiles1 + $470
    ld bc, $0501
    call Func_000_1881
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld hl, vTiles1 + $700
    ld bc, $0D01
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

Jump_015_5165::
    ld de, Data_015_7050
    ld hl, wC3BB
    ld bc, $0D09
    call Func_015_65B7
    farcall Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_51AC
    ld de, $018E
    call Func_015_6742
    ld hl, wC462
    call Func_015_6772
    ld de, $018F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall Func_01E_7564
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_015_51AC::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_015_7333
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_015_7333
    call Func_015_66CA
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_51D6::
    ld a, $01
    ld [wD7F5], a
    farcall Func_01D_6088
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_51E9::
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD7F1], a
    ld a, $01
    ld [wD7F2], a
    farcall Func_01D_6320
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_520D::
    ld a, $02
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_5232
    cp a, $FC
    jr z, Jump_015_5232
    cp a, $FD
    jr z, Jump_015_523B
    cp a, $FE
    jr z, Jump_015_523C
    cp a, $FF
    jr z, Jump_015_525F
    ret

Jump_015_5232::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_015_523B::
    ret

Jump_015_523C::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
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
    ret

Jump_015_525F::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_7333
    call Func_015_66CA
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call Func_015_67F9
    call Func_015_6822
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

Jump_015_52BD::
    ld c, $09
    ld hl, $0223
    ld de, $0057
    xor a, a
    ld [wD7F1], a
    ld a, $0D
    ld [wD7F2], a
    call Func_015_6791
    ld a, [wC89D]
    or a, a
    jr z, Jump_015_52EB
    ld de, Data_015_7345
    ld hl, wC3BB
    ld bc, $0403
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_52EB::
    ld de, Data_015_733F
    ld hl, wC3BA
    ld bc, $0203
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_52FF::
    ld a, [wD782]
    and a, a
    jr nz, Jump_015_5323
    call Func_015_4182
    ld a, [wD781]
    dec a
    ld [wD781], a
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_015_5323::
    ld a, $9C
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, Func_015_6DE6
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall Func_01D_6C14
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5358::
    ld c, $03
    ld hl, Data_015_732D
    call Func_015_67E5
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

Jump_015_5376::
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call Func_015_6374
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5387::
    ld a, $6C
    call StoreWC60B
    ld de, Data_015_7351
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [wD7B7], a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_53B3::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_015_53CF
    bit 7, a
    jr nz, Jump_015_53E9
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_015_53F9
    bit 1, a
    jp nz, Jump_015_5488
    call Func_015_549E
    ret

Jump_015_53CF::
    call Func_015_54BC
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_015_53DC
    ld a, $01
    jr Jump_015_53DD

Jump_015_53DC::
    dec a

Jump_015_53DD::
    ld [wD7AD], a
    call Func_015_549E
    ld a, $69
    call StoreWC60B
    ret

Jump_015_53E9::
    call Func_015_54BC
    ld a, [wD7AD]
    cp a, $01
    jr c, Jump_015_53F6
    xor a, a
    jr Jump_015_53DD

Jump_015_53F6::
    inc a
    jr Jump_015_53DD

Jump_015_53F9::
    ld a, $69
    call StoreWC60B
    call Func_015_54C0
    ld a, [wD7AD]
    and a, a
    jp nz, Jump_015_5471
    ld a, [wD780]
    cp a, $04
    jr z, Jump_015_5415
    cp a, $05
    jr z, Jump_015_5438
    jr Jump_015_5446

Jump_015_5415::
    ld a, [wD781]
    cp a, $22
    jr c, Jump_015_542A
    ld a, $04
    ld [wD7B2], a
    ld a, $23
    ld [wD7B3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_542A::
    ld a, $04
    ld [wD7B2], a
    ld a, $0E
    ld [wD7B3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_5438::
    ld a, $05
    ld [wD7B2], a
    ld a, $0C
    ld [wD7B3], a
    ld a, $0D
    jr Jump_015_5454

Jump_015_5446::
    ld a, $07
    ld [wD7B2], a
    ld a, $18
    ld [wD7B3], a
    ld a, $0E
    jr Jump_015_5454

Jump_015_5454::
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld [wD7FA], a
    farcall Func_01E_7745
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5471::
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

Jump_015_5488::
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

; 2 call sites from 1 routine (e.g. Func_015_512C)
; reads: wC564, wD7AE, wD7AD
; writes: wD7AE
Func_015_549E::
    ld a, [wC564]
    cp a, $14
    jr c, Jump_015_54B8
    ld a, [wD7AE]
    inc a
    ld [wD7AE], a
    cp a, $10
    jr c, Jump_015_54B8
    cp a, $18
    jr c, Func_015_54BC
    xor a, a
    ld [wD7AE], a

Jump_015_54B8::
    ld b, $BB
    jr Jump_015_54C2

; 2 call sites from 1 routine (e.g. Func_015_512C)
; reads: wD7AD
Func_015_54BC::
    ld b, $C3
    jr Jump_015_54C2

; 1 call site from 1 routine (e.g. Func_015_512C)
; reads: wD7AD
Func_015_54C0::
    ld b, $BC

Jump_015_54C2::
    ld a, [wD7AD]
    add a, a
    ld hl, Data_015_54E2
    add a, l
    ld l, a
    jr nc, Jump_015_54CE
    inc h

Jump_015_54CE::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_015_6655
    pop de
    add hl, de
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_015_54E2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

Jump_015_54E6::
    call Func_015_60BF
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $06
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5504::
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call Func_015_680F
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_015_5555
    ld a, $01
    ld [wD7FA], a
    ld a, $07
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5555::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_556A::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld a, $6E
    add a, l
    ld l, a
    jr nc, Jump_015_5593
    inc h

Jump_015_5593::
    xor a, a
    ld [hl], a
    pop hl
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call Func_015_680F
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    call Func_015_683C
    ld hl, wD7BE
    ld c, $00

Jump_015_55B7::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_55B7
    xor a, a
    ld [wD781], a
    ld a, $09
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_55D2::
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    ld [wD7F2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $1F
    ld [wD7F3], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [wD7F4], a
    ldh a, [hFFC7]
    ld [wD7F5], a
    pop hl
    ld a, [hl]
    ld [wD7B4], a
    ld a, $01
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    farcall Func_014_5CA8
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7B4]
    ld c, $01
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $0A
    ld de, wC8CF

Jump_015_5648::
    ld a, [de]
    cp a, $F0
    jr z, Jump_015_5654
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_015_5648
    jr Jump_015_5657

Jump_015_5654::
    ld a, $F0
    ld [hl], a

Jump_015_5657::
    ld a, [wD7B4]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wC986
    ld b, $A5

Jump_015_5668::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_5668
    xor a, a
    ld [rRAMG2], a
    ld a, [wD7B4]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
    ld a, [wD7F5]
    ld [wD7B4], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    ld de, wC986
    ld b, $A5

Jump_015_569E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_569E
    xor a, a
    ld [rRAMG2], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_015_56B0::
    ld a, [wD781]
    rst $00
    dw Jump_015_56F6
    dw Func_015_570C
    dw Jump_015_571D
    dw Jump_015_5746
    dw Jump_015_57A4
    dw Jump_015_57CB
    dw Jump_015_5823
    dw Func_015_4182
    dw Jump_015_58D2
    dw Jump_015_5920
    dw Jump_015_593E
    dw Jump_015_59B8
    dw Jump_015_5A97
    dw Jump_015_5ACA
    dw Jump_015_5AF5
    dw Jump_015_5AFC
    dw Jump_015_5B33
    dw Jump_015_5B62
    dw Jump_015_5B82
    dw Jump_015_5B96
    dw Jump_015_5C19
    dw Jump_015_5C5B
    dw Jump_015_5376
    dw Jump_015_5387
    dw Jump_015_53B3
    dw Jump_015_5C7D
    dw Jump_015_5CDC
    dw Jump_015_5CF7
    dw Jump_015_5D3E
    dw Jump_015_5DBB
    dw Jump_015_5DCE
    dw Jump_015_5E0C
    dw Jump_015_5358

Jump_015_56F6::
    ld b, $46
    ld de, Func_015_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    call Func_015_6E14
    ret

; 2 call sites from 1 routine (e.g. Func_015_5A67)
; reads: wD781
; writes: wD781
Func_015_570C::
    ld hl, Data_015_72A9
    ld de, Data_015_72C5
    call Func_015_6374
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_571D::
    ld a, $0D
    ldh [hFF90], a
    call Func_000_1C0C
    call Func_000_19A9
    farcall Func_004_4AA8
    farcall Func_069_4001
    call Func_015_6E14
    xor a, a
    ldh [hFF8D], a
    ld a, $7F
    ld [wC527], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5746::
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_015_66AF
    ld hl, wC300
    ld de, wC29C
    ld bc, $0064
    call Func_015_66AF
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_577C
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_015_66B8
    ld hl, wD168
    ld de, wD104
    ld bc, $0064
    call Func_015_66B8

Jump_015_577C::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_6655
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_015_65F1
    ld a, $70
    ldh [hFFBA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_57A4::
    ld hl, wC8CF
    ld de, wC130
    ld c, $0A

Jump_015_57AC::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_57B7
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_015_57AC

Jump_015_57B7::
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_57CB::
    ld de, Data_01F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call Func_015_63D3
    ld a, $6C
    call StoreWC60B
    ld de, Data_015_73AB
    ld hl, wC412
    ld bc, $0605
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ret

Jump_015_5811::
    ld a, [wC58A]
    and a, a
    jr nz, Jump_015_57CB
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ret

Jump_015_5823::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_015_5837
    cp a, $FF
    jr z, Jump_015_5850
    ret

Jump_015_5837::
    call Func_015_586D
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

Jump_015_5850::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_015_5837
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 2 routines (e.g. Func_015_58B4, Func_015_570C)
; reads: wIsCGB
; points at: wC412, wC246, wD27A, wD0AE
Func_015_586D::
    ld hl, wC412
    ld de, wC246
    ld c, $05
    call Func_015_5896
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_5889
    ld hl, wD27A
    ld de, wD0AE
    ld c, $05
    call Func_015_58B4

Jump_015_5889::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ret

; 1 call site from 1 routine (e.g. Func_015_586D)
Func_015_5896::
    push hl
    push de
    push bc
    ld bc, $0006
    call Func_015_66AF
    pop bc
    pop de
    pop hl
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_015_58A9
    inc h

Jump_015_58A9::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_015_58B0
    inc d

Jump_015_58B0::
    dec c
    jr nz, Func_015_5896
    ret

; 1 call site from 1 routine (e.g. Func_015_586D)
Func_015_58B4::
    push hl
    push de
    push bc
    ld bc, $0006
    call Func_015_66B8
    pop bc
    pop de
    pop hl
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_015_58C7
    inc h

Jump_015_58C7::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_015_58CE
    inc d

Jump_015_58CE::
    dec c
    jr nz, Func_015_58B4
    ret

Jump_015_58D2::
    ld de, Data_01F_43C0
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_42D0
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_015_6F6B
    ld hl, wC364
    ld bc, $0807
    call Func_015_65B7
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140B
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5920::
    ld c, $03
    ld hl, Data_015_732D
    call Func_015_67E5
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

Jump_015_593E::
    ld a, [wC6FD]
    cp a, $03
    jr nc, Jump_015_5998
    ld hl, wC6FE
    ld a, [wC6FD]
    add a, l
    ld l, a
    jr nc, Jump_015_5950
    inc h

Jump_015_5950::
    ld a, [wD7B4]
    ld [hl], a
    ld a, [wC6FD]
    inc a
    ld [wC6FD], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $00
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    call Func_015_586D
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5998::
    ld a, [wD7FA]
    ld b, $BC
    ld hl, Data_015_733B
    call Func_015_66CA
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_59B8::
    ld de, Data_015_59E5
    ld hl, wC364
    ld bc, $0809
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_5A2D
    xor a, a
    ld [wD7AF], a
    ld [wD7AB], a
    ld [wD7AE], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_015_59E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0559E5, $41

Jump_015_5A26::
    or a, h
    or a, h

Jump_015_5A28::
    or a, h
    or a, h
    or a, h
    or a, h
    or a, l

; 1 call site from 1 routine (e.g. Func_015_58B4)
Func_015_5A2D::
    ld c, $10

Jump_015_5A2F::
    push bc
    ld a, c
    ld de, Func_015_5A67
    add a, e
    ld e, a
    jr nc, Jump_015_5A39
    inc d

Jump_015_5A39::
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
    ld de, Data_015_5A77
    add a, e
    ld e, a
    jr nc, Jump_015_5A55
    inc d

Jump_015_5A55::
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
    dec c
    jr nz, Jump_015_5A2F
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wC52D, wC364
Func_015_5A67:: ; heuristic: follows a terminator; C0
    and a, e
    ld d, b
    ld b, h
    ld de, $1916
    ld c, b
    inc h
    and a, [hl]
    ld [de], a
    ld sp, $3229
    jr Jump_015_5A8A
    db $25

Data_015_5A77:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00

Jump_015_5A8A::
    sub a, a
    db $10, $97 ; stop
    jr nz, Jump_015_5A26
    jr nc, Jump_015_5A28
    ld b, b
    sub a, a
    ld d, b
    sub a, a
    ld h, b
    sub a, a

Jump_015_5A97::
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld hl, vTiles1 + $700
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
    ld de, Data_015_73C9
    ld hl, wC364
    ld bc, $0809
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5ACA::
    ld a, [wC6FE]
    ld [wD789], a
    ld a, [wC6FF]
    ld [wD78A], a
    ld a, [wC700]
    ld [wD78B], a
    ld a, [wD7B4]
    ld [wD78C], a
    ld a, $04
    ld [wD7A9], a
    farcall Func_01E_7163
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5AF5::
    farcall Func_01F_5C15
    ret

Jump_015_5AFC::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call Func_015_6866
    ld de, Data_015_7411
    ld hl, wC36C
    ld bc, $0C09
    call Func_015_65B7
    pop af
    ld [wD7F1], a
    farcall Func_01D_5B4D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5B33::
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
    ld hl, wC378
    ld c, $28
    call Func_015_656C
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5B62::
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    farcall Func_01D_5CD7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5B82::
    call Func_015_6655
    ld bc, $140B
    ld de, $01CC
    call Func_015_65F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5B96::
    xor a, a
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_5BBA
    cp a, $FC
    jr z, Jump_015_5BBA
    cp a, $FD
    jr z, Jump_015_5C10
    cp a, $FE
    jr z, Jump_015_5BC3
    cp a, $FF
    jr z, Jump_015_5BD9
    ret

Jump_015_5BBA::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_015_5BC3::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5BD9::
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
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

Jump_015_5C10::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_015_5C19::
    ld de, Data_01F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $09
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call Func_015_6791
    ld de, Data_015_73AB
    ld hl, wC412
    ld bc, $0601
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5C5B::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_570C
    ld a, $06
    ld [wD781], a
    xor a, a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5C7D::
    ld de, Data_01F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_015_6791
    ld de, Data_015_73AB
    ld hl, wC412
    ld bc, $0605
    call Func_015_65B7
    ld de, Data_015_7471
    ld hl, wC40C
    ld bc, $0C01
    call Func_015_65B7
    xor a, a
    ld b, $BC
    ld hl, Data_015_733B
    call Func_015_66CA
    ld c, $04
    ld hl, Data_015_73A1
    call Func_015_67E5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5CDC::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $13
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5CF7::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AB]
    add a, l
    ld l, a
    jr nc, Jump_015_5D0B
    inc h

Jump_015_5D0B::
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    xor a, a
    ld [rRAMG2], a
    ld a, $F0
    ld [wC8D9], a
    ld hl, wC8CF
    ld de, wC130

Jump_015_5D20::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_5D2A
    ld [de], a
    inc hl
    inc de
    jr Jump_015_5D20

Jump_015_5D2A::
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5D3E::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AB]
    add a, l
    ld l, a
    jr nc, Jump_015_5D52
    inc h

Jump_015_5D52::
    ld a, [hl]
    ld c, $00
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD7AB]
    cp a, $03
    jr z, Jump_015_5DB3
    ld hl, wD789
    ld a, [wD7AB]
    add a, l
    ld l, a
    jr nc, Jump_015_5D71
    inc h

Jump_015_5D71::
    ld a, $FF
    ld [hl], a
    ld hl, wD789
    ld de, wC6FE
    ld c, $00

Jump_015_5D7C::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_015_5D84
    inc hl
    jr Jump_015_5D88

Jump_015_5D84::
    ld [de], a
    inc hl
    inc de
    inc c

Jump_015_5D88::
    ld a, c
    cp a, $03
    jr c, Jump_015_5D7C
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wC6FE
    ld c, $00

Jump_015_5D9B::
    push bc
    push hl
    ld a, [hl]
    ld c, $00
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_5D9B
    xor a, a
    ld [rRAMG2], a

Jump_015_5DB3::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5DBB::
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5DCE::
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call Func_015_6791
    ld de, Data_01F_43C0
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_42D0
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_015_6F6B
    ld hl, wC364
    ld bc, $0807
    call Func_015_65B7
    call Func_015_4182
    ret

Jump_015_5E0C::
    call Func_015_570C
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_015_5E30::
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $17
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    ld a, $06
    ld [wD780], a
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ret

Jump_015_5E62::
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    push hl
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld [wCADB], a
    ldh a, [hFFC7]
    ld [wCADC], a
    pop hl
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld [wCB3D], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $16
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    ld a, $06
    ld [wD780], a
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ret

Jump_015_5ECC::
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $15
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    ld hl, wD780
    inc [hl]
    ret

Jump_015_5EF6::
    ld a, [wD781]
    rst $00
    dw Jump_015_5F1F
    dw Jump_015_56F6
    dw Func_015_570C
    dw Jump_015_571D
    dw Jump_015_5746
    dw Jump_015_5F0A
    dw Jump_015_5F51
    dw Jump_015_5FAD

Jump_015_5F0A::
    call Func_015_4182
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_015_5F1E
    farcall Func_01C_42B3
    ld a, $FC
    call Func_000_0DF2

Jump_015_5F1E::
    ret

Jump_015_5F1F::
    call Func_015_6655
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_5F51::
    ld a, [wC56C]
    and a, a
    ret nz
    ld de, wCADB
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_015_6ACA
    ld hl, wC8CF
    ld de, wC130
    ld c, $00

Jump_015_5F69::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_5F77
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_015_5F69

Jump_015_5F77::
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
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

Jump_015_5FAD::
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $01
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

Jump_015_5FD9::
    farcall Func_01E_4069
    ld a, [wD781]
    cp a, $0A
    ret nz
    ld a, [wD7B3]
    cp a, $23
    jr nz, Jump_015_5FFC
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $06
    ld [wD780], a
    ret

Jump_015_5FFC::
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $05
    ld [wD780], a
    ret

Jump_015_600C::
    farcall Func_01E_4069
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ret

Jump_015_6028::
    ld a, [wD781]
    rst $00
    dw Jump_015_603E
    dw Jump_015_6063
    dw Jump_015_6070
    dw Jump_015_6074
    dw Jump_015_60AC
    dw Func_015_60BF
    dw Jump_015_60E2
    dw Jump_015_6101
    dw Jump_015_6155

Jump_015_603E::
    ld hl, vTiles2
    ld de, Data_047_629A
    ld b, $47
    call DecompressToVRAM
    ld hl, wC49F
    ld de, Data_047_67E2
    ld b, $47
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_6063::
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call Func_015_6374
    call Func_015_4171
    ret

Jump_015_6070::
    call Func_015_512C
    ret

Jump_015_6074::
    ld de, Data_015_7050
    ld hl, wC3BB
    ld bc, $0D09
    call Func_015_65B7
    farcall Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_60A4
    ld hl, wC462
    call Func_015_6772
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_015_60A4::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_60AC::
    ld a, $01
    ld [wD7F5], a
    farcall Func_01D_6088
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 1 call site from 1 routine (e.g. Func_015_54C0)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
Func_015_60BF::
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wD7F1], a
    ld [wD7F2], a
    farcall Func_01D_6320
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_60E2::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_7333
    call Func_015_66CA
    ld de, Data_015_7351
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_6101::
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call Func_015_67F9
    call Func_015_6822
    xor a, a
    ld [wC528], a
    ld a, $1B
    ld [wC529], a
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
    farcall Func_01B_4C94
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_6155::
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_6655
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_015_65F1
    farcall Func_01E_7763
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
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

Jump_015_61B6::
    ld a, [wD781]
    rst $00
    dw Jump_015_603E
    dw Jump_015_6063
    dw Jump_015_61CE
    dw Jump_015_5AF5
    dw Jump_015_5AFC
    dw Jump_015_5B33
    dw Jump_015_5B62
    dw Jump_015_6203
    dw Jump_015_6235
    dw Jump_015_6155

Jump_015_61CE::
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld hl, vTiles1 + $700
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_61F5::
    ld a, [wC58A]
    and a, a
    jr nz, Jump_015_6203
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_6203::
    call Func_015_63D3
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_6235::
    ld c, $04
    ld hl, Data_015_73A1
    call Func_015_67E5
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
    ld de, Data_015_7351
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_625C::
    ld a, [wD781]
    rst $00
    dw Jump_015_603E
    dw Jump_015_62C9
    dw Func_015_4171
    dw Jump_015_6336
    dw Jump_015_62D2
    dw Jump_015_5376
    dw Jump_015_6359
    dw Jump_015_6276
    dw Jump_015_47E1
    dw Jump_015_629F
    dw Jump_015_6155

Jump_015_6276::
    ld hl, vTiles1 + $270
    ld bc, $0901
    call Func_000_1881
    ld hl, vTiles1 + $780
    ld bc, $0501
    call Func_000_1881
    ld a, [wD7B4]
    ld [wD7F1], a
    farcall Func_01D_5CD7
    call Func_015_6A82
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_629F::
    ld a, $C7
    ld [wD7F1], a
    ld a, [wD7B4]
    ld b, a
    call Func_015_6866
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [wD7F1], a
    call Func_015_6866
    pop af
    call Func_015_6360
    ret

Jump_015_62C9::
    call Func_015_69C6
    call Func_015_693F
    jp Jump_015_62F7

Jump_015_62D2::
    call Func_015_69E3
    call Func_015_47A7
    ret

Jump_015_62D9::
    ld a, [wD781]
    rst $00
    dw Jump_015_603E
    dw Jump_015_6063
    dw Jump_015_62F1
    dw Jump_015_6336
    dw Jump_015_6359
    dw Jump_015_43BD
    dw Jump_015_43F4
    dw Jump_015_4418
    dw Func_015_6360
    dw Jump_015_6155

Jump_015_62F1::
    farcall Func_01D_5F2D

Jump_015_62F7::
    farcall Func_01E_7163
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_631B
    ld hl, wC42E
    call Func_015_6772
    ld hl, wC42F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_015_631B::
    ld c, $05
    ld hl, Data_015_73A1
    call Func_015_67E5
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_6336::
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call Func_000_1881
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call Func_000_1881
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call Func_000_1881
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_6359::
    farcall Func_01F_5C15
    ret

; 1 call site from 1 routine (e.g. Func_015_60BF)
; reads: wD781
; writes: wD781
; points at: wC410
Func_015_6360::
    ld de, Data_015_7351
    ld hl, wC410
    ld bc, $0805
    call Func_015_65B7
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; 6 call sites from 6 routines (e.g. Func_015_4439, Func_015_570C, Func_015_5A67, Func_015_512C, ...)
; reads: wD785
; writes: wD785, wD784
Func_015_6374::
    push hl
    push de
    ld a, [wD785]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_015_637F
    inc h

Jump_015_637F::
    ld a, [hl]
    cp a, $FF
    jp z, Jump_015_63AE
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wD785]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_015_6395
    inc d

Jump_015_6395::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    jr Func_015_6374

Jump_015_63AE::
    pop de
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

; 2 call sites from 2 routines (e.g. Func_015_6B00, Func_016_777B)
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5
Func_015_63B8::
    ld a, $A4
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall Func_01D_6973
    ret

; 9 call sites from 3 routines (e.g. Func_015_4C0C, Func_015_570C, Func_015_60BF)
; reads: wC58A, wD780, wD781
; writes: rRAMG2, rRAMB, wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6
; points at: sBB0F
Func_015_63D3::
    ld a, [wC58A]
    and a, a
    ret z
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sBB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, Jump_015_63F5

Jump_015_63ED::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Jump_015_63F5::
    ld a, [wD780]
    cp a, $04
    jr nz, Jump_015_63ED
    ld a, [wD781]
    cp a, $37
    jr nc, Jump_015_63ED

; 2 call sites from 2 routines (e.g. Func_00D_615E, Func_0F1_5B0F)
; writes: rRAMB, rRAMG2, wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6
Func_015_6403::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ld a, $90
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    ld a, $88
    ld [wD7F4], a
    ld a, $28
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    farcall Func_01D_6A3F
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_00D_5A5C, Func_0F0_4CA0)
; reads: wC58A, wD782
; writes: wD782
; points at: wC3C8
Func_015_642D::
    ld a, [wC58A]
    and a, a
    jr nz, Jump_015_6439
    ld a, $02
    ld [wD782], a
    ret

Jump_015_6439::
    ld a, [wD782]
    and a, a
    jr nz, Jump_015_6441
    jr Jump_015_644D

Jump_015_6441::
    ld de, Data_015_727D
    ld hl, wC3C8
    ld bc, $1401
    call Func_015_65B7

Jump_015_644D::
    ld a, $02
    ld [wD782], a
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_00D_5A3C, Func_0F0_4CA0)
; points at: wC364
Func_015_645F::
    ld de, Data_015_70C5
    ld hl, wC364
    ld bc, $140B
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ret

; 2 call sites from 2 routines (e.g. Func_015_4182, Func_00D_463F)
; reads: wC563, wC562, wD786, wD780
; writes: wD7FA, wC920, wC919, wC89D, wD780, wD7AB, wD7AD, wD7AF, ...
Func_015_6478::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_015_6494
    bit 7, a
    jr nz, Jump_015_64C2
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_015_64DC
    bit 1, a
    jp nz, Jump_015_6511
    call Func_015_6524
    ret

Jump_015_6494::
    call Func_015_6542
    ld a, [wD786]
    and a, a
    jr nz, Jump_015_64AB
    ld a, $02
    ld [wD786], a
    call Func_015_6524
    ld a, $69
    call StoreWC60B
    ret

Jump_015_64AB::
    dec a

Jump_015_64AC::
    ld [wD786], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    call Func_015_6524
    ld a, $69
    call StoreWC60B
    ret

Jump_015_64C2::
    call Func_015_6542
    ld a, [wD786]
    cp a, $02
    jr c, Jump_015_64D9
    xor a, a
    ld [wD786], a
    call Func_015_6524
    ld a, $69
    call StoreWC60B
    ret

Jump_015_64D9::
    inc a
    jr Jump_015_64AC

Jump_015_64DC::
    ld a, $69
    call StoreWC60B
    call Func_015_6546
    ld c, $03
    ld hl, Data_015_732D
    call Func_015_67E5
    ld a, [wD786]
    cp a, $02
    jr z, Jump_015_6511
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

Jump_015_6511::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    xor a, a
    ld [wC89D], a
    ret

; 4 call sites from 1 routine (e.g. Func_015_6478)
; reads: wC564, wD787, wD786
; writes: wD787
Func_015_6524::
    ld a, [wC564]
    cp a, $14
    jr c, Jump_015_653E
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, Jump_015_653E
    cp a, $18
    jr c, Func_015_6542
    xor a, a
    ld [wD787], a

Jump_015_653E::
    ld b, $BB
    jr Jump_015_6548

; 2 call sites from 1 routine (e.g. Func_015_6478)
; reads: wD786
Func_015_6542::
    ld b, $C3
    jr Jump_015_6548

; 1 call site from 1 routine (e.g. Func_015_6478)
; reads: wD786
Func_015_6546::
    ld b, $BC

Jump_015_6548::
    ld a, [wD786]
    add a, a
    ld hl, Data_015_6566
    add a, l
    ld l, a
    jr nc, Jump_015_6554
    inc h

Jump_015_6554::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call Func_015_6655
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_015_6566:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

; 1 call site from 1 routine (e.g. Func_015_5A67)
; reads: hFFC6, rSTAT, wC6FD
; writes: rRAMG2, rRAMB
; points at: wD789
Func_015_656C::
    ld b, $00

Jump_015_656E::
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_015_6582
    inc h

Jump_015_6582::
    ld a, [hl]
    ld c, $00
    ld b, $01
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    cp a, $02
    jr nz, Jump_015_65AD
    pop hl
    pop bc
    push bc
    di

Jump_015_659B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_015_659B
    ld a, b
    add a, $E1
    ld [hl], a
    ei
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_015_65AC
    inc h

Jump_015_65AC::
    push hl

Jump_015_65AD::
    pop hl
    pop bc
    inc b
    ld a, [wC6FD]
    cp a, b
    jr nz, Jump_015_656E
    ret

; 45 call sites from 14 routines (e.g. Func_015_645F, Func_015_6B00, Func_015_642D, Func_015_4182, ...)
; reads: wIsCGB
; writes: rSVBK
Func_015_65B7::
    push hl
    push bc

Jump_015_65B9::
    push bc
    push hl

Jump_015_65BB::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_015_65BB
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_015_65B9
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

Jump_015_65DD::
    push bc
    push hl

Jump_015_65DF::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_65DF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_015_65DD
    xor a, a
    ldh [rSVBK], a
    ret

; 41 call sites from 15 routines (e.g. Func_015_645F, Func_015_642D, Func_015_4182, Func_015_4C0C, ...)
; reads: wC529, wC555, wC554, wIsCGB
; writes: wC554, wC555, rVBK, rSVBK
; points at: wC198, wD000
Func_015_65F1::
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
    ld a, [wC529]
    cp a, $10
    jr z, Jump_015_6634
    cp a, $11
    jr z, Jump_015_6634
    cp a, $12
    jr z, Jump_015_6634
    ld a, l
    add a, $C1
    ld [wC554], a
    ld a, h
    adc a, $01
    ld [wC555], a
    ld a, [wC555]
    cp a, $9B
    jr nz, Jump_015_6634
    ld a, [wC554]
    cp a, $61
    jr nz, Jump_015_6634
    ld a, $C1
    ld [wC554], a
    ld a, $99
    ld [wC555], a

Jump_015_6634::
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

; 45 call sites from 17 routines (e.g. Func_015_6546, Func_015_645F, Func_015_642D, Func_015_4182, ...)
; reads: hFFA5, hFFA1
Func_015_6655::
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
    jr nc, Jump_015_6675
    inc h

Jump_015_6675::
    ret

; 9 call sites from 9 routines (e.g. Func_015_67F9, Func_015_4182, Func_00D_463F, Func_00D_4741, ...)
; points at: hFFC9, wD7F1
Func_015_6676::
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

Jump_015_66A4::
    ld a, [hl]
    and a, a
    jr nz, Jump_015_66AE
    add a, $E3
    ld [hl+], a
    dec c
    jr nz, Jump_015_66A4

Jump_015_66AE::
    ret

; 6 call sites from 5 routines (e.g. Func_015_40FA, Func_015_6791, Func_015_5896, Func_015_570C, ...)
Func_015_66AF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_015_66AF
    ret

; 6 call sites from 5 routines (e.g. Func_015_40FA, Func_015_6791, Func_015_58B4, Func_015_570C, ...)
; writes: rSVBK
Func_015_66B8::
    ld a, $02
    ldh [rSVBK], a

Jump_015_66BC::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_66BC
    xor a, a
    ldh [rSVBK], a
    ret

; 19 call sites from 9 routines (e.g. Func_015_67E5, Func_015_4C0C, Func_015_47A7, Func_015_4439, ...)
Func_015_66CA::
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_015_66D1
    inc h

Jump_015_66D1::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; 1 call site from 1 routine (e.g. Func_015_4439)
; reads: wD785, wD7F1, wD7F2, wD784
; writes: wD7F1, wD7F2, wD784, wD785
; points at: wD781
Func_015_66D8::
    ld hl, Data_015_731B
    ld a, $9D
    jr Jump_015_66E4

; 1 call site from 1 routine (e.g. Func_015_4F4C)
; reads: wD785, wD7F1, wD7F2, wD784
; writes: wD7F1, wD7F2, wD784, wD785
; points at: wD781
Func_015_66DF::
    ld hl, Data_015_731B
    ld a, $9C

Jump_015_66E4::
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    xor a, a
    ld [wD784], a

Jump_015_66EF::
    push hl
    ld a, [wD785]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_015_66F9
    inc h

Jump_015_66F9::
    ld a, [hl]
    cp a, $FF
    jp z, Jump_015_6734
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    push hl
    ld a, [wD785]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wD7F1]
    ld d, a
    ld a, [wD7F2]
    ld e, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call Func_015_6780
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $06
    jr c, Jump_015_66EF
    ret

Jump_015_6734::
    pop de
    pop hl
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wD781
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. Func_015_4182, Func_015_512C)
Func_015_6742::
    push de
    call Func_015_6655
    pop de
    add hl, de
    push hl
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    call Func_000_24F8
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; 4 call sites from 4 routines (e.g. Func_015_4182, Func_015_512C, Func_015_5A67, Func_015_60BF)
Func_015_6772::
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

; 2 call sites from 2 routines (e.g. Func_015_6B00, Func_015_66DF)
; reads: rSTAT
Func_015_6780::
    ld c, $10

Jump_015_6782::
    di

Jump_015_6783::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_015_6783
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_015_6782
    ret

; 9 call sites from 6 routines (e.g. Func_015_4C0C, Func_015_47A7, Func_015_4439, Func_015_4182, ...)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wC198, wD000
Func_015_6791::
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
    call Func_015_66AF
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_67D2
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
    call Func_015_66B8
    pop de
    pop hl

Jump_015_67D2::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_015_67DA
    inc h

Jump_015_67DA::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_015_67E1
    inc d

Jump_015_67E1::
    dec c
    jr nz, Func_015_6791
    ret

; 9 call sites from 7 routines (e.g. Func_015_6478, Func_015_47A7, Func_015_4439, Func_015_512C, ...)
Func_015_67E5::
    ld a, c
    ld b, a
    ld c, $00

Jump_015_67E9::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call Func_015_66CA
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_67E9
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_015_512C, Func_015_60BF)
; writes: wC8C0, wC8C1, wC8C2
Func_015_67F9::
    call Func_015_680F
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    call Func_015_6676
    ret

; 5 call sites from 3 routines (e.g. Func_015_4F4C, Func_015_67F9, Func_015_54C0)
; reads: hFFC6
Func_015_680F::
    ldh a, [hFFC6]
    ld c, $0A
    ld hl, $0000
    call Multiply8
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_015_512C, Func_015_60BF)
; points at: wD7F4, wC130
Func_015_6822::
    ld hl, wD7F4
    ld de, wC130
    ld c, $00

Jump_015_682A::
    ld a, [hl]
    cp a, $E3
    jr z, Jump_015_6831
    ld [de], a
    inc de

Jump_015_6831::
    inc hl
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_015_682A
    ld a, $F0
    ld [de], a
    ret

; 9 call sites from 9 routines (e.g. Func_015_4F4C, Func_015_54C0, Func_00C_6A29, Func_00C_6E0C, ...)
; reads: wD7F3, wD7F2, wD7F1, wC619, wC618, wC617
; writes: wC619, wC618, wC617
Func_015_683C::
    ld a, [wD7F3]
    ld e, a
    ld a, [wD7F2]
    ld h, a
    ld a, [wD7F1]
    ld l, a
    ld a, [wC619]
    ld d, a
    ld a, [wC618]
    ld b, a
    ld a, [wC617]
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, d
    sbc a, e
    ld [wC619], a
    ld a, b
    ld [wC618], a
    ld a, c
    ld [wC617], a
    ret

; 5 call sites from 4 routines (e.g. Func_015_4771, Func_015_5A67, Func_015_4182, Func_015_60BF)
; reads: hFFC6, wD7F1
; writes: rRAMG2, rRAMB, wD09D, wD09E
Func_015_6866::
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
    ld a, [wD7F1]
    ld [wD09E], a
    farcall Func_016_7A48
    xor a, a
    ld [rRAMG2], a
    ret

; 5 call sites from 5 routines (e.g. Func_015_4771, Func_015_4182, Func_00D_71BD, Func_037_4AFD, ...)
; reads: wD7F1, wD7F2, wD7F3, hFFC6, wC8C1, wC8C2
; writes: rRAMG2, rRAMB
Func_015_688D::
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld l, a
    ld a, [wD7F3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    add a, $CC
    pop hl
    ld [hl], a
    pop bc
    push bc
    inc hl
    inc hl
    inc hl
    push hl
    ld a, b
    ld c, $56
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_015_68DC
    ld a, [wC8C1]
    add a, $E0
    pop hl
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl+], a
    pop bc
    ret

; 7 call sites from 7 routines (e.g. Func_015_688D, Func_015_47A7, Func_00D_6310, Func_00D_6509, ...)
; reads: wC8C0, wC8C1
; writes: wC8C0, wC8C1
Func_015_68DC::
    ld a, [wC8C0]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [wC8C0], a
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [wC8C1], a

Jump_015_68F2::
    ret

; 5 call sites from 5 routines (e.g. Func_015_4C0C, Func_007_7DE5, Func_00D_73F1, Func_037_5172, ...)
Func_015_68F3::
    call Func_015_68FA
    ld a, [hl]
    or a, b
    ld [hl], a
    ret

; 12 call sites from 7 routines (e.g. Func_015_68F3, Func_015_47A7, Func_001_5535, Func_00C_4102, ...)
; reads: wD7F1, wD7F2, wD7F3, wD7F4
; writes: wD7F5
Func_015_68FA::
    ld a, [wD7F1]
    ld e, a
    ld a, [wD7F2]
    ld d, a
    push de
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wD7F3]
    ld l, a
    ld a, [wD7F4]
    ld h, a
    add hl, de
    pop de
    push hl
    ld a, e
    and a, $07
    ld hl, Data_015_6937
    add a, l
    ld l, a
    jr nc, Jump_015_6925
    inc h

Jump_015_6925::
    ld a, [hl]
    ld b, a
    pop hl
    ld a, [hl]
    and a, b
    jr nz, Jump_015_6931
    xor a, a
    ld [wD7F5], a
    ret

Jump_015_6931::
    ld a, $FF
    ld [wD7F5], a
    ret

Data_015_6937:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

; 2 call sites from 2 routines (e.g. Func_015_4439, Func_015_60BF)
; reads: wD7B9
; writes: wD7A9, rRAMG2, rRAMB, wD7B9
; points at: wD789, wD7BE, sA000, wD7F1
Func_015_693F::
    ld hl, wD789
    ld b, $1E

Jump_015_6944::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_6944
    ld hl, wD7BE
    ld b, $1E

Jump_015_694E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_694E
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wD7B9], a
    ld de, sA000
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_015_696D::
    ld a, [de]
    cp a, $01
    jr z, Jump_015_6978
    cp a, $02
    jr z, Jump_015_6978
    jr Jump_015_69AA

Jump_015_6978::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_015_6980
    inc d

Jump_015_6980::
    ld a, [de]
    and a, a
    jr nz, Jump_015_69A2
    pop de
    push de
    ld a, $0E
    add a, e
    ld e, a
    jr nc, Jump_015_698D
    inc d

Jump_015_698D::
    ld a, [de]
    and a, $01
    push hl
    ld hl, wD7F1
    cp a, [hl]
    jr nz, Jump_015_699B
    pop hl
    pop de
    jr Jump_015_69AA

Jump_015_699B::
    pop hl
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_015_69AA

Jump_015_69A2::
    pop de
    ld a, [wD7B9]
    inc a
    ld [wD7B9], a

Jump_015_69AA::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_015_69B1
    inc d

Jump_015_69B1::
    inc b
    ld a, b
    cp a, $1E
    jr c, Jump_015_696D
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    farcall Func_01D_5F9C
    ret

; 2 call sites from 2 routines (e.g. Func_015_4439, Func_015_60BF)
; reads: wD7B4, hFFC6
; writes: rRAMG2, rRAMB, wD7F1
Func_015_69C6::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ret

; 3 call sites from 3 routines (e.g. Func_015_4771, Func_015_4439, Func_015_60BF)
Func_015_69E3::
    ld hl, vTiles2 + $7C0
    ld bc, $0401
    call Func_000_1881
    ld hl, vTiles1 + $400
    ld bc, $0301
    call Func_000_1881
    ld hl, vTiles1 + $4A0
    ld bc, $0201
    call Func_000_1881

; 2 call sites from 2 routines (e.g. Func_015_4C0C, Func_015_47A7)
Func_015_69FE::
    ld hl, vTiles2 + $700
    ld bc, $0901
    call Func_000_1881
    ld hl, vTiles1 + $750
    ld bc, $0301
    call Func_000_1881
    ld hl, vTiles1 + $7D0
    ld bc, $0201
    call Func_000_1881
    ret

; 1 call site from 1 routine (e.g. Func_015_4182)
Func_015_6A1A::
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call Func_000_1881
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call Func_000_1881
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call Func_000_1881
    ret

; 1 call site from 1 routine (e.g. Func_015_47A7)
; reads: wD7F1, hFFC6, hFFC7
; writes: rRAMG2, rRAMB, wC8D9, wD7F5
Func_015_6A36::
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [wC8D9], a
    xor a, a
    ld c, a
    ld a, $02
    ld [wD7F5], a
    farcall Func_01D_6129
    pop bc
    push bc
    ld a, b
    ld c, $0B
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call Func_015_6ACA
    xor a, a
    ld c, a
    ld a, $03
    ld [wD7F5], a
    farcall Func_01D_6129
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; 2 call sites from 2 routines (e.g. Func_015_47A7, Func_015_60BF)
; reads: wD7B4, wD7F5, wD7F6
; writes: rRAMG2, rRAMB
; points at: sA000, wC986, wCA2B
Func_015_6A82::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wC986
    ld b, $A5

Jump_015_6A9C::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6A9C
    farcall Func_01D_5D84
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wCA2B
    ld b, $A5

Jump_015_6ABF::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6ABF
    xor a, a
    ld [rRAMG2], a
    ret

; 4 call sites from 3 routines (e.g. Func_015_47A7, Func_015_6A36, Func_015_5A67)
; reads: wDataBank
; writes: wDataBank
; points at: wC8CF
Func_015_6ACA::
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, Data_008_4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_015_6ADE
    inc h

Jump_015_6ADE::
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
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_00D_5A4A, Func_0F0_4CA0)
; reads: hFFC6, wC8C1, wC8C2
; writes: wC528, wC529, wD782, rRAMG2, rRAMB, wC8CF, wC8D0, wC8D1, ...
; points at: wC52D, wC364, sBB0F, wC3B0, wC3C4, wC8CF, wC385, wC8C0, ...
Func_015_6B00::
    ld hl, vTiles1 + $240
    ld bc, $0901
    call Func_000_1881
    ld hl, vTiles1 + $470
    ld bc, $0301
    call Func_000_1881
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call Func_000_1881
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call Func_000_1881
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    farcall Func_002_706E
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_015_6B6B
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $8D
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0F
    xor a, a
    ld [wC528], a
    ld a, $28
    ld [wC529], a
    farcall Func_01B_4C94
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [wD782], a
    ret

Jump_015_6B6B::
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld de, Data_015_71A1
    ld hl, wC364
    ld bc, $140B
    call Func_015_65B7
    ld hl, sBB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr z, Jump_015_6BA1
    ld hl, Data_015_763B
    ld de, vTiles2 + $6F0
    call Func_015_6780
    ld a, $6F
    ld hl, wC3B0
    ld [hl+], a
    ld [hl], a
    ld hl, wC3C4
    ld [hl+], a
    ld [hl], a

Jump_015_6BA1::
    ld hl, sBB0F
    ld de, wC8CF
    ld c, $0A

Jump_015_6BA9::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_6BB4
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_015_6BA9

Jump_015_6BB4::
    ld a, $F0
    ld [de], a
    ld de, vTiles1 + $280
    call Func_000_21A1
    ld a, $16
    ld [wC8CF], a
    ld a, $24
    ld [wC8D0], a
    ld a, $36
    ld [wC8D1], a
    ld a, $37
    ld [wC8D2], a
    ld a, $F0
    ld [wC8D3], a
    ld de, vTiles1 + $240
    call Func_000_21A1
    ld a, $28
    ld [wC8CF], a
    ld a, $35
    ld [wC8D0], a
    ld a, $F0
    ld [wC8D1], a
    ld de, vTiles2 + $780
    call Func_000_21A1
    ld hl, sBB0F
    ld a, $F1
    add a, l
    ld l, a
    jr nc, Jump_015_6BFB
    inc h

Jump_015_6BFB::
    ld b, [hl]
    ld hl, sBB0F
    ld a, $F2
    add a, l
    ld l, a
    jr nc, Jump_015_6C06
    inc h

Jump_015_6C06::
    ld c, $00
    xor a, a
    ld [rRAMG2], a

Jump_015_6C0C::
    push hl
    push bc
    call Func_015_6DE6
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    ld a, $01
    ld [wD7F2], a
    farcall Func_01D_795D
    pop bc
    push bc
    ld a, c
    add a, a
    ld hl, Data_015_6E0E
    add a, l
    ld l, a
    jr nc, Jump_015_6C30
    inc h

Jump_015_6C30::
    ld e, [hl]
    inc hl
    ld d, [hl]
    call Func_000_21A1
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6C0C
    ld c, $00

Jump_015_6C3F::
    push hl
    push bc
    call Func_015_6DE6
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and a, $0F
    ld [wD09D], a
    xor a, a
    ld [rRAMG2], a
    pop bc
    push bc
    ld a, c
    add a, $C7
    ld [wD09E], a
    farcall Func_016_7A48
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6C3F
    ld c, $00

Jump_015_6C6F::
    push hl
    push bc
    call Func_015_6DE6
    ld a, $62
    add a, l
    ld l, a
    jr nc, Jump_015_6C7B
    inc h

Jump_015_6C7B::
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    xor a, a
    ld [rRAMG2], a
    call HLToDecimalDigits
    pop bc
    push bc
    ld a, c
    add a, a
    ld hl, Data_015_6E08
    add a, l
    ld l, a
    jr nc, Jump_015_6C9E
    inc h

Jump_015_6C9E::
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wC8C1]
    and a, a
    jr z, Jump_015_6CB4
    di
    call WaitForVRAMAccess
    ld a, [wC8C1]
    add a, $E0
    ld [hl], a
    ei
    inc hl

Jump_015_6CB4::
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6C6F
    ld c, $00

Jump_015_6CC8::
    push hl
    push bc
    ld hl, Data_015_6DD0
    ld a, c
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_015_6CD4
    inc h

Jump_015_6CD4::
    ld e, [hl]
    inc hl
    ld d, [hl]
    di
    call WaitForVRAMAccess
    ld a, $EA
    ld [de], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, $ED
    ld [de], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6CC8
    ld hl, sBB0F
    ld de, $0221
    add hl, de
    push hl
    inc hl
    inc hl
    inc hl
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    call HLToDecimalDigits
    ld hl, wC385
    ld c, $00
    ld de, wC8C0
    ld b, $03
    call Func_015_6DD6
    pop hl
    inc hl
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    xor a, a
    ld [rRAMG2], a
    call HLToDecimalDigits
    ld hl, wC389
    ld c, $00
    ld de, wC8C1
    ld b, $02
    call Func_015_6DD6
    ld hl, sBB01
    ld a, $06
    add a, l
    ld l, a
    jr nc, Jump_015_6D3D
    inc h

Jump_015_6D3D::
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    add a, $0A
    cp a, $0D
    jr nz, Jump_015_6D9A
    ld hl, sBE0D
    ld a, [hl]
    bit 7, a
    jr z, Jump_015_6D98
    ld hl, sBD36
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, sBC0A
    add hl, de
    inc hl
    ld de, wC130
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
    ld a, $F0
    ld [de], a
    ld a, $08
    ld [wC528], a
    ld a, $05
    ld [wC529], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall Func_008_402B
    jr Jump_015_6DB4

Jump_015_6D98::
    ld a, $0D

Jump_015_6D9A::
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall Func_008_402B

Jump_015_6DB4::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    call Func_015_63B8
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wD782], a
    ret

Data_015_6DD0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A8, $C3, $D0, $C3, $F8, $C3

; 2 call sites from 1 routine (e.g. Func_015_6B00)
Func_015_6DD6::
    di
    call WaitForVRAMAccess
    ld a, [de]
    add a, $E0
    ld [hl+], a
    ei
    inc de
    inc c
    ld a, c
    cp a, b
    jr c, Func_015_6DD6
    ret

; 3 call sites from 1 routine (e.g. Func_015_6B00)
; writes: rRAMG2, rRAMB
; points at: sA06F
Func_015_6DE6::
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_015_6DF6
    inc h

Jump_015_6DF6::
    ld a, [hl]
    ld c, $6F
    call Multiply8
    ld de, sA06F
    add hl, de
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Data_015_6E08:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $C3, $D2, $C3, $FA, $C3

Data_015_6E0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D

; 2 call sites from 2 routines (e.g. Func_015_570C, Func_015_54C0)
; reads: wC938, wC939, wC93A, wC93B, wC93C, wC93D, wC93E, wC93F, ...
; writes: hFF8E, hFF91, hFF98, wC8EF, wC8F0, wC8F1, wC8F4, wC8F5, ...
Func_015_6E14::
    ld a, [wC938]
    ldh [hFF8E], a
    ld a, [wC939]
    ldh [hFF91], a
    ld a, [wC93A]
    ldh [hFF98], a
    ld a, [wC93B]
    ld [wC8EF], a
    ld a, [wC93C]
    ld [wC8F0], a
    ld a, [wC93D]
    ld [wC8F1], a
    ld a, [wC93E]
    ld [wC8F4], a
    ld a, [wC93F]
    ld [wC8F5], a
    ld a, [wC940]
    ld [wC8F6], a
    ld a, [wC941]
    ld [wC8F9], a
    ld a, [wC942]
    ld [wC8FA], a
    ld a, [wC943]
    ld [wC8FB], a
    ld a, [wC937]
    ld [wCB86], a
    xor a, a
    ld [wC936], a
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_00D_73F1, Func_0F1_4D4E)
; reads: wCF8C, wCF8B, wCF8D, wCF8F, wCF8E, wCF90
; points at: wCF8B, wCF8E
Func_015_6E64::
    ld a, [wCF8C]
    cp a, $FF
    jr z, Jump_015_6E86
    ld b, a
    ld a, [wCF8B]
    or a, b
    and a, a
    jr z, Jump_015_6E86
    ld de, wCF8B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp a, $63
    jr nc, Jump_015_6E86
    inc a
    ld [hl-], a
    ld a, [wCF8D]
    ld [hl], a

Jump_015_6E86::
    ld a, [wCF8F]
    cp a, $FF
    ret z
    ld b, a
    ld a, [wCF8E]
    or a, b
    ret z
    ld de, wCF8E
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp a, $63
    ret nc
    inc a
    ld [hl-], a
    ld a, [wCF90]
    ld [hl], a
    ret

; 3 call sites from 3 routines (e.g. Func_015_4C0C, Func_00D_72D0, Func_0F1_4D4E)
; reads: wCA2A, wC58A, wCACF, wD7F1, wD782
; writes: wCF8B, wCF8C, wCF8D, wCF8E, wCF8F, wCF90, rRAMG, rRAMB, ...
; points at: wCF8B, wCF8E
Func_015_6EA5::
    xor a, a
    ld [wCF8B], a
    ld [wCF8C], a
    ld [wCF8D], a
    ld [wCF8E], a
    ld [wCF8F], a
    ld [wCF90], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [wD7F1], a
    ld de, wCF8B
    ld a, [wCA2A]
    and a, a
    call nz, Func_015_6EFD
    ld a, [wC58A]
    and a, a
    jr nz, Jump_015_6EDF
    ld de, wCF8E
    ld a, [wCACF]
    and a, a
    call nz, Func_015_6EFD

Jump_015_6EDF::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld a, [wD7F1]
    ld [wD7FA], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

; 2 call sites from 1 routine (e.g. Func_015_6EA5)
; reads: wD7F1, hFFC6, wCF8D, wCF8B, wCF8C
; writes: hFFC6, wD7F1
; points at: wC635, wCF8B
Func_015_6EFD::
    add a, $3F
    ldh [hFFC6], a
    ld c, a
    ld hl, wC635
    ld b, $64

Jump_015_6F07::
    ld a, [hl+]
    cp a, c
    jr z, Jump_015_6F14
    and a, a
    jr z, Jump_015_6F1B

Jump_015_6F0E::
    inc hl
    dec b
    jr nz, Jump_015_6F07
    jr Jump_015_6F5C

Jump_015_6F14::
    ld a, [hl]
    cp a, $63
    jr c, Jump_015_6F45
    jr Jump_015_6F5C

Jump_015_6F1B::
    push hl
    ld hl, wCF8B
    ld a, l
    cp a, e
    jr nz, Jump_015_6F2A
    ld a, h
    cp a, d
    jr nz, Jump_015_6F2A
    pop hl
    jr Jump_015_6F45

Jump_015_6F2A::
    ld a, [wCF8D]
    ld l, a
    ldh a, [hFFC6]
    cp a, l
    jr z, Jump_015_6F44
    pop hl
    push hl
    ld a, [wCF8B]
    cp a, l
    jr nz, Jump_015_6F44
    ld a, [wCF8C]
    cp a, h
    jr nz, Jump_015_6F44
    pop hl
    jr Jump_015_6F0E

Jump_015_6F44::
    pop hl

Jump_015_6F45::
    ldh a, [hFFC6]
    push af
    push de
    push hl
    pop hl
    pop de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    pop af
    ld [de], a
    jr Jump_015_6F56

Jump_015_6F56::
    ld a, $01
    ld [wD7F1], a
    ret

Jump_015_6F5C::
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    ld a, [wD7F1]
    and a, a
    ret nz
    xor a, a
    ld [wD7F1], a
    ret

Data_015_6F6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $A4, $A5, $EE, $EE, $A6, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A7, $A8, $A9, $AA, $AB, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $AC, $AD, $AE, $A9, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_6FA3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_6FDB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $056FDB, $75

Data_015_7050:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $057050, $75

Data_015_70C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
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
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Data_015_71A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $A4, $A5, $A6, $A7, $78, $79, $ED, $A8, $A9, $AA, $AB, $AC, $C3, $C3
    db $C3, $ED, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C7, $D0, $D1, $D2, $D3, $D4, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C8, $D5, $D6, $D7, $D8, $D9, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C9, $DA, $DB, $DC, $DD, $DE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Data_015_727D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $C3, $C3, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB
    db $DC, $DD, $DE, $B7

Data_015_7291:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_72A9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A
    db $C0, $8A, $D0, $8A, $E0, $8A, $E0, $8E, $F0, $8E, $FF, $FF

Data_015_72C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $40, $60, $43, $80, $42, $20, $41, $50, $42, $80, $43, $70, $42, $C0, $42
    db $F0, $40, $C0, $43, $D0, $42, $90, $42, $10, $49, $FF, $FF

Data_015_72E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_015_72F1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_015_72FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $80, $41, $00, $41, $90, $41, $E0, $41, $F0, $40, $D0, $41, $50, $41
    db $60, $41, $A0, $41, $B0, $40, $10, $49, $10, $49, $FF, $FF

Data_015_731B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0, $8C, $B0, $8C
    db $FF, $FF

Data_015_732D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3

Data_015_7333:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $C3, $F8, $C3, $20, $C4, $48, $C4

Data_015_733B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $27, $C4, $4F, $C4

Data_015_733F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $B7, $C3, $B7, $B4, $B5

Data_015_7345:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $B7, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B5

Data_015_7351:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $70, $71, $72, $73, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $74, $75, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_7379:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_73A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

Data_015_73AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $77, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_015_73C9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0573C9, $48

Data_015_7411:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $057411, $60

Data_015_7471:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_747D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05747D, $58

Data_015_74D5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $F8, $F9, $FA
    db $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7

Data_015_7505:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA

Data_015_7511:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_7541:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9
    db $B9, $B9, $B9, $BA

Data_015_7565:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C9, $7C, $7D
    db $7E, $7F, $C0, $C1, $C2, $CA, $CB, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9
    db $B9, $B9, $B9, $BA

Data_015_7589:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $F5, $F6, $F7
    db $FD, $FE, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $FF, $77, $78, $70, $71, $72, $73, $74, $75, $76, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_75C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $DC, $00, $0F, $FF, $FF, $F1, $01, $FF, $FF, $3F, $36, $3F, $FF, $E2
    db $88, $07, $FF, $FF, $C3, $00, $FF, $FF, $FC, $40, $1F, $FF, $FE, $F8, $83, $FF
    db $FE, $63, $00, $7F, $FB, $F9, $F9, $0F, $FF, $FF, $C4, $30, $00, $00, $00, $00

Data_015_75F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_761D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4
    db $B4, $B5, $72, $73, $74, $75, $76, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_763B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05763B, $171

; 2 call sites from 2 routines (e.g. Func_014_4DFE, Func_014_4FCC)
; writes: wD7A9, rRAMG2, rRAMB
; points at: wD789, sB356, sA000
Func_015_77AC::
    ld hl, wD789
    ld b, $1E

Jump_015_77B1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_77B1
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, sB356
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_015_77CD::
    ld a, [de]
    bit 7, a
    jr z, Jump_015_77D5
    inc c
    ld a, b
    ld [hl+], a

Jump_015_77D5::
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_015_77DC
    inc d

Jump_015_77DC::
    inc b
    ld a, b
    cp a, $1D
    jr c, Jump_015_77CD
    ld de, sA000
    ld a, $01
    ld [rRAMB], a
    ld a, [de]
    bit 7, a
    jr z, Jump_015_77F2
    inc c
    ld a, b
    ld [hl+], a

Jump_015_77F2::
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    ret

; 1 call site from 1 routine (e.g. Func_014_4E07)
; reads: wD7AF, wD7B1, wD7A9, wD781, wD7B0
; writes: rRAMG2, rRAMB, wD7F1, wD7F2, wD7F3, wD7F4, wC8D9, wD781
; points at: wD789, sB356, sA000
Func_015_77FB::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AF]
    ld b, a
    sla a
    sla a
    add a, b
    add a, l
    ld l, a
    jr nc, Jump_015_7815
    inc h

Jump_015_7815::
    ld c, $00

Jump_015_7817::
    ld a, [wD7B1]
    cp a, $04
    jr c, Jump_015_7823
    ld a, [wD7A9]
    jr Jump_015_7832

Jump_015_7823::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_015_782F
    ld a, [wD7A9]
    jr Jump_015_7832

Jump_015_782F::
    ld a, [wD7A9]

Jump_015_7832::
    ld b, a
    ld a, [wD7AF]
    push bc
    ld c, a
    sla a
    sla a
    add a, c
    pop bc
    add a, c
    cp a, b
    jr nc, Jump_015_78AF
    push hl
    push bc
    xor a, a
    ld [wD7F1], a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_015_7864
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    ld [wD7F2], a

Jump_015_785A::
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    jr Jump_015_7876

Jump_015_7864::
    ld a, $01
    ld [wD7F2], a
    ld hl, sA000
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    jr Jump_015_785A

Jump_015_7876::
    farcall Func_01D_795D
    ld a, $F0
    ld [wC8D9], a
    pop bc
    push bc
    ld a, c
    cp a, $04
    jr nz, Jump_015_788D
    call Func_015_78C5
    jr Jump_015_789F

Jump_015_788D::
    ld a, c
    sla a
    ld hl, Data_015_78BB
    add a, l
    ld l, a
    jr nc, Jump_015_7898
    inc h

Jump_015_7898::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call Func_000_21A1

Jump_015_789F::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_015_78AF
    ld a, c
    cp a, $05
    jp c, Jump_015_7817

Jump_015_78AF::
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_015_78BB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

; 1 call site from 1 routine (e.g. Func_015_77FB)
; reads: wD784, wD785
; writes: wD784, wD785
; points at: wC8CF
Func_015_78C5::
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wC8CF

Jump_015_78CF::
    ld a, [wD784]
    push hl
    add a, l
    ld l, a
    jr nc, Jump_015_78D8
    inc h

Jump_015_78D8::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_015_790E
    cp a, $8D
    jr z, Jump_015_78EE
    cp a, $8E
    jr z, Jump_015_78EE
    call Func_015_7917
    call CopyFromBankWaitVRAM
    jr Jump_015_78FD

Jump_015_78EE::
    push af
    ld a, [wD785]
    dec a
    ld [wD785], a
    pop af
    call Func_015_7917
    call OrFromBankWaitVRAM

Jump_015_78FD::
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    jr Jump_015_78CF

Jump_015_790E::
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

; 2 call sites from 1 routine (e.g. Func_015_78C5)
; reads: wD785
Func_015_7917::
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld hl, Data_015_794A
    ld a, [wD785]
    sla a
    add a, l
    ld l, a
    jr nc, Jump_015_793E
    inc h

Jump_015_793E::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld h, d
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

Data_015_794A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $E0, $8C, $F0, $8C

; 1 call site from 1 routine (e.g. Func_014_4E0E)
; reads: wD7F1
; writes: rRAMG2, wD09D, wD09E
Func_015_7954::
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call Func_015_7A43
    ld a, [hl]
    and a, $0F
    ld [wD09D], a
    ld a, $C7
    ld [wD09E], a
    farcall Func_016_7A48
    xor a, a
    ld [rRAMG2], a
    ret

; 1 call site from 1 routine (e.g. Func_014_4E0E)
; reads: wD7F1, wC8C1, wC8C2, wC8C0
; writes: rRAMG2, wC386, wC389, wC38A, wD7F1, wD7F3, wD7F5, wD7F7, ...
; points at: wD7F1
Func_015_7976::
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call Func_015_7A43
    push hl
    inc hl
    ld a, [hl]
    and a, $08
    sla a
    swap a
    pop hl
    add a, $CC
    ld [wC386], a
    push hl
    ld a, $62
    add a, l
    ld l, a
    jr nc, Jump_015_7999
    inc h

Jump_015_7999::
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_015_7ADB
    ld a, [wC8C1]
    add a, $E0
    ld [wC389], a
    ld a, [wC8C2]
    add a, $E0
    ld [wC38A], a
    pop hl
    push hl
    ld a, $57
    add a, l
    ld l, a
    jr nc, Jump_015_79BE
    inc h

Jump_015_79BE::
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl+]
    ld [wD7F3], a
    ld a, [hl+]
    ld [wD7F5], a
    ld a, [hl+]
    ld [wD7F7], a
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wD7F2], a
    ld a, [hl]
    and a, $30
    swap a
    ld [wD7F4], a
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [wD7F6], a
    ld a, [hl]
    and a, $03
    ld [wD7F8], a
    pop hl
    ld c, $00

Jump_015_79F5::
    push bc
    ld a, c
    sla a
    ld de, wD7F1
    add a, e
    ld e, a
    jr nc, Jump_015_7A01
    inc d

Jump_015_7A01::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call HLToDecimalDigits
    call Func_015_7ADB
    pop bc
    ld a, c
    sla a
    ld hl, Data_015_7A3B
    add a, l
    ld l, a
    jr nc, Jump_015_7A18
    inc h

Jump_015_7A18::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wC8C0]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wC8C1]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wC8C2]
    add a, $E0
    ld [de], a
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_015_79F5
    xor a, a
    ld [rRAMG2], a
    ret

Data_015_7A3B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

; 3 call sites from 3 routines (e.g. Func_015_7976, Func_015_7954, Func_015_7A5F)
; writes: rRAMB
; points at: sB356, sA000
Func_015_7A43::
    ld a, b
    cp a, $1D
    jr z, Jump_015_7A56
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    ld [rRAMB], a
    ret

Jump_015_7A56::
    ld hl, sA000
    ld a, $01
    ld [rRAMB], a
    ret

; 1 call site from 1 routine (e.g. Func_014_4E46)
; reads: wD7F1, wDataBank
; writes: rRAMG2, wD7F2, wD7F1, wD7F3, wD7F4, wC8D9, wDataBank
; points at: wC8CF
Func_015_7A5F::
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call Func_015_7A43
    push hl
    ld [wD7F2], a
    xor a, a
    ld [wD7F1], a
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall Func_01D_795D
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles1 + $780
    call Func_000_21A1
    pop hl
    inc hl
    ld a, [hl+]
    and a, $01
    ld e, a
    ld a, [hl]
    ld l, a
    ld a, e
    ld h, a
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, Data_008_4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_015_7AAA
    inc h

Jump_015_7AAA::
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld b, a
    ld a, e
    ld c, a
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [wDataBank], a
    ld hl, wC8CF
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, vTiles1 + $270
    call Func_000_21A1
    xor a, a
    ld [rRAMG2], a
    ret

; 2 call sites from 1 routine (e.g. Func_015_7976)
; reads: wC8C0, wC8C1
; writes: wC8C0, wC8C1
Func_015_7ADB::
    ld a, [wC8C0]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [wC8C0], a
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [wC8C1], a

Jump_015_7AF1::
    ret
    ds $50E, $00
