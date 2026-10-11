SECTION "Bank 27", ROMX[$4000], BANK[$27]
    db $27

; ORs the attribute bits from Data_027_411C[hSpriteSetIndex] (when its bit 0 is set) into hSpriteAttrXor, then builds the sprite from Data_027_401E (E-0124)
; 6 call sites from 6 routines (e.g. DebugMonsterPictureViewer_Update, UpdateAndDrawSpriteSlots, AdvanceHFF99AndRunHFF8BMode_Shared01, AdvanceHFF99AndRunHFF8BMode_Case00_Sub01, ...)
; reads: hSpriteSetIndex, hSpriteAttrXor
; writes: hSpriteAttrXor
DrawMetaSpriteSet_Bank27::
Func_027_4001:: ; address name
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
    call DrawMetaSpriteSet_Bank27_Sub01
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

; only called from DrawMetaSpriteSet_Bank27 (E-0047)
; 1 call site from 1 routine (e.g. DrawMetaSpriteSet_Bank27)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
DrawMetaSpriteSet_Bank27_Sub01::
Func_027_419C:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hMetaSpriteYLo], a
    ldh a, [hSpriteOriginYHi]
    adc a, b
    ldh [hMetaSpriteYHi], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hMetaSpriteXLo
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
    ldh a, [hSpriteWindowClipMode]
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
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_027_421F
    ld a, b
    cp a, $A8
    jr c, Jump_027_4224
    jr Jump_027_421F

Jump_027_4210::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
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
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $00
    jr nz, Jump_027_424C
    ld a, b
    cp a, $B8
    jr c, Jump_027_4253
    jr Jump_027_424C

Jump_027_423D::
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
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
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, Jump_027_4295
    ld a, b
    cp a, $A8
    jr c, Jump_027_429A
    jr Jump_027_4295

Jump_027_4286::
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
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
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $00
    jr z, Jump_027_42CB
    jr nz, Jump_027_42C4
    ld a, b
    cp a, $B8
    jr c, Jump_027_42CB
    jr Jump_027_42C4

Jump_027_42B5::
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
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
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_027_4322
    ld a, c
    cp a, $B8
    jr nc, Jump_027_4322
    ldh a, [hSpriteWindowClipMode]
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
    ldh a, [hMetaSpriteXLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteXHi]
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
    call BGTileUnderPointIsHFFBA_Bank27
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
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, Jump_027_439D
    ld a, c
    cp a, $B8
    jr nc, Jump_027_439D
    ldh a, [hSpriteWindowClipMode]
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
    ldh a, [hMetaSpriteXFlipLo]
    sub a, c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
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
    call BGTileUnderPointIsHFFBA_Bank27
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

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. DrawMetaSpriteSet_Bank27_Sub01)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsHFFBA_Bank27::
Func_027_43E2:: ; address name
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
    ldh a, [hSpriteHideTile]
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
    INCBIN "dwm2-cobi-us.gbc", $09F160, $1C8

; E-0143 (C1: on CGB, with hFFC8 = 0, DecompressGraphicsHFFC6ToHFFCA copies the 8 bytes at 27:$7328 + 8 * monster id to wOBJPaletteBuffer + 8 * hFFC9; the count matches MonsterSpriteTable).
; record: one CGB OBJ palette: 4 BGR555 colours
MonsterSpritePalettes::
Data_027_7328:: ; heuristic: start of a structured table; C0
    dw $0000, $6BFF, $027F, $0800 ; id 0
    dw $0000, $6BFF, $027F, $0800 ; id 1 DrakSlime
    dw $0000, $6BFF, $035F, $0800 ; id 2 SpotSlime
    dw $0000, $01BF, $4BA0, $0800 ; id 3 WingSlime
    dw $0000, $03E2, $78B4, $0800 ; id 4 TreeSlime
    dw $0000, $6BFF, $0F8A, $0800 ; id 5 Snaily
    dw $0000, $6BFF, $3E60, $0800 ; id 6 SlimeNite
    dw $0000, $6BFF, $0F8A, $0800 ; id 7 Babble
    dw $0000, $6BFF, $0C7F, $0800 ; id 8 BoxSlime
    dw $0000, $6BFF, $6F40, $0800 ; id 9 PearlGel
    dw $0000, $6BFF, $7EA0, $0800 ; id 10 Slime
    dw $0000, $035F, $7CE1, $0800 ; id 11 Healer
    dw $0000, $027F, $4A60, $0800 ; id 12 FangSlime
    dw $0000, $3AD9, $0112, $0800 ; id 13 RockSlime
    dw $0000, $6BFF, $31AC, $0800 ; id 14 SlimeBorg
    dw $0000, $6BFF, $391F, $0800 ; id 15 Slabbit
    dw $0000, $031F, $7E42, $0800 ; id 16 KingSlime
    dw $0000, $6BFF, $2549, $0800 ; id 17 Metaly
    dw $0000, $6BFF, $296A, $0800 ; id 18 Metabble
    dw $0000, $6BFF, $031F, $0800 ; id 19 SpotKing
    dw $0000, $6BFF, $022A, $0800 ; id 20 TropicGel
    dw $0000, $03DF, $4472, $0800 ; id 21 MimeSlime
    dw $0000, $7FE0, $391C, $0800 ; id 22 HaloSlime
    dw $0000, $2A1F, $2549, $0800 ; id 23 MetalKing
    dw $0000, $1BFF, $029F, $0800 ; id 24 GoldSlime
    dw $0000, $6BFF, $0240, $0800 ; id 25 GranSlime
    dw $0000, $6BFF, $22DE, $0800 ; id 26 WonderEgg
    dw $0000, $6BFF, $027F, $0800 ; id 27 Butch
    dw $0000, $6BFF, $027F, $0800 ; id 28 ?
    dw $0000, $6BFF, $027F, $0800 ; id 29 ?
    dw $0000, $6BFF, $027F, $0800 ; id 30 ?
    dw $0000, $6BFF, $027F, $0800 ; id 31 ?
    dw $0000, $6BFF, $027F, $0800 ; id 32 ?
    dw $0000, $6BFF, $027F, $0800 ; id 33 ?
    dw $0000, $6BFF, $027F, $0800 ; id 34 ?
    dw $0000, $6BFF, $027F, $0800 ; id 35 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 36 DragonKid
    dw $0000, $029F, $7E80, $0800 ; id 37 Tortragon
    dw $0000, $6BFF, $7371, $0800 ; id 38 Pteranod
    dw $0000, $03BF, $1C37, $0800 ; id 39 Gasgon
    dw $0000, $209D, $37E0, $0800 ; id 40 FairyDrak
    dw $0000, $6BFF, $6D48, $0800 ; id 41 LizardMan
    dw $0000, $6BFF, $02D7, $0800 ; id 42 Poisongon
    dw $0000, $6BFF, $7E00, $0800 ; id 43 Swordgon
    dw $0000, $6DE7, $7F20, $0800 ; id 44 Drygon
    dw $0000, $33BF, $32A0, $0800 ; id 45 Dragon
    dw $0000, $6BFF, $02BF, $0800 ; id 46 MiniDrak
    dw $0000, $6BFF, $7E80, $0800 ; id 47 MadDragon
    dw $0000, $6BFF, $02FF, $0800 ; id 48 Rayburn
    dw $0000, $0F7F, $06A0, $0800 ; id 49 Chamelgon
    dw $0000, $6BFF, $03B6, $0800 ; id 50 LizardFly
    dw $0000, $6B5A, $1525, $0800 ; id 51 Andreal
    dw $0000, $075F, $1479, $0800 ; id 52 KingCobra
    dw $3800, $6BFF, $71ED, $0800 ; id 53 Vampirus
    dw $3800, $6BFF, $030B, $0800 ; id 54 SnakeBat
    dw $0000, $6BFF, $3E51, $0800 ; id 55 Spikerous
    dw $0000, $075C, $0A3D, $0800 ; id 56 GreatDrak
    dw $0000, $007F, $06C5, $0800 ; id 57 Crestpent
    dw $0000, $033F, $7E60, $0800 ; id 58 WingSnake
    dw $0000, $1F00, $015A, $0800 ; id 59 Coatol
    dw $0000, $6BFF, $0286, $0800 ; id 60 Orochi
    dw $0000, $037F, $076F, $0800 ; id 61 BattleRex
    dw $0000, $6BFF, $023D, $0800 ; id 62 SkyDragon
    dw $0000, $7F20, $001D, $0800 ; id 63 Serpentia
    dw $0000, $6BFF, $1BEC, $0800 ; id 64 Divinegon
    dw $0000, $6BFF, $01CF, $0800 ; id 65 Orligon
    dw $0000, $6BFF, $155E, $0800 ; id 66 GigaDraco
    dw $0000, $6BFF, $01DE, $0800 ; id 67 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 68 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 69 ?
    dw $0000, $6BFF, $01DE, $0800 ; id 70 ?
    dw $0000, $7F00, $021A, $0800 ; id 71 Tonguella
    dw $0000, $6BFF, $7CB8, $0800 ; id 72 Almiraj
    dw $0000, $6BFF, $01FF, $0800 ; id 73 CatFly
    dw $0000, $02D3, $15FF, $0800 ; id 74 PillowRat
    dw $0000, $6BFF, $0176, $0800 ; id 75 Saccer
    dw $0000, $6BFF, $0270, $0800 ; id 76 GulpBeast
    dw $0000, $6BFF, $033F, $0800 ; id 77 Skullroo
    dw $0000, $6BFF, $7F00, $0800 ; id 78 WindBeast
    dw $0000, $6BFF, $027D, $0800 ; id 79 Beavern
    dw $0000, $075F, $7DC7, $0800 ; id 80 Antbear
    dw $0000, $025F, $7C15, $0800 ; id 81 SuperTen
    dw $0000, $03E8, $00D6, $0800 ; id 82 IronTurt
    dw $0000, $035F, $4A53, $0800 ; id 83 Mommonja
    dw $0000, $01B6, $1B9F, $0800 ; id 84 HammerMan
    dw $0000, $6BFF, $422E, $0800 ; id 85 Grizzly
    dw $0000, $6BFF, $455F, $0800 ; id 86 Yeti
    dw $3800, $6BFF, $5293, $0800 ; id 87 ArrowDog
    dw $3800, $6BFF, $3416, $0800 ; id 88 NoctoKing
    dw $0000, $7FFF, $1CFF, $0800 ; id 89 BeastNite
    dw $0000, $6BFF, $7A87, $0800 ; id 90 MadGopher
    dw $0000, $1B9F, $753C, $0800 ; id 91 FairyRat
    dw $0000, $6BFF, $5A17, $0800 ; id 92 Unicorn
    dw $0000, $1B9F, $75A0, $0800 ; id 93 Goategon
    dw $0000, $075F, $6475, $0800 ; id 94 WildApe
    dw $0000, $7C1F, $76F0, $0800 ; id 95 Trumpeter
    dw $0000, $6BFF, $7EE4, $0800 ; id 96 KingLeo
    dw $0000, $02BF, $7EDC, $0800 ; id 97 DarkHorn
    dw $0000, $03BF, $01BF, $0800 ; id 98 MadCat
    dw $0000, $6BFF, $01D8, $0800 ; id 99 BigEye
    dw $0000, $7FFF, $027D, $0800 ; id 100 Gorago
    dw $0000, $4E52, $01D8, $0800 ; id 101 CatMage
    dw $0000, $025F, $451E, $0800 ; id 102 Dumbira
    dw $0000, $7F00, $021A, $0800 ; id 103 ?
    dw $0000, $7F00, $021A, $0800 ; id 104 ?
    dw $0000, $7F00, $021A, $0800 ; id 105 ?
    dw $0000, $201F, $02FE, $0800 ; id 106 Picky
    dw $0000, $5EF8, $011B, $0800 ; id 107 Wyvern
    dw $0000, $03DF, $2CC6, $0800 ; id 108 BullBird
    dw $0000, $7D10, $1857, $0800 ; id 109 Florajay
    dw $0000, $6BFF, $3C9F, $0800 ; id 110 DuckKite
    dw $0000, $7C1F, $01FF, $0800 ; id 111 MadPecker
    dw $0000, $7DD6, $02BB, $0800 ; id 112 MadRaven
    dw $0000, $077F, $00DF, $0800 ; id 113 MistyWing
    dw $0000, $7EE0, $02BF, $0800 ; id 114 AquaHawk
    dw $0000, $6BFF, $007B, $0800 ; id 115 Dracky
    dw $0000, $03E0, $540E, $0800 ; id 116 KiteHawk
    dw $0000, $37DF, $3037, $0800 ; id 117 BigRoost
    dw $0000, $0FBF, $7DE0, $0800 ; id 118 StubBird
    dw $0000, $6BFF, $483B, $0800 ; id 119 LandOwl
    dw $0000, $0218, $0FBF, $0800 ; id 120 MadGoose
    dw $0000, $51F8, $6BFF, $0800 ; id 121 MadCondor
    dw $0000, $009F, $7D40, $0800 ; id 122 Emyu
    dw $0000, $66D4, $6BFF, $0800 ; id 123 Blizzardy
    dw $0000, $179F, $00BB, $0800 ; id 124 Phoenix
    dw $0000, $03FD, $7D2F, $0800 ; id 125 ZapBird
    dw $0000, $037F, $6566, $0800 ; id 126 Garudian
    dw $0000, $179F, $0033, $0800 ; id 127 WhipBird
    dw $0000, $179F, $7F69, $0800 ; id 128 FunkyBird
    dw $0000, $179F, $3C1F, $0800 ; id 129 RainHawk
    dw $0000, $039F, $1FD3, $0800 ; id 130 Azurile
    dw $0000, $039F, $5CEF, $0800 ; id 131 Shantak
    dw $0000, $077F, $7EA0, $0800 ; id 132 CragDevil
    dw $0000, $201F, $02FE, $0800 ; id 133 ?
    dw $0000, $201F, $02FE, $0800 ; id 134 ?
    dw $0000, $201F, $02FE, $0800 ; id 135 ?
    dw $0000, $201F, $02FE, $0800 ; id 136 ?
    dw $0000, $201F, $02FE, $0800 ; id 137 ?
    dw $0000, $201F, $02FE, $0800 ; id 138 ?
    dw $0000, $201F, $02FE, $0800 ; id 139 ?
    dw $0000, $201F, $02FE, $0800 ; id 140 ?
    dw $0000, $031E, $038D, $0800 ; id 141 MadPlant
    dw $0000, $7D35, $2FEB, $0800 ; id 142 FireWeed
    dw $0000, $7F4F, $60B2, $0800 ; id 143 FloraMan
    dw $0000, $640E, $02F1, $0800 ; id 144 WingTree
    dw $0000, $6BFF, $032A, $0800 ; id 145 CactiBall
    dw $0000, $6BFF, $038D, $0800 ; id 146 Gulpple
    dw $0000, $6BFF, $6891, $0800 ; id 147 Toadstool
    dw $0000, $7E19, $01FF, $0800 ; id 148 AmberWeed
    dw $0000, $6BFF, $0320, $0800 ; id 149 Slurperon
    dw $0000, $6BFF, $0110, $0800 ; id 150 Stubsuck
    dw $0000, $02DF, $02ED, $0800 ; id 151 Oniono
    dw $0000, $0360, $025F, $0800 ; id 152 DanceVegi
    dw $0000, $6FF1, $012F, $0800 ; id 153 TreeBoy
    dw $0000, $6BFF, $0115, $0800 ; id 154 Devipine
    dw $0000, $001F, $0217, $0800 ; id 155 FaceTree
    dw $0000, $02C0, $0217, $0800 ; id 156 HerbMan
    dw $0000, $033F, $032C, $0800 ; id 157 BeanMan
    dw $0000, $6BFF, $021F, $0800 ; id 158 EvilSeed
    dw $0000, $03AA, $005B, $0800 ; id 159 ManEater
    dw $0000, $6BFF, $01C8, $0800 ; id 160 Snapper
    dw $0000, $6BFF, $2A16, $0800 ; id 161 GhosTree
    dw $0000, $001F, $036C, $0800 ; id 162 Rosevine
    dw $0000, $036C, $296D, $0800 ; id 163 Egdracil
    dw $0000, $6E5F, $6017, $0800 ; id 164 Warubou
Data_027_7850:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $7FB5, $7EA6, $0800 ; id 165 Watabou
    dw $0000, $7FFF, $6CD6, $0800 ; id 166 Eggplaton
    dw $0000, $02FF, $024A, $0800 ; id 167 FooHero
    dw $0000, $031E, $038D, $0800 ; id 168 ?
    dw $0000, $031E, $038D, $0800 ; id 169 ?
    dw $0000, $031E, $038D, $0800 ; id 170 ?
    dw $0000, $031E, $038D, $0800 ; id 171 ?
    dw $0000, $031E, $038D, $0800 ; id 172 ?
    dw $0000, $031E, $038D, $0800 ; id 173 ?
    dw $0000, $031E, $038D, $0800 ; id 174 ?
    dw $0000, $031E, $038D, $0800 ; id 175 ?
    dw $0000, $475F, $0275, $0800 ; id 176 GiantSlug
    dw $0000, $7DDF, $034B, $0800 ; id 177 Catapila
    dw $0000, $371F, $01DC, $0800 ; id 178 Gophecada
    dw $0000, $7FFF, $7CB7, $0800 ; id 179 Butterfly
    dw $0000, $63F4, $36C0, $0800 ; id 180 WeedBug
    dw $0000, $729F, $3CFB, $0800 ; id 181 GiantWorm
    dw $0000, $4EFF, $034F, $0800 ; id 182 Lipsy
    dw $0000, $6980, $0258, $0800 ; id 183 StagBug
    dw $0000, $427F, $017F, $0800 ; id 184 Pyuro
    dw $0000, $7FFF, $3F01, $0800 ; id 185 ArmyAnt
    dw $0000, $7FFF, $029D, $0800 ; id 186 GoHopper
    dw $0000, $3EB8, $3538, $0800 ; id 187 TailEater
    dw $0000, $7FFF, $013F, $0800 ; id 188 ArmorPede
    dw $0000, $7FFF, $027F, $0800 ; id 189 Eyeder
    dw $0000, $1B5D, $0278, $0800 ; id 190 GiantMoth
    dw $0000, $627F, $3157, $0800 ; id 191 Droll
    dw $0000, $7FFF, $01BF, $0800 ; id 192 ArmyCrab
    dw $0000, $7FFF, $021D, $0800 ; id 193 MadHornet
    dw $0000, $037F, $601A, $0800 ; id 194 Belzebub
    dw $0000, $037F, $0208, $0800 ; id 195 WarMantis
    dw $0000, $0218, $00D0, $0800 ; id 196 HornBeet
    dw $0000, $6BFF, $2BE0, $0800 ; id 197 Sickler
    dw $0000, $6BFF, $017D, $0800 ; id 198 Armorpion
    dw $0000, $6BFF, $04BD, $0800 ; id 199 Digster
    dw $0000, $6BFF, $541F, $0800 ; id 200 Skularach
    dw $0000, $7FFF, $017D, $0800 ; id 201 MultiEyes
    dw $0000, $475F, $0275, $0800 ; id 202 ?
    dw $0000, $475F, $0275, $0800 ; id 203 ?
    dw $0000, $475F, $0275, $0800 ; id 204 ?
    dw $0000, $475F, $0275, $0800 ; id 205 ?
    dw $0000, $475F, $0275, $0800 ; id 206 ?
    dw $0000, $475F, $0275, $0800 ; id 207 ?
    dw $0000, $475F, $0275, $0800 ; id 208 ?
    dw $0000, $475F, $0275, $0800 ; id 209 ?
    dw $0000, $475F, $0275, $0800 ; id 210 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 211 Pixy
    dw $0000, $6BFF, $7A00, $0800 ; id 212 MedusaEye
    dw $0000, $6BFF, $7EE7, $0800 ; id 213 AgDevil
    dw $0000, $6BFF, $023F, $0800 ; id 214 Demonite
    dw $0000, $6BFF, $7D57, $0800 ; id 215 DarkEye
    dw $0000, $6BFF, $7EA4, $0800 ; id 216 EyeBall
    dw $0000, $6BFF, $029F, $0800 ; id 217 SkulRider
    dw $0000, $6BFF, $6A18, $0800 ; id 218 EvilBeast
    dw $0000, $6BFF, $170E, $0800 ; id 219 Bubblemon
    dw $0000, $179F, $009B, $0800 ; id 220 1EyeClown
    dw $0000, $71BC, $179F, $0800 ; id 221 Gremlin
    dw $0000, $179F, $64B9, $0800 ; id 222 ArcDemon
    dw $0000, $6BFF, $023C, $0800 ; id 223 Lionex
    dw $0000, $6BFF, $011C, $0800 ; id 224 GoatHorn
    dw $0000, $6BFF, $025D, $0800 ; id 225 Orc
    dw $0000, $6BFF, $0F68, $0800 ; id 226 Ogre
    dw $0000, $179F, $5917, $0800 ; id 227 GateGuard
    dw $0000, $6BFF, $7D8E, $0800 ; id 228 ChopClown
    dw $0000, $6BFF, $032B, $0800 ; id 229 BossTroll
    dw $0000, $6BFF, $7EA0, $0800 ; id 230 Grendal
    dw $0000, $6BFF, $029F, $0800 ; id 231 Akubar
    dw $0000, $6BFF, $3544, $0800 ; id 232 MadKnight
    dw $0000, $6BFF, $001B, $0800 ; id 233 EvilWell
    dw $0000, $6BE0, $6580, $0800 ; id 234 Gigantes
    dw $0000, $0F7F, $7720, $0800 ; id 235 Centasaur
    dw $0000, $6BFF, $001D, $0800 ; id 236 EvilArmor
    dw $0000, $179F, $5A53, $0800 ; id 237 Jamirus
    dw $0000, $6BFF, $01DF, $0800 ; id 238 Durran
    dw $0000, $6BFF, $3C73, $0800 ; id 239 Titanis
    dw $0000, $6BFF, $748F, $0800 ; id 240 LampGenie
    dw $0000, $6BFF, $7DC0, $0800 ; id 241 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 242 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 243 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 244 ?
    dw $0000, $6BFF, $7DC0, $0800 ; id 245 ?
    dw $0000, $029F, $011E, $0800 ; id 246 Spooky
    dw $0000, $42DC, $1992, $0800 ; id 247 Skullgon
    dw $0000, $7FFF, $7A20, $0800 ; id 248 PutrePup
    dw $0000, $531E, $4472, $0800 ; id 249 RotRaven
    dw $0000, $7E7F, $70F5, $0800 ; id 250 Mummy
    dw $0000, $7FFF, $5CCA, $0800 ; id 251 DarkCrab
    dw $0000, $7FFF, $0196, $0800 ; id 252 DeadNite
    dw $0000, $02BF, $420B, $0800 ; id 253 Shadow
    dw $0000, $6BFF, $601A, $0800 ; id 254 Skulpent
    dw $0000, $7FFF, $0196, $0800 ; id 255 Hork
    dw $0000, $03BF, $0219, $0800 ; id 256 Mudron
    dw $0000, $33FF, $027C, $0800 ; id 257 NiteWhip
    dw $0000, $03FF, $7F46, $0800 ; id 258 WindMerge
    dw $0000, $6ABF, $021D, $0800 ; id 259 Reaper
    dw $0000, $7F00, $2A16, $0800 ; id 260 Inverzon
    dw $0000, $7F00, $7D80, $0800 ; id 261 FoxFire
    dw $0000, $6BFF, $001D, $0800 ; id 262 CaptDead
    dw $0000, $7FFF, $7D88, $0800 ; id 263 DeadNoble
    dw $0000, $7E5F, $447B, $0800 ; id 264 WhiteKing
    dw $0000, $3F1C, $017E, $0800 ; id 265 BoneSlave
    dw $0000, $7FFF, $7571, $0800 ; id 266 Skeletor
    dw $0000, $7FFF, $28D0, $0800 ; id 267 Servant
    dw $0000, $007F, $7C15, $0800 ; id 268 Lazamanus
    dw $0000, $035F, $021C, $0800 ; id 269 Copycat
    dw $0000, $7FFF, $68F8, $0800 ; id 270 MadSpirit
    dw $0000, $02DD, $501F, $0800 ; id 271 PomPomBom
    dw $0000, $135F, $3C1D, $0800 ; id 272 Niterich
    dw $0000, $029F, $011E, $0800 ; id 273 ?
    dw $0000, $029F, $011E, $0800 ; id 274 ?
    dw $0000, $029F, $011E, $0800 ; id 275 ?
    dw $0000, $029F, $011E, $0800 ; id 276 ?
    dw $0000, $029F, $011E, $0800 ; id 277 ?
    dw $0000, $029F, $011E, $0800 ; id 278 ?
    dw $0000, $029F, $011E, $0800 ; id 279 ?
    dw $0000, $029F, $011E, $0800 ; id 280 ?
    dw $0000, $33FF, $023F, $0800 ; id 281 JewelBag
    dw $0000, $4B7F, $021A, $0800 ; id 282 EvilWand
    dw $0000, $6BFF, $021F, $0800 ; id 283 MadCandle
    dw $0000, $033F, $01FD, $0800 ; id 284 CoilBird
    dw $0000, $439F, $190F, $0800 ; id 285 Facer
    dw $0000, $6BFF, $036D, $0800 ; id 286 SpikyBoy
    dw $0000, $439F, $1417, $0800 ; id 287 MadMirror
    dw $0000, $7ED9, $0038, $0800 ; id 288 RogueNite
    dw $0000, $3B5E, $170E, $0800 ; id 289 Puppetor
    dw $0000, $3B5E, $025C, $0800 ; id 290 Goopi
    dw $0000, $03FF, $5815, $0800 ; id 291 Voodoll
    dw $0000, $6BFF, $7F54, $0800 ; id 292 MetalDrak
    dw $0000, $03FF, $38ED, $0800 ; id 293 Balzak
    dw $0000, $6BFF, $7F0B, $0800 ; id 294 SabreMan
    dw $0000, $6BFF, $02BF, $0800 ; id 295 CurseLamp
    dw $0000, $3B5E, $0160, $0800 ; id 296 Brushead
    dw $0000, $6BFF, $7EC5, $0800 ; id 297 Roboster
    dw $0000, $6BFF, $7DC0, $0800 ; id 298 Roboster2
    dw $0000, $7D9F, $025C, $0800 ; id 299 EvilPot
    dw $0000, $6BFF, $4DCD, $0800 ; id 300 Gismo
    dw $0000, $6BFF, $0018, $0800 ; id 301 LavaMan
    dw $0000, $6BFF, $7E09, $0800 ; id 302 IceMan
    dw $0000, $7F15, $59EC, $0800 ; id 303 Mimic
    dw $0000, $6BFF, $7EEC, $0800 ; id 304 Exaucers
    dw $0000, $1EBC, $01B7, $0800 ; id 305 MudDoll
    dw $0000, $6BFF, $025B, $0800 ; id 306 Golem
    dw $0000, $6BFF, $3A73, $0800 ; id 307 StoneMan
    dw $0000, $6BFF, $6186, $0800 ; id 308 BombCrag
    dw $0000, $6BFF, $02FF, $0800 ; id 309 GoldGolem
    dw $0000, $00DF, $7969, $0800 ; id 310 DarkMate
    dw $0000, $7FFF, $7D00, $0800 ; id 311 ProtoMech
    dw $0000, $7FFF, $7E87, $0800 ; id 312 CloudKing
    dw $0000, $33FF, $023F, $0800 ; id 313 ?
    dw $0000, $33FF, $023F, $0800 ; id 314 ?
    dw $0000, $33FF, $023F, $0800 ; id 315 ?
    dw $0000, $6BFF, $6C17, $0800 ; id 316 Petiteel
    dw $0000, $7D80, $023F, $0800 ; id 317 Moray
    dw $0000, $6BFF, $169F, $0800 ; id 318 WalrusMan
    dw $0000, $6BFF, $1C1C, $0800 ; id 319 RayGigas
    dw $0000, $6BFF, $0099, $0800 ; id 320 Anemon
    dw $0000, $6BFF, $5413, $0800 ; id 321 Aquarella
    dw $0000, $6BFF, $65AB, $0800 ; id 322 Merman
    dw $0000, $6BFF, $493F, $0800 ; id 323 Octokid
    dw $0000, $7FFF, $24D3, $0800 ; id 324 PutreFish
    dw $0000, $033F, $7230, $0800 ; id 325 Octoreach
    dw $0000, $6BFF, $2552, $0800 ; id 326 Angleron
    dw $0000, $6BFF, $7F00, $0800 ; id 327 FishRider
    dw $0000, $6BFF, $60A3, $0800 ; id 328 RushFish
    dw $0000, $6BFF, $007F, $0800 ; id 329 Gamanian
    dw $0000, $6BFF, $027B, $0800 ; id 330 Clawster
    dw $0000, $6BFF, $017F, $0800 ; id 331 CancerMan
    dw $0000, $6BFF, $5182, $0800 ; id 332 RogueWave
    dw $0000, $6BFF, $74DB, $0800 ; id 333 Scallopa
    dw $0000, $6BFF, $5413, $0800 ; id 334 SeaHorse
    dw $0000, $6BE8, $281B, $0800 ; id 335 HoodSquid
    dw $0000, $6BFF, $02FF, $0800 ; id 336 MerTiger
    dw $0000, $6BFF, $7E40, $0800 ; id 337 AxeShark
    dw $0000, $6BFF, $7DCD, $0800 ; id 338 Octogon
    dw $0000, $6BFF, $7D5A, $0800 ; id 339 KingSquid
    dw $0000, $6BFF, $021F, $0800 ; id 340 Digong
    dw $0000, $6BFF, $5413, $0800 ; id 341 WhaleMage
    dw $0000, $037F, $69EE, $0800 ; id 342 Aquadon
    dw $0000, $039F, $005B, $0800 ; id 343 Octoraid
    dw $0000, $03DF, $0AC3, $0800 ; id 344 Grakos
    dw $0000, $6BFF, $0320, $0800 ; id 345 Poseidon
    dw $0000, $7FFF, $0240, $0800 ; id 346 Pumpoise
    dw $0000, $56A0, $1859, $0800 ; id 347 Starfish
    dw $0000, $6BFF, $6C17, $0800 ; id 348 ?
    dw $0000, $6BFF, $6C17, $0800 ; id 349 ?
    dw $0000, $6BFF, $6C17, $0800 ; id 350 ?
    dw $0000, $6BFF, $4414, $0800 ; id 351 DracoLord
    dw $0000, $019F, $6C73, $0800 ; id 352 DracoLord
    dw $0000, $6BFF, $653B, $0800 ; id 353 LordDraco
    dw $0000, $6BFF, $6C1A, $0800 ; id 354 Hargon
    dw $0000, $019F, $7E20, $0800 ; id 355 Sidoh
    dw $0000, $02BF, $51D4, $0800 ; id 356 Genosidoh
    dw $0000, $03E9, $6939, $0800 ; id 357 Baramos
    dw $0000, $6BFF, $015C, $0800 ; id 358 Zoma
    dw $0000, $6BFF, $75A0, $0800 ; id 359 AsuraZoma
    dw $0000, $6BFF, $0E71, $0800 ; id 360 Pizzaro
    dw $0000, $03E9, $60DD, $0800 ; id 361 PsychoPiz
    dw $0000, $6BFF, $00BF, $0800 ; id 362 Esterk
    dw $0000, $6BFF, $0310, $0800 ; id 363 Mirudraas
    dw $0000, $6BFF, $493F, $0800 ; id 364 Mirudraas
    dw $0000, $325F, $02E0, $0800 ; id 365 Mudou
    dw $0000, $6BFF, $493F, $0800 ; id 366 DeathMore
    dw $0000, $6BFF, $493F, $0800 ; id 367 DeathMore
    dw $0000, $03FF, $493F, $0800 ; id 368 DeathMore
    dw $0000, $425A, $0553, $0800 ; id 369 Darkdrium
    dw $0000, $6F7B, $480D, $0800 ; id 370 Orgodemir
    dw $0000, $6F7B, $3EA8, $0800 ; id 371 Orgodemir
    dw $0000, $6BFF, $021F, $0800 ; id 372 Darck
    dw $0000, $6BFF, $4414, $0800 ; id 373 Tatsu
    dw $0000, $6BFF, $4414, $0800 ; id 374 Diago
    dw $0000, $6BFF, $4414, $0800 ; id 375 Samsi
    dw $0000, $6BFF, $4414, $0800 ; id 376 Bazoo
    dw $0000, $6BFF, $4414, $0800 ; id 377 ?
    dw $0000, $6BFF, $4414, $0800 ; id 378 ?
    dw $0000, $6BFF, $4414, $0800 ; id 379 ?
    dw $0000, $6BFF, $009F, $0800 ; id 380 Lamia
    dw $0000, $6BFF, $6F50, $0800 ; id 381 Dimensaur
    dw $0000, $331F, $021F, $0800 ; id 382 Kagebou
    dw $0000, $0000, $0000, $0000 ; id 383 ?
    ds $D8, $00
