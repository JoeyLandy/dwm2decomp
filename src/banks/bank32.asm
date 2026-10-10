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
; reads: wCFCB
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
    ld bc, rIE
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

; 1 call site from 1 routine (e.g. Func_03A_6157)
; reads: wCFCB
Func_032_4ADC::
    ld a, [wCFCB]
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
    ld a, [wCFCC]
    rst $00
    dw Jump_032_4B04
    dw Jump_032_4B62
    dw Jump_032_4BE1
    dw Jump_032_4C0A
    dw Jump_032_4C27
    dw Jump_032_4C30

Jump_032_4B04::
    call Func_032_4E29
    ld a, [wDABD]
    or a, a
    jr z, Jump_032_4B14
    ld a, $04
    ld [wCFCC], a
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
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    jr Jump_032_4B61

Jump_032_4B38::
    ld a, $05
    ld [wCFCC], a
    jr Jump_032_4B61

Jump_032_4B3F::
    ld [wD8A4], a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_032_4B5D
    ld a, [wD8A4]
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr z, Jump_032_4B5D
    ld hl, wCFCC
    inc [hl]
    jr Jump_032_4B62

Jump_032_4B5D::
    ld hl, wD89E
    inc [hl]

Jump_032_4B61::
    ret

Jump_032_4B62::
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    push af
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    pop af
    ld [hl-], a
    ld [hl], $CD
    ld a, $03
    ld [wCFCC], a
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
    ld a, [wD8A4]
    push af
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    pop af
    ld [hl-], a
    pop af
    ld [hl], a
    ld a, $04
    ld [wCFCC], a
    jr Jump_032_4BE0

Jump_032_4BC6::
    call Func_032_4C3E
    jr nc, Jump_032_4BD1
    ld hl, wCFCC
    inc [hl]
    jr Jump_032_4BE1

Jump_032_4BD1::
    ld a, [wCFCC]
    cp a, $04
    jr z, Jump_032_4BE0

Jump_032_4BD8::
    xor a, a
    ld [wCFCC], a
    ld hl, wD89E
    inc [hl]

Jump_032_4BE0::
    ret

Jump_032_4BE1::
    ld hl, wCFCC
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    bit 5, [hl]
    jr z, Jump_032_4C0A
    call Func_032_4C9C
    jr nc, Jump_032_4C0A
    ld a, [wD8A4]
    call Func_032_6803
    ld a, h
    or a, l
    ret nz
    ld a, $09
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_4C0A::
    ld hl, wCFCC
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    bit 4, [hl]
    jr z, Jump_032_4C27
    call Func_032_4D99
    ld d, $14
    farcall Func_03A_6EE5
    ret

Jump_032_4C27::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_4C30::
    ld a, $09
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ret

; 1 call site from 1 routine (e.g. Func_032_4ADC)
; reads: wD8A4
; points at: wD80C
Func_032_4C3E::
    ld a, [wD8A4]
    ld hl, wD80C
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

; 1 call site from 1 routine (e.g. Func_032_4ADC)
; reads: wC5E7, wC5E8, wD8A4, wD872, wD873
; writes: wCFCC
; points at: wD80C, wD89E
Func_032_4C9C::
    call Func_000_3ED4
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
    ld [wCFCC], a
    jr Jump_032_4D2A

Jump_032_4CCB::
    call Func_032_4D2C
    jr nc, Jump_032_4CD4
    xor a, a
    ld [de], a
    dec de
    ld [de], a

Jump_032_4CD4::
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_032_4CB7
    ld a, [wD8A4]
    call SetBit0OfWD095Indexed_Bank32
    ld d, $10
    call Func_032_4D23
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    call SetBit1OfWD095Indexed_Bank32
    ld d, $11
    call Func_032_4D23
    jr Jump_032_4D2A

Jump_032_4D0B::
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    set 4, [hl]
    ld a, [wD8A4]
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
; reads: wD8A4
; writes: wD872, wD873
; points at: wD8BF
Func_032_4D2C::
    ld a, [wD8A4]
    ld hl, wD8BF
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
    ld [wD872], a
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
; reads: wD8A4
; writes: wD872, wD873
; points at: wD8DF
Func_032_4D5A::
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    ld hl, wD8DF
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
    ld [wD872], a
    ld a, b
    ld [wD873], a
    ret

; 1 call site from 1 routine (e.g. Func_032_4C9C)
; reads: wD8A4
; points at: wD80F
Func_032_4D8D::
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld [hl], $00
    ret

; 1 call site from 1 routine (e.g. Func_032_4ADC)
; reads: wD8A4, wC5E7, wC58A, wC5E8, wCFC5
; writes: wD8A6, wD8A5
; points at: wD80F, wDA1C, wDA1D
Func_032_4D99::
    call Func_000_3ED4
    ld a, [wD8A4]
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
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld [hl], b
    farcall Func_039_4001
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    call Func_032_57FD
    ld [wD8A5], a
    ret

Data_032_4E1C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $C2, $C3, $C5

Data_032_4E20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C6

; 1 call site from 1 routine (e.g. Func_032_4ADC)
; reads: wDABD
; writes: wDAD2, wDABE, wD802, wCFCC, wDABA, wDABF, wDAD1, wC970
Func_032_4E29::
    xor a, a
    ld [wDAD2], a
    xor a, a
    ld [wDABE], a
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wCFCC], a
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
; reads: wC5E7, wD8A4, wD8A5, wD871
; writes: wD871, wD8A5
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
    ld a, [wD8A4]
    call SetBit2OfWD095Indexed_Bank32
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a

Jump_032_4ECA::
    add_a_to_hl
    ld [hl], $BF
    jr Jump_032_4EDB

Jump_032_4ED3::
    ld d, $82
    farcall Func_03A_7193

Jump_032_4EDB::
    ld a, [wD871]
    ld [wD8A5], a
    scf
    ccf
    ret

; 1 call site from 1 routine (e.g. Func_032_4C3E)
; reads: wD8A4
; points at: wD80F
Func_032_4EE4::
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    ld [hl], a
    ret

Jump_032_4EF2::
    ld a, [wCFCC]
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

Jump_032_4F53::
    farcall Func_0A3_4960
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_032_4F00
    call Func_032_5804
    call Func_032_535F
    jp nc, Jump_032_4FFB
    call Func_032_51F9
    jr c, Jump_032_4F9C
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_032_4F85
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr z, Jump_032_4FFB
    ld a, [wD8A4]
    ld hl, wDAE0
    call Func_032_57FD
    or a, a
    jr nz, Jump_032_4FFB
    ld a, [wCFF3]
    bit 2, a
    jr nz, Jump_032_4FFB
    ld a, [wD8A4]
    call ReadWDA53Indexed_Bank32
    cp a, $03
    jr c, Jump_032_4FFB

Jump_032_4FC8::
    ld a, [wD8A6]
    cp a, $6E
    jr z, Jump_032_4FFB
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $10
    jr nz, Jump_032_4FFB
    farcall Func_030_5440
    call Func_032_5804
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    inc hl
    ld [hl], $FF
    call Func_032_51F9
    jr nc, Jump_032_4F85

Jump_032_4FFB::
    ld hl, wCFCC
    inc [hl]
    ret

Jump_032_5000::
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_032_5073
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld [hl], $00
    inc hl
    ld [hl], $FF
    call Func_032_5804

Jump_032_5073::
    ld hl, wCFCC
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

Jump_032_50B7::
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    call Func_032_57FD
    cp a, $FF
    jr z, Jump_032_50F6
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    bit 7, [hl]
    jr nz, Jump_032_50DD
    ld a, [wCFF2]
    and a, $0F
    cp a, $01
    jr z, Jump_032_50FC

Jump_032_50DD::
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    call Func_032_57FD
    ld [wD8A5], a
    ld hl, wCFCC
    inc [hl]
    ret

Jump_032_510E::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ld a, [wD8A6]
    call Func_000_3F47
    ret nz
    ld d, $02
    farcall Func_03A_7508
    ld a, [wSkillRecord]
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
    ld hl, wCFCC
    dec [hl]
    ld hl, wCFCC
    dec [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4, wSkillRecord, hFFC6, hFFC7
; writes: hFFC7, wSkillId, wCFED, hFFC8, wD8A4
; points at: wDA2C, wDA5B
Func_032_514C:: ; heuristic: follows a terminator; C0
    xor a, a
    ldh [hFFC7], a
    ld a, [wD8A4]
    add a, a
    ld hl, wDA2C
    call Func_032_57FD
    ld [wSkillId], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wSkillRecord]
    ldh [hFFC8], a
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    add a, a
    ld hl, wDA2C
    call Func_032_57FD
    ld [wSkillId], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wSkillRecord]
    ldh [hFFC8], a
    ld a, [wD8A4]
    call Func_032_68FD
    jr c, Jump_032_51C3
    ld a, [wD8A4]
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
    ld [wD8A4], a
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

; 6 call sites from 3 routines (e.g. Func_032_5820, Func_032_4F0A, Func_032_514C)
; reads: wD8A6, wD8A4, hFFC8, wCFF3, wSkillRecord
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
    ld a, [wSkillRecord]
    ldh [hFFC8], a

Jump_032_520B::
    ld a, [wD8A4]
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
    ld a, [wD8A4]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr c, Jump_032_5294
    ld a, [wCFF3]
    bit 3, a
    jr z, Jump_032_5294
    ld a, [wD8A4]
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
; reads: wD8A4, wCFF2
; points at: wD80D, wD80A, wD80B, wD80E
Func_032_529E::
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_032_52F9
    ld hl, wD80A
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_032_52B8
    ld hl, wD80B

Jump_032_52B8::
    bit 3, [hl]
    jp nz, Jump_032_52FD
    ld a, [wD8A4]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr c, Jump_032_5301
    ld a, [wCFF2]
    cp a, $12
    jr nz, Jump_032_5301
    ld a, [wD8A4]
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
; reads: wD8A4
; points at: wD80D, wD80E
Func_032_5303::
    ld a, [wD8A4]
    ld hl, wD80D
    call AddAx9ToHL
    bit 7, [hl]
    jr nz, Jump_032_5344
    ld a, [wD8A4]
    call ReadWDA53Indexed_Bank32
    cp a, $02
    jr c, Jump_032_5348
    ld a, [wD8A4]
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
; reads: wD8A4
; points at: wD80D
Func_032_534A::
    ld a, [wD8A4]
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

; 3 call sites from 3 routines (e.g. Func_032_5386, Func_032_55EE, Func_032_4F0A)
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

; 8 call sites from 4 routines (e.g. Func_032_5820, Func_032_55EE, Func_032_4F0A, Func_032_553B)
; reads: wD8A6, wD8A4, hFFC6, wSkillRecord
; writes: wSkillId, wCFED, wD8A4, wSkillRecord, wD866, wD867
; points at: wDA2C, wD8DF
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
; reads: wD8A4, wSkillRecord
; writes: wD866, wD867
; points at: wD8DF
Func_032_5397::
    ld a, [wD8A4]
    ld hl, wD8DF
    add a, a
    add_a_to_hl
    ld a, [wSkillRecord]
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
    ld a, [wD8A4]
    call SetBit1OfWD095Indexed_Bank32
    ret

Jump_032_53C8::
    cp a, $D6
    jr z, Jump_032_541A
    cp a, $D9
    jr z, Jump_032_541A
    ld a, [wD8A4]
    ld hl, wDA2C
    add a, a
    call Func_032_57FD
    ld [wSkillId], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    call Func_032_5397
    ld a, [wD8A4]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    ld hl, wDA2C
    add a, a
    call Func_032_57FD
    ld [wSkillId], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    call Func_032_5397
    pop af
    ld [wD8A4], a
    call Func_032_5804
    ret

Jump_032_541A::
    ld a, $FF
    ld [wSkillRecord], a
    call Func_032_5397
    ld a, [wD8A4]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_032_5397
    pop af
    ld [wD8A4], a
    call Func_032_5804
    ret

; 7 call sites from 3 routines (e.g. Func_032_543C, Func_032_4F0A, Func_032_553B)
; writes: wCFCA, wCFCB, wCFCC
Func_032_543C::
    ld a, $07
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_544A::
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A4]
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

Jump_032_5474::
    ld hl, wCFCB
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
    ld a, [wD8A4]
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

Jump_032_54AF::
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl]
    and a, $C0
    cp a, $40
    jr nz, Jump_032_54F5
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    bit 6, [hl]
    jr nz, Jump_032_54E0
    ld a, [wD8A4]
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
    ld hl, wCFCA
    inc [hl]
    ld a, $06
    ld [wCFCB], a
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
    ld a, [wD8A4]
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

Jump_032_5519::
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    call Func_032_553B
    ret z
    ld a, $80
    ld [wDAD2], a
    farcall Func_03A_4001
    ret

; 1 call site from 1 routine (e.g. Func_032_543C)
; reads: wD8A6
Func_032_553B::
    ld a, [wD8A6]
    cp a, $CD
    ret

Jump_032_5541::
    ld a, [wCFCC]
    rst $00
    dw Jump_032_554D
    dw Jump_032_55C2
    dw Jump_032_55CF
    dw Jump_032_55E7

Jump_032_554D::
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    inc hl
    ld a, [hl]
    ld [wD8A5], a
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
    ld a, [wD8A5]
    ld hl, wD814
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_032_55B2
    jr Jump_032_55A9

Jump_032_5585::
    ld a, [wD8A5]
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
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_55B2::
    res 4, [hl]
    ld hl, wDAAC
    ld a, [hl+]
    ld [hl-], a
    ld a, [wD8A6]
    ld [hl], a
    ld hl, wCFCC
    inc [hl]
    ret

Jump_032_55C2::
    ld hl, wCFCC
    inc [hl]
    ld d, $B0
    farcall Func_03A_7193
    ret

Jump_032_55CF::
    ld hl, wCFCC
    inc [hl]
    ld a, [wDAAD]
    cp a, $FF
    ret z
    ld d, $92
    farcall Func_03A_7193
    ld a, $FF
    ld [wDAAD], a
    ret

Jump_032_55E7::
    call Func_032_5386
    call Func_032_543C
    ret

; 1 call site from 1 routine (e.g. Func_032_5820)
; reads: wC58A, wD043, wDABA, wD044, wD8A6, wD045, wD8A4, wC57F, ...
; writes: wD092, wStringIndex, wStringCategory, wCFC8, wCFC9, wCFCA, wCFCB, wDataBank, ...
; points at: wCFCB, wD057, wD058
Func_032_55EE::
    ld hl, wCFCB
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
    ld a, [wD8A4]
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
    ld a, [wD8A4]
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
    ld [wCFC8], a
    ld a, $09
    ld [wCFC9], a
    xor a, a
    ld [wCFCA], a
    ld [wCFCB], a
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

Jump_032_5770::
    ld a, [wD8A4]
    ld hl, wD854
    call AddDoubleAToHL_Bank32
    bit 4, [hl]
    call z, Func_032_5386
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_578B::
    ld a, [wCFCC]
    rst $00
    dw Jump_032_5793
    dw Jump_032_57BA

Jump_032_5793::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD8A4]
    ld [wD8A5], a
    call Func_032_5B12
    call Func_032_5AB3
    call Func_032_57E4
    ld d, $8A
    cp a, $04
    jr c, Jump_032_57AF
    ld d, $8D

Jump_032_57AF::
    farcall Func_03A_7193
    ld hl, wCFCC
    inc [hl]
    ret

Jump_032_57BA::
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
    ld hl, wCFC8
    inc [hl]
    xor a, a
    ld [wCFC9], a
    jr Jump_032_57E3

Jump_032_57DA::
    xor a, a
    ld [wCFCC], a
    ld a, $07
    ld [wCFCB], a

Jump_032_57E3::
    ret

; 2 call sites from 1 routine (e.g. Func_032_55EE)
; reads: wD8A4
Func_032_57E4::
    ld a, [wD8A4]
    ret

; 1 call site from 1 routine (e.g. Func_032_55EE)
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

; 18 call sites from 10 routines (e.g. Func_032_5397, Func_032_5804, Func_032_543C, Func_032_4D99, ...)
Func_032_57FD::
    add_a_to_hl
    ld a, [hl]
    ret

; 7 call sites from 3 routines (e.g. Func_032_5397, Func_032_4F0A, Func_032_514C)
; reads: wD8A4
; writes: wD8A6, wSkillId, wCFED
; points at: wDA1C
Func_032_5804::
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    ld [wSkillId], a
    ld a, $00
    ld [wCFED], a
    farcall LoadSkillRecord
    ret

; 1 call site from 1 routine (e.g. Func_03A_68C9)
; reads: wCFCB
Func_032_5820::
    ld a, [wCFCB]
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
    ld hl, wCFCB
    inc [hl]
    ld hl, wDAC9
    ld a, [wD8A4]
    ld [hl+], a
    ld a, [wD8A5]
    ld [hl+], a
    ld a, [wDABA]
    ld [hl+], a
    ld a, [wD8A4]
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
    ld a, [wD8A5]
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
    ld a, [wD8A5]
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
    ld a, [wD8A5]
    ld [wD8A4], a
    ld a, [wD8A4]
    ld hl, wDA1C
    call AddDoubleAToHL_Bank32
    ld a, [wD8A6]
    ld [hl+], a
    ld [hl], $FF
    ld a, [wD8A4]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $02
    farcall Func_039_4001
    ld a, [wD8A4]
    ld hl, wDA1D
    call AddDoubleAToHL_Bank32
    ld a, [hl]
    ld [wD8A5], a
    ret

Jump_032_58B3::
    ld hl, wCFCB
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
    ld [wCFCB], a

Jump_032_58D9::
    ret

Jump_032_58DA::
    ld a, [wDAB2]
    bit 0, a
    jr nz, Jump_032_58F2
    farcall Func_03A_6D76
    ld a, $80
    ld [wDAD3], a
    farcall Func_03A_5762

Jump_032_58F2::
    ld hl, wCFCB
    inc [hl]
    ret

Jump_032_58F7::
    ld a, [wSoundChannelSlots]
    ld hl, wDC20
    and a, [hl]
    cp a, $FF
    ret nz
    ld a, $80
    ld [wDAD2], a
    farcall Func_03A_4001
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_5915::
    ld a, [wCFCC]
    rst $00
    dw Jump_032_5921
    dw Jump_032_5993
    dw Jump_032_59A0
    dw Jump_032_59B8

Jump_032_5921::
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    call Func_032_57FD
    ld [wD8A6], a
    inc hl
    ld a, [hl]
    ld [wD8A5], a
    ld a, [wCFF6]
    bit 7, a
    jr z, Jump_032_5976
    ld a, [wCFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_032_5952
    ld a, [wD8A5]
    ld hl, wD814
    call AddAx9ToHL
    bit 4, [hl]
    jr nz, Jump_032_5983
    jr Jump_032_5976

Jump_032_5952::
    ld a, [wD8A5]
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
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_5983::
    res 4, [hl]
    ld hl, wDAAC
    ld a, [hl+]
    ld [hl-], a
    ld a, [wD8A6]
    ld [hl], a
    ld hl, wCFCC
    inc [hl]
    ret

Jump_032_5993::
    ld hl, wCFCC
    inc [hl]
    ld d, $B0
    farcall Func_03A_7193
    ret

Jump_032_59A0::
    ld hl, wCFCC
    inc [hl]
    ld a, [wDAAD]
    cp a, $FF
    ret z
    ld d, $92
    farcall Func_03A_7193
    ld a, $FF
    ld [wDAAD], a
    ret

Jump_032_59B8::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_59C1::
    ld a, $05
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_032_59CB::
    call Func_032_55EE
    ret

Jump_032_59CF::
    call Func_032_5386
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ret

; 1 call site from 1 routine (e.g. Func_036_48CB)
; reads: wDAC1, wD8A5, wD872, wD873
; writes: wCFCC, wCFCD
; points at: wCFCB, wD8BF
Func_032_59DF::
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ld a, [wDAC1]
    and a, $C0
    cp a, $00
    jr z, Jump_032_5A39
    cp a, $40
    jr z, Jump_032_5A26
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wD872]
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
    ld hl, wCFCB
    dec [hl]
    xor a, a
    ld [wCFCD], a

Jump_032_5A26::
    ld a, [wD8A5]
    call SetBit0OfWD095Indexed_Bank32
    ld a, [wD8A5]
    call SetBit1OfWD095Indexed_Bank32
    ld a, [wD8A5]
    call SetBit2OfWD095Indexed_Bank32
    ret

Jump_032_5A39::
    ret

; 1 call site from 1 routine (e.g. Func_036_48CB)
; reads: wCFCD
Func_032_5A3A::
    ld a, [wCFCD]
    rst $00
    dw Jump_032_5A44
    dw Jump_032_5A5B
    dw Jump_032_5A63

Jump_032_5A44::
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call Func_032_5B12
    ret

Jump_032_5A5B::
    call Func_032_5AB3
    ld hl, wCFCD
    inc [hl]
    ret

Jump_032_5A63::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCD], a
    ld a, [wD8A5]
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

; 1 call site from 1 routine (e.g. Func_032_5A3A)
; reads: wD8A6
; points at: wD872
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
    ld hl, wD872
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ret

; 11 call sites from 11 routines (e.g. Func_032_6764, Func_032_55EE, Func_032_5A3A, Func_032_66F1, ...)
; reads: wC58A, wC57F, wD8A5, rSTAT
Func_032_5AB3::
    ld a, [wC58A]
    or a, a
    jr z, Jump_032_5AD4
    cp a, $02
    jr z, Jump_032_5AD4
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_032_5AD4
    ld a, [wD8A5]
    bit 2, a
    ret nz
    and a, $03
    cp a, $03
    ret z
    ld a, [wD8A5]
    jr Jump_032_5AE4

Jump_032_5AD4::
    ld a, [wD8A5]
    bit 2, a
    ret z
    and a, $03
    cp a, $03
    ret z
    ld a, [wD8A5]
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

; 9 call sites from 9 routines (e.g. Func_032_6764, Func_032_55EE, Func_032_5A3A, Func_032_66F1, ...)
; reads: wD8A5, wC58A
; writes: wDAAB, wDABE
; points at: wD812, wDA63, wD8BF, wD80C, wD80A
Func_032_5B12::
    call Func_032_5C3F
    ld a, [wD8A5]
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
    ld a, [wD8A5]
    ld hl, wDA63
    add_a_to_hl
    ld [hl], $01
    ld a, [wD8A5]
    ld hl, wD8BF
    add a, a
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wD8A5]
    ld hl, wD80C
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
    ld a, [wD8A5]
    cp a, $03
    jr z, Jump_032_5B78
    jr c, Jump_032_5B8D
    cp a, $07
    jr z, Jump_032_5B78
    ld [wDAAB], a
    jr Jump_032_5B93

Jump_032_5B78::
    ld a, [wD8A5]
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
    ld a, [wD8A5]
    call SetBit2OfWD095Indexed_Bank32

Jump_032_5B93::
    ret

; 1 call site from 1 routine (e.g. Func_032_5B12)
; reads: wCFF2, wDABF, wDAD1, wD8A5, wDABA
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
    ld a, [wD8A5]
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
    ld a, [wD8A5]
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

; 2 call sites from 2 routines (e.g. Func_032_5E3B, Func_032_5B12)
; reads: wDAC4, wDAC5, wD8A5
; writes: wDAC4, wDAC5
; points at: wD91F, wD90F
Func_032_5BE8::
    push af
    push bc
    push de
    push hl
    ld a, [wDAC4]
    ld l, a
    ld a, [wDAC5]
    ld h, a
    push hl
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4111
    ld a, [wD8A5]
    ld hl, wD91F
    add a, a
    add_a_to_hl
    ld a, [wDAC4]
    ld [hl+], a
    ld a, [wDAC5]
    ld [hl], a
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_40CD
    ld a, [wD8A5]
    ld hl, wD90F
    add a, a
    add_a_to_hl
    ld a, [wDAC4]
    ld [hl+], a
    ld a, [wDAC5]
    ld [hl], a
    pop hl
    ld a, l
    ld [wDAC4], a
    ld a, h
    ld [wDAC5], a
    pop hl
    pop de
    pop bc
    pop af
    ret

; 2 call sites from 2 routines (e.g. Func_032_5E3B, Func_032_5B12)
; reads: wD8A5, wDAC4, wDAC5
; writes: wD868, wD869, wD86A, wD86B
; points at: wD80D, wD8CF, wD8BF, wD8EF, wD8DF, wD8FF, wD92F, wD8B7, ...
Func_032_5C3F::
    ld a, [wD8A5]
    ld hl, wD80D
    call AddAx9ToHL
    ld a, [hl]
    and a, $30
    ret z
    and a, $20
    call nz, Func_032_5E1A
    ld a, $01
    ld [wD868], a
    ld a, [wD8A5]
    ld c, a
    farcall Func_019_434D
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4001
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD8CF
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    call Func_032_6803
    call CompareHLToBC
    jr c, Jump_032_5C95
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5C95::
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4045
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD8EF
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    call Func_032_6808
    call CompareHLToBC
    jr c, Jump_032_5CCA
    ld a, [wD8A5]
    ld hl, wD8DF
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b

Jump_032_5CCA::
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4089
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD8FF
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4155
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD92F
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    ld c, a
    farcall Func_019_4298
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4199
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD8B7
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_41D3
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_420D
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4247
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4281
    ld a, [wDAC4]
    ld c, a
    ld a, [wD8A5]
    ld hl, wD980
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4111
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD91F
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_40CD
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    ld a, [wD8A5]
    ld hl, wD90F
    call AddDoubleAToHL_Bank32
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_42BB
    ld a, [wD8A5]
    ld hl, wD8A7
    add_a_to_hl
    ld [hl], c
    ld a, [wD8A5]
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
    ld a, [wD8A5]
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

; 1 call site from 1 routine (e.g. Func_032_5C3F)
; reads: wD8A5, wC58A
; points at: wDAD4
Func_032_5E1A::
    ld a, [wD8A5]
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

; 1 call site from 1 routine (e.g. Func_0A0_5278)
; reads: wD8A5
; writes: wD80A, wD80B, wD8A5
; points at: wD812, wD80C, wDA63, wDA5B
Func_032_5E3B::
    xor a, a
    ld [wD80A], a
    ld [wD80B], a
    ld c, $00

Jump_032_5E44::
    push bc
    ld a, c
    ld [wD8A5], a
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_032_5E79
    call Func_032_5C3F
    ld a, [wD8A5]
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
    ld a, [wD8A5]
    ld hl, wD80C
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
    ld hl, wDA63
    add_a_to_hl
    ld [hl], $FF
    ld a, $03
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FF
    ld a, $03
    ld hl, wD80C
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

; 1 call site from 1 routine (e.g. Func_036_48CB)
; reads: wCFCC
Func_032_5EAB::
    ld a, [wCFCC]
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
    ld [wCFCD], a
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
    ld hl, wCFCC
    inc [hl]
    ret

Jump_032_5F0A::
    ld a, $03
    ld [wCFCC], a
    ret

Jump_032_5F10::
    ld a, $04
    ld [wCFCC], a
    ret

Jump_032_5F16::
    ld a, [wD8A4]
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
    ld [wCFCC], a
    ret

Jump_032_5F35::
    ld a, $09
    ld [wCFCC], a
    ret

Jump_032_5F3B::
    call Func_032_604A
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ret

Jump_032_5F4B::
    ld a, [wD8A4]
    push af
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld [wD8A4], a
    call Func_032_604A
    pop af
    ld [wD8A4], a
    jr Jump_032_5F3B

Jump_032_5F63::
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jp c, Func_032_61D9
    ld a, [wD8A5]
    ld hl, wD80C
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
    ld a, [wD8A5]
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
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jp c, Func_032_61D9
    ld a, [wD8A5]
    ld hl, wD80C
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
    ld a, [wD8A5]
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
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jp c, Func_032_61D9
    ld a, [wD8A5]
    ld hl, wD80C
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
    ld a, [wD8A5]
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

; 2 call sites from 1 routine (e.g. Func_032_5EAB)
; reads: wD8A4, wC5E7
; points at: wDA1C
Func_032_604A::
    call Func_000_3ED4
    ld a, [wD8A4]
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
    ld a, [wD8A4]
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

Jump_032_6099::
    ld a, [wCFCE]
    or a, a
    jr z, Jump_032_60AB
    ld d, a
    farcall Func_03A_7193
    ld hl, wCFCC
    inc [hl]
    ret

Jump_032_60AB::
    xor a, a
    ld [wCFCC], a
    ld hl, wCFCB
    inc [hl]
    ret

Jump_032_60B4::
    ld a, [wCFCD]
    rst $00
    dw Jump_032_60C0
    dw Jump_032_60DF
    dw Jump_032_6174
    dw Func_032_61D9

Jump_032_60C0::
    ld hl, wCFCD
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

Jump_032_60DF::
    ld hl, wCFCD
    inc [hl]
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD8BF
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
    ld hl, wCFCD
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
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    push hl
    ld a, [wD876]
    ld l, a
    ld a, [wD877]
    ld h, a
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    pop hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld a, [wD871]
    ld [wD8A5], a
    ld a, [wD8A4]
    call SetBit0OfWD095Indexed_Bank32
    ret

Jump_032_6174::
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    call Func_032_618A
    ld a, [wD871]
    ld [wD8A5], a
    ret

; 1 call site from 1 routine (e.g. Func_032_604A)
; reads: wCFCE
Func_032_618A::
    ld a, [wCFCE]
    rst $00
    dw Jump_032_6194
    dw Jump_032_61A9
    dw Jump_032_61B1

Jump_032_6194::
    ld hl, wCFCE
    inc [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_61A9::
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

Jump_032_61B1::
    ld a, [wD8A5]
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
    ld hl, wCFCD
    inc [hl]
    xor a, a
    ld [wCFCE], a
    ret

; 3 call sites from 3 routines (e.g. Func_032_6749, Func_032_627C, Func_032_652E)
; writes: wCFCD, wCFCC
Func_032_61D9::
    xor a, a
    ld [wCFCD], a
    ld a, $01
    ld [wCFCC], a
    ret

Jump_032_61E3::
    ld a, [wCFCD]
    rst $00
    dw Jump_032_61EF
    dw Jump_032_620E
    dw Jump_032_6266
    dw Jump_032_62CB

Jump_032_61EF::
    call Func_032_6749
    ret c
    ld a, $20
    ld [wDAD2], a
    farcall Func_03A_4001
    ld a, $08
    ld [wDAD3], a
    farcall Func_03A_5762
    ld hl, wCFCD
    inc [hl]
    ret

Jump_032_620E::
    ld hl, wCFCD
    inc [hl]
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD8BF
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
    ld hl, wCFCD
    dec [hl]
    xor a, a
    ld [wCFCE], a
    jr Jump_032_625F

Jump_032_6245::
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    ld d, $38
    farcall Func_03A_7193
    ld a, [wD871]
    ld [wD8A5], a

Jump_032_625F::
    ld a, [wD8A4]
    call SetBit0OfWD095Indexed_Bank32
    ret

Jump_032_6266::
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    call Func_032_627C
    ld a, [wD871]
    ld [wD8A5], a
    ret

; 1 call site from 1 routine (e.g. Func_032_61D9)
; reads: wCFCE
Func_032_627C::
    ld a, [wCFCE]
    rst $00
    dw Jump_032_6286
    dw Jump_032_629B
    dw Jump_032_62A3

Jump_032_6286::
    ld hl, wCFCE
    inc [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_629B::
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

Jump_032_62A3::
    ld a, [wD8A5]
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
    ld hl, wCFCD
    inc [hl]
    xor a, a
    ld [wCFCE], a
    ret

Jump_032_62CB::
    call Func_032_61D9
    ret

Jump_032_62CF::
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
    ld [wD8A4], a

Jump_032_62F1::
    ld a, [wCFCD]
    rst $00
    dw Jump_032_62FD
    dw Jump_032_630B
    dw Jump_032_63AC
    dw Jump_032_640B

Jump_032_62FD::
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    jp c, Jump_032_640B
    ret

Jump_032_630B::
    ld hl, wCFCD
    inc [hl]
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A4]
    call SetBit0OfWD095Indexed_Bank32
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $01
    jr z, Jump_032_6366
    ld a, [wD8A4]
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
    ld [wD872], a
    ld a, b
    ld [wD873], a
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    ld d, $38
    farcall Func_03A_7193
    ld a, [wD871]
    ld [wD8A5], a
    jr Jump_032_637D

Jump_032_6366::
    ld a, [wD8A4]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank32
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld hl, $03E8
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a

Jump_032_637D::
    ld a, [wD8A4]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wD872]
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
    ld hl, wCFCD
    dec [hl]
    xor a, a
    ld [wCFCE], a

Jump_032_63AB::
    ret

Jump_032_63AC::
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    call Func_032_63C2
    ld a, [wD871]
    ld [wD8A5], a
    ret

; 1 call site from 1 routine (e.g. Func_032_627C)
; reads: wCFCE
Func_032_63C2::
    ld a, [wCFCE]
    rst $00
    dw Jump_032_63CC
    dw Jump_032_63E1
    dw Jump_032_63E9

Jump_032_63CC::
    ld hl, wCFCE
    inc [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_63E1::
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

Jump_032_63E9::
    ld a, [wD8A5]
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

Jump_032_640B::
    ld a, [wD8A6]
    cp a, $D6
    jr nz, Jump_032_642E
    ld a, [wC983]
    bit 0, a
    jr z, Jump_032_6421
    ld a, [wC982]
    ld [wD8A4], a
    jr Jump_032_642E

Jump_032_6421::
    inc a
    ld [wC983], a
    xor a, a
    ld [wCFCD], a
    xor a, a
    ld [wCFCE], a
    ret

Jump_032_642E::
    ld a, $06
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCD], a
    ret

Jump_032_643C::
    ret

Jump_032_643D::
    ld a, [wCFCD]
    rst $00
    dw Jump_032_6449
    dw Jump_032_6468
    dw Jump_032_6518
    dw Jump_032_657D

Jump_032_6449::
    ld hl, wCFCD
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

Jump_032_6468::
    ld hl, wCFCD
    inc [hl]
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank32
    push hl
    deref_hl
    push hl
    ld a, [wD872]
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
    ld hl, wCFCD
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
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    push hl
    ld a, [wD876]
    ld l, a
    ld a, [wD877]
    ld h, a
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld a, [wC0A0]
    ld d, a
    farcall Func_03A_7193
    pop hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ld a, [wD871]
    ld [wD8A5], a
    ld a, [wD8A4]
    call SetBit0OfWD095Indexed_Bank32
    ret

Jump_032_6518::
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    call Func_032_652E
    ld a, [wD871]
    ld [wD8A5], a
    ret

; 1 call site from 1 routine (e.g. Func_032_63C2)
; reads: wCFCE
Func_032_652E::
    ld a, [wCFCE]
    rst $00
    dw Jump_032_6538
    dw Jump_032_654D
    dw Jump_032_6555

Jump_032_6538::
    ld hl, wCFCE
    inc [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_654D::
    call Func_032_5AB3
    ld hl, wCFCE
    inc [hl]
    ret

Jump_032_6555::
    ld a, [wD8A5]
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
    ld hl, wCFCD
    inc [hl]
    xor a, a
    ld [wCFCE], a
    ret

Jump_032_657D::
    call Func_032_61D9
    ret

; 1 call site from 1 routine (e.g. Func_036_7571)
; reads: wD8A5, wDAC4, wDAC5
; points at: wD80C, wD91F, wD90F
Func_032_6581:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $D0
    call nz, Func_032_660F
    xor a, a
    ld [hl+], a
    ld a, [wD8A5]
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
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_4111
    ld a, [wD8A5]
    ld hl, wD91F
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    call CompareHLToBC
    pop hl
    jr nc, Jump_032_65DF
    ld a, [wDAC4]
    ld [hl+], a
    ld a, [wDAC5]
    ld [hl], a

Jump_032_65DF::
    ld a, [wD8A5]
    ld c, a
    farcall Func_03B_40CD
    ld a, [wD8A5]
    ld hl, wD90F
    add a, a
    add_a_to_hl
    push hl
    deref_hl
    ld a, [wDAC4]
    ld c, a
    ld a, [wDAC5]
    ld b, a
    call CompareHLToBC
    pop hl
    ret nc
    ld a, [wDAC4]
    ld [hl+], a
    ld a, [wDAC5]
    ld [hl], a
    ret

; 3 call sites from 2 routines (e.g. Func_032_6581, Func_032_6622)
; reads: wD8A5
; points at: wDA5B
Func_032_660F::
    push hl
    push bc
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    pop bc
    pop hl
    ret
    db $C9

; 1 call site from 1 routine (e.g. Func_036_7599)
; reads: wD8A5
; points at: wD80C
Func_032_6622::
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $90
    call nz, Func_032_660F
    ld a, [hl]
    and a, $63
    ld [hl], a
    ld a, [wD8A5]
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

; 1 call site from 1 routine (e.g. Func_03A_69AA)
; reads: wCFCC
Func_032_6662::
    ld a, [wCFCC]
    rst $00
    dw Jump_032_666C
    dw Jump_032_667D
    dw Jump_032_66DB

Jump_032_666C::
    ld hl, wCFCC
    inc [hl]
    farcall Func_03A_4001
    farcall Func_03A_5762
    ret

Jump_032_667D::
    ld a, [wD8A5]
    ld hl, wD8BF
    call AddDoubleAToHL_Bank32
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wD872]
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
    ld hl, wCFCC
    inc [hl]
    xor a, a
    ld [wCFCD], a
    jr Jump_032_66B5

Jump_032_66AD::
    xor a, a
    ld [wCFCC], a
    ld hl, wCFCB
    inc [hl]

Jump_032_66B5::
    ld a, [wD8A5]
    call SetBit0OfWD095Indexed_Bank32
    call Func_032_682D
    ld d, $35
    jr c, Jump_032_66C4
    ld d, $36

Jump_032_66C4::
    farcall Func_03A_7193
    ld a, [wD8A4]
    ld l, a
    ld a, [wD8A5]
    ld h, a
    ld a, l
    ld [wD8A5], a
    ld a, h
    ld [wD8A4], a
    ret

Jump_032_66DB::
    ld a, [wD8A5]
    ld [wD871], a
    ld a, [wD8A4]
    ld [wD8A5], a
    call Func_032_66F1
    ld a, [wD871]
    ld [wD8A5], a
    ret

; 1 call site from 1 routine (e.g. Func_032_6662)
; reads: wCFCD
Func_032_66F1::
    ld a, [wCFCD]
    rst $00
    dw Jump_032_66FB
    dw Jump_032_6710
    dw Jump_032_6718

Jump_032_66FB::
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $FE
    call Func_032_5B12
    ret

Jump_032_6710::
    call Func_032_5AB3
    ld hl, wCFCD
    inc [hl]
    ret

Jump_032_6718::
    ld a, [wD8A5]
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
    ld [wCFCD], a
    xor a, a
    ld [wCFCC], a
    ld hl, wCFCB
    inc [hl]
    ld a, $81
    ld [wDABA], a
    ret

; 3 call sites from 3 routines (e.g. Func_032_604A, Func_032_61D9, Func_032_63C2)
; reads: wD8A4
Func_032_6749::
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    ret nc
    call Func_032_61D9
    scf
    ret

; 1 call site from 1 routine (e.g. Func_032_604A)
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

; 1 call site from 1 routine (e.g. Func_03B_453D)
; reads: wCFCD
Func_032_6764::
    ld a, [wCFCD]
    rst $00
    dw Jump_032_676E
    dw Jump_032_6785
    dw Jump_032_678D

Jump_032_676E::
    ld hl, wCFCD
    inc [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld a, [hl]
    add a, $FB
    ld [hl], a
    call Func_032_5B12
    ret

Jump_032_6785::
    call Func_032_5AB3
    ld hl, wCFCD
    inc [hl]
    ret

Jump_032_678D::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCD], a
    ld a, [wD8A5]
    call SetBit2OfWD095Indexed_Bank32
    ld d, $8B
    call Func_032_6848
    jr nc, Jump_032_67A3
    dec d

Jump_032_67A3::
    farcall Func_03A_7193
    ret

; 1 call site from 1 routine (e.g. Func_036_4582)
; reads: wD8A5, wD872, wD873
; writes: wD872, wD873
; points at: wD813
Func_032_67AA::
    ld a, [wD8A5]
    ld hl, wD813
    call AddAx9ToHL
    ld a, [hl]
    push af
    and a, $F0
    ld [hl], a
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    pop af
    bit 0, a
    jr z, Jump_032_67CF
    add hl, hl
    ld a, l
    ld [wD872], a
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
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

Jump_032_67E2::
    bit 2, a
    ret z
    add hl, hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23, $21, $CF, $D8, $18, $1E

; 1 call site from 1 routine (e.g. Func_032_4D5A)
; points at: wD8EF
Func_032_67FE::
    ld hl, wD8EF
    jr Jump_032_681C

; 4 call sites from 4 routines (e.g. Func_032_5C3F, Func_032_4ADC, Func_032_4C9C, Func_032_627C)
; points at: wD8BF
Func_032_6803::
    ld hl, wD8BF
    jr Jump_032_681C

; 2 call sites from 2 routines (e.g. Func_032_5C3F, Func_032_51F9)
; points at: wD8DF
Func_032_6808::
    ld hl, wD8DF
    jr Jump_032_681C
    db $21, $1F, $D9, $18, $0A

; A = the byte at wDA53 + A; clobbers HL (the same 10 bytes appear in 4 banks)
; 6 call sites from 4 routines (e.g. Func_032_51F9, Func_032_529E, Func_032_5303, Func_032_4F0A)
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
; 19 call sites from 9 routines (e.g. Func_032_5C3F, Func_032_5820, Func_032_55EE, Func_032_6662, ...)
AddDoubleAToHL_Bank32::
Func_032_6826:: ; address name
    add a, a
    add_a_to_hl
    ret

; 9 call sites from 8 routines (e.g. Func_032_6662, Func_032_5A3A, Func_032_66F1, Func_032_604A, ...)
; reads: wC58A, wC57F, wD8A4
Func_032_682D::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_032_6842
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_032_6842
    ld a, [wD8A4]
    cp a, $04
    ccf
    ret

Jump_032_6842::
    ld a, [wD8A4]
    cp a, $04
    ret

; 3 call sites from 3 routines (e.g. Func_032_6764, Func_032_5EAB, Func_032_5A3A)
; reads: wC58A, wC57F, wD8A5
Func_032_6848::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_032_685D
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_032_685D
    ld a, [wD8A5]
    cp a, $04
    ccf
    ret

Jump_032_685D::
    ld a, [wD8A5]
    cp a, $04
    ret
    db $7A, $21, $78, $68, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 4 banks)
; 7 call sites from 7 routines (e.g. Func_032_6662, Func_032_4C9C, Func_032_59DF, Func_032_604A, ...)
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
; 3 call sites from 3 routines (e.g. Func_032_5397, Func_032_4C9C, Func_032_59DF)
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
; 16 call sites from 14 routines (e.g. Func_032_5B12, Func_032_6764, Func_032_4C9C, Func_032_4E51, ...)
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
