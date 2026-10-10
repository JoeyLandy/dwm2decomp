SECTION "Bank 27", ROMX[$4000], BANK[$27]
    db $27

; 6 call sites from 6 routines (e.g. DebugMonsterPictureViewer_Update, Func_004_44CE, Func_004_4C96, Func_004_4D43, ...)
; reads: hSpriteSetIndex, hSpriteAttrXor
; writes: hSpriteAttrXor
Func_027_4001::
    ldh a, [hSpriteSetIndex]
    ld e, a
    ld d, $00
    ld hl, Data_027_411C
    add hl, de
    bit 0, [hl]
    jr z, Jump_027_4017
    ld a, [hl]
    and a, $F0
    ld e, a
    ldh a, [hSpriteAttrXor]
    or a, e
    ldh [hSpriteAttrXor], a

Jump_027_4017::
    ld de, Data_027_401E
    call Func_027_419C
    ret

Data_027_401E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_027_4418
    dw Data_027_448A
    dw Data_027_44FC
    dw Data_027_456E
    dw Data_027_45E0
    dw Data_027_4652
    dw Data_027_46C4
    dw Data_027_4736
    dw Data_027_47A8
    dw Data_027_481A
    dw Data_027_488C
    dw Data_027_48FE
    dw Data_027_4970
    dw Data_027_49E2
    dw Data_027_4A54
    dw Data_027_4AC6
    dw Data_027_4B38
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4BAA
    dw Data_027_4C1C
    dw Data_027_4C8E
    dw Data_027_4D00
    dw Data_027_4D72
    dw Data_027_4DE4
    dw Data_027_4E56
    dw Data_027_4EC8
    dw Data_027_4F3A
    dw Data_027_4FAC
    dw Data_027_501E
    dw Data_027_5090
    dw Data_027_5102
    dw Data_027_5174
    dw Data_027_51E6
    dw Data_027_5258
    dw Data_027_52CA
    dw Data_027_533C
    dw Data_027_53AE
    dw Data_027_5420
    dw Data_027_5492
    dw Data_027_54FC
    dw Data_027_5566
    dw Data_027_55D8
    dw Data_027_564A
    dw Data_027_56BC
    dw Data_027_572E
    dw Data_027_57A0
    dw Data_027_5812
    dw Data_027_5884
    dw Data_027_58F6
    dw Data_027_5968
    dw Data_027_59DA
    dw Data_027_59DA
    dw Data_027_59DA
    dw Data_027_59DA
    dw Data_027_5A4C
    dw Data_027_5ABE
    dw Data_027_5B30
    dw Data_027_5BA2
    dw Data_027_5C14
    dw Data_027_5C86
    dw Data_027_5CF8
    dw Data_027_5D6A
    dw Data_027_5DDC
    dw Data_027_5E4E
    dw Data_027_5EAC
    dw Data_027_5F1E
    dw Data_027_5F90
    dw Data_027_6002
    dw Data_027_6074
    dw Data_027_60E6
    dw Data_027_6158
    dw Data_027_61CA
    dw Data_027_623C
    dw Data_027_62AE
    dw Data_027_6320
    dw Data_027_6392
    dw Data_027_6404
    dw Data_027_6476
    dw Data_027_64E8
    dw Data_027_655A
    dw Data_027_65CC
    dw Data_027_663E
    dw Data_027_66B0
    dw Data_027_6722
    dw Data_027_6794
    dw Data_027_6806
    dw Data_027_6806
    dw Data_027_6806
    dw Data_027_6806
    dw Data_027_6878
    dw Data_027_68EA
    dw Data_027_695C
    dw Data_027_69CE
    dw Data_027_6A40
    dw Data_027_6AB2
    dw Data_027_6B24
    dw Data_027_6B96
    dw Data_027_6C08
    dw Data_027_6C7A
    dw Data_027_6CEC
    dw Data_027_6D5E
    dw Data_027_6DD0
    dw Data_027_6E42
    dw Data_027_6EB4
    dw Data_027_6F26
    dw Data_027_6F98
    dw Data_027_700A
    dw Data_027_707C
    dw Data_027_70EE
    dw Data_027_7160
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $D2, $71
    db $44, $72, $B6, $72

Data_027_411C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $09C11C, $80

; 1 call site from 1 routine (e.g. Func_027_4001)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hFFB3, hFFB4, hOamNextEntry
; points at: hFFB5
Func_027_419C::
    ldh a, [hOamNextEntry]
    cp a, $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hFFB3], a
    ldh a, [hSpriteOriginYHi]
    adc a, b
    ldh [hFFB4], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hFFB5
    ldh a, [hSpriteOriginX]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [hSpriteOriginXHi]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [hFFB9]
    or a, a
    jp nz, Jump_027_42E6
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_027_426E

Jump_027_41F8::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_027_4210
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_027_421F
    ld a, b
    cp a, $A8
    jr c, Jump_027_4224
    jr Jump_027_421F

Jump_027_4210::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_027_421F
    ld a, b
    cp a, $A8
    jr c, Jump_027_4224

Jump_027_421F::
    inc hl
    inc hl
    inc hl
    jr Jump_027_41F8

Jump_027_4224::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_027_423D
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $00
    jr nz, Jump_027_424C
    ld a, b
    cp a, $B8
    jr c, Jump_027_4253
    jr Jump_027_424C

Jump_027_423D::
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $FF
    jr nz, Jump_027_424C
    ld a, b
    cp a, $B8
    jr c, Jump_027_4253

Jump_027_424C::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_41F8

Jump_027_4253::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_027_41F8
    ret

Jump_027_426E::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_027_4286
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_027_4295
    ld a, b
    cp a, $A8
    jr c, Jump_027_429A
    jr Jump_027_4295

Jump_027_4286::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_027_4295
    ld a, b
    cp a, $A8
    jr c, Jump_027_429A

Jump_027_4295::
    inc hl
    inc hl
    inc hl
    jr Jump_027_426E

Jump_027_429A::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_027_42B5
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $00
    jr z, Jump_027_42CB
    jr nz, Jump_027_42C4
    ld a, b
    cp a, $B8
    jr c, Jump_027_42CB
    jr Jump_027_42C4

Jump_027_42B5::
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $FF
    jr nz, Jump_027_42C4
    ld a, b
    cp a, $B8
    jr c, Jump_027_42CB

Jump_027_42C4::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_426E

Jump_027_42CB::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_027_426E
    ret

Jump_027_42E6::
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_027_4367

Jump_027_42EC::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_42F7
    dec b

Jump_027_42F7::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_027_4322
    ld a, c
    cp a, $B8
    jr nc, Jump_027_4322
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_027_4327
    cp a, $01
    jr nz, Jump_027_4315
    ld a, c
    cp a, $34
    jr c, Jump_027_4322
    jr Jump_027_4327

Jump_027_4315::
    cp a, $02
    jr nz, Jump_027_4320
    ld a, c
    cp a, $71
    jr c, Jump_027_4327
    jr Jump_027_4322

Jump_027_4320::
    jr Jump_027_4327

Jump_027_4322::
    inc hl
    inc hl
    inc hl
    jr Jump_027_42EC

Jump_027_4327::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_4332
    dec b

Jump_027_4332::
    ldh a, [hFFB5]
    add a, c
    ld c, a
    ldh a, [hFFB6]
    adc a, b
    jr nz, Jump_027_4340
    ld a, c
    cp a, $B8
    jr c, Jump_027_4347

Jump_027_4340::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_42EC

Jump_027_4347::
    ld a, c
    ld [de], a
    call Func_027_43E2
    jr nc, Jump_027_4340
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_027_42EC
    ret

Jump_027_4367::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_4372
    dec b

Jump_027_4372::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_027_439D
    ld a, c
    cp a, $B8
    jr nc, Jump_027_439D
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_027_43A2
    cp a, $01
    jr nz, Jump_027_4390
    ld a, c
    cp a, $34
    jr c, Jump_027_439D
    jr Jump_027_43A2

Jump_027_4390::
    cp a, $02
    jr nz, Jump_027_439B
    ld a, c
    cp a, $71
    jr c, Jump_027_43A2
    jr Jump_027_439D

Jump_027_439B::
    jr Jump_027_43A2

Jump_027_439D::
    inc hl
    inc hl
    inc hl
    jr Jump_027_4367

Jump_027_43A2::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_027_43AD
    dec b

Jump_027_43AD::
    ldh a, [hFFB7]
    sub a, c
    ld c, a
    ldh a, [hFFB8]
    sbc a, b
    jr nz, Jump_027_43BB
    ld a, c
    cp a, $B8
    jr c, Jump_027_43C2

Jump_027_43BB::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_027_4367

Jump_027_43C2::
    ld a, c
    ld [de], a
    call Func_027_43E2
    jr nc, Jump_027_43BB
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_027_4367
    ret

; 2 call sites from 1 routine (e.g. Func_027_419C)
; reads: hScrollY, hScrollX, hFFBA, rSTAT
Func_027_43E2::
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add a, b
    sub a, $0C
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add a, b
    sub a, $04
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld l, a
    ld a, h
    and a, $03
    adc a, $98
    ld h, a
    ldh a, [hFFBA]
    ld b, a
    di

Jump_027_440C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_027_440C
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

Data_027_4418:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C418, $72

Data_027_448A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C48A, $72

Data_027_44FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C4FC, $72

Data_027_456E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C56E, $72

Data_027_45E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C5E0, $72

Data_027_4652:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C652, $72

Data_027_46C4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C6C4, $72

Data_027_4736:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C736, $72

Data_027_47A8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C7A8, $72

Data_027_481A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C81A, $72

Data_027_488C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C88C, $72

Data_027_48FE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C8FE, $72

Data_027_4970:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C970, $72

Data_027_49E2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09C9E2, $72

Data_027_4A54:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CA54, $72

Data_027_4AC6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CAC6, $72

Data_027_4B38:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CB38, $72

Data_027_4BAA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CBAA, $72

Data_027_4C1C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CC1C, $72

Data_027_4C8E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CC8E, $72

Data_027_4D00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CD00, $72

Data_027_4D72:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CD72, $72

Data_027_4DE4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CDE4, $72

Data_027_4E56:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CE56, $72

Data_027_4EC8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CEC8, $72

Data_027_4F3A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CF3A, $72

Data_027_4FAC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09CFAC, $72

Data_027_501E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D01E, $72

Data_027_5090:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D090, $72

Data_027_5102:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D102, $72

Data_027_5174:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D174, $72

Data_027_51E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D1E6, $72

Data_027_5258:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D258, $72

Data_027_52CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D2CA, $72

Data_027_533C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D33C, $72

Data_027_53AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D3AE, $72

Data_027_5420:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D420, $72

Data_027_5492:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D492, $6A

Data_027_54FC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D4FC, $6A

Data_027_5566:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D566, $72

Data_027_55D8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D5D8, $72

Data_027_564A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D64A, $72

Data_027_56BC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D6BC, $72

Data_027_572E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D72E, $72

Data_027_57A0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D7A0, $72

Data_027_5812:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D812, $72

Data_027_5884:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D884, $72

Data_027_58F6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D8F6, $72

Data_027_5968:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D968, $72

Data_027_59DA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09D9DA, $72

Data_027_5A4C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DA4C, $72

Data_027_5ABE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DABE, $72

Data_027_5B30:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DB30, $72

Data_027_5BA2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DBA2, $72

Data_027_5C14:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DC14, $72

Data_027_5C86:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DC86, $72

Data_027_5CF8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DCF8, $72

Data_027_5D6A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DD6A, $72

Data_027_5DDC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DDDC, $72

Data_027_5E4E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DE4E, $5E

Data_027_5EAC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DEAC, $72

Data_027_5F1E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DF1E, $72

Data_027_5F90:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09DF90, $72

Data_027_6002:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E002, $72

Data_027_6074:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E074, $72

Data_027_60E6:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E0E6, $72

Data_027_6158:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E158, $72

Data_027_61CA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E1CA, $72

Data_027_623C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E23C, $72

Data_027_62AE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E2AE, $72

Data_027_6320:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E320, $72

Data_027_6392:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E392, $72

Data_027_6404:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E404, $72

Data_027_6476:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E476, $72

Data_027_64E8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E4E8, $72

Data_027_655A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E55A, $72

Data_027_65CC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E5CC, $72

Data_027_663E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E63E, $72

Data_027_66B0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E6B0, $72

Data_027_6722:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E722, $72

Data_027_6794:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E794, $72

Data_027_6806:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E806, $72

Data_027_6878:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E878, $72

Data_027_68EA:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E8EA, $72

Data_027_695C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E95C, $72

Data_027_69CE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09E9CE, $72

Data_027_6A40:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EA40, $72

Data_027_6AB2:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EAB2, $72

Data_027_6B24:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EB24, $72

Data_027_6B96:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EB96, $72

Data_027_6C08:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EC08, $72

Data_027_6C7A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EC7A, $72

Data_027_6CEC:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09ECEC, $72

Data_027_6D5E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09ED5E, $72

Data_027_6DD0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EDD0, $72

Data_027_6E42:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EE42, $72

Data_027_6EB4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EEB4, $72

Data_027_6F26:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EF26, $72

Data_027_6F98:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09EF98, $72

Data_027_700A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09F00A, $72

Data_027_707C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09F07C, $72

Data_027_70EE:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09F0EE, $72

Data_027_7160:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $09F160, $6F0

Data_027_7850:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $09F850, $6D0
    ds $E0, $00
