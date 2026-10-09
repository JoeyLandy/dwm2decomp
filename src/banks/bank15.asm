SECTION "Bank 15", ROMX[$4000], BANK[$15]
    db $15

Func_015_4001::
    ld a, [$D788]
    rst $00
    dw Func_015_400D
    dw Func_015_403F
    dw Func_015_4076
    dw Func_015_40AE

Func_015_400D:: ; heuristic: target of a pointer table; C0
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_015_66AF
    ld a, [$C525]
    and a, a
    jr z, Jump_015_402B
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_015_66B8

Jump_015_402B::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D788]
    inc a
    ld [$D788], a
    ret

Func_015_403F:: ; heuristic: target of a pointer table; C0
    ld hl, Data_015_72A9
    ld de, Data_015_72FF
    call Func_015_6374
    xor a, a
    ld [$D784], a
    ld [$D785], a
    ld [$D780], a
    ld [$D781], a
    ld [$C46B], a
    ld a, [$D788]
    inc a
    ld [$D788], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_015_4076:: ; heuristic: target of a pointer table; C0
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld de, Data_01F_4230
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4290
    ld hl, $8CF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4370
    ld hl, $8DF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [$D788]
    inc a
    ld [$D788], a
    ret

Func_015_40AE:: ; heuristic: target of a pointer table; C0
    ld hl, $62AD
    ld b, $1D
    rst $10
    ld hl, $7A64
    ld b, $16
    rst $10
    xor a, a
    ld [$D7F0], a
    ld [$D788], a
    ld bc, $006F
    ld hl, $D780

Jump_015_40C7::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_40C7
    ld hl, $C130
    ld b, $10

Jump_015_40D3::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_015_40D3
    ld hl, $470B
    ld b, $02
    rst $10
    ld a, $80
    ldh [$FFBA], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_015_40FA::
    ld a, [$D780]
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
    ld hl, $D780
    ld bc, $006F

Jump_015_412A::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_412A
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_015_66AF
    ld a, [$C525]
    and a, a
    jr z, Jump_015_414F
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_015_66B8

Jump_015_414F::
    ld a, $05
    ld [$D7F0], a
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld hl, $D780
    inc [hl]
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4167::
    ld a, [$D781]
    rst $00
    dw Func_015_4171
    dw Func_015_4182
    dw Jump_015_41BD

Func_015_4171::
    ld hl, Data_015_72A9
    ld de, Data_015_72C5
    call Func_015_6374
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_015_4182::
    ld de, Data_015_7291
    ld hl, $C370
    ld bc, $0803
    call Func_015_65B7
    ld hl, $C617
    ld de, $C8C0
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
    ld hl, $C386
    ld de, $D7F3
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
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_41BD::
    ld de, Data_015_6F6B
    ld hl, $C364
    ld bc, $0807
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140B
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [$D781], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_015_41E1::
    call Func_015_6478
    ret

Jump_015_41E5::
    ld a, [$D786]
    and a, a
    jr z, Jump_015_41ED
    jr Jump_015_41F5

Jump_015_41ED::
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_015_41F5::
    ld hl, $6026
    ld b, $1D
    rst $10
    ld a, [$D7B9]
    and a, a
    jr nz, Jump_015_4215
    ld a, $01
    ld [$D7FA], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4215::
    xor a, a
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_422B::
    ld a, [$D781]
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
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_015_6791
    ld de, Data_015_42F4
    ld hl, $C364
    ld bc, $080B
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [$D7AB], a
    ld [$D7AF], a
    ld [$D7AE], a
    ld [$D7AD], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_015_42F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0542F4, $58

Jump_015_434C::
    call Func_015_6A1A
    ld de, Data_015_747D
    ld hl, $C364
    ld bc, $080B
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4363::
    ld hl, $5F2D
    ld b, $1D
    rst $10

Jump_015_4369::
    ld hl, Data_015_7163
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_015_43A4
    ld de, $0142
    call Func_015_6742
    ld hl, $C42E
    call Func_015_6772
    ld de, $0143
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld hl, Data_015_7564
    ld b, $1E
    rst $10
    ld hl, $C42F
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, Data_015_759A
    ld b, $1E
    rst $10

Jump_015_43A4::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_43AC::
    ld hl, $5C15
    ld b, $1F
    rst $10
    xor a, a
    ld [$D7F1], a
    ld hl, $6AA5
    ld b, $1D
    rst $10
    ret

Jump_015_43BD::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [$D7F1], a
    call Func_015_6866
    ld de, Data_015_74D5
    ld hl, $C3BC
    ld bc, $0C09
    call Func_015_65B7
    pop af
    ld [$D7F1], a
    ld hl, $C3D6
    ld a, l
    ld [$D7F2], a
    ld a, h
    ld [$D7F3], a
    call Func_015_688D
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_43F4::
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    ld hl, $8F80
    ld bc, $0501
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, $D781
    inc [hl]
    ret

Jump_015_4418::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_015_4439::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_444D::
    ld a, [$D7AB]
    ld b, $BB
    ld hl, Data_015_73A1
    call Func_015_66CA
    call Func_015_4439
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_015_73A1
    call Func_015_66CA
    ret

Jump_015_4467::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
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
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_015_4494::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_449C::
    ld a, [$D781]
    add a, $04
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_44CA::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_015_44D3::
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [$D7F1], a
    ld a, $09
    ld [$D7F2], a
    call Func_015_6791
    ld c, $09
    ld hl, $0224
    ld de, $0058
    xor a, a
    ld [$D7F1], a
    ld a, $0C
    ld [$D7F2], a
    call Func_015_6791
    ld de, Data_015_6FA3
    ld hl, $C364
    ld bc, $0807
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_451B::
    call Func_015_4171
    ld de, Data_015_6F6B
    ld hl, $C364
    ld bc, $0807
    call Func_015_65B7
    ld a, [$D786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4550::
    ld de, Data_015_7379
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4570::
    ld a, $6C
    call Func_000_1278
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call Func_015_6374
    ld de, Data_015_7351
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [$D7FA], a
    ld [$D7AD], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_45A5::
    ld de, Data_015_7505
    ld hl, $C40C
    ld bc, $0C05
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
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
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_45DC::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $0E
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $01
    ld [$D7F5], a
    ld hl, $D789
    ld c, $00

Jump_015_4606::
    push hl
    push bc
    ld a, [hl]
    ld c, $0E
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $01
    ld b, a
    ld a, [$D7F5]
    cp a, b
    jr nz, Jump_015_463F
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [$D7A9]
    cp a, c
    jr nz, Jump_015_4606
    pop hl
    ld a, $03
    ld [$D7FA], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_463F::
    pop bc
    pop hl
    pop hl
    push hl
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    ldh a, [$FFC6]
    cp a, $0A
    jr nc, Jump_015_466B
    pop hl
    ld a, $02
    ld [$D7FA], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_466B::
    pop hl
    ld a, [$C6FD]
    cp a, $02
    jr nc, Jump_015_4696
    ld a, [hl]
    ld b, a
    ld a, [$C6FE]
    cp a, b
    jr nz, Jump_015_4696
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    dec a
    dec a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4696::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7B4], a
    ld a, [$D7AB]
    ld [$D7B5], a
    ld a, [$D7AF]
    ld [$D7B6], a
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AF], a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_46D3::
    ld a, $B6
    ld [$C378], a
    ld [$C3A0], a
    ld [$C3C8], a
    ld de, Data_015_7541
    ld hl, $C394
    ld bc, $0C03
    call Func_015_65B7
    ld de, Data_015_7505
    ld hl, $C40C
    ld bc, $0C05
    call Func_015_65B7
    ld c, $05
    ld hl, Data_015_73A1
    call Func_015_67E5
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4712::
    call Func_015_66D8
    ret

Jump_015_4716::
    call Func_015_69E3
    ld de, Data_015_7565
    ld hl, $C394
    ld bc, $0C03
    call Func_015_65B7
    ld de, Data_015_7589
    ld hl, $C40C
    ld bc, $0C05
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4739::
    ld hl, $8A40
    ld bc, $0301
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0501
    call Func_000_1881
    ld hl, $8CE0
    ld bc, $1101
    call Func_000_1881
    ld de, Data_015_747D
    ld hl, $C364
    ld bc, $080B
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4768::
    call Func_015_69C6
    call Func_015_693F
    jp Jump_015_4369

Func_015_4771::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [$D7F1], a
    call Func_015_6866
    pop af
    ld [$D7F1], a
    ld hl, $C426
    ld a, l
    ld [$D7F2], a
    ld a, h
    ld [$D7F3], a
    call Func_015_688D
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_479C::
    call Func_015_69E3
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_015_47A7::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [$D7F1], a
    ld hl, Func_015_6A36
    ld b, $15
    rst $10
    xor a, a
    ld [$CFA8], a
    ld [$CFA9], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_47CF::
    call Func_015_6A82
    xor a, a
    ld [$CFA8], a
    ld [$CFA9], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_47E1::
    xor a, a
    ld [$D7F1], a
    ld hl, $5688
    ld b, $0E
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7F7]
    cp a, $FF
    jr nz, Jump_015_47FF
    ld a, [$D7F6]
    cp a, $FF
    jr z, Jump_015_485A

Jump_015_47FF::
    ld a, [$D7F6]
    ld [$D7F1], a
    ld [$D006], a
    ld a, [$D7F7]
    ld [$D7F2], a
    ld [$D007], a
    ld de, Data_015_75C5
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    call Func_015_68FA
    ld a, [$D7F5]
    cp a, $FF
    jr z, Jump_015_487A
    ld a, [$D7F6]
    ld [$D7F1], a
    ld a, [$D7F7]
    ld [$D7F2], a
    ld hl, $C7FC
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    call Func_015_68FA
    cp a, $FF
    jr z, Jump_015_487A
    ld a, [$D7F6]
    ld [$D006], a
    ld a, [$D7F7]
    ld [$D007], a
    ld hl, Data_015_5A7E
    ld b, $16
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_015_487A

Jump_015_485A::
    ld c, $00
    ld hl, $C8CF

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
    ld hl, $8C90
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    jr Jump_015_4899

Jump_015_487A::
    ld a, [$D7F6]
    ld l, a
    ld a, [$D7F7]
    ld h, a
    call Func_015_6ACA
    ld hl, $CADD
    ld a, [hl]
    and a, $0F
    ld [$D09D], a
    ld a, $C9
    ld [$D09E], a
    ld hl, $7A48
    ld b, $16
    rst $10

Jump_015_4899::
    ld c, $00
    ld a, $04
    ld [$D7F5], a
    ld hl, $6129
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_48AE::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
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
    ld a, [$D781]
    sub a, $09
    ld [$D781], a
    ret

Jump_015_48DB::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_48E3::
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4911::
    ld a, [$D781]
    sub a, $06
    ld [$D781], a
    ret

Jump_015_491A::
    ld c, $03
    ld hl, $01FC
    ld de, $0030
    xor a, a
    ld [$D7F1], a
    ld a, $0C
    ld [$D7F2], a
    call Func_015_6791
    ld a, $B7
    ld [$C393], a
    ld [$C3A7], a
    call Func_015_4182
    ld de, Data_015_74D5
    ld hl, $C3BC
    ld bc, $0C01
    call Func_015_65B7
    ld de, Data_015_7511
    ld hl, $C420
    ld bc, $0C04
    call Func_015_65B7
    ld de, Data_015_4985
    ld hl, $C393
    ld bc, $0102
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Data_015_4985:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B7, $B7

Jump_015_4987::
    ld a, $9D
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld de, Func_015_6DE6
    ld a, d
    ld [$D7F3], a
    ld a, e
    ld [$D7F4], a
    ld hl, $6C14
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7B5]
    ld [$D7AB], a
    ld a, [$D7B6]
    ld [$D7AF], a
    xor a, a
    ld [$D7FA], a
    ld [$D7AD], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, $01
    ld [$D781], a
    ret

Jump_015_49C9::
    ld de, Data_015_75F5
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_69FE
    call Func_015_47A7
    ld de, Data_015_7589
    ld hl, $C40C
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
    ld [$D781], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
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
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4A4D::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $56
    call Func_000_1F80
    xor a, a
    ld [$1FFF], a
    ldh a, [$FFC6]
    cp a, $0A
    jr nc, Jump_015_4A88
    ld a, $03
    ld [$D7FA], a
    ld a, $24
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4A88::
    ld a, [$C6FD]
    cp a, $03
    jr z, Jump_015_4AED
    cp a, $01
    jr z, Jump_015_4AD6
    ld a, [$D7B4]
    ld b, a
    ld a, [$C6FE]
    cp a, b
    jr z, Jump_015_4AA5
    ld a, [$C6FF]
    cp a, b
    jr z, Jump_015_4AA5
    jr Jump_015_4AED

Jump_015_4AA5::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld b, [hl]
    ld a, [$C6FE]
    cp a, b
    jr z, Jump_015_4AC2
    ld a, [$C6FF]
    cp a, b
    jr z, Jump_015_4AC2
    jr Jump_015_4AED

Jump_015_4AC2::
    ld a, $02
    ld [$D7FA], a
    ld a, $24
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4AD6::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld b, [hl]
    ld a, [$C6FE]
    cp a, b
    jr nz, Jump_015_4AED
    jr Jump_015_4AC2

Jump_015_4AED::
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4B02::
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    ld hl, $C7FC
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    call Func_015_68FA
    cp a, $FF
    jr nz, Jump_015_4B21
    jr Jump_015_4B55

Jump_015_4B21::
    ld hl, $CADB
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Data_015_5A7E
    ld b, $16
    rst $10
    ld a, c
    and a, a
    jr z, Jump_015_4B38
    jr Jump_015_4B55

Jump_015_4B38::
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    ld hl, Data_015_75C5
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    call Func_015_68FA
    cp a, $FF
    jr nz, Jump_015_4BA7

Jump_015_4B55::
    ld de, $CADB
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_015_6ACA
    ld hl, $C8CF
    ld de, $C130

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
    ld hl, $CB3D
    ld a, [hl]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_015_68DC
    ld a, [$C8C1]
    cp a, $E3
    jr z, Jump_015_4B8A
    ld [de], a
    inc de

Jump_015_4B8A::
    ld a, [$C8C2]
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4BA7::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4BBE::
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    ld de, $C7FC
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    call Func_015_68FA
    cp a, $FF
    jr z, Jump_015_4BF7
    ld hl, $CADB
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    ld hl, Data_015_5A7E
    ld b, $16
    rst $10
    ld a, c
    and a, a
    jr nz, Jump_015_4BF7
    ld a, $01
    ld [$D7FA], a
    jr Jump_015_4BFB

Jump_015_4BF7::
    xor a, a
    ld [$D7FA], a

Jump_015_4BFB::
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_015_4C0C::
    ld a, [$C58A]
    and a, a
    jr z, Jump_015_4C15
    call Func_015_645F

Jump_015_4C15::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4C1D::
    ld a, [$C58A]
    and a, a
    jr z, Jump_015_4C26
    call Func_015_6B00

Jump_015_4C26::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4C2E::
    call Func_015_63D3
    ld a, [$D782]
    cp a, $02
    jr z, Jump_015_4C4D
    cp a, $03
    jr z, Jump_015_4C66
    call Func_015_642D
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_015_4C4D::
    ld a, [$C58A]
    and a, a
    jr z, Jump_015_4C5E
    ld a, $0D
    ld [$C529], a
    ld hl, $4C86
    ld b, $1B
    rst $10

Jump_015_4C5E::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_015_4C66::
    ld a, [$C52B]
    and a, a
    ret nz
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4C80::
    ld a, [$D782]
    and a, a
    jr nz, Jump_015_4C8A
    call Func_015_6EA5
    ret

Jump_015_4C8A::
    xor a, a
    ld [$D782], a
    ld a, [$C58A]
    and a, a
    jr z, Jump_015_4CD9
    ld de, Data_015_75F5
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_69FE
    call Func_015_47A7
    ld de, Data_015_7589
    ld hl, $C40C
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
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ret

Jump_015_4CE3::
    ld a, [$C58A]
    and a, a
    jr z, Jump_015_4D1E
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    cp a, $FE
    jr z, Jump_015_4CFE
    cp a, $FF
    jr z, Jump_015_4D14
    call Func_015_63D3
    ret

Jump_015_4CFE::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4D14::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_015_4CFE
    call Func_015_63D3

Jump_015_4D1E::
    ld a, [$D781]
    add a, $07
    ld [$D781], a
    xor a, a
    ld [$D782], a
    ret

Jump_015_4D2B::
    ld de, Data_015_761D
    ld hl, $C412
    ld bc, $0605
    call Func_015_65B7
    call Func_015_4C0C
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ret

Jump_015_4D46::
    ld a, $9D
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld de, Func_015_6DE6
    ld a, d
    ld [$D7F3], a
    ld a, e
    ld [$D7F4], a
    ld hl, $6C14
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4D6E::
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [$D7F1], a
    ld a, $14
    ld [$D7F2], a
    call Func_015_6791
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4D96::
    call Func_015_4171
    call Func_015_4182
    ld de, Data_015_6F6B
    ld hl, $C364
    ld bc, $0807
    call Func_015_65B7
    ld a, [$D781]
    dec a
    ld [$D781], a
    ret

Jump_015_4DB0::
    ld a, [$D786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4DE5::
    call Func_015_4171
    call Func_015_4182
    ld a, [$D781]
    dec a
    ld [$D781], a
    ret

Jump_015_4DF3::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4E1D::
    ld hl, $CB3D
    ld a, [hl]
    ldh [$FFC6], a
    call Func_015_67F9
    call Func_015_6822
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4E47::
    ld a, [$D782]
    and a, a
    jr z, Jump_015_4EB1
    cp a, $01
    jr z, Jump_015_4E87
    cp a, $02
    jr z, Jump_015_4E6B
    ld a, [$C52B]
    and a, a
    jr z, Jump_015_4E5F
    call Func_015_63D3
    ret

Jump_015_4E5F::
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_4E6B::
    call Func_015_63D3
    ld a, [$C58A]
    and a, a
    jr z, Jump_015_4E7F
    ld a, $0E
    ld [$C529], a
    ld hl, $4C86
    ld b, $1B
    rst $10

Jump_015_4E7F::
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_015_4E87::
    call Func_015_63D3
    ld a, [$C58A]
    and a, a
    jr z, Jump_015_4E9C
    ld hl, Data_015_7347
    ld b, $02
    rst $10
    ld a, [$C8C3]
    bit 7, a
    ret z

Jump_015_4E9C::
    xor a, a
    ld [$D7FA], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4EB1::
    call Func_015_63D3
    ld a, [$D7B4]
    ld b, a
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld b, [hl]
    push bc
    ld a, b
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Data_015_7E96
    ld b, $14
    rst $10
    pop bc
    ld a, [$D7B4]
    cp a, b
    jr c, Jump_015_4EDE
    dec a

Jump_015_4EDE::
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Data_015_7E96
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld [$D7B4], a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7F6]
    ld l, a
    ld a, [$D7F7]
    ld h, a
    ld de, $CAD0
    ld b, $A5

Jump_015_4F07::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_4F07
    xor a, a
    ld [$1FFF], a
    xor a, a
    ld [$C8C3], a
    ld [$C8C4], a
    ld hl, $CADB
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl]
    ld [$D7F2], a
    ld de, $C7FC
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    call Func_015_68F3
    ld hl, $D7E0
    ld b, $07

Jump_015_4F36::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_4F36
    ld hl, $5AAF
    ld b, $16
    rst $10
    call Func_015_6E64
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Func_015_4F4C:: ; heuristic: follows a terminator; C0
    ld hl, $C6FE
    ld c, $00

Jump_015_4F51::
    ld a, [hl]
    cp a, b
    jr nz, Jump_015_4F61
    ld a, $FF
    ld [hl], a
    ld a, [$C6FD]
    dec a
    ld [$C6FD], a
    jr Jump_015_4F69

Jump_015_4F61::
    inc hl
    inc c
    ld a, [$C6FD]
    cp a, c
    jr nz, Jump_015_4F51

Jump_015_4F69::
    ld hl, $C6FE
    ld de, $C6FE
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
    ld hl, $C6FE
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
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_015_4FAE
    cp a, $FF
    jr z, Jump_015_4FC4
    ret

Jump_015_4FAE::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_4FC4::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_015_4FAE
    ld hl, $CB3D
    ld a, [hl]
    ldh [$FFC6], a
    call Func_015_680F
    xor a, a
    ld [$D7F3], a
    ld a, h
    ld [$D7F2], a
    ld a, l
    ld [$D7F1], a
    ld hl, $440F
    ld b, $1C
    rst $10
    ld a, [$D7F1]
    cp a, $FF
    jr nz, Jump_015_5003
    ld a, $02
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5003::
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    inc a
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_501D::
    xor a, a
    ld [$D781], a
    ld a, $0A
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5030::
    ld hl, $CB3D
    ld a, [hl]
    ldh [$FFC6], a
    call Func_015_680F
    xor a, a
    ld [$D7F3], a
    ld a, h
    ld [$D7F2], a
    ld a, l
    ld [$D7F1], a
    call Func_015_683C
    ld hl, $D7BE
    ld c, $00

Jump_015_504D::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_504D
    ld hl, $6026
    ld b, $1D
    rst $10
    xor a, a
    ld [$D7AB], a
    ld [$D7AF], a
    ld [$D7B1], a
    ld [$D7B0], a
    ld hl, $D789
    ld a, [$D7B4]
    ld b, a
    ld c, $00

Jump_015_5071::
    ld a, [hl]
    cp a, b
    jr z, Jump_015_5084
    inc c
    inc hl
    ld a, [$D7AB]
    inc a
    ld [$D7AB], a
    ld a, [$D7A9]
    cp a, c
    jr nz, Jump_015_5071

Jump_015_5084::
    ld a, [$D7AB]
    srl a
    srl a
    ld [$D7AF], a
    ld a, [$D7AB]

Jump_015_5091::
    cp a, $04
    jr c, Jump_015_5099
    sub a, $04
    jr Jump_015_5091

Jump_015_5099::
    ld [$D7AB], a
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $6E
    call Func_000_1FD1
    xor a, a
    ld [hl], a
    xor a, a
    ld [$1FFF], a
    ld [$D781], a
    ld a, $08
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_50D1::
    ld a, [$D781]
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
    ld hl, $C3BB
    ld bc, $0D09
    call Func_015_65B7
    ld a, [$D786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld hl, $6026
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_015_512C::
    ld hl, $8C00
    ld bc, $0301
    call Func_000_1881
    ld hl, $8C70
    ld bc, $0501
    call Func_000_1881
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0D01
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5165::
    ld de, Data_015_7050
    ld hl, $C3BB
    ld bc, $0D09
    call Func_015_65B7
    ld hl, Data_015_71E1
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_015_51AC
    ld de, $018E
    call Func_015_6742
    ld hl, $C462
    call Func_015_6772
    ld de, $018F
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld hl, Data_015_7564
    ld b, $1E
    rst $10
    ld hl, $C463
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, Data_015_759A
    ld b, $1E
    rst $10

Jump_015_51AC::
    ld a, [$D7AB]
    ld b, $BB
    ld hl, Data_015_7333
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D7AB]
    ld b, $C3
    ld hl, Data_015_7333
    call Func_015_66CA
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_51D6::
    ld a, $01
    ld [$D7F5], a
    ld hl, $6088
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_51E9::
    ld de, Data_01F_4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$D7F1], a
    ld a, $01
    ld [$D7F2], a
    ld hl, $6320
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_520D::
    ld a, $02
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
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
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_015_523B::
    ret

Jump_015_523C::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ret

Jump_015_525F::
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    add a, $04
    ld [$D781], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_015_7333
    call Func_015_66CA
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $6D
    call Func_000_1F80
    xor a, a
    ld [$1FFF], a
    call Func_015_67F9
    call Func_015_6822
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_52BD::
    ld c, $09
    ld hl, $0223
    ld de, $0057
    xor a, a
    ld [$D7F1], a
    ld a, $0D
    ld [$D7F2], a
    call Func_015_6791
    ld a, [$C89D]
    or a, a
    jr z, Jump_015_52EB
    ld de, Data_015_7345
    ld hl, $C3BB
    ld bc, $0403
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_52EB::
    ld de, Data_015_733F
    ld hl, $C3BA
    ld bc, $0203
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_52FF::
    ld a, [$D782]
    and a, a
    jr nz, Jump_015_5323
    call Func_015_4182
    ld a, [$D781]
    dec a
    ld [$D781], a
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D782]
    inc a
    ld [$D782], a
    ret

Jump_015_5323::
    ld a, $9C
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld de, Func_015_6DE6
    ld a, d
    ld [$D7F3], a
    ld a, e
    ld [$D7F4], a
    ld hl, $6C14
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    xor a, a
    ld [$D782], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5358::
    ld c, $03
    ld hl, Data_015_732D
    call Func_015_67E5
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5376::
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call Func_015_6374
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5387::
    ld a, $6C
    call Func_000_1278
    ld de, Data_015_7351
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [$D7B7], a
    ld [$D7AD], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_53B3::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_015_53CF
    bit 7, a
    jr nz, Jump_015_53E9
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_015_53F9
    bit 1, a
    jp nz, Jump_015_5488
    call Func_015_549E
    ret

Jump_015_53CF::
    call Func_015_54BC
    ld a, [$D7AD]
    and a, a
    jr nz, Jump_015_53DC
    ld a, $01
    jr Jump_015_53DD

Jump_015_53DC::
    dec a

Jump_015_53DD::
    ld [$D7AD], a
    call Func_015_549E
    ld a, $69
    call Func_000_1278
    ret

Jump_015_53E9::
    call Func_015_54BC
    ld a, [$D7AD]
    cp a, $01
    jr c, Jump_015_53F6
    xor a, a
    jr Jump_015_53DD

Jump_015_53F6::
    inc a
    jr Jump_015_53DD

Jump_015_53F9::
    ld a, $69
    call Func_000_1278
    call Func_015_54C0
    ld a, [$D7AD]
    and a, a
    jp nz, Jump_015_5471
    ld a, [$D780]
    cp a, $04
    jr z, Jump_015_5415
    cp a, $05
    jr z, Jump_015_5438
    jr Jump_015_5446

Jump_015_5415::
    ld a, [$D781]
    cp a, $22
    jr c, Jump_015_542A
    ld a, $04
    ld [$D7B2], a
    ld a, $23
    ld [$D7B3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_542A::
    ld a, $04
    ld [$D7B2], a
    ld a, $0E
    ld [$D7B3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_5438::
    ld a, $05
    ld [$D7B2], a
    ld a, $0C
    ld [$D7B3], a
    ld a, $0D
    jr Jump_015_5454

Jump_015_5446::
    ld a, $07
    ld [$D7B2], a
    ld a, $18
    ld [$D7B3], a
    ld a, $0E
    jr Jump_015_5454

Jump_015_5454::
    ld [$D780], a
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld [$D7FA], a
    ld hl, Data_015_7745
    ld b, $1E
    rst $10
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5471::
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5488::
    ld a, $02
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_015_549E::
    ld a, [$C564]
    cp a, $14
    jr c, Jump_015_54B8
    ld a, [$D7AE]
    inc a
    ld [$D7AE], a
    cp a, $10
    jr c, Jump_015_54B8
    cp a, $18
    jr c, Func_015_54BC
    xor a, a
    ld [$D7AE], a

Jump_015_54B8::
    ld b, $BB
    jr Jump_015_54C2

Func_015_54BC::
    ld b, $C3
    jr Jump_015_54C2

Func_015_54C0::
    ld b, $BC

Jump_015_54C2::
    ld a, [$D7AD]
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
    call Func_000_120A
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
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5504::
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $6D
    call Func_000_1F80
    xor a, a
    ld [$1FFF], a
    call Func_015_680F
    xor a, a
    ld [$D7F3], a
    ld a, h
    ld [$D7F2], a
    ld a, l
    ld [$D7F1], a
    ld hl, $440F
    ld b, $1C
    rst $10
    ld a, [$D7F1]
    cp a, $FF
    jr nz, Jump_015_5555
    ld a, $01
    ld [$D7FA], a
    ld a, $07
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5555::
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_556A::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
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
    call Func_000_1F80
    xor a, a
    ld [$1FFF], a
    call Func_015_680F
    xor a, a
    ld [$D7F3], a
    ld a, h
    ld [$D7F2], a
    ld a, l
    ld [$D7F1], a
    call Func_015_683C
    ld hl, $D7BE
    ld c, $00

Jump_015_55B7::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_55B7
    xor a, a
    ld [$D781], a
    ld a, $09
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_55D2::
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push hl
    ld a, [hl]
    ld c, $0E
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $01
    ld [$D7F2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0D
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $1F
    ld [$D7F3], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld [$D7F4], a
    ldh a, [$FFC7]
    ld [$D7F5], a
    pop hl
    ld a, [hl]
    ld [$D7B4], a
    ld a, $01
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ld hl, $5CA8
    ld b, $14
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7B4]
    ld c, $01
    call Func_000_1FD1
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld c, $0A
    ld de, $C8CF

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
    ld a, [$D7B4]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld de, $C986
    ld b, $A5

Jump_015_5668::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_5668
    xor a, a
    ld [$1FFF], a
    ld a, [$D7B4]
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld hl, Data_015_7E96
    ld b, $14
    rst $10
    ld a, [$D7F5]
    ld [$D7B4], a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7F6]
    ld l, a
    ld a, [$D7F7]
    ld h, a
    ld de, $C986
    ld b, $A5

Jump_015_569E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_569E
    xor a, a
    ld [$1FFF], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    ret

Jump_015_56B0::
    ld a, [$D781]
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
    ld hl, $8800
    call Func_000_0CF5
    ld a, [$D781]
    inc a
    ld [$D781], a
    call Func_015_6E14
    ret

Func_015_570C::
    ld hl, Data_015_72A9
    ld de, Data_015_72C5
    call Func_015_6374
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_571D::
    ld a, $0D
    ldh [$FF90], a
    call Func_000_1C0C
    call Func_000_19A9
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld hl, Func_015_4001
    ld b, $69
    rst $10
    call Func_015_6E14
    xor a, a
    ldh [$FF8D], a
    ld a, $7F
    ld [$C527], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5746::
    ld hl, $C364
    ld de, $C198
    ld bc, $0104
    call Func_015_66AF
    ld hl, $C300
    ld de, $C29C
    ld bc, $0064
    call Func_015_66AF
    ld a, [$C525]
    and a, a
    jr z, Jump_015_577C
    ld hl, $D1CC
    ld de, $D000
    ld bc, $0104
    call Func_015_66B8
    ld hl, $D168
    ld de, $D104
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
    ldh [$FFBA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_57A4::
    ld hl, $C8CF
    ld de, $C130
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
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_57CB::
    ld de, Data_01F_4180
    ld hl, $9770
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4330
    ld hl, $9730
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    call Func_015_63D3
    ld a, $6C
    call Func_000_1278
    ld de, Data_015_73AB
    ld hl, $C412
    ld bc, $0605
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ret

Jump_015_5811::
    ld a, [$C58A]
    and a, a
    jr nz, Jump_015_57CB
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ret

Jump_015_5823::
    ld hl, $6540
    ld b, $1D
    rst $10
    ld a, [$D7F9]
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
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5850::
    ld a, [$D7FA]
    cp a, $01
    jr z, Jump_015_5837
    ld a, [$D781]
    add a, $04
    ld [$D781], a
    xor a, a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_015_586D::
    ld hl, $C412
    ld de, $C246
    ld c, $05
    call Func_015_5896
    ld a, [$C525]
    and a, a
    jr z, Jump_015_5889
    ld hl, $D27A
    ld de, $D0AE
    ld c, $05
    call Func_015_58B4

Jump_015_5889::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ret

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
    ld hl, $8AD0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_42D0
    ld hl, $8AE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_015_6F6B
    ld hl, $C364
    ld bc, $0807
    call Func_015_65B7
    ld a, [$D786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140B
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5920::
    ld c, $03
    ld hl, Data_015_732D
    call Func_015_67E5
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $02
    ld [$D780], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_593E::
    ld a, [$C6FD]
    cp a, $03
    jr nc, Jump_015_5998
    ld hl, $C6FE
    ld a, [$C6FD]
    add a, l
    ld l, a
    jr nc, Jump_015_5950
    inc h

Jump_015_5950::
    ld a, [$D7B4]
    ld [hl], a
    ld a, [$C6FD]
    inc a
    ld [$C6FD], a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7B4]
    ld c, $00
    call Func_000_1FD1
    ld a, $02
    ld [hl], a
    xor a, a
    ld [$1FFF], a
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld a, $01
    ld [$D7FA], a
    ld a, [$D781]
    sub a, $03
    ld [$D781], a
    call Func_015_586D
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5998::
    ld a, [$D7FA]
    ld b, $BC
    ld hl, Data_015_733B
    call Func_015_66CA
    xor a, a
    ld [$D7FA], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_59B8::
    ld de, Data_015_59E5
    ld hl, $C364
    ld bc, $0809
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_5A2D
    xor a, a
    ld [$D7AF], a
    ld [$D7AB], a
    ld [$D7AE], a
    ld a, [$D781]
    inc a
    ld [$D781], a
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
    call Func_000_0B2B
    pop bc
    dec c
    jr nz, Jump_015_5A2F
    ret

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
    db $D0, $8E, $E0, $8E, $F0, $8E, $50

Data_015_5A7E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F, $F0, $8F, $00

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
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0501
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld de, Data_015_73C9
    ld hl, $C364
    ld bc, $0809
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5ACA::
    ld a, [$C6FE]
    ld [$D789], a
    ld a, [$C6FF]
    ld [$D78A], a
    ld a, [$C700]
    ld [$D78B], a
    ld a, [$D7B4]
    ld [$D78C], a
    ld a, $04
    ld [$D7A9], a
    ld hl, Data_015_7163
    ld b, $1E
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5AF5::
    ld hl, $5C15
    ld b, $1F
    rst $10
    ret

Jump_015_5AFC::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [$D7F1], a
    call Func_015_6866
    ld de, Data_015_7411
    ld hl, $C36C
    ld bc, $0C09
    call Func_015_65B7
    pop af
    ld [$D7F1], a
    ld hl, $5B4D
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5B33::
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    ld hl, $8F80
    ld bc, $0501
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, $C378
    ld c, $28
    call Func_015_656C
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5B62::
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5B82::
    call Func_015_6655
    ld bc, $140B
    ld de, $01CC
    call Func_015_65F1
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5B96::
    xor a, a
    ld [$D7F9], a
    ld hl, $66B6
    ld b, $1D
    rst $10
    ld a, [$D7F9]
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
    ld a, [$D781]
    sub a, $07
    ld [$D781], a
    ret

Jump_015_5BC3::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ld a, $01
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5BD9::
    ld a, [$D781]
    add a, $03
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5C10::
    ld a, [$D781]
    sub a, $04
    ld [$D781], a
    ret

Jump_015_5C19::
    ld de, Data_01F_4180
    ld hl, $9770
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4330
    ld hl, $9730
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld c, $09
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [$D7F1], a
    ld a, $14
    ld [$D7F2], a
    call Func_015_6791
    ld de, Data_015_73AB
    ld hl, $C412
    ld bc, $0601
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5C5B::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    call Func_015_570C
    ld a, $06
    ld [$D781], a
    xor a, a
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5C7D::
    ld de, Data_01F_4180
    ld hl, $9770
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4330
    ld hl, $9730
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [$D7F1], a
    ld a, $08
    ld [$D7F2], a
    call Func_015_6791
    ld de, Data_015_73AB
    ld hl, $C412
    ld bc, $0605
    call Func_015_65B7
    ld de, Data_015_7471
    ld hl, $C40C
    ld bc, $0C01
    call Func_015_65B7
    xor a, a
    ld b, $BC
    ld hl, Data_015_733B
    call Func_015_66CA
    ld c, $04
    ld hl, Data_015_73A1
    call Func_015_67E5
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5CDC::
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld a, $13
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5CF7::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $D789
    ld a, [$D7AB]
    add a, l
    ld l, a
    jr nc, Jump_015_5D0B
    inc h

Jump_015_5D0B::
    ld a, [hl]
    ld c, $01
    call Func_000_1FA4
    xor a, a
    ld [$1FFF], a
    ld a, $F0
    ld [$C8D9], a
    ld hl, $C8CF
    ld de, $C130

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
    ld a, [$D781]
    inc a
    ld [$D781], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5D3E::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $D789
    ld a, [$D7AB]
    add a, l
    ld l, a
    jr nc, Jump_015_5D52
    inc h

Jump_015_5D52::
    ld a, [hl]
    ld c, $00
    call Func_000_1FD1
    ld a, $01
    ld [hl], a
    xor a, a
    ld [$1FFF], a
    ld a, [$D7AB]
    cp a, $03
    jr z, Jump_015_5DB3
    ld hl, $D789
    ld a, [$D7AB]
    add a, l
    ld l, a
    jr nc, Jump_015_5D71
    inc h

Jump_015_5D71::
    ld a, $FF
    ld [hl], a
    ld hl, $D789
    ld de, $C6FE
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
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $C6FE
    ld c, $00

Jump_015_5D9B::
    push bc
    push hl
    ld a, [hl]
    ld c, $00
    call Func_000_1FD1
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
    ld [$1FFF], a

Jump_015_5DB3::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5DBB::
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5DCE::
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [$D7F1], a
    ld a, $14
    ld [$D7F2], a
    call Func_015_6791
    ld de, Data_01F_43C0
    ld hl, $8AD0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_42D0
    ld hl, $8AE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_015_6F6B
    ld hl, $C364
    ld bc, $0807
    call Func_015_65B7
    call Func_015_4182
    ret

Jump_015_5E0C::
    call Func_015_570C
    ld a, [$D786]
    ld hl, Data_015_732D
    ld b, $BC
    call Func_015_66CA
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5E30::
    ld a, [$C919]
    ld [$C91C], a
    ld a, [$C91A]
    ld [$C91D], a
    ld a, [$C91B]
    ld [$C91E], a
    xor a, a
    ld [$C917], a
    ld a, $17
    ld [$C916], a
    ld hl, $405C
    ld b, $13
    rst $10
    xor a, a
    ld [$D7FD], a
    ld a, $06
    ld [$D780], a
    xor a, a
    ld [$CFA8], a
    ld [$CFA9], a
    ret

Jump_015_5E62::
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    push hl
    ld c, $0B
    call Func_000_1F89
    ldh a, [$FFC6]
    ld [$CADB], a
    ldh a, [$FFC7]
    ld [$CADC], a
    pop hl
    ld a, [hl]
    ld c, $6D
    call Func_000_1F80
    ldh a, [$FFC6]
    ld [$CB3D], a
    xor a, a
    ld [$1FFF], a
    ld a, [$C919]
    ld [$C91C], a
    ld a, [$C91A]
    ld [$C91D], a
    ld a, [$C91B]
    ld [$C91E], a
    xor a, a
    ld [$C917], a
    ld a, $16
    ld [$C916], a
    ld hl, $405C
    ld b, $13
    rst $10
    xor a, a
    ld [$D7FD], a
    ld a, $06
    ld [$D780], a
    xor a, a
    ld [$CFA8], a
    ld [$CFA9], a
    ret

Jump_015_5ECC::
    ld a, [$C919]
    ld [$C91C], a
    ld a, [$C91A]
    ld [$C91D], a
    ld a, [$C91B]
    ld [$C91E], a
    xor a, a
    ld [$C917], a
    ld a, $15
    ld [$C916], a
    ld hl, $405C
    ld b, $13
    rst $10
    xor a, a
    ld [$D7FD], a
    ld hl, $D780
    inc [hl]
    ret

Jump_015_5EF6::
    ld a, [$D781]
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
    ld a, [$C525]
    and a, a
    jr nz, Jump_015_5F1E
    ld hl, Jump_015_42B3
    ld b, $1C
    rst $10
    ld a, $FC
    call Func_000_0DF2

Jump_015_5F1E::
    ret

Jump_015_5F1F::
    call Func_015_6655
    ld a, h
    ld [$D7F5], a
    ld a, l
    ld [$D7F6], a
    ld de, $5E12
    ld a, d
    ld [$D7F1], a
    ld a, e
    ld [$D7F2], a
    ld a, $20
    ld [$D7F3], a
    ld a, $20
    ld [$D7F4], a
    xor a, a
    ld [$D7F7], a
    ld hl, $5D9A
    ld b, $1F
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_5F51::
    ld a, [$C56C]
    and a, a
    ret nz
    ld de, $CADB
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_015_6ACA
    ld hl, $C8CF
    ld de, $C130
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
    ld a, [$D781]
    inc a
    ld [$D781], a
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5FAD::
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, $01
    ld [$D780], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_5FD9::
    ld hl, $4069
    ld b, $1E
    rst $10
    ld a, [$D781]
    cp a, $0A
    ret nz
    ld a, [$D7B3]
    cp a, $23
    jr nz, Jump_015_5FFC
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    add a, $06
    ld [$D780], a
    ret

Jump_015_5FFC::
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    add a, $05
    ld [$D780], a
    ret

Jump_015_600C::
    ld hl, $4069
    ld b, $1E
    rst $10
    ld a, [$D781]
    cp a, $0A
    ret nz
    xor a, a
    ld [$D781], a
    ld [$D782], a
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    ret

Jump_015_6028::
    ld a, [$D781]
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
    ld hl, $9000
    ld de, Data_047_629A
    ld b, $47
    call Func_000_0CF5
    ld hl, $C49F
    ld de, Data_047_67E2
    ld b, $47
    ld c, $40
    call Func_000_0B2B
    ld a, $7F
    ld [$C526], a
    ld a, [$D781]
    inc a
    ld [$D781], a
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
    ld hl, $C3BB
    ld bc, $0D09
    call Func_015_65B7
    ld hl, Data_015_71E1
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_015_60A4
    ld hl, $C462
    call Func_015_6772
    ld hl, $C463
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, Data_015_759A
    ld b, $1E
    rst $10

Jump_015_60A4::
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_60AC::
    ld a, $01
    ld [$D7F5], a
    ld hl, $6088
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_015_60BF::
    ld de, Data_01F_4990
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, $01
    ld [$D7F1], a
    ld [$D7F2], a
    ld hl, $6320
    ld b, $1D
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_60E2::
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_015_7333
    call Func_015_66CA
    ld de, Data_015_7351
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_6101::
    ld hl, $5DA1
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [hl]
    ld c, $6D
    call Func_000_1F80
    xor a, a
    ld [$1FFF], a
    call Func_015_67F9
    call Func_015_6822
    xor a, a
    ld [$C528], a
    ld a, $1B
    ld [$C529], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $4C94
    ld b, $1B
    rst $10
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_6155::
    ld hl, $4AA8
    ld b, $04
    rst $10
    ld a, $7F
    ld [$C527], a
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
    ld hl, Data_015_7763
    ld b, $1E
    rst $10
    ld a, $70
    ldh [$FFBA], a
    xor a, a
    ld [$D782], a
    ld a, [$D7B2]
    ld [$D780], a
    ld a, [$D7B3]
    ld [$D781], a
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1202
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_61B6::
    ld a, [$D781]
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
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0501
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_61F5::
    ld a, [$C58A]
    and a, a
    jr nz, Jump_015_6203
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_6203::
    call Func_015_63D3
    ld de, Data_01F_4230
    ld hl, $8CE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4290
    ld hl, $8CF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4370
    ld hl, $8DF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_6235::
    ld c, $04
    ld hl, Data_015_73A1
    call Func_015_67E5
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
    ld de, Data_015_7351
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_625C::
    ld a, [$D781]
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
    ld hl, $8A70
    ld bc, $0901
    call Func_000_1881
    ld hl, $8F80
    ld bc, $0501
    call Func_000_1881
    ld a, [$D7B4]
    ld [$D7F1], a
    ld hl, $5CD7
    ld b, $1D
    rst $10
    call Func_015_6A82
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_629F::
    ld a, $C7
    ld [$D7F1], a
    ld a, [$D7B4]
    ld b, a
    call Func_015_6866
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [$D7F1], a
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
    ld a, [$D781]
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
    ld hl, $5F2D
    ld b, $1D
    rst $10

Jump_015_62F7::
    ld hl, Data_015_7163
    ld b, $1E
    rst $10
    ld a, [$D7B0]
    cp a, $02
    jr c, Jump_015_631B
    ld hl, $C42E
    call Func_015_6772
    ld hl, $C42F
    ld a, h
    ld [$D7F1], a
    ld a, l
    ld [$D7F2], a
    ld hl, Data_015_759A
    ld b, $1E
    rst $10

Jump_015_631B::
    ld c, $05
    ld hl, Data_015_73A1
    call Func_015_67E5
    ld a, [$D7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call Func_015_66CA
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_6336::
    ld hl, $8A40
    ld bc, $0C01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0D01
    call Func_000_1881
    ld hl, $8CE0
    ld bc, $1101
    call Func_000_1881
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Jump_015_6359::
    ld hl, $5C15
    ld b, $1F
    rst $10
    ret

Func_015_6360::
    ld de, Data_015_7351
    ld hl, $C410
    ld bc, $0805
    call Func_015_65B7
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Func_015_6374::
    push hl
    push de
    ld a, [$D785]
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
    ld a, [$D785]
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
    call Func_000_0B2B
    pop de
    pop hl
    ld a, [$D785]
    inc a
    ld [$D785], a
    jr Func_015_6374

Jump_015_63AE::
    pop de
    pop hl
    xor a, a
    ld [$D785], a
    ld [$D784], a
    ret

Func_015_63B8::
    ld a, $A4
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld [$D7F3], a
    ld [$D7F4], a
    ld a, $80
    ld [$D7F5], a
    ld hl, $6973
    ld b, $1D
    rst $10
    ret

Func_015_63D3::
    ld a, [$C58A]
    and a, a
    ret z
    ld a, $0A
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld hl, $BB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, Jump_015_63F5

Jump_015_63ED::
    xor a, a
    ld [$4100], a
    ld [$1FFF], a
    ret

Jump_015_63F5::
    ld a, [$D780]
    cp a, $04
    jr nz, Jump_015_63ED
    ld a, [$D781]
    cp a, $37
    jr nc, Jump_015_63ED

Func_015_6403::
    xor a, a
    ld [$4100], a
    ld [$1FFF], a
    ld a, $90
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    ld [$D7F3], a
    ld a, $88
    ld [$D7F4], a
    ld a, $28
    ld [$D7F5], a
    xor a, a
    ld [$D7F6], a
    ld c, $01
    ld hl, $6A3F
    ld b, $1D
    rst $10
    ret

Func_015_642D::
    ld a, [$C58A]
    and a, a
    jr nz, Jump_015_6439
    ld a, $02
    ld [$D782], a
    ret

Jump_015_6439::
    ld a, [$D782]
    and a, a
    jr nz, Jump_015_6441
    jr Jump_015_644D

Jump_015_6441::
    ld de, Data_015_727D
    ld hl, $C3C8
    ld bc, $1401
    call Func_015_65B7

Jump_015_644D::
    ld a, $02
    ld [$D782], a
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ret

Func_015_645F::
    ld de, Data_015_70C5
    ld hl, $C364
    ld bc, $140B
    call Func_015_65B7
    call Func_015_6655
    ld bc, $140D
    ld de, $01CC
    call Func_015_65F1
    ret

Func_015_6478::
    ld a, [$C563]
    bit 6, a
    jr nz, Jump_015_6494
    bit 7, a
    jr nz, Jump_015_64C2
    ld a, [$C562]
    bit 0, a
    jp nz, Jump_015_64DC
    bit 1, a
    jp nz, Jump_015_6511
    call Func_015_6524
    ret

Jump_015_6494::
    call Func_015_6542
    ld a, [$D786]
    and a, a
    jr nz, Jump_015_64AB
    ld a, $02
    ld [$D786], a
    call Func_015_6524
    ld a, $69
    call Func_000_1278
    ret

Jump_015_64AB::
    dec a

Jump_015_64AC::
    ld [$D786], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    call Func_015_6524
    ld a, $69
    call Func_000_1278
    ret

Jump_015_64C2::
    call Func_015_6542
    ld a, [$D786]
    cp a, $02
    jr c, Jump_015_64D9
    xor a, a
    ld [$D786], a
    call Func_015_6524
    ld a, $69
    call Func_000_1278
    ret

Jump_015_64D9::
    inc a
    jr Jump_015_64AC

Jump_015_64DC::
    ld a, $69
    call Func_000_1278
    call Func_015_6546
    ld c, $03
    ld hl, Data_015_732D
    call Func_015_67E5
    ld a, [$D786]
    cp a, $02
    jr z, Jump_015_6511
    ld [$D7FA], a
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7AB], a
    ld [$D7AD], a
    ld [$D7AF], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Jump_015_6511::
    ld a, $02
    ld [$D7FA], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    xor a, a
    ld [$C89D], a
    ret

Func_015_6524::
    ld a, [$C564]
    cp a, $14
    jr c, Jump_015_653E
    ld a, [$D787]
    inc a
    ld [$D787], a
    cp a, $10
    jr c, Jump_015_653E
    cp a, $18
    jr c, Func_015_6542
    xor a, a
    ld [$D787], a

Jump_015_653E::
    ld b, $BB
    jr Jump_015_6548

Func_015_6542::
    ld b, $C3
    jr Jump_015_6548

Func_015_6546::
    ld b, $BC

Jump_015_6548::
    ld a, [$D786]
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
    call Func_000_120A
    ld a, b
    ld [hl], a
    ei
    ret

Data_015_6566:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

Func_015_656C::
    ld b, $00

Jump_015_656E::
    push bc
    push hl
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $D789
    ld a, b
    add a, l
    ld l, a
    jr nc, Jump_015_6582
    inc h

Jump_015_6582::
    ld a, [hl]
    ld c, $00
    ld b, $01
    call Func_000_1F80
    xor a, a
    ld [$4100], a
    ld [$1FFF], a
    ldh a, [$FFC6]
    cp a, $02
    jr nz, Jump_015_65AD
    pop hl
    pop bc
    push bc
    di

Jump_015_659B::
    ldh a, [$FF41]
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
    ld a, [$C6FD]
    cp a, b
    jr nz, Jump_015_656E
    ret

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
    ld a, [$C525]
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [$FF70], a

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
    ldh [$FF70], a
    ret

Func_015_65F1::
    push de
    push bc
    push hl
    ld hl, $C198
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call Func_000_18A5
    pop hl
    push hl
    ld a, [$C529]
    cp a, $10
    jr z, Jump_015_6634
    cp a, $11
    jr z, Jump_015_6634
    cp a, $12
    jr z, Jump_015_6634
    ld a, l
    add a, $C1
    ld [$C554], a
    ld a, h
    adc a, $01
    ld [$C555], a
    ld a, [$C555]
    cp a, $9B
    jr nz, Jump_015_6634
    ld a, [$C554]
    cp a, $61
    jr nz, Jump_015_6634
    ld a, $C1
    ld [$C554], a
    ld a, $99
    ld [$C555], a

Jump_015_6634::
    pop hl
    pop bc
    pop de
    ld a, [$C525]
    and a, a
    ret z
    ld a, $01
    ldh [$FF4F], a
    ld a, $02
    ldh [$FF70], a
    push hl
    ld hl, $D000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call Func_000_18A5
    xor a, a
    ldh [$FF70], a
    ldh [$FF4F], a
    ret

Func_015_6655::
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
    jr nc, Jump_015_6675
    inc h

Jump_015_6675::
    ret

Func_015_6676::
    ld de, $FFC9
    ld hl, $D7F1
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
    ld hl, $D7F1

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

Func_015_66AF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_015_66AF
    ret

Func_015_66B8::
    ld a, $02
    ldh [$FF70], a

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
    ldh [$FF70], a
    ret

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

Func_015_66D8::
    ld hl, Data_015_731B
    ld a, $9D
    jr Jump_015_66E4

Func_015_66DF::
    ld hl, Data_015_731B
    ld a, $9C

Jump_015_66E4::
    ld [$D7F1], a
    xor a, a
    ld [$D7F2], a
    xor a, a
    ld [$D784], a

Jump_015_66EF::
    push hl
    ld a, [$D785]
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
    ld a, [$D785]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [$D7F1]
    ld d, a
    ld a, [$D7F2]
    ld e, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call Func_015_6780
    pop hl
    ld a, [$D785]
    inc a
    ld [$D785], a
    ld a, [$D784]
    inc a
    ld [$D784], a
    cp a, $06
    jr c, Jump_015_66EF
    ret

Jump_015_6734::
    pop de
    pop hl
    xor a, a
    ld [$D784], a
    ld [$D785], a
    ld hl, $D781
    inc [hl]
    ret

Func_015_6742::
    push de
    call Func_015_6655
    pop de
    add hl, de
    push hl
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, $C5
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, $BE
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    call Func_000_24F8
    di
    call Func_000_120A
    ld a, $C6
    ld [hl], a
    ei
    ret

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

Func_015_6780::
    ld c, $10

Jump_015_6782::
    di

Jump_015_6783::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_015_6783
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_015_6782
    ret

Func_015_6791::
    push bc
    push hl
    push de
    ld de, $C198
    add hl, de
    pop de
    push de
    push hl
    ld hl, $C198
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld c, a
    call Func_015_66AF
    pop de
    pop hl
    ld a, [$C525]
    and a, a
    jr z, Jump_015_67D2
    push hl
    push de
    ld de, $D000
    add hl, de
    pop de
    push de
    push hl
    ld hl, $D000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
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

Func_015_67F9::
    call Func_015_680F
    ld a, l
    ld [$C8C0], a
    ld a, h
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    call Func_015_6676
    ret

Func_015_680F::
    ldh a, [$FFC6]
    ld c, $0A
    ld hl, $0000
    call Func_000_1682
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Func_015_6822::
    ld hl, $D7F4
    ld de, $C130
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

Func_015_683C::
    ld a, [$D7F3]
    ld e, a
    ld a, [$D7F2]
    ld h, a
    ld a, [$D7F1]
    ld l, a
    ld a, [$C619]
    ld d, a
    ld a, [$C618]
    ld b, a
    ld a, [$C617]
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, d
    sbc a, e
    ld [$C619], a
    ld a, b
    ld [$C618], a
    ld a, c
    ld [$C617], a
    ret

Func_015_6866::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, b
    ld c, $0D
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $0F
    ld [$D09D], a
    ld a, [$D7F1]
    ld [$D09E], a
    ld hl, $7A48
    ld b, $16
    rst $10
    xor a, a
    ld [$1FFF], a
    ret

Func_015_688D::
    ld a, [$D7F1]
    ld b, a
    ld a, [$D7F2]
    ld l, a
    ld a, [$D7F3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, b
    ld c, $0E
    ld b, $01
    call Func_000_1F80
    ldh a, [$FFC6]
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
    call Func_000_1F80
    ldh a, [$FFC6]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_015_68DC
    ld a, [$C8C1]
    add a, $E0
    pop hl
    ld [hl+], a
    ld a, [$C8C2]
    add a, $E0
    ld [hl+], a
    pop bc
    ret

Func_015_68DC::
    ld a, [$C8C0]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [$C8C0], a
    ld a, [$C8C1]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [$C8C1], a

Jump_015_68F2::
    ret

Func_015_68F3::
    call Func_015_68FA
    ld a, [hl]
    or a, b
    ld [hl], a
    ret

Func_015_68FA::
    ld a, [$D7F1]
    ld e, a
    ld a, [$D7F2]
    ld d, a
    push de
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [$D7F3]
    ld l, a
    ld a, [$D7F4]
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
    ld [$D7F5], a
    ret

Jump_015_6931::
    ld a, $FF
    ld [$D7F5], a
    ret

Data_015_6937:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

Func_015_693F::
    ld hl, $D789
    ld b, $1E

Jump_015_6944::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_6944
    ld hl, $D7BE
    ld b, $1E

Jump_015_694E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_694E
    xor a, a
    ld [$D7A9], a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld [$D7B9], a
    ld de, $A000
    ld hl, $D789
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
    ld hl, $D7F1
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
    ld a, [$D7B9]
    inc a
    ld [$D7B9], a

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
    ld [$D7A9], a
    xor a, a
    ld [$1FFF], a
    ld hl, $5F9C
    ld b, $1D
    rst $10
    ret

Func_015_69C6::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7B4]
    ld c, $0E
    call Func_000_1F80
    ldh a, [$FFC6]
    and a, $01
    ld [$D7F1], a
    xor a, a
    ld [$1FFF], a
    ret

Func_015_69E3::
    ld hl, $97C0
    ld bc, $0401
    call Func_000_1881
    ld hl, $8C00
    ld bc, $0301
    call Func_000_1881
    ld hl, $8CA0
    ld bc, $0201
    call Func_000_1881

Func_015_69FE::
    ld hl, $9700
    ld bc, $0901
    call Func_000_1881
    ld hl, $8F50
    ld bc, $0301
    call Func_000_1881
    ld hl, $8FD0
    ld bc, $0201
    call Func_000_1881
    ret

Func_015_6A1A::
    ld hl, $8A40
    ld bc, $0C01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0D01
    call Func_000_1881
    ld hl, $8CE0
    ld bc, $1101
    call Func_000_1881
    ret

Func_015_6A36::
    ld a, [$D7F1]
    ld b, a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    push bc
    ld a, b
    ld c, $01
    call Func_000_1FA4
    ld a, $F0
    ld [$C8D9], a
    xor a, a
    ld c, a
    ld a, $02
    ld [$D7F5], a
    ld hl, $6129
    ld b, $1D
    rst $10
    pop bc
    push bc
    ld a, b
    ld c, $0B
    ld b, $02
    call Func_000_1F89
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    call Func_015_6ACA
    xor a, a
    ld c, a
    ld a, $03
    ld [$D7F5], a
    ld hl, $6129
    ld b, $1D
    rst $10
    pop bc
    xor a, a
    ld [$1FFF], a
    ret

Func_015_6A82::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld a, [$D7B4]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld de, $C986
    ld b, $A5

Jump_015_6A9C::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6A9C
    ld hl, Jump_015_5D84
    ld b, $1D
    rst $10
    ld a, [$D7F5]
    ld h, a
    ld a, [$D7F6]
    ld l, a
    ld a, [hl]
    ld c, $A5
    call Func_000_1682
    ld de, $A000
    add hl, de
    ld de, $CA2B
    ld b, $A5

Jump_015_6ABF::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6ABF
    xor a, a
    ld [$1FFF], a
    ret

Func_015_6ACA::
    push hl
    ld a, [$D7FE]
    push af
    ld a, $08
    ld [$D7FE], a
    ld hl, $4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_015_6ADE
    inc h

Jump_015_6ADE::
    call Func_000_0B6C
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call Func_000_0B6C
    ld e, b
    ld d, c
    pop af
    ld [$D7FE], a
    ld hl, $C8CF
    ld b, $08
    ld c, $10
    call Func_000_0B2B
    ret

Func_015_6B00::
    ld hl, $8A40
    ld bc, $0901
    call Func_000_1881
    ld hl, $8C70
    ld bc, $0301
    call Func_000_1881
    ld hl, $8D00
    ld bc, $0F01
    call Func_000_1881
    ld hl, $8F00
    ld bc, $0D01
    call Func_000_1881
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, Data_015_706E
    ld b, $02
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr z, Jump_015_6B6B
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $8D
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0F
    xor a, a
    ld [$C528], a
    ld a, $28
    ld [$C529], a
    ld hl, $4C94
    ld b, $1B
    rst $10
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [$D782], a
    ret

Jump_015_6B6B::
    ld a, $0A
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld de, Data_015_71A1
    ld hl, $C364
    ld bc, $140B
    call Func_015_65B7
    ld hl, $BB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr z, Jump_015_6BA1
    ld hl, Data_015_763B
    ld de, $96F0
    call Func_015_6780
    ld a, $6F
    ld hl, $C3B0
    ld [hl+], a
    ld [hl], a
    ld hl, $C3C4
    ld [hl+], a
    ld [hl], a

Jump_015_6BA1::
    ld hl, $BB0F
    ld de, $C8CF
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
    ld de, $8A80
    call Func_000_21A1
    ld a, $16
    ld [$C8CF], a
    ld a, $24
    ld [$C8D0], a
    ld a, $36
    ld [$C8D1], a
    ld a, $37
    ld [$C8D2], a
    ld a, $F0
    ld [$C8D3], a
    ld de, $8A40
    call Func_000_21A1
    ld a, $28
    ld [$C8CF], a
    ld a, $35
    ld [$C8D0], a
    ld a, $F0
    ld [$C8D1], a
    ld de, $9780
    call Func_000_21A1
    ld hl, $BB0F
    ld a, $F1
    add a, l
    ld l, a
    jr nc, Jump_015_6BFB
    inc h

Jump_015_6BFB::
    ld b, [hl]
    ld hl, $BB0F
    ld a, $F2
    add a, l
    ld l, a
    jr nc, Jump_015_6C06
    inc h

Jump_015_6C06::
    ld c, $00
    xor a, a
    ld [$1FFF], a

Jump_015_6C0C::
    push hl
    push bc
    call Func_015_6DE6
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld a, $01
    ld [$D7F2], a
    ld hl, $795D
    ld b, $1D
    rst $10
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
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld a, [hl]
    and a, $0F
    ld [$D09D], a
    xor a, a
    ld [$1FFF], a
    pop bc
    push bc
    ld a, c
    add a, $C7
    ld [$D09E], a
    ld hl, $7A48
    ld b, $16
    rst $10
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
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    xor a, a
    ld [$1FFF], a
    call Func_000_16F5
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
    ld a, [$C8C1]
    and a, a
    jr z, Jump_015_6CB4
    di
    call Func_000_120A
    ld a, [$C8C1]
    add a, $E0
    ld [hl], a
    ei
    inc hl

Jump_015_6CB4::
    di
    call Func_000_120A
    ld a, [$C8C2]
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
    call Func_000_120A
    ld a, $EA
    ld [de], a
    ei
    inc de
    di
    call Func_000_120A
    ld a, $ED
    ld [de], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6CC8
    ld hl, $BB0F
    ld de, $0221
    add hl, de
    push hl
    inc hl
    inc hl
    inc hl
    ld a, $0A
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    call Func_000_16F5
    ld hl, $C385
    ld c, $00
    ld de, $C8C0
    ld b, $03
    call Func_015_6DD6
    pop hl
    inc hl
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    xor a, a
    ld [$1FFF], a
    call Func_000_16F5
    ld hl, $C389
    ld c, $00
    ld de, $C8C1
    ld b, $02
    call Func_015_6DD6
    ld hl, $BB01
    ld a, $06
    add a, l
    ld l, a
    jr nc, Jump_015_6D3D
    inc h

Jump_015_6D3D::
    ld a, $0A
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld a, [hl]
    add a, $0A
    cp a, $0D
    jr nz, Jump_015_6D9A
    ld hl, $BE0D
    ld a, [hl]
    bit 7, a
    jr z, Jump_015_6D98
    ld hl, $BD36
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, $BC0A
    add hl, de
    inc hl
    ld de, $C130
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
    ld [$C528], a
    ld a, $05
    ld [$C529], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    ld hl, Jump_015_402B
    ld b, $08
    rst $10
    jr Jump_015_6DB4

Jump_015_6D98::
    ld a, $0D

Jump_015_6D9A::
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    ld hl, Jump_015_402B
    ld b, $08
    rst $10

Jump_015_6DB4::
    xor a, a
    ld [$4100], a
    ld [$1FFF], a
    call Func_015_63B8
    ld hl, $C52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [$D782], a
    ret

Data_015_6DD0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A8, $C3, $D0, $C3, $F8, $C3

Func_015_6DD6::
    di
    call Func_000_120A
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

Func_015_6DE6::
    ld a, $0A
    ld [$1FFF], a
    ld a, $01
    ld [$4100], a
    ld a, c
    add a, l
    ld l, a
    jr nc, Jump_015_6DF6
    inc h

Jump_015_6DF6::
    ld a, [hl]
    ld c, $6F
    call Func_000_1682
    ld de, $A06F
    add hl, de
    xor a, a
    ld [$4100], a
    ld [$1FFF], a
    ret

Data_015_6E08:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $C3, $D2, $C3, $FA, $C3

Data_015_6E0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D

Func_015_6E14::
    ld a, [$C938]
    ldh [$FF8E], a
    ld a, [$C939]
    ldh [$FF91], a
    ld a, [$C93A]
    ldh [$FF98], a
    ld a, [$C93B]
    ld [$C8EF], a
    ld a, [$C93C]
    ld [$C8F0], a
    ld a, [$C93D]
    ld [$C8F1], a
    ld a, [$C93E]
    ld [$C8F4], a
    ld a, [$C93F]
    ld [$C8F5], a
    ld a, [$C940]
    ld [$C8F6], a
    ld a, [$C941]
    ld [$C8F9], a
    ld a, [$C942]
    ld [$C8FA], a
    ld a, [$C943]
    ld [$C8FB], a
    ld a, [$C937]
    ld [$CB86], a
    xor a, a
    ld [$C936], a
    ret

Func_015_6E64::
    ld a, [$CF8C]
    cp a, $FF
    jr z, Jump_015_6E86
    ld b, a
    ld a, [$CF8B]
    or a, b
    and a, a
    jr z, Jump_015_6E86
    ld de, $CF8B
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
    ld a, [$CF8D]
    ld [hl], a

Jump_015_6E86::
    ld a, [$CF8F]
    cp a, $FF
    ret z
    ld b, a
    ld a, [$CF8E]
    or a, b
    ret z
    ld de, $CF8E
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
    ld a, [$CF90]
    ld [hl], a
    ret

Func_015_6EA5::
    xor a, a
    ld [$CF8B], a
    ld [$CF8C], a
    ld [$CF8D], a
    ld [$CF8E], a
    ld [$CF8F], a
    ld [$CF90], a
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    xor a, a
    ld [$D7F1], a
    ld de, $CF8B
    ld a, [$CA2A]
    and a, a
    call nz, Func_015_6EFD
    ld a, [$C58A]
    and a, a
    jr nz, Jump_015_6EDF
    ld de, $CF8E
    ld a, [$CACF]
    and a, a
    call nz, Func_015_6EFD

Jump_015_6EDF::
    xor a, a
    ld [$0100], a
    ld [$4100], a
    ld a, [$D7F1]
    ld [$D7FA], a
    ld a, [$D782]
    inc a
    ld [$D782], a
    xor a, a
    ld [$C920], a
    ld a, $80
    ld [$C919], a
    ret

Func_015_6EFD::
    add a, $3F
    ldh [$FFC6], a
    ld c, a
    ld hl, $C635
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
    ld hl, $CF8B
    ld a, l
    cp a, e
    jr nz, Jump_015_6F2A
    ld a, h
    cp a, d
    jr nz, Jump_015_6F2A
    pop hl
    jr Jump_015_6F45

Jump_015_6F2A::
    ld a, [$CF8D]
    ld l, a
    ldh a, [$FFC6]
    cp a, l
    jr z, Jump_015_6F44
    pop hl
    push hl
    ld a, [$CF8B]
    cp a, l
    jr nz, Jump_015_6F44
    ld a, [$CF8C]
    cp a, h
    jr nz, Jump_015_6F44
    pop hl
    jr Jump_015_6F0E

Jump_015_6F44::
    pop hl

Jump_015_6F45::
    ldh a, [$FFC6]
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
    ld [$D7F1], a
    ret

Jump_015_6F5C::
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    ld a, [$D7F1]
    and a, a
    ret nz
    xor a, a
    ld [$D7F1], a
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
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $D0
    db $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $C3, $B7, $B6, $C3, $C3, $C3

Data_015_706E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05706E, $57

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
    ds $11, $C3

Data_015_7163:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $B7, $B6
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
    db $B7, $B6, $C7, $D0, $D1

Data_015_71E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D2, $D3, $D4, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6
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
    db $C3, $C3

Data_015_7347:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $B7, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B5

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
    db $B9, $B9, $B9

Data_015_7564:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BA

Data_015_7565:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C9, $7C, $7D
    db $7E, $7F, $C0, $C1, $C2, $CA, $CB, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9
    db $B9, $B9, $B9, $BA

Data_015_7589:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $F5, $F6, $F7
    db $FD

Data_015_759A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FE, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $B7, $B6, $FF, $77, $78, $70, $71, $72, $73, $74, $75, $76, $B7, $B3
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

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
    INCBIN "dwm2-cobi-us.gbc", $05763B, $10A

Data_015_7745:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $00, $1A, $C0, $ED, $07, $34, $77, $ED, $07, $42, $77, $ED, $E4, $0C
    db $00, $00, $1D, $C0, $ED, $00, $04, $C0, $ED, $07, $4C, $76, $00, $21

Data_015_7763:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $057763, $49

Func_015_77AC::
    ld hl, $D789
    ld b, $1E

Jump_015_77B1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_77B1
    xor a, a
    ld [$D7A9], a
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld de, $B356
    ld hl, $D789
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
    ld de, $A000
    ld a, $01
    ld [$4100], a
    ld a, [de]
    bit 7, a
    jr z, Jump_015_77F2
    inc c
    ld a, b
    ld [hl+], a

Jump_015_77F2::
    ld a, c
    ld [$D7A9], a
    xor a, a
    ld [$1FFF], a
    ret

Func_015_77FB::
    ld a, $0A
    ld [$1FFF], a
    xor a, a
    ld [$4100], a
    ld hl, $D789
    ld a, [$D7AF]
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
    ld a, [$D7B1]
    cp a, $04
    jr c, Jump_015_7823
    ld a, [$D7A9]
    jr Jump_015_7832

Jump_015_7823::
    ld a, [$D7B0]
    cp a, $01
    jr nz, Jump_015_782F
    ld a, [$D7A9]
    jr Jump_015_7832

Jump_015_782F::
    ld a, [$D7A9]

Jump_015_7832::
    ld b, a
    ld a, [$D7AF]
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
    ld [$D7F1], a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_015_7864
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    ld [$D7F2], a

Jump_015_785A::
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    jr Jump_015_7876

Jump_015_7864::
    ld a, $01
    ld [$D7F2], a
    ld hl, $A000
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    jr Jump_015_785A

Jump_015_7876::
    ld hl, $795D
    ld b, $1D
    rst $10
    ld a, $F0
    ld [$C8D9], a
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
    ld a, [$D7A9]
    cp a, c
    jr z, Jump_015_78AF
    ld a, c
    cp a, $05
    jp c, Jump_015_7817

Jump_015_78AF::
    xor a, a
    ld [$1FFF], a
    ld a, [$D781]
    inc a
    ld [$D781], a
    ret

Data_015_78BB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

Func_015_78C5::
    xor a, a
    ld [$D784], a
    ld [$D785], a
    ld hl, $C8CF

Jump_015_78CF::
    ld a, [$D784]
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
    call Func_000_0B2B
    jr Jump_015_78FD

Jump_015_78EE::
    push af
    ld a, [$D785]
    dec a
    ld [$D785], a
    pop af
    call Func_015_7917
    call Func_000_0B46

Jump_015_78FD::
    pop hl
    ld a, [$D785]
    inc a
    ld [$D785], a
    ld a, [$D784]
    inc a
    ld [$D784], a
    jr Jump_015_78CF

Jump_015_790E::
    pop hl
    xor a, a
    ld [$D785], a
    ld [$D784], a
    ret

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
    ld a, [$D785]
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

Func_015_7954::
    ld a, [$D7F1]
    ld b, a
    ld a, $0A
    ld [$1FFF], a
    call Func_015_7A43
    ld a, [hl]
    and a, $0F
    ld [$D09D], a
    ld a, $C7
    ld [$D09E], a
    ld hl, $7A48
    ld b, $16
    rst $10
    xor a, a
    ld [$1FFF], a
    ret

Func_015_7976::
    ld a, [$D7F1]
    ld b, a
    ld a, $0A
    ld [$1FFF], a
    call Func_015_7A43
    push hl
    inc hl
    ld a, [hl]
    and a, $08
    sla a
    swap a
    pop hl
    add a, $CC
    ld [$C386], a
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
    call Func_000_16F5
    call Func_015_7ADB
    ld a, [$C8C1]
    add a, $E0
    ld [$C389], a
    ld a, [$C8C2]
    add a, $E0
    ld [$C38A], a
    pop hl
    push hl
    ld a, $57
    add a, l
    ld l, a
    jr nc, Jump_015_79BE
    inc h

Jump_015_79BE::
    ld a, [hl+]
    ld [$D7F1], a
    ld a, [hl+]
    ld [$D7F3], a
    ld a, [hl+]
    ld [$D7F5], a
    ld a, [hl+]
    ld [$D7F7], a
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [$D7F2], a
    ld a, [hl]
    and a, $30
    swap a
    ld [$D7F4], a
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [$D7F6], a
    ld a, [hl]
    and a, $03
    ld [$D7F8], a
    pop hl
    ld c, $00

Jump_015_79F5::
    push bc
    ld a, c
    sla a
    ld de, $D7F1
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
    call Func_000_16F5
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
    ld a, [$C8C0]
    add a, $E0
    ld [de], a
    inc de
    ld a, [$C8C1]
    add a, $E0
    ld [de], a
    inc de
    ld a, [$C8C2]
    add a, $E0
    ld [de], a
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_015_79F5
    xor a, a
    ld [$1FFF], a
    ret

Data_015_7A3B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

Func_015_7A43::
    ld a, b
    cp a, $1D
    jr z, Jump_015_7A56
    ld c, $6F
    call Func_000_1682
    ld de, $B356
    add hl, de
    xor a, a
    ld [$4100], a
    ret

Jump_015_7A56::
    ld hl, $A000
    ld a, $01
    ld [$4100], a
    ret

Func_015_7A5F::
    ld a, [$D7F1]
    ld b, a
    ld a, $0A
    ld [$1FFF], a
    call Func_015_7A43
    push hl
    ld [$D7F2], a
    xor a, a
    ld [$D7F1], a
    ld a, l
    ld [$D7F3], a
    ld a, h
    ld [$D7F4], a
    ld hl, Func_01D_795D
    ld b, $1D
    rst $10
    ld a, $F0
    ld [$C8D9], a
    ld de, $8F80
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
    ld a, [$D7FE]
    push af
    ld a, $08
    ld [$D7FE], a
    ld hl, $4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_015_7AAA
    inc h

Jump_015_7AAA::
    call Func_000_0B6C
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
    call Func_000_0B6C
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [$D7FE], a
    ld hl, $C8CF
    ld b, $08
    ld c, $10
    call Func_000_0B2B
    ld de, $8A70
    call Func_000_21A1
    xor a, a
    ld [$1FFF], a
    ret

Func_015_7ADB::
    ld a, [$C8C0]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [$C8C0], a
    ld a, [$C8C1]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [$C8C1], a

Jump_015_7AF1::
    ret
    ds $3A4, $00

Data_015_7E96:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16A, $00
