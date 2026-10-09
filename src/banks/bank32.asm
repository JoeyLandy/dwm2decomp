SECTION "Bank 32", ROMX[$4000], BANK[$32]
    db $32

Func_032_4001::
    ld a, [$CB75]
    ld l, a
    ld a, [$CB76]
    ld h, a
    ld a, [hl]
    or a, a
    jr z, Jump_032_4012
    call Func_032_401C
    jr Jump_032_401B

Jump_032_4012::
    inc [hl]
    inc hl
    inc hl
    inc hl
    ld [hl], $00
    call Func_032_403F

Jump_032_401B::
    ret

Func_032_401C::
    ld a, [$CB75]
    add a, $05
    ld l, a
    ld a, [$CB76]
    adc a, $00
    ld h, a
    ld a, [hl]
    cp a, $FF
    ret z
    or a, a
    jr z, Jump_032_4032
    dec a
    ld [hl-], a
    ret

Jump_032_4032::
    ld a, [$CB75]
    add a, $03
    ld l, a
    ld a, [$CB76]
    adc a, $00
    ld h, a
    inc [hl]

Func_032_403F::
    call Func_032_4083
    ld a, b
    and a, c
    cp a, $FF
    jr nz, Jump_032_4053
    ld a, [$CB75]
    ld l, a
    ld a, [$CB76]
    ld h, a
    ld [hl], $00
    ret

Jump_032_4053::
    ld a, c
    cp a, $F8
    jr c, Jump_032_4073
    cp a, $FE
    jr nz, Jump_032_406D
    ld a, [$CB75]
    add a, $03
    ld l, a
    ld a, [$CB76]
    adc a, $00
    ld h, a
    ld a, [hl]
    sub a, b
    ld [hl], a
    jr Jump_032_4032

Jump_032_406D::
    cp a, $FD
    jr nz, Jump_032_4073
    jr Jump_032_4032

Jump_032_4073::
    ld a, [$CB75]
    add a, $04
    ld l, a
    ld a, [$CB76]
    adc a, $00
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

Func_032_4083::
    ld a, [$CB75]
    ld c, a
    ld a, [$CB76]
    ld b, a
    inc bc
    inc bc
    ld a, [bc]
    add a, a
    ld hl, Data_032_40A6
    add a, l
    ld l, a
    jr nc, Jump_032_4097
    inc h

Jump_032_4097::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    inc bc
    ld a, [bc]
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_40A2
    inc h

Jump_032_40A2::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

Data_032_40A6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1E, $41, $32, $41, $5E, $41, $90, $41, $B0, $41, $D0, $41, $12, $42, $28, $42
    db $4C, $42, $92, $42, $B0, $42, $CE, $42, $10, $43, $3A, $43, $58, $43, $96, $43
    db $B6, $43, $E4, $43, $24, $44, $3E

Data_032_40CD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C80CD, $44

Data_032_4111:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $49, $C6, $49, $06, $4A, $2A, $4A, $6A, $4A, $8C, $4A, $C4, $4A, $00, $05, $01
    db $05, $02, $05, $03, $05, $04, $02, $05, $02, $06, $02, $07, $02, $1F, $02, $FF
    db $FF, $00, $04, $01, $04, $02, $04, $03, $04, $04, $02, $05, $02, $06

Data_032_413F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $07, $02, $1F, $08, $08, $03, $09, $03, $0A, $03, $0B, $03, $0C, $03, $09

Data_032_414F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $0A, $03, $0B, $02, $0C

Data_032_4155:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C8155, $44

Data_032_4199:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $05, $03, $06, $03, $07, $03, $08, $03, $09, $03, $0A, $03, $0B, $03, $0C
    db $03, $0D, $03, $1F, $02, $FF, $FF, $00, $03, $01, $03, $02, $03, $03, $03, $04
    db $03, $05, $03, $06, $03, $07, $03, $08, $03, $09, $03, $0A, $03, $0B, $03, $0C
    db $03, $0D, $03, $1F, $02, $FF, $FF, $00, $04, $01

Data_032_41D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $02, $02, $03, $04, $04, $05, $05, $03, $06, $04, $07, $03, $08, $04, $04
    db $03, $05, $04, $06, $03, $07, $04, $08, $03, $04, $04, $05, $03, $06, $04, $07
    db $03, $08, $04, $04, $03, $05, $04, $06, $03, $07, $04, $08, $03, $04, $03, $05
    db $04, $06, $03, $07, $04, $08, $03, $09, $04, $0A

Data_032_420D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $05, $1F, $02, $FF, $FF, $00, $04, $01, $02, $02, $04, $03, $04, $04, $02, $00
    db $02, $01, $02, $02, $02, $01, $02, $1F, $02, $FF, $FF, $00, $02, $01, $02, $02
    db $02, $1F, $10, $03, $04, $04, $02, $05, $04, $06, $02, $07, $04, $08, $02, $03
    db $03, $04, $02, $05, $03, $06, $02, $07, $04, $08

Data_032_4247:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $1F, $02, $FF, $FF, $00, $02, $01, $02, $02, $02, $03, $02, $1F, $10, $04
    db $05, $05, $05, $06, $05, $07, $02, $08, $02, $0E, $02, $09, $02, $0F, $02, $0E
    db $02, $10, $02, $0B, $02, $11, $02, $0C, $02, $10, $02, $0B, $02, $11, $02, $0C
    db $02, $12, $02, $0D, $02, $13, $02, $08, $02, $0E

Data_032_4281:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $09, $02, $0F, $02, $0A, $02, $10, $02, $0B, $02, $06, $02, $1F, $02, $FF
    db $FF, $00, $02, $01, $02, $02, $02

Data_032_4298:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $02, $04, $02, $05, $02, $06, $02, $07, $02, $08, $02, $09, $02, $0A, $02
    db $0B, $02, $0C, $02, $1F, $02, $FF, $FF, $00, $03, $01, $03, $02, $04, $03, $04
    db $04, $05, $05

Data_032_42BB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C82BB, $87

Func_032_4342:: ; heuristic: target of a pointer table; C0
    inc b
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    inc bc
    inc bc
    inc bc
    inc b
    rrca
    rra
    inc bc
    inc b
    inc bc
    rra
    inc bc
    inc b
    ld [bc], a
    rra
    ld [bc], a
    rst $38
    rst $38
    ld b, $03
    rlca
    inc bc
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    ld bc, $010B
    inc c
    ld bc, $081F
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    dec b
    ld bc, $021F
    rst $38
    rst $38
    nop
    inc b
    ld bc, $1F03
    ld [$0502], sp
    inc bc
    inc b
    inc b
    inc bc
    dec b
    inc bc
    ld b, $02
    rlca
    ld [bc], a
    inc b
    ld [bc], a
    dec b
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [bc], a
    ld [bc], a
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0203
    ld [bc], a
    rra
    ld [$0503], sp
    inc b
    inc b
    dec b
    inc bc
    ld b, $03
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    dec b
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    inc b
    ld bc, $021F
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0203
    ld [bc], a
    inc bc
    inc bc
    ld [bc], a
    ld bc, $020F
    inc b
    inc bc
    dec b
    inc bc
    ld b, $03
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    ld bc, $010B
    inc c
    ld bc, $010D
    ld b, $03
    rlca
    ld [bc], a
    ld a, [bc]
    ld bc, $010B
    inc c
    ld bc, $010D
    ld [$0903], sp
    ld [bc], a
    ld a, [bc]
    ld bc, $010B
    inc c
    ld bc, $010D
    ld c, $01
    inc b
    ld [bc], a
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0204
    inc b
    inc bc
    inc b
    inc b
    inc b
    dec b
    inc b
    ld b, $04
    rlca
    inc b
    ld [$0904], sp
    inc b
    ld a, [bc]
    inc b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0203
    inc b
    inc bc
    inc bc
    inc b
    ld [bc], a
    dec b
    ld bc, $0106
    rlca
    ld bc, $011F
    rst $38
    rst $38
    nop
    ld a, [bc]
    ld bc, $0208
    rlca
    inc bc
    ld b, $04
    dec b
    dec b
    dec b
    ld b, $05
    rlca
    dec b
    ld [$0904], sp
    inc b
    ld a, [bc]
    inc b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    ld [$0601], sp
    ld [bc], a
    ld [$0603], sp
    inc b
    ld [$0805], sp
    ld b, $08
    rlca
    ld [$0408], sp
    add hl, bc
    inc b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    ld b, $01
    ld b, $02
    ld b, $03
    ld b, $04
    ld [$0805], sp
    ld b, $04
    ld [$0804], sp
    inc b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    ld b, $01
    ld b, $02
    ld b, $03
    ld b, $04
    ld b, $05
    ld b, $1F
    ld [bc], a
    rst $38
    rst $38
    nop
    ld a, [bc]
    ld bc, $0206
    ld b, $03
    ld b, $04
    ld b, $05
    ld b, $1F
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    rra
    inc b
    nop
    inc b
    rra
    inc b
    nop
    inc b
    rra
    inc b
    nop
    inc b
    rra
    inc b
    nop
    inc b
    rra
    inc b
    nop
    inc b
    rra
    rrca
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0203
    inc bc
    rra
    ld [$0203], sp
    inc b
    ld [bc], a
    dec b
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    ld c, $02
    rrca
    ld [bc], a
    db $10, $02 ; stop
    ld de, $1202
    ld [bc], a
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0204
    inc b
    inc bc
    inc b
    inc b
    dec b
    dec b
    inc b
    ld b, $04
    rlca
    inc b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    dec b
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    dec bc
    inc bc
    inc c
    dec b
    dec c
    inc b
    ld c, $03
    rrca
    inc bc
    ld c, $04
    dec c
    inc b
    ld c, $03
    dec bc
    inc bc
    inc de
    inc b
    dec bc
    inc b
    inc c
    dec b

Func_032_4544:: ; heuristic: target of a pointer table; C0
    dec c
    inc b
    ld c, $03
    rrca
    inc b
    ld c, $03
    db $10, $04 ; stop
    ld de, $1204
    inc b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    inc b
    dec b
    dec b
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    inc b
    dec b
    dec b
    inc bc
    ld b, $03
    rra
    ld [$0307], sp
    ld [$0902], sp
    inc b
    ld a, [bc]
    inc b
    dec bc
    inc b
    inc c
    inc b
    dec c
    inc b
    ld c, $03
    rrca
    inc bc
    db $10, $03 ; stop
    ld de, $1203
    inc bc
    inc de
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    inc b
    dec b
    dec b
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    inc bc
    dec bc
    inc b
    inc c
    inc bc
    dec c
    inc bc
    ld c, $03
    rrca
    ld [bc], a
    db $10, $02 ; stop
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    ld c, $02
    rrca
    ld [bc], a
    db $10, $02 ; stop
    dec c
    ld [bc], a
    ld c, $02
    rrca
    ld [bc], a
    db $10, $02 ; stop
    ld a, [bc]
    ld bc, $021F
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    inc b
    dec b
    dec b
    inc bc
    ld b, $03
    rra
    ld [$0207], sp
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    ld c, $02
    rrca
    ld [bc], a
    db $10, $02 ; stop
    ld de, $1202
    ld [bc], a
    inc de
    ld [bc], a
    inc d
    ld [bc], a
    dec d
    ld [bc], a
    ld d, $02
    rla
    ld [bc], a
    jr Jump_032_460C
    db $19, $02

Jump_032_460C::
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    inc b
    dec b
    dec b
    inc bc
    ld b, $03
    rra
    ld [$0507], sp
    ld [$0904], sp
    inc bc
    ld a, [bc]
    inc bc
    dec bc
    inc bc
    ld a, [bc]
    inc b
    dec bc
    ld [$031F], sp
    dec bc
    ld [bc], a
    rra
    ld [bc], a
    dec bc
    ld bc, $011F
    dec bc
    ld bc, $011F
    dec bc
    ld bc, $011F
    dec bc
    ld bc, $021F
    rst $38
    rst $38
    nop
    ld b, $01
    dec b
    ld [bc], a
    dec b
    inc bc
    inc bc
    inc b
    inc b
    dec b
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    inc b
    dec b
    dec b
    inc bc
    ld b, $02
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    ld b, $01
    dec b
    ld [bc], a
    dec b
    inc bc
    dec b
    inc b
    inc bc
    dec b
    inc bc
    ld b, $08
    rlca
    inc bc
    ld b, $03
    rlca
    inc bc
    ld b, $03
    rlca
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld b, $02
    rlca
    ld bc, $0106
    rlca
    ld bc, $0106
    rlca
    ld bc, $0106
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    dec b
    ld bc, $0204
    inc b
    inc bc
    inc b
    inc b
    inc bc
    dec b
    inc bc
    ld b, $03
    dec b
    ld [bc], a
    rlca
    ld [bc], a
    ld [$0702], sp
    ld [bc], a
    rra
    ld [bc], a
    ld [$1F02], sp
    ld [bc], a
    rlca
    ld bc, $011F
    ld [$1F01], sp
    ld bc, $0107
    rra
    ld bc, $0108
    rra
    ld bc, $021F
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0205
    dec b
    inc bc
    inc b
    inc b
    inc b
    dec b
    ld b, $06
    inc b
    rlca
    inc b
    ld [$0703], sp
    ld [bc], a
    ld [$0602], sp
    ld [bc], a
    ld [$0903], sp
    inc bc
    ld [$0902], sp
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    dec bc
    ld [bc], a
    ld a, [bc]
    ld bc, $010B
    ld a, [bc]
    ld bc, $011F
    dec bc
    ld bc, $011F
    ld a, [bc]
    ld bc, $011F
    dec bc
    ld bc, $021F
    rst $38
    rst $38
    nop
    ld bc, $0101
    ld [bc], a
    ld bc, $0203
    inc b
    inc bc
    dec b
    inc bc
    ld b, $03
    rlca
    inc bc
    ld [$0903], sp
    inc bc
    ld a, [bc]
    inc bc
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    rra
    db $01

Func_032_4746:: ; heuristic: target of a pointer table; C0
    ld bc, $1F03
    ld bc, $0302
    rra
    ld bc, $0303
    rra
    ld bc, $0304
    dec b
    inc bc
    inc b
    inc bc
    dec b
    inc bc
    inc b
    inc bc
    dec b
    inc bc
    inc b
    inc bc
    dec b
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0004
    inc bc
    ld bc, $0203
    inc b
    ld bc, $0204
    inc bc
    ld bc, $0303
    inc b
    ld [bc], a
    inc b
    inc bc
    inc bc
    ld [bc], a
    inc bc
    inc b
    inc b
    inc bc
    inc b
    inc b
    inc bc
    inc bc
    inc bc
    dec b
    inc b
    inc b
    inc bc
    ld b, $03
    dec b
    inc b
    rlca
    inc b
    db $10, $04 ; stop
    dec bc
    inc b
    ld de, $0C04
    inc b
    ld [de], a
    inc b
    dec c
    inc b
    inc de
    inc b
    rlca
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0205
    inc b
    inc bc
    inc bc
    inc b
    inc bc
    dec b
    inc bc
    ld b, $03
    rlca
    inc bc
    ld [$1F03], sp
    ld [$0209], sp
    ld a, [bc]
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    ld c, $02
    rrca
    ld [bc], a
    db $10, $02 ; stop
    ld de, $1202
    ld [bc], a
    inc de
    ld [bc], a
    inc d
    ld [bc], a
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    ld c, $02
    rrca
    ld [bc], a
    dec d
    ld [bc], a
    ld d, $02
    rla
    ld [bc], a
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0204
    inc b
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    dec b
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$0502], sp
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$1F02], sp
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0203
    ld b, $03
    ld b, $04
    ld b, $05
    ld b, $06
    ld b, $07
    ld b, $08
    ld b, $09
    ld b, $1F
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    inc b
    inc bc
    inc bc
    inc b
    inc bc
    dec b
    inc b
    ld b, $04
    rlca
    inc bc
    ld [$0703], sp
    inc bc
    add hl, bc
    inc b
    ld a, [bc]
    inc bc
    dec bc
    inc bc
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    dec b
    inc bc
    dec b
    inc b
    dec b
    dec b
    inc b
    ld b, $03
    ld [de], a
    inc bc
    rlca
    ld [bc], a
    inc de
    ld [bc], a
    ld [$1402], sp
    ld [bc], a
    add hl, bc
    ld [bc], a
    dec d
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    ld d, $02
    dec bc
    ld [bc], a
    rla
    ld [bc], a
    inc c
    ld [bc], a
    jr Jump_032_4860
    db $0D, $02

Jump_032_4860::
    add hl, de
    ld [bc], a
    ld c, $02
    ld a, [de]
    ld [bc], a
    rrca
    ld [bc], a
    dec de
    ld [bc], a
    db $10, $02 ; stop
    ld de, $FF02
    rst $38
    nop
    inc b
    ld bc, $0205
    dec b
    inc bc
    inc b
    inc b
    ld b, $05
    inc b
    ld b, $04
    rra
    ld a, [bc]
    rlca
    inc bc
    ld [$0902], sp
    dec b
    ld a, [bc]
    dec b
    dec bc
    dec b
    inc c
    ld b, $0D
    ld b, $0E
    dec b
    rrca
    inc b
    inc c
    inc b
    dec c
    inc b
    ld c, $04
    rrca
    inc bc
    inc c
    inc bc
    dec c
    inc bc
    ld c, $03
    db $10, $02 ; stop
    rrca
    ld [bc], a
    ld de, $1002
    ld [bc], a
    ld de, $FF02
    rst $38
    nop
    inc bc
    ld bc, $0202
    ld [bc], a
    inc bc
    dec b
    inc b
    dec b
    dec b
    ld b, $06
    ld b, $07
    dec b
    ld [$0905], sp
    dec b
    rlca
    inc b
    ld [$0904], sp
    inc b
    rlca
    inc b
    ld [$0904], sp
    inc b
    ld a, [bc]
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0201
    inc b
    inc bc
    ld bc, $0404
    dec b
    ld bc, $0406
    rlca
    ld bc, $0408
    add hl, bc
    ld bc, $040A
    dec bc
    ld bc, $040C
    dec c
    ld bc, $040E
    rrca
    inc bc
    ld c, $04
    rrca
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    dec b
    ld bc, $0205
    dec b
    inc bc
    dec b
    inc b
    dec b
    dec b
    dec b
    ld b, $05
    rlca
    dec b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0203
    inc bc
    inc bc
    inc bc
    inc b
    inc bc
    dec b
    inc bc
    ld b, $03
    rlca
    inc bc
    ld [$0903], sp
    inc bc
    ld a, [bc]
    inc bc
    dec bc
    inc bc
    dec bc
    inc bc
    inc c
    inc bc
    dec c
    inc bc
    ld c, $03
    rrca
    inc bc
    inc de
    inc bc
    db $10, $03 ; stop
    inc d
    inc bc
    ld de, $1503
    inc bc
    ld [de], a
    inc bc
    rrca
    inc bc
    inc de
    ld [bc], a
    db $10, $02 ; stop
    inc d
    ld [bc], a
    ld de, $1502
    ld [bc], a
    ld [de], a
    ld [bc], a
    inc de
    ld [bc], a
    rrca
    ld [bc], a
    ld c, $03
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0204
    inc b
    inc bc
    inc b
    inc b
    inc b
    dec b
    inc b
    ld b, $04
    rlca
    inc b
    ld [$0904], sp
    inc b
    ld a, [bc]
    inc b
    dec bc
    inc b
    inc c
    inc bc
    dec c
    inc bc
    inc c
    inc bc
    ld c, $04
    rrca
    inc bc
    db $10, $02 ; stop
    ld de, $1204
    inc b
    inc de
    inc b
    inc d
    dec e
    rra
    inc bc
    inc d
    inc bc
    rra
    inc bc
    inc d
    inc bc
    rra
    ld [bc], a
    inc d
    ld [bc], a
    rra
    ld bc, $0114
    rra
    ld bc, $0114
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0204
    dec b
    inc bc
    inc b
    inc b
    inc bc
    dec b
    inc b
    ld b, $05
    rlca
    inc b
    ld [$0903], sp
    inc bc
    ld a, [bc]
    inc b
    dec bc
    dec b
    inc c
    ld b, $0D
    inc bc
    ld c, $04
    rrca
    inc b
    db $10, $04 ; stop
    ld de, $1204
    inc b
    inc de
    inc b
    inc d
    inc b
    dec d
    inc b
    ld d, $04
    rla
    inc bc
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0203
    inc bc
    inc bc
    inc bc
    inc b
    ld [bc], a
    dec b
    inc bc
    ld b, $04
    rra
    ld [$0407], sp
    ld [$0904], sp
    inc b
    ld a, [bc]
    inc b
    dec bc
    inc b
    inc c
    inc b
    dec c
    inc b
    ld c, $04
    rrca
    inc b
    db $10, $04 ; stop
    ld de, $1204
    inc bc
    inc de
    inc bc
    ld [de], a
    inc bc
    inc de
    inc bc
    ld [de], a
    inc bc
    inc de
    inc bc
    ld de, $0F02
    ld [bc], a
    ld c, $02
    inc c
    ld [bc], a
    dec bc
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    rst $38
    rst $38
    nop
    ld b, $01
    dec b
    ld [bc], a
    dec b
    inc bc
    inc b
    inc b
    ld [bc], a
    dec b
    inc bc
    inc b
    inc bc
    ld b, $04
    rlca
    ld b, $08
    dec b
    add hl, bc
    inc b
    ld a, [bc]
    inc b
    dec bc
    inc b
    inc c
    inc b
    dec c
    inc b
    ld c, $04
    rrca
    inc b
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0204
    inc bc
    inc bc
    inc b
    inc b
    inc b
    dec b
    inc bc
    ld b, $03
    rlca
    ld [bc], a
    ld [$0702], sp
    inc bc
    ld [$0903], sp
    inc bc
    ld a, [bc]
    inc bc
    dec bc
    inc bc
    inc c
    inc bc
    dec c

Func_032_4A49:: ; heuristic: target of a pointer table; C0
    inc bc
    db $10, $03 ; stop
    ld de, $0E03
    inc bc
    rrca
    inc bc
    db $10, $03 ; stop
    ld de, $0C03
    ld [bc], a
    dec c
    ld [bc], a
    ld [de], a
    ld bc, $011F
    inc de
    ld bc, $011F
    inc d
    ld bc, $011F
    dec d
    ld bc, $FFFF
    nop
    dec b
    ld bc, $0206
    dec b
    inc bc
    inc b
    inc b
    inc b
    dec b
    inc b
    ld b, $04
    rlca
    inc b
    ld [$1F04], sp
    ld a, [bc]
    add hl, bc
    inc bc
    ld a, [bc]
    inc bc
    dec bc
    inc bc
    inc c
    inc bc
    dec c
    inc bc
    ld c, $03
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0203
    inc bc
    inc bc
    inc bc
    db $10, $03 ; stop
    inc b
    inc bc
    ld de, $0503
    inc bc
    ld [de], a
    inc bc
    ld b, $03
    inc de
    inc bc
    rlca
    inc bc
    inc d
    inc bc
    ld [$1503], sp
    inc bc
    add hl, bc
    inc bc
    ld d, $03
    ld a, [bc]
    inc bc
    rla
    inc bc
    dec bc
    inc bc
    jr Jump_032_4AB9
    db $0C, $03, $19

Jump_032_4AB9::
    inc bc
    dec c
    inc bc
    ld a, [de]
    inc bc
    ld c, $03
    rrca
    inc bc
    rst $38
    rst $38
    nop
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    inc b
    ld [bc], a
    dec b
    ld [bc], a
    ld b, $02
    rlca
    ld [bc], a
    ld [$0902], sp
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    rst $38
    rst $38

Func_032_4ADC::
    ld a, [$CFCB]
    rst $00
    dw Jump_032_4AF4
    dw Jump_032_4EF2
    dw Jump_032_544A
    dw Jump_032_5474
    dw Jump_032_54AF
    dw Jump_032_5519
    dw Jump_032_5541
    dw Func_032_55EE
    dw Jump_032_5770
    dw Jump_032_578B

Jump_032_4AF4::
    ld a, [$CFCC]
    rst $00
    dw Jump_032_4B04
    dw Jump_032_4B62
    dw Jump_032_4BE1
    dw Jump_032_4C0A
    dw Jump_032_4C27
    dw Jump_032_4C30

Jump_032_4B04::
    call Func_032_4E29
    ld a, [$DABD]
    or a, a
    jr z, Jump_032_4B14
    ld a, $04
    ld [$CFCC], a
    jr Jump_032_4B61

Jump_032_4B14::
    ld a, [$D89E]
    cp a, $09
    jr z, Jump_032_4B38
    ld hl, $D895
    call Func_032_57FD
    cp a, $FF
    jr z, Jump_032_4B38
    cp a, $10
    jr nz, Jump_032_4B3F
    ld a, $08
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    jr Jump_032_4B61

Jump_032_4B38::
    ld a, $05
    ld [$CFCC], a
    jr Jump_032_4B61

Jump_032_4B3F::
    ld [$D8A4], a
    call Func_000_3E54
    jr c, Jump_032_4B5D
    ld a, [$D8A4]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_4B52
    inc h

Jump_032_4B52::
    ld a, [hl]
    cp a, $03
    jr z, Jump_032_4B5D
    ld hl, $CFCC
    inc [hl]
    jr Jump_032_4B62

Jump_032_4B5D::
    ld hl, $D89E
    inc [hl]

Jump_032_4B61::
    ret

Jump_032_4B62::
    ld a, [$D8A4]
    ld hl, $D811
    call Func_000_3F25
    ld a, [hl-]
    and a, $C0
    jr z, Jump_032_4B7A
    ld d, $15
    ld hl, Data_032_6EE5
    ld b, $3A
    rst $10
    jr Jump_032_4BD8

Jump_032_4B7A::
    dec hl
    ld a, [hl+]
    and a, $C0
    jr z, Jump_032_4B98
    ld a, [$D8A4]
    push af
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_4B8D
    inc h

Jump_032_4B8D::
    pop af
    ld [hl-], a
    ld [hl], $CD
    ld a, $03
    ld [$CFCC], a
    jr Jump_032_4BE0

Jump_032_4B98::
    ld a, [hl-]
    and a, $0C
    jr z, Jump_032_4BC6
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_4BC6
    ld a, $CA
    bit 6, [hl]
    jr nz, Jump_032_4BAD
    ld a, $CB

Jump_032_4BAD::
    push af
    ld a, [$D8A4]
    push af
    ld hl, $DA1D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_4BBB
    inc h

Jump_032_4BBB::
    pop af
    ld [hl-], a
    pop af
    ld [hl], a
    ld a, $04
    ld [$CFCC], a
    jr Jump_032_4BE0

Jump_032_4BC6::
    call Func_032_4C3E
    jr nc, Jump_032_4BD1
    ld hl, $CFCC
    inc [hl]
    jr Jump_032_4BE1

Jump_032_4BD1::
    ld a, [$CFCC]
    cp a, $04
    jr z, Jump_032_4BE0

Jump_032_4BD8::
    xor a, a
    ld [$CFCC], a
    ld hl, $D89E
    inc [hl]

Jump_032_4BE0::
    ret

Jump_032_4BE1::
    ld hl, $CFCC
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    bit 5, [hl]
    jr z, Jump_032_4C0A
    call Func_032_4C9C
    jr nc, Jump_032_4C0A
    ld a, [$D8A4]
    call Func_032_6803
    ld a, h
    or a, l
    ret nz
    ld a, $09
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_4C0A::
    ld hl, $CFCC
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    bit 4, [hl]
    jr z, Jump_032_4C27
    call Func_032_4D99
    ld d, $14
    ld hl, Data_032_6EE5
    ld b, $3A
    rst $10
    ret

Jump_032_4C27::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_4C30::
    ld a, $09
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Func_032_4C3E::
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    bit 6, [hl]
    jr z, Jump_032_4C4F
    ld d, $17
    jr Jump_032_4C91

Jump_032_4C4F::
    bit 7, [hl]
    jr z, Jump_032_4C5A
    call Func_032_4E51
    jr c, Jump_032_4C91
    jr Jump_032_4C97

Jump_032_4C5A::
    ld bc, $0003
    add hl, bc
    bit 2, [hl]
    jr z, Jump_032_4C66
    ld d, $1A
    jr Jump_032_4C91

Jump_032_4C66::
    bit 0, [hl]
    jr z, Jump_032_4C6E
    ld d, $16
    jr Jump_032_4C91

Jump_032_4C6E::
    bit 1, [hl]
    jr z, Jump_032_4C76
    ld d, $18
    jr Jump_032_4C91

Jump_032_4C76::
    bit 3, [hl]
    jr z, Jump_032_4C7E
    ld d, $19
    jr Jump_032_4C91

Jump_032_4C7E::
    bit 4, [hl]
    jr z, Jump_032_4C86
    ld d, $1B
    jr Jump_032_4C91

Jump_032_4C86::
    bit 5, [hl]
    jr z, Jump_032_4C8E
    ld d, $1C
    jr Jump_032_4C91

Jump_032_4C8E::
    scf
    jr Jump_032_4C9B

Jump_032_4C91::
    ld hl, Data_032_6EE5
    ld b, $3A
    rst $10

Jump_032_4C97::
    call Func_032_4EE4
    xor a, a

Jump_032_4C9B::
    ret

Func_032_4C9C::
    call Func_000_3ED4
    ld a, [$C5E7]
    cp a, $40
    jr nc, Jump_032_4CB7
    ld a, [$C5E8]
    cp a, $40
    jr c, Jump_032_4CB9
    cp a, $80
    jr c, Jump_032_4CCB
    cp a, $C0
    jr c, Jump_032_4CF7
    jr Jump_032_4D0B

Jump_032_4CB7::
    xor a, a
    ret

Jump_032_4CB9::
    ld hl, $D89E
    inc [hl]
    call Func_032_4D8D
    ld d, $0F
    call Func_032_4D23
    xor a, a
    ld [$CFCC], a
    jr Jump_032_4D2A

Jump_032_4CCB::
    call Func_032_4D2C
    jr nc, Jump_032_4CD4
    xor a, a
    ld [de], a
    dec de
    ld [de], a

Jump_032_4CD4::
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_032_4CB7
    ld a, [$D8A4]
    call Func_032_687F
    ld d, $10
    call Func_032_4D23
    ld a, [$D8A4]
    call Func_032_6803
    ld a, h
    or a, l
    jr nz, Jump_032_4D2A
    jr Jump_032_4D2A

Jump_032_4CF7::
    call Func_032_4D5A
    ld a, b
    or a, c
    jr z, Jump_032_4CB7
    ld a, [$D8A4]
    call Func_032_688C
    ld d, $11
    call Func_032_4D23
    jr Jump_032_4D2A

Jump_032_4D0B::
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    set 4, [hl]
    ld a, [$D8A4]
    call Func_032_6899
    ld d, $12
    call Func_032_4D23
    jr Jump_032_4D2A

Func_032_4D23::
    ld hl, Data_032_6EE5
    ld b, $3A
    rst $10
    ret

Jump_032_4D2A::
    scf
    ret

Func_032_4D2C::
    ld a, [$D8A4]
    ld hl, $D8BF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_4D38
    inc h

Jump_032_4D38::
    push hl
    ld a, l
    add a, $10
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, $06
    call Func_000_16D1
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    pop de
    ld a, [de]
    sub a, l
    ld [de], a
    inc de
    ld a, [de]
    sbc a, h
    ld [de], a
    ret

Func_032_4D5A::
    ld a, [$D8A4]
    call Func_032_67FE
    ld a, h
    or a, l
    jr nz, Jump_032_4D69
    ld bc, $0000
    jr Jump_032_4D84

Jump_032_4D69::
    ld a, $06
    call Func_000_16D1
    push hl
    ld a, [$D8A4]
    ld hl, $D8DF
    add a, a
    call Func_032_57FD
    pop bc
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    jr nc, Jump_032_4D84
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_032_4D84::
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    ret

Func_032_4D8D::
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld [hl], $00
    ret

Func_032_4D99::
    call Func_000_3ED4
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_4DAF
    ld a, [hl]
    and a, $0C
    jr z, Jump_032_4DB3

Jump_032_4DAF::
    ld a, $C9
    jr Jump_032_4DF7

Jump_032_4DB3::
    ld a, [$C5E7]
    cp a, $80
    jr c, Jump_032_4DF1
    cp a, $C0
    jr c, Jump_032_4DF5
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_032_4DD1
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_032_4DD1
    ld hl, Data_032_4E20
    jr Jump_032_4DD4

Jump_032_4DD1::
    ld hl, Data_032_4E1C

Jump_032_4DD4::
    ld a, [$C5E8]
    ld b, a
    ld a, [hl+]
    call Func_000_16BF
    call Func_032_57FD
    cp a, $C8
    jr nz, Jump_032_4DF7
    ld a, [$CFC5]
    cp a, $02
    jr c, Jump_032_4DEE
    ld a, $C7
    jr Jump_032_4DF7

Jump_032_4DEE::
    ld a, [hl]
    jr Jump_032_4DF7

Jump_032_4DF1::
    ld a, $C0
    jr Jump_032_4DF7

Jump_032_4DF5::
    ld a, $C1

Jump_032_4DF7::
    ld b, a
    ld [$D8A6], a
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_4E07
    inc h

Jump_032_4E07::
    ld [hl], b
    ld hl, Func_032_4001
    ld b, $39
    rst $10
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    call Func_032_57FD
    ld [$D8A5], a
    ret

Data_032_4E1C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $C2, $C3, $C5

Data_032_4E20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C6

Func_032_4E29::
    xor a, a
    ld [$DAD2], a
    xor a, a
    ld [$DABE], a
    ld a, $FF
    ld [$D802], a
    xor a, a
    ld [$CFCC], a
    ld a, [$DABD]
    or a, a
    ret nz
    xor a, a
    ld [$DABA], a
    xor a, a
    ld [$DABF], a
    ld a, $FF
    ld [$DAD1], a
    xor a, a
    ld [$C970], a
    ret

Func_032_4E51::
    ld a, [hl]
    and a, $0C
    jr z, Jump_032_4E6A
    cp a, $04
    jr z, Jump_032_4E66
    cp a, $08
    jr z, Jump_032_4E62
    ld b, $60
    jr Jump_032_4E6C

Jump_032_4E62::
    ld b, $A0
    jr Jump_032_4E6C

Jump_032_4E66::
    ld b, $E0
    jr Jump_032_4E6C

Jump_032_4E6A::
    ld b, $FF

Jump_032_4E6C::
    ld a, [$C5E7]
    cp a, b
    jr z, Jump_032_4E8F
    jr c, Jump_032_4E8F
    ld a, [hl]
    and a, $F3
    ld b, a
    ld a, [hl]
    and a, $0C
    dec a
    push bc
    push af
    pop bc
    bit 5, c
    pop bc
    jr nz, Jump_032_4E88
    and a, $0C
    jr Jump_032_4E89

Jump_032_4E88::
    xor a, a

Jump_032_4E89::
    or a, b
    ld [hl], a
    ld d, $13
    scf
    ret

Jump_032_4E8F::
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [$D8A4]
    call Func_032_6899
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_4EBE
    ld a, [hl]
    and a, $0C
    jr z, Jump_032_4ED3
    ld a, [hl]
    and a, $F3
    ld [hl], a
    jr Jump_032_4EC3

Jump_032_4EBE::
    dec hl
    ld a, [hl]
    and a, $3F
    ld [hl], a

Jump_032_4EC3::
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a

Jump_032_4ECA::
    add a, l
    ld l, a
    jr nc, Jump_032_4ECF
    inc h

Jump_032_4ECF::
    ld [hl], $BF
    jr Jump_032_4EDB

Jump_032_4ED3::
    ld d, $82
    ld hl, Data_032_7193
    ld b, $3A
    rst $10

Jump_032_4EDB::
    ld a, [$D871]
    ld [$D8A5], a
    scf
    ccf
    ret

Func_032_4EE4::
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    ld [hl], a
    ret

Jump_032_4EF2::
    ld a, [$CFCC]
    rst $00
    dw Jump_032_4F53
    dw Jump_032_5000
    dw Jump_032_50B7
    dw Jump_032_510E
    dw Jump_032_5130

Jump_032_4F00::
    dw $4CCD
    dw $3851
    dw Jump_032_7A49
    dw $07FE
    dw Jump_032_4ECA

Func_032_4F0A:: ; heuristic: follows a terminator; C0
    ld c, a
    and a, $07
    jr z, Jump_032_4F32
    push de
    ld hl, Data_032_7508
    ld b, $3A
    rst $10
    pop af
    cp a, $01
    call nz, Func_032_5386
    call Func_032_543C
    ld hl, Data_032_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    call Func_032_691C
    ret nz
    ld hl, Data_032_413F
    ld b, $A3
    rst $10
    ret

Jump_032_4F32::
    ld hl, Data_032_7715
    ld b, $3A
    rst $10
    call Func_032_543C
    ld hl, Data_032_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    call Func_032_691C
    ret nz
    ld hl, Data_032_413F
    ld b, $A3
    rst $10
    ret
    db $21, $CC, $CF, $34, $C9

Jump_032_4F53::
    ld hl, $4960
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_032_4F00
    call Func_032_5804
    call Func_032_535F
    jp nc, Jump_032_4FFB
    call Func_032_51F9
    jr c, Jump_032_4F9C
    ld a, [$D8A4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_032_4F77
    inc h

Jump_032_4F77::
    bit 7, [hl]
    jr z, Jump_032_4F85
    ld a, [$D8A4]
    call Func_032_6812
    cp a, $02
    jr nc, Jump_032_4FC8

Jump_032_4F85::
    ld a, d
    cp a, $07
    jp z, Jump_032_4FFB
    push de
    ld hl, Data_032_7508
    ld b, $3A
    rst $10
    pop af
    cp a, $01
    call nz, Func_032_5386
    call Func_032_543C
    ret

Jump_032_4F9C::
    ld a, [$D8A4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_032_4FA7
    inc h

Jump_032_4FA7::
    bit 7, [hl]
    jr z, Jump_032_4FFB
    ld a, [$D8A4]
    ld hl, $DAE0
    call Func_032_57FD
    or a, a
    jr nz, Jump_032_4FFB
    ld a, [$CFF3]
    bit 2, a
    jr nz, Jump_032_4FFB
    ld a, [$D8A4]
    call Func_032_6812
    cp a, $03
    jr c, Jump_032_4FFB

Jump_032_4FC8::
    ld a, [$D8A6]
    cp a, $6E
    jr z, Jump_032_4FFB
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $10
    jr nz, Jump_032_4FFB
    ld hl, $5440
    ld b, $30
    rst $10
    call Func_032_5804
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    call Func_032_57FD
    ld [$D8A6], a
    inc hl
    ld [hl], $FF
    call Func_032_51F9
    jr nc, Jump_032_4F85

Jump_032_4FFB::
    ld hl, $CFCC
    inc [hl]
    ret

Jump_032_5000::
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_032_5073
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_032_5073
    ld a, [$D89E]
    or a, a
    jr z, Jump_032_5073
    ld b, a
    ld hl, $D895

Jump_032_5018::
    ld a, [hl]
    cp a, $10
    jr z, Jump_032_5043
    cp a, $04
    jr c, Jump_032_5043
    push hl
    ld hl, $DA5B
    call Func_032_57FD
    pop hl
    cp a, $03
    jr z, Jump_032_5031
    cp a, $FE
    jr nz, Jump_032_5043

Jump_032_5031::
    push hl
    ld a, [hl]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_503C
    inc h

Jump_032_503C::
    ld a, [$D8A6]
    cp a, [hl]
    pop hl
    jr z, Jump_032_5049

Jump_032_5043::
    inc hl
    dec b
    jr nz, Jump_032_5018
    jr Jump_032_5073

Jump_032_5049::
    ld a, [$D8A6]
    ld c, a
    push hl
    ld hl, Data_032_5078

Jump_032_5051::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_032_505B
    cp a, c
    jr z, Jump_032_505E
    jr Jump_032_5051

Jump_032_505B::
    pop hl
    jr Jump_032_5043

Jump_032_505E::
    pop hl
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_506B
    inc h

Jump_032_506B::
    ld [hl], $00
    inc hl
    ld [hl], $FF
    call Func_032_5804

Jump_032_5073::
    ld hl, $CFCC
    inc [hl]
    ret

Data_032_5078:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13
    db $14, $15, $19, $1A, $26, $28, $2A, $2C, $2E, $2F, $30, $33, $3D, $3E, $3F, $40
    db $41
    dw Func_032_4342
    dw Func_032_4544
    dw Func_032_4746
    dw Func_032_4A49
    db $4B, $4D, $4E, $4F, $64, $65, $66, $67, $6B, $6C, $6D, $6F, $70, $71, $72, $73
    db $74, $79, $7A, $8E, $90, $FF

Jump_032_50B7::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    call Func_032_57FD
    cp a, $FF
    jr z, Jump_032_50F6
    ld a, [$D8A4]
    ld hl, $DAD8
    add a, l
    ld l, a
    jr nc, Jump_032_50D0
    inc h

Jump_032_50D0::
    bit 7, [hl]
    jr nz, Jump_032_50DD
    ld a, [$CFF2]
    and a, $0F
    cp a, $01
    jr z, Jump_032_50FC

Jump_032_50DD::
    ld a, [$D8A4]
    call Func_032_6812
    cp a, $02
    jr nc, Jump_032_50F6
    ld a, [$CFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_032_50F6
    cp a, $04
    jr z, Jump_032_50F6
    jr Jump_032_50FC

Jump_032_50F6::
    ld hl, Func_032_4001
    ld b, $39
    rst $10

Jump_032_50FC::
    ld a, [$D8A4]
    ld hl, $DA1D
    add a, a
    call Func_032_57FD
    ld [$D8A5], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_032_510E::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ld a, [$D8A6]
    call Func_000_3F47
    ret nz
    ld d, $02
    ld hl, Data_032_7508
    ld b, $3A
    rst $10
    ld a, [$CFEE]
    or a, a
    call nz, Func_032_5386
    call Func_032_543C
    ret

Jump_032_5130::
    call Func_032_51F9
    jr c, Jump_032_5143
    ld a, d
    cp a, $07
    jr z, Jump_032_5143
    cp a, $01
    call nz, Func_032_5386
    call Func_032_543C
    ret

Jump_032_5143::
    ld hl, $CFCC
    dec [hl]
    ld hl, $CFCC
    dec [hl]
    ret

Func_032_514C:: ; heuristic: follows a terminator; C0
    xor a, a
    ldh [$FFC7], a
    ld a, [$D8A4]
    add a, a
    ld hl, $DA2C
    call Func_032_57FD
    ld [$CFEC], a
    ld a, $00
    ld [$CFED], a
    ld hl, Func_032_4001
    ld b, $1A
    rst $10
    ld a, [$CFEE]
    ldh [$FFC8], a
    ld a, [$D8A4]
    call Func_032_68FD
    jr nc, Jump_032_5178
    ld d, $00
    jr Jump_032_517D

Jump_032_5178::
    call Func_032_51F9
    jr c, Jump_032_5181

Jump_032_517D::
    ld a, $01
    ldh [$FFC7], a

Jump_032_5181::
    push de
    ld a, [$D8A4]
    push af
    ld hl, Data_032_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    add a, a
    ld hl, $DA2C
    call Func_032_57FD
    ld [$CFEC], a
    ld a, $00
    ld [$CFED], a
    ld hl, Func_032_4001
    ld b, $1A
    rst $10
    ld a, [$CFEE]
    ldh [$FFC8], a
    ld a, [$D8A4]
    call Func_032_68FD
    jr c, Jump_032_51C3
    ld a, [$D8A4]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_51BE
    inc h

Jump_032_51BE::
    ld a, [hl]
    cp a, $03
    jr nz, Jump_032_51C7

Jump_032_51C3::
    ld d, $00
    jr Jump_032_51CC

Jump_032_51C7::
    call Func_032_51F9
    jr c, Jump_032_51D2

Jump_032_51CC::
    ldh a, [$FFC7]
    or a, $02
    ldh [$FFC7], a

Jump_032_51D2::
    pop af
    ld [$D8A4], a
    ldh a, [$FFC7]
    or a, a
    jr z, Jump_032_51F3
    bit 0, a
    jr z, Jump_032_51E2
    pop de
    jr Jump_032_51EC

Jump_032_51E2::
    bit 1, a
    jr z, Jump_032_51EB
    ld a, d
    pop de
    ld d, a
    jr Jump_032_51EC

Jump_032_51EB::
    pop de

Jump_032_51EC::
    push de
    call Func_032_5804
    pop de
    xor a, a
    ret

Jump_032_51F3::
    call Func_032_5804
    pop de
    scf
    ret

Func_032_51F9::
    ld a, [$D8A6]
    cp a, $D0
    jr c, Jump_032_5206
    cp a, $E4
    jr nc, Jump_032_5206
    jr Jump_032_520B

Jump_032_5206::
    ld a, [$CFEE]
    ldh [$FFC8], a

Jump_032_520B::
    ld a, [$D8A4]
    call Func_032_6808
    ldh a, [$FFC8]
    or a, a
    jr z, Jump_032_522D
    ld a, h
    or a, l
    jp z, Jump_032_5296
    ldh a, [$FFC8]
    cp a, $FF
    jr z, Jump_032_522D
    ld c, a
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    bit 7, h
    jr nz, Jump_032_5296

Jump_032_522D::
    ld a, [$D8A6]
    call Func_000_3F47
    jr z, Jump_032_529A
    ld a, [$CFF3]
    bit 6, a
    jr z, Jump_032_5243
    call Func_032_529E
    jr nc, Jump_032_529C
    jr Jump_032_5259

Jump_032_5243::
    bit 4, a
    jr z, Jump_032_524E
    call Func_032_5303
    jr nc, Jump_032_529C
    jr Jump_032_5259

Jump_032_524E::
    bit 5, a
    jr z, Jump_032_5259
    call Func_032_534A
    jr nc, Jump_032_529C
    jr Jump_032_5259

Jump_032_5259::
    ld a, [$D8A4]
    call Func_032_6812
    cp a, $02
    jr c, Jump_032_5294
    ld a, [$CFF3]
    bit 3, a
    jr z, Jump_032_5294
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, $D80E
    call Func_000_3F25

Jump_032_527A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_032_5284
    bit 3, [hl]
    jr z, Jump_032_5294

Jump_032_5284::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_527A
    ld d, $07
    jr Jump_032_529C

Jump_032_5294::
    scf
    ret

Jump_032_5296::
    ld d, $01
    jr Jump_032_529C

Jump_032_529A::
    ld d, $02

Jump_032_529C::
    xor a, a
    ret

Func_032_529E::
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    bit 0, [hl]
    jr nz, Jump_032_52F9
    ld hl, $D80A
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_032_52B8
    ld hl, $D80B

Jump_032_52B8::
    bit 3, [hl]
    jp nz, Jump_032_52FD
    ld a, [$D8A4]
    call Func_032_6812
    cp a, $02
    jr c, Jump_032_5301
    ld a, [$CFF2]
    cp a, $12
    jr nz, Jump_032_5301
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, $D80E
    call Func_000_3F25

Jump_032_52DE::
    ld a, c
    call Func_000_3E54
    jr c, Jump_032_52E9
    ld a, [hl]
    and a, $22
    jr z, Jump_032_5301

Jump_032_52E9::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_52DE
    ld d, $07
    jr Jump_032_52FF

Jump_032_52F9::
    ld d, $03
    jr Jump_032_52FF

Jump_032_52FD::
    ld d, $04

Jump_032_52FF::
    xor a, a
    ret

Jump_032_5301::
    scf
    ret

Func_032_5303::
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    bit 7, [hl]
    jr nz, Jump_032_5344
    ld a, [$D8A4]
    call Func_032_6812
    cp a, $02
    jr c, Jump_032_5348
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, $D80E
    call Func_000_3F25

Jump_032_532A::
    ld a, c
    call Func_000_3E54
    jr c, Jump_032_5334
    bit 6, [hl]
    jr z, Jump_032_5348

Jump_032_5334::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_532A
    ld d, $07
    jr Jump_032_5346

Jump_032_5344::
    ld d, $05

Jump_032_5346::
    xor a, a
    ret

Jump_032_5348::
    scf
    ret

Func_032_534A::
    ld a, [$D8A4]
    ld hl, $D80D
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_032_5359
    jr Jump_032_535D

Jump_032_5359::
    ld d, $06
    xor a, a
    ret

Jump_032_535D::
    scf
    ret

Func_032_535F::
    ld a, [$D8A6]
    cp a, $BF
    jr z, Jump_032_5384
    cp a, $C9
    jr z, Jump_032_5384
    cp a, $CA
    jr z, Jump_032_5384
    cp a, $CB
    jr z, Jump_032_5384
    cp a, $CC
    jr z, Jump_032_5384
    cp a, $CD
    jr z, Jump_032_5384
    cp a, $CE
    jr z, Jump_032_5384
    cp a, $CF
    jr z, Jump_032_5384
    scf
    ret

Jump_032_5384::
    xor a, a
    ret

Func_032_5386::
    ld a, [$D8A6]
    cp a, $D0
    jr c, Jump_032_5393
    cp a, $E4
    jr nc, Jump_032_5393
    jr Jump_032_53C8

Jump_032_5393::
    call Func_032_535F
    ret nc

Func_032_5397::
    ld a, [$D8A4]
    ld hl, $D8DF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_53A3
    inc h

Jump_032_53A3::
    ld a, [$CFEE]
    or a, a
    ret z
    cp a, $FF
    jr z, Jump_032_53B6
    ld c, a
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, $00
    ld [hl], a
    jr Jump_032_53C1

Jump_032_53B6::
    ld a, [hl+]
    ld [$D866], a
    ld a, [hl]
    ld [$D867], a
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_032_53C1::
    ld a, [$D8A4]
    call Func_032_688C
    ret

Jump_032_53C8::
    cp a, $D6
    jr z, Jump_032_541A
    cp a, $D9
    jr z, Jump_032_541A
    ld a, [$D8A4]
    ld hl, $DA2C
    add a, a
    call Func_032_57FD
    ld [$CFEC], a
    ld a, $00
    ld [$CFED], a
    ld hl, Func_032_4001
    ld b, $1A
    rst $10
    call Func_032_5397
    ld a, [$D8A4]
    push af
    ld hl, Data_032_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    ld hl, $DA2C
    add a, a
    call Func_032_57FD
    ld [$CFEC], a
    ld a, $00
    ld [$CFED], a
    ld hl, Func_032_4001
    ld b, $1A
    rst $10
    call Func_032_5397
    pop af
    ld [$D8A4], a
    call Func_032_5804
    ret

Jump_032_541A::
    ld a, $FF
    ld [$CFEE], a
    call Func_032_5397
    ld a, [$D8A4]
    push af
    ld hl, Data_032_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_032_5397
    pop af
    ld [$D8A4], a
    call Func_032_5804
    ret

Func_032_543C::
    ld a, $07
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_544A::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D854
    add a, a
    call Func_032_57FD
    and a, $54
    ret z
    bit 6, a
    jr nz, Jump_032_546B
    bit 2, a
    jr nz, Jump_032_5467
    ld d, $32
    jr Jump_032_546D

Jump_032_5467::
    ld d, $30
    jr Jump_032_546D

Jump_032_546B::
    ld d, $34

Jump_032_546D::
    ld hl, Data_032_6EE5
    ld b, $3A
    rst $10
    ret

Jump_032_5474::
    ld hl, $CFCB
    inc [hl]
    ld hl, Data_032_6D76
    ld b, $3A
    rst $10
    ld a, $80
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    ld a, [$C58A]
    or a, a
    ret nz
    ld a, [$CFC5]
    cp a, $04
    ret c
    cp a, $06
    ret nc
    ld a, [$D8A4]
    cp a, $04
    ret c
    ld a, [$D8A6]
    or a, a
    ret z
    cp a, $AB
    ret z
    cp a, $AC
    ret z
    cp a, $B0
    ret nc
    ld [$D093], a
    ret

Jump_032_54AF::
    ld hl, $CFCB
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr nz, Jump_032_54F5
    ld a, [$D8A4]
    ld hl, $D80C
    call Func_000_3F25
    bit 6, [hl]
    jr nz, Jump_032_54E0
    ld a, [$D8A4]
    ld de, $D8A7
    add a, e
    ld e, a
    jr nc, Jump_032_54DB
    inc d

Jump_032_54DB::
    ld a, [de]
    bit 4, a
    jr nz, Jump_032_54EA

Jump_032_54E0::
    ld hl, $CFCA
    inc [hl]
    ld a, $06
    ld [$CFCB], a
    ret

Jump_032_54EA::
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call Func_032_543C
    ret

Jump_032_54F5::
    ld a, [$D8A4]
    ld hl, $D854
    add a, a
    call Func_032_57FD
    and a, $03
    ret z
    bit 0, a
    jr nz, Jump_032_550A
    ld d, $2F
    jr Jump_032_5512

Jump_032_550A::
    ld a, [$CFF4]
    bit 3, a
    ret z
    ld d, $2E

Jump_032_5512::
    ld hl, Data_032_6EE5
    ld b, $3A
    rst $10
    ret

Jump_032_5519::
    ld a, [$DC00]
    ld hl, $DC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    call Func_032_553B
    ret z
    ld a, $80
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ret

Func_032_553B::
    ld a, [$D8A6]
    cp a, $CD
    ret

Jump_032_5541::
    ld a, [$CFCC]
    rst $00
    dw Jump_032_554D
    dw Jump_032_55C2
    dw Jump_032_55CF
    dw Jump_032_55E7

Jump_032_554D::
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    call Func_032_57FD
    ld [$D8A6], a
    inc hl
    ld a, [hl]
    ld [$D8A5], a
    ld a, [$CFF6]
    bit 7, a
    jr z, Jump_032_55A9
    ld a, [$CFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_032_5585
    ld a, [$D8A6]
    cp a, $35
    jr z, Jump_032_5585
    ld a, [$D8A5]
    ld hl, $D814
    call Func_000_3F25
    bit 4, [hl]
    jr nz, Jump_032_55B2
    jr Jump_032_55A9

Jump_032_5585::
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, $D814
    call Func_000_3F25

Jump_032_5593::
    ld a, c
    call Func_000_3E54
    jr c, Jump_032_559D
    bit 4, [hl]
    jr nz, Jump_032_55B2

Jump_032_559D::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_5593

Jump_032_55A9::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_55B2::
    res 4, [hl]
    ld hl, $DAAC
    ld a, [hl+]
    ld [hl-], a
    ld a, [$D8A6]
    ld [hl], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_032_55C2::
    ld hl, $CFCC
    inc [hl]
    ld d, $B0
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ret

Jump_032_55CF::
    ld hl, $CFCC
    inc [hl]
    ld a, [$DAAD]
    cp a, $FF
    ret z
    ld d, $92
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld a, $FF
    ld [$DAAD], a
    ret

Jump_032_55E7::
    call Func_032_5386
    call Func_032_543C
    ret

Func_032_55EE::
    ld hl, $CFCB
    inc [hl]
    ld a, [$C58A]
    or a, a
    ret z
    cp a, $02
    ret z
    ld a, [$D043]
    or a, a
    ret z
    ld a, [$DABA]
    or a, a
    ret nz
    call Func_032_535F
    ret nc
    ld a, [$D044]
    bit 7, a
    ret z
    ld b, a
    ld a, [$D8A6]
    ld hl, Data_032_5688
    add a, l
    ld l, a
    jr nc, Jump_032_561A
    inc h

Jump_032_561A::
    ld a, [hl]
    or a, a
    ret z
    and a, b
    ret z
    ld c, a
    ld a, [$D045]
    and a, c
    jr z, Jump_032_563B
    ld hl, $D057
    ld a, [$D8A4]
    cp a, $04
    jr c, Jump_032_5633
    ld hl, $D058

Jump_032_5633::
    ld a, c
    and a, [hl]
    jr nz, Jump_032_563B
    ld a, c
    or a, [hl]
    ld [hl], a
    ret

Jump_032_563B::
    ld a, $02
    call Func_000_122D
    ld a, [$C57F]
    rlca
    and a, $04
    ld b, a
    ld a, [$D8A4]
    and a, $04
    cp a, b
    jr nz, Jump_032_5658
    ld a, $05
    ld [$D092], a
    ld a, $63
    jr Jump_032_565F

Jump_032_5658::
    ld a, $04
    ld [$D092], a
    ld a, $64

Jump_032_565F::
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, Func_032_4001
    ld b, $2F
    rst $10
    ld a, $02
    ld [$CFC8], a
    ld a, $09
    ld [$CFC9], a
    xor a, a
    ld [$CFCA], a
    ld [$CFCB], a
    ld a, [$D067]
    ld [$D7FE], a
    xor a, a
    ld [$D067], a
    ret

Data_032_5688:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
    ds $15, $40
    db $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10
    ds $18, $20
    db $01, $02, $02, $08, $08, $08, $08, $08, $08, $08, $08
    ds $29, $02
    db $08, $08, $08, $08, $20, $04, $04, $04, $04, $04, $04, $04, $04, $20, $20, $20
    db $10, $20, $20, $20, $20, $20, $20, $20, $08, $20, $20, $20, $20, $20, $20, $20
    db $20, $04, $08, $10, $20, $10, $20, $20, $20, $20, $20, $20, $08, $20, $10, $10
    db $10, $00, $00, $00, $00, $00, $00, $00, $00, $02, $00, $00, $20, $20
    ds $2B, $00

Data_032_5762:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Jump_032_5770::
    ld a, [$D8A4]
    ld hl, $D854
    call Func_032_6826
    bit 4, [hl]
    call z, Func_032_5386
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_578B::
    ld a, [$CFCC]
    rst $00
    dw Jump_032_5793
    dw Jump_032_57BA

Jump_032_5793::
    ld a, [$C52B]
    or a, a
    ret nz
    ld a, [$D8A4]
    ld [$D8A5], a
    call Func_032_5B12
    call Func_032_5AB3
    call Func_032_57E4
    ld d, $8A
    cp a, $04
    jr c, Jump_032_57AF
    ld d, $8D

Jump_032_57AF::
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld hl, $CFCC
    inc [hl]
    ret

Jump_032_57BA::
    ld a, [$C52B]
    or a, a
    ret nz
    call Func_032_57E4
    and a, $04
    ld c, a
    ld b, $03

Jump_032_57C7::
    call Func_032_57E8
    jr nc, Jump_032_57DA
    inc c
    dec b
    jr nz, Jump_032_57C7
    ld hl, $CFC8
    inc [hl]
    xor a, a
    ld [$CFC9], a
    jr Jump_032_57E3

Jump_032_57DA::
    xor a, a
    ld [$CFCC], a
    ld a, $07
    ld [$CFCB], a

Jump_032_57E3::
    ret

Func_032_57E4::
    ld a, [$D8A4]
    ret

Func_032_57E8::
    ld a, [$C58A]
    cp a, $01
    jr z, Jump_032_57F8
    ld a, c
    cp a, $04
    jr c, Jump_032_57F8
    call Func_000_3E54
    ret

Jump_032_57F8::
    ld a, c
    call Func_000_3E25
    ret

Func_032_57FD::
    add a, l
    ld l, a
    jr nc, Jump_032_5802
    inc h

Jump_032_5802::
    ld a, [hl]
    ret

Func_032_5804::
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    call Func_032_57FD
    ld [$D8A6], a
    ld [$CFEC], a
    ld a, $00
    ld [$CFED], a
    ld hl, Func_032_4001
    ld b, $1A
    rst $10
    ret

Func_032_5820::
    ld a, [$CFCB]
    rst $00
    dw Jump_032_5834
    dw Jump_032_58B3
    dw Jump_032_58DA
    dw Jump_032_58F7
    dw Jump_032_5915
    dw Jump_032_59C1
    dw Jump_032_59CB
    dw Jump_032_59CF

Jump_032_5834::
    ld hl, $CFCB
    inc [hl]
    ld hl, $DAC9
    ld a, [$D8A4]
    ld [hl+], a
    ld a, [$D8A5]
    ld [hl+], a
    ld a, [$DABA]
    ld [hl+], a
    ld a, [$D8A4]
    ld de, $DA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_032_5853
    inc d

Jump_032_5853::
    ld a, [de]
    ld [hl+], a
    inc de
    ld [hl+], a
    ld a, [$D8A5]
    ld de, $DA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_032_5863
    inc d

Jump_032_5863::
    ld a, [de]
    ld [hl+], a
    inc de
    ld [hl+], a
    ld a, [$D8A5]
    ld de, $DA5B
    add a, e
    ld e, a
    jr nc, Jump_032_5872
    inc d

Jump_032_5872::
    ld a, [de]
    ld [hl], a
    ld a, $01
    ld [$DABD], a
    xor a, a
    ld [$DABA], a
    ld a, [$D8A5]
    ld [$D8A4], a
    ld a, [$D8A4]
    ld hl, $DA1C
    call Func_032_6826
    ld a, [$D8A6]
    ld [hl+], a
    ld [hl], $FF
    ld a, [$D8A4]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_589D
    inc h

Jump_032_589D::
    ld [hl], $02
    ld hl, Func_032_4001
    ld b, $39
    rst $10
    ld a, [$D8A4]
    ld hl, $DA1D
    call Func_032_6826
    ld a, [hl]
    ld [$D8A5], a
    ret

Jump_032_58B3::
    ld hl, $CFCB
    inc [hl]
    call Func_032_51F9
    jr c, Jump_032_58D9
    ld a, d
    and a, $07
    jr z, Jump_032_58D9
    cp a, $07
    jr z, Jump_032_58D9
    push de
    ld hl, Data_032_7508
    ld b, $3A
    rst $10
    pop af
    cp a, $01
    jr z, Jump_032_58D4
    call Func_032_5386

Jump_032_58D4::
    ld a, $05
    ld [$CFCB], a

Jump_032_58D9::
    ret

Jump_032_58DA::
    ld a, [$DAB2]
    bit 0, a
    jr nz, Jump_032_58F2
    ld hl, Data_032_6D76
    ld b, $3A
    rst $10
    ld a, $80
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10

Jump_032_58F2::
    ld hl, $CFCB
    inc [hl]
    ret

Jump_032_58F7::
    ld a, [$DC00]
    ld hl, $DC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, $80
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_5915::
    ld a, [$CFCC]
    rst $00
    dw Jump_032_5921
    dw Jump_032_5993
    dw Jump_032_59A0
    dw Jump_032_59B8

Jump_032_5921::
    ld a, [$D8A4]
    ld hl, $DA1C
    add a, a
    call Func_032_57FD
    ld [$D8A6], a
    inc hl
    ld a, [hl]
    ld [$D8A5], a
    ld a, [$CFF6]
    bit 7, a
    jr z, Jump_032_5976
    ld a, [$CFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_032_5952
    ld a, [$D8A5]
    ld hl, $D814
    call Func_000_3F25
    bit 4, [hl]
    jr nz, Jump_032_5983
    jr Jump_032_5976

Jump_032_5952::
    ld a, [$D8A5]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, $D814
    call Func_000_3F25

Jump_032_5960::
    ld a, c
    call Func_000_3E54
    jr c, Jump_032_596A
    bit 4, [hl]
    jr nz, Jump_032_5983

Jump_032_596A::
    ld a, l
    add a, $09
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    dec b
    jr nz, Jump_032_5960

Jump_032_5976::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_5983::
    res 4, [hl]
    ld hl, $DAAC
    ld a, [hl+]
    ld [hl-], a
    ld a, [$D8A6]
    ld [hl], a
    ld hl, $CFCC
    inc [hl]
    ret

Jump_032_5993::
    ld hl, $CFCC
    inc [hl]
    ld d, $B0
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ret

Jump_032_59A0::
    ld hl, $CFCC
    inc [hl]
    ld a, [$DAAD]
    cp a, $FF
    ret z
    ld d, $92
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld a, $FF
    ld [$DAAD], a
    ret

Jump_032_59B8::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_59C1::
    ld a, $05
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    ret

Jump_032_59CB::
    call Func_032_55EE
    ret

Jump_032_59CF::
    call Func_032_5386
    ld hl, $CFCA
    inc [hl]
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Func_032_59DF::
    ld hl, $CFCB
    inc [hl]
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCC], a
    ld a, [$DAC1]
    and a, $C0
    cp a, $00
    jr z, Jump_032_5A39
    cp a, $40
    jr z, Jump_032_5A26
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_032_6826
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_032_5A1B
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_032_5A26
    inc hl

Jump_032_5A1B::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, $CFCB
    dec [hl]
    xor a, a
    ld [$CFCD], a

Jump_032_5A26::
    ld a, [$D8A5]
    call Func_032_687F
    ld a, [$D8A5]
    call Func_032_688C
    ld a, [$D8A5]
    call Func_032_6899
    ret

Jump_032_5A39::
    ret

Func_032_5A3A::
    ld a, [$CFCD]
    rst $00
    dw Jump_032_5A44
    dw Jump_032_5A5B
    dw Jump_032_5A63

Jump_032_5A44::
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_5A53
    inc h

Jump_032_5A53::
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call Func_032_5B12
    ret

Jump_032_5A5B::
    call Func_032_5AB3
    ld hl, $CFCD
    inc [hl]
    ret

Jump_032_5A63::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCD], a
    ld a, [$D8A5]
    call Func_032_6899
    call Func_032_5A95
    ret z
    ld a, [$D8A6]
    cp a, $91
    jr nz, Jump_032_5A86
    ld d, $8A
    call Func_032_682D
    jr c, Jump_032_5A84
    inc d

Jump_032_5A84::
    jr Jump_032_5A8E

Jump_032_5A86::
    ld d, $8B
    call Func_032_6848
    jr nc, Jump_032_5A8E
    dec d

Jump_032_5A8E::
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ret

Func_032_5A95::
    ld a, [$D8A6]
    cp a, $13
    ret z
    cp a, $14
    ret z
    cp a, $15
    jr z, Jump_032_5AA9
    cp a, $79
    cp a, $D6
    jr z, Jump_032_5AA9
    ret

Jump_032_5AA9::
    ld hl, $D872
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ret

Func_032_5AB3::
    ld a, [$C58A]
    or a, a
    jr z, Jump_032_5AD4
    cp a, $02
    jr z, Jump_032_5AD4
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_032_5AD4
    ld a, [$D8A5]
    bit 2, a
    ret nz
    and a, $03
    cp a, $03
    ret z
    ld a, [$D8A5]
    jr Jump_032_5AE4

Jump_032_5AD4::
    ld a, [$D8A5]
    bit 2, a
    ret z
    and a, $03
    cp a, $03
    ret z
    ld a, [$D8A5]
    sub a, $04

Jump_032_5AE4::
    cp a, $02
    jr z, Jump_032_5AF6
    cp a, $01
    jr z, Jump_032_5AF1
    ld hl, $9140
    jr Jump_032_5AF9

Jump_032_5AF1::
    ld hl, $9380
    jr Jump_032_5AF9

Jump_032_5AF6::
    ld hl, $95C0

Jump_032_5AF9::
    ld c, $24

Jump_032_5AFB::
    ld b, $08

Jump_032_5AFD::
    di

Jump_032_5AFE::
    ldh a, [$FF41]
    bit 1, a
    jr nz, Jump_032_5AFE
    ld a, $FF
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ei
    dec b
    jr nz, Jump_032_5AFD
    dec c
    jr nz, Jump_032_5AFB
    ret

Func_032_5B12::
    call Func_032_5C3F
    ld a, [$D8A5]
    ld hl, $D812
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_5B2A
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call Func_032_5BE8

Jump_032_5B2A::
    call Func_032_5B94
    ld a, [$D8A5]
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_032_5B38
    inc h

Jump_032_5B38::
    ld [hl], $01
    ld a, [$D8A5]
    ld hl, $D8BF
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_5B46
    inc h

Jump_032_5B46::
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ld a, [$C58A]
    or a, a
    jr z, Jump_032_5B66
    cp a, $02
    jr nz, Jump_032_5B93

Jump_032_5B66::
    ld a, [$D8A5]
    cp a, $03
    jr z, Jump_032_5B78
    jr c, Jump_032_5B8D
    cp a, $07
    jr z, Jump_032_5B78
    ld [$DAAB], a
    jr Jump_032_5B93

Jump_032_5B78::
    ld a, [$D8A5]
    and a, $04
    rrca
    rrca
    and a, $01
    ld hl, $D80A
    res 2, [hl]
    ld a, $09
    ld [$DABE], a
    jr Jump_032_5B93

Jump_032_5B8D::
    ld a, [$D8A5]
    call Func_032_6899

Jump_032_5B93::
    ret

Func_032_5B94::
    ld a, [$CFF2]
    and a, $0F
    cp a, $02
    jr nz, Jump_032_5BC3
    ld a, [$DABF]
    bit 1, a
    jr z, Jump_032_5BC3
    ld a, [$DAD1]
    cp a, $FF
    jr z, Jump_032_5BC3
    ld c, a
    ld a, [$D8A5]
    cp a, c
    jr c, Jump_032_5BC3
    jr z, Jump_032_5BC3
    ld a, [$DABA]
    bit 7, a
    jr z, Jump_032_5BC3
    cp a, $81
    jr z, Jump_032_5BC3
    dec a
    ld [$DABA], a

Jump_032_5BC3::
    ld a, [$D8A5]
    ld e, a
    and a, $04
    ld c, a
    ld b, $04

Jump_032_5BCC::
    ld a, c
    ld hl, $D812
    call Func_000_3F25
    bit 4, [hl]
    jr z, Jump_032_5BE3
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    cp a, e
    jr nz, Jump_032_5BE3
    dec hl
    res 4, [hl]

Jump_032_5BE3::
    inc c
    dec b
    jr nz, Jump_032_5BCC
    ret

Func_032_5BE8::
    push af
    push bc
    push de
    push hl
    ld a, [$DAC4]
    ld l, a
    ld a, [$DAC5]
    ld h, a
    push hl
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4111
    ld b, $3B
    rst $10
    ld a, [$D8A5]
    ld hl, $D91F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_5C0B
    inc h

Jump_032_5C0B::
    ld a, [$DAC4]
    ld [hl+], a
    ld a, [$DAC5]
    ld [hl], a
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_40CD
    ld b, $3B
    rst $10
    ld a, [$D8A5]
    ld hl, $D90F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_5C29
    inc h

Jump_032_5C29::
    ld a, [$DAC4]
    ld [hl+], a
    ld a, [$DAC5]
    ld [hl], a
    pop hl
    ld a, l
    ld [$DAC4], a
    ld a, h
    ld [$DAC5], a
    pop hl
    pop de
    pop bc
    pop af
    ret

Func_032_5C3F::
    ld a, [$D8A5]
    ld hl, $D80D
    call Func_000_3F25
    ld a, [hl]
    and a, $30
    ret z
    and a, $20
    call nz, Func_032_5E1A
    ld a, $01
    ld [$D868], a
    ld a, [$D8A5]
    ld c, a
    ld hl, $434D
    ld b, $19
    rst $10
    ld a, [$D8A5]
    ld c, a
    ld hl, Func_032_4001
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D8CF
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    call Func_032_6803
    call Func_000_3E7A
    jr c, Jump_032_5C95
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5C95::
    ld a, [$D8A5]
    ld c, a
    ld hl, $4045
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D8EF
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    call Func_032_6808
    call Func_000_3E7A
    jr c, Jump_032_5CCA
    ld a, [$D8A5]
    ld hl, $D8DF
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5CCA::
    ld a, [$D8A5]
    ld c, a
    ld hl, $4089
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D8FF
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4155
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D92F
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4298
    ld b, $19
    rst $10
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4199
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D8B7
    add a, l
    ld l, a
    jr nc, Jump_032_5D29
    inc h

Jump_032_5D29::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_41D3
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_032_5D43
    inc h

Jump_032_5D43::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_420D
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_032_5D5D
    inc h

Jump_032_5D5D::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4247
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_032_5D77
    inc h

Jump_032_5D77::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4281
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$D8A5]
    ld hl, $D980
    add a, l
    ld l, a
    jr nc, Jump_032_5D91
    inc h

Jump_032_5D91::
    ld [hl], c
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4111
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D91F
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_40CD
    ld b, $3B
    rst $10
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    ld a, [$D8A5]
    ld hl, $D90F
    call Func_032_6826
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_42BB
    ld b, $3B
    rst $10
    ld a, [$D8A5]
    ld hl, $D8A7
    add a, l
    ld l, a
    jr nc, Jump_032_5DE3
    inc h

Jump_032_5DE3::
    ld [hl], c
    ld a, [$D8A5]
    ld b, a
    and a, $03
    cp a, $03
    ret z
    ld a, b
    ld e, $31
    call Func_000_3F32
    ld a, l
    ld [$D868], a
    ld a, h
    ld [$D869], a
    ld a, [$D8A5]
    ld de, $DA72
    ld b, a
    add a, a
    add a, b
    add a, a
    add a, b
    add a, e
    ld e, a
    jr nc, Jump_032_5E0B
    inc d

Jump_032_5E0B::
    ld a, e
    ld [$D86A], a
    ld a, d
    ld [$D86B], a
    ld hl, $44B9
    ld b, $19
    rst $10
    ret

Func_032_5E1A::
    ld a, [$D8A5]
    ld c, a

Func_032_5E1E::
    ld a, [$C58A]
    or a, a
    jr z, Jump_032_5E27
    cp a, $02
    ret nz

Jump_032_5E27::
    ld a, c
    cp a, $04
    ret c
    and a, $03
    cp a, $03
    ret z
    ld hl, $DAD4
    add a, l
    ld l, a
    jr nc, Jump_032_5E38
    inc h

Jump_032_5E38::
    ld [hl], $FF
    ret

Func_032_5E3B::
    xor a, a
    ld [$D80A], a
    ld [$D80B], a
    ld c, $00

Jump_032_5E44::
    push bc
    ld a, c
    ld [$D8A5], a
    call Func_000_3E54
    jr c, Jump_032_5E79
    call Func_032_5C3F
    ld a, [$D8A5]
    ld hl, $D812
    call Func_000_3F25
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_5E66
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call Func_032_5BE8

Jump_032_5E66::
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a

Jump_032_5E79::
    pop bc
    inc c
    ld a, c
    cp a, $02
    jr nz, Jump_032_5E44
    ld a, $03
    ld hl, $DA63
    add a, l
    ld l, a
    jr nc, Jump_032_5E8A
    inc h

Jump_032_5E8A::
    ld [hl], $FF
    ld a, $03
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_5E96
    inc h

Jump_032_5E96::
    ld [hl], $FF
    ld a, $03
    ld hl, $D80C
    call Func_000_3F25
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ret

Func_032_5EAB::
    ld a, [$CFCC]
    rst $00
    dw Jump_032_5EC3
    dw Jump_032_6099
    dw Jump_032_60AB
    dw Jump_032_60B4
    dw Jump_032_61E3
    dw Jump_032_62CF
    dw Jump_032_643C
    dw Jump_032_643C
    dw Jump_032_643C
    dw Jump_032_643D

Jump_032_5EC3::
    xor a, a
    ld [$CFCD], a
    xor a, a
    ld [$CFCE], a
    ld a, [$D8A6]
    cp a, $15
    jr z, Jump_032_5F20
    cp a, $20
    jr z, Jump_032_5F20
    cp a, $3B
    jr z, Jump_032_5F3B
    cp a, $5F
    jp z, Jump_032_5F63
    cp a, $60
    jp z, Jump_032_5FAE
    cp a, $61
    jp z, Jump_032_5FF8
    cp a, $6D
    jr z, Jump_032_5F35
    cp a, $6F
    jr z, Jump_032_5F0A
    cp a, $70
    jr z, Jump_032_5F10
    cp a, $7B
    jr z, Jump_032_5F20
    cp a, $B8
    jr z, Jump_032_5F3B
    cp a, $D6
    jr z, Jump_032_5F16
    cp a, $DC
    jr z, Jump_032_5F4B

Jump_032_5F05::
    ld hl, $CFCC
    inc [hl]
    ret

Jump_032_5F0A::
    ld a, $03
    ld [$CFCC], a
    ret

Jump_032_5F10::
    ld a, $04
    ld [$CFCC], a
    ret

Jump_032_5F16::
    ld a, [$D8A4]
    ld [$C982], a
    xor a, a
    ld [$C983], a

Jump_032_5F20::
    ld a, [$CFCF]
    bit 0, a
    jr z, Jump_032_5F05
    ld a, [$CFCF]
    and a, $FE
    ld [$CFCF], a
    ld a, $05
    ld [$CFCC], a
    ret

Jump_032_5F35::
    ld a, $09
    ld [$CFCC], a
    ret

Jump_032_5F3B::
    call Func_032_604A
    xor a, a
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCC], a
    ret

Jump_032_5F4B::
    ld a, [$D8A4]
    push af
    ld hl, Data_032_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a
    call Func_032_604A
    pop af
    ld [$D8A4], a
    jr Jump_032_5F3B

Jump_032_5F63::
    ld a, [$D8A5]
    call Func_000_3E54
    jp c, Func_032_61D9
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $03
    jp nz, Func_032_61D9
    push hl
    ld hl, $60D1
    ld b, $36
    rst $10
    pop hl
    ld a, e
    or a, a
    jp nz, Func_032_61D9
    set 0, [hl]
    ld a, [$D8A5]
    call Func_032_6899
    ld a, $20
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld a, $08
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    ld a, $75
    ld [$CFCE], a
    jp Func_032_61D9

Jump_032_5FAE::
    ld a, [$D8A5]
    call Func_000_3E54
    jp c, Func_032_61D9
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    bit 6, [hl]
    jp nz, Func_032_61D9
    push hl
    ld hl, $60EB
    ld b, $36
    rst $10
    pop hl
    ld a, e
    or a, a
    jp nz, Func_032_61D9
    set 6, [hl]
    ld a, [$D8A5]
    call Func_032_6899
    ld a, $20
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld a, $08
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    ld a, $76
    ld [$CFCE], a
    jp Func_032_61D9

Jump_032_5FF8::
    ld a, [$D8A5]
    call Func_000_3E54
    jp c, Func_032_61D9
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    bit 7, [hl]
    jp nz, Func_032_61D9
    push hl
    ld hl, $610D
    ld b, $36
    rst $10
    pop hl
    ld a, e
    or a, a
    jp nz, Func_032_61D9
    ld a, [hl]
    or a, $8C
    ld [hl], a
    ld a, [$D8A5]
    call Func_032_6899
    ld a, $20
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld a, $08
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    call Func_032_6848
    ld a, $74
    jr c, Jump_032_6044
    dec a

Jump_032_6044::
    ld [$CFCE], a
    jp Func_032_61D9

Func_032_604A::
    call Func_000_3ED4
    ld a, [$D8A4]
    ld hl, $DA1C
    call Func_032_6826
    push hl
    ld a, [$C5E7]
    and a, $03
    ld hl, Data_032_6094
    add a, l
    ld l, a
    jr nc, Jump_032_6064
    inc h

Jump_032_6064::
    ld a, [hl]
    pop hl
    ld [hl+], a
    ld c, a
    push hl
    ld a, [$D8A4]
    and a, $04
    xor a, $04
    ld b, a
    ld a, c
    cp a, $00
    jr nz, Jump_032_6090
    ld a, [$C5E7]
    and a, $03
    add a, b

Jump_032_607C::
    ld b, a
    call Func_000_3E54
    jr nc, Jump_032_6090
    ld a, b
    and a, $03
    jr nz, Jump_032_608C
    ld a, b
    or a, $03
    jr Jump_032_607C

Jump_032_608C::
    ld a, b
    dec a
    jr Jump_032_607C

Jump_032_6090::
    pop hl
    ld a, b
    ld [hl], a
    ret

Data_032_6094:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00

Jump_032_6099::
    ld a, [$CFCE]
    or a, a
    jr z, Jump_032_60AB
    ld d, a
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld hl, $CFCC
    inc [hl]
    ret

Jump_032_60AB::
    xor a, a
    ld [$CFCC], a
    ld hl, $CFCB
    inc [hl]
    ret

Jump_032_60B4::
    ld a, [$CFCD]
    rst $00
    dw Jump_032_60C0
    dw Jump_032_60DF
    dw Jump_032_6174
    dw Func_032_61D9

Jump_032_60C0::
    ld hl, $CFCD
    inc [hl]
    call Func_032_6749
    ret c
    ld a, $20
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld a, $08
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    ret

Jump_032_60DF::
    ld hl, $CFCD
    inc [hl]
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_032_6826
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    call Func_032_6755
    inc hl
    ld a, l
    ld [$D876], a
    ld a, h
    ld [$D877], a
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    jr c, Jump_032_610F
    or a, c
    jr z, Jump_032_610F
    jr Jump_032_6112

Jump_032_610F::
    ld bc, $0000

Jump_032_6112::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    or a, b
    jr nz, Jump_032_6121
    ld hl, $CFCD
    dec [hl]
    xor a, a
    ld [$CFCE], a

Jump_032_6121::
    ld a, $35
    ld [$C0A0], a
    call Func_032_682D
    jr nc, Jump_032_612F
    ld hl, $C0A0
    inc [hl]

Jump_032_612F::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    push hl
    ld a, [$D876]
    ld l, a
    ld a, [$D877]
    ld h, a
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    pop hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, [$D871]
    ld [$D8A5], a
    ld a, [$D8A4]
    call Func_032_687F
    ret

Jump_032_6174::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    call Func_032_618A
    ld a, [$D871]
    ld [$D8A5], a
    ret

Func_032_618A::
    ld a, [$CFCE]
    rst $00
    dw Jump_032_6194
    dw Jump_032_61A9
    dw Jump_032_61B1

Jump_032_6194::
    ld hl, $CFCE
    inc [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_61A3
    inc h

Jump_032_61A3::
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_61A9::
    call Func_032_5AB3
    ld hl, $CFCE
    inc [hl]
    ret

Jump_032_61B1::
    ld a, [$D8A5]
    call Func_032_6899
    ld a, $90
    ld [$C0A0], a
    call Func_032_682D
    jr c, Jump_032_61C6
    ld a, $8D
    ld [$C0A0], a

Jump_032_61C6::
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld hl, $CFCD
    inc [hl]
    xor a, a
    ld [$CFCE], a
    ret

Func_032_61D9::
    xor a, a
    ld [$CFCD], a
    ld a, $01
    ld [$CFCC], a
    ret

Jump_032_61E3::
    ld a, [$CFCD]
    rst $00
    dw Jump_032_61EF
    dw Jump_032_620E
    dw Jump_032_6266
    dw Jump_032_62CB

Jump_032_61EF::
    call Func_032_6749
    ret c
    ld a, $20
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld a, $08
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    ld hl, $CFCD
    inc [hl]
    ret

Jump_032_620E::
    ld hl, $CFCD
    inc [hl]
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_032_6826
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, h
    or a, a
    jr nz, Jump_032_6231
    ld a, l
    cp a, $01
    jr nz, Jump_032_6231
    ld bc, $0000
    jr Jump_032_6234

Jump_032_6231::
    ld bc, $0001

Jump_032_6234::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    or a, b
    jr nz, Jump_032_6245
    ld hl, $CFCD
    dec [hl]
    xor a, a
    ld [$CFCE], a
    jr Jump_032_625F

Jump_032_6245::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    ld d, $38
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld a, [$D871]
    ld [$D8A5], a

Jump_032_625F::
    ld a, [$D8A4]
    call Func_032_687F
    ret

Jump_032_6266::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    call Func_032_627C
    ld a, [$D871]
    ld [$D8A5], a
    ret

Func_032_627C::
    ld a, [$CFCE]
    rst $00
    dw Jump_032_6286
    dw Jump_032_629B
    dw Jump_032_62A3

Jump_032_6286::
    ld hl, $CFCE
    inc [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_6295
    inc h

Jump_032_6295::
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_629B::
    call Func_032_5AB3
    ld hl, $CFCE
    inc [hl]
    ret

Jump_032_62A3::
    ld a, [$D8A5]
    call Func_032_6899
    ld a, $90
    ld [$C0A0], a
    call Func_032_682D
    jr c, Jump_032_62B8
    ld a, $8D
    ld [$C0A0], a

Jump_032_62B8::
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld hl, $CFCD
    inc [hl]
    xor a, a
    ld [$CFCE], a
    ret

Jump_032_62CB::
    call Func_032_61D9
    ret

Jump_032_62CF::
    ld a, [$D8A6]
    cp a, $D6
    jr nz, Jump_032_62F1
    ld a, [$C983]
    bit 0, a
    jr z, Jump_032_62F1
    bit 7, a
    jr nz, Jump_032_62F1
    set 7, a
    ld [$C983], a
    ld hl, Data_032_414F
    ld b, $A3
    rst $10
    ldh a, [$FFC6]
    ld [$D8A4], a

Jump_032_62F1::
    ld a, [$CFCD]
    rst $00
    dw Jump_032_62FD
    dw Jump_032_630B
    dw Jump_032_63AC
    dw Jump_032_640B

Jump_032_62FD::
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A4]
    call Func_000_3E54
    jp c, Jump_032_640B
    ret

Jump_032_630B::
    ld hl, $CFCD
    inc [hl]
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A4]
    call Func_032_687F
    call Func_000_3ED4
    ld a, [$C5E7]
    and a, $01
    jr z, Jump_032_6366
    ld a, [$D8A4]
    call Func_032_6803
    push hl
    ld a, $64
    call Func_000_16D1
    ld a, h
    or a, l
    jr nz, Jump_032_6336
    ld hl, $0001

Jump_032_6336::
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    or a, c
    jr nz, Jump_032_6342
    jr Jump_032_6366

Jump_032_6342::
    ld a, c
    ld [$D872], a
    ld a, b
    ld [$D873], a
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    ld d, $38
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld a, [$D871]
    ld [$D8A5], a
    jr Jump_032_637D

Jump_032_6366::
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_032_6826
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a

Jump_032_637D::
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_032_6826
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_032_63A0
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_032_63AB
    inc hl

Jump_032_63A0::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, $CFCD
    dec [hl]
    xor a, a
    ld [$CFCE], a

Jump_032_63AB::
    ret

Jump_032_63AC::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    call Func_032_63C2
    ld a, [$D871]
    ld [$D8A5], a
    ret

Func_032_63C2::
    ld a, [$CFCE]
    rst $00
    dw Jump_032_63CC
    dw Jump_032_63E1
    dw Jump_032_63E9

Jump_032_63CC::
    ld hl, $CFCE
    inc [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_63DB
    inc h

Jump_032_63DB::
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_63E1::
    call Func_032_5AB3
    ld hl, $CFCE
    inc [hl]
    ret

Jump_032_63E9::
    ld a, [$D8A5]
    call Func_032_6899
    ld a, [$D8A6]
    cp a, $7B
    ld d, $8C
    jr z, Jump_032_6401
    ld d, $90
    call Func_032_682D
    jr c, Jump_032_6401
    ld d, $8D

Jump_032_6401::
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    xor a, a
    ld [$CFCE], a

Jump_032_640B::
    ld a, [$D8A6]
    cp a, $D6
    jr nz, Jump_032_642E
    ld a, [$C983]
    bit 0, a
    jr z, Jump_032_6421
    ld a, [$C982]
    ld [$D8A4], a
    jr Jump_032_642E

Jump_032_6421::
    inc a
    ld [$C983], a
    xor a, a
    ld [$CFCD], a
    xor a, a
    ld [$CFCE], a
    ret

Jump_032_642E::
    ld a, $06
    ld [$CFCA], a
    xor a, a
    ld [$CFCB], a
    xor a, a
    ld [$CFCD], a
    ret

Jump_032_643C::
    ret

Jump_032_643D::
    ld a, [$CFCD]
    rst $00
    dw Jump_032_6449
    dw Jump_032_6468
    dw Jump_032_6518
    dw Jump_032_657D

Jump_032_6449::
    ld hl, $CFCD
    inc [hl]
    call Func_032_6749
    ret c
    ld a, $20
    ld [$DAD2], a
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld a, $08
    ld [$DAD3], a
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    ret

Jump_032_6468::
    ld hl, $CFCD
    inc [hl]
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A4]
    ld hl, $D8BF
    call Func_032_6826
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    push hl
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    srl h
    rr l
    srl h
    rr l
    ld a, l
    ld [$D876], a
    ld a, h
    ld [$D877], a
    ld a, l
    or a, h
    jr nz, Jump_032_64A5
    ld hl, $0001
    ld a, l
    ld [$D876], a
    ld a, h
    ld [$D877], a

Jump_032_64A5::
    pop bc
    ld a, c
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    jr c, Jump_032_64B3
    or a, c
    jr z, Jump_032_64B3
    jr Jump_032_64B6

Jump_032_64B3::
    ld bc, $0000

Jump_032_64B6::
    pop hl
    ld a, c
    ld [hl+], a
    ld [hl], b
    or a, c
    jr nz, Jump_032_64C5
    ld hl, $CFCD
    dec [hl]
    xor a, a
    ld [$CFCE], a

Jump_032_64C5::
    ld a, $35
    ld [$C0A0], a
    call Func_032_682D
    jr nc, Jump_032_64D3
    ld hl, $C0A0
    inc [hl]

Jump_032_64D3::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    push hl
    ld a, [$D876]
    ld l, a
    ld a, [$D877]
    ld h, a
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    pop hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ld a, [$D871]
    ld [$D8A5], a
    ld a, [$D8A4]
    call Func_032_687F
    ret

Jump_032_6518::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    call Func_032_652E
    ld a, [$D871]
    ld [$D8A5], a
    ret

Func_032_652E::
    ld a, [$CFCE]
    rst $00
    dw Jump_032_6538
    dw Jump_032_654D
    dw Jump_032_6555

Jump_032_6538::
    ld hl, $CFCE
    inc [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_6547
    inc h

Jump_032_6547::
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_654D::
    call Func_032_5AB3
    ld hl, $CFCE
    inc [hl]
    ret

Jump_032_6555::
    ld a, [$D8A5]
    call Func_032_6899
    ld a, $90
    ld [$C0A0], a
    call Func_032_682D
    jr c, Jump_032_656A
    ld a, $8D
    ld [$C0A0], a

Jump_032_656A::
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld hl, $CFCD
    inc [hl]
    xor a, a
    ld [$CFCE], a
    ret

Jump_032_657D::
    call Func_032_61D9
    ret

Func_032_6581:: ; heuristic: follows a terminator; C0
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $D0
    call nz, Func_032_660F
    xor a, a
    ld [hl+], a
    ld a, [$D8A5]
    call Func_032_6899
    ld a, [hl]
    and a, $3C
    ld [hl+], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $FC
    ld [hl], a
    inc hl
    push hl
    inc hl
    inc hl
    res 7, [hl]
    pop hl
    bit 7, [hl]
    ret z
    res 7, [hl]
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_4111
    ld b, $3B
    rst $10
    ld a, [$D8A5]
    ld hl, $D91F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_65C5
    inc h

Jump_032_65C5::
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    call Func_000_3E7A
    pop hl
    jr nc, Jump_032_65DF
    ld a, [$DAC4]
    ld [hl+], a
    ld a, [$DAC5]
    ld [hl], a

Jump_032_65DF::
    ld a, [$D8A5]
    ld c, a
    ld hl, Data_032_40CD
    ld b, $3B
    rst $10
    ld a, [$D8A5]
    ld hl, $D90F
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_65F5
    inc h

Jump_032_65F5::
    push hl
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$DAC4]
    ld c, a
    ld a, [$DAC5]
    ld b, a
    call Func_000_3E7A
    pop hl
    ret nc
    ld a, [$DAC4]
    ld [hl+], a
    ld a, [$DAC5]
    ld [hl], a
    ret

Func_032_660F::
    push hl
    push bc
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_661C
    inc h

Jump_032_661C::
    ld [hl], $03
    pop bc
    pop hl
    ret
    db $C9

Func_032_6622::
    ld a, [$D8A5]
    ld hl, $D80C
    call Func_000_3F25
    ld a, [hl]
    and a, $90
    call nz, Func_032_660F
    ld a, [hl]
    and a, $63
    ld [hl], a
    ld a, [$D8A5]
    call Func_032_6899
    inc hl
    ld a, [hl]
    and a, $30
    ld [hl], a
    inc hl
    xor a, a
    ld [hl+], a
    ld a, [hl]
    and a, $F7
    ld [hl+], a
    ld a, [hl]
    and a, $FF
    ld [hl+], a
    ld a, [hl]
    and a, $C0
    call nz, Func_032_660F
    ld a, [hl]
    and a, $33
    ld [hl+], a
    ld a, [hl]
    and a, $37
    ld [hl+], a
    ld a, [hl]
    and a, $FB
    ld [hl+], a
    ld a, [hl]
    and a, $3F
    ld [hl], a
    ret

Func_032_6662::
    ld a, [$CFCC]
    rst $00
    dw Jump_032_666C
    dw Jump_032_667D
    dw Jump_032_66DB

Jump_032_666C::
    ld hl, $CFCC
    inc [hl]
    ld hl, Func_032_4001
    ld b, $3A
    rst $10
    ld hl, Data_032_5762
    ld b, $3A
    rst $10
    ret

Jump_032_667D::
    ld a, [$D8A5]
    ld hl, $D8BF
    call Func_032_6826
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [$D872]
    ld c, a
    ld a, [$D873]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, Jump_032_66A0
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_032_66AD
    inc hl

Jump_032_66A0::
    xor a, a
    ld [hl-], a
    ld [hl], a
    ld hl, $CFCC
    inc [hl]
    xor a, a
    ld [$CFCD], a
    jr Jump_032_66B5

Jump_032_66AD::
    xor a, a
    ld [$CFCC], a
    ld hl, $CFCB
    inc [hl]

Jump_032_66B5::
    ld a, [$D8A5]
    call Func_032_687F
    call Func_032_682D
    ld d, $35
    jr c, Jump_032_66C4
    ld d, $36

Jump_032_66C4::
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ld a, [$D8A4]
    ld l, a
    ld a, [$D8A5]
    ld h, a
    ld a, l
    ld [$D8A5], a
    ld a, h
    ld [$D8A4], a
    ret

Jump_032_66DB::
    ld a, [$D8A5]
    ld [$D871], a
    ld a, [$D8A4]
    ld [$D8A5], a
    call Func_032_66F1
    ld a, [$D871]
    ld [$D8A5], a
    ret

Func_032_66F1::
    ld a, [$CFCD]
    rst $00
    dw Jump_032_66FB
    dw Jump_032_6710
    dw Jump_032_6718

Jump_032_66FB::
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_670A
    inc h

Jump_032_670A::
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_6710::
    call Func_032_5AB3
    ld hl, $CFCD
    inc [hl]
    ret

Jump_032_6718::
    ld a, [$D8A5]
    call Func_032_6899
    ld a, $8A
    ld [$C0A0], a
    call Func_032_682D
    jr c, Jump_032_672D
    ld a, $8B
    ld [$C0A0], a

Jump_032_672D::
    ld a, [$C0A0]
    ld d, a
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    xor a, a
    ld [$CFCD], a
    xor a, a
    ld [$CFCC], a
    ld hl, $CFCB
    inc [hl]
    ld a, $81
    ld [$DABA], a
    ret

Func_032_6749::
    ld a, [$D8A4]
    call Func_000_3E54
    ret nc
    call Func_032_61D9
    scf
    ret

Func_032_6755::
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Func_000_16AA
    ld a, $0A
    call Func_000_16E2
    pop de
    ret

Func_032_6764::
    ld a, [$CFCD]
    rst $00
    dw Jump_032_676E
    dw Jump_032_6785
    dw Jump_032_678D

Jump_032_676E::
    ld hl, $CFCD
    inc [hl]
    ld a, [$D8A5]
    ld hl, $DA5B
    add a, l
    ld l, a
    jr nc, Jump_032_677D
    inc h

Jump_032_677D::
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call Func_032_5B12
    ret

Jump_032_6785::
    call Func_032_5AB3
    ld hl, $CFCD
    inc [hl]
    ret

Jump_032_678D::
    ld hl, $CFCB
    inc [hl]
    xor a, a
    ld [$CFCD], a
    ld a, [$D8A5]
    call Func_032_6899
    ld d, $8B
    call Func_032_6848
    jr nc, Jump_032_67A3
    dec d

Jump_032_67A3::
    ld hl, Data_032_7193
    ld b, $3A
    rst $10
    ret

Func_032_67AA::
    ld a, [$D8A5]
    ld hl, $D813
    call Func_000_3F25
    ld a, [hl]
    push af
    and a, $F0
    ld [hl], a
    ld a, [$D872]
    ld l, a
    ld a, [$D873]
    ld h, a
    pop af
    bit 0, a
    jr z, Jump_032_67CF
    add hl, hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_032_67CF::
    bit 1, a
    jr z, Jump_032_67E2
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret

Jump_032_67E2::
    bit 2, a
    ret z
    add hl, hl
    ld a, l
    ld [$D872], a
    ld a, h
    ld [$D873], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E

Func_032_67FE::
    ld hl, $D8EF
    jr Jump_032_681C

Func_032_6803::
    ld hl, $D8BF
    jr Jump_032_681C

Func_032_6808::
    ld hl, $D8DF
    jr Jump_032_681C
    db $21, $1F, $D9, $18, $0A

Func_032_6812::
    ld hl, $DA53
    add a, l
    ld l, a
    jr nc, Jump_032_681A
    inc h

Jump_032_681A::
    ld a, [hl]
    ret

Jump_032_681C::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_6822
    inc h

Jump_032_6822::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ret

Func_032_6826::
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_032_682C
    inc h

Jump_032_682C::
    ret

Func_032_682D::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_032_6842
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_032_6842
    ld a, [$D8A4]
    cp a, $04
    ccf
    ret

Jump_032_6842::
    ld a, [$D8A4]
    cp a, $04
    ret

Func_032_6848::
    ld a, [$C58A]
    cp a, $01
    jr nz, Jump_032_685D
    ld a, [$C57F]
    bit 1, a
    jr z, Jump_032_685D
    ld a, [$D8A5]
    cp a, $04
    ccf
    ret

Jump_032_685D::
    ld a, [$D8A5]
    cp a, $04
    ret
    db $7A, $21, $78, $68, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

Func_032_687F::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_032_6888
    inc h

Jump_032_6888::
    set 0, [hl]
    pop hl
    ret

Func_032_688C::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_032_6895
    inc h

Jump_032_6895::
    set 1, [hl]
    pop hl
    ret

Func_032_6899::
    push hl
    ld hl, $D095
    add a, l
    ld l, a
    jr nc, Jump_032_68A2
    inc h

Jump_032_68A2::
    set 2, [hl]
    pop hl
    ret

Func_032_68A6:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, $D968
    add a, l
    ld l, a
    jr nc, Jump_032_68B3
    inc h

Jump_032_68B3::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_032_68C2
    ld l, $09
    cp a, $40
    jr nc, Jump_032_68C2
    ld l, $12

Jump_032_68C2::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D970
    add a, l
    ld l, a
    jr nc, Jump_032_68CE
    inc h

Jump_032_68CE::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_032_68DD
    ld l, $03
    cp a, $40
    jr nc, Jump_032_68DD
    ld l, $06

Jump_032_68DD::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, $D978
    add a, l
    ld l, a
    jr nc, Jump_032_68E9
    inc h

Jump_032_68E9::
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_032_68F8
    ld l, $01
    cp a, $40
    jr nc, Jump_032_68F8
    ld l, $02

Jump_032_68F8::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

Func_032_68FD::
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_6917
    ld a, [hl]
    and a, $0C
    jr nz, Jump_032_6917
    xor a, a
    jr Jump_032_6918

Jump_032_6917::
    scf

Jump_032_6918::
    ld a, c
    pop bc
    pop hl
    ret

Func_032_691C::
    push hl
    ld hl, $D80F
    call Func_000_3F25
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_692B
    ld a, [hl]
    and a, $0C

Jump_032_692B::
    pop hl
    ret
    ds $449, $00

Data_032_6D76:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16F, $00

Data_032_6EE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $2AE, $00

Data_032_7193:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $375, $00

Data_032_7508:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $20D, $00

Data_032_7715:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $334, $00

Jump_032_7A49::
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
