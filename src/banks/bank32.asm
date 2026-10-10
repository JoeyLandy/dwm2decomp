SECTION "Bank 32", ROMX[$4000], BANK[$32]
    db $32

; 8 call sites from 6 routines (e.g. GameMode4_Update, Func_03A_4001, Func_03A_4ADB, Func_03A_548F, ...)
; reads: wCB75, wCB76
Func_032_4001::
    ld a, [wCB75]
    ld l, a
    ld a, [wCB76]
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

; 1 call site from 1 routine (e.g. Func_032_4001)
; reads: wCB75, wCB76
Func_032_401C::
    ld a, [wCB75]
    add a, $05
    ld l, a
    ld a, [wCB76]
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
    ld a, [wCB75]
    add a, $03
    ld l, a
    ld a, [wCB76]
    adc a, $00
    ld h, a
    inc [hl]

; 1 call site from 1 routine (e.g. Func_032_4001)
; reads: wCB75, wCB76
Func_032_403F::
    call Func_032_4083
    ld a, b
    and a, c
    cp a, $FF
    jr nz, Jump_032_4053
    ld a, [wCB75]
    ld l, a
    ld a, [wCB76]
    ld h, a
    ld [hl], $00
    ret

Jump_032_4053::
    ld a, c
    cp a, $F8
    jr c, Jump_032_4073
    cp a, $FE
    jr nz, Jump_032_406D
    ld a, [wCB75]
    add a, $03
    ld l, a
    ld a, [wCB76]
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
    ld a, [wCB75]
    add a, $04
    ld l, a
    ld a, [wCB76]
    adc a, $00
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], b
    ret

; 1 call site from 1 routine (e.g. Func_032_403F)
; reads: wCB75, wCB76
Func_032_4083::
    ld a, [wCB75]
    ld c, a
    ld a, [wCB76]
    ld b, a
    inc bc
    inc bc
    ld a, [bc]
    add a, a
    ld hl, Data_032_40A6
    add_a_to_hl
    deref_hl
    inc bc
    ld a, [bc]
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ret

Data_032_40A6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0C80A6, $9A

; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG
Func_032_4140:: ; heuristic: target of a pointer table; C0
    rlca
    ld [bc], a
    rra
    ld [$0308], sp
    add hl, bc
    inc bc
    ld a, [bc]
    inc bc
    dec bc
    inc bc
    inc c
    inc bc
    add hl, bc
    inc bc
    ld a, [bc]
    inc bc
    dec bc
    ld [bc], a
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    ld c, $02
    rra
    ld [bc], a
    rst $38
    rst $38
    ld [$0902], sp
    dec b
    ld a, [bc]
    dec b
    dec bc
    dec b
    inc c
    ld [bc], a
    dec c
    ld [bc], a
    ld c, $02
    rrca
    ld [bc], a
    rra
    ld [rRAMG], sp
    ld bc, $0201
    ld bc, $0103
    inc b
    inc bc
    dec b
    inc bc
    ld b, $03
    rlca
    inc bc
    inc b
    inc bc
    dec b
    inc bc
    ld b, $03
    rlca
    inc bc
    ld [bc], a
    ld [bc], a
    nop
    ld [bc], a
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
    inc c
    inc bc
    dec c
    inc bc
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
    inc c
    inc bc
    dec c
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0203
    ld [bc], a
    inc bc
    inc b
    inc b
    dec b
    dec b
    inc bc
    ld b, $04
    rlca
    inc bc
    ld [$0404], sp
    inc bc
    dec b
    inc b
    ld b, $03
    rlca
    inc b
    ld [$0403], sp
    inc b
    dec b
    inc bc
    ld b, $04
    rlca
    inc bc
    ld [$0404], sp
    inc bc
    dec b
    inc b
    ld b, $03
    rlca
    inc b
    ld [$0403], sp
    inc bc
    dec b
    inc b
    ld b, $03
    rlca
    inc b
    ld [$0903], sp
    inc b
    ld a, [bc]
    dec b
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc b
    ld bc, $0202
    inc b
    inc bc
    inc b
    inc b
    ld [bc], a
    nop
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    ld bc, $1F02
    ld [bc], a
    rst $38
    rst $38
    nop
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    rra
    db $10, $03 ; stop
    inc b
    inc b
    ld [bc], a
    dec b
    inc b
    ld b, $02
    rlca
    inc b
    ld [$0302], sp
    inc bc
    inc b
    ld [bc], a
    dec b
    inc bc
    ld b, $02
    rlca
    inc b
    ld [$1F02], sp
    ld [bc], a
    rst $38
    rst $38
    nop
    ld [bc], a
    ld bc, $0202
    ld [bc], a
    inc bc
    ld [bc], a
    rra
    db $10, $04 ; stop
    dec b
    dec b
    dec b
    ld b, $05
    rlca
    ld [bc], a
    ld [$0E02], sp
    ld [bc], a
    add hl, bc
    ld [bc], a
    rrca
    ld [bc], a
    ld c, $02
    db $10, $02 ; stop
    dec bc
    ld [bc], a
    ld de, $0C02
    ld [bc], a
    db $10, $02 ; stop
    dec bc
    ld [bc], a
    ld de, $0C02
    ld [bc], a
    ld [de], a
    ld [bc], a
    dec c
    ld [bc], a
    inc de
    ld [bc], a
    ld [$0E02], sp
    ld [bc], a
    add hl, bc
    ld [bc], a
    rrca
    ld [bc], a
    ld a, [bc]
    ld [bc], a
    db $10, $02 ; stop
    dec bc
    ld [bc], a
    ld b, $02
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
    ld [bc], a
    inc c
    ld [bc], a
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    inc bc
    ld bc, $0203
    inc b
    inc bc
    inc b
    inc b
    dec b
    dec b
    inc b
    ld b, $05
    rlca
    inc b
    ld [$0905], sp
    inc b
    ld a, [bc]
    dec b
    dec bc
    inc b
    inc c
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
    inc c
    inc bc
    dec c
    inc bc
    ld c, $03
    dec bc
    inc bc
    inc c
    inc bc
    dec c
    inc bc
    ld c, $03
    rrca
    inc bc
    db $10, $03 ; stop
    ld de, $1203
    inc bc
    inc de
    inc bc
    inc d
    inc bc
    dec d
    inc bc
    ld d, $03
    rla
    inc bc
    jr Jump_032_430B
    db $19, $03, $1A

Jump_032_430B::
    inc bc
    rra
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
    inc c
    inc bc
    dec c
    inc bc
    ld c, $03
    rrca
    inc bc
    db $10, $03 ; stop
    ld de, $1203
    inc bc
    rra
    ld [bc], a
    rst $38
    rst $38
    nop
    dec b
    ld bc, $0204
    inc b
    inc bc
    inc bc

; no direct call (reached through a table, a jump or a vector)
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

; no direct call (reached through a table, a jump or a vector)
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

; no direct call (reached through a table, a jump or a vector)
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
    ld de, rSC
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
    ld de, rSC
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

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
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

; 1 call site from 1 routine (e.g. RunBattleActions_Case00)
; reads: wBattleResolveStep
Func_032_4ADC::
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_032_4ADC_Case00
    dw Func_032_4ADC_Case01
    dw Func_032_4ADC_Case02
    dw Func_032_4ADC_Case03
    dw Func_032_4ADC_Case04
    dw Func_032_4ADC_Case05
    dw Func_032_4ADC_Case06
    dw Func_032_55EE
    dw Func_032_4ADC_Case08
    dw Func_032_4ADC_Case09

; entry 0 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case00::
Jump_032_4AF4:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_4ADC_Table2_Case00
    dw Func_032_4ADC_Table2_Case01
    dw Func_032_4ADC_Table2_Case02
    dw Func_032_4ADC_Table2_Case03
    dw Func_032_4ADC_Table2_Case04
    dw Func_032_4ADC_Table2_Case05

; entry 0 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wDABD, wD89E, wBattleActor, wBattleSubStep
; writes: wBattleSubStep, wBattleSubPhase, wBattleResolveStep, wBattleActor
; points at: wD895, wDA5B, wBattleSubStep, wD811, wD89E, wDA1D, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Table2_Case00::
Jump_032_4B04:: ; address name
    call Func_032_4E29
    ld a, [wDABD]
    or a, a
    jr z, Jump_032_4B14
    ld a, $04
    ld [wBattleSubStep], a
    jr Jump_032_4B61

Jump_032_4B14::
    ld a, [wD89E]
    cp a, $09
    jr z, Jump_032_4B38
    ld hl, wD895
    call Func_032_57FD
    cp a, $FF
    jr z, Jump_032_4B38
    cp a, $10
    jr nz, Jump_032_4B3F
    ld a, $08
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    jr Jump_032_4B61

Jump_032_4B38::
    ld a, $05
    ld [wBattleSubStep], a
    jr Jump_032_4B61

Jump_032_4B3F::
    ld [wBattleActor], a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_032_4B5D
    ld a, [wBattleActor]
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr z, Jump_032_4B5D
    ld hl, wBattleSubStep
    inc [hl]
    jr Func_032_4ADC_Table2_Case01

Jump_032_4B5D::
    ld hl, wD89E
    inc [hl]

Jump_032_4B61::
    ret

; entry 1 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleSubStep
; writes: wBattleSubStep, wBattleResolveStep
; points at: wD811, wD89E, wDA1D, wBattleSubStep, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Table2_Case01::
Jump_032_4B62:: ; address name
    ld a, [wBattleActor]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl-]
    and a, $C0
    jr z, Jump_032_4B7A
    ld d, $15
    farcall Func_03A_6EE5
    jr Jump_032_4BD8

Jump_032_4B7A::
    dec hl
    ld a, [hl+]
    and a, $C0
    jr z, Jump_032_4B98
    ld a, [wBattleActor]
    push af
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    pop af
    ld [hl-], a
    ld [hl], $CD
    ld a, $03
    ld [wBattleSubStep], a
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
    ld a, [wBattleActor]
    push af
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    pop af
    ld [hl-], a
    pop af
    ld [hl], a
    ld a, $04
    ld [wBattleSubStep], a
    jr Jump_032_4BE0

Jump_032_4BC6::
    call Func_032_4C3E
    jr nc, Jump_032_4BD1
    ld hl, wBattleSubStep
    inc [hl]
    jr Func_032_4ADC_Table2_Case02

Jump_032_4BD1::
    ld a, [wBattleSubStep]
    cp a, $04
    jr z, Jump_032_4BE0

Jump_032_4BD8::
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wD89E
    inc [hl]

Jump_032_4BE0::
    ret

; entry 2 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleResolveStep, wBattleSubStep
; points at: wBattleSubStep, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Table2_Case02::
Jump_032_4BE1:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 5, [hl]
    jr z, Func_032_4ADC_Table2_Case03
    call Func_032_4C9C
    jr nc, Func_032_4ADC_Table2_Case03
    ld a, [wBattleActor]
    call Func_032_6803
    ld a, h
    or a, l
    ret nz
    ld a, $09
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 3 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleSubStep
; points at: wBattleSubStep, wBattleStatus, wBattleResolveStep
Func_032_4ADC_Table2_Case03::
Jump_032_4C0A:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Func_032_4ADC_Table2_Case04
    call Func_032_4D99
    ld d, $14
    farcall Func_03A_6EE5
    ret

; entry 4 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep
; points at: wBattleResolveStep
Func_032_4ADC_Table2_Case04::
Jump_032_4C27:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 5 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
Func_032_4ADC_Table2_Case05::
Jump_032_4C30:: ; address name
    ld a, $09
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; 1 call site from 1 routine (e.g. Func_032_4ADC_Table2_Case01)
; reads: wBattleActor
; points at: wBattleStatus
Func_032_4C3E::
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
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
    farcall Func_03A_6EE5

Jump_032_4C97::
    call Func_032_4EE4
    xor a, a

Jump_032_4C9B::
    ret

; 1 call site from 1 routine (e.g. Func_032_4ADC_Table2_Case02)
; reads: wC5E7, wC5E8, wBattleActor, wBattleDamageLo, wD873
; writes: wBattleSubStep
; points at: wBattleStatus, wD89E
Func_032_4C9C::
    call AdvanceRandom
    ld a, [wC5E7]
    cp a, $40
    jr nc, Jump_032_4CB7
    ld a, [wC5E8]
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
    ld hl, wD89E
    inc [hl]
    call Func_032_4D8D
    ld d, $0F
    call Func_032_4D23
    xor a, a
    ld [wBattleSubStep], a
    jr Jump_032_4D2A

Jump_032_4CCB::
    call Func_032_4D2C
    jr nc, Jump_032_4CD4
    xor a, a
    ld [de], a
    dec de
    ld [de], a

Jump_032_4CD4::
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_032_4CB7
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank32
    ld d, $10
    call Func_032_4D23
    ld a, [wBattleActor]
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
    ld a, [wBattleActor]
    call SetBit1OfWD095Indexed_Bank32
    ld d, $11
    call Func_032_4D23
    jr Jump_032_4D2A

Jump_032_4D0B::
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    set 4, [hl]
    ld a, [wBattleActor]
    call SetBit2OfWD095Indexed_Bank32
    ld d, $12
    call Func_032_4D23
    jr Jump_032_4D2A

; 4 call sites from 1 routine (e.g. Func_032_4C9C)
Func_032_4D23::
    farcall Func_03A_6EE5
    ret

Jump_032_4D2A::
    scf
    ret

; 1 call site from 1 routine (e.g. Func_032_4C9C)
; reads: wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleHP
Func_032_4D2C::
    ld a, [wBattleActor]
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    push hl
    ld a, l
    add a, $10
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    deref_hl
    ld a, $06
    call DivideHLByA
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    pop de
    ld a, [de]
    sub a, l
    ld [de], a
    inc de
    ld a, [de]
    sbc a, h
    ld [de], a
    ret

; 1 call site from 1 routine (e.g. Func_032_4C9C)
; reads: wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wBattleMP
Func_032_4D5A::
    ld a, [wBattleActor]
    call Func_032_67FE
    ld a, h
    or a, l
    jr nz, Jump_032_4D69
    ld bc, $0000
    jr Jump_032_4D84

Jump_032_4D69::
    ld a, $06
    call DivideHLByA
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleMP
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
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    ret

; 1 call site from 1 routine (e.g. Func_032_4C9C)
; reads: wBattleActor
; points at: wD80F
Func_032_4D8D::
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    ld [hl], $00
    ret

; 1 call site from 1 routine (e.g. Func_032_4ADC_Table2_Case03)
; reads: wBattleActor, wC5E7, wC58A, wC5E8, wCFC5
; writes: wD8A6, wBattleTarget
; points at: wD80F, wDA1C, wDA1D
Func_032_4D99::
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
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
    ld a, [wC5E7]
    cp a, $80
    jr c, Jump_032_4DF1
    cp a, $C0
    jr c, Jump_032_4DF5
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_032_4DD1
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_4DD1
    ld hl, Data_032_4E20
    jr Jump_032_4DD4

Jump_032_4DD1::
    ld hl, Data_032_4E1C

Jump_032_4DD4::
    ld a, [wC5E8]
    ld b, a
    ld a, [hl+]
    call DivideBByA
    call Func_032_57FD
    cp a, $C8
    jr nz, Jump_032_4DF7
    ld a, [wCFC5]
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
    ld [wD8A6], a
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld [hl], b
    farcall Func_039_4001
    ld a, [wBattleActor]
    ld hl, wDA1D
    add a, a
    call Func_032_57FD
    ld [wBattleTarget], a
    ret

Data_032_4E1C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $C2, $C3, $C5

Data_032_4E20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C6

; 1 call site from 1 routine (e.g. Func_032_4ADC_Table2_Case00)
; reads: wDABD
; writes: wDAD2, wDABE, wD802, wBattleSubStep, wDABA, wDABF, wDAD1, wC970
Func_032_4E29::
    xor a, a
    ld [wDAD2], a
    xor a, a
    ld [wDABE], a
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wDABD]
    or a, a
    ret nz
    xor a, a
    ld [wDABA], a
    xor a, a
    ld [wDABF], a
    ld a, $FF
    ld [wDAD1], a
    xor a, a
    ld [wC970], a
    ret

; 1 call site from 1 routine (e.g. Func_032_4C3E)
; reads: wC5E7, wBattleActor, wBattleTarget, wD871
; writes: wD871, wBattleTarget
; points at: wD80F, wDA1C
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
    ld a, [wC5E7]
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
    ld a, [wBattleActor]
    call SetBit2OfWD095Indexed_Bank32
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
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
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a

; entry 9 of the `rst $00` table in Func_032_4EE4
; no direct call (reached through a table, a jump or a vector)
; reads: wD871
; writes: wBattleTarget
Func_032_4EE4_Case09::
Jump_032_4ECA:: ; address name
    add_a_to_hl
    ld [hl], $BF
    jr Jump_032_4EDB

Jump_032_4ED3::
    ld d, $82
    farcall Func_03A_7193

Jump_032_4EDB::
    ld a, [wD871]
    ld [wBattleTarget], a
    scf
    ccf
    ret

; 1 call site from 1 routine (e.g. Func_032_4C3E)
; reads: wBattleActor
; points at: wD80F
Func_032_4EE4::
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    ld [hl], a
    ret

; entry 1 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case01::
Jump_032_4EF2:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_4EE4_Case00
    dw Func_032_4EE4_Case01
    dw Func_032_4EE4_Case02
    dw Func_032_4EE4_Case03
    dw Func_032_4EE4_Case04

Jump_032_4F00::
    dw $4CCD
    dw $3851
    dw Func_032_4EE4_Case07
    dw $07FE
    dw Func_032_4EE4_Case09

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
Func_032_4F0A:: ; heuristic: follows a terminator; C0
    ld c, a
    and a, $07
    jr z, Jump_032_4F32
    push de
    farcall Func_03A_7508
    pop af
    cp a, $01
    call nz, Func_032_5386
    call Func_032_543C
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    call Func_032_691C
    ret nz
    farcall Func_0A3_413F
    ret

Jump_032_4F32::
    farcall Func_03A_7715
    call Func_032_543C
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    call Func_032_691C
    ret nz
    farcall Func_0A3_413F
    ret
    db $21, $CC, $CF, $34, $C9

; entry 0 of the `rst $00` table in Func_032_4EE4
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wBattleActor, wD8A6, wCFF3
; writes: wD8A6
; points at: wDAD8, wBattleSubStep, wBattleStatus, wDA1C, wDAE0
Func_032_4EE4_Case00::
Jump_032_4F53:: ; address name
    farcall Func_0A3_4960
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_032_4F00
    call Func_032_5804
    call Func_032_535F
    jp nc, Jump_032_4FFB
    call Func_032_51F9
    jr c, Jump_032_4F9C
    ld a, [wBattleActor]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_032_4F85
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr nc, Jump_032_4FC8

Jump_032_4F85::
    ld a, d
    cp a, $07
    jp z, Jump_032_4FFB
    push de
    farcall Func_03A_7508
    pop af
    cp a, $01
    call nz, Func_032_5386
    call Func_032_543C
    ret

Jump_032_4F9C::
    ld a, [wBattleActor]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_032_4FFB
    ld a, [wBattleActor]
    ld hl, wDAE0
    call Func_032_57FD
    or a, a
    jr nz, Jump_032_4FFB
    ld a, [wCFF3]
    bit 2, a
    jr nz, Jump_032_4FFB
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank32
    cp a, $03
    jr c, Jump_032_4FFB

Jump_032_4FC8::
    ld a, [wD8A6]
    cp a, $6E
    jr z, Jump_032_4FFB
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $10
    jr nz, Jump_032_4FFB
    farcall Func_030_5440
    call Func_032_5804
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    inc hl
    ld [hl], $FF
    call Func_032_51F9
    jr nc, Jump_032_4F85

Jump_032_4FFB::
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_4EE4
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wBattleActor, wD89E, wD8A6
; points at: wD895, wDA5B, wDA1C, wBattleSubStep
Func_032_4EE4_Case01::
Jump_032_5000:: ; address name
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_032_5073
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_5073
    ld a, [wD89E]
    or a, a
    jr z, Jump_032_5073
    ld b, a
    ld hl, wD895

Jump_032_5018::
    ld a, [hl]
    cp a, $10
    jr z, Jump_032_5043
    cp a, $04
    jr c, Jump_032_5043
    push hl
    ld hl, wDA5B
    call Func_032_57FD
    pop hl
    cp a, $03
    jr z, Jump_032_5031
    cp a, $FE
    jr nz, Jump_032_5043

Jump_032_5031::
    push hl
    ld a, [hl]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld a, [wD8A6]
    cp a, [hl]
    pop hl
    jr z, Jump_032_5049

Jump_032_5043::
    inc hl
    dec b
    jr nz, Jump_032_5018
    jr Jump_032_5073

Jump_032_5049::
    ld a, [wD8A6]
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
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld [hl], $00
    inc hl
    ld [hl], $FF
    call Func_032_5804

Jump_032_5073::
    ld hl, wBattleSubStep
    inc [hl]
    ret

Data_032_5078:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13
    db $14, $15, $19, $1A, $26, $28, $2A, $2C, $2E, $2F, $30, $33, $3D, $3E, $3F
    dw Func_032_4140
    dw Func_032_4342
    dw Func_032_4544
    dw Func_032_4746
    dw Func_032_4A49
    db $4B, $4D, $4E, $4F, $64, $65, $66, $67, $6B, $6C, $6D, $6F, $70, $71, $72, $73
    db $74, $79, $7A, $8E, $90, $FF

; entry 2 of the `rst $00` table in Func_032_4EE4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wCFF2
; writes: wBattleTarget
; points at: wDA1D, wDAD8, wBattleSubStep
Func_032_4EE4_Case02::
Jump_032_50B7:: ; address name
    ld a, [wBattleActor]
    ld hl, wDA1D
    add a, a
    call Func_032_57FD
    cp a, $FF
    jr z, Jump_032_50F6
    ld a, [wBattleActor]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr nz, Jump_032_50DD
    ld a, [wCFF2]
    and a, $0F
    cp a, $01
    jr z, Jump_032_50FC

Jump_032_50DD::
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr nc, Jump_032_50F6
    ld a, [wCFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_032_50F6
    cp a, $04
    jr z, Jump_032_50F6
    jr Jump_032_50FC

Jump_032_50F6::
    farcall Func_039_4001

Jump_032_50FC::
    ld a, [wBattleActor]
    ld hl, wDA1D
    add a, a
    call Func_032_57FD
    ld [wBattleTarget], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_032_4EE4
; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wRecordBufferData
; writes: wBattleSubStep
; points at: wBattleResolveStep
Func_032_4EE4_Case03::
Jump_032_510E:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wD8A6]
    call Func_000_3F47
    ret nz
    ld d, $02
    farcall Func_03A_7508
    ld a, [wRecordBufferData]
    or a, a
    call nz, Func_032_5386
    call Func_032_543C
    ret

; entry 4 of the `rst $00` table in Func_032_4EE4
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
Func_032_4EE4_Case04::
Jump_032_5130:: ; address name
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
    ld hl, wBattleSubStep
    dec [hl]
    ld hl, wBattleSubStep
    dec [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRecordBufferData, hFFC6, hFFC7
; writes: hFFC7, wRecordBuffer, wCFED, hFFC8, wBattleActor
; points at: wDA2C, wDA5B
Func_032_514C:: ; heuristic: follows a terminator; C0
    xor a, a
    ldh [hFFC7], a
    ld a, [wBattleActor]
    add a, a
    ld hl, wDA2C
    call Func_032_57FD
    ld [wRecordBuffer], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    ldh [hFFC8], a
    ld a, [wBattleActor]
    call Func_032_68FD
    jr nc, Jump_032_5178
    ld d, $00
    jr Jump_032_517D

Jump_032_5178::
    call Func_032_51F9
    jr c, Jump_032_5181

Jump_032_517D::
    ld a, $01
    ldh [hFFC7], a

Jump_032_5181::
    push de
    ld a, [wBattleActor]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    add a, a
    ld hl, wDA2C
    call Func_032_57FD
    ld [wRecordBuffer], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    ldh [hFFC8], a
    ld a, [wBattleActor]
    call Func_032_68FD
    jr c, Jump_032_51C3
    ld a, [wBattleActor]
    ld hl, wDA5B
    add_a_to_hl
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
    ldh a, [hFFC7]
    or a, $02
    ldh [hFFC7], a

Jump_032_51D2::
    pop af
    ld [wBattleActor], a
    ldh a, [hFFC7]
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

; 6 call sites from 4 routines (e.g. Func_032_5820_Case01, Func_032_4EE4_Case04, Func_032_4EE4_Case00, Func_032_514C)
; reads: wD8A6, wBattleActor, hFFC8, wCFF3, wRecordBufferData
; writes: hFFC8
; points at: wD80E
Func_032_51F9::
    ld a, [wD8A6]
    cp a, $D0
    jr c, Jump_032_5206
    cp a, $E4
    jr nc, Jump_032_5206
    jr Jump_032_520B

Jump_032_5206::
    ld a, [wRecordBufferData]
    ldh [hFFC8], a

Jump_032_520B::
    ld a, [wBattleActor]
    call Func_032_6808
    ldh a, [hFFC8]
    or a, a
    jr z, Jump_032_522D
    ld a, h
    or a, l
    jp z, Jump_032_5296
    ldh a, [hFFC8]
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
    ld a, [wD8A6]
    call Func_000_3F47
    jr z, Jump_032_529A
    ld a, [wCFF3]
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
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr c, Jump_032_5294
    ld a, [wCFF3]
    bit 3, a
    jr z, Jump_032_5294
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wD80E
    call AddAx9ToHL

Jump_032_527A::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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

; 1 call site from 1 routine (e.g. Func_032_51F9)
; reads: wBattleActor, wCFF2
; points at: wD80D, wD80A, wD80B, wD80E
Func_032_529E::
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_032_52F9
    ld hl, wD80A
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_52B8
    ld hl, wD80B

Jump_032_52B8::
    bit 3, [hl]
    jp nz, Jump_032_52FD
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr c, Jump_032_5301
    ld a, [wCFF2]
    cp a, $12
    jr nz, Jump_032_5301
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wD80E
    call AddAx9ToHL

Jump_032_52DE::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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

; 1 call site from 1 routine (e.g. Func_032_51F9)
; reads: wBattleActor
; points at: wD80D, wD80E
Func_032_5303::
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_032_5344
    ld a, [wBattleActor]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr c, Jump_032_5348
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03
    ld hl, wD80E
    call AddAx9ToHL

Jump_032_532A::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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

; 1 call site from 1 routine (e.g. Func_032_51F9)
; reads: wBattleActor
; points at: wD80D
Func_032_534A::
    ld a, [wBattleActor]
    ld hl, wD80D
    call AddAx9ToHL
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

; 3 call sites from 3 routines (e.g. Func_032_5386, Func_032_55EE, Func_032_4EE4_Case00)
; reads: wD8A6
Func_032_535F::
    ld a, [wD8A6]
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

; 8 call sites from 8 routines (e.g. Func_032_5820_Case07, Func_032_5820_Case01, Func_032_4ADC_Case08, Func_032_4EE4_Case04, ...)
; reads: wD8A6, wBattleActor, hFFC6, wRecordBufferData
; writes: wRecordBuffer, wCFED, wBattleActor, wRecordBufferData, wD866, wD867
; points at: wDA2C, wBattleMP
Func_032_5386::
    ld a, [wD8A6]
    cp a, $D0
    jr c, Jump_032_5393
    cp a, $E4
    jr nc, Jump_032_5393
    jr Jump_032_53C8

Jump_032_5393::
    call Func_032_535F
    ret nc

; 4 call sites from 1 routine (e.g. Func_032_5397)
; reads: wBattleActor, wRecordBufferData
; writes: wD866, wD867
; points at: wBattleMP
Func_032_5397::
    ld a, [wBattleActor]
    ld hl, wBattleMP
    add a, a
    add_a_to_hl
    ld a, [wRecordBufferData]
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
    ld [wD866], a
    ld a, [hl]
    ld [wD867], a
    xor a, a
    ld [hl-], a
    ld [hl], a

Jump_032_53C1::
    ld a, [wBattleActor]
    call SetBit1OfWD095Indexed_Bank32
    ret

Jump_032_53C8::
    cp a, $D6
    jr z, Jump_032_541A
    cp a, $D9
    jr z, Jump_032_541A
    ld a, [wBattleActor]
    ld hl, wDA2C
    add a, a
    call Func_032_57FD
    ld [wRecordBuffer], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    call Func_032_5397
    ld a, [wBattleActor]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    ld hl, wDA2C
    add a, a
    call Func_032_57FD
    ld [wRecordBuffer], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    call Func_032_5397
    pop af
    ld [wBattleActor], a
    call Func_032_5804
    ret

Jump_032_541A::
    ld a, $FF
    ld [wRecordBufferData], a
    call Func_032_5397
    ld a, [wBattleActor]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call Func_032_5397
    pop af
    ld [wBattleActor], a
    call Func_032_5804
    ret

; 7 call sites from 6 routines (e.g. Func_032_4ADC_Case04, Func_032_4EE4_Case04, Func_032_4EE4_Case03, Func_032_4EE4_Case00, ...)
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep
Func_032_543C::
    ld a, $07
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 2 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; points at: wBattleResolveStep, wD854
Func_032_4ADC_Case02::
Jump_032_544A:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wD854
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
    farcall Func_03A_6EE5
    ret

; entry 3 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wC58A, wCFC5, wBattleActor, wD8A6
; writes: wDAD3, wD093
; points at: wBattleResolveStep
Func_032_4ADC_Case03::
Jump_032_5474:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    farcall Func_03A_6D76
    ld a, $80
    ld [wDAD3], a
    farcall Func_03A_5762
    ld a, [wC58A]
    or a, a
    ret nz
    ld a, [wCFC5]
    cp a, $04
    ret c
    cp a, $06
    ret nc
    ld a, [wBattleActor]
    cp a, $04
    ret c
    ld a, [wD8A6]
    or a, a
    ret z
    cp a, $AB
    ret z
    cp a, $AC
    ret z
    cp a, $B0
    ret nc
    ld [wD093], a
    ret

; entry 4 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wCFF4
; writes: wBattleResolveStep
; points at: wBattleResolveStep, wD80F, wBattleStatus, wD8A7, wBattleSubPhase, wD854
Func_032_4ADC_Case04::
Jump_032_54AF:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr nz, Jump_032_54F5
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_032_54E0
    ld a, [wBattleActor]
    ld de, wD8A7
    add a, e
    ld e, a
    jr nc, Jump_032_54DB
    inc d

Jump_032_54DB::
    ld a, [de]
    bit 4, a
    jr nz, Jump_032_54EA

Jump_032_54E0::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, $06
    ld [wBattleResolveStep], a
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
    ld a, [wBattleActor]
    ld hl, wD854
    add a, a
    call Func_032_57FD
    and a, $03
    ret z
    bit 0, a
    jr nz, Jump_032_550A
    ld d, $2F
    jr Jump_032_5512

Jump_032_550A::
    ld a, [wCFF4]
    bit 3, a
    ret z
    ld d, $2E

Jump_032_5512::
    farcall Func_03A_6EE5
    ret

; entry 5 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; writes: wBattleSubStep, wDAD2
; points at: wDC20, wBattleResolveStep
Func_032_4ADC_Case05::
Jump_032_5519:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    call Func_032_553B
    ret z
    ld a, $80
    ld [wDAD2], a
    farcall Func_03A_4001
    ret

; 1 call site from 1 routine (e.g. Func_032_4ADC_Case05)
; reads: wD8A6
Func_032_553B::
    ld a, [wD8A6]
    cp a, $CD
    ret

; entry 6 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case06::
Jump_032_5541:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_553B_Case00
    dw Func_032_553B_Case01
    dw Func_032_553B_Case02
    dw Func_032_553B_Case03

; entry 0 of the `rst $00` table in Func_032_553B
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wCFF6, wCFF2, wD8A6, wBattleTarget
; writes: wD8A6, wBattleTarget, wBattleSubStep
; points at: wDA1C, wD814, wBattleResolveStep, wDAAC, wBattleSubStep
Func_032_553B_Case00::
Jump_032_554D:: ; address name
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    inc hl
    ld a, [hl]
    ld [wBattleTarget], a
    ld a, [wCFF6]
    bit 7, a
    jr z, Jump_032_55A9
    ld a, [wCFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_032_5585
    ld a, [wD8A6]
    cp a, $35
    jr z, Jump_032_5585
    ld a, [wBattleTarget]
    ld hl, wD814
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_032_55B2
    jr Jump_032_55A9

Jump_032_5585::
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wD814
    call AddAx9ToHL

Jump_032_5593::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_032_55B2::
    res 4, [hl]
    ld hl, wDAAC
    ld a, [hl+]
    ld [hl-], a
    ld a, [wD8A6]
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_553B
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
Func_032_553B_Case01::
Jump_032_55C2:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld d, $B0
    farcall Func_03A_7193
    ret

; entry 2 of the `rst $00` table in Func_032_553B
; no direct call (reached through a table, a jump or a vector)
; reads: wDAAD
; writes: wDAAD
; points at: wBattleSubStep
Func_032_553B_Case02::
Jump_032_55CF:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wDAAD]
    cp a, $FF
    ret z
    ld d, $92
    farcall Func_03A_7193
    ld a, $FF
    ld [wDAAD], a
    ret

; entry 3 of the `rst $00` table in Func_032_553B
; no direct call (reached through a table, a jump or a vector)
Func_032_553B_Case03::
Jump_032_55E7:: ; address name
    call Func_032_5386
    call Func_032_543C
    ret

; 1 call site from 1 routine (e.g. Func_032_5820_Case06)
; reads: wC58A, wD043, wDABA, wD044, wD8A6, wD045, wBattleActor, wC57F, ...
; writes: wD092, wStringIndex, wStringCategory, wBattlePhase, wBattleStep, wBattleSubPhase, wBattleResolveStep, wDataBank, ...
; points at: wBattleResolveStep, wD057, wD058
Func_032_55EE::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wC58A]
    or a, a
    ret z
    cp a, $02
    ret z
    ld a, [wD043]
    or a, a
    ret z
    ld a, [wDABA]
    or a, a
    ret nz
    call Func_032_535F
    ret nc
    ld a, [wD044]
    bit 7, a
    ret z
    ld b, a
    ld a, [wD8A6]
    ld hl, Data_032_5688
    add_a_to_hl
    ld a, [hl]
    or a, a
    ret z
    and a, b
    ret z
    ld c, a
    ld a, [wD045]
    and a, c
    jr z, Jump_032_563B
    ld hl, wD057
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_032_5633
    ld hl, wD058

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
    call QueueMusic
    ld a, [wC57F]
    rlca
    and a, $04
    ld b, a
    ld a, [wBattleActor]
    and a, $04
    cp a, b
    jr nz, Jump_032_5658
    ld a, $05
    ld [wD092], a
    ld a, $63
    jr Jump_032_565F

Jump_032_5658::
    ld a, $04
    ld [wD092], a
    ld a, $64

Jump_032_565F::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld a, $02
    ld [wBattlePhase], a
    ld a, $09
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a, a
    ld [wDataBankSave], a
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
    ds $39, $00

; entry 8 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleResolveStep, wBattleSubStep
; points at: wD854, wBattleSubPhase
Func_032_4ADC_Case08::
Jump_032_5770:: ; address name
    ld a, [wBattleActor]
    ld hl, wD854
    call AddDoubleAToHL_Bank32
    bit 4, [hl]
    call z, Func_032_5386
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 9 of the `rst $00` table in Func_032_4ADC
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_4ADC_Case09::
Jump_032_578B:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_55EE_Case00
    dw Func_032_55EE_Case01

; entry 0 of the `rst $00` table in Func_032_55EE
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wBattleActor
; writes: wBattleTarget
; points at: wBattleSubStep
Func_032_55EE_Case00::
Jump_032_5793:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call DefeatTarget
    call Func_032_5AB3
    call Func_032_57E4
    ld d, $8A
    cp a, $04
    jr c, Jump_032_57AF
    ld d, $8D

Jump_032_57AF::
    farcall Func_03A_7193
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_55EE
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wBattleStep, wBattleSubStep, wBattleResolveStep
; points at: wBattlePhase
Func_032_55EE_Case01::
Jump_032_57BA:: ; address name
    ld a, [wC52B]
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
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    jr Jump_032_57E3

Jump_032_57DA::
    xor a, a
    ld [wBattleSubStep], a
    ld a, $07
    ld [wBattleResolveStep], a

Jump_032_57E3::
    ret

; 2 call sites from 2 routines (e.g. Func_032_55EE_Case01, Func_032_55EE_Case00)
; reads: wBattleActor
Func_032_57E4::
    ld a, [wBattleActor]
    ret

; 1 call site from 1 routine (e.g. Func_032_55EE_Case01)
; reads: wC58A
Func_032_57E8::
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_032_57F8
    ld a, c
    cp a, $04
    jr c, Jump_032_57F8
    call CarryUnlessWDA63SlotEmpty
    ret

Jump_032_57F8::
    ld a, c
    call Func_000_3E25
    ret

; 18 call sites from 13 routines (e.g. Func_032_5397, Func_032_5804, Func_032_4ADC_Case04, Func_032_4ADC_Case02, ...)
Func_032_57FD::
    add_a_to_hl
    ld a, [hl]
    ret

; 7 call sites from 4 routines (e.g. Func_032_5397, Func_032_4EE4_Case01, Func_032_4EE4_Case00, Func_032_514C)
; reads: wBattleActor
; writes: wD8A6, wRecordBuffer, wCFED
; points at: wDA1C
Func_032_5804::
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    ld [wRecordBuffer], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    ret

; 1 call site from 1 routine (e.g. RunBattleStep4_Case00)
; reads: wBattleResolveStep
Func_032_5820::
    ld a, [wBattleResolveStep]
    rst $00
    dw Func_032_5820_Case00
    dw Func_032_5820_Case01
    dw Func_032_5820_Case02
    dw Func_032_5820_Case03
    dw Func_032_5820_Case04
    dw Func_032_5820_Case05
    dw Func_032_5820_Case06
    dw Func_032_5820_Case07

; entry 0 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wDABA, wD8A6
; writes: wDABD, wDABA, wBattleActor, wBattleTarget
; points at: wBattleResolveStep, wDAC9, wDA1C, wDA5B, wDA1D
Func_032_5820_Case00::
Jump_032_5834:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wDAC9
    ld a, [wBattleActor]
    ld [hl+], a
    ld a, [wBattleTarget]
    ld [hl+], a
    ld a, [wDABA]
    ld [hl+], a
    ld a, [wBattleActor]
    ld de, wDA1C
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
    ld a, [wBattleTarget]
    ld de, wDA1C
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
    ld a, [wBattleTarget]
    ld de, wDA5B
    add a, e
    ld e, a
    jr nc, Jump_032_5872
    inc d

Jump_032_5872::
    ld a, [de]
    ld [hl], a
    ld a, $01
    ld [wDABD], a
    xor a, a
    ld [wDABA], a
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld a, [wBattleActor]
    ld hl, wDA1C
    call AddDoubleAToHL_Bank32
    ld a, [wD8A6]
    ld [hl+], a
    ld [hl], $FF
    ld a, [wBattleActor]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $02
    farcall Func_039_4001
    ld a, [wBattleActor]
    ld hl, wDA1D
    call AddDoubleAToHL_Bank32
    ld a, [hl]
    ld [wBattleTarget], a
    ret

; entry 1 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep
; points at: wBattleResolveStep
Func_032_5820_Case01::
Jump_032_58B3:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call Func_032_51F9
    jr c, Jump_032_58D9
    ld a, d
    and a, $07
    jr z, Jump_032_58D9
    cp a, $07
    jr z, Jump_032_58D9
    push de
    farcall Func_03A_7508
    pop af
    cp a, $01
    jr z, Jump_032_58D4
    call Func_032_5386

Jump_032_58D4::
    ld a, $05
    ld [wBattleResolveStep], a

Jump_032_58D9::
    ret

; entry 2 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wDAB2
; writes: wDAD3
; points at: wBattleResolveStep
Func_032_5820_Case02::
Jump_032_58DA:: ; address name
    ld a, [wDAB2]
    bit 0, a
    jr nz, Jump_032_58F2
    farcall Func_03A_6D76
    ld a, $80
    ld [wDAD3], a
    farcall Func_03A_5762

Jump_032_58F2::
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wSoundChannelSlots
; writes: wDAD2, wBattleSubStep
; points at: wDC20, wBattleResolveStep
Func_032_5820_Case03::
Jump_032_58F7:: ; address name
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, $80
    ld [wDAD2], a
    farcall Func_03A_4001
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 4 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep
Func_032_5820_Case04::
Jump_032_5915:: ; address name
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_5820_Table2_Case00
    dw Func_032_5820_Table2_Case01
    dw Func_032_5820_Table2_Case02
    dw Func_032_5820_Table2_Case03

; entry 0 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wCFF6, wCFF2, wBattleTarget, wD8A6
; writes: wD8A6, wBattleTarget, wBattleSubStep
; points at: wDA1C, wD814, wBattleResolveStep, wDAAC, wBattleSubStep
Func_032_5820_Table2_Case00::
Jump_032_5921:: ; address name
    ld a, [wBattleActor]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    inc hl
    ld a, [hl]
    ld [wBattleTarget], a
    ld a, [wCFF6]
    bit 7, a
    jr z, Jump_032_5976
    ld a, [wCFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_032_5952
    ld a, [wBattleTarget]
    ld hl, wD814
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_032_5983
    jr Jump_032_5976

Jump_032_5952::
    ld a, [wBattleTarget]
    and a, $04
    ld c, a
    ld b, $03
    ld hl, wD814
    call AddAx9ToHL

Jump_032_5960::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
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
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_032_5983::
    res 4, [hl]
    ld hl, wDAAC
    ld a, [hl+]
    ld [hl-], a
    ld a, [wD8A6]
    ld [hl], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
Func_032_5820_Table2_Case01::
Jump_032_5993:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld d, $B0
    farcall Func_03A_7193
    ret

; entry 2 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; reads: wDAAD
; writes: wDAAD
; points at: wBattleSubStep
Func_032_5820_Table2_Case02::
Jump_032_59A0:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    ld a, [wDAAD]
    cp a, $FF
    ret z
    ld d, $92
    farcall Func_03A_7193
    ld a, $FF
    ld [wDAAD], a
    ret

; entry 3 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep
; points at: wBattleResolveStep
Func_032_5820_Table2_Case03::
Jump_032_59B8:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

; entry 5 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
Func_032_5820_Case05::
Jump_032_59C1:: ; address name
    ld a, $05
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 6 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
Func_032_5820_Case06::
Jump_032_59CB:: ; address name
    call Func_032_55EE
    ret

; entry 7 of the `rst $00` table in Func_032_5820
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleResolveStep, wBattleSubStep
; points at: wBattleSubPhase
Func_032_5820_Case07::
Jump_032_59CF:: ; address name
    call Func_032_5386
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

; target slot wBattleTarget (wD8A5): when wDAC1's top two bits are not 00 and not 01, wBattleHP[target] -= the 16-bit damage in wD872/wD873 and is clamped at 0 (a result below zero also decrements wCFCB and clears wCFCD); then sets bits 0, 1 and 2 of the target's wD095 flags
; 1 call site from 1 routine (e.g. ResolveStepApplyDamage)
; reads: wDAC1, wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleSubStep, wBattleSubStep2
; points at: wBattleResolveStep, wBattleHP
ApplyDamageToTarget::
Func_032_59DF:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wDAC1]
    and a, $C0
    cp a, $00
    jr z, Jump_032_5A39
    cp a, $40
    jr z, Jump_032_5A26
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
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
    ld hl, wBattleResolveStep
    dec [hl]
    xor a, a
    ld [wBattleSubStep2], a

Jump_032_5A26::
    ld a, [wBattleTarget]
    call SetBit0OfWD095Indexed_Bank32
    ld a, [wBattleTarget]
    call SetBit1OfWD095Indexed_Bank32
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ret

Jump_032_5A39::
    ret

; 1 call site from 1 routine (e.g. RunBattleResolveStep_Case0D)
; reads: wBattleSubStep2
Func_032_5A3A::
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_5A3A_Case00
    dw Func_032_5A3A_Case01
    dw Func_032_5A3A_Case02

; entry 0 of the `rst $00` table in Func_032_5A3A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep2, wDA5B
Func_032_5A3A_Case00::
Jump_032_5A44:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_5A3A
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep2
Func_032_5A3A_Case01::
Jump_032_5A5B:: ; address name
    call Func_032_5AB3
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_5A3A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wD8A6
; writes: wBattleSubStep2
; points at: wBattleResolveStep
Func_032_5A3A_Case02::
Jump_032_5A63:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep2], a
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    call Func_032_5A95
    ret z
    ld a, [wD8A6]
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
    farcall Func_03A_7193
    ret

; 1 call site from 1 routine (e.g. Func_032_5A3A_Case02)
; reads: wD8A6
; points at: wBattleDamageLo
Func_032_5A95::
    ld a, [wD8A6]
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
    ld hl, wBattleDamageLo
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ret

; 11 call sites from 11 routines (e.g. Func_032_6764_Case01, Func_032_55EE_Case00, Func_032_5A3A_Case01, Func_032_66F1_Case01, ...)
; reads: wC58A, wC57F, wBattleTarget, rSTAT
Func_032_5AB3::
    ld a, [wC58A]
    or a, a
    jr z, Jump_032_5AD4
    cp a, $02
    jr z, Jump_032_5AD4
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_032_5AD4
    ld a, [wBattleTarget]
    bit 2, a
    ret nz
    and a, $03
    cp a, $03
    ret z
    ld a, [wBattleTarget]
    jr Jump_032_5AE4

Jump_032_5AD4::
    ld a, [wBattleTarget]
    bit 2, a
    ret z
    and a, $03
    cp a, $03
    ret z
    ld a, [wBattleTarget]
    sub a, $04

Jump_032_5AE4::
    cp a, $02
    jr z, Jump_032_5AF6
    cp a, $01
    jr z, Jump_032_5AF1
    ld hl, vTiles2 + $140
    jr Jump_032_5AF9

Jump_032_5AF1::
    ld hl, vTiles2 + $380
    jr Jump_032_5AF9

Jump_032_5AF6::
    ld hl, vTiles2 + $5C0

Jump_032_5AF9::
    ld c, $24

Jump_032_5AFB::
    ld b, $08

Jump_032_5AFD::
    di

Jump_032_5AFE::
    ldh a, [rSTAT]
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

; target slot wBattleTarget: re-derives its stats (Func_032_5C3F, Func_032_5B94, Func_032_5BE8 clear 'buff' bits), sets wBattleSlotOut[target] = 1, wBattleHP[target] = 0 and clears the target's 9-byte status record (wD80C + 9 * slot)
; 9 call sites from 9 routines (e.g. Func_032_6764_Case00, Func_032_55EE_Case00, Func_032_5A3A_Case00, Func_032_66F1_Case00, ...)
; reads: wBattleTarget, wC58A
; writes: wDAAB, wDABE
; points at: wD812, wBattleSlotOut, wBattleHP, wBattleStatus, wD80A
DefeatTarget::
Func_032_5B12:: ; address name
    call RecomputeTargetMaxHPAndMP
    ld a, [wBattleTarget]
    ld hl, wD812
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_5B2A
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call Func_032_5BE8

Jump_032_5B2A::
    call Func_032_5B94
    ld a, [wBattleTarget]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $01
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    add a, a
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
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
    ld a, [wC58A]
    or a, a
    jr z, Jump_032_5B66
    cp a, $02
    jr nz, Jump_032_5B93

Jump_032_5B66::
    ld a, [wBattleTarget]
    cp a, $03
    jr z, Jump_032_5B78
    jr c, Jump_032_5B8D
    cp a, $07
    jr z, Jump_032_5B78
    ld [wDAAB], a
    jr Jump_032_5B93

Jump_032_5B78::
    ld a, [wBattleTarget]
    and a, $04
    rrca
    rrca
    and a, $01
    ld hl, wD80A
    res 2, [hl]
    ld a, $09
    ld [wDABE], a
    jr Jump_032_5B93

Jump_032_5B8D::
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32

Jump_032_5B93::
    ret

; 1 call site from 1 routine (e.g. DefeatTarget)
; reads: wCFF2, wDABF, wDAD1, wBattleTarget, wDABA
; writes: wDABA
; points at: wD812
Func_032_5B94::
    ld a, [wCFF2]
    and a, $0F
    cp a, $02
    jr nz, Jump_032_5BC3
    ld a, [wDABF]
    bit 1, a
    jr z, Jump_032_5BC3
    ld a, [wDAD1]
    cp a, $FF
    jr z, Jump_032_5BC3
    ld c, a
    ld a, [wBattleTarget]
    cp a, c
    jr c, Jump_032_5BC3
    jr z, Jump_032_5BC3
    ld a, [wDABA]
    bit 7, a
    jr z, Jump_032_5BC3
    cp a, $81
    jr z, Jump_032_5BC3
    dec a
    ld [wDABA], a

Jump_032_5BC3::
    ld a, [wBattleTarget]
    ld e, a
    and a, $04
    ld c, a
    ld b, $04

Jump_032_5BCC::
    ld a, c
    ld hl, wD812
    call AddAx9ToHL
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

; 2 call sites from 2 routines (e.g. Func_032_5E3B, DefeatTarget)
; reads: wBattleStatResultLo, wBattleStatResultHi, wBattleTarget
; writes: wBattleStatResultLo, wBattleStatResultHi
; points at: wBattleAGL, wBattleDEF
Func_032_5BE8::
    push af
    push bc
    push de
    push hl
    ld a, [wBattleStatResultLo]
    ld l, a
    ld a, [wBattleStatResultHi]
    ld h, a
    push hl
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a, a
    add_a_to_hl
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    pop hl
    ld a, l
    ld [wBattleStatResultLo], a
    ld a, h
    ld [wBattleStatResultHi], a
    pop hl
    pop de
    pop bc
    pop af
    ret

; when bits 4-5 of the target's status byte (wD80D + 9 * slot) are set: stores GetBaseHP and GetBaseMP of the target in wBattleMaxHP and wBattleMaxMP and lowers the current values to the new maximum
; 2 call sites from 2 routines (e.g. Func_032_5E3B, DefeatTarget)
; reads: wBattleTarget, wBattleStatResultLo, wBattleStatResultHi
; writes: wD868, wD869, wD86A, wD86B
; points at: wD80D, wBattleMaxHP, wBattleHP, wBattleMaxMP, wBattleMP, wBattleATK, wBattleINT, wD8B7, ...
RecomputeTargetMaxHPAndMP::
Func_032_5C3F:: ; address name
    ld a, [wBattleTarget]
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    ret z
    and a, $20
    call nz, Func_032_5E1A
    ld a, $01
    ld [wD868], a
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_019_434D
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseHP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxHP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call Func_032_6803
    call CompareHLToBC
    jr c, Jump_032_5C95
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5C95::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseMP
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleMaxMP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call Func_032_6808
    call CompareHLToBC
    jr c, Jump_032_5CCA
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5CCA::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseATK
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleATK
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseINT
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleINT
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_019_4298
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_4199
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wD8B7
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_41D3
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_420D
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_4247
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_4281
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleTarget]
    ld hl, wD980
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    ld c, a
    farcall Func_03B_42BB
    ld a, [wBattleTarget]
    ld hl, wD8A7
    add_a_to_hl
    ld [hl], c
    ld a, [wBattleTarget]
    ld b, a
    and a, $03
    cp a, $03
    ret z
    ld a, b
    ld e, $31
    call Func_000_3F32
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld a, [wBattleTarget]
    ld de, wDA72
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
    ld [wD86A], a
    ld a, d
    ld [wD86B], a
    farcall Func_019_44B9
    ret

; 1 call site from 1 routine (e.g. RecomputeTargetMaxHPAndMP)
; reads: wBattleTarget, wC58A
; points at: wDAD4
Func_032_5E1A::
    ld a, [wBattleTarget]
    ld c, a

; 1 call site from 1 routine (e.g. Func_036_710F)
; reads: wC58A
; points at: wDAD4
Func_032_5E1E::
    ld a, [wC58A]
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
    ld hl, wDAD4
    add_a_to_hl
    ld [hl], $FF
    ret

; 1 call site from 1 routine (e.g. Func_0A0_5278_Table2_Case04)
; reads: wBattleTarget
; writes: wD80A, wD80B, wBattleTarget
; points at: wD812, wBattleStatus, wBattleSlotOut, wDA5B
Func_032_5E3B::
    xor a, a
    ld [wD80A], a
    ld [wD80B], a
    ld c, $00

Jump_032_5E44::
    push bc
    ld a, c
    ld [wBattleTarget], a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_032_5E79
    call RecomputeTargetMaxHPAndMP
    ld a, [wBattleTarget]
    ld hl, wD812
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    jr z, Jump_032_5E66
    ld a, [hl]
    and a, $3F
    ld [hl], a
    call Func_032_5BE8

Jump_032_5E66::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
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
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld [hl], $FF
    ld a, $03
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FF
    ld a, $03
    ld hl, wBattleStatus
    call AddAx9ToHL
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

; 1 call site from 1 routine (e.g. RunBattleResolveStep_Case0E)
; reads: wBattleSubStep
Func_032_5EAB::
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_5EAB_Case00
    dw Func_032_5EAB_Case01
    dw Func_032_5EAB_Case02
    dw Func_032_5EAB_Case03
    dw Func_032_5EAB_Case04
    dw Func_032_5EAB_Case05
    dw Func_032_5EAB_Case06
    dw Func_032_5EAB_Case06
    dw Func_032_5EAB_Case06
    dw Func_032_5EAB_Case09

; entry 0 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wBattleActor, hFFC6, wCFCF, wBattleTarget
; writes: wBattleSubStep2, wCFCE, wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep, wC982, wC983, ...
; points at: wBattleSubStep, wBattleStatus
Func_032_5EAB_Case00::
Jump_032_5EC3:: ; address name
    xor a, a
    ld [wBattleSubStep2], a
    xor a, a
    ld [wCFCE], a
    ld a, [wD8A6]
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
    ld hl, wBattleSubStep
    inc [hl]
    ret

Jump_032_5F0A::
    ld a, $03
    ld [wBattleSubStep], a
    ret

Jump_032_5F10::
    ld a, $04
    ld [wBattleSubStep], a
    ret

Jump_032_5F16::
    ld a, [wBattleActor]
    ld [wC982], a
    xor a, a
    ld [wC983], a

Jump_032_5F20::
    ld a, [wCFCF]
    bit 0, a
    jr z, Jump_032_5F05
    ld a, [wCFCF]
    and a, $FE
    ld [wCFCF], a
    ld a, $05
    ld [wBattleSubStep], a
    ret

Jump_032_5F35::
    ld a, $09
    ld [wBattleSubStep], a
    ret

Jump_032_5F3B::
    call Func_032_604A
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

Jump_032_5F4B::
    ld a, [wBattleActor]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a
    call Func_032_604A
    pop af
    ld [wBattleActor], a
    jr Jump_032_5F3B

Jump_032_5F63::
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jp c, Func_032_61D9
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    jp nz, Func_032_61D9
    push hl
    farcall Func_036_60D1
    pop hl
    ld a, e
    or a, a
    jp nz, Func_032_61D9
    set 0, [hl]
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, $20
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $08
    ld [wDAD3], a
    farcall Func_03A_5762
    ld a, $75
    ld [wCFCE], a
    jp Func_032_61D9

Jump_032_5FAE::
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jp c, Func_032_61D9
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    jp nz, Func_032_61D9
    push hl
    farcall Func_036_60EB
    pop hl
    ld a, e
    or a, a
    jp nz, Func_032_61D9
    set 6, [hl]
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, $20
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $08
    ld [wDAD3], a
    farcall Func_03A_5762
    ld a, $76
    ld [wCFCE], a
    jp Func_032_61D9

Jump_032_5FF8::
    ld a, [wBattleTarget]
    call CarryUnlessWDA63SlotEmpty
    jp c, Func_032_61D9
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 7, [hl]
    jp nz, Func_032_61D9
    push hl
    farcall Func_036_610D
    pop hl
    ld a, e
    or a, a
    jp nz, Func_032_61D9
    ld a, [hl]
    or a, $8C
    ld [hl], a
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, $20
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $08
    ld [wDAD3], a
    farcall Func_03A_5762
    call Func_032_6848
    ld a, $74
    jr c, Jump_032_6044
    dec a

Jump_032_6044::
    ld [wCFCE], a
    jp Func_032_61D9

; 2 call sites from 1 routine (e.g. Func_032_5EAB_Case00)
; reads: wBattleActor, wC5E7
; points at: wDA1C
Func_032_604A::
    call AdvanceRandom
    ld a, [wBattleActor]
    ld hl, wDA1C
    call AddDoubleAToHL_Bank32
    push hl
    ld a, [wC5E7]
    and a, $03
    ld hl, Data_032_6094
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [hl+], a
    ld c, a
    push hl
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld b, a
    ld a, c
    cp a, $00
    jr nz, Jump_032_6090
    ld a, [wC5E7]
    and a, $03
    add a, b

Jump_032_607C::
    ld b, a
    call CarryUnlessWDA63SlotEmpty
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

; entry 1 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
; reads: wCFCE
; writes: wBattleSubStep
; points at: wBattleSubStep, wBattleResolveStep
Func_032_5EAB_Case01::
Jump_032_6099:: ; address name
    ld a, [wCFCE]
    or a, a
    jr z, Func_032_5EAB_Case02
    ld d, a
    farcall Func_03A_7193
    ld hl, wBattleSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubStep
; points at: wBattleResolveStep
Func_032_5EAB_Case02::
Jump_032_60AB:: ; address name
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep2
Func_032_5EAB_Case03::
Jump_032_60B4:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_604A_Case00
    dw Func_032_604A_Case01
    dw Func_032_604A_Case02
    dw Func_032_61D9

; entry 0 of the `rst $00` table in Func_032_604A
; no direct call (reached through a table, a jump or a vector)
; writes: wDAD2, wDAD3
; points at: wBattleSubStep2
Func_032_604A_Case00::
Jump_032_60C0:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    call Func_032_6749
    ret c
    ld a, $20
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $08
    ld [wDAD3], a
    farcall Func_03A_5762
    ret

; entry 1 of the `rst $00` table in Func_032_604A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wBattleDamageLo, wD873, wD876, wD877, wC0A0, wD871
; writes: wD876, wD877, wCFCE, wC0A0, wD871, wBattleTarget, wBattleDamageLo, wD873
; points at: wBattleSubStep2, wBattleHP, wC0A0
Func_032_604A_Case01::
Jump_032_60DF:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    push hl
    deref_hl
    push hl
    call Func_032_6755
    inc hl
    ld a, l
    ld [wD876], a
    ld a, h
    ld [wD877], a
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
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wCFCE], a

Jump_032_6121::
    ld a, $35
    ld [wC0A0], a
    call Func_032_682D
    jr nc, Jump_032_612F
    ld hl, wC0A0
    inc [hl]

Jump_032_612F::
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    push hl
    ld a, [wD876]
    ld l, a
    ld a, [wD877]
    ld h, a
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    pop hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, [wD871]
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank32
    ret

; entry 2 of the `rst $00` table in Func_032_604A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wD871
; writes: wD871, wBattleTarget
Func_032_604A_Case02::
Jump_032_6174:: ; address name
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call Func_032_618A
    ld a, [wD871]
    ld [wBattleTarget], a
    ret

; 1 call site from 1 routine (e.g. Func_032_604A_Case02)
; reads: wCFCE
Func_032_618A::
    ld a, [wCFCE]
    rst $00
    dw Func_032_618A_Case00
    dw Func_032_618A_Case01
    dw Func_032_618A_Case02

; entry 0 of the `rst $00` table in Func_032_618A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wCFCE, wDA5B
Func_032_618A_Case00::
Jump_032_6194:: ; address name
    ld hl, wCFCE
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_618A
; no direct call (reached through a table, a jump or a vector)
; points at: wCFCE
Func_032_618A_Case01::
Jump_032_61A9:: ; address name
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_618A
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC0A0
; writes: wC0A0, wCFCE
; points at: wBattleSubStep2
Func_032_618A_Case02::
Jump_032_61B1:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, $90
    ld [wC0A0], a
    call Func_032_682D
    jr c, Jump_032_61C6
    ld a, $8D
    ld [wC0A0], a

Jump_032_61C6::
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    ld hl, wBattleSubStep2
    inc [hl]
    xor a, a
    ld [wCFCE], a
    ret

; 3 call sites from 3 routines (e.g. Func_032_6749, Func_032_61D9_Case03, Func_032_63C2_Table2_Case03)
; writes: wBattleSubStep2, wBattleSubStep
Func_032_61D9::
    xor a, a
    ld [wBattleSubStep2], a
    ld a, $01
    ld [wBattleSubStep], a
    ret

; entry 4 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep2
Func_032_5EAB_Case04::
Jump_032_61E3:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_61D9_Case00
    dw Func_032_61D9_Case01
    dw Func_032_61D9_Case02
    dw Func_032_61D9_Case03

; entry 0 of the `rst $00` table in Func_032_61D9
; no direct call (reached through a table, a jump or a vector)
; writes: wDAD2, wDAD3
; points at: wBattleSubStep2
Func_032_61D9_Case00::
Jump_032_61EF:: ; address name
    call Func_032_6749
    ret c
    ld a, $20
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $08
    ld [wDAD3], a
    farcall Func_03A_5762
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_032_61D9
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wD871
; writes: wCFCE, wD871, wBattleTarget
; points at: wBattleSubStep2, wBattleHP
Func_032_61D9_Case01::
Jump_032_620E:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    push hl
    deref_hl
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
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wCFCE], a
    jr Jump_032_625F

Jump_032_6245::
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld d, $38
    farcall Func_03A_7193
    ld a, [wD871]
    ld [wBattleTarget], a

Jump_032_625F::
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank32
    ret

; entry 2 of the `rst $00` table in Func_032_61D9
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wD871
; writes: wD871, wBattleTarget
Func_032_61D9_Case02::
Jump_032_6266:: ; address name
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call Func_032_627C
    ld a, [wD871]
    ld [wBattleTarget], a
    ret

; 1 call site from 1 routine (e.g. Func_032_61D9_Case02)
; reads: wCFCE
Func_032_627C::
    ld a, [wCFCE]
    rst $00
    dw Func_032_627C_Case00
    dw Func_032_627C_Case01
    dw Func_032_627C_Case02

; entry 0 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wCFCE, wDA5B
Func_032_627C_Case00::
Jump_032_6286:: ; address name
    ld hl, wCFCE
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; points at: wCFCE
Func_032_627C_Case01::
Jump_032_629B:: ; address name
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC0A0
; writes: wC0A0, wCFCE
; points at: wBattleSubStep2
Func_032_627C_Case02::
Jump_032_62A3:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, $90
    ld [wC0A0], a
    call Func_032_682D
    jr c, Jump_032_62B8
    ld a, $8D
    ld [wC0A0], a

Jump_032_62B8::
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    ld hl, wBattleSubStep2
    inc [hl]
    xor a, a
    ld [wCFCE], a
    ret

; entry 3 of the `rst $00` table in Func_032_61D9
; no direct call (reached through a table, a jump or a vector)
Func_032_61D9_Case03::
Jump_032_62CB:: ; address name
    call Func_032_61D9
    ret

; entry 5 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wC983, hFFC6, wBattleSubStep2
; writes: wC983, wBattleActor
Func_032_5EAB_Case05::
Jump_032_62CF:: ; address name
    ld a, [wD8A6]
    cp a, $D6
    jr nz, Jump_032_62F1
    ld a, [wC983]
    bit 0, a
    jr z, Jump_032_62F1
    bit 7, a
    jr nz, Jump_032_62F1
    set 7, a
    ld [wC983], a
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wBattleActor], a

Jump_032_62F1::
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_627C_Table2_Case00
    dw Func_032_627C_Table2_Case01
    dw Func_032_627C_Table2_Case02
    dw Func_032_627C_Table2_Case03

; entry 0 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wD8A6, wC983, wC982
; writes: wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep2, wC983, wCFCE
; points at: wBattleSubStep2
Func_032_627C_Table2_Case00::
Jump_032_62FD:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    jp c, Func_032_627C_Table2_Case03
    ret

; entry 1 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wC5E7, wBattleDamageLo, wD873, wBattleTarget, wD871
; writes: wBattleDamageLo, wD873, wCFCE, wD871, wBattleTarget
; points at: wBattleSubStep2, wBattleHP
Func_032_627C_Table2_Case01::
Jump_032_630B:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank32
    call AdvanceRandom
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_032_6366
    ld a, [wBattleActor]
    call Func_032_6803
    push hl
    ld a, $64
    call DivideHLByA
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
    ld [wBattleDamageLo], a
    ld a, b
    ld [wD873], a
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld d, $38
    farcall Func_03A_7193
    ld a, [wD871]
    ld [wBattleTarget], a
    jr Jump_032_637D

Jump_032_6366::
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a

Jump_032_637D::
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
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
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wCFCE], a

Jump_032_63AB::
    ret

; entry 2 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wD871
; writes: wD871, wBattleTarget
Func_032_627C_Table2_Case02::
Jump_032_63AC:: ; address name
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call Func_032_63C2
    ld a, [wD871]
    ld [wBattleTarget], a
    ret

; 1 call site from 1 routine (e.g. Func_032_627C_Table2_Case02)
; reads: wCFCE
Func_032_63C2::
    ld a, [wCFCE]
    rst $00
    dw Func_032_63C2_Case00
    dw Func_032_63C2_Case01
    dw Func_032_63C2_Case02

; entry 0 of the `rst $00` table in Func_032_63C2
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wCFCE, wDA5B
Func_032_63C2_Case00::
Jump_032_63CC:: ; address name
    ld hl, wCFCE
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_63C2
; no direct call (reached through a table, a jump or a vector)
; points at: wCFCE
Func_032_63C2_Case01::
Jump_032_63E1:: ; address name
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_63C2
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wD8A6, wC983, wC982
; writes: wCFCE, wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep2, wC983
Func_032_63C2_Case02::
Jump_032_63E9:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, [wD8A6]
    cp a, $7B
    ld d, $8C
    jr z, Jump_032_6401
    ld d, $90
    call Func_032_682D
    jr c, Jump_032_6401
    ld d, $8D

Jump_032_6401::
    farcall Func_03A_7193
    xor a, a
    ld [wCFCE], a

; entry 3 of the `rst $00` table in Func_032_627C
; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6, wC983, wC982
; writes: wBattleActor, wBattleSubPhase, wBattleResolveStep, wBattleSubStep2, wC983, wCFCE
Func_032_627C_Table2_Case03::
Jump_032_640B:: ; address name
    ld a, [wD8A6]
    cp a, $D6
    jr nz, Jump_032_642E
    ld a, [wC983]
    bit 0, a
    jr z, Jump_032_6421
    ld a, [wC982]
    ld [wBattleActor], a
    jr Jump_032_642E

Jump_032_6421::
    inc a
    ld [wC983], a
    xor a, a
    ld [wBattleSubStep2], a
    xor a, a
    ld [wCFCE], a
    ret

Jump_032_642E::
    ld a, $06
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep2], a
    ret

; entry 6 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
Func_032_5EAB_Case06::
Jump_032_643C:: ; address name
    ret

; entry 9 of the `rst $00` table in Func_032_5EAB
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleSubStep2
Func_032_5EAB_Case09::
Jump_032_643D:: ; address name
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_63C2_Table2_Case00
    dw Func_032_63C2_Table2_Case01
    dw Func_032_63C2_Table2_Case02
    dw Func_032_63C2_Table2_Case03

; entry 0 of the `rst $00` table in Func_032_63C2
; no direct call (reached through a table, a jump or a vector)
; writes: wDAD2, wDAD3
; points at: wBattleSubStep2
Func_032_63C2_Table2_Case00::
Jump_032_6449:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    call Func_032_6749
    ret c
    ld a, $20
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $08
    ld [wDAD3], a
    farcall Func_03A_5762
    ret

; entry 1 of the `rst $00` table in Func_032_63C2
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleDamageLo, wD873, wBattleTarget, wD876, wD877, wC0A0, wD871
; writes: wD876, wD877, wCFCE, wC0A0, wD871, wBattleTarget, wBattleDamageLo, wD873
; points at: wBattleSubStep2, wBattleHP, wC0A0
Func_032_63C2_Table2_Case01::
Jump_032_6468:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    push hl
    deref_hl
    push hl
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    srl h
    rr l
    srl h
    rr l
    ld a, l
    ld [wD876], a
    ld a, h
    ld [wD877], a
    ld a, l
    or a, h
    jr nz, Jump_032_64A5
    ld hl, $0001
    ld a, l
    ld [wD876], a
    ld a, h
    ld [wD877], a

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
    ld hl, wBattleSubStep2
    dec [hl]
    xor a, a
    ld [wCFCE], a

Jump_032_64C5::
    ld a, $35
    ld [wC0A0], a
    call Func_032_682D
    jr nc, Jump_032_64D3
    ld hl, wC0A0
    inc [hl]

Jump_032_64D3::
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    push hl
    ld a, [wD876]
    ld l, a
    ld a, [wD877]
    ld h, a
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    pop hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ld a, [wD871]
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    call SetBit0OfWD095Indexed_Bank32
    ret

; entry 2 of the `rst $00` table in Func_032_63C2
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wD871
; writes: wD871, wBattleTarget
Func_032_63C2_Table2_Case02::
Jump_032_6518:: ; address name
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call Func_032_652E
    ld a, [wD871]
    ld [wBattleTarget], a
    ret

; 1 call site from 1 routine (e.g. Func_032_63C2_Table2_Case02)
; reads: wCFCE
Func_032_652E::
    ld a, [wCFCE]
    rst $00
    dw Func_032_652E_Case00
    dw Func_032_652E_Case01
    dw Func_032_652E_Case02

; entry 0 of the `rst $00` table in Func_032_652E
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wCFCE, wDA5B
Func_032_652E_Case00::
Jump_032_6538:: ; address name
    ld hl, wCFCE
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_652E
; no direct call (reached through a table, a jump or a vector)
; points at: wCFCE
Func_032_652E_Case01::
Jump_032_654D:: ; address name
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_652E
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC0A0
; writes: wC0A0, wCFCE
; points at: wBattleSubStep2
Func_032_652E_Case02::
Jump_032_6555:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, $90
    ld [wC0A0], a
    call Func_032_682D
    jr c, Jump_032_656A
    ld a, $8D
    ld [wC0A0], a

Jump_032_656A::
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    ld hl, wBattleSubStep2
    inc [hl]
    xor a, a
    ld [wCFCE], a
    ret

; entry 3 of the `rst $00` table in Func_032_63C2
; no direct call (reached through a table, a jump or a vector)
Func_032_63C2_Table2_Case03::
Jump_032_657D:: ; address name
    call Func_032_61D9
    ret

; 1 call site from 1 routine (e.g. Func_036_7571)
; reads: wBattleTarget, wBattleStatResultLo, wBattleStatResultHi
; points at: wBattleStatus, wBattleAGL, wBattleDEF
Func_032_6581:: ; heuristic: follows a terminator; C0
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $D0
    call nz, Func_032_660F
    xor a, a
    ld [hl+], a
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
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
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseAGL
    ld a, [wBattleTarget]
    ld hl, wBattleAGL
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    call CompareHLToBC
    pop hl
    jr nc, Jump_032_65DF
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a

Jump_032_65DF::
    ld a, [wBattleTarget]
    ld c, a
    farcall GetBaseDEF
    ld a, [wBattleTarget]
    ld hl, wBattleDEF
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    ld a, [wBattleStatResultLo]
    ld c, a
    ld a, [wBattleStatResultHi]
    ld b, a
    call CompareHLToBC
    pop hl
    ret nc
    ld a, [wBattleStatResultLo]
    ld [hl+], a
    ld a, [wBattleStatResultHi]
    ld [hl], a
    ret

; 3 call sites from 2 routines (e.g. Func_032_6581, Func_032_6622)
; reads: wBattleTarget
; points at: wDA5B
Func_032_660F::
    push hl
    push bc
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    pop bc
    pop hl
    ret
    db $C9

; 1 call site from 1 routine (e.g. Func_036_7599)
; reads: wBattleTarget
; points at: wBattleStatus
Func_032_6622::
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $90
    call nz, Func_032_660F
    ld a, [hl]
    and a, $63
    ld [hl], a
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
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

; 1 call site from 1 routine (e.g. Func_03A_69AA_Case05)
; reads: wBattleSubStep
Func_032_6662::
    ld a, [wBattleSubStep]
    rst $00
    dw Func_032_6662_Case00
    dw Func_032_6662_Case01
    dw Func_032_6662_Case02

; entry 0 of the `rst $00` table in Func_032_6662
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep
Func_032_6662_Case00::
Jump_032_666C:: ; address name
    ld hl, wBattleSubStep
    inc [hl]
    farcall Func_03A_4001
    farcall Func_03A_5762
    ret

; entry 1 of the `rst $00` table in Func_032_6662
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleDamageLo, wD873, wBattleActor
; writes: wBattleSubStep2, wBattleTarget, wBattleActor, wBattleSubStep
; points at: wBattleHP, wBattleSubStep, wBattleResolveStep
Func_032_6662_Case01::
Jump_032_667D:: ; address name
    ld a, [wBattleTarget]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wD873]
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
    ld hl, wBattleSubStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep2], a
    jr Jump_032_66B5

Jump_032_66AD::
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]

Jump_032_66B5::
    ld a, [wBattleTarget]
    call SetBit0OfWD095Indexed_Bank32
    call Func_032_682D
    ld d, $35
    jr c, Jump_032_66C4
    ld d, $36

Jump_032_66C4::
    farcall Func_03A_7193
    ld a, [wBattleActor]
    ld l, a
    ld a, [wBattleTarget]
    ld h, a
    ld a, l
    ld [wBattleTarget], a
    ld a, h
    ld [wBattleActor], a
    ret

; entry 2 of the `rst $00` table in Func_032_6662
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleActor, wD871
; writes: wD871, wBattleTarget
Func_032_6662_Case02::
Jump_032_66DB:: ; address name
    ld a, [wBattleTarget]
    ld [wD871], a
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call Func_032_66F1
    ld a, [wD871]
    ld [wBattleTarget], a
    ret

; 1 call site from 1 routine (e.g. Func_032_6662_Case02)
; reads: wBattleSubStep2
Func_032_66F1::
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_66F1_Case00
    dw Func_032_66F1_Case01
    dw Func_032_66F1_Case02

; entry 0 of the `rst $00` table in Func_032_66F1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep2, wDA5B
Func_032_66F1_Case00::
Jump_032_66FB:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_66F1
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep2
Func_032_66F1_Case01::
Jump_032_6710:: ; address name
    call Func_032_5AB3
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_66F1
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wC0A0
; writes: wC0A0, wBattleSubStep2, wBattleSubStep, wDABA
; points at: wBattleResolveStep
Func_032_66F1_Case02::
Jump_032_6718:: ; address name
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld a, $8A
    ld [wC0A0], a
    call Func_032_682D
    jr c, Jump_032_672D
    ld a, $8B
    ld [wC0A0], a

Jump_032_672D::
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    xor a, a
    ld [wBattleSubStep2], a
    xor a, a
    ld [wBattleSubStep], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $81
    ld [wDABA], a
    ret

; 3 call sites from 3 routines (e.g. Func_032_604A_Case00, Func_032_61D9_Case00, Func_032_63C2_Table2_Case00)
; reads: wBattleActor
Func_032_6749::
    ld a, [wBattleActor]
    call CarryUnlessWDA63SlotEmpty
    ret nc
    call Func_032_61D9
    scf
    ret

; 1 call site from 1 routine (e.g. Func_032_604A_Case01)
Func_032_6755::
    push de
    ld b, h
    ld c, l
    ld a, $08
    call Multiply8By16
    ld a, $0A
    call Divide24ByA
    pop de
    ret

; 1 call site from 1 routine (e.g. Func_03B_42F4_Case09)
; reads: wBattleSubStep2
Func_032_6764::
    ld a, [wBattleSubStep2]
    rst $00
    dw Func_032_6764_Case00
    dw Func_032_6764_Case01
    dw Func_032_6764_Case02

; entry 0 of the `rst $00` table in Func_032_6764
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; points at: wBattleSubStep2, wDA5B
Func_032_6764_Case00::
Jump_032_676E:: ; address name
    ld hl, wBattleSubStep2
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call DefeatTarget
    ret

; entry 1 of the `rst $00` table in Func_032_6764
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleSubStep2
Func_032_6764_Case01::
Jump_032_6785:: ; address name
    call Func_032_5AB3
    ld hl, wBattleSubStep2
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_032_6764
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wBattleSubStep2
; points at: wBattleResolveStep
Func_032_6764_Case02::
Jump_032_678D:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep2], a
    ld a, [wBattleTarget]
    call SetBit2OfWD095Indexed_Bank32
    ld d, $8B
    call Func_032_6848
    jr nc, Jump_032_67A3
    dec d

Jump_032_67A3::
    farcall Func_03A_7193
    ret

; 1 call site from 1 routine (e.g. RunBattleResolveStep_Case0A)
; reads: wBattleTarget, wBattleDamageLo, wD873
; writes: wBattleDamageLo, wD873
; points at: wD813
Func_032_67AA::
    ld a, [wBattleTarget]
    ld hl, wD813
    call AddAx9ToHL
    ld a, [hl]
    push af
    and a, $F0
    ld [hl], a
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wD873]
    ld h, a
    pop af
    bit 0, a
    jr z, Jump_032_67CF
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
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
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret

Jump_032_67E2::
    bit 2, a
    ret z
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wD873], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E

; 1 call site from 1 routine (e.g. Func_032_4D5A)
; points at: wBattleMaxMP
Func_032_67FE::
    ld hl, wBattleMaxMP
    jr Jump_032_681C

; 4 call sites from 4 routines (e.g. RecomputeTargetMaxHPAndMP, Func_032_4ADC_Table2_Case02, Func_032_4C9C, Func_032_627C_Table2_Case01)
; points at: wBattleHP
Func_032_6803::
    ld hl, wBattleHP
    jr Jump_032_681C

; 2 call sites from 2 routines (e.g. RecomputeTargetMaxHPAndMP, Func_032_51F9)
; points at: wBattleMP
Func_032_6808::
    ld hl, wBattleMP
    jr Jump_032_681C
    db $21, $1F, $D9, $18, $0A

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 4 banks)
; 6 call sites from 5 routines (e.g. Func_032_51F9, Func_032_529E, Func_032_5303, Func_032_4EE4_Case02, ...)
; points at: wDA53
ReadWDA53Indexed_Bank32::
Func_032_6812:: ; address name
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    ret

Jump_032_681C::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 11 banks)
; 19 call sites from 10 routines (e.g. RecomputeTargetMaxHPAndMP, Func_032_5820_Case00, Func_032_4ADC_Case08, Func_032_6662_Case01, ...)
AddDoubleAToHL_Bank32::
Func_032_6826:: ; address name
    add a, a
    add_a_to_hl
    ret

; 9 call sites from 9 routines (e.g. Func_032_6662_Case01, Func_032_5A3A_Case02, Func_032_66F1_Case02, Func_032_604A_Case01, ...)
; reads: wC58A, wC57F, wBattleActor
Func_032_682D::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_032_6842
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_032_6842
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

Jump_032_6842::
    ld a, [wBattleActor]
    cp a, $04
    ret

; 3 call sites from 3 routines (e.g. Func_032_6764_Case02, Func_032_5EAB_Case00, Func_032_5A3A_Case02)
; reads: wC58A, wC57F, wBattleTarget
Func_032_6848::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_032_685D
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_032_685D
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

Jump_032_685D::
    ld a, [wBattleTarget]
    cp a, $04
    ret
    db $7A, $21, $78, $68, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 7 call sites from 7 routines (e.g. Func_032_6662_Case01, Func_032_4C9C, ApplyDamageToTarget, Func_032_604A_Case01, ...)
; points at: wD095
SetBit0OfWD095Indexed_Bank32::
Func_032_687F:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 3 call sites from 3 routines (e.g. Func_032_5397, Func_032_4C9C, ApplyDamageToTarget)
; points at: wD095
SetBit1OfWD095Indexed_Bank32::
Func_032_688C:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 16 call sites from 14 routines (e.g. DefeatTarget, Func_032_6764_Case02, Func_032_4C9C, Func_032_4E51, ...)
; points at: wD095
SetBit2OfWD095Indexed_Bank32::
Func_032_6899:: ; address name
    push hl
    ld hl, wD095
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 7 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank32:: ; heuristic: follows a terminator; C0
Func_032_68A6:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
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
    ld hl, wSlotPersonalityMid
    add_a_to_hl
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
    ld hl, wSlotPersonalityLo
    add_a_to_hl
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

; 2 call sites from 1 routine (e.g. Func_032_514C)
; points at: wD80F
Func_032_68FD::
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
    call AddAx9ToHL
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

; 2 call sites from 1 routine (e.g. Func_032_4F0A)
; points at: wD80F
Func_032_691C::
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_032_692B
    ld a, [hl]
    and a, $0C

Jump_032_692B::
    pop hl
    ret
    ds $111C, $00

; entry 7 of the `rst $00` table in Func_032_4EE4
; no direct call (reached through a table, a jump or a vector)
Func_032_4EE4_Case07::
Jump_032_7A49:: ; address name
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
