SECTION "Bank 87", ROMX[$4000], BANK[$87]
    db $87

; 1 call site from 1 routine (e.g. Func_002_4AE0_Case00)
; reads: wC8CB, wC468, hFF8C, wC918, hMapId, hMapScreenX, hMapScreenY, wModeState, ...
; writes: wC918, wC916, wC917, wJoypadHeld, wJoypadPressed
Func_087_4001::
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wC918]
    or a, a
    ret nz
    inc a
    ld [wC918], a
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    ret z
    ld a, [hl]
    ld h, a
    ld l, e

Jump_087_4031::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    or a, a
    jr nz, Jump_087_4096
    inc hl
    ld a, [hl+]
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_087_4057
    inc hl
    jr Jump_087_4064

Jump_087_4057::
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_087_4096
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_087_4096

Jump_087_4064::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    cp a, e
    jr nz, Jump_087_4071
    cp a, $FF
    jr nz, Jump_087_4071
    inc hl
    jr Jump_087_4078

Jump_087_4071::
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr c, Jump_087_4096

Jump_087_4078::
    ld a, [hl+]
    ld [wC916], a
    ld a, [hl]
    ld [wC917], a
    farcall Func_013_405C
    ld a, [wModeState]
    cp a, $01
    jr nz, Jump_087_4094
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

Jump_087_4094::
    pop hl
    ret

Jump_087_4096::
    pop hl
    ld a, $0A
    add_a_to_hl
    jr Jump_087_4031
    db $33, $5D, $48, $5D, $71, $5D, $00, $00, $86, $5D, $9B, $5D, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $BA, $5D
    ds $18, $00
    db $D9, $5D, $E4, $5D, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $EF, $5D
    ds $12, $00
    db $FA, $5D, $00, $00, $00, $00, $00, $00, $00, $00, $05, $5E, $00, $00, $00, $00
    db $00, $00, $24, $5E, $00, $00, $00, $00, $00, $00, $00, $00, $2F, $5E, $44, $5E
    db $4F, $5E, $5A, $5E
    ds $20, $00
    db $65, $5E
    ds $1C, $00
    db $70, $5E, $00, $00, $7B, $5E
    ds $12, $00
    db $90, $5E
    ds $1C, $00
    db $A5, $5E, $00, $00, $00, $00, $00, $00, $B0, $5E, $00, $00, $00, $00, $00, $00
    db $00, $00, $BB, $5E
    ds $1A, $00
    db $C6, $5E, $00, $00, $00, $00, $00, $00, $00, $00, $EF, $5E
    ds $10, $00
    db $FA, $5E
    ds $1C, $00
    db $05, $5F, $00, $00, $1A, $5F
    ds $A6, $00

; 2 call sites from 2 routines (e.g. Func_002_4AE0_Case00, Func_002_4AE0_Case05)
; reads: wC8CB, wC468, hFF8C, wJoypadPressed, wSpriteSlotCount, hPlayerX, hPlayerY, hPlayerFacing, ...
; writes: wC916, wC917, wJoypadHeld, wJoypadPressed
Func_087_42A0::
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wSpriteSlotCount]
    or a, a
    jp z, Jump_087_43FC
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_087_42D2
    dec a
    jr z, Jump_087_42D8
    dec a
    jr z, Jump_087_42DE
    dec b
    jr Jump_087_42DF

Jump_087_42D2::
    ld a, c
    add a, $11
    ld c, a
    jr Jump_087_42DF

Jump_087_42D8::
    ld a, b
    add a, $11
    ld b, a
    jr Jump_087_42DF

Jump_087_42DE::
    dec c

Jump_087_42DF::
    call Func_087_4709
    or a, a
    jp z, Jump_087_43FC
    dec a
    ld c, $10
    call Multiply8
    ld a, l
    add a, $7F
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_087_432B
    push hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_087_430E
    ld a, $0A
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_087_430E
    pop hl
    jp Jump_087_43FC

Jump_087_430E::
    pop hl
    push hl
    ld a, $0B
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    jr z, Jump_087_4320
    pop hl
    jp Jump_087_43FC

Jump_087_4320::
    inc hl
    ld a, [hl]
    and a, $0F
    jr z, Jump_087_432A
    pop hl
    jp Jump_087_43FC

Jump_087_432A::
    pop hl

Jump_087_432B::
    ld a, $09
    add_a_to_hl
    xor a, a
    ld [hl], a
    dec hl
    dec hl
    ldh a, [hPlayerFacing]
    add a, $02
    and a, $03
    ld [hl], a
    ld a, $08
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_087_4351
    ld a, $08
    ld [wC917], a
    jp Jump_087_43DC

Jump_087_4351::
    cp a, $FE
    jr nz, Jump_087_4360
    ld a, $09
    ld [wC917], a
    xor a, a
    ld [wC916], a
    jr Jump_087_43DC

Jump_087_4360::
    cp a, $FC
    jr nz, Jump_087_4370
    ld a, $09
    ld [wC917], a
    ld a, $02
    ld [wC916], a
    jr Jump_087_43DC

Jump_087_4370::
    cp a, $FB
    jr nz, Jump_087_4380
    ld a, $09
    ld [wC917], a
    ld a, $03
    ld [wC916], a
    jr Jump_087_43DC

Jump_087_4380::
    cp a, $FA
    jr nz, Jump_087_4390
    ld a, $09
    ld [wC917], a
    ld a, $08
    ld [wC916], a
    jr Jump_087_43DC

Jump_087_4390::
    ld [wC916], a
    ldh a, [hMapId]
    cp a, $20
    jr nc, Jump_087_43A0
    ld a, $01
    ld [wC917], a
    jr Jump_087_43DC

Jump_087_43A0::
    cp a, $30
    jr nc, Jump_087_43AB
    ld a, $02
    ld [wC917], a
    jr Jump_087_43DC

Jump_087_43AB::
    cp a, $48
    jr nc, Jump_087_43B6
    ld a, $03
    ld [wC917], a
    jr Jump_087_43DC

Jump_087_43B6::
    cp a, $70
    jr nc, Jump_087_43C1
    ld a, $04
    ld [wC917], a
    jr Jump_087_43DC

Jump_087_43C1::
    cp a, $A0
    jr nc, Jump_087_43CC
    ld a, $05
    ld [wC917], a
    jr Jump_087_43DC

Jump_087_43CC::
    cp a, $A8
    jr nc, Jump_087_43D7
    ld a, $06
    ld [wC917], a
    jr Jump_087_43DC

Jump_087_43D7::
    ld a, $07
    ld [wC917], a

Jump_087_43DC::
    farcall Func_013_405C
    ld a, [wModeState]
    cp a, $01
    ret nz
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wC8CD]
    bit 7, a
    ret z
    farcall Func_002_5B9E
    ret

Jump_087_43FC::
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_087_440A
    call Func_087_4507
    or a, a
    jr nz, Jump_087_4420
    ret

Jump_087_440A::
    ldh a, [hMapId]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $39
    ld l, a
    ld a, h
    adc a, $45
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    or a, e
    ret z
    ld a, [hl]
    ld h, a
    ld l, e

Jump_087_4420::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    or a, a
    jp z, Jump_087_44FC
    cp a, $05
    jr nz, Jump_087_4489
    inc hl
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_087_443D
    ld a, [hl]
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jp nz, Jump_087_44FC

Jump_087_443D::
    inc hl
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerFacing]
    dec a
    jp nz, Jump_087_445D
    ld a, c
    sub a, $10
    ld c, a
    jp Jump_087_4466

Jump_087_445D::
    dec a
    dec a
    jp nz, Jump_087_4466
    ld a, c
    add a, $10
    ld c, a

Jump_087_4466::
    ldh a, [hPlayerX]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr nz, Jump_087_4479
    ld a, c
    sub a, $10
    ld c, a
    jr Jump_087_4481

Jump_087_4479::
    dec a
    dec a
    jr nz, Jump_087_4481
    ld a, c
    add a, $10
    ld c, a

Jump_087_4481::
    ldh a, [hPlayerY]
    cp a, c
    jp nz, Jump_087_44FC
    jr Jump_087_44BD

Jump_087_4489::
    dec a
    ld c, a
    ldh a, [hPlayerFacing]
    cp a, c
    jr nz, Jump_087_44FC
    inc hl
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_087_449F
    ld a, [hl]
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jr nz, Jump_087_44FC

Jump_087_449F::
    inc hl
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jp nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_087_44FC
    ld a, [hl+]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_087_44FC

Jump_087_44BD::
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    cp a, e
    jr nz, Jump_087_44CA
    cp a, $FF
    jr nz, Jump_087_44CA
    inc hl
    jr Jump_087_44D1

Jump_087_44CA::
    ld a, [hl+]
    ld d, a
    call TestFlagBit
    jr c, Jump_087_44FC

Jump_087_44D1::
    ld a, [hl+]
    ld [wC916], a
    ld a, [hl]
    ld [wC917], a
    farcall Func_013_405C
    ld a, [wModeState]
    cp a, $01
    jr nz, Jump_087_44FC
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wC8CD]
    bit 7, a
    jr z, Jump_087_44FA
    farcall Func_002_5B9E

Jump_087_44FA::
    pop hl
    ret

Jump_087_44FC::
    pop hl
    ld a, $0A
    add_a_to_hl
    jp Jump_087_4420

; 1 call site from 1 routine (e.g. Func_087_42A0)
; reads: wCC45
; points at: wCD89
Func_087_4507::
    cp a, $84
    jr nz, Jump_087_4511
    ld hl, Data_087_5D28
    ld a, $01
    ret

Jump_087_4511::
    cp a, $83
    jr nz, Jump_087_4537
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    cp a, $02
    jr nz, Jump_087_452D
    ld hl, Data_087_5CA4
    ld a, $01
    ret

Jump_087_452D::
    cp a, $03
    jr nz, Jump_087_4537
    ld hl, Data_087_5CFF
    ld a, $01
    ret

Jump_087_4537::
    xor a, a
    ret
    db $51, $47, $7A, $47, $85, $47, $00, $00, $CD, $47, $00, $48
    dw Data_087_480B
    db $70, $48, $B7, $48
    dw Data_087_48CC
    db $00, $00, $00, $00
    dw Data_087_48EB
    db $0A, $49, $33, $49
    dw Data_087_4966
    db $A3, $49, $C2, $49
    dw Data_087_4A63
    db $8C, $4A, $00, $00
    dw Data_087_4AAB
    db $10, $4B, $43, $4B
    dw Data_087_4B4E
    db $8B, $4B, $18, $4C
    dw Data_087_4C2D
    db $00, $00, $42, $4C, $00, $00, $00, $00, $00, $00, $93, $4C
    dw Data_087_4CA8
    db $BD, $4C, $C8, $4C
    dw Data_087_4CFB
    db $00, $00, $00, $00
    dw Data_087_4D06
    db $00, $00, $25, $4D
    dw Data_087_4D3A
    db $00, $00, $8B, $4D
    dw Data_087_4DAA
    db $00, $00, $00, $00
    dw Data_087_4DD3
    db $24, $4E, $61, $4E
    dw Data_087_4E6C
    db $77, $4E, $00, $00
    dw Data_087_4EB4
    db $00, $00, $05, $4F
    dw Data_087_4F38
    db $4D, $4F, $58, $4F
    dw Data_087_4F77
    db $A0, $4F, $00, $00
    dw Data_087_4FAB
    db $00, $00, $C0, $4F
    dw Data_087_4FF3
    INCBIN "dwm2-cobi-us.gbc", $21C5C1, $48
    ds $12, $00
    INCBIN "dwm2-cobi-us.gbc", $21C61B, $EE

; 1 call site from 1 routine (e.g. Func_087_42A0)
; reads: wSpriteSlotCount, hFFC7, hFFC6
; writes: hFFC6, hFFC7
; points at: wCB8A
Func_087_4709::
    ld a, [wSpriteSlotCount]
    or a, a
    ret z
    ld a, c
    swap a
    and a, $0F
    ldh [hFFC6], a
    ld a, b
    swap a
    and a, $0F
    ldh [hFFC7], a
    ld a, [wSpriteSlotCount]
    ld b, a
    ld c, $01
    ld hl, wCB8A

Jump_087_4725::
    push hl
    push bc
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_087_473E
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr z, Jump_087_474D

Jump_087_473E::
    pop bc
    inc c
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_087_4725
    xor a, a
    ret

Jump_087_474D::
    pop bc
    pop hl
    ld a, c
    ret
    INCBIN "dwm2-cobi-us.gbc", $21C751, $BA

Data_087_480B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21C80B, $C1

Data_087_48CC:: ; heuristic: target of a monotone pointer table; C0
    db $03, $09, $00, $00, $20, $30, $FF, $FF, $C5, $01, $05, $09, $00, $00, $60, $20
    db $FF, $FF, $C6, $01, $03, $09, $00, $00, $70, $30, $FF, $FF, $C7, $01, $FF

Data_087_48EB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21C8EB, $7B

Data_087_4966:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21C966, $FD

Data_087_4A63:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CA63, $48

Data_087_4AAB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CAAB, $A3

Data_087_4B4E:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CB4E, $DF

Data_087_4C2D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CC2D, $7B

Data_087_4CA8:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CCA8, $53

Data_087_4CFB:: ; heuristic: target of a monotone pointer table; C0
    db $03, $25, $01, $00, $50, $10, $FF, $FF, $2A, $02, $FF

Data_087_4D06:: ; heuristic: target of a monotone pointer table; C0
    db $05, $28, $00, $00, $30, $10, $FF, $FF, $40, $02, $05, $28, $00, $00, $20, $30
    db $FF, $FF, $40, $02, $05, $28, $00, $00, $60, $40, $FF, $FF, $40, $02, $FF, $02
    db $2A, $00, $00, $70, $60, $FF, $FF, $42, $02, $02, $2A, $00, $00, $70, $70, $FF
    db $FF, $3F, $02, $FF

Data_087_4D3A:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CD3A, $70

Data_087_4DAA:: ; heuristic: target of a monotone pointer table; C0
    db $04, $2E, $00, $00, $40, $20, $FF, $FF, $3E, $02, $03, $2E, $00, $00, $40, $20
    db $FF, $FF, $3E, $02, $02, $2E, $00, $00, $50, $20, $FF, $FF, $3E, $02, $03, $2E
    db $00, $00, $50, $20, $FF, $FF, $3E, $02, $FF

Data_087_4DD3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CDD3, $99

Data_087_4E6C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CE6C, $48

Data_087_4EB4:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CEB4, $84

Data_087_4F38:: ; heuristic: target of a monotone pointer table; C0
    db $05, $3A, $00, $00, $40, $50, $FF, $FF, $5A, $03, $05, $3A, $00, $00, $50, $50
    db $FF, $FF, $5B, $03, $FF, $05, $3B, $00, $00, $70, $70, $FF, $FF, $6B, $03, $FF
    db $04, $3C, $00, $00, $50, $40, $FF, $FF, $3D, $03, $03, $3C, $01, $00, $40, $50
    db $FF, $FF, $18, $03, $03, $3C, $02, $00, $70, $60, $FF, $FF, $19, $03, $FF

Data_087_4F77:: ; heuristic: target of a monotone pointer table; C0
    db $03, $3D, $00, $00, $70, $30, $FF, $FF, $14, $03, $01, $3D, $00, $00, $30, $60
    db $FF, $FF, $59, $03, $01, $3D, $00, $00, $40, $60, $FF, $FF, $59, $03, $01, $3D
    db $00, $00, $50, $60, $FF, $FF, $59, $03, $FF, $05, $3E, $01, $01, $60, $30, $FF
    db $FF, $4E, $03, $FF

Data_087_4FAB:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CFAB, $48

Data_087_4FF3:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $21CFF3, $CB1

Data_087_5CA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $21DCA4, $5B

Data_087_5CFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $00, $00, $00, $40, $30, $FF, $FF, $04, $09, $05, $00, $00, $00, $60, $30
    db $FF, $FF, $05, $09, $05, $00, $00, $00, $80, $30, $FF, $FF, $04, $09, $05, $00
    db $01, $00, $10, $20, $FF, $FF, $04, $09, $FF

Data_087_5D28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $21DD28, $1FD
    ds $20DB, $00
