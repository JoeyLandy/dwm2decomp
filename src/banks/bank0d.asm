SECTION "Bank 0D", ROMX[$4000], BANK[$0D]
    db $0D

Func_00D_4001::
    ld de, Data_00D_4016
    call Func_000_25C9
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9

Func_00D_400F::
    call Func_00D_4001
    call Func_000_2611
    ret

Data_00D_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00D_4018

Data_00D_4018:: ; heuristic: target of a monotone pointer table; C0
    dw Data_00D_4078
    dw Data_00D_4078
    dw Data_00D_40B8
    dw Data_00D_40EB
    dw Data_00D_410E
    dw Data_00D_412D
    dw Data_00D_414D
    dw Data_00D_414D
    dw Data_00D_418C
    dw Data_00D_41B2
    dw Data_00D_41D8
    dw Data_00D_4221
    dw Data_00D_423F
    dw Data_00D_423F
    dw Data_00D_423F
    dw Data_00D_423F
    dw Data_00D_42A0
    dw Data_00D_42A0
    dw Data_00D_42E2
    dw Data_00D_4303
    dw Data_00D_4325
    dw Data_00D_4348
    dw Data_00D_436C
    dw Data_00D_4388
    dw Data_00D_43AC
    dw Data_00D_43CF
    dw Data_00D_43F4
    dw Data_00D_4417
    dw Data_00D_443F
    dw Data_00D_4459
    dw Data_00D_447B
    dw Data_00D_449D
    dw Data_00D_44BE
    dw Data_00D_44E6
    dw Data_00D_44FE
    dw Data_00D_4521
    dw Data_00D_452A
    dw Func_00D_4599
    dw Func_00D_4599
    dw Func_00D_4599
    dw Func_00D_4599
    dw Func_00D_45A1
    dw Func_00D_45A8
    dw Func_00D_45B1
    db $BB, $45, $C3, $45, $CB, $45, $D1, $45

Data_00D_4078:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $28, $2F, $26, $32, $30, $28, $90, $37, $32, $90, $37, $2B
    db $28, $F1, $14, $28, $3C, $90, $1C, $2B, $32, $33, $B5, $FA, $F7, $EF, $EE, $0D
    db $32, $90, $3C, $32, $38, $90, $31, $28, $28, $27, $90, $24, $31, $3C, $EF, $EE
    db $2E, $28, $3C, $36, $90, $24, $33, $33, $35, $24, $2C, $36, $28, $27, $98, $F0

Data_00D_40B8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $18, $2E, $24, $3C, $B5, $90, $0C, $32, $30, $28, $90, $25, $24, $26, $2E
    db $90, $2C, $29, $F1, $3C, $32, $38, $90, $29, $2C, $31, $27, $90, $24, $31, $3C
    db $90, $16, $24, $2A, $2C, $26, $FA, $F7, $EF, $EE, $14, $28, $3C, $36, $B5, $EF
    db $EE, $F7, $F0

Data_00D_40EB:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0D, $32, $31, $41, $90, $26, $32, $30, $28, $90, $2C, $29, $F1
    db $3C, $32, $38, $90, $2B, $24, $39, $28, $90, $31, $32, $90, $2E, $28, $3C, $36
    db $B5, $F7, $F0

Data_00D_410E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $20, $2B, $2C, $26, $2B, $90, $2E, $28, $3C, $90, $36, $2B, $32, $38, $2F
    db $27, $F1, $12, $90, $24, $33, $33, $35, $24, $2C, $36, $28, $98, $F7, $F0

Data_00D_412D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0A, $33, $33, $35, $24, $2C, $36, $24, $2F, $90, $3A, $2C, $2F
    db $2F, $F1, $26, $32, $36, $37, $90, $F9, $00, $10, $B5, $90, $18, $14, $98, $F0

Data_00D_414D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $11, $24, $2B, $98, $90, $12, $3F, $90, $31, $32, $37, $F1, $24
    db $33, $33, $35, $24, $2C, $36, $2C, $31, $2A, $90, $24, $31, $3C, $FA, $F7, $EF
    db $EE, $2E, $28, $3C, $90, $2C, $29, $90, $3C, $32, $38, $90, $27, $32, $31, $41
    db $EF, $EE, $33, $24, $3C, $90, $30, $3C, $90, $29, $28, $28, $B5, $F7, $F0

Data_00D_418C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $16, $24, $2A, $2C, $26, $90, $14
    db $28, $3C, $F1, $36, $2B, $32, $38, $2F, $27, $90, $12, $90, $24, $33, $33, $35
    db $24, $2C, $36, $28, $98, $F0

Data_00D_41B2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $90, $2E, $28, $3C, $3E, $90, $25, $28, $28
    db $31, $F1, $24, $33, $33, $35, $24, $2C, $36, $28, $27, $90, $24, $2F, $35, $28
    db $24, $27, $3C, $B5, $F7, $F0

Data_00D_41D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0341D8, $49

Data_00D_4221:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1C, $2B, $32, $38, $2F, $27, $90, $12, $90, $36, $24, $39, $28
    db $F1, $37, $2B, $28, $90, $35, $28, $36, $38, $2F, $37, $36, $98, $F0

Data_00D_423F:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03423F, $61

Data_00D_42A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0342A0, $42

Data_00D_42E2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $A4, $0B, $38, $37, $AB, $90, $12, $90, $26, $24, $31, $41, $F1
    db $37, $24, $2E, $28, $90, $37, $2B, $2C, $36, $90, $30, $24, $31, $3C, $B5, $F7
    db $F0

Data_00D_4303:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $2B, $24, $39, $28, $90, $F9, $00, $90, $32, $29, $F1
    db $3C, $32, $38, $35, $90, $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $36, $B5
    db $F7, $F0

Data_00D_4325:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $90, $2B, $32, $33, $28, $90, $3C, $32, $38, $43, $2F, $F1
    db $29, $2C, $31, $27, $90, $30, $24, $31, $3C, $90, $30, $28, $27, $24, $2F, $36
    db $99, $F7, $F0

Data_00D_4348:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $24, $31, $37, $90, $37, $32, $90, $37, $35, $24, $27, $28
    db $F1, $30, $28, $27, $24, $2F, $36, $90, $29, $32, $35, $90, $33, $35, $2C, $3D
    db $28, $36, $98, $F0

Data_00D_436C:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $20, $2B, $2C, $26, $2B, $90, $33, $35, $2C, $3D, $28, $90, $27
    db $32, $F1, $3C, $32, $38, $90, $3A, $24, $31, $37, $98, $F0

Data_00D_4388:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $37, $35, $24, $27, $28, $90, $29, $32, $35
    db $F1, $F9, $00, $90, $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $36, $B5, $90
    db $18, $14, $98, $F0

Data_00D_43AC:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $1D, $2B, $24, $37, $90, $35, $28, $34, $38, $2C, $35, $28, $36
    db $F1, $30, $32, $35, $28, $90, $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $36
    db $B5, $F7, $F0

Data_00D_43CF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $27, $32, $31, $41, $90, $2B, $24, $39, $28
    db $F1, $24, $31, $3C, $90, $35, $32, $32, $30, $90, $29, $32, $35, $90, $37, $2B
    db $24, $37, $B5, $F7, $F0

Data_00D_43F4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $35, $90, $2E, $28, $3C, $90, $35, $2C, $31, $2A
    db $90, $2C, $36, $F1, $24, $2F, $35, $28, $24, $27, $3C, $90, $29, $38, $2F, $2F
    db $B5, $F7, $F0

Data_00D_4417:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $2B, $24, $39, $28, $90, $31, $32, $90, $30
    db $32, $35, $28, $F1, $35, $32, $32, $30, $90, $29, $32, $35, $90, $30, $32, $31
    db $36, $37, $28, $35, $36, $B5, $F7, $F0

Data_00D_443F:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $0F, $2C, $31, $28, $AB, $90, $3A, $28, $90, $36, $2B, $24, $2F
    db $2F, $F1, $37, $35, $24, $27, $28, $B5, $F7, $F0

Data_00D_4459:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $12, $43, $2F, $90, $36, $28, $31, $27, $90, $37, $2B, $28, $90
    db $28, $2A, $2A, $F1, $37, $32, $90, $37, $2B, $28, $90, $29, $24, $35, $30, $B5
    db $F7, $F0

Data_00D_447B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $26, $24, $31, $41, $90, $37, $24, $2E, $28
    db $F1, $24, $31, $3C, $90, $30, $32, $35, $28, $90, $2C, $37, $28, $30, $36, $B5
    db $F7, $F0

Data_00D_449D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $26, $24, $31, $41, $90, $2B, $32, $2F, $27
    db $90, $24, $31, $3C, $F1, $30, $32, $35, $28, $90, $2E, $28, $3C, $36, $B5, $F7
    db $F0

Data_00D_44BE:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45, $90, $22, $32, $38, $90, $2B, $24, $39, $28, $90, $31, $32, $90, $30
    db $32, $35, $28, $F1, $35, $32, $32, $30, $90, $29, $32, $35, $90, $30, $32, $31
    db $36, $37, $28, $35, $36, $B5, $F7, $F0

Data_00D_44E6:: ; heuristic: target of a monotone pointer table; C0
    db $15, $28, $24, $27, $36, $90, $37, $32, $90, $24, $31, $32, $37, $2B, $28, $35
    db $F1, $3A, $32, $35, $2F, $27, $B5, $F0

Data_00D_44FE:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $24, $30, $28, $36, $90, $24, $90, $30, $32, $31, $36, $37, $28, $35, $90
    db $25, $3C, $F1, $24, $90, $2A, $35, $28, $24, $37, $90, $24, $30, $32, $38, $31
    db $37, $B5, $F0

Data_00D_4521:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $3E, $90, $28, $2A, $2A, $B5, $F0

Data_00D_452A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $03452A, $6F

Func_00D_4599:: ; heuristic: target of a pointer table; C0
    ld d, $28
    scf
    jr z, Jump_00D_45B6
    dec [hl]
    dec h
    db $F0

Func_00D_45A1:: ; heuristic: target of a pointer table; C0
    ld d, $24
    daa
    inc c
    inc h
    scf
    db $F0

Func_00D_45A8:: ; heuristic: target of a pointer table; C0
    ld de, $3532
    ld sp, $280B
    jr z, Jump_00D_45E7
    db $F0

Func_00D_45B1:: ; heuristic: target of a pointer table; C0
    inc e
    ld l, $3C
    dec c
    dec [hl]

Jump_00D_45B6::
    inc h
    ld a, [hl+]
    ld [hl-], a
    ld sp, $18F0
    ld h, $37
    ld [hl-], a
    ld a, [hl+]
    ld [hl-], a
    ld sp, $1CF0
    jr z, Jump_00D_45FB
    add hl, sp
    inc h
    ld sp, $F037
    dec c
    inc h
    dec [hl]
    ld h, $2E
    ldh a, [hFFFA]
    add a, b
    rst $10
    rst $00
    dw Jump_00D_45F6
    dw Jump_00D_4635
    dw Jump_00D_46B6
    dw Jump_00D_46C2
    dw Jump_00D_470F
    dw Jump_00D_4710
    dw Jump_00D_45F5
    dw Jump_00D_45F5
    dw Jump_00D_45F5

Jump_00D_45E7::
    push af
    ld b, l
    push af
    ld b, l
    push af
    ld b, l
    push af
    ld b, l
    ld b, c
    ld c, e
    push af
    ld b, l
    ld e, l
    ld c, e

Jump_00D_45F5::
    ret

Jump_00D_45F6::
    ld hl, wD780
    db $01, $6F

Jump_00D_45FB::
    nop
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    db $20

Func_00D_4602:: ; heuristic: target of a pointer table; C0
    ld sp, hl
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_4621
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_00D_4E84

Jump_00D_4621::
    ld a, $06
    ld [wD7F0], a
    xor a, a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_4635::
    ld a, [wD781]
    rst $00
    dw Func_00D_463F
    dw Jump_00D_4650
    dw Jump_00D_4692

Func_00D_463F::
    ld hl, Data_00D_4F81
    ld de, Data_00D_4F9F
    call Func_00D_4F3D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_4650::
    ld de, Data_00D_4FBD
    ld hl, wC370
    ld bc, $0803
    call Func_00D_4DCB
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Func_000_173A
    farcall Func_015_6676
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_00D_467F::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00D_467F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_4692::
    ld de, Data_00D_4FD5
    ld hl, wC364
    ld bc, $0B07
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140B
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_46B6::
    ld a, $01
    ld [wC89D], a
    farcall Func_015_6478
    ret

Jump_00D_46C2::
    ld a, [wD786]
    and a, a
    jr z, Jump_00D_46CA
    jr Jump_00D_46D0

Jump_00D_46CA::
    xor a, a
    ld [wD7BD], a
    jr Jump_00D_46D5

Jump_00D_46D0::
    ld a, $01
    ld [wD7BD], a

Jump_00D_46D5::
    farcall Func_01D_6026
    ld a, [wD7B9]
    and a, a
    jr z, Jump_00D_46FB
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_46FB::
    ld a, $01
    ld [wD7FA], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_470F::
    ret

Jump_00D_4710::
    ld a, [wD781]
    rst $00
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_4741
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_47F7
    dw Func_00D_473A
    dw Func_00D_473A
    dw Func_00D_4869
    dw Func_00D_491A
    dw Func_00D_4952
    db $88, $49

Func_00D_473A:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ret

Func_00D_4741:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_4766
    cp a, $FC
    jr z, Jump_00D_4766
    cp a, $FD
    jr z, Jump_00D_476F
    cp a, $FE
    jr z, Jump_00D_4770
    cp a, $FF
    jr z, Jump_00D_478A
    ret

Jump_00D_4766::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_00D_476F::
    ret

Jump_00D_4770::
    ld a, [wD781]
    inc a
    ld [wD781], a
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

Jump_00D_478A::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_5097
    call Func_00D_4E96
    ld a, [wD7BD]
    and a, a
    jr z, Jump_00D_47E0
    call Func_00D_4CF4
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    farcall Func_015_6676
    ld b, $04
    ld hl, wD7F4

Jump_00D_47C4::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_47CF
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, Jump_00D_47C4

Jump_00D_47CF::
    ld de, wC130

Jump_00D_47D2::
    ld a, b
    and a, a
    jr z, Jump_00D_47DD
    ld a, [hl]
    ld [de], a
    inc de
    inc hl
    dec b
    jr Jump_00D_47D2

Jump_00D_47DD::
    ld a, $F0
    ld [de], a

Jump_00D_47E0::
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

Func_00D_47F7:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wD7F5], a
    call Func_00D_4D24
    ld a, [wD7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_480C
    cp a, $FF
    jr z, Jump_00D_4822
    ret

Jump_00D_480C::
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

Jump_00D_4822::
    ld a, [wD7AD]
    and a, a
    jp nz, Jump_00D_4852
    ld a, $05
    ld [wD7B2], a
    ld a, $0C
    ld [wD7B3], a
    ld a, $0D
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

Jump_00D_4852::
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

Func_00D_4869:: ; heuristic: target of a pointer table; C0
    ld a, [wD7BD]
    and a, a
    jr nz, Jump_00D_4894
    ld a, $14
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    and a, a
    jr nz, Jump_00D_48AF
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

Jump_00D_4894::
    call Func_00D_4CF4
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    and a, a
    jr z, Jump_00D_48C5

Jump_00D_48AF::
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

Jump_00D_48C5::
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
    ld c, $0E
    call SRAMRecordAddress
    ld a, [hl]
    and a, a
    jr z, Jump_00D_48E9
    xor a, a
    jr Jump_00D_48EB

Jump_00D_48E9::
    ld a, $01

Jump_00D_48EB::
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    call Func_00D_4CF4
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_015_683C
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

Func_00D_491A:: ; heuristic: target of a pointer table; C0
    ld de, Data_00D_5022
    ld hl, wC3BB
    ld bc, $0D09
    call Func_00D_4DCB
    farcall Func_01E_71E1
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_494A
    ld hl, wC462
    call Func_00D_4EC7
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_00D_494A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_4952:: ; heuristic: target of a pointer table; C0
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wD7F1], a
    ld [wD7F2], a
    farcall Func_01D_6320
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $07
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret
    db $FA, $82, $D7, $C7
    dw Func_00D_499A
    dw Func_00D_49A2
    dw Func_00D_4A03
    dw Func_00D_4A3F
    dw Func_00D_4A69
    dw Func_00D_4ABF
    dw Func_00D_4ACF

Func_00D_499A:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wD7FA], a
    call Func_00D_4B30
    ret

Func_00D_49A2:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld c, $00
    ld de, $0000

Jump_00D_49AA::
    push hl
    push bc
    push de
    ld a, c
    ld de, Data_00D_49FD
    add a, e
    ld e, a
    jr nc, Jump_00D_49B6
    inc d

Jump_00D_49B6::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    pop de
    ldh a, [hFFC6]
    add a, e
    ld e, a
    ldh a, [hFFC7]
    adc a, d
    ld d, a
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_00D_49AA
    ld l, e
    ld h, d
    ld a, $06
    call DivideHLByA
    ld a, h
    and a, a
    jr z, Jump_00D_49DC

Jump_00D_49D8::
    ld a, $03
    jr Jump_00D_49F2

Jump_00D_49DC::
    ld a, l
    cp a, $C9
    jr nc, Jump_00D_49D8
    cp a, $65
    jr nc, Jump_00D_49EC
    cp a, $33
    jr nc, Jump_00D_49F0
    xor a, a
    jr Jump_00D_49F2

Jump_00D_49EC::
    ld a, $02
    jr Jump_00D_49F2

Jump_00D_49F0::
    ld a, $01

Jump_00D_49F2::
    ld [wD7FA], a
    xor a, a
    ld [rRAMG2], a
    call Func_00D_4B30
    ret

Data_00D_49FD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $61, $63, $65, $67, $69

Func_00D_4A03:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld a, [hl]
    ld c, $3C
    call SRAMRecordAddress
    ld c, $00
    ld b, $00

Jump_00D_4A10::
    ld a, [hl+]
    and a, a
    jr z, Jump_00D_4A19
    cp a, $FF
    jr z, Jump_00D_4A19
    inc b

Jump_00D_4A19::
    inc c
    ld a, c
    cp a, $19
    jr c, Jump_00D_4A10
    ld a, b
    cp a, $06
    jr c, Jump_00D_4A31
    cp a, $0B
    jr c, Jump_00D_4A35
    cp a, $10
    jr c, Jump_00D_4A3A
    ld a, $03
    jp Jump_00D_49F2

Jump_00D_4A31::
    xor a, a
    jp Jump_00D_49F2

Jump_00D_4A35::
    ld a, $01
    jp Jump_00D_49F2

Jump_00D_4A3A::
    ld a, $02
    jp Jump_00D_49F2

Func_00D_4A3F:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld a, [hl]
    ld c, $57
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $29
    jr c, Jump_00D_4A5B
    cp a, $3D
    jr c, Jump_00D_4A5F
    cp a, $51
    jr c, Jump_00D_4A64
    ld a, $03
    jp Jump_00D_49F2

Jump_00D_4A5B::
    xor a, a
    jp Jump_00D_49F2

Jump_00D_4A5F::
    ld a, $01
    jp Jump_00D_49F2

Jump_00D_4A64::
    ld a, $02
    jp Jump_00D_49F2

Func_00D_4A69:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld b, $00
    push hl
    push bc
    ld a, [hl]
    ld c, $6F
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld e, a
    pop bc
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, $72
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, e
    jr c, Jump_00D_4A96
    jr nz, Jump_00D_4A8D
    jr Jump_00D_4A96

Jump_00D_4A8D::
    pop bc
    pop de
    ldh a, [hFFC6]
    ld e, a
    ld b, $01
    push de
    push bc

Jump_00D_4A96::
    pop bc
    pop de
    pop hl
    push hl
    push de
    push bc
    ld a, [hl]
    ld c, $70
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, e
    jr c, Jump_00D_4AB8
    jr nz, Jump_00D_4AAB
    jr Jump_00D_4AB8

Jump_00D_4AAB::
    pop bc
    pop de
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld b, $02
    pop hl
    jr Jump_00D_4ABB

Jump_00D_4AB8::
    pop bc
    pop de
    pop hl

Jump_00D_4ABB::
    ld a, b
    jp Jump_00D_49F2

Func_00D_4ABF:: ; heuristic: target of a pointer table; C0
    call Func_00D_4B18
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    jp Jump_00D_49F2

Func_00D_4ACF:: ; heuristic: target of a pointer table; C0
    ld a, $14
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    farcall Func_015_683C
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
    ld a, $02
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wD782], a
    ld a, $10
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_4B18::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ret

Func_00D_4B30::
    ld a, [wD782]
    inc a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_4B41:: ; heuristic: follows a terminator; C0
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
    db $FA, $81, $D7, $C7
    dw Func_00D_4B73
    dw Func_00D_4B98
    dw Func_00D_4BA5
    dw Func_00D_4BDE
    dw Func_00D_4BE1
    dw Func_00D_4BF4
    dw Func_00D_4C17
    dw Func_00D_4C36
    dw Func_00D_4C9C

Func_00D_4B73:: ; heuristic: target of a pointer table; C0
    ld hl, vTiles2
    ld de, Data_049_4418
    ld b, $49
    call DecompressToVRAM
    ld hl, wC49F
    ld de, Data_049_46DC
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_4B98:: ; heuristic: target of a pointer table; C0
    ld hl, Data_00D_509F
    ld de, Data_00D_50AF
    call Func_00D_4F3D
    call Func_00D_463F
    ret

Func_00D_4BA5:: ; heuristic: target of a pointer table; C0
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

Func_00D_4BDE:: ; heuristic: target of a pointer table; C0
    call Func_00D_491A

Func_00D_4BE1:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7F5], a
    farcall Func_01D_6088
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_4BF4:: ; heuristic: target of a pointer table; C0
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

Func_00D_4C17:: ; heuristic: target of a pointer table; C0
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_5097
    call Func_00D_4E96
    ld de, Data_00D_50BD
    ld hl, wC410
    ld bc, $0805
    call Func_00D_4DCB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_4C36:: ; heuristic: target of a pointer table; C0
    ld a, [wD7BD]
    and a, a
    jr z, Jump_00D_4C78
    call Func_00D_4CF4
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    farcall Func_015_6676
    ld b, $04
    ld hl, wD7F4

Jump_00D_4C59::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_4C64
    dec b
    inc hl
    ld a, b
    and a, a
    jr nz, Jump_00D_4C59

Jump_00D_4C64::
    ld de, wC130

Jump_00D_4C67::
    ld a, b
    and a, a
    jr z, Jump_00D_4C71
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr Jump_00D_4C67

Jump_00D_4C71::
    ld a, $F0
    ld [de], a
    ld a, $08
    jr Jump_00D_4C7A

Jump_00D_4C78::
    ld a, $03

Jump_00D_4C7A::
    ld [wC529], a
    xor a, a
    ld [wC528], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    farcall Func_0F2_43DE
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_4C9C:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    call Func_00D_4E5A
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00D_4E05
    farcall Func_01E_7763
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

Func_00D_4CF4::
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
    ldh a, [hFFC6]
    ld c, $14
    call Multiply8
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_00D_4D23
    inc h

Jump_00D_4D23::
    ret

Func_00D_4D24::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_00D_4D44
    bit 7, a
    jr nz, Jump_00D_4D62
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_00D_4D72
    bit 1, a
    jp nz, Jump_00D_4D80
    call Func_00D_4D86
    xor a, a
    ld [wD7F5], a
    ret

Jump_00D_4D44::
    call Func_00D_4DA4
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_00D_4D51
    ld a, $01
    jr Jump_00D_4D52

Jump_00D_4D51::
    dec a

Jump_00D_4D52::
    ld [wD7AD], a
    ld a, $69
    call StoreWC60B
    call Func_00D_4DA0
    xor a, a
    ld [wD7F5], a
    ret

Jump_00D_4D62::
    call Func_00D_4DA4
    ld a, [wD7AD]
    cp a, $01
    jr c, Jump_00D_4D6F
    xor a, a
    jr Jump_00D_4D52

Jump_00D_4D6F::
    inc a
    jr Jump_00D_4D52

Jump_00D_4D72::
    ld a, $69
    call StoreWC60B
    call Func_00D_4DA8
    ld a, $FF
    ld [wD7F5], a
    ret

Jump_00D_4D80::
    ld a, $FE
    ld [wD7F5], a
    ret

Func_00D_4D86::
    ld a, [wC564]
    cp a, $14
    jr c, Func_00D_4DA0
    ld a, [wD7AE]
    inc a
    ld [wD7AE], a
    cp a, $10
    jr c, Func_00D_4DA0
    cp a, $18
    jr c, Func_00D_4DA4
    xor a, a
    ld [wD7AE], a

Func_00D_4DA0::
    ld b, $BB
    jr Jump_00D_4DAA

Func_00D_4DA4::
    ld b, $C3
    jr Jump_00D_4DAA

Func_00D_4DA8::
    ld b, $BC

Jump_00D_4DAA::
    ld a, [wD7AD]
    add a, a
    ld hl, Func_00D_4DC7
    add a, l
    ld l, a
    jr nc, Jump_00D_4DB6
    inc h

Jump_00D_4DB6::
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call Func_00D_4E5A
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Func_00D_4DC7:: ; heuristic: follows a terminator; C0
    dec l
    ld bc, $016D

Func_00D_4DCB::
    push hl
    push bc

Jump_00D_4DCD::
    push bc
    push hl

Jump_00D_4DCF::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00D_4DCF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00D_4DCD
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

Jump_00D_4DF1::
    push bc
    push hl

Jump_00D_4DF3::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_4DF3
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_00D_4DF1
    xor a, a
    ldh [rSVBK], a
    ret

Func_00D_4E05:: ; heuristic: follows a terminator; C0
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
    add a, $C1
    ld [wC554], a
    ld a, h
    adc a, $01
    ld [wC555], a
    ld a, [wC554]
    cp a, $61
    jr nz, Jump_00D_4E39
    ld a, [wC555]
    cp a, $9B
    jr nz, Jump_00D_4E39
    ld a, $C1
    ld [wC554], a
    ld a, $99
    ld [wC555], a

Jump_00D_4E39::
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

Func_00D_4E5A::
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
    jr nc, Jump_00D_4E7A
    inc h

Jump_00D_4E7A::
    ret

Func_00D_4E7B:: ; heuristic: follows a terminator; C0
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Func_00D_4E7B
    ret

Func_00D_4E84:: ; heuristic: follows a terminator; C0
    ld a, $02
    ldh [rSVBK], a

Jump_00D_4E88::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_4E88
    xor a, a
    ldh [rSVBK], a
    ret

Func_00D_4E96:: ; heuristic: follows a terminator; C0
    push bc
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00D_4E9D
    inc h

Jump_00D_4E9D::
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

Func_00D_4EA4:: ; heuristic: follows a terminator; C0
    push de
    call Func_00D_4E5A
    pop de
    add hl, de
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

Func_00D_4EC7:: ; heuristic: follows a terminator; C0
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

Func_00D_4ED5:: ; heuristic: follows a terminator; C0
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
    call Func_00D_4E7B
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_4F16
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
    call Func_00D_4E84
    pop de
    pop hl

Jump_00D_4F16::
    pop bc
    ld a, $14
    add a, l
    ld l, a
    jr nc, Jump_00D_4F1E
    inc h

Jump_00D_4F1E::
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_00D_4F25
    inc d

Jump_00D_4F25::
    dec c
    jr nz, Func_00D_4ED5
    ret

Func_00D_4F29::
    ld a, c
    ld b, a
    ld c, $00

Jump_00D_4F2D::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call Func_00D_4E96
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_4F2D
    ret

Func_00D_4F3D::
    push hl
    push de
    ld a, [wD785]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00D_4F48
    inc h

Jump_00D_4F48::
    ld a, [hl]
    cp a, $FF
    jp z, Jump_00D_4F77
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
    jr nc, Jump_00D_4F5E
    inc d

Jump_00D_4F5E::
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
    jr Func_00D_4F3D

Jump_00D_4F77::
    pop de
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

Data_00D_4F81:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A
    db $C0, $8A, $D0, $8A, $E0, $8A, $F0, $8A, $E0, $8E, $F0, $8E, $FF, $FF

Data_00D_4F9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F0, $40, $A0, $43, $50, $42, $00, $43, $90, $43, $80, $43, $90, $42, $C0, $40
    db $70, $43, $C0, $43, $D0, $42, $10, $49, $10, $49, $10, $49, $FF, $FF

Data_00D_4FBD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_4FD5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $034FD5, $4D

Data_00D_5022:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035022, $75

Data_00D_5097:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $C3, $F8, $C3, $20, $C4, $48, $C4

Data_00D_509F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_00D_50AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_00D_50BD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $70, $71, $72, $73, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $74, $75, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Func_00D_50E5::
    ld a, [wD788]
    rst $00
    dw Func_00D_50F1
    dw Func_00D_50F8
    dw Func_00D_50F1
    dw Func_00D_50F1

Func_00D_50F1:: ; heuristic: target of a pointer table; C0
    farcall Func_015_4001
    ret

Func_00D_50F8:: ; heuristic: target of a pointer table; C0
    call Func_000_222B
    ld de, Data_01F_4910
    ld hl, vTiles1 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4910
    ld hl, vTiles1 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4910
    ld hl, vTiles1 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld [wD780], a
    ld [wD781], a
    ld [wC46B], a
    ld a, [wD788]
    inc a
    ld [wD788], a
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

Func_00D_5159::
    ld a, [wD780]
    rst $00
    dw Jump_00D_516B
    dw Jump_00D_5172
    dw Jump_00D_51E2
    dw Jump_00D_5221
    dw Jump_00D_52A7
    dw Jump_00D_52AB
    dw Jump_00D_530F

Jump_00D_516B::
    ld hl, $45D1
    ld b, $0D
    rst $10
    ret

Jump_00D_5172::
    ld a, [wD781]
    rst $00
    dw Func_00D_517A
    dw Jump_00D_51B6

Func_00D_517A::
    ld de, Data_01F_4210
    ld hl, vTiles1 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4120
    ld hl, vTiles1 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4190
    ld hl, vTiles1 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles1 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_51B6::
    ld de, Data_00D_550A
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_51E2::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_51F6
    cp a, $FF
    jr z, Jump_00D_5205
    ret

Jump_00D_51F6::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5205::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_51F6
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5221::
    ld a, [wD781]
    rst $00
    dw Jump_00D_522B
    dw Func_00D_525F
    dw Jump_00D_5280

Jump_00D_522B::
    ld de, Data_00D_552E
    ld hl, wC364
    ld bc, $0809
    call Func_00D_4DCB
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00D_4ED5
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_525F::
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_5280::
    call Func_000_222B
    ld de, Data_00D_5576
    ld hl, wC364
    ld bc, $0809
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_52A7::
    call Func_00D_5412
    ret

Jump_00D_52AB::
    ld a, [wD786]
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_00D_52B6
    inc h

Jump_00D_52B6::
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
    ld a, $03
    ld [wD7F1], a
    ld [rRAMG2], a
    farcall Func_014_5CA8
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_530F::
    ld a, [wD781]
    rst $00
    dw Func_00D_531D
    dw Func_00D_5342
    dw Func_00D_534E
    dw Func_00D_53A4
    dw Func_00D_53BB

Func_00D_531D:: ; heuristic: target of a pointer table; C0
    ld hl, vTiles2
    ld de, Data_049_4832
    ld b, $49
    call DecompressToVRAM
    ld hl, wC49F
    ld de, Data_049_4AC5
    ld b, $49
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_5342:: ; heuristic: target of a pointer table; C0
    call Func_00D_517A
    call Func_00D_525F
    ld a, $02
    ld [wD781], a
    ret

Func_00D_534E:: ; heuristic: target of a pointer table; C0
    ld a, [wD786]
    ld hl, wC6FE
    add a, l
    ld l, a
    jr nc, Jump_00D_5359
    inc h

Jump_00D_5359::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call SRAMRecordAddress
    ld de, wC8CF
    ld c, $00

Jump_00D_536D::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_537C
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_00D_536D
    jr Jump_00D_537F

Jump_00D_537C::
    ld a, $F0
    ld [hl], a

Jump_00D_537F::
    xor a, a
    ld [rRAMG2], a
    call Func_000_222B
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
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_53A4:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wC528], a
    ld a, $23
    ld [wC529], a
    farcall Func_0F2_43DE
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_53BB:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    call Func_00D_4E5A
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00D_4E05
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wD782], a
    ld [wD781], a
    ld a, $04
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

Func_00D_5412::
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_00D_542E
    bit 7, a
    jr nz, Jump_00D_5460
    ld a, [wC562]
    bit 0, a
    jp nz, Jump_00D_5479
    bit 1, a
    jp nz, Jump_00D_54A6
    call Func_00D_54C1
    ret

Jump_00D_542E::
    call Func_00D_54DF
    ld a, [wC6FD]
    cp a, $02
    jr c, Jump_00D_543E
    ld a, [wD786]
    and a, a
    jr nz, Jump_00D_5449

Jump_00D_543E::
    ld a, [wC6FD]
    dec a
    ld [wD786], a
    call Func_00D_54C1
    ret

Jump_00D_5449::
    dec a

Jump_00D_544A::
    ld [wD786], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    call Func_00D_54DB
    ld a, $69
    call StoreWC60B
    ret

Jump_00D_5460::
    call Func_00D_54DF
    ld a, [wC6FD]
    dec a
    ld b, a
    ld a, [wD786]
    cp a, b
    jr c, Jump_00D_5476
    xor a, a
    ld [wD786], a
    call Func_00D_54C1
    ret

Jump_00D_5476::
    inc a
    jr Jump_00D_544A

Jump_00D_5479::
    ld a, $69
    call StoreWC60B
    call Func_00D_54E3
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    ld [wCFA8], a
    ld [wCFA9], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_54A6::
    ld a, $01
    ld [wD7FA], a
    ld [wD780], a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_54C1::
    ld a, [wC564]
    cp a, $14
    jr c, Func_00D_54DB
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, Func_00D_54DB
    cp a, $18
    jr c, Func_00D_54DF
    xor a, a
    ld [wD787], a

Func_00D_54DB::
    ld b, $BB
    jr Jump_00D_54E5

Func_00D_54DF::
    ld b, $C3
    jr Jump_00D_54E5

Func_00D_54E3::
    ld b, $BC

Jump_00D_54E5::
    ld a, [wD786]
    sla a
    ld hl, Data_00D_5504
    add a, l
    ld l, a
    jr nc, Jump_00D_54F2
    inc h

Jump_00D_54F2::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call Func_00D_4E5A
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00D_5504:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $00, $A1, $00, $E1, $00

Data_00D_550A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $A5, $F3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5, $A1, $C3
    db $C9, $C3, $F1, $C3

Data_00D_552E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03552E, $48

Data_00D_5576:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035576, $48

Func_00D_55BE::
    ld a, [wD780]
    rst $00
    dw Jump_00D_55CA
    dw Jump_00D_5633
    dw Jump_00D_56A9
    dw Jump_00D_5722

Jump_00D_55CA::
    ld hl, wD780
    ld bc, $006F

Jump_00D_55D0::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_55D0
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_55F5
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_00D_4E84

Jump_00D_55F5::
    ld a, $07
    ld [wD7F0], a
    ld a, $70
    ldh [hFFBA], a
    ld de, Data_01F_4AD0
    ld hl, vTiles1 + $4A0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5633::
    ld a, [wD781]
    rst $00
    dw Jump_00D_563B
    dw Jump_00D_567D

Jump_00D_563B::
    ld de, Data_00D_4FBD
    ld hl, wC370
    ld bc, $0803
    call Func_00D_4DCB
    ld a, [wC617]
    ld [wC8C0], a
    ld a, [wC618]
    ld [wC8C1], a
    ld a, [wC619]
    ld [wC8C2], a
    call Func_000_173A
    farcall Func_015_6676
    ld hl, wC386
    ld de, wD7F3
    ld c, $00

Jump_00D_566A::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_00D_566A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_567D::
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_56A9::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_56BD
    cp a, $FF
    jr z, Jump_00D_56CC
    ret

Jump_00D_56BD::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_56CC::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_56BD
    call Func_00D_5702
    cp a, $FF
    jr nz, Jump_00D_56E9
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_56E9::
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_5702::
    ld c, $00

Jump_00D_5704::
    ld a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_00D_5720
    inc c
    ld a, c
    cp a, $20
    jr c, Jump_00D_5704
    ld a, $FF
    ret

Jump_00D_5720::
    xor a, a
    ret

Jump_00D_5722::
    ld a, [wD781]
    rst $00
    dw Jump_00D_5766
    dw Jump_00D_5789
    dw Func_00D_57F5
    dw Func_00D_585C
    dw Func_00D_5872
    dw Func_00D_5891
    dw Func_00D_5AB4
    dw Func_00D_595C
    dw Func_00D_5AE3
    dw Func_00D_5A3C
    dw Func_00D_5A4A
    dw Func_00D_5A5C
    dw Func_00D_5AB4
    dw Func_00D_5B06
    dw Func_00D_5B4A
    dw Func_00D_5BBF
    dw Func_00D_5BDF
    dw Func_00D_5C17
    dw Func_00D_574C

Func_00D_574C:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5766::
    ld de, Data_00D_61A7
    ld hl, wC3B8
    ld bc, $1009
    call Func_00D_4DCB
    call Func_00D_60C3
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_5789::
    ld hl, vTiles2 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0601
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_57F5:: ; heuristic: target of a pointer table; C0
    ld de, Data_00D_6237
    ld hl, wC3CE
    ld bc, $0D07
    db $CD, $CB

Func_00D_5800:: ; heuristic: target of a pointer table; C0
    ld c, l
    xor a, a
    ld [wD7F5], a
    call Func_00D_5C87
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_583D
    ld de, $018E
    call Func_00D_4EA4
    ld hl, wC462
    call Func_00D_4EC7
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

Jump_00D_583D::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_00D_62B0
    call Func_00D_4E96
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_585C:: ; heuristic: target of a pointer table; C0
    xor a, a
    ld [wD7F5], a
    call Func_00D_5DED
    xor a, a
    ld [wD7F5], a
    call Func_00D_5D26
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_5872:: ; heuristic: target of a pointer table; C0
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_00D_62B0
    call Func_00D_4E96
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_5891:: ; heuristic: target of a pointer table; C0
    ld a, [wC563]
    bit 2, a
    jr nz, Jump_00D_58B9
    ld a, $03
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_58C0
    cp a, $FC
    jr z, Jump_00D_58C0
    cp a, $FE
    jr z, Jump_00D_58C9
    cp a, $FF
    jr z, Jump_00D_58D8
    ret

Jump_00D_58B9::
    farcall Func_0F2_633B
    ret

Jump_00D_58C0::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_00D_58C9::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_58D8::
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00D_591E
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
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_591E::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_62B0
    call Func_00D_4E96
    ld de, wC130
    ld a, $01
    call Func_00D_6120
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
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

Func_00D_595C:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_5970
    cp a, $FF
    jr z, Jump_00D_599F
    ret

Jump_00D_5970::
    call Func_00D_5A05
    ld a, $02
    ld [wD7FA], a
    ld a, [wD781]
    inc a
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

Jump_00D_599F::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_5970
    xor a, a
    call Func_00D_6120
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_01C_440F
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_00D_59D2
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_59D2::
    call Func_00D_5A05
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
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

Func_00D_5A05::
    ld de, Data_00D_6292
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_5A2F
    ld hl, wC462
    call Func_00D_4EC7
    ld hl, wC463
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall Func_01E_759A

Jump_00D_5A2F::
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

Func_00D_5A3C:: ; heuristic: target of a pointer table; C0
    farcall Func_015_645F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_5A4A:: ; heuristic: target of a pointer table; C0
    farcall Func_015_6B00
    xor a, a
    ld [wC528], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_5A5C:: ; heuristic: target of a pointer table; C0
    call Func_00D_615E
    ld a, [wD782]
    cp a, $02
    jr z, Jump_00D_5A87
    cp a, $03
    jr z, Jump_00D_5A9A
    farcall Func_015_642D
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

Jump_00D_5A87::
    ld a, $0B
    ld [wC529], a
    farcall Func_00D_4001
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_00D_5A9A::
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

Func_00D_5AB4:: ; heuristic: target of a pointer table; C0
    call Func_00D_615E
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_5AE3:: ; heuristic: target of a pointer table; C0
    ld c, $04
    ld hl, Data_00D_62B0
    call Func_00D_4F29
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $05
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_5B06:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    cp a, $FE
    jr z, Jump_00D_5B1B
    cp a, $FF
    jr z, Jump_00D_5B27
    call Func_00D_615E
    ret

Jump_00D_5B1B::
    call Func_00D_5C47
    ld a, [wD781]
    add a, $05
    ld [wD781], a
    ret

Jump_00D_5B27::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_5B1B
    call Func_00D_615E
    xor a, a
    ld [wD7FA], a
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

Func_00D_5B4A:: ; heuristic: target of a pointer table; C0
    call Func_00D_615E
    ld a, [wD782]
    and a, a
    jr z, Jump_00D_5B7C
    farcall Func_002_7347
    ld a, [wC8C3]
    bit 7, a
    ret z
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $01
    ld [wC968], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5B7C::
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    xor a, a
    ld [hl], a
    xor a, a
    call Func_00D_6120
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    farcall Func_015_683C
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Func_00D_5BBF:: ; heuristic: target of a pointer table; C0
    call Func_00D_5C47
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld de, wC130
    call Func_000_2458
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_5BDF:: ; heuristic: target of a pointer table; C0
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call Func_00D_4ED5
    db $CD, $3B

Func_00D_5C00:: ; heuristic: target of a pointer table; C0
    ld d, [hl]
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_5C17:: ; heuristic: target of a pointer table; C0
    call Func_00D_5C60
    cp a, $FF
    jr nz, Jump_00D_5C38
    xor a, a
    ld [wD7FA], a
    ld a, $03
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_5C38::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_5C47::
    ld a, $C3
    ld hl, wC3B0
    ld [hl+], a
    ld [hl], a
    ld hl, wC3C4
    ld [hl+], a
    ld [hl], a
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

Func_00D_5C60::
    ld hl, wC707
    ld c, $00
    ld b, $00

Jump_00D_5C67::
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_00D_5C83
    cp a, $FF
    jr z, Jump_00D_5C72
    inc b

Jump_00D_5C72::
    pop hl
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $20
    jr c, Jump_00D_5C67
    xor a, a
    ret

Jump_00D_5C83::
    pop hl
    ld a, $FF
    ret

Func_00D_5C87::
    ld a, [wD7A9]
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_00D_5C97
    inc l

Jump_00D_5C97::
    ld a, l
    ld [wD7B0], a
    ld a, [wD7AF]
    inc a
    cp a, l
    jr c, Jump_00D_5CD2
    pop af
    push af
    and a, a
    jr nz, Jump_00D_5CB7
    ld a, [wD7AF]
    inc a
    cp a, l
    jr z, Jump_00D_5CD2
    ld a, [wD7AF]
    dec a
    ld [wD7AF], a
    jr Jump_00D_5CD2

Jump_00D_5CB7::
    pop af
    dec a
    ld [wD7B1], a
    ld b, a
    ld a, [wD7AB]
    cp a, b
    jr c, Jump_00D_5CD8
    jr z, Jump_00D_5CD8
    push bc
    push hl
    call Func_00D_5CD9
    pop hl
    pop bc
    ld a, b
    ld [wD7AB], a
    jr Jump_00D_5CD8

Jump_00D_5CD2::
    pop af
    ld a, $03
    ld [wD7B1], a

Jump_00D_5CD8::
    ret

Func_00D_5CD9::
    ld b, $C3
    ld a, [wD7F5]
    and a, a
    jr z, Jump_00D_5CEF
    cp a, $01
    jr z, Jump_00D_5CEA
    ld hl, Data_00D_5D1E
    jr Jump_00D_5CF2

Jump_00D_5CEA::
    ld hl, Data_00D_5D16
    jr Jump_00D_5CF2

Jump_00D_5CEF::
    ld hl, Data_00D_5D0E

Jump_00D_5CF2::
    ld a, [wD7AB]
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00D_5CFC
    inc h

Jump_00D_5CFC::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call Func_00D_4E5A
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00D_5D0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A6, $00, $C6, $00, $E6, $00, $06, $01

Data_00D_5D16:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A4, $00, $C4, $00, $E4, $00, $04, $01

Data_00D_5D1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $C2, $00, $E2, $00, $02, $01

Func_00D_5D26::
    ld a, [wD7F5]
    and a, a
    jr nz, Jump_00D_5D31
    ld de, Data_00D_5DDD
    jr Jump_00D_5D34

Jump_00D_5D31::
    ld de, Data_00D_5DE5

Jump_00D_5D34::
    ld b, $04

Jump_00D_5D36::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, $C3
    ld [hl], a
    inc de
    dec b
    jr nz, Jump_00D_5D36
    ld hl, wD789
    ld a, [wD7AF]
    sla a
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00D_5D51
    inc h

Jump_00D_5D51::
    ld a, [hl]
    ld c, $00

Jump_00D_5D54::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_00D_5D60
    ld a, [wD7A9]
    jr Jump_00D_5D6F

Jump_00D_5D60::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_00D_5D6C
    ld a, [wD7A9]
    jr Jump_00D_5D6F

Jump_00D_5D6C::
    ld a, [wD7A9]

Jump_00D_5D6F::
    ld b, a
    ld a, [wD7AF]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_5DDC
    push hl
    push bc
    ld a, [hl]
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    ld de, wC707
    add hl, de
    ld e, l
    ld d, h
    ld a, [de]
    cp a, $FE
    jr z, Jump_00D_5DCC
    cp a, $FF
    jr z, Jump_00D_5DCC
    bit 6, a
    jr z, Jump_00D_5DA1
    ld b, $CA
    jr Jump_00D_5DA3

Jump_00D_5DA1::
    ld b, $C3

Jump_00D_5DA3::
    ld a, [wD7F5]
    and a, a
    jr nz, Jump_00D_5DAE
    ld de, Data_00D_5DDD
    jr Jump_00D_5DB8

Jump_00D_5DAE::
    ld de, Data_00D_5DE5
    ld a, b
    cp a, $C3
    jr z, Jump_00D_5DB8
    ld b, $70

Jump_00D_5DB8::
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_5DC0
    inc d

Jump_00D_5DC0::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei

Jump_00D_5DCC::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_00D_5DDC
    ld a, c
    cp a, $04
    jp c, Jump_00D_5D54

Jump_00D_5DDC::
    ret

Data_00D_5DDD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CD, $C3, $F5, $C3, $1D, $C4, $45, $C4

Data_00D_5DE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C9, $C3, $F1, $C3, $19, $C4, $41, $C4

Func_00D_5DED::
    ld hl, wD789
    ld a, [wD7AF]
    sla a
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00D_5DFC
    inc h

Jump_00D_5DFC::
    ld c, $00

Jump_00D_5DFE::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_00D_5E0A
    ld a, [wD7A9]
    jr Jump_00D_5E19

Jump_00D_5E0A::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_00D_5E16
    ld a, [wD7A9]
    jr Jump_00D_5E19

Jump_00D_5E16::
    ld a, [wD7A9]

Jump_00D_5E19::
    ld b, a
    ld a, [wD7AF]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_5ED5
    push hl
    push bc
    ld a, [hl]
    sla a
    sla a
    ld de, wC707
    add a, e
    ld e, a
    jr nc, Jump_00D_5E35
    inc d

Jump_00D_5E35::
    ld a, [de]
    cp a, $FE
    jr nz, Jump_00D_5E60
    ld hl, wC8CF
    ld a, $16
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $2A
    ld [hl+], a
    ld a, $2C
    ld [hl+], a
    ld a, $26
    ld [hl+], a
    ld a, $90
    ld [hl+], a
    ld a, $14
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $3C
    ld [hl+], a
    ld a, $5B
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    jr Jump_00D_5EC0

Jump_00D_5E60::
    inc de
    inc de
    inc de
    ld a, [de]
    bit 7, a
    jr z, Jump_00D_5EB2
    dec de
    dec de
    dec de
    ld a, [de]
    and a, $3F
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, Data_009_4016
    ld a, $0C
    add a, l
    ld l, a
    jr nc, Jump_00D_5E85
    inc h

Jump_00D_5E85::
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
    ld b, $09
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $F0
    ld [wC8DC], a
    jr Jump_00D_5EC0

Jump_00D_5EB2::
    ld a, [hl]
    ld de, wC8CF
    call Func_000_2458
    ld a, $5B
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a

Jump_00D_5EC0::
    pop bc
    push bc
    call Func_00D_5ED6
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_00D_5ED5
    ld a, c
    cp a, $04
    jp c, Jump_00D_5DFE

Jump_00D_5ED5::
    ret

Func_00D_5ED6::
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wC8CF

Jump_00D_5EE0::
    ld a, [wD784]
    push hl
    add a, l
    ld l, a
    jr nc, Jump_00D_5EE9
    inc h

Jump_00D_5EE9::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_00D_5F23
    cp a, $8D
    jr z, Jump_00D_5F01
    cp a, $8E
    jr z, Jump_00D_5F01
    push bc
    call Func_00D_5F2C
    call CopyFromBankWaitVRAM
    pop bc
    jr Jump_00D_5F12

Jump_00D_5F01::
    push af
    ld a, [wD785]
    dec a
    ld [wD785], a
    pop af
    push bc
    call Func_00D_5F2C
    call OrFromBankWaitVRAM
    pop bc

Jump_00D_5F12::
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    jr Jump_00D_5EE0

Jump_00D_5F23::
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

Func_00D_5F2C::
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
    ld a, [wD7F5]
    and a, a
    jr z, Jump_00D_5F63
    cp a, $01
    jr z, Jump_00D_5F5E
    cp a, $02
    jr z, Jump_00D_5F59
    ld de, Data_00D_60A9
    jr Jump_00D_5F66

Jump_00D_5F59::
    ld de, Data_00D_6041
    jr Jump_00D_5F66

Jump_00D_5F5E::
    ld de, Data_00D_5FF1
    jr Jump_00D_5F66

Jump_00D_5F63::
    ld de, Data_00D_5F89

Jump_00D_5F66::
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_5F6E
    inc d

Jump_00D_5F6E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD785]
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00D_5F7D
    inc h

Jump_00D_5F7D::
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

Data_00D_5F89:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035F89, $68

Data_00D_5FF1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $035FF1, $50

Data_00D_6041:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $036041, $68

Data_00D_60A9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AB, $60, $00, $96, $10, $96, $20, $96, $30, $96, $40, $96, $50, $96, $60, $96
    db $70, $96, $80, $96, $90, $96, $A0, $96, $B0, $96

Func_00D_60C3::
    ld hl, wD789
    ld b, $20

Jump_00D_60C8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_60C8
    xor a, a
    ld [wD7A9], a
    ld de, wC707
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_00D_60DB::
    ld a, [de]
    cp a, $FF
    jr z, Jump_00D_60E3
    inc c
    ld a, b
    ld [hl+], a

Jump_00D_60E3::
    ld a, $04
    add a, e
    ld e, a
    jr nc, Jump_00D_60EA
    inc d

Jump_00D_60EA::
    inc b
    ld a, b
    cp a, $20
    jr c, Jump_00D_60DB
    ld a, c
    ld [wD7A9], a
    ret

Func_00D_60F5:: ; heuristic: follows a terminator; C0
    ld hl, wD789
    ld a, [wD7AF]
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00D_6102
    inc h

Jump_00D_6102::
    ld a, [wD7AB]
    add a, l
    ld l, a
    jr nc, Jump_00D_610A
    inc h

Jump_00D_610A::
    ld a, [hl]
    ld hl, wC707
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_00D_6115
    inc h

Jump_00D_6115::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld c, $0A
    call Multiply8
    ret

Func_00D_6120:: ; heuristic: follows a terminator; C0
    and a, a
    jr nz, Jump_00D_6127
    call Func_00D_60F5
    ret

Jump_00D_6127::
    call Func_00D_60F5
    push de
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Func_000_173A
    farcall Func_015_6676
    pop de
    ld hl, wD7F1
    ld c, $07

Jump_00D_6146::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_6154
    inc hl
    dec c
    jr nz, Jump_00D_6146
    xor a, a
    ld [de], a
    inc de
    jr Jump_00D_615A

Jump_00D_6154::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_00D_6154

Jump_00D_615A::
    ld a, $F0
    ld [de], a
    ret

Func_00D_615E:: ; heuristic: follows a terminator; C0
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sBB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, Jump_00D_617B

Jump_00D_6173::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Jump_00D_617B::
    ld a, [wD781]
    cp a, $0B
    jr c, Jump_00D_6173
    farcall Func_015_6403
    ret

Data_00D_6189:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $77, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_00D_61A7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0361A7, $90

Data_00D_6237:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $036237, $5B

Data_00D_6292:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $AB, $AC, $EE, $EF, $FC, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $71, $72, $73, $74, $75, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_62B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0362B0, $60

Func_00D_6310::
    ld a, [wD780]
    rst $00
    dw Jump_00D_643A
    dw Jump_00D_6384
    dw Jump_00D_6320
    dw Jump_00D_649C
    dw Jump_00D_656D
    dw Jump_00D_65D0

Jump_00D_6320::
    ld a, [wC839]
    and a, a
    jr nz, Jump_00D_6345
    ld a, [wC838]
    and a, a
    jr z, Jump_00D_6336
    cp a, $01
    jr z, Jump_00D_6336
    cp a, $02
    jr z, Jump_00D_6336
    jr Jump_00D_6345

Jump_00D_6336::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6345::
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld hl, wC130
    ld de, wC8C0
    ld a, [de]
    cp a, $E3
    jr z, Jump_00D_6362
    ld [hl+], a

Jump_00D_6362::
    inc de
    ld a, [de]
    cp a, $E3
    jr z, Jump_00D_6369
    ld [hl+], a

Jump_00D_6369::
    inc de
    ld a, [de]
    ld [hl+], a
    ld a, $F0
    ld [hl], a
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

Jump_00D_6384::
    call Func_00D_6DD0
    push af
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    pop af
    cp a, $FF
    jr nz, Jump_00D_6397
    jr Jump_00D_63CB

Jump_00D_6397::
    push af
    add a, l
    ld l, a
    jr nc, Jump_00D_639D
    inc h

Jump_00D_639D::
    ld a, h
    cp a, $03
    jr c, Jump_00D_63CF
    jr nz, Jump_00D_63A9
    ld a, l
    cp a, $E8
    jr c, Jump_00D_63CF

Jump_00D_63A9::
    ld a, l
    sub a, $E7
    ld l, a
    ld a, h
    sbc a, $03
    ld h, a
    pop af
    ld b, a
    ld a, l
    sub a, b
    ld b, a
    and a, a
    jr z, Jump_00D_63C1
    ld hl, wC61D
    ld c, $00
    call Func_00D_63F6

Jump_00D_63C1::
    ld a, $03
    ld [wC839], a
    ld a, $E7
    ld [wC838], a

Jump_00D_63CB::
    ld a, $01
    jr Jump_00D_63E2

Jump_00D_63CF::
    pop af
    ld b, a
    ld a, l
    ld [wC838], a
    ld a, h
    ld [wC839], a
    ld hl, wC61D
    ld c, $00
    call Func_00D_63F6
    xor a, a

Jump_00D_63E2::
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_63F6::
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
    jr nz, Jump_00D_640D
    xor a, a
    ld [hl], a
    pop bc
    pop hl
    push hl
    push bc
    dec b
    ld a, b
    and a, a
    jr nz, Jump_00D_640D
    pop hl
    pop bc
    jr Jump_00D_6416
    db $C9

Jump_00D_640D::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Func_00D_63F6

Jump_00D_6416::
    ld hl, wC61D
    ld de, wC61E
    ld b, $17

Jump_00D_641E::
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6428
    inc hl
    inc de
    dec b
    jr nz, Jump_00D_641E
    ret

Jump_00D_6428::
    ld a, [de]
    and a, a
    jr nz, Jump_00D_6431
    inc de
    dec b
    jr nz, Jump_00D_6428
    ret

Jump_00D_6431::
    ld a, [de]
    ld [hl+], a
    xor a, a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_641E
    ret

Jump_00D_643A::
    ld hl, wD780
    ld bc, $006F

Jump_00D_6440::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_00D_6440
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_6465
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_00D_4E84

Jump_00D_6465::
    ld a, $07
    ld [wD7F0], a
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    call Func_00D_6DD0
    cp a, $FF
    jr z, Jump_00D_6488
    xor a, a
    ld [wD7FA], a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6488::
    ld a, $01
    ld [wD7FA], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_649C::
    ld a, [wD781]
    rst $00
    dw Jump_00D_64A6
    dw Func_00D_6509
    dw Jump_00D_6541

Jump_00D_64A6::
    ld de, Data_01F_4170
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4280
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4250
    ld hl, vTiles1 + $2F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4300
    ld hl, vTiles1 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A40
    ld hl, vTiles1 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_6509::
    ld de, Data_00D_6EB7
    ld hl, wC36D
    ld bc, $0B03
    call Func_00D_4DCB
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld hl, wC388
    ld de, wC8C0
    ld c, $00

Jump_00D_652E::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_00D_652E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_6541::
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_00D_656D::
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_6581
    cp a, $FF
    jr z, Jump_00D_6590
    ret

Jump_00D_6581::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6590::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_6581
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call Func_00D_4ED5
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    xor a, a
    ld [wD7FA], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_65D0::
    ld a, [wD781]
    rst $00
    dw Jump_00D_65F2
    dw Jump_00D_6615
    dw Func_00D_6668
    dw Func_00D_66BB
    dw Func_00D_66CE
    dw Func_00D_66ED
    db $A3, $67
    dw Func_00D_67F7
    dw Func_00D_68FD
    dw Func_00D_6929
    dw Func_00D_69E8
    dw Func_00D_6A0B
    dw Func_00D_6A1F
    dw Func_00D_6AA2
    dw Func_00D_6AEC

Jump_00D_65F2::
    ld de, Data_00D_6ED8
    ld hl, wC3B7
    ld bc, $1109
    call Func_00D_4DCB
    call Func_00D_6DF2
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_00D_6615::
    ld hl, vTiles1 + $240
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0F01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $700
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_6668:: ; heuristic: target of a pointer table; C0
    ld a, [wD7AF]
    and a, a
    jr nz, Jump_00D_6678
    ld de, Data_00D_6F71
    jr Jump_00D_6681

Jump_00D_6673::
    ld de, Data_00D_7043
    jr Jump_00D_6681

Jump_00D_6678::
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_6673
    ld de, Data_00D_6FDA

Jump_00D_6681::
    ld hl, wC3CC
    ld bc, $0F07
    call Func_00D_4DCB
    ld a, $01
    ld [wD7F5], a
    call Func_00D_5C87
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_00D_669C
    call Func_00D_6E88

Jump_00D_669C::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_00D_7106
    call Func_00D_4E96
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_66BB:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7F5], a
    call Func_00D_6E0E
    call Func_00D_6D3E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_66CE:: ; heuristic: target of a pointer table; C0
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_00D_7106
    call Func_00D_4E96
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_66ED:: ; heuristic: target of a pointer table; C0
    ld b, $BB
    call Func_00D_6DA7
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    cp a, $01
    jr c, Jump_00D_6707
    ld a, $01

Jump_00D_6707::
    ld [wD7FA], a
    cp a, $01
    jr z, Jump_00D_6744
    add a, $22
    ld [wC529], a
    xor a, a
    ld [wC528], a
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
    farcall Func_00D_400F
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6744::
    ld a, [hl]
    add a, $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, Data_00D_4016
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wC130
    ld c, $00

Jump_00D_6761::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_676A
    ld [hl+], a
    inc de
    jr Jump_00D_6761

Jump_00D_676A::
    ld a, $F0
    ld [hl], a
    ld a, $23
    ld [wC529], a
    xor a, a
    ld [wC528], a
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
    farcall Func_00D_400F
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_67A3:: ; heuristic: follows a terminator; C0
    ld b, $BB
    call Func_00D_6DA7
    ld a, [wC563]
    bit 6, a
    jr nz, Jump_00D_67E4
    bit 7, a
    jr nz, Jump_00D_67E8
    bit 4, a
    jr nz, Jump_00D_67EC
    bit 5, a
    jr nz, Jump_00D_67F0
    bit 1, a
    jr nz, Jump_00D_67CB
    bit 0, a
    jr nz, Jump_00D_67CB
    ld a, [wC52B]
    bit 0, a
    ret nz
    jr Jump_00D_67CE

Jump_00D_67CB::
    call Func_00D_400F

Jump_00D_67CE::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ld b, $BB
    call Func_00D_6DA7
    ret

Jump_00D_67E4::
    ld a, $01
    jr Jump_00D_67F2

Jump_00D_67E8::
    ld a, $02
    jr Jump_00D_67F2

Jump_00D_67EC::
    ld a, $03
    jr Jump_00D_67F2

Jump_00D_67F0::
    ld a, $04

Jump_00D_67F2::
    ld [wD7BD], a
    jr Jump_00D_67CE

Func_00D_67F7:: ; heuristic: target of a pointer table; C0
    ld a, [wD7BD]
    and a, a
    jr z, Jump_00D_6827
    cp a, $01
    jr z, Jump_00D_6822
    cp a, $02
    jr z, Jump_00D_681B
    cp a, $03
    jr z, Jump_00D_6814
    cp a, $04
    jr z, Jump_00D_680D

Jump_00D_680D::
    ld a, $20
    ld [wC563], a
    jr Jump_00D_6827

Jump_00D_6814::
    ld a, $10
    ld [wC563], a
    jr Jump_00D_6827

Jump_00D_681B::
    ld a, $80
    ld [wC563], a
    jr Jump_00D_6827

Jump_00D_6822::
    ld a, $40
    ld [wC563], a

Jump_00D_6827::
    ld a, $04
    ld [wD7F9], a
    farcall Func_01D_66B6
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_00D_684C
    cp a, $FC
    jr z, Jump_00D_684C
    cp a, $FD
    jr z, Jump_00D_6867
    cp a, $FE
    jr z, Jump_00D_6882
    cp a, $FF
    jr z, Jump_00D_6891
    ret

Jump_00D_684C::
    xor a, a
    ld [wD7BD], a
    ld a, [wD781]
    sub a, $06
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6867::
    xor a, a
    ld [wD7BD], a
    ld a, [wD781]
    sub a, $02
    ld [wD781], a
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6882::
    ld a, $02
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6891::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_00D_7106
    call Func_00D_4E96
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_68BE
    inc d

Jump_00D_68BE::
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld hl, wC130
    ld a, [wC8C1]
    cp a, $E3
    jr z, Jump_00D_68D6
    ld [hl+], a

Jump_00D_68D6::
    ld a, [wC8C2]
    ld [hl+], a
    ld a, $F0
    ld [hl], a
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

Func_00D_68FD:: ; heuristic: target of a pointer table; C0
    ld de, Data_00D_6189
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $6C
    call StoreWC60B
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_6929:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_693D
    cp a, $FF
    jr z, Jump_00D_6956
    ret

Jump_00D_693D::
    call Func_00D_69B3
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

Jump_00D_6956::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_693D
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6974
    inc d

Jump_00D_6974::
    ld a, [de]
    ld b, a
    ld a, [wC839]
    and a, a
    jr nz, Jump_00D_6999
    ld a, [wC838]
    cp a, b
    jr nc, Jump_00D_6999
    ld a, $02
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

Jump_00D_6999::
    xor a, a
    ld [wD7FA], a
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_69B3::
    ld a, [wD7AF]
    and a, a
    jr nz, Jump_00D_69C3
    ld de, Data_00D_70AC
    jr Jump_00D_69CC

Jump_00D_69BE::
    ld de, Data_00D_70CA
    jr Jump_00D_69CC

Jump_00D_69C3::
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_69BE
    ld de, Data_00D_70E8

Jump_00D_69CC::
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    call Func_00D_6D3E
    call Func_00D_6E88
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

Func_00D_69E8:: ; heuristic: target of a pointer table; C0
    ld c, $04
    ld hl, Data_00D_7106
    call Func_00D_4F29
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, $05
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_6A0B:: ; heuristic: target of a pointer table; C0
    call Func_00D_69B3
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_6A1F:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6A63
    call Func_00D_6CCC
    cp a, $FF
    jr nz, Jump_00D_6A4E
    ld a, $03
    ld [wD7FA], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6A4E::
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

Jump_00D_6A63::
    call Func_00D_6D09
    cp a, $FF
    jr nz, Jump_00D_6A4E
    ld a, $01
    ld [wD7FA], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_6A80:: ; heuristic: follows a terminator; C0
    farcall Func_012_691F
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_00D_6A4E
    ld a, $02
    ld [wD7FA], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_6AA2:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    push hl
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6ABA
    inc d

Jump_00D_6ABA::
    ld a, [de]
    ld b, a
    ld a, [wC838]
    ld l, a
    ld a, [wC839]
    ld h, a
    ld a, l
    sub a, b
    ld l, a
    ld a, h
    sbc a, $00
    ld [wC839], a
    ld a, l
    ld [wC838], a
    call Func_00D_6509
    pop hl
    ld a, [hl]
    cp a, $01
    jr nc, Jump_00D_6ADD
    xor a, a
    jr Jump_00D_6ADF

Jump_00D_6ADD::
    ld a, $01

Jump_00D_6ADF::
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_6AEC:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    push af
    and a, a
    jr z, Jump_00D_6B07
    call Func_00D_6CCC
    call Func_00D_6B55
    jr Jump_00D_6B15

Jump_00D_6B07::
    call Func_00D_6D09
    ld a, $1E
    ld [hl], a
    jr Jump_00D_6B15
    db $21, $9A, $68, $06, $12, $D7

Jump_00D_6B15::
    pop af
    and a, a
    jr z, Jump_00D_6B3A
    call Func_00D_6CCC
    cp a, $FF
    jr nz, Jump_00D_6B24
    ld a, $03
    jr Jump_00D_6B25

Jump_00D_6B24::
    xor a, a

Jump_00D_6B25::
    ld [wD7FA], a
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_6B3A::
    call Func_00D_6D09
    cp a, $FF
    jr nz, Jump_00D_6B24
    ld a, $01
    jr Jump_00D_6B25

Func_00D_6B45:: ; heuristic: follows a terminator; C0
    farcall Func_012_691F
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_00D_6B24
    ld a, $02
    jr Jump_00D_6B25

Func_00D_6B55::
    push hl
    ld hl, wC986
    ld b, $A5

Jump_00D_6B5B::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6B5B
    pop hl
    push hl
    farcall Func_01D_5DA1
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld hl, $0179
    add a, l
    ld l, a
    jr nc, Jump_00D_6B79
    inc h

Jump_00D_6B79::
    ld a, l
    ld [wCFE6], a
    ld a, h
    ld [wCFE7], a
    farcall Func_034_4001
    ld a, [wCFEC]
    ld [wD006], a
    ld a, [wCFED]
    ld [wD007], a
    farcall Func_035_4001
    farcall Func_016_5AAF
    ld hl, wC986
    ld a, $01
    ld [hl+], a
    call Func_00D_6CBA
    ld a, [wCFEC]
    ld [hl+], a
    ld [wCADB], a
    ld a, [wCFED]
    ld [hl+], a
    ld [wCADC], a
    ld a, [wD008]
    ld [hl+], a
    push hl
    farcall Func_00E_61C1
    pop hl
    ld a, [wCADE]
    ld [hl+], a
    ld de, wC60C
    ld c, $00

Jump_00D_6BCB::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_6BDA
    ld [hl+], a
    inc c
    inc de
    ld a, c
    cp a, $0A
    jr c, Jump_00D_6BCB
    jr Jump_00D_6BED

Jump_00D_6BDA::
    ld a, $F0
    ld [hl+], a
    inc c
    ld a, c
    cp a, $0A
    jr z, Jump_00D_6BED
    ld a, $0A
    sub a, c
    ld b, a

Jump_00D_6BE7::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6BE7

Jump_00D_6BED::
    xor a, a
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    ld b, $08

Jump_00D_6C01::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6C01
    push hl
    ld b, $19

Jump_00D_6C0A::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6C0A
    pop hl
    ld a, [wD010]
    ld [hl+], a
    ld a, [wD011]
    ld [hl+], a
    ld a, [wD012]
    ld [hl+], a
    ld a, $16
    add a, l
    ld l, a
    jr nc, Jump_00D_6C24
    inc h

Jump_00D_6C24::
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, [wD00E]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, [wCFF6]
    ld [hl+], a
    ld a, [wCFF7]
    ld [hl+], a
    ld a, [wCFF6]
    ld [hl+], a
    ld a, [wCFF7]
    ld [hl+], a
    ld a, [wCFF8]
    ld [hl+], a
    ld a, [wCFF9]
    ld [hl+], a
    ld a, [wCFF8]
    ld [hl+], a
    ld a, [wCFF9]
    ld [hl+], a
    ld a, [wCFFA]
    ld [hl+], a
    ld a, [wCFFB]
    ld [hl+], a
    ld a, [wCFFC]
    ld [hl+], a
    ld a, [wCFFD]
    ld [hl+], a
    ld a, [wCFFE]
    ld [hl+], a
    ld a, [wCFFF]
    ld [hl+], a
    ld a, [wD000]
    ld [hl+], a
    ld a, [wD001]
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, [wD002]
    ld [hl+], a
    ld a, [wD003]
    ld [hl+], a
    ld a, [wD005]
    ld [hl+], a
    ld a, [wD004]
    ld [hl+], a
    ld de, wD01A
    ld b, $1B

Jump_00D_6C8E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_6C8E
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    call Func_00D_6CBE
    xor a, a
    ld [hl+], a
    xor a, a
    ld [hl+], a
    pop hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wC986
    ld b, $A5

Jump_00D_6CAF::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_6CAF
    xor a, a
    ld [rRAMG2], a
    ret

Func_00D_6CBA::
    ld b, $0A
    jr Jump_00D_6CC5

Func_00D_6CBE::
    ld a, $98
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld b, $07

Jump_00D_6CC5::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_00D_6CC5
    ret

Func_00D_6CCC::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
    ld c, $00
    ld a, [wC7C7]
    ld de, Data_00D_6D06
    add a, e
    ld e, a
    jr nc, Jump_00D_6CE5
    inc d

Jump_00D_6CE5::
    ld a, [de]
    ld b, a

Jump_00D_6CE7::
    push hl
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6D00
    cp a, $FF
    jr z, Jump_00D_6D00
    pop hl
    ld a, $A5
    add a, l
    ld l, a
    jr nc, Jump_00D_6CF8
    inc h

Jump_00D_6CF8::
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6CE7
    ld a, $FF
    ret

Jump_00D_6D00::
    pop hl
    xor a, a
    ld [rRAMG2], a
    ret

Data_00D_6D06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

Func_00D_6D09::
    ld hl, wC61D
    ld c, $00

Jump_00D_6D0E::
    ld a, [hl]
    and a, a
    jr z, Jump_00D_6D20
    cp a, $FF
    jr z, Jump_00D_6D20
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_00D_6D0E
    ld a, $FF
    ret

Jump_00D_6D20::
    xor a, a
    ret

Func_00D_6D22:: ; heuristic: follows a terminator; C0
    ld hl, wC707
    ld c, $00

Jump_00D_6D27::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_00D_6D3C
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_00D_6D33
    inc h

Jump_00D_6D33::
    inc c
    ld a, c
    cp a, $0C
    jr c, Jump_00D_6D27
    ld a, $FF
    ret

Jump_00D_6D3C::
    xor a, a
    ret

Func_00D_6D3E::
    ld a, [wD7AF]
    add a, a
    add a, a
    ld de, Data_00D_710E
    add a, e
    ld e, a
    jr nc, Jump_00D_6D4B
    inc d

Jump_00D_6D4B::
    ld a, [wD7AF]
    and a, a
    jr z, Jump_00D_6D60
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_6D64
    ld a, [wD7AF]
    ld b, a
    ld a, $03
    sub a, b
    jr Jump_00D_6D66

Jump_00D_6D60::
    ld a, $04
    jr Jump_00D_6D66

Jump_00D_6D64::
    ld a, $03

Jump_00D_6D66::
    ld b, a
    ld c, $00

Jump_00D_6D69::
    push de
    push bc
    ld a, [de]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall Func_015_68DC
    ld de, Data_00D_6D9F
    pop bc
    push bc
    ld a, c
    sla a
    add a, e
    ld e, a
    jr nc, Jump_00D_6D85
    inc d

Jump_00D_6D85::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    pop bc
    pop de
    inc de
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6D69
    ret

Data_00D_6D9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D7, $C3, $FF, $C3, $27, $C4, $4F, $C4

Func_00D_6DA7::
    push bc
    ld a, [wD7AB]
    sla a
    ld hl, Data_00D_6DC8
    add a, l
    ld l, a
    jr nc, Jump_00D_6DB5
    inc h

Jump_00D_6DB5::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call Func_00D_4E5A
    pop de
    add hl, de
    pop bc
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_00D_6DC8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A4, $00, $E4, $00, $24, $01, $64, $01

Func_00D_6DD0::
    ld hl, wC61D
    ld c, $00
    ld b, $00

Jump_00D_6DD7::
    push hl
    push bc
    ld a, [hl]
    cp a, $2C
    jr nz, Jump_00D_6DE1
    pop bc
    inc b
    push bc

Jump_00D_6DE1::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_00D_6DD7
    ld a, b
    and a, a
    jr z, Jump_00D_6DEF
    ret

Jump_00D_6DEF::
    ld a, $FF
    ret

Func_00D_6DF2::
    ld a, [wC837]
    and a, a
    jr nz, Jump_00D_6DFC
    ld b, $06
    jr Jump_00D_6DFE

Jump_00D_6DFC::
    ld b, $07

Jump_00D_6DFE::
    ld hl, wD789
    ld c, $00

Jump_00D_6E03::
    ld a, c
    ld [hl+], a
    inc c
    ld a, c
    cp a, b
    jr c, Jump_00D_6E03
    ld [wD7A9], a
    ret

Func_00D_6E0E::
    ld hl, wD789
    ld a, [wD7AF]
    sla a
    sla a
    add a, l
    ld l, a
    jr nc, Jump_00D_6E1D
    inc h

Jump_00D_6E1D::
    ld c, $00

Jump_00D_6E1F::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_00D_6E2B
    ld a, [wD7A9]
    jr Jump_00D_6E3A

Jump_00D_6E2B::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_00D_6E37
    ld a, [wD7A9]
    jr Jump_00D_6E3A

Jump_00D_6E37::
    ld a, [wD7A9]

Jump_00D_6E3A::
    ld b, a
    ld a, [wD7AF]
    sla a
    sla a
    add a, c
    cp a, b
    jp nc, Jump_00D_6E87
    push hl
    push bc
    ld a, [hl]
    add a, $28
    ld l, a
    ld h, $00
    sla l
    rl h
    push hl
    ld hl, Data_00D_4016
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld hl, wC8CF
    ld c, $00

Jump_00D_6E66::
    ld a, [de]
    cp a, $F0
    jr z, Jump_00D_6E6F
    ld [hl+], a
    inc de
    jr Jump_00D_6E66

Jump_00D_6E6F::
    ld a, $F0
    ld [hl], a
    pop bc
    push bc
    call Func_00D_5ED6
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_00D_6E87
    ld a, c
    cp a, $04
    jp c, Jump_00D_6E1F

Jump_00D_6E87::
    ret

Func_00D_6E88::
    ld de, $018E
    call Func_00D_4EA4
    ld hl, wC462
    call Func_00D_4EC7
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
    ret

Data_00D_6EB7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $AD, $CF, $AE, $AF
    db $FC, $FD, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4
    db $B5

Data_00D_6ED8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $036ED8, $99

Data_00D_6F71:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FD
    ds $14, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $FD, $C3, $C3, $C3, $C3

Data_00D_6FDA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8
    ds $15, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $C3, $C3, $C3, $C3

Data_00D_7043:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $FD
    ds $14, $C3
    db $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $FD
    ds $14, $C3
    db $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $FD
    ds $14, $C3
    db $D9, $DA, $DB, $DC, $DD, $DE, $F9, $FA, $FB, $C3, $C3, $C3, $C3, $C3

Data_00D_70AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_70CA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $FD, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_70E8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3
    db $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_00D_7106:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $C3, $F4, $C3, $1C, $C4, $44, $C4

Data_00D_710E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $03, $04, $04, $05, $05, $0A

Func_00D_7115::
    farcall Func_01E_4001
    ret

Func_00D_711C::
    ld a, [wD780]
    rst $00
    dw Jump_00D_7144
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7159
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_755C
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7158
    dw Jump_00D_7578

Jump_00D_7144::
    farcall Func_01E_4069
    ld a, $08
    ld [wD7F0], a
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    ret

Jump_00D_7158::
    ret

Jump_00D_7159::
    ld a, [wD781]
    rst $00
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_71BD
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_71FF
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_719C
    dw Func_00D_7195
    dw Func_00D_7195
    dw Func_00D_720E
    dw Func_00D_7195
    dw Func_00D_722A
    dw Func_00D_72D0
    dw Func_00D_72F4
    dw Func_00D_7329
    dw Func_00D_7352
    dw Func_00D_73AF
    dw Func_00D_73F1
    dw Func_00D_74AD
    dw Func_00D_74BB
    dw Func_00D_74F1
    dw Func_00D_74FC

Func_00D_7195:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ret

Func_00D_719C:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ld de, Data_01F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

Func_00D_71BD:: ; heuristic: target of a pointer table; C0
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
    call Func_00D_7812
    ld de, Data_00D_785E
    ld hl, wC36C
    ld bc, $0C05
    call Func_00D_4DCB
    pop af
    ld [wD7F1], a
    ld hl, wC386
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    farcall Func_015_688D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_71FF:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_720E:: ; heuristic: target of a pointer table; C0
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call Func_00D_4ED5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_722A:: ; heuristic: target of a pointer table; C0
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
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $0A
    jr nc, Jump_00D_726A
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

Jump_00D_726A::
    pop hl
    ld a, [wC6FD]
    cp a, $02
    jr nc, Jump_00D_7295
    ld a, [hl]
    ld b, a
    ld a, [wC6FE]
    cp a, b
    jr nz, Jump_00D_7295
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

Jump_00D_7295::
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
    ld [wD7FA], a
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

Func_00D_72D0:: ; heuristic: target of a pointer table; C0
    ld a, [wD782]
    and a, a
    jr nz, Jump_00D_72E0
    call Func_00D_7839
    farcall Func_015_6EA5
    ret

Jump_00D_72E0::
    xor a, a
    ld [wD782], a
    call Func_00D_720E
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ret

Func_00D_72F4:: ; heuristic: target of a pointer table; C0
    call Func_00D_7839
    ld a, [wD7FB]
    sla a
    ld de, Data_00D_78D6
    add a, e

Func_00D_7300:: ; heuristic: target of a pointer table; C0
    ld e, a

Func_00D_7301:: ; heuristic: target of a pointer table; C0
    jr nc, Jump_00D_7304
    inc d

Jump_00D_7304::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, wCA2B
    ld b, $A5

Jump_00D_730E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_730E
    ld hl, wC994
    ld a, [hl]
    and a, $01
    inc a
    and a, $01
    ld hl, wCA39
    ld [hl], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_7329:: ; heuristic: target of a pointer table; C0
    ld a, $01
    ld [wD7F1], a
    farcall Func_00E_5688
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    call Func_00D_76D0
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    xor a, a
    ld [wD782], a
    ret

Func_00D_7352:: ; heuristic: target of a pointer table; C0
    ld a, $6C
    call StoreWC60B
    ld de, Data_01F_4230
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles2 + $720
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4180
    ld hl, vTiles2 + $760
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD7FA], a
    ld de, Data_00D_78B8
    ld hl, wC412
    ld bc, $0605
    call Func_00D_4DCB
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_73AF:: ; heuristic: target of a pointer table; C0
    farcall Func_01D_6540
    ld a, [wD7F9]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_00D_73C3
    cp a, $FF
    jr z, Jump_00D_73D2
    ret

Jump_00D_73C3::
    ld a, $01
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_73D2::
    ld a, [wD7FA]
    cp a, $01
    jr z, Jump_00D_73C3
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld [wD7FA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Func_00D_73F1:: ; heuristic: target of a pointer table; C0
    ld a, [wD782]
    and a, a
    jr z, Jump_00D_740F
    xor a, a
    ld [wD7FA], a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_740F::
    ld a, [wD7B4]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall Func_014_7E96
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

Jump_00D_7435::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_00D_7435
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
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
    farcall Func_015_68F3
    ld hl, wD7E0
    ld b, $07

Jump_00D_7472::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_00D_7472
    ld a, [wD7FB]
    sla a
    ld hl, Data_00D_7499
    add a, l
    ld l, a
    jr nc, Jump_00D_7484
    inc h

Jump_00D_7484::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    farcall Func_015_6E64
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Data_00D_7499:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $01, $18, $01, $1A, $01, $25, $01, $29, $01, $32, $00, $33, $00, $34, $00
    db $35, $00, $36, $00

Func_00D_74AD:: ; heuristic: target of a pointer table; C0
    farcall Func_00C_6FCB
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_74BB:: ; heuristic: target of a pointer table; C0
    ld a, [wC919]
    ld [wC91C], a
    ld a, [wC91A]
    ld [wC91D], a
    ld a, [wC91B]
    ld [wC91E], a
    xor a, a
    ld [wC917], a
    ld a, $20
    ld [wC916], a
    farcall Func_013_405C
    xor a, a
    ld [wD7FD], a
    xor a, a
    ldh [hFFB9], a
    farcall Func_004_449F
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_74F1:: ; heuristic: target of a pointer table; C0
    call Func_00D_77C2
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Func_00D_74FC:: ; heuristic: target of a pointer table; C0
    ld hl, wC364
    ld de, wC198
    ld bc, $0104
    call Func_00D_4E7B
    ld hl, wC300
    ld de, wC29C
    ld bc, $0064
    call Func_00D_4E7B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_00D_7532
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call Func_00D_4E84
    ld hl, wD168
    ld de, wD104
    ld bc, $0064
    call Func_00D_4E84

Jump_00D_7532::
    call Func_00D_4E5A
    ld bc, $140D
    ld de, $01CC
    call Func_00D_4E05
    call Func_00D_4E5A
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call Func_00D_4E05
    ld a, $70
    ldh [hFFBA], a
    xor a, a
    ld [wC920], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00D_755C::
    farcall Func_01E_4069
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $05
    ld [wD780], a
    ret

Jump_00D_7578::
    ld a, [wD781]
    rst $00
    dw Func_00D_7597
    dw Func_00D_7637
    dw Func_00D_7590
    dw Func_00D_7590
    dw Func_00D_7590
    dw Func_00D_71BD
    db $62, $76, $AF, $76, $90, $75, $90, $75

Func_00D_7590:: ; heuristic: target of a pointer table; C0
    farcall Func_015_40FA
    ret

Func_00D_7597:: ; heuristic: target of a pointer table; C0
    ld a, [wD7FB]
    ld b, a
    sla a
    add a, b
    push af
    ld hl, Data_00D_75D7
    add a, l
    ld l, a
    jr nc, Jump_00D_75A7
    inc h

Jump_00D_75A7::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, vTiles2
    call DecompressToVRAM
    pop af
    ld hl, Data_00D_7607
    add a, l
    ld l, a
    jr nc, Jump_00D_75BC
    inc h

Jump_00D_75BC::
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl]
    ld b, a
    ld hl, wC49F
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wC526], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_00D_75D7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9, $49, $48, $82, $6B, $48, $A9
    db $49, $48, $A9, $49, $48, $A9, $49, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B
    db $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48, $82, $6B, $48

Data_00D_7607:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87, $4C, $48, $34, $6F, $48, $87
    db $4C, $48, $87, $4C, $48, $87, $4C, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F
    db $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48, $34, $6F, $48

Func_00D_7637:: ; heuristic: target of a pointer table; C0
    ld hl, Data_01F_789A
    ld de, Data_01F_78AA
    call Func_00D_4F3D
    ld de, Data_01F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $037662, $6E

Func_00D_76D0::
    ld a, [wD7F6]
    ld [wD7F1], a
    ld [wD006], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld [wD007], a
    ld de, $75C5
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall Func_015_68FA
    ld a, [wD7F5]
    cp a, $FF
    jr z, Jump_00D_7737
    ld a, [wD7F6]
    ld [wD7F1], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld hl, wC7FC
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall Func_015_68FA
    cp a, $FF
    jr z, Jump_00D_7737
    ld a, [wD7F6]
    ld [wD006], a
    ld a, [wD7F7]
    ld [wD007], a
    farcall Func_016_5A7E
    ld a, c
    and a, a
    jr nz, Jump_00D_7737
    ld a, $01
    ld [wD7FA], a
    ret

Jump_00D_7737::
    xor a, a
    ld [wD7FA], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    call Func_00D_778C
    ld hl, wC8CF
    ld de, wC130
    ld b, $10

Jump_00D_774E::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_00D_7758
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_774E

Jump_00D_7758::
    ld a, $90
    ld [de], a
    inc de
    ld a, $A2
    ld [de], a
    inc de
    push de
    ld a, [wCB3D]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall Func_015_68DC
    pop de
    ld hl, wC8C0
    ld b, $03

Jump_00D_7776::
    ld a, [hl]
    cp a, $E3
    jr nz, Jump_00D_7782
    inc hl
    dec b
    ld a, b
    cp a, $01
    jr nz, Jump_00D_7776

Jump_00D_7782::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_7782
    ld a, $F0
    ld [de], a
    ret

Func_00D_778C::
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, Data_008_4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_00D_77A0
    inc h

Jump_00D_77A0::
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

Func_00D_77C2::
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

Func_00D_7812::
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

Func_00D_7839::
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

Jump_00D_7853::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00D_7853
    xor a, a
    ld [rRAMG2], a
    ret

Data_00D_785E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $03785E, $5A

Data_00D_78B8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $76, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_00D_78D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00D_78F6
    dw Data_00D_799B
    dw Data_00D_7A40
    dw Data_00D_7AE5
    dw Data_00D_7B8A
    dw Data_00D_7C2F
    dw Data_00D_7CD4
    dw Data_00D_7D79
    dw Data_00D_7E1E
    dw Data_00D_7EC3
    db $F6, $78, $F6, $78, $F6, $78, $F6, $78, $F6, $78, $F6, $78

Data_00D_78F6:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $4A, $00, $02, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $25, $36, $61
    ds $1F, $00
    db $12, $23, $00, $00
    dw Func_00D_5800
    dw Func_00D_5800
    dw Func_00D_5C00
    dw Func_00D_5C00
    INCBIN "dwm2-cobi-us.gbc", $037958, $43

Data_00D_799B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $1E, $01, $08, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $07, $0D, $6B, $6F
    ds $1E, $00
    INCBIN "dwm2-cobi-us.gbc", $0379F1, $4F

Data_00D_7A40:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $BC, $00, $05, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $13, $33, $6D
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037A96, $4F

Data_00D_7AE5:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $92, $00, $04, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $19, $2F, $3C, $9B
    ds $1E, $00
    INCBIN "dwm2-cobi-us.gbc", $037B3B, $4F

Data_00D_7B8A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $5E, $00, $02, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $20, $34, $63, $90
    ds $1E, $00
    INCBIN "dwm2-cobi-us.gbc", $037BE0, $4F

Data_00D_7C2F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $80, $00, $03, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $79, $7B, $92
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037C85, $4F

Data_00D_7CD4:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $0D, $01, $07, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $3A, $3B, $A0
    ds $1F, $00
    db $35, $35, $00, $00
    dw Func_00D_7300
    dw Func_00D_7301
    dw $4601
    dw Func_00D_4602
    INCBIN "dwm2-cobi-us.gbc", $037D36, $43

Data_00D_7D79:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $33, $00, $01, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $19, $82, $9C
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037DCF, $4F

Data_00D_7E1E:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $0A, $01, $07, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $50, $51, $52
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037E74, $4F

Data_00D_7EC3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $33, $01, $08, $00, $98
    db $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $FF, $FF, $FF, $FF, $98, $98
    db $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0, $00, $98, $98, $98, $F0, $F0, $F0, $F0
    db $F0, $F0, $F0, $00, $6F, $81, $91
    ds $1F, $00
    INCBIN "dwm2-cobi-us.gbc", $037F19, $4D
    ds $9A, $00
