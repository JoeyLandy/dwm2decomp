SECTION "Bank 39", ROMX[$4000], BANK[$39]
    db $39

Func_039_4001::
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_400D
    inc h

Jump_039_400D::
    ld a, [hl]
    ld [$D8A6], a
    ld c, a
    ld b, $00
    ld a, [$D8A4]
    ld hl, $DA53
    add a, l
    ld l, a
    jr nc, Jump_039_401F
    inc h

Jump_039_401F::
    ld a, [hl]
    ld hl, Data_039_41AC
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_402A
    inc h

Jump_039_402A::
    ld a, [$C58A]
    or a, a
    jr z, Jump_039_4037
    cp a, $02
    jr z, Jump_039_4037
    xor a, a
    jr Jump_039_403D

Jump_039_4037::
    ld a, [$D8A4]
    and a, $04
    rrca

Jump_039_403D::
    add a, l
    ld l, a
    jr nc, Jump_039_4042
    inc h

Jump_039_4042::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    add hl, bc
    add hl, bc
    call Func_000_000B
    ret

Func_039_404B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    jp Jump_039_417C

Func_039_4055:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    add a, a
    ld hl, $DA2D
    add a, l
    ld l, a
    jr nc, Jump_039_4061
    inc h

Jump_039_4061::
    ld a, [hl]
    ld c, a
    call Func_000_3E54
    jr nc, Jump_039_406A
    jr Func_039_404B

Jump_039_406A::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_4076
    inc h

Jump_039_4076::
    ld [hl], c
    ret

Func_039_4078:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

Jump_039_4082::
    ld a, c
    call Func_000_3E54
    jr nc, Jump_039_408C
    inc c
    dec b
    jr nz, Jump_039_4082

Jump_039_408C::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_4098
    inc h

Jump_039_4098::
    ld [hl], c
    ret
    db $FA, $A4, $D8, $E6, $04, $C3, $7C, $41

Func_039_40A2:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03

Jump_039_40AA::
    ld a, c
    call Func_000_3E54
    jr nc, Jump_039_40B4
    inc c
    dec b
    jr nz, Jump_039_40AA

Jump_039_40B4::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_40C0
    inc h

Jump_039_40C0::
    ld [hl], c
    ret

Func_039_40C2:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld d, c

Jump_039_40CB::
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_40D6
    ld d, c

Jump_039_40D6::
    inc c
    dec b
    jr nz, Jump_039_40CB
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_40E6
    inc h

Jump_039_40E6::
    ld [hl], d
    ret
    INCBIN "dwm2-cobi-us.gbc", $0E40E8, $43

Func_039_412B:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_4137
    inc h

Jump_039_4137::
    ld a, [$D8A4]
    ld [hl], a
    ret

Func_039_413C:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_4148
    inc h

Jump_039_4148::
    ld a, [$D8A4]
    and a, $04
    ld [hl], a
    ret

Func_039_414F:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld e, a

Jump_039_4153::
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $07
    cp a, e
    jr z, Jump_039_4153
    call Func_000_3E54
    jr c, Jump_039_4153
    and a, $03
    cp a, $03
    jr z, Jump_039_4153
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_4175
    inc h

Jump_039_4175::
    ld a, [$C5E7]
    and a, $07
    ld [hl], a
    ret

Jump_039_417C::
    ld c, a
    ld b, $03
    ld d, $FF

Jump_039_4181::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_419A
    ld a, d
    cp a, $FF
    jr nz, Jump_039_418F
    ld d, c
    jr Jump_039_419A

Jump_039_418F::
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_419A
    ld d, c

Jump_039_419A::
    inc c
    dec b
    jr nz, Jump_039_4181
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_41AA
    inc h

Jump_039_41AA::
    ld [hl], d
    ret

Data_039_41AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E41AC, $7E
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    INCBIN "dwm2-cobi-us.gbc", $0E4234, $96
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $4B, $40, $4B, $40, $4B, $40, $78, $40, $4B, $40, $78, $40, $4B, $40, $78, $40
    db $4B, $40, $2B, $41, $2B, $41, $2B, $41, $E8, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    INCBIN "dwm2-cobi-us.gbc", $0E4358, $9C
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    INCBIN "dwm2-cobi-us.gbc", $0E43FC, $96
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $4B, $40, $4B, $40, $4B, $40, $78, $40, $4B, $40, $78, $40, $4B, $40, $78, $40
    db $4B, $40, $2B, $41, $2B, $41, $2B, $41, $E8, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $4B, $40, $2B, $41, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $4B, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40, $4B, $40, $4B, $40, $4B, $40
    db $4B, $40, $78, $40, $78, $40, $4B, $40, $4B, $40, $78, $40, $A2, $40, $78, $40
    db $2B, $41, $A2, $40, $78, $40, $4B, $40, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw Func_039_6C75
    dw Func_039_6C75
    dw Func_039_6C75
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_6CE9
    dw Func_039_6CE9
    dw Func_039_6CE9
    dw Func_039_40C2
    dw Func_039_40C2
    dw Func_039_413C
    dw Func_039_6AFD
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_6B0A
    dw Func_039_40A2
    dw Func_039_6BB0
    db $78, $40, $5D, $6B, $A2, $40, $B6, $6B, $78, $40, $9A, $40, $78, $40, $91, $66
    db $78, $40, $2B, $41, $4B, $40, $78, $40, $78, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    db $4B, $40, $2B, $41, $2B, $41, $91, $66, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $4B, $40, $4B, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_414F
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $4B, $40, $4B, $40, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $4B, $40, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $E8, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw Func_039_6C75
    dw Func_039_6C75
    dw Func_039_6C75
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_6CE9
    dw Func_039_6CE9
    dw Func_039_6CE9
    dw Func_039_40C2
    dw Func_039_40C2
    dw Func_039_413C
    dw Func_039_6AFD
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_6B0A
    dw Func_039_40A2
    dw Func_039_6BB0
    db $78, $40, $5D, $6B, $A2, $40, $B6, $6B, $78, $40, $9A, $40, $78, $40, $91, $66
    db $78, $40, $2B, $41, $4B, $40, $78, $40, $00, $00, $00, $00
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    db $4B, $40, $2B, $41, $2B, $41, $91, $66, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $4B, $40, $4B, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_414F
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $4B, $40, $4B, $40, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $4B, $40, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $E8, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $4B, $40, $2B, $41, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_413C
    dw Func_039_40A2
    db $78, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5390
    dw Func_039_5F0E
    dw Func_039_5F0E
    dw Func_039_5F0E
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $03, $5E
    db $78, $40, $78, $40
    dw Func_039_5514
    dw Func_039_5514
    dw Func_039_5514
    dw Func_039_40A2
    dw Func_039_40A2
    db $E8, $40, $E8, $40, $E8, $40
    dw Func_039_569C
    dw Func_039_569C
    dw Func_039_413C
    dw Func_039_5716
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_5857
    dw Func_039_40A2
    dw Func_039_58B7
    db $78, $40, $6B, $59, $A2, $40, $11, $59, $78, $40, $D8, $57, $78, $40, $ED, $60
    db $78, $40, $2B, $41, $4B, $61, $78, $40, $78, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_5DBB
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_65CD
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $A5, $63, $78, $40, $78, $40, $78, $40, $5C, $65, $78, $40
    db $4B, $40, $4B, $40
    dw Func_039_61A1
    dw Func_039_62A3
    dw Func_039_6222
    dw Func_039_6324
    dw Func_039_5CBB
    dw Func_039_5C97
    dw Func_039_5C9D
    dw Func_039_5CA3
    dw Func_039_5CC1
    dw Func_039_5CC7
    dw Func_039_5CA9
    dw Func_039_5CAF
    dw Func_039_5CB5
    dw Func_039_64DB
    dw Func_039_5C43
    dw Func_039_5CCD
    dw Func_039_5D19
    dw Func_039_5BA5
    dw Func_039_5390
    dw Func_039_5390
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6416
    dw Func_039_412B
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_414F
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_6014
    dw Func_039_6014
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $F9, $5B, $F9, $5B, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $CB, $59, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5D67
    dw Func_039_5ADB
    dw Func_039_5B40
    db $78, $40, $67, $5D, $78, $40, $4B, $40, $78, $40
    dw Func_039_5A84
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5A27
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw Func_039_5F0E
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_5390
    db $78, $40, $78, $40, $90, $53, $90, $53, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $0E, $5F, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw Func_039_67AD
    dw Func_039_67AD
    dw Func_039_67AD
    dw Func_039_40A2
    dw Func_039_40A2
    db $E8, $40, $E8, $40, $E8, $40
    dw Func_039_6998
    dw Func_039_6998
    dw Func_039_413C
    dw Func_039_699B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_69A1
    dw Func_039_40A2
    dw Func_039_69A4
    db $78, $40, $AA, $69, $A2, $40, $A7, $69, $78, $40, $9E, $69, $78, $40, $91, $66
    db $78, $40, $2B, $41, $13, $6A, $78, $40, $00, $00, $00, $00
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_6A04
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $4B, $40, $4B, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_69E9
    dw Func_039_69C5
    dw Func_039_69CB
    dw Func_039_69D1
    dw Func_039_69EF
    dw Func_039_69F5
    dw Func_039_69D7
    dw Func_039_69DD
    dw Func_039_69E3
    dw Func_039_6691
    dw Func_039_69C2
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_414F
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $BF, $69, $BF, $69, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $AD, $69, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_69B6
    dw Func_039_69B9
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw Func_039_69B3
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_69B0
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_412B
    db $00, $00, $78, $40, $A2, $40, $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40
    db $2B, $41, $2B, $41, $78, $40, $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00
    db $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_413C
    dw Func_039_40A2
    db $78, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5390
    dw Func_039_5F0E
    dw Func_039_5F0E
    dw Func_039_5F0E
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $03, $5E
    db $78, $40, $78, $40
    dw Func_039_5514
    dw Func_039_5514
    dw Func_039_5514
    dw Func_039_40A2
    dw Func_039_40A2
    db $E8, $40, $E8, $40, $E8, $40
    dw Func_039_569C
    dw Func_039_569C
    dw Func_039_413C
    dw Func_039_5716
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_5857
    dw Func_039_40A2
    dw Func_039_58B7
    db $78, $40, $6B, $59, $A2, $40, $11, $59, $78, $40, $D8, $57, $78, $40, $ED, $60
    db $78, $40, $2B, $41, $4B, $61, $78, $40, $78, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_5DBB
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_65CD
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $A5, $63, $78, $40, $78, $40, $78, $40, $5C, $65, $78, $40
    db $4B, $40, $4B, $40
    dw Func_039_61A1
    dw Func_039_62A3
    dw Func_039_6222
    dw Func_039_6324
    dw Func_039_5CBB
    dw Func_039_5C97
    dw Func_039_5C9D
    dw Func_039_5CA3
    dw Func_039_5CC1
    dw Func_039_5CC7
    dw Func_039_5CA9
    dw Func_039_5CAF
    dw Func_039_5CB5
    dw Func_039_64DB
    dw Func_039_5C43
    dw Func_039_5CCD
    dw Func_039_5D19
    dw Func_039_5BA5
    dw Func_039_5390
    dw Func_039_5390
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6416
    dw Func_039_412B
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_414F
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_6014
    dw Func_039_6014
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $F9, $5B, $F9, $5B, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $CB, $59, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5D67
    dw Func_039_5ADB
    dw Func_039_5B40
    db $78, $40, $67, $5D, $78, $40, $4B, $40, $78, $40
    dw Func_039_5A84
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5A27
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw Func_039_5F0E
    dw Func_039_5390
    dw Func_039_5390
    dw Func_039_5390
    db $78, $40, $78, $40, $90, $53, $90, $53, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $90, $53, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $91, $66
    db $78, $40, $78, $40
    dw Func_039_67AD
    dw Func_039_67AD
    dw Func_039_67AD
    dw Func_039_40A2
    dw Func_039_40A2
    db $E8, $40, $E8, $40, $E8, $40
    dw Func_039_6998
    dw Func_039_6998
    dw Func_039_413C
    dw Func_039_699B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_69A1
    dw Func_039_40A2
    dw Func_039_69A4
    db $78, $40, $AA, $69, $A2, $40, $A7, $69, $78, $40, $9E, $69, $78, $40, $91, $66
    db $78, $40, $2B, $41, $13, $6A, $78, $40, $00, $00, $00, $00
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_6A04
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $91, $66, $78, $40, $78, $40, $78, $40, $91, $66, $78, $40
    db $4B, $40, $4B, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_69E9
    dw Func_039_69C5
    dw Func_039_69CB
    dw Func_039_69D1
    dw Func_039_69EF
    dw Func_039_69F5
    dw Func_039_69D7
    dw Func_039_69DD
    dw Func_039_69E3
    dw Func_039_6691
    dw Func_039_69C2
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_414F
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $BF, $69, $BF, $69, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $AD, $69, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_69B6
    dw Func_039_69B9
    db $78, $40, $91, $66, $78, $40, $4B, $40, $78, $40
    dw Func_039_69B3
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_69B0
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_412B
    db $00, $00, $78, $40, $A2, $40, $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40
    db $2B, $41, $2B, $41, $78, $40, $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00
    db $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6691
    dw Func_039_412B
    dw Func_039_413C
    dw Func_039_40A2
    db $78, $40
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    dw Func_039_6691
    db $78, $40, $78, $40, $91, $66, $91, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $91, $66, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_543C
    dw Func_039_5F0E
    dw Func_039_5F0E
    dw Func_039_5F0E
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $03, $5E
    db $78, $40, $78, $40
    dw Func_039_5593
    dw Func_039_5593
    dw Func_039_5593
    dw Func_039_40A2
    dw Func_039_40A2
    db $E8, $40, $E8, $40, $E8, $40
    dw Func_039_569C
    dw Func_039_569C
    dw Func_039_413C
    dw Func_039_5716
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_5857
    dw Func_039_40A2
    dw Func_039_58B7
    db $78, $40, $6B, $59, $A2, $40, $11, $59, $78, $40, $D8, $57, $78, $40, $ED, $60
    db $78, $40, $2B, $41, $4B, $61, $78, $40, $78, $40
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_5DBB
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_65CD
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $A5, $63, $78, $40, $78, $40, $78, $40, $5C, $65, $78, $40
    db $4B, $40, $4B, $40
    dw Func_039_61A1
    dw Func_039_62A3
    dw Func_039_6222
    dw Func_039_6324
    dw Func_039_5CBB
    dw Func_039_5C97
    dw Func_039_5C9D
    dw Func_039_5CA3
    dw Func_039_5CC1
    dw Func_039_5CC7
    dw Func_039_5CA9
    dw Func_039_5CAF
    dw Func_039_5CB5
    dw Func_039_64DB
    dw Func_039_5C43
    dw Func_039_5CCD
    dw Func_039_5D19
    dw Func_039_5BA5
    dw Func_039_543C
    dw Func_039_543C
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6416
    dw Func_039_412B
    dw Func_039_543C
    dw Func_039_543C
    dw Func_039_543C
    dw Func_039_414F
    dw Func_039_543C
    dw Func_039_543C
    dw Func_039_6014
    dw Func_039_6014
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $F9, $5B, $F9, $5B, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $CB, $59, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5D67
    dw Func_039_5ADB
    dw Func_039_5B40
    db $78, $40, $67, $5D, $78, $40, $4B, $40, $78, $40
    dw Func_039_5A84
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_5A27
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40, $2B, $41, $2B, $41, $00, $00, $00, $00, $00, $00, $78, $40, $A2, $40
    db $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40, $2B, $41, $2B, $41, $78, $40
    db $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00, $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    db $55, $40, $2B, $41, $3C, $41, $A2, $40, $78, $40
    dw Func_039_5F0E
    dw Func_039_543C
    dw Func_039_543C
    dw Func_039_543C
    db $78, $40, $78, $40, $3C, $54, $3C, $54, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $0E, $5F, $2B, $41, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_66C5
    dw Func_039_6A0A
    dw Func_039_6A0A
    dw Func_039_6A0A
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $07, $6A
    db $78, $40, $78, $40
    dw Func_039_68B0
    dw Func_039_68B0
    dw Func_039_68B0
    dw Func_039_40A2
    dw Func_039_40A2
    db $E8, $40, $E8, $40, $E8, $40
    dw Func_039_6998
    dw Func_039_6998
    dw Func_039_413C
    dw Func_039_699B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_69A1
    dw Func_039_40A2
    dw Func_039_69A4
    db $78, $40, $AA, $69, $A2, $40, $A7, $69, $78, $40, $9E, $69, $78, $40, $10, $6A
    db $78, $40, $2B, $41, $13, $6A, $78, $40, $00, $00
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_40A2
    dw Func_039_6A04
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6AFA
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $78, $40
    db $78, $40, $78, $40, $22, $6A, $78, $40, $78, $40, $78, $40, $99, $6A, $78, $40
    db $4B, $40, $4B, $40
    dw Func_039_6A16
    dw Func_039_6A1C
    dw Func_039_6A19
    dw Func_039_6A1F
    dw Func_039_69E9
    dw Func_039_69C5
    dw Func_039_69CB
    dw Func_039_69D1
    dw Func_039_69EF
    dw Func_039_69F5
    dw Func_039_69D7
    dw Func_039_69DD
    dw Func_039_69E3
    dw Func_039_6A96
    dw Func_039_69C2
    dw Func_039_69FB
    dw Func_039_69FE
    dw Func_039_69BC
    dw Func_039_66C5
    dw Func_039_66C5
    db $4B, $40, $78, $40, $78, $40
    dw Func_039_6A25
    dw Func_039_412B
    dw Func_039_66C5
    dw Func_039_66C5
    dw Func_039_66C5
    dw Func_039_414F
    dw Func_039_66C5
    dw Func_039_6A0D
    dw Func_039_6A0D
    dw Func_039_66C5
    db $78, $40, $78, $40, $78, $40, $78, $40, $78, $40, $BF, $69, $BF, $69, $78, $40
    db $78, $40, $78, $40, $3C, $41, $A2, $40, $2B, $41, $78, $40, $78, $40, $78, $40
    db $A2, $40, $AD, $69, $78, $40, $78, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6A01
    dw Func_039_69B6
    dw Func_039_69B9
    db $78, $40, $01, $6A, $78, $40, $4B, $40, $78, $40
    dw Func_039_69B3
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_69B0
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_40A2
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    ds $10, $00
    db $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_6A9C
    dw Func_039_412B
    db $00, $00, $78, $40, $A2, $40, $78, $40, $78, $40, $A2, $40, $78, $40, $78, $40
    db $2B, $41, $2B, $41, $78, $40, $78, $40, $3C, $41, $A2, $40, $78, $40, $00, $00
    db $2B, $41, $E8, $40, $4B, $40
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_412B
    dw Func_039_66C5
    dw Func_039_412B
    dw Func_039_413C
    dw Func_039_40A2
    db $78, $40
    dw Func_039_6A0A
    dw Func_039_66C5
    dw Func_039_66C5
    dw Func_039_66C5
    db $78, $40, $78, $40, $C5, $66, $C5, $66, $78, $40, $A2, $40, $78, $40, $2B, $41
    db $A2, $40, $78, $40, $0A, $6A, $2B, $41, $78, $40, $2B, $41, $2B, $41

Func_039_5390:: ; heuristic: target of a pointer table; C0
    ld hl, $D872
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld [$D8A5], a
    ld c, a
    ld b, $03

Jump_039_53A7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_53B2
    call Func_039_6D6A
    jr z, Jump_039_53BC

Jump_039_53B2::
    inc c
    dec b
    jr nz, Jump_039_53A7
    call Func_039_6D74
    jp Jump_039_542B

Jump_039_53BC::
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_53C2::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_53CD
    call Func_039_6E06
    jr z, Jump_039_53D7

Jump_039_53CD::
    inc c
    dec b
    jr nz, Jump_039_53C2
    call Func_039_6E8B
    jp Jump_039_542B

Jump_039_53D7::
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_53DD::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_540D
    call Func_039_6E06
    jr nz, Jump_039_540D
    call Func_039_6E27
    ld a, c
    call Func_039_71F9
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr nc, Jump_039_5403
    ld hl, $0000

Jump_039_5403::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jr Jump_039_5415

Jump_039_540D::
    ld a, $FF
    ld [$D872], a
    ld [$D873], a

Jump_039_5415::
    pop bc
    call Func_039_6E61
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_039_6DF4
    inc c
    dec b
    jr nz, Jump_039_53DD
    call Func_039_6D89

Jump_039_542B::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_5437
    inc h

Jump_039_5437::
    ld a, [$D8A5]
    ld [hl], a
    ret

Func_039_543C:: ; heuristic: target of a pointer table; C0
    ld hl, $D872
    ld bc, $0008
    xor a, a
    call Func_000_0949
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld [$D8A5], a
    ld c, a
    ld b, $03

Jump_039_5453::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_545E
    call Func_039_6D6A
    jr z, Jump_039_5468

Jump_039_545E::
    inc c
    dec b
    jr nz, Jump_039_5453
    call Func_039_6D74
    jp Jump_039_5503

Jump_039_5468::
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_546E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_547E
    call Func_039_6E06
    jr z, Jump_039_5488
    call Func_039_71D4
    jr z, Jump_039_5488

Jump_039_547E::
    inc c
    dec b
    jr nz, Jump_039_546E
    call Func_039_6E8B
    jp Jump_039_5503

Jump_039_5488::
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_548E::
    ld a, c
    call Func_039_6E06
    jr nz, Jump_039_549F
    call Func_039_71D4
    jr nz, Jump_039_549F
    ld a, c
    call Func_000_3E25
    jr nc, Jump_039_54A9

Jump_039_549F::
    inc c
    dec b
    jr nz, Jump_039_548E
    call Func_039_6E8B
    jp Jump_039_5503

Jump_039_54A9::
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_54AF::
    push bc
    ld a, c
    call Func_000_3E25
    jr c, Jump_039_54E5
    call Func_039_6E06
    jr nz, Jump_039_54E5
    call Func_039_71D4
    jr nz, Jump_039_54E5
    ld a, c
    call Func_039_6E27
    ld a, c
    call Func_039_71F9
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    jr nc, Jump_039_54DB
    ld hl, $0000

Jump_039_54DB::
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jr Jump_039_54ED

Jump_039_54E5::
    ld a, $FF
    ld [$D872], a
    ld [$D873], a

Jump_039_54ED::
    pop bc
    call Func_039_6E61
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    call Func_039_6DF4
    inc c
    dec b
    jr nz, Jump_039_54AF
    call Func_039_6D89

Jump_039_5503::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_550F
    inc h

Jump_039_550F::
    ld a, [$D8A5]
    ld [hl], a
    ret

Func_039_5514:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld e, a
    ld d, $03

Jump_039_551C::
    ld a, e
    ld [$D86B], a
    ld a, d
    ld [$D86C], a
    ld a, e
    call Func_000_3E54
    jr nc, Jump_039_5532
    ld bc, $0000
    ld hl, $0000
    jr Jump_039_5553

Jump_039_5532::
    ld a, e
    ld hl, $D8BF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_553C
    inc h

Jump_039_553C::
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, e
    call Func_039_71EF
    call Func_000_3E7A
    jr nz, Jump_039_5550
    ld bc, $0001
    ld hl, $0000
    jr Jump_039_5553

Jump_039_5550::
    call Func_000_3F04

Jump_039_5553::
    push hl
    ld a, [$D86B]
    ld e, a
    ld a, [$D86C]
    ld d, a
    ld a, $03
    sub a, d
    ld hl, $D87D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_5568
    inc h

Jump_039_5568::
    ld [hl], c
    inc hl
    ld [hl], b
    pop bc
    ld a, [$D86B]
    ld e, a
    ld a, [$D86C]
    ld d, a
    ld a, $03
    sub a, d
    ld hl, $D874
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_5580
    inc h

Jump_039_5580::
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D86B]
    ld e, a
    ld a, [$D86C]
    ld d, a
    inc e
    dec d
    jr nz, Jump_039_551C
    call Func_039_6EB6
    ret

Func_039_5593:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld e, a
    ld d, $03
    xor a, a
    ld [$D868], a
    ld b, d
    ld c, e
    xor a, a
    ld hl, $FFC6
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_039_55A8::
    ld a, c
    ld [$D86B], a
    ld a, b
    ld [$D86C], a
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_55E4
    ld hl, $D868
    inc [hl]
    ld a, c
    call Func_039_71EF
    ld a, c
    ld de, $D8A7
    add a, e
    ld e, a
    jr nc, Jump_039_55C7
    inc d

Jump_039_55C7::
    ld a, [de]
    bit 0, a
    jr z, Jump_039_55D3
    ld a, $1E
    call Func_000_16AA
    jr Jump_039_55D5

Jump_039_55D3::
    ld e, $00

Jump_039_55D5::
    ldh a, [$FFC6]
    add a, l
    ldh [$FFC6], a
    ldh a, [$FFC7]
    adc a, h
    ldh [$FFC7], a
    ldh a, [$FFC8]
    adc a, e
    ldh [$FFC8], a

Jump_039_55E4::
    ld a, [$D86B]
    ld c, a
    ld a, [$D86C]
    ld b, a
    inc c
    dec b
    jr nz, Jump_039_55A8
    ldh a, [$FFC6]
    ld l, a
    ldh a, [$FFC7]
    ld h, a
    ldh a, [$FFC8]
    ld e, a
    ld a, [$D868]
    call Func_000_16E2
    ld a, [$D868]
    call Func_000_16E2
    ld a, l
    ld [$D87D], a
    ld a, h
    ld [$D87E], a
    ld a, [$D8A4]
    and a, $04
    ld e, a
    ld d, $03
    ld a, $FF
    ld [$D86A], a

Jump_039_561A::
    ld a, e
    ld [$D868], a
    ld a, d
    ld [$D869], a
    ld a, e
    call Func_000_3E54
    jr c, Jump_039_566D
    ld a, e
    ld hl, $D8CF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_5632
    inc h

Jump_039_5632::
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, e
    call Func_039_71F9
    call Func_000_3E7A
    jr z, Jump_039_566D
    ld a, [$D87D]
    ld c, a
    ld a, [$D87E]
    ld b, a
    call Func_000_3E7A
    jr z, Jump_039_565D
    jr nc, Jump_039_566D
    ld a, l
    ld [$D87D], a
    ld a, h
    ld [$D87E], a
    ld a, [$D868]
    ld [$D86A], a
    jr Jump_039_566D

Jump_039_565D::
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_566D
    ld a, [$D868]
    ld [$D86A], a

Jump_039_566D::
    ld a, [$D868]
    ld e, a
    ld a, [$D869]
    ld d, a
    inc e
    dec d
    jr nz, Jump_039_561A
    ld a, [$D86A]
    cp a, $FF
    jr z, Jump_039_5691
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_568C
    inc h

Jump_039_568C::
    ld a, [$D86A]
    ld [hl], a
    ret

Jump_039_5691::
    ld a, [$D8A4]
    and a, $04
    ld e, a
    ld d, $03
    jp Jump_039_551C

Func_039_569C:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [$FFC6], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_56AF::
    ld a, c
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_039_56B8
    inc h

Jump_039_56B8::
    ld a, [hl]
    cp a, $01
    jr nz, Jump_039_56CD
    ld a, c
    and a, $03
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_56C8
    inc h

Jump_039_56C8::
    ld [hl], c
    ld hl, $FFC6
    inc [hl]

Jump_039_56CD::
    inc c
    dec b
    jr nz, Jump_039_56AF
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_039_56DC
    ld a, [$D8A4]
    ld c, a
    jr Jump_039_5708

Jump_039_56DC::
    ld hl, $FFC7
    ld b, $02
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_039_56F0
    ld b, $01
    ld a, [hl+]
    cp a, $FF
    jr nz, Jump_039_56F0
    ld c, [hl]
    jr Jump_039_5708

Jump_039_56F0::
    ld c, a
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_039_5704
    push af
    call Func_000_3ED4
    ld a, [$C5E7]
    ld e, a
    pop af
    bit 0, e
    jr z, Jump_039_5704
    ld c, a

Jump_039_5704::
    ld a, c
    dec b
    jr nz, Jump_039_56F0

Jump_039_5708::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_5714
    inc h

Jump_039_5714::
    ld [hl], c
    ret

Func_039_5716:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld de, $FFC7

Jump_039_5728::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5738
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    ld [de], a

Jump_039_5738::
    inc de
    inc c
    dec b
    jr nz, Jump_039_5728
    ld hl, $FFC7
    ld bc, $0300
    ld d, $00

Jump_039_5745::
    bit 1, [hl]
    jr z, Jump_039_574D
    ld a, c
    ldh [$FFC6], a
    inc d

Jump_039_574D::
    inc c
    inc hl
    dec b
    jr nz, Jump_039_5745
    ld a, d
    or a, a
    jr z, Jump_039_576C
    cp a, $01
    jr z, Jump_039_57C1
    cp a, $03
    jr z, Jump_039_57B3
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_57C1
    ld d, $02
    jr Jump_039_57A2

Jump_039_576C::
    ld hl, $FFC7
    ld bc, $0300
    ld d, $00

Jump_039_5774::
    bit 0, [hl]
    jr z, Jump_039_577C
    ld a, c
    ldh [$FFC6], a
    inc d

Jump_039_577C::
    inc hl
    inc c
    dec b
    jr nz, Jump_039_5774
    ld a, d
    or a, a
    jr nz, Jump_039_578E
    ld a, [$D8A4]
    and a, $03
    ldh [$FFC6], a
    jr Jump_039_57C1

Jump_039_578E::
    cp a, $01
    jr z, Jump_039_57C1
    cp a, $03
    jr z, Jump_039_57B3
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_57C1
    ld d, $01

Jump_039_57A2::
    ld hl, $FFC7
    ld c, $00

Jump_039_57A7::
    ld a, [hl+]
    and a, d
    jr nz, Jump_039_57AE
    inc c
    jr Jump_039_57A7

Jump_039_57AE::
    ld a, c
    ldh [$FFC6], a
    jr Jump_039_57C1

Jump_039_57B3::
    call Func_000_3ED4
    ld a, [$C5E7]
    ld b, a
    ld a, $03
    call Func_000_16BF
    ldh [$FFC6], a

Jump_039_57C1::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_57CD
    inc h

Jump_039_57CD::
    ldh a, [$FFC6]
    ld c, a
    ld a, [$D8A4]
    and a, $04
    or a, c
    ld [hl], a
    ret

Func_039_57D8:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    ldh [$FFC8], a

Jump_039_57E9::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5831
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    bit 6, a
    jr nz, Jump_039_5831
    bit 2, [hl]
    jr nz, Jump_039_5831
    ld a, c
    call Func_039_71E5
    push bc
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr z, Jump_039_581C
    jr c, Jump_039_5831
    ld a, c
    ldh [$FFC6], a
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    jr Jump_039_5831

Jump_039_581C::
    push hl
    call Func_000_3ED4
    pop hl
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_5831
    ld a, c
    ldh [$FFC6], a
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a

Jump_039_5831::
    inc c
    dec b
    jr nz, Jump_039_57E9
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_5840
    ld a, [$D8A4]
    ldh [$FFC6], a

Jump_039_5840::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_584C
    inc h

Jump_039_584C::
    ldh a, [$FFC6]
    ld c, a
    ld a, [$D8A4]
    and a, $04
    or a, c
    ld [hl], a
    ret

Func_039_5857:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a

Jump_039_5867::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5891
    call Func_039_71EA
    push hl
    call Func_039_6F32
    pop bc
    call Func_000_3E7A
    jr nc, Jump_039_5891
    ldh a, [$FFC7]
    ld l, a
    ldh a, [$FFC8]
    ld h, a
    call Func_000_3E7A
    jr c, Jump_039_5891
    ld a, c
    ldh [$FFC7], a
    ld a, b
    ldh [$FFC8], a
    pop bc
    push bc
    ld a, c
    ldh [$FFC6], a

Jump_039_5891::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5867
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_58A1
    ld a, [$D8A4]
    and a, $03

Jump_039_58A1::
    ld c, a
    ld a, [$D8A4]
    and a, $04
    or a, c
    ld c, a
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_58B5
    inc h

Jump_039_58B5::
    ld [hl], c
    ret

Func_039_58B7:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_58CD::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5909
    ldh [$FFC8], a
    ld hl, $D80E
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_039_5909
    ld a, c
    ldh [$FFC9], a
    call Func_039_71EA
    ld a, h
    or a, a
    jr nz, Jump_039_58EE
    ld a, l
    cp a, $02
    jr c, Jump_039_5909

Jump_039_58EE::
    ld a, c
    ld hl, $DA75
    call Func_039_71C9
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5909
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5909
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5909::
    inc c
    dec b
    jr nz, Jump_039_58CD
    call Func_039_6FE2
    ret

Func_039_5911:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_5927::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5963
    ldh [$FFC8], a
    ld hl, $D80E
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_039_5963
    ld a, c
    ldh [$FFC9], a
    call Func_039_7203
    ld a, h
    or a, a
    jr nz, Jump_039_5948
    ld a, l
    cp a, $02
    jr c, Jump_039_5963

Jump_039_5948::
    ld a, c
    ld hl, $DA75
    call Func_039_71C9
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5963
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5963
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5963::
    inc c
    dec b
    jr nz, Jump_039_5927
    call Func_039_6FE2
    ret

Func_039_596B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a

Jump_039_597B::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_59A5
    call Func_039_7203
    push hl
    call Func_039_6F66
    pop bc
    call Func_000_3E7A
    jr nc, Jump_039_59A5
    ldh a, [$FFC7]
    ld l, a
    ldh a, [$FFC8]
    ld h, a
    call Func_000_3E7A
    jr c, Jump_039_59A5
    ld a, c
    ldh [$FFC7], a
    ld a, b
    ldh [$FFC8], a
    pop bc
    push bc
    ld a, c
    ldh [$FFC6], a

Jump_039_59A5::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_597B
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_59B5
    ld a, [$D8A4]
    and a, $03

Jump_039_59B5::
    ld c, a
    ld a, [$D8A4]
    and a, $04
    or a, c
    ld c, a
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_59C9
    inc h

Jump_039_59C9::
    ld [hl], c
    ret

Func_039_59CB:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_59E1::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5A1F
    ldh [$FFC8], a
    call Func_039_71EA
    ld a, h
    or a, a
    jr nz, Jump_039_5A02
    ld a, l
    cp a, $02
    jr nc, Jump_039_5A02
    ld a, c
    call Func_039_7203
    ld a, h
    or a, a
    jr nz, Jump_039_5A02
    ld a, l
    cp a, $02
    jr c, Jump_039_5A1F

Jump_039_5A02::
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA74
    call Func_039_71C9
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5A1F
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5A1F
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5A1F::
    inc c
    dec b
    jr nz, Jump_039_59E1
    call Func_039_6FE2
    ret

Func_039_5A27:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    ld e, a
    and a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a
    ldh [$FFCB], a

Jump_039_5A40::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5A7B
    ldh [$FFC9], a
    cp a, e
    jr z, Jump_039_5A7B
    ldh [$FFCA], a
    call Func_039_71EF
    push hl
    ld a, c
    call Func_039_71F9
    add hl, hl
    ld c, l
    ld b, h
    add hl, hl
    add hl, hl
    add hl, bc
    pop bc
    call Func_000_3E7A
    jr nc, Jump_039_5A7B
    ldh a, [$FFCA]
    ldh [$FFCB], a
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_039_5A7B
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ldh a, [$FFCA]
    ldh [$FFC6], a

Jump_039_5A7B::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5A40
    call Func_039_7028
    ret

Func_039_5A84:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_5A9C::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5AD3
    ldh [$FFC8], a
    call Func_039_6F9A
    jr z, Jump_039_5AD3
    ld a, c
    ldh [$FFC9], a
    ld hl, $D80D
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_039_5AD3
    ld a, c
    ldh [$FFCA], a
    ld hl, $DA78
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_5AD3
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5AD3
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5AD3::
    inc c
    dec b
    jr nz, Jump_039_5A9C
    call Func_039_7002
    ret

Func_039_5ADB:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_5AF3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5B38
    ldh [$FFC8], a
    call Func_039_71EA
    ld a, h
    or a, a
    jr nz, Jump_039_5B07
    ld a, l
    cp a, $02
    jr c, Jump_039_5B38

Jump_039_5B07::
    ld a, c
    ldh [$FFC9], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_5B38
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5B38
    ld a, c
    ldh [$FFCA], a
    ld hl, $DA77
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5B38
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5B38
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5B38::
    inc c
    dec b
    jr nz, Jump_039_5AF3
    call Func_039_7002
    ret

Func_039_5B40:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_5B58::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5B9D
    ldh [$FFC8], a
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_039_5B68
    inc h

Jump_039_5B68::
    bit 4, [hl]
    jr nz, Jump_039_5B9D
    ld a, c
    ldh [$FFC9], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $DC
    jr nz, Jump_039_5B9D
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5B9D
    ld a, c
    ldh [$FFCA], a
    ld hl, $DA77
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5B9D
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5B9D
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5B9D::
    inc c
    dec b
    jr nz, Jump_039_5B58
    call Func_039_7002
    ret

Func_039_5BA5:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_5BBB::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5BF1
    ldh [$FFC8], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_5BF1
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5BF1
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA74
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_5BF1
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5BF1
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5BF1::
    inc c
    dec b
    jr nz, Jump_039_5BBB
    call Func_039_6FE2
    ret

Func_039_5BF9:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_5C0F::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5C3B
    ldh [$FFC8], a
    call Func_039_71FE
    ld a, h
    or a, l
    jr z, Jump_039_5C3B
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA74
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5C3B
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5C3B
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5C3B::
    inc c
    dec b
    jr nz, Jump_039_5C0F
    call Func_039_6FE2
    ret

Func_039_5C43:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_5C59::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5C8E
    ldh [$FFC9], a
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_039_5C6A
    inc h

Jump_039_5C6A::
    bit 0, [hl]
    jr z, Jump_039_5C8E
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    call Func_000_3E7A
    jr c, Jump_039_5C8E
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ldh a, [$FFC9]
    ldh [$FFC6], a

Jump_039_5C8E::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5C59
    call Func_039_6FC8
    ret

Func_039_5C97:: ; heuristic: target of a pointer table; C0
    ld d, $01
    call Func_039_7093
    ret

Func_039_5C9D:: ; heuristic: target of a pointer table; C0
    ld d, $02
    call Func_039_7093
    ret

Func_039_5CA3:: ; heuristic: target of a pointer table; C0
    ld d, $03
    call Func_039_7093
    ret

Func_039_5CA9:: ; heuristic: target of a pointer table; C0
    ld d, $06
    call Func_039_7093
    ret

Func_039_5CAF:: ; heuristic: target of a pointer table; C0
    ld d, $07
    call Func_039_7093
    ret

Func_039_5CB5:: ; heuristic: target of a pointer table; C0
    ld d, $08
    call Func_039_7093
    ret

Func_039_5CBB:: ; heuristic: target of a pointer table; C0
    ld d, $00
    call Func_039_7093
    ret

Func_039_5CC1:: ; heuristic: target of a pointer table; C0
    ld d, $05
    call Func_039_7093
    ret

Func_039_5CC7:: ; heuristic: target of a pointer table; C0
    ld d, $04
    call Func_039_7093
    ret

Func_039_5CCD:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_5CE3::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5D11
    ldh [$FFC8], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    jr nz, Jump_039_5D11
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA76
    call Func_039_71C9
    and a, $03
    cp a, $03
    jr z, Jump_039_5D11
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5D11
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5D11::
    inc c
    dec b
    jr nz, Jump_039_5CE3
    call Func_039_6FE2
    ret

Func_039_5D19:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_5D2F::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5D5F
    ldh [$FFC8], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $CC
    jr nz, Jump_039_5D5F
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA77
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_5D5F
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5D5F
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5D5F::
    inc c
    dec b
    jr nz, Jump_039_5D2F
    call Func_039_6FE2
    ret

Func_039_5D67:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_5D7D::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5DB3
    ldh [$FFC8], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $DC
    jr nz, Jump_039_5DB3
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_039_5DB3
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA77
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_5DB3
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_5DB3
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5DB3::
    inc c
    dec b
    jr nz, Jump_039_5D7D
    call Func_039_6FE2
    ret

Func_039_5DBB:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC9], a
    xor a, a
    ldh [$FFC7], a
    ldh [$FFC8], a

Jump_039_5DD2::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5DFA
    ldh [$FFC9], a
    call Func_039_71EF
    push hl
    ld a, c
    call Func_039_71F4
    pop bc
    add hl, bc
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    call Func_000_3E7A
    jr c, Jump_039_5DFA
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ldh a, [$FFC9]
    ldh [$FFC6], a

Jump_039_5DFA::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5DD2
    call Func_039_6FC8
    ret

Func_039_5E03:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    xor a, a
    ldh [$FFC9], a
    ldh [$FFCA], a
    ld a, $FF
    ldh [$FFCB], a

Jump_039_5E20::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5E53
    ld hl, $D80E
    ldh [$FFCB], a
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_039_5E53
    ld a, c
    ld hl, $DA74
    call Func_039_71C9
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5E53
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_5E4F
    jr c, Jump_039_5E53
    ld a, e
    ldh [$FFC7], a
    xor a, a
    ldh [$FFC8], a

Jump_039_5E4F::
    ld hl, $FFC8
    inc [hl]

Jump_039_5E53::
    inc c
    dec b
    jr nz, Jump_039_5E20
    ldh a, [$FFC8]
    or a, a
    jr z, Jump_039_5EAC
    cp a, $01
    jr z, Jump_039_5ED8
    ldh a, [$FFD0]
    ld c, a
    ld b, $03

Jump_039_5E65::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5EA5
    ld hl, $D80E
    call Func_000_3F25
    bit 1, [hl]
    jr nz, Jump_039_5EA5
    ld a, c
    ld hl, $DA74
    call Func_039_71C9
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5EA5
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr nz, Jump_039_5EA5
    ld a, c
    call Func_039_71F9
    ldh a, [$FFC9]
    ld c, a
    ldh a, [$FFCA]
    ld b, a
    call Func_000_3E80
    jr c, Jump_039_5EA5
    ld a, l
    ldh [$FFC9], a
    ld a, h
    ldh [$FFCA], a
    pop bc
    push bc
    ld a, c
    ldh [$FFC6], a

Jump_039_5EA5::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5E65
    jr Jump_039_5EFA

Jump_039_5EAC::
    ldh a, [$FFD0]
    ld c, a
    ld b, $03

Jump_039_5EB1::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5ED1
    ldh [$FFCB], a
    call Func_039_71F9
    ldh a, [$FFC9]
    ld c, a
    ldh a, [$FFCA]
    ld b, a
    call Func_000_3E80
    jr c, Jump_039_5ED1
    ld a, l
    ldh [$FFC9], a
    ld a, h
    ldh [$FFCA], a
    ld a, c
    ldh [$FFC6], a

Jump_039_5ED1::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_5EB1
    jr Jump_039_5EFA

Jump_039_5ED8::
    ldh a, [$FFD0]
    ld c, a
    ld b, $03
    ldh a, [$FFC7]
    ld e, a

Jump_039_5EE0::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_5EF3
    ld hl, $DA74
    call Func_039_71C9
    and a, $30
    swap a
    cp a, e
    jr z, Jump_039_5EF7

Jump_039_5EF3::
    inc c
    dec b
    jr nz, Jump_039_5EE0

Jump_039_5EF7::
    ld a, c
    ldh [$FFC6], a

Jump_039_5EFA::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_5F06
    inc h

Jump_039_5F06::
    ldh a, [$FFD0]
    ld e, a
    ldh a, [$FFC6]
    or a, e
    ld [hl], a
    ret

Func_039_5F0E:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A6]
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    ld a, $02
    ld [$D869], a
    ld hl, $FFCE
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld e, $09
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_039_5F3A
    ld a, [$D8A4]
    and a, $04
    jr z, Jump_039_5F3A
    ld e, $0D

Jump_039_5F3A::
    ld a, e
    ld [$D868], a
    ld hl, Func_01A_4022
    ld b, $1A
    rst $10
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a
    ldh [$FFCB], a
    ld [$D874], a
    ld [$D875], a
    xor a, a
    ld [$D872], a
    ld [$D873], a

Jump_039_5F6B::
    push bc
    ld a, c
    call Func_000_3E54
    jp c, Jump_039_5FF2
    ldh [$FFC9], a
    ld hl, $D80E
    call Func_000_3F25
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_5FF2
    ld a, c
    ldh [$FFCA], a
    ld hl, $DA72
    call Func_039_71C9
    and a, $30
    swap a
    cp a, $03
    jr z, Jump_039_5FF2
    ldh [$FFCC], a
    push bc
    call Func_039_7155
    pop bc
    push hl
    ld a, c
    call Func_039_71F9
    pop bc
    call Func_000_3E7A
    jr c, Jump_039_5FD9
    ldh a, [$FFCC]
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_5FBE
    jr c, Jump_039_5FF2
    ld a, e
    ldh [$FFC7], a
    ldh a, [$FFC9]
    ldh [$FFCB], a
    ld a, l
    ld [$D874], a
    ld a, h
    ld [$D875], a
    jr Jump_039_5FF2

Jump_039_5FBE::
    ld a, [$D874]
    ld c, a
    ld a, [$D875]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_039_5FF2
    ld a, l
    ld [$D874], a
    ld a, h
    ld [$D875], a
    ldh a, [$FFC9]
    ldh [$FFCB], a
    jr Jump_039_5FF2

Jump_039_5FD9::
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E80
    jr c, Jump_039_5FF2
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ldh a, [$FFC9]
    ldh [$FFC8], a

Jump_039_5FF2::
    pop bc
    inc c
    dec b
    jp nz, Jump_039_5F6B
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6004
    inc h

Jump_039_6004::
    ldh a, [$FFC8]
    cp a, $FF
    jr nz, Jump_039_6012
    ldh a, [$FFCB]
    cp a, $FF
    jr nz, Jump_039_6012
    ldh a, [$FFC9]

Jump_039_6012::
    ld [hl], a
    ret

Func_039_6014:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC9], a
    ldh [$FFCA], a
    xor a, a
    ldh [$FFC7], a
    ldh [$FFC8], a

Jump_039_602D::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6079
    ldh [$FFC9], a
    ld hl, $D812
    call Func_000_3F25
    ld a, [hl+]
    and a, $20
    jr nz, Jump_039_6079
    and a, $05
    jr nz, Jump_039_6079
    ld a, c
    ld hl, $DA75
    call Func_039_71C9
    and a, $03
    cp a, $03
    jr z, Jump_039_6079
    ld e, a
    ldh a, [$FFCA]
    cp a, e
    jr z, Jump_039_6060
    jr nc, Jump_039_6079
    ld a, c
    call Func_039_71F9
    jr Jump_039_606F

Jump_039_6060::
    ld a, c
    call Func_039_71F9
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    call Func_000_3E7A
    jr c, Jump_039_6079

Jump_039_606F::
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ldh a, [$FFC9]
    ldh [$FFC6], a

Jump_039_6079::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_602D
    ldh a, [$FFC6]
    cp a, $FF
    jp nz, Jump_039_60E9
    ldh a, [$FFD0]
    ld c, a
    ld b, $03

Jump_039_608A::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_60B6
    ldh [$FFC9], a
    ld hl, $D813
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_039_60B6
    ld a, c
    call Func_039_71F9
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    call Func_000_3E7A
    jr c, Jump_039_60B6
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ldh a, [$FFC9]
    ldh [$FFC6], a

Jump_039_60B6::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_608A
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_60E9
    ldh a, [$FFD0]
    ld c, a
    ld b, $03

Jump_039_60C6::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_60E4
    ldh [$FFC9], a
    call Func_039_71F9
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    jr c, Jump_039_60E4
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ldh a, [$FFC9]
    ldh [$FFC6], a

Jump_039_60E4::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_60C6

Jump_039_60E9::
    call Func_039_6FC8
    ret

Func_039_60ED:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_6105::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6143
    ldh [$FFC8], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_6143
    inc hl
    inc hl
    ld a, [hl-]
    or a, a
    jr nz, Jump_039_6143
    ld a, c
    ldh [$FFC9], a
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_6143
    ld a, c
    ldh [$FFCA], a
    ld hl, $DA74
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_6143
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_6143
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_6143::
    inc c
    dec b
    jr nz, Jump_039_6105
    call Func_039_7002
    ret

Func_039_614B:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_6161::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6199
    ldh [$FFC8], a
    call Func_039_71FE
    ld a, h
    or a, l
    jr z, Jump_039_6199
    ld a, c
    ldh [$FFC9], a
    ld hl, $D80E
    call Func_000_3F25
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_6199
    ld a, c
    ld hl, $DA74
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    cp a, $03
    jr z, Jump_039_6199
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_6199
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_6199::
    inc c
    dec b
    jr nz, Jump_039_6161
    call Func_039_6FE2
    ret

Func_039_61A1:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_61BD::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_621A
    ldh [$FFC8], a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_621A
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_621A
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA72
    call Func_039_71C9
    and a, $30
    swap a
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_61F5
    jr c, Jump_039_621A
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_61F5::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_621A
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_621A::
    inc c
    dec b
    jr nz, Jump_039_61BD
    call Func_039_6FE2
    ret

Func_039_6222:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_623E::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_629B
    ldh [$FFC8], a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_629B
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_629B
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA73
    call Func_039_71C9
    and a, $30
    swap a
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_6276
    jr c, Jump_039_629B
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_6276::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_629B
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_629B::
    inc c
    dec b
    jr nz, Jump_039_623E
    call Func_039_6FE2
    ret

Func_039_62A3:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_62BF::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_631C
    ldh [$FFC8], a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_631C
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_631C
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA73
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_62F7
    jr c, Jump_039_631C
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_62F7::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_631C
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_631C::
    inc c
    dec b
    jr nz, Jump_039_62BF
    call Func_039_6FE2
    ret

Func_039_6324:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_6340::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_639D
    ldh [$FFC8], a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_639D
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_639D
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA73
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_6378
    jr c, Jump_039_639D
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_6378::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_639D
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_639D::
    inc c
    dec b
    jr nz, Jump_039_6340
    call Func_039_6FE2
    ret

Func_039_63A5:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_63C1::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_640E
    ldh [$FFC8], a
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA73
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_63E9
    jr c, Jump_039_640E
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_63E9::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_640E
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_640E::
    inc c
    dec b
    jr nz, Jump_039_63C1
    call Func_039_6FE2
    ret

Func_039_6416:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld [$D8A5], a
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_6435::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6440
    call Func_039_6D6A
    jr z, Jump_039_644A

Jump_039_6440::
    inc c
    dec b
    jr nz, Jump_039_6435
    call Func_039_6D74
    jp Jump_039_64CA

Jump_039_644A::
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_6450::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6460
    call Func_039_6E06
    jr z, Jump_039_646A
    call Func_039_71D4
    jr z, Jump_039_646A

Jump_039_6460::
    inc c
    dec b
    jr nz, Jump_039_6450
    call Func_039_6E8B
    jp Jump_039_64CA

Jump_039_646A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_64C2
    call Func_039_71D4
    jr nz, Jump_039_64C2
    ld a, c
    call Func_039_6E06
    jr nz, Jump_039_64C2
    ldh [$FFC8], a
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA78
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_649D
    jr c, Jump_039_64C2
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_649D::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_64C2
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_64C2::
    inc c
    dec b
    jr nz, Jump_039_646A
    call Func_039_6FE2
    ret

Jump_039_64CA::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_64D6
    inc h

Jump_039_64D6::
    ld a, [$D8A5]
    ld [hl], a
    ret

Func_039_64DB:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_64F7::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6554
    ldh [$FFC8], a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_6554
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_6554
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA72
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_652F
    jr c, Jump_039_6554
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_652F::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_6554
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_6554::
    inc c
    dec b
    jr nz, Jump_039_64F7
    call Func_039_6FE2
    ret

Func_039_655C:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_6578::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_65C5
    ldh [$FFC8], a
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA72
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_65A0
    jr c, Jump_039_65C5
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_65A0::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_65C5
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_65C5::
    inc c
    dec b
    jr nz, Jump_039_6578
    call Func_039_6FE2
    ret

Func_039_65CD:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a
    ldh [$FFCB], a
    ld [$D874], a
    ld [$D875], a
    xor a, a
    ld [$D872], a
    ld [$D873], a

Jump_039_65F4::
    push bc
    ld a, c
    call Func_000_3E54
    jp c, Jump_039_666F
    ldh [$FFC9], a
    ld hl, $DA76
    call Func_039_71C9
    and a, $C0
    rrca
    rrca
    swap a
    cp a, $03
    jr z, Jump_039_666F
    ldh [$FFCC], a
    push bc
    call Func_039_7180
    pop bc
    push hl
    ld a, c
    call Func_039_71F9
    pop bc
    call Func_000_3E7A
    jr c, Jump_039_6656
    ldh a, [$FFCC]
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_663B
    jr c, Jump_039_666F
    ld a, e
    ldh [$FFC7], a
    ldh a, [$FFC9]
    ldh [$FFCB], a
    ld a, l
    ld [$D874], a
    ld a, h
    ld [$D875], a
    jr Jump_039_666F

Jump_039_663B::
    ld a, [$D874]
    ld c, a
    ld a, [$D875]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_039_666F
    ld a, l
    ld [$D874], a
    ld a, h
    ld [$D875], a
    ldh a, [$FFC9]
    ldh [$FFCB], a
    jr Jump_039_666F

Jump_039_6656::
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E80
    jr c, Jump_039_666F
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ldh a, [$FFC9]
    ldh [$FFC8], a

Jump_039_666F::
    pop bc
    inc c
    dec b
    jp nz, Jump_039_65F4
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6681
    inc h

Jump_039_6681::
    ldh a, [$FFC8]
    cp a, $FF
    jr nz, Jump_039_668F
    ldh a, [$FFCB]
    cp a, $FF
    jr nz, Jump_039_668F
    ldh a, [$FFC9]

Jump_039_668F::
    ld [hl], a
    ret

Func_039_6691:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [$FFC6], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_66A9::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_66BD
    ld hl, $FFC6
    ld a, [hl]
    inc [hl]
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_66BC
    inc h

Jump_039_66BC::
    ld [hl], c

Jump_039_66BD::
    inc c
    dec b
    jr nz, Jump_039_66A9
    call Func_039_704E
    ret

Func_039_66C5:: ; heuristic: target of a pointer table; C0
    call Func_000_3ED4
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [$FFC6], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a
    ld [$D874], a
    ld [$D875], a
    ld [$D876], a
    ld [$D877], a

Jump_039_66EF::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6722
    ld hl, $FFC6
    ld e, [hl]
    ld a, e
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_6702
    inc h

Jump_039_6702::
    ld [hl], c
    ld a, e
    ld hl, $D872
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_670D
    inc h

Jump_039_670D::
    push hl
    ld a, e
    call Func_039_71F9
    push hl
    ld a, e
    call Func_039_71EA
    pop de
    add hl, de
    sra h
    rr l
    ld d, h
    ld a, l
    pop hl
    ld [hl+], a
    ld [hl], d

Jump_039_6722::
    inc c
    dec b
    jr nz, Jump_039_66EF
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld a, [$D874]
    ld c, a
    ld a, [$D875]
    ld b, a
    call Func_000_3E7A
    jr z, Jump_039_6757
    jr c, Jump_039_6757
    ld a, l
    ld [$D874], a
    ld a, h
    ld [$D875], a
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    ldh a, [$FFC7]
    push af
    ldh a, [$FFC8]
    ldh [$FFC7], a
    pop af
    ldh [$FFC8], a

Jump_039_6757::
    ld a, [$D874]
    ld l, a
    ld a, [$D875]
    ld h, a
    ld a, [$D876]
    ld c, a
    ld a, [$D877]
    ld b, a
    call Func_000_3E7A
    jr z, Jump_039_6788
    jr c, Jump_039_6788
    ld a, l
    ld [$D876], a
    ld a, h
    ld [$D877], a
    ld a, c
    ld [$D874], a
    ld a, b
    ld [$D875], a
    ldh a, [$FFC8]
    push af
    ldh a, [$FFC9]
    ldh [$FFC8], a
    pop af
    ldh [$FFC9], a

Jump_039_6788::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld a, [$D874]
    ld c, a
    ld a, [$D875]
    ld b, a
    call Func_000_3E7A
    jr z, Jump_039_67A9
    jr c, Jump_039_67A9
    ldh a, [$FFC7]
    push af
    ldh a, [$FFC8]
    ldh [$FFC7], a
    pop af
    ldh [$FFC8], a

Jump_039_67A9::
    call Func_039_704E
    ret

Func_039_67AD:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld e, a
    ld d, $03
    push de
    xor a, a
    ld [$D09D], a
    ld [$D09E], a
    ld [$D09F], a
    ld [$D0A0], a
    ld [$D0A1], a
    ld [$D0A2], a
    ld [$D0A3], a
    ld [$D0A4], a
    ld [$D0A5], a
    ld [$D0A6], a
    ld [$D0A7], a
    ld [$D0A8], a

Jump_039_67DB::
    ld a, e
    call Func_000_3E54
    jr c, Jump_039_680E
    call Func_039_71F9
    push hl
    ld a, e
    call Func_039_71EF
    pop bc
    call Func_000_3E7A
    jr z, Jump_039_680E
    push de
    call Func_000_3F04
    pop de
    push de
    ld a, e
    and a, $03
    ld de, $D09D
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_039_6802
    inc d

Jump_039_6802::
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    pop de

Jump_039_680E::
    inc e
    dec d
    jr nz, Jump_039_67DB
    pop de
    ld a, $FF
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_6820::
    ld a, e
    call Func_000_3E54
    jr c, Jump_039_6895
    ld hl, $FFC7
    ld a, [hl+]
    or a, [hl]
    inc hl
    or a, [hl]
    inc hl
    or a, [hl]
    jr z, Jump_039_687A
    ld a, e
    and a, $03
    ld hl, $D09D
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_683E
    inc h

Jump_039_683E::
    ld a, l
    ldh [$FFCB], a
    ld a, h
    ldh [$FFCC], a
    ld a, [hl+]
    or a, [hl]
    inc hl
    or a, [hl]
    inc hl
    or a, [hl]
    jr z, Jump_039_6895
    ldh a, [$FFCB]
    ld l, a
    ldh a, [$FFCC]
    ld h, a
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ldh a, [$FFC7]
    ld l, a
    ldh a, [$FFC8]
    ld h, a
    call Func_000_3E7A
    jr z, Jump_039_6864
    jr nc, Jump_039_6895
    jr Jump_039_687A

Jump_039_6864::
    ldh a, [$FFCB]
    ld l, a
    ldh a, [$FFCC]
    ld h, a
    inc hl
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ldh a, [$FFC9]
    ld l, a
    ldh a, [$FFCA]
    ld h, a
    call Func_000_3E7A
    jr nc, Jump_039_6895

Jump_039_687A::
    ld a, e
    ldh [$FFC6], a
    and a, $03
    ld hl, $D09D
    add a, a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6889
    inc h

Jump_039_6889::
    ld a, [hl+]
    ldh [$FFC7], a
    ld a, [hl+]
    ldh [$FFC8], a
    ld a, [hl+]
    ldh [$FFC9], a
    ld a, [hl]
    ldh [$FFCA], a

Jump_039_6895::
    inc e
    dec d
    jr nz, Jump_039_6820
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_68A5
    inc h

Jump_039_68A5::
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_68AE
    ld a, [$D8A4]

Jump_039_68AE::
    ld [hl], a
    ret

Func_039_68B0:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld e, a
    ld d, $03
    push de
    xor a, a
    ldh [$FFC6], a
    ldh [$FFCA], a
    ldh [$FFCB], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a
    ld [$D874], a
    ld [$D875], a
    ld [$D876], a
    ld [$D877], a

Jump_039_68DA::
    ld a, e
    call Func_000_3E54
    jr c, Jump_039_68F1
    call Func_039_71EF
    ldh a, [$FFCA]
    add a, l
    ldh [$FFCA], a
    ldh a, [$FFCB]
    adc a, h
    ldh [$FFCB], a
    ld hl, $FFC6
    inc [hl]

Jump_039_68F1::
    inc e
    dec d
    jr nz, Jump_039_68DA
    ldh a, [$FFCA]
    ld l, a
    ldh a, [$FFCB]
    ld h, a
    ldh a, [$FFC6]
    call Func_000_16D1
    ld a, l
    ldh [$FFCA], a
    ld a, h
    ldh [$FFCB], a
    xor a, a
    ldh [$FFC6], a
    pop de

Jump_039_690A::
    ld a, e
    call Func_000_3E54
    jr c, Jump_039_693C
    call Func_039_71F9
    ldh a, [$FFCA]
    ld c, a
    ldh a, [$FFCB]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_039_693C
    ldh a, [$FFC6]
    ld bc, $D872
    add a, a
    add a, c
    ld c, a
    jr nc, Jump_039_6929
    inc b

Jump_039_6929::
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ld hl, $FFC6
    ld a, [hl]
    inc [hl]
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_693B
    inc h

Jump_039_693B::
    ld [hl], e

Jump_039_693C::
    inc e
    dec d
    jr nz, Jump_039_690A
    ldh a, [$FFC6]
    or a, a
    jp z, Func_039_67AD
    cp a, $01
    jr z, Jump_039_6988
    cp a, $02
    jr z, Jump_039_696F
    ld a, [$D876]
    ld l, a
    ld a, [$D877]
    ld h, a
    ld a, [$D874]
    ld c, a
    ld a, [$D875]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_039_696F
    ld a, l
    ld [$D874], a
    ld a, h
    ld [$D875], a
    ldh a, [$FFC9]
    ldh [$FFC8], a

Jump_039_696F::
    ld a, [$D874]
    ld l, a
    ld a, [$D875]
    ld h, a
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_039_6988
    ldh a, [$FFC8]
    ldh [$FFC7], a

Jump_039_6988::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6994
    inc h

Jump_039_6994::
    ldh a, [$FFC7]
    ld [hl], a
    ret

Func_039_6998:: ; heuristic: target of a pointer table; C0
    jp Func_039_569C

Func_039_699B:: ; heuristic: target of a pointer table; C0
    jp Func_039_5716

Func_039_699E:: ; heuristic: follows a terminator; C0
    jp Func_039_57D8

Func_039_69A1:: ; heuristic: target of a pointer table; C0
    jp Func_039_5857

Func_039_69A4:: ; heuristic: target of a pointer table; C0
    jp Func_039_58B7

Func_039_69A7:: ; heuristic: follows a terminator; C0
    jp Func_039_5911

Func_039_69AA:: ; heuristic: follows a terminator; C0
    jp Func_039_596B

Func_039_69AD:: ; heuristic: follows a terminator; C0
    jp Func_039_59CB

Func_039_69B0:: ; heuristic: target of a pointer table; C0
    jp Func_039_5A27

Func_039_69B3:: ; heuristic: target of a pointer table; C0
    jp Func_039_5A84

Func_039_69B6:: ; heuristic: target of a pointer table; C0
    jp Func_039_5ADB

Func_039_69B9:: ; heuristic: target of a pointer table; C0
    jp Func_039_5B40

Func_039_69BC:: ; heuristic: target of a pointer table; C0
    jp Func_039_5BA5

Func_039_69BF:: ; heuristic: follows a terminator; C0
    jp Func_039_5BF9

Func_039_69C2:: ; heuristic: target of a pointer table; C0
    jp Func_039_5C43

Func_039_69C5:: ; heuristic: target of a pointer table; C0
    ld d, $01
    call Func_039_70FD
    ret

Func_039_69CB:: ; heuristic: target of a pointer table; C0
    ld d, $02
    call Func_039_70FD
    ret

Func_039_69D1:: ; heuristic: target of a pointer table; C0
    ld d, $03
    call Func_039_70FD
    ret

Func_039_69D7:: ; heuristic: target of a pointer table; C0
    ld d, $06
    call Func_039_70FD
    ret

Func_039_69DD:: ; heuristic: target of a pointer table; C0
    ld d, $07
    call Func_039_70FD
    ret

Func_039_69E3:: ; heuristic: target of a pointer table; C0
    ld d, $08
    call Func_039_70FD
    ret

Func_039_69E9:: ; heuristic: target of a pointer table; C0
    ld d, $00
    call Func_039_70FD
    ret

Func_039_69EF:: ; heuristic: target of a pointer table; C0
    ld d, $05
    call Func_039_70FD
    ret

Func_039_69F5:: ; heuristic: target of a pointer table; C0
    ld d, $04
    call Func_039_70FD
    ret

Func_039_69FB:: ; heuristic: target of a pointer table; C0
    jp Func_039_5CCD

Func_039_69FE:: ; heuristic: target of a pointer table; C0
    jp Func_039_5D19

Func_039_6A01:: ; heuristic: target of a pointer table; C0
    jp Func_039_5D67

Func_039_6A04:: ; heuristic: target of a pointer table; C0
    jp Func_039_5DBB

Func_039_6A07:: ; heuristic: follows a terminator; C0
    jp Func_039_5E03

Func_039_6A0A:: ; heuristic: target of a pointer table; C0
    jp Func_039_5F0E

Func_039_6A0D:: ; heuristic: target of a pointer table; C0
    jp Func_039_6014

Func_039_6A10:: ; heuristic: follows a terminator; C0
    jp Func_039_60ED

Func_039_6A13:: ; heuristic: follows a terminator; C0
    jp Func_039_614B

Func_039_6A16:: ; heuristic: target of a pointer table; C0
    jp Func_039_61A1

Func_039_6A19:: ; heuristic: target of a pointer table; C0
    jp Func_039_6222

Func_039_6A1C:: ; heuristic: target of a pointer table; C0
    jp Func_039_62A3

Func_039_6A1F:: ; heuristic: target of a pointer table; C0
    jp Func_039_6324

Func_039_6A22:: ; heuristic: follows a terminator; C0
    jp Func_039_63A5

Func_039_6A25:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ld [$D872], a
    ld [$D873], a

Jump_039_6A41::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6A8E
    ldh [$FFC8], a
    ld a, c
    ldh [$FFC9], a
    ld hl, $DA78
    call Func_039_71C9
    and a, $0C
    rrca
    rrca
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr z, Jump_039_6A69
    jr c, Jump_039_6A8E
    ld a, $FF
    ld [$D872], a
    ld [$D873], a
    ld a, e
    ldh [$FFC7], a

Jump_039_6A69::
    push bc
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    call Func_000_3E7A
    pop bc
    jr nc, Jump_039_6A8E
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, c
    ldh [$FFC6], a

Jump_039_6A8E::
    inc c
    dec b
    jr nz, Jump_039_6A41
    call Func_039_6FE2
    ret

Func_039_6A96:: ; heuristic: target of a pointer table; C0
    jp Func_039_64DB

Func_039_6A99:: ; heuristic: follows a terminator; C0
    jp Func_039_655C

Func_039_6A9C:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_6AB4::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6AF2
    ldh [$FFC8], a
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $CC
    jr nz, Jump_039_6AF2
    inc hl
    inc hl
    ld a, [hl-]
    or a, a
    jr nz, Jump_039_6AF2
    ld a, c
    ldh [$FFC9], a
    ld a, [hl]
    and a, $22
    jr nz, Jump_039_6AF2
    ld a, c
    ldh [$FFCA], a
    ld hl, $DA75
    call Func_039_71C9
    and a, $C0
    rlca
    rlca
    cp a, $03
    jr z, Jump_039_6AF2
    ld e, a
    ldh a, [$FFC7]
    cp a, e
    jr c, Jump_039_6AF2
    ld a, e
    ldh [$FFC7], a
    ld a, c
    ldh [$FFC6], a

Jump_039_6AF2::
    inc c
    dec b
    jr nz, Jump_039_6AB4
    call Func_039_7002
    ret

Func_039_6AFA:: ; heuristic: target of a pointer table; C0
    jp Func_039_65CD

Func_039_6AFD:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld hl, $D80C
    ld d, $03
    jp Jump_039_6BE3

Func_039_6B0A:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [$FFC6], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_6B1D::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6B41
    call Func_039_71EA
    push hl
    call Func_039_6F32
    pop bc
    call Func_000_3E7A
    jr z, Jump_039_6B41
    ld hl, $FFC6
    ld a, [hl]
    inc [hl]
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_6B3E
    inc h

Jump_039_6B3E::
    pop bc
    ld [hl], c
    push bc

Jump_039_6B41::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6B1D
    ldh a, [$FFC6]
    or a, a
    jp nz, Func_039_704E
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6B58
    inc h

Jump_039_6B58::
    ld a, [$D8A4]
    ld [hl], a
    ret

Func_039_6B5D:: ; heuristic: follows a terminator; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [$FFC6], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_6B70::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6B94
    call Func_039_7203
    push hl
    call Func_039_6F66
    pop bc
    call Func_000_3E7A
    jr z, Jump_039_6B94
    ld hl, $FFC6
    ld a, [hl]
    inc [hl]
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_6B91
    inc h

Jump_039_6B91::
    pop bc
    ld [hl], c
    push bc

Jump_039_6B94::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6B70
    ldh a, [$FFC6]
    or a, a
    jp nz, Func_039_704E
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6BAB
    inc h

Jump_039_6BAB::
    ld a, [$D8A4]
    ld [hl], a
    ret

Func_039_6BB0:: ; heuristic: target of a pointer table; C0
    ld de, Func_039_71EA
    jp Jump_039_6C30
    db $11, $03, $72, $C3, $30, $6C, $FA, $A4, $D8, $E6, $04, $21, $0C, $D8, $16, $10
    db $C3, $E3, $6B, $FA, $A4, $D8, $E6, $04, $21, $0C, $D8, $16, $40, $C3, $E3, $6B
    db $FA, $A4, $D8, $E6, $04, $21, $0C, $D8, $16, $20, $C3, $E3, $6B

Jump_039_6BE3::
    ld c, a
    ld b, $03
    call Func_000_3F25
    xor a, a
    ldh [$FFC6], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_6BF4::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6C0E
    ld a, [hl]
    and a, d
    jr z, Jump_039_6C0E
    push hl
    ld hl, $FFC6
    ld a, [hl]
    inc [hl]
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_6C0C
    inc h

Jump_039_6C0C::
    ld [hl], c
    pop hl

Jump_039_6C0E::
    ld a, $09
    add a, l
    ld l, a
    jr nc, Jump_039_6C15
    inc h

Jump_039_6C15::
    inc c
    dec b
    jr nz, Jump_039_6BF4
    ldh a, [$FFC6]
    or a, a
    jp nz, Func_039_704E
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6C2B
    inc h

Jump_039_6C2B::
    ld a, [$D8A4]
    ld [hl], a
    ret

Jump_039_6C30::
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    xor a, a
    ldh [$FFC6], a
    ld a, $FF
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_6C45::
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6C67
    ld h, d
    ld l, e
    call Func_000_000E
    ld a, h
    or a, a
    jr nz, Jump_039_6C59
    ld a, l
    cp a, $02
    jr c, Jump_039_6C67

Jump_039_6C59::
    ld hl, $FFC6
    ld a, [hl]
    inc [hl]
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_6C66
    inc h

Jump_039_6C66::
    ld [hl], c

Jump_039_6C67::
    inc c
    dec b
    jr nz, Jump_039_6C45
    ldh a, [$FFC6]
    or a, a
    jp z, Func_039_6691
    call Func_039_704E
    ret

Func_039_6C75:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_6C8A::
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6CD4
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EF
    pop bc
    call Func_000_3F04
    ldh a, [$FFC7]
    sub a, l
    ld e, a
    ldh a, [$FFC8]
    sbc a, h
    ld d, a
    jr c, Jump_039_6CC3
    ld a, d
    or a, e
    jr nz, Jump_039_6CD4
    ldh a, [$FFC9]
    sub a, c
    ld e, a
    ldh a, [$FFCA]
    sbc a, b
    ld d, a
    jr c, Jump_039_6CC3
    ld a, d
    or a, e
    jr nz, Jump_039_6CD4
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_6CD4

Jump_039_6CC3::
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ld a, c
    ldh [$FFC9], a
    ld a, b
    ldh [$FFCA], a
    pop bc
    ld a, c
    ldh [$FFC6], a
    push bc

Jump_039_6CD4::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6C8A
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6CE5
    inc h

Jump_039_6CE5::
    ldh a, [$FFC6]
    ld [hl], a
    ret

Func_039_6CE9:: ; heuristic: target of a pointer table; C0
    ld a, [$D8A4]
    and a, $04
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    xor a, a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a
    ldh [$FFCA], a

Jump_039_6CFE::
    push bc
    ld a, [$D8A4]
    cp a, c
    jr z, Jump_039_6D4E
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_6D4E
    call Func_039_71FE
    push hl
    ld a, c
    call Func_039_71F4
    pop bc
    call Func_000_3F04
    ldh a, [$FFC7]
    sub a, l
    ld e, a
    ldh a, [$FFC8]
    sbc a, h
    ld d, a
    jr c, Jump_039_6D3D
    ld a, d
    or a, e
    jr nz, Jump_039_6D4E
    ldh a, [$FFC9]
    sub a, c
    ld e, a
    ldh a, [$FFCA]
    sbc a, b
    ld d, a
    jr c, Jump_039_6D3D
    ld a, d
    or a, e
    jr nz, Jump_039_6D4E
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 7, a
    jr z, Jump_039_6D4E

Jump_039_6D3D::
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ld a, c
    ldh [$FFC9], a
    ld a, b
    ldh [$FFCA], a
    pop bc
    ld a, c
    ldh [$FFC6], a
    push bc

Jump_039_6D4E::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_6CFE
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6D5F
    inc h

Jump_039_6D5F::
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_6D68
    ld a, [$D8A4]

Jump_039_6D68::
    ld [hl], a
    ret

Func_039_6D6A::
    ld hl, $D810
    call Func_000_3F25
    ld a, [hl]
    and a, $0C
    ret

Func_039_6D74::
    ld a, $00
    ld [$D87F], a
    xor a, a
    ldh [$FFC7], a
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_6D82::
    call Func_039_6DC8
    inc c
    dec b
    jr nz, Jump_039_6D82

Func_039_6D89::
    xor a, a
    ldh [$FFC6], a
    ld a, [$D874]
    ld c, a
    ld a, [$D875]
    ld b, a
    ld de, $0201

Jump_039_6D97::
    ld a, e
    ld hl, $D874
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6DA1
    inc h

Jump_039_6DA1::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr z, Jump_039_6DB2
    jr nc, Jump_039_6DBC

Jump_039_6DAB::
    ld b, h
    ld c, l
    ld a, e
    ldh [$FFC6], a
    jr Jump_039_6DBC

Jump_039_6DB2::
    call Func_000_3ED4
    ld a, [$C5E7]
    bit 1, a
    jr z, Jump_039_6DAB

Jump_039_6DBC::
    inc e
    dec d
    jr nz, Jump_039_6D97
    ld hl, $D8A5
    ldh a, [$FFC6]
    add a, [hl]
    ld [hl], a
    ret

Func_039_6DC8::
    ld a, c
    call Func_000_3E54
    jr c, Func_039_6DF1
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    ldh a, [$FFC7]
    or a, a
    jr z, Jump_039_6DED
    push hl
    ld a, c
    ld hl, $D812
    call Func_000_3F25
    ld a, [hl]
    pop hl
    bit 2, a
    jr z, Jump_039_6DED
    srl h
    rr l

Jump_039_6DED::
    pop de
    add hl, de
    jr Func_039_6DF4

Func_039_6DF1::
    ld hl, $FFFF

Func_039_6DF4::
    ld a, c
    and a, $03
    add a, a
    ld de, $D874
    add a, e
    ld e, a
    jr nc, Jump_039_6E00
    inc d

Jump_039_6E00::
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ret

Func_039_6E06::
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl+]
    and a, $40
    jr nz, Jump_039_6E26
    inc hl
    inc hl
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_6E26
    ld a, [hl+]
    and a, $0C
    jr nz, Jump_039_6E26
    inc hl
    ld a, [hl+]
    and a, $20
    jr nz, Jump_039_6E26
    ld a, [hl]
    and a, $07

Jump_039_6E26::
    ret

Func_039_6E27::
    push bc
    ld a, [$D8A6]
    cp a, $00
    jr z, Jump_039_6E3F
    cp a, $48
    jr c, Jump_039_6E47
    cp a, $66
    jr z, Jump_039_6E47
    cp a, $6B
    jr z, Jump_039_6E4F
    cp a, $6C
    jr z, Jump_039_6E4F

Jump_039_6E3F::
    ld hl, Func_036_7DC9
    ld b, $36
    rst $10
    jr Jump_039_6E5F

Jump_039_6E47::
    ld hl, Func_01A_408F
    ld b, $1A
    rst $10
    jr Jump_039_6E5F

Jump_039_6E4F::
    ld a, [$D8A4]
    call Func_039_71E5
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    jr Jump_039_6E5F

Jump_039_6E5F::
    pop bc
    ret

Func_039_6E61::
    ld a, c
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_039_6E6A
    inc h

Jump_039_6E6A::
    bit 0, [hl]
    ret z
    push af
    push bc
    push de
    push hl
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, $32
    call Func_000_16AA
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    pop hl
    pop de
    pop bc
    pop af
    ret

Func_039_6E8B::
    ld a, $01
    ldh [$FFC7], a
    ld b, $03
    ld a, [$D8A5]
    ld c, a

Jump_039_6E95::
    ld a, c
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_039_6EAB
    ld a, [hl]
    and a, $0C
    jr nz, Jump_039_6EAB
    call Func_039_6DC8
    jr Jump_039_6EAE

Jump_039_6EAB::
    call Func_039_6DF1

Jump_039_6EAE::
    inc c
    dec b
    jr nz, Jump_039_6E95
    call Func_039_6D89
    ret

Func_039_6EB6::
    ld a, $00
    ldh [$FFC6], a
    ld a, $01
    ldh [$FFC7], a
    ld a, $02
    ldh [$FFC8], a

Jump_039_6EC2::
    ldh a, [$FFC7]
    ld hl, $D874
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6ECD
    inc h

Jump_039_6ECD::
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [$FFC6]
    ld hl, $D874
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6EDB
    inc h

Jump_039_6EDB::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr c, Jump_039_6F06
    jr nz, Jump_039_6F0A
    ldh a, [$FFC7]
    ld hl, $D87D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6EF0
    inc h

Jump_039_6EF0::
    ld c, [hl]
    inc hl
    ld b, [hl]
    ldh a, [$FFC6]
    ld hl, $D87D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6EFE
    inc h

Jump_039_6EFE::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    call Func_000_3E7A
    jr nc, Jump_039_6F0A

Jump_039_6F06::
    ldh a, [$FFC7]
    ldh [$FFC6], a

Jump_039_6F0A::
    ld hl, $FFC7
    inc [hl]
    ldh a, [$FFC8]
    dec a
    ldh [$FFC8], a
    jr nz, Jump_039_6EC2
    ldh a, [$FFC6]
    ld c, a
    ld a, [$D8A4]
    and a, $04
    or a, c
    ld [$D8A5], a
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6F2D
    inc h

Jump_039_6F2D::
    ld a, [$D8A5]
    ld [hl], a
    ret

Func_039_6F32::
    ld hl, Func_03B_40CD
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld l, a
    ld a, [$DAC5]
    ld h, a
    ld bc, $03E7
    call Func_000_3E7A
    jr nc, Jump_039_6F65
    add hl, hl
    call Func_000_3E7A
    jr nc, Jump_039_6F62
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_039_6F5C
    ld a, [$D8A4]
    and a, $04
    jr nz, Jump_039_6F65

Jump_039_6F5C::
    add hl, hl
    call Func_000_3E7A
    jr c, Jump_039_6F65

Jump_039_6F62::
    ld hl, $03E7

Jump_039_6F65::
    ret

Func_039_6F66:: ; heuristic: follows a terminator; C0
    ld hl, Func_03B_4111
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld l, a
    ld a, [$DAC5]
    ld h, a
    ld bc, $03E7
    call Func_000_3E7A
    jr nc, Jump_039_6F99
    add hl, hl
    call Func_000_3E7A
    jr nc, Jump_039_6F96
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_039_6F90
    ld a, [$D8A4]
    and a, $04
    jr nz, Jump_039_6F99

Jump_039_6F90::
    add hl, hl
    call Func_000_3E7A
    jr c, Jump_039_6F99

Jump_039_6F96::
    ld hl, $03E7

Jump_039_6F99::
    ret

Func_039_6F9A::
    push bc
    ld hl, $D989
    swap a
    add a, l
    ld l, a
    jr nc, Jump_039_6FA5
    inc h

Jump_039_6FA5::
    ld bc, $0800

Jump_039_6FA8::
    ld a, [hl+]
    cp a, $40
    jr c, Jump_039_6FC0
    cp a, $48
    jr c, Jump_039_6FBF
    cp a, $70
    jr c, Jump_039_6FC0
    cp a, $76
    jr c, Jump_039_6FBF
    cp a, $89
    jr z, Jump_039_6FBF
    jr Jump_039_6FC0

Jump_039_6FBF::
    inc c

Jump_039_6FC0::
    inc hl
    dec b
    jr nz, Jump_039_6FA8
    ld a, c
    or a, a
    pop bc
    ret

Func_039_6FC8::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6FD4
    inc h

Jump_039_6FD4::
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_6FDC
    ldh a, [$FFC9]

Jump_039_6FDC::
    ld e, a
    ldh a, [$FFD0]
    or a, e
    ld [hl], a
    ret

Func_039_6FE2::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_6FEE
    inc h

Jump_039_6FEE::
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_6FFC
    ldh a, [$FFC9]
    cp a, $FF
    jr nz, Jump_039_6FFC
    ldh a, [$FFC8]

Jump_039_6FFC::
    ld e, a
    ldh a, [$FFD0]
    or a, e
    ld [hl], a
    ret

Func_039_7002::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_700E
    inc h

Jump_039_700E::
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_7022
    ldh a, [$FFCA]
    cp a, $FF
    jr nz, Jump_039_7022
    ldh a, [$FFC9]
    cp a, $FF
    jr nz, Jump_039_7022
    ldh a, [$FFC8]

Jump_039_7022::
    ld e, a
    ldh a, [$FFD0]
    or a, e
    ld [hl], a
    ret

Func_039_7028::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_7034
    inc h

Jump_039_7034::
    ldh a, [$FFC6]
    cp a, $FF
    jr nz, Jump_039_7048
    ldh a, [$FFCB]
    cp a, $FF
    jr nz, Jump_039_7048
    ldh a, [$FFCA]
    cp a, $FF
    jr nz, Jump_039_7048
    ldh a, [$FFC9]

Jump_039_7048::
    ld e, a
    ldh a, [$FFD0]
    or a, e
    ld [hl], a
    ret

Func_039_704E::
    ldh a, [$FFC6]
    cp a, $03
    jr z, Jump_039_7069
    cp a, $02
    jr z, Jump_039_705C
    ldh a, [$FFC7]
    jr Jump_039_7084

Jump_039_705C::
    ld a, [$C5E7]
    cp a, $AB
    ldh a, [$FFC7]
    jr c, Jump_039_7084
    ldh a, [$FFC8]
    jr Jump_039_7084

Jump_039_7069::
    ld a, [$C5E7]
    cp a, $80
    ld b, $00
    jr c, Jump_039_707A
    cp a, $D5
    ld b, $01
    jr c, Jump_039_707A
    ld b, $02

Jump_039_707A::
    ld a, b
    ld hl, $FFC7
    add a, l
    ld l, a
    jr nc, Jump_039_7083
    inc h

Jump_039_7083::
    ld a, [hl]

Jump_039_7084::
    ld b, a
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_7091
    inc h

Jump_039_7091::
    ld [hl], b
    ret

Func_039_7093::
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC7], a
    ldh [$FFC8], a
    ldh [$FFC9], a

Jump_039_70A9::
    ld a, c
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_70F4
    ldh [$FFC9], a
    ld hl, $D958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_70BC
    inc h

Jump_039_70BC::
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    push de
    push bc
    ld hl, Func_035_400A
    ld b, $35
    rst $10
    pop bc
    pop de
    ld a, [$D008]
    cp a, d
    jr nz, Jump_039_70F4
    ld a, c
    call Func_039_71F9
    push hl
    ld a, c
    call Func_039_71EA
    pop bc
    add hl, bc
    ldh a, [$FFC7]
    ld c, a
    ldh a, [$FFC8]
    ld b, a
    call Func_000_3E7A
    jr nc, Jump_039_70F4
    ld a, l
    ldh [$FFC7], a
    ld a, h
    ldh [$FFC8], a
    ldh a, [$FFC9]
    ldh [$FFC6], a

Jump_039_70F4::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_70A9
    call Func_039_6FC8
    ret

Func_039_70FD::
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ldh [$FFD0], a
    ld c, a
    ld b, $03
    ld a, $FF
    ldh [$FFC6], a
    ldh [$FFC9], a

Jump_039_710F::
    ld a, c
    push bc
    ld a, c
    call Func_000_3E54
    jr c, Jump_039_714C
    ldh [$FFC9], a
    ld hl, $D958
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_7122
    inc h

Jump_039_7122::
    ld a, [hl+]
    ld [$D006], a
    ld a, [hl]
    ld [$D007], a
    push de
    ld hl, Func_035_400A
    ld b, $35
    rst $10
    pop de
    ld a, [$D008]
    cp a, d
    jr nz, Jump_039_714C
    ldh a, [$FFC6]
    cp a, $FF
    jr z, Jump_039_7148
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $01
    jr z, Jump_039_714C

Jump_039_7148::
    ldh a, [$FFC9]
    ldh [$FFC6], a

Jump_039_714C::
    pop bc
    inc c
    dec b
    jr nz, Jump_039_710F
    call Func_039_6FC8
    ret

Func_039_7155::
    push af
    ldh a, [$FFCE]
    ld l, a
    ldh a, [$FFCF]
    ld h, a
    pop af
    or a, a
    jr z, Jump_039_716D
    cp a, $01
    jr z, Jump_039_716F
    cp a, $02
    jr z, Jump_039_717B
    ld hl, $0000
    jr Jump_039_717F

Jump_039_716D::
    jr Jump_039_717F

Jump_039_716F::
    ld a, $55
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    jr Jump_039_717F

Jump_039_717B::
    sra h
    rr l

Jump_039_717F::
    ret

Func_039_7180::
    push af
    ld a, [$D8A4]
    call Func_039_71FE
    push hl
    ld a, [$D8A4]
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_039_7193
    inc h

Jump_039_7193::
    ld a, [hl]
    pop hl
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_719B
    inc h

Jump_039_719B::
    ld a, $5A
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    pop af
    or a, a
    jr z, Jump_039_71B6
    cp a, $01
    jr z, Jump_039_71B8
    cp a, $02
    jr z, Jump_039_71C4
    ld hl, $0000
    jr Jump_039_71C8

Jump_039_71B6::
    jr Jump_039_71C8

Jump_039_71B8::
    ld a, $55
    call Func_000_16AA
    ld a, $64
    call Func_000_16E2
    jr Jump_039_71C8

Jump_039_71C4::
    sra h
    rr l

Jump_039_71C8::
    ret

Func_039_71C9::
    add a, a
    add a, c
    add a, a
    add a, c
    add a, l
    ld l, a
    jr nc, Jump_039_71D2
    inc h

Jump_039_71D2::
    ld a, [hl]
    ret

Func_039_71D4::
    ld a, c
    ld hl, $D80E
    call Func_000_3F25
    bit 3, [hl]
    ret nz
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $C0
    ret

Func_039_71E5::
    ld hl, $D8FF
    jr Jump_039_7212

Func_039_71EA::
    ld hl, $D90F
    jr Jump_039_7212

Func_039_71EF::
    ld hl, $D8CF
    jr Jump_039_7212

Func_039_71F4::
    ld hl, $D8EF
    jr Jump_039_7212

Func_039_71F9::
    ld hl, $D8BF
    jr Jump_039_7212

Func_039_71FE::
    ld hl, $D8DF
    jr Jump_039_7212

Func_039_7203::
    ld hl, $D91F
    jr Jump_039_7212

Func_039_7208:: ; heuristic: follows a terminator; C0
    ld hl, $DA53
    add a, l
    ld l, a
    jr nc, Jump_039_7210
    inc h

Jump_039_7210::
    ld a, [hl]
    ret

Jump_039_7212::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_7218
    inc h

Jump_039_7218::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_039_721C:: ; heuristic: follows a terminator; C0
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_039_7222
    inc h

Jump_039_7222::
    ret

Func_039_7223:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_039_7238
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_039_7238
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_039_7238::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_039_723E:: ; heuristic: follows a terminator; C0
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_039_7253
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_039_7253
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_039_7253::
    ld a, [$D8A5]
    cp a, $04
    ret
    INCBIN "dwm2-cobi-us.gbc", $0E7259, $CA
    ds $CDD, $00
