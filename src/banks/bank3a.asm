SECTION "Bank 3A", ROMX[$4000], BANK[$3A]
    db $3A

; 15 call sites from 12 routines (e.g. Func_032_543C, Func_032_5820, Func_032_5EAB, Func_032_604A, ...)
; reads: wD8A5, wD8A6, wDAD2, wDABF, wCFF2, wD8A4, wD868, wD801
; writes: wD8A4, wD803, wD802, wDAF1, wC952, wD868, wD801, wDAB5, ...
; points at: wD804, wD805, wDAB3, wDAD2
Func_03A_4001::
    ld a, [wD8A5]
    and a, $03
    cp a, $03
    jr nz, Jump_03A_4019
    ld a, [wD8A6]
    cp a, $85
    ret c
    cp a, $89
    ret nc
    ld a, [wDAD2]
    and a, $41
    ret z

Jump_03A_4019::
    ld a, [wDAD2]
    or a, a
    ret z
    bit 7, a
    jr nz, Jump_03A_406E
    bit 6, a
    jr nz, Jump_03A_4073
    bit 5, a
    jr nz, Jump_03A_407B
    bit 4, a
    jr nz, Jump_03A_404D
    bit 3, a
    jr nz, Jump_03A_4042
    bit 2, a
    jr nz, Jump_03A_4037
    ret

Jump_03A_4037::
    ld a, [wD8A5]
    ld [wD8A4], a
    ld hl, Data_03A_47EC
    jr Jump_03A_407E

Jump_03A_4042::
    ld a, [wD8A5]
    ld [wD8A4], a
    ld hl, Data_03A_486C
    jr Jump_03A_407E

Jump_03A_404D::
    bit 0, a
    ret z
    srl a
    and a, $07
    cp a, $00
    jr z, Jump_03A_4062
    cp a, $01
    jr z, Jump_03A_405D
    ret

Jump_03A_405D::
    ld a, $14
    jp Jump_03A_48EC

Jump_03A_4062::
    call Func_03A_7CB5
    ld a, $02
    jp c, Jump_03A_40B3
    ld a, $03
    jr Jump_03A_40B3

Jump_03A_406E::
    ld hl, Data_03A_40CC
    jr Jump_03A_407E

Jump_03A_4073::
    bit 0, a
    ret z
    ld hl, Data_03A_4294
    jr Jump_03A_407E

Jump_03A_407B::
    ld hl, Data_03A_445C

Jump_03A_407E::
    ld a, [wD8A6]
    push af
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    pop af
    cp a, $6C
    jr z, Jump_03A_40A2
    ld a, [wDABF]
    bit 0, a
    jr nz, Jump_03A_40A2
    ld a, [wCFF2]
    cp a, $80
    jr z, Jump_03A_40A2
    call Func_03A_7C9A
    jr nc, Jump_03A_40AA
    inc hl
    jr Jump_03A_40AA

Jump_03A_40A2::
    call Func_03A_7CB5
    jr c, Jump_03A_40AA
    inc hl
    jr Jump_03A_40AA

Jump_03A_40AA::
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    jp z, Jump_03A_48EC

Jump_03A_40B3::
    and a, $7F
    ld [wD803], a
    ld a, $00
    ld [wD802], a
    xor a, a
    ld hl, wD804
    ld bc, $0004
    call FillBytes
    xor a, a
    ld [wDAF1], a
    ret

Data_03A_40CC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $00, $FF, $01, $FF, $02, $FF, $03, $FF, $04, $FF, $05, $FF, $06
    db $FF, $07, $FF, $08, $FF, $09, $FF, $0A, $FF, $0B, $FF, $0F, $FF, $10, $FF, $11
    db $FF, $0C, $FF, $0D, $FF, $0E
    ds $52, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E8144, $64
    ds $22, $FF
    db $84, $84, $84, $84, $84, $84, $85, $85, $2B, $2B, $85, $85
    ds $19, $FF
    db $30
    ds $12, $FF
    db $31, $FF, $84, $84
    ds $2C, $FF
    db $85, $85
    ds $33, $FF
    db $30, $FF, $FF, $FF, $FF, $FF, $33, $FF, $34, $FF, $35, $FF, $36, $FF, $37, $FF
    db $38, $FF, $FF, $FF, $30, $FF, $1D, $FF, $2A, $FF, $FF, $85, $85, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $3B, $FF

Data_03A_4294:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E8294, $124
    ds $1A, $FF
    db $14, $FF, $FF, $FF, $32, $32
    ds $10, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E83E8, $74

Data_03A_445C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $BF, $FF
    db $15, $FF, $15, $FF, $15
    ds $16, $FF
    db $8D, $83, $FF, $FF, $8D, $83, $8D, $83
    ds $2AE, $FF

Data_03A_47EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF, $14, $FF
    db $14, $FF, $14, $FF, $14, $FF, $14
    ds $2D, $FF
    db $12, $FF, $FF, $FF, $82, $FF, $82, $FF, $82, $FF, $82
    ds $31, $FF

Data_03A_486C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $32, $FF
    db $2C, $FF, $2C, $FF, $2C, $FF, $2C, $FF, $15, $FF, $32, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $09, $FF, $0F, $FF, $0E, $FF, $02
    ds $31, $FF

Jump_03A_48EC::
    push af
    xor a, a
    ld [wC952], a
    ld a, [wD8A6]
    cp a, $D7
    jr z, Jump_03A_48FA
    jr Jump_03A_48FF

Jump_03A_48FA::
    ld a, $01
    ld [wC952], a

Jump_03A_48FF::
    pop af
    ld b, a
    call Func_03A_4A19
    call Func_03A_49EB
    ld a, b
    jr nc, Jump_03A_492E
    cp a, $2B
    jr z, Jump_03A_492E
    cp a, $32
    jr z, Jump_03A_492E
    cp a, $13
    jr z, Jump_03A_4917
    ret

Jump_03A_4917::
    ld a, [wD8A6]
    cp a, $32
    jr z, Jump_03A_4921
    cp a, $77
    ret nz

Jump_03A_4921::
    ld a, [wDAD2]
    cp a, $41
    ret nz
    ld a, [wD8A4]
    ld [wD868], a
    ld a, b

Jump_03A_492E::
    ld [wD801], a
    ld [wDAB5], a
    ld b, a
    call Func_03A_4A06
    jr z, Jump_03A_4962
    ld a, b
    cp a, $09
    jr nz, Jump_03A_494A
    ld a, [wD8A6]
    cp a, $48
    ld a, b
    jr nz, Jump_03A_494A
    xor a, a
    jr Jump_03A_4962

Jump_03A_494A::
    cp a, $0D
    jr nz, Jump_03A_4959
    ld hl, wDAD2
    bit 1, [hl]
    jr z, Jump_03A_4959
    ld a, $00
    jr Jump_03A_4962

Jump_03A_4959::
    ld hl, Data_03A_49AF
    add_a_to_hl
    ld a, [hl]

Jump_03A_4962::
    ld [wDAB9], a
    cp a, $00
    jr nz, Jump_03A_4970
    ld a, [wD868]
    call CarryUnlessWDA63SlotEmpty
    ret c

Jump_03A_4970::
    xor a, a
    ld [wD804], a
    ld a, $FF
    ld hl, wD805
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wD802], a
    ld a, $01
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    ld hl, wDAB3
    ld a, l
    ld [wCB75], a
    ld a, h
    ld [wCB76], a
    farcall Func_032_4001
    call Func_03A_4A3A
    ld a, [wD801]
    ld c, a
    call Func_03A_5516
    ret

Data_03A_49AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $01, $01, $01, $02, $02, $01, $02, $01, $01, $01, $02, $01, $02
    db $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $01, $01, $00, $00, $01, $00
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01

; 1 call site from 1 routine (e.g. Func_03A_4001)
; reads: wC58A, wC57F, wD868
Func_03A_49EB::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_4A00
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_4A00
    ld a, [wD868]
    cp a, $04
    ccf
    ret

Jump_03A_4A00::
    ld a, [wD868]
    cp a, $04
    ret

; 1 call site from 1 routine (e.g. Func_03A_4001)
; reads: wDAD2, wD8A6
Func_03A_4A06::
    ld a, [wDAD2]
    bit 3, a
    ret nz
    ld a, b
    cp a, $1D
    ret nz
    ld a, [wD8A6]
    cp a, $65
    ret nz
    ld a, $02
    ret

; 1 call site from 1 routine (e.g. Func_03A_4001)
; reads: wDAD2, wD8A6, wD8A5, wD8A4
; writes: wD868
Func_03A_4A19::
    ld a, [wDAD2]
    bit 3, a
    jr nz, Jump_03A_4A33
    ld a, [wD8A6]
    cp a, $3A
    jr z, Jump_03A_4A2C
    ld a, [wD8A5]
    jr Jump_03A_4A2F

Jump_03A_4A2C::
    ld a, [wD8A4]

Jump_03A_4A2F::
    ld [wD868], a
    ret

Jump_03A_4A33::
    ld a, [wD8A5]
    ld [wD868], a
    ret

; 9 call sites from 5 routines (e.g. Func_03A_4ADB, Func_03A_4001, Func_03A_548F, Func_03D_4001, ...)
; reads: wDAB9, wD890, wC58A, wC57F, wD868, wD805
; writes: wD804
; points at: wD805
Func_03A_4A3A::
    ld a, [wDAB9]
    cp a, $00
    jr z, Jump_03A_4A4F
    cp a, $01
    jr z, Jump_03A_4A79
    cp a, $02
    jr z, Jump_03A_4A7F
    ld a, $00
    ld [wD804], a
    ret

Jump_03A_4A4F::
    ld a, [wD890]
    ld b, a
    ld a, b
    cp a, $03
    jr z, Jump_03A_4A60
    cp a, $02
    jr z, Jump_03A_4A64
    ld b, $05
    jr Jump_03A_4A66

Jump_03A_4A60::
    ld b, $00
    jr Jump_03A_4A66

Jump_03A_4A64::
    ld b, $03

Jump_03A_4A66::
    ld a, [wD868]
    and a, $03
    add a, b
    ld hl, Data_03A_4AD5
    add_a_to_hl
    ld a, [hl]
    ld [wD804], a
    ret

Jump_03A_4A79::
    ld a, $50
    ld [wD804], a
    ret

Jump_03A_4A7F::
    ld c, $04
    ld a, [wD890]
    ld b, a
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_4A95
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_4A95
    ld c, $00

Jump_03A_4A95::
    ld e, $00
    ld a, b
    cp a, $03
    jr z, Jump_03A_4AA4
    cp a, $02
    jr z, Jump_03A_4AA8
    ld d, $05
    jr Jump_03A_4A66

Jump_03A_4AA4::
    ld d, $00
    jr Jump_03A_4AAA

Jump_03A_4AA8::
    ld d, $03

Jump_03A_4AAA::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_4ACA
    ld a, e
    ld hl, wD805
    add_a_to_hl
    push hl
    ld a, c
    and a, $03
    add a, d
    ld hl, Data_03A_4AD5
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [hl], a
    inc e

Jump_03A_4ACA::
    inc c
    dec b
    jr nz, Jump_03A_4AAA
    ld a, [wD805]
    ld [wD804], a
    ret

Data_03A_4AD5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $50, $80, $38, $68, $50

; 4 call sites from 4 routines (e.g. Func_031_40A5, Func_03A_6157, Func_03A_68C9, Func_0A0_4F70)
; reads: wD802, wD800, wD801, wDAD2, wC58A, wDAB3, wDAAA, wDAB9, ...
; writes: wD800, wDAD3, wD804, wD806, wDAAA, wDAF1, wD807, wD802, ...
; points at: wD805, wDAB3, wDAF1
Func_03A_4ADB::
    ld a, [wD802]
    cp a, $00
    jp z, Jump_03A_4C14
    ld a, [wD800]
    cp a, $01
    jr nz, Jump_03A_4B04
    ld a, [wD801]
    ld c, a
    call Func_03A_52A4
    ld a, $02
    ld [wD800], a
    ld a, [wDAD2]
    srl a
    and a, $44
    ld [wDAD3], a
    call Func_03A_5762
    ret

Jump_03A_4B04::
    ld a, [wD800]
    cp a, $02
    jp nz, Jump_03A_4B87
    ld a, [wC58A]
    or a, a
    jr nz, Jump_03A_4B18
    farcall Func_032_4001

Jump_03A_4B18::
    call Func_03A_536D
    ld a, [wDAB3]
    or a, a
    jr z, Jump_03A_4B2B
    ld a, [wDAAA]
    or a, a
    jr z, Jump_03A_4B2B
    call Func_03A_5383
    ret

Jump_03A_4B2B::
    ld a, [wDAB9]
    cp a, $02
    jr nz, Jump_03A_4B74
    ld a, [wD806]
    cp a, $FF
    jr z, Jump_03A_4B53
    ld a, [wD806]
    ld [wD804], a
    ld a, $FF
    ld [wD806], a
    xor a, a
    ld [wDAAA], a
    ld a, $03
    ld [wD800], a
    ld a, $08
    ld [wDAF1], a
    ret

Jump_03A_4B53::
    ld a, [wD807]
    cp a, $FF
    jr z, Jump_03A_4B74
    ld a, [wD807]
    ld [wD804], a
    ld a, $FF
    ld [wD807], a
    xor a, a
    ld [wDAAA], a
    ld a, $03
    ld [wD800], a
    ld a, $08
    ld [wDAF1], a
    ret

Jump_03A_4B74::
    ld a, [wC952]
    or a, a
    jr nz, Jump_03A_4BB5
    xor a, a
    ld [wD800], a
    ld [wDAAA], a
    ld a, $FF
    ld [wD802], a
    ret

Jump_03A_4B87::
    ld hl, wDAF1
    dec [hl]
    ld a, [hl]
    or a, a
    ret nz
    xor a, a
    ld [wDAF1], a
    ld a, $02
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    farcall Func_032_4001
    ld a, [wDAD2]
    srl a
    and a, $44
    ld [wDAD3], a
    call Func_03A_5762
    ret

Jump_03A_4BB5::
    xor a, a
    ld [wC952], a
    ld a, [wD8A6]
    sub a, $D7
    sla a
    ld hl, Data_03A_4C12
    add_a_to_hl
    ld a, [hl+]
    ld [wD801], a
    ld [wDAB5], a
    ld a, [hl]
    ld [wDAB9], a
    xor a, a
    ld [wD804], a
    ld a, $FF
    ld hl, wD805
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wD802], a
    ld a, $01
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    ld hl, wDAB3
    ld a, l
    ld [wCB75], a
    ld a, h
    ld [wCB76], a
    farcall Func_032_4001
    call Func_03A_4A3A
    ld a, [wD801]
    ld c, a
    call Func_03A_5516
    ret

Data_03A_4C12:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $22, $00

Jump_03A_4C14::
    call Func_03A_4C26
    call Func_03A_5536
    ld a, [wD802]
    cp a, $FF
    ret nz
    ld a, $7F
    ld [wC526], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_4ADB)
; reads: wDAF1, wD803
; writes: wDAF1
Func_03A_4C26::
    ld a, [wDAF1]
    inc a
    cp a, $05
    ld [wDAF1], a
    ret c
    xor a, a
    ld [wDAF1], a
    ld a, [wD803]
    rst $00
    dw Jump_03A_4C54
    dw Jump_03A_4C54
    dw Jump_03A_4C5E
    dw Jump_03A_4DF4
    dw Jump_03A_4E35
    dw Jump_03A_4E74
    dw Jump_03A_4F06
    dw Jump_03A_4F42
    dw Jump_03A_4F97
    dw Jump_03A_507A
    dw Jump_03A_508A
    dw Jump_03A_5114
    dw Jump_03A_513A
    dw Jump_03A_51DF

Jump_03A_4C54::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

Jump_03A_4C5E::
    ld a, [wD8A5]
    and a, $03
    cp a, $03
    jp z, Jump_03A_4CEB
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_4C7F
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_4C7F
    ld a, [wD8A5]
    cp a, $04
    jr nc, Jump_03A_4CEB
    jr Jump_03A_4C86

Jump_03A_4C7F::
    ld a, [wD8A5]
    cp a, $04
    jr c, Jump_03A_4CEB

Jump_03A_4C86::
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_4CEB
    ld a, [wD804]
    rst $00
    dw Jump_03A_4C9C
    dw Jump_03A_4CC2
    dw Jump_03A_4C9C
    dw Jump_03A_4CC2
    dw Jump_03A_4CEB

Jump_03A_4C9C::
    ld a, $06
    ld [wD805], a
    call Func_03A_4CF9
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4CC2::
    ld a, $06
    ld [wD805], a
    call Func_03A_4CF9
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wD8A5]
    and a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4CEB::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    xor a, a
    ld [wD805], a
    ret

; 2 call sites from 1 routine (e.g. Func_03A_4C26)
; reads: wD890, wD8A5
Func_03A_4CF9::
    ld a, [wD890]
    cp a, $01
    jr z, Jump_03A_4D28
    cp a, $02
    jr z, Jump_03A_4D17
    ld a, [wD8A5]
    and a, $03
    cp a, $01
    jr z, Jump_03A_4D28
    jr c, Jump_03A_4D13
    ld a, $04
    jr Jump_03A_4D2A

Jump_03A_4D13::
    ld a, $03
    jr Jump_03A_4D2A

Jump_03A_4D17::
    ld a, [wD8A5]
    and a, $03
    cp a, $01
    jr z, Jump_03A_4D24
    ld a, $01
    jr Jump_03A_4D2A

Jump_03A_4D24::
    ld a, $02
    jr Jump_03A_4D2A

Jump_03A_4D28::
    ld a, $00

Jump_03A_4D2A::
    ret

; 4 call sites from 2 routines (e.g. Func_03A_4C26, Func_03A_50D9)
; reads: wD805
Func_03A_4D2B::
    push de
    ld a, [wD805]
    ld b, a

Jump_03A_4D30::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, Jump_03A_4D30
    pop de
    dec c
    ret z
    ld a, $20
    add a, e
    ld e, a
    jr nc, Jump_03A_4D45
    inc d

Jump_03A_4D45::
    jr Func_03A_4D2B

; 8 call sites from 2 routines (e.g. Func_03A_4C26, Func_03A_50D9)
Func_03A_4D47::
    add a, a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    deref_hl
    ret

Data_03A_4D52:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E7, $00, $E4, $00, $EA, $00, $E1, $00, $ED, $00

Data_03A_4D5C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E8D5C, $74
    ds $24, $C3

Jump_03A_4DF4::
    ld a, [wD804]
    rst $00
    dw Jump_03A_4E00
    dw Jump_03A_4E1A
    dw Jump_03A_4E00
    dw Jump_03A_4E25

Jump_03A_4E00::
    ld a, $02
    ldh [hFFA5], a
    ld a, $00
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: hFFA5, hFFA1
; points at: wD804
Func_03A_4E0D:: ; heuristic: follows a terminator; C0
    ld a, $00
    ldh [hFFA5], a
    ld a, $01
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4E1A::
    xor a, a
    ldh [hFFA5], a
    xor a, a
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4E25::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ldh [hFFA5], a
    xor a, a
    ldh [hFFA1], a
    xor a, a
    ld [wD804], a
    ret

Jump_03A_4E35::
    ld a, [wD804]
    rst $00
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E67

Jump_03A_4E47::
    ld hl, wC5E9
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, wD804
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_03A_4E57)
; points at: wC5E9, wD804
Func_03A_4E57::
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4E67::
    call Func_03A_4E57
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

Jump_03A_4E74::
    ld a, [wD804]
    rst $00
    dw Jump_03A_4E80
    dw Jump_03A_4E96
    dw Jump_03A_4EA9
    dw Jump_03A_4EB9

Jump_03A_4E80::
    call Func_03A_4EC3
    ld a, [wD807]
    cp a, $04
    ret c
    xor a, a
    ld [wD806], a
    xor a, a
    ld [wD807], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4E96::
    ld hl, wD805
    inc [hl]
    ld a, [wD805]
    cp a, $0A
    ret nz
    ld hl, wD804
    inc [hl]
    xor a, a
    ld [wD805], a
    ret

Jump_03A_4EA9::
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4EB9::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; 2 call sites from 2 routines (e.g. Func_03A_4E57, Func_03A_4EC3)
; points at: wD807, wC5E9
Func_03A_4EC3::
    ld hl, wD807
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wC5E9

Jump_03A_4ECE::
    ld a, [hl]
    and a, $03
    add a, $01
    cp a, $04
    jr c, Jump_03A_4ED9
    ld a, $03

Jump_03A_4ED9::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    add a, $04
    cp a, $0D
    jr c, Jump_03A_4EE6
    ld a, $0C

Jump_03A_4EE6::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    add a, $10
    cp a, $31
    jr c, Jump_03A_4EF3
    ld a, $30

Jump_03A_4EF3::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    add a, $40
    cp a, $C1
    jr c, Jump_03A_4F00
    ld a, $C0

Jump_03A_4F00::
    or a, c
    ld [hl+], a
    dec b
    jr nz, Jump_03A_4ECE
    ret

Jump_03A_4F06::
    ld a, [wD804]
    rst $00
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F24
    dw Jump_03A_4F38

Jump_03A_4F24::
    ld hl, wC5E9
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4F38::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

Jump_03A_4F42::
    ld a, [wD804]
    rst $00
    dw Jump_03A_4F54
    dw Jump_03A_4F6A
    dw Jump_03A_4F7D
    dw Jump_03A_4F54
    dw Jump_03A_4F6A
    dw Jump_03A_4F7D
    dw Jump_03A_4F8D

Jump_03A_4F54::
    call Func_03A_4EC3
    ld a, [wD807]
    cp a, $04
    ret c
    xor a, a
    ld [wD806], a
    xor a, a
    ld [wD807], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4F6A::
    ld hl, wD805
    inc [hl]
    ld a, [wD805]
    cp a, $05
    ret nz
    ld hl, wD804
    inc [hl]
    xor a, a
    ld [wD805], a
    ret

Jump_03A_4F7D::
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_4F8D::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

Jump_03A_4F97::
    ld a, [wD804]
    or a, a
    call z, Func_03A_4FB4
    call Func_03A_5028
    ld a, [wD804]
    or a, a
    ret z
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    xor a, a
    ld [wD805], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_4EC3)
; reads: wD804, wD805
Func_03A_4FB4::
    ld a, [wD804]
    or a, a
    ret nz
    ld a, [wD805]
    rst $00
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_500D
    dw Jump_03A_4FF3
    dw Jump_03A_500D
    dw Jump_03A_5000
    dw Jump_03A_5018

Jump_03A_4FF3::
    ld a, $04
    ldh [hFFA5], a
    ld a, $00
    ldh [hFFA1], a
    ld hl, wD805
    inc [hl]
    ret

Jump_03A_5000::
    ld a, $00
    ldh [hFFA5], a
    ld a, $03
    ldh [hFFA1], a
    ld hl, wD805
    inc [hl]
    ret

Jump_03A_500D::
    xor a, a
    ldh [hFFA5], a
    xor a, a
    ldh [hFFA1], a
    ld hl, wD805
    inc [hl]
    ret

Jump_03A_5018::
    ld a, $01
    ld [wD804], a
    xor a, a
    ldh [hFFA5], a
    xor a, a
    ldh [hFFA1], a
    xor a, a
    ld [wD805], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_4EC3)
; reads: wD805
Func_03A_5028::
    ld a, [wD805]
    rst $00
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E
    dw Jump_03A_5062
    dw Jump_03A_506E

Jump_03A_5062::
    ld hl, wC5E9
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ret

Jump_03A_506E::
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ret

Jump_03A_507A::
    ld a, [wD807]
    or a, a
    jr nz, Jump_03A_5085
    ld hl, wD807
    inc [hl]
    ret

Jump_03A_5085::
    ld hl, wD807
    inc [hl]
    ret

Jump_03A_508A::
    ld a, [wD804]
    rst $00
    dw Jump_03A_5096
    dw Jump_03A_50AC
    dw Jump_03A_50BF
    dw Jump_03A_50CF

Jump_03A_5096::
    call Func_03A_50D9
    ld a, [wD807]
    cp a, $04
    ret c
    xor a, a
    ld [wD806], a
    xor a, a
    ld [wD807], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_50AC::
    ld hl, wD805
    inc [hl]
    ld a, [wD805]
    cp a, $0A
    ret nz
    ld hl, wD804
    inc [hl]
    xor a, a
    ld [wD805], a
    ret

Jump_03A_50BF::
    ld hl, wC5E9
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_50CF::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_5028)
; points at: wD807, wC5E9
Func_03A_50D9::
    ld hl, wD807
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wC5E9

Jump_03A_50E4::
    ld a, [hl]
    and a, $03
    cp a, $00
    jr z, Jump_03A_50ED
    sub a, $01

Jump_03A_50ED::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    cp a, $00
    jr z, Jump_03A_50F8
    sub a, $04

Jump_03A_50F8::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    cp a, $00
    jr z, Jump_03A_5103
    sub a, $10

Jump_03A_5103::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    cp a, $00
    jr z, Jump_03A_510E
    sub a, $40

Jump_03A_510E::
    or a, c
    ld [hl+], a
    dec b
    jr nz, Jump_03A_50E4
    ret

Jump_03A_5114::
    ld a, [wD804]
    rst $00
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E47
    dw Func_03A_4E57
    dw Jump_03A_4E67

Jump_03A_513A::
    ld a, [wD804]
    rst $00
    dw Jump_03A_5180
    dw Jump_03A_5176
    dw Jump_03A_5189
    dw Jump_03A_5176
    dw Jump_03A_5192
    dw Jump_03A_5176
    dw Jump_03A_519B
    dw Jump_03A_5176
    dw Jump_03A_51A4
    dw Jump_03A_5176
    dw Jump_03A_51AD
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_5176
    dw Jump_03A_51B6
    dw Jump_03A_5176
    dw Jump_03A_51C3
    dw Jump_03A_51D0

Jump_03A_5176::
    xor a, a
    ldh [hFFA1], a
    ldh [hFFA5], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_5180::
    ld a, $FE
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_5189::
    ld a, $02
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_5192::
    ld a, $FC
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_519B::
    ld a, $04
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_51A4::
    ld a, $F8
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_51AD::
    ld a, $08
    ldh [hFFA1], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_51B6::
    ld a, $F8
    ldh [hFFA1], a
    ld a, $02
    ldh [hFFA5], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_51C3::
    ld a, $08
    ldh [hFFA1], a
    ld a, $02
    ldh [hFFA5], a
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_51D0::
    xor a, a
    ldh [hFFA1], a
    ldh [hFFA5], a
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    ret

Jump_03A_51DF::
    ld a, [wC57F]
    ld b, a
    ld a, [wC58A]
    ld c, a
    ld a, [wD8A4]
    cp a, $07
    jr nc, Jump_03A_5264
    cp a, $03
    jr z, Jump_03A_5264
    dec c
    jr nz, Jump_03A_51FB
    cp a, $04
    jr nc, Jump_03A_5264
    jr Jump_03A_51FF

Jump_03A_51FB::
    cp a, $04
    jr c, Jump_03A_5264

Jump_03A_51FF::
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_5264
    ld a, [wD804]
    rst $00
    dw Jump_03A_5215
    dw Jump_03A_523B
    dw Jump_03A_5215
    dw Jump_03A_523B
    dw Jump_03A_5264

Jump_03A_5215::
    ld a, $06
    ld [wD805], a
    call Func_03A_5272
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_523B::
    ld a, $06
    ld [wD805], a
    call Func_03A_5272
    ld hl, Data_03A_4D52
    call Func_03A_4D47
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wD8A4]
    and a, $03
    ld hl, Data_03A_4D5C
    call Func_03A_4D47
    ld c, $06
    call Func_03A_4D2B
    ld hl, wD804
    inc [hl]
    ret

Jump_03A_5264::
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wD804], a
    xor a, a
    ld [wD805], a
    ret

; 2 call sites from 1 routine (e.g. Func_03A_50D9)
; reads: wD890, wD8A4
Func_03A_5272::
    ld a, [wD890]
    cp a, $01
    jr z, Jump_03A_52A1
    cp a, $02
    jr z, Jump_03A_5290
    ld a, [wD8A4]
    and a, $03
    cp a, $01
    jr z, Jump_03A_52A1
    jr c, Jump_03A_528C
    ld a, $04
    jr Jump_03A_52A3

Jump_03A_528C::
    ld a, $03
    jr Jump_03A_52A3

Jump_03A_5290::
    ld a, [wD8A4]
    and a, $03
    cp a, $01
    jr z, Jump_03A_529D
    ld a, $01
    jr Jump_03A_52A3

Jump_03A_529D::
    ld a, $02
    jr Jump_03A_52A3

Jump_03A_52A1::
    ld a, $00

Jump_03A_52A3::
    ret

; 2 call sites from 2 routines (e.g. Func_03A_4ADB, Func_03A_54DC)
Func_03A_52A4::
    ld c, a
    ld b, $00
    ld hl, Data_03A_52B9
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    ld hl, vTiles0
    call DecompressToVRAM
    ret

Data_03A_52B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0E92B9, $B4

; 2 call sites from 2 routines (e.g. Func_03A_4ADB, Func_03A_54DC)
; reads: wDAB9, wD804
; writes: wD804, wDAAA
Func_03A_536D::
    ld a, [wDAB9]
    cp a, $03
    ret nz
    ld a, [wD804]
    add a, $04
    ld [wD804], a
    cp a, $D0
    ret c
    xor a, a
    ld [wDAAA], a
    ret

; 2 call sites from 2 routines (e.g. Func_03A_4ADB, Func_03A_54DC)
; reads: wD801
Func_03A_5383::
    ld a, [wD801]
    cp a, $0E
    jr c, Jump_03A_539D
    cp a, $20
    jr c, Jump_03A_53A4
    cp a, $2D
    jr c, Jump_03A_53AB
    cp a, $33
    jr c, Jump_03A_53B2
    farcall Func_092_4001
    ret

Jump_03A_539D::
    farcall Func_03E_4001
    ret

Jump_03A_53A4::
    farcall Func_03F_4001
    ret

Jump_03A_53AB::
    farcall Func_03D_4001
    ret

Jump_03A_53B2::
    farcall Func_03B_5059
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4FCE)
; reads: wC5F9, wD868, wD869, wD86A, wD86B
; writes: wD868, wD869, wD86A, wD86B
Func_03A_53B9::
    ld hl, vBGMap0 + $1CE
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld hl, vBGMap0 + $1D2
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld hl, Data_03A_40CC
    call Func_03A_540A
    ld hl, vBGMap0 + $1EE
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld hl, vBGMap0 + $1F2
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld hl, Data_03A_4294
    call Func_03A_540A
    ld hl, vBGMap0 + $20E
    ld a, l
    ld [wD868], a
    ld a, h
    ld [wD869], a
    ld hl, vBGMap0 + $212
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    ld hl, Data_03A_445C

; 2 call sites from 1 routine (e.g. Func_03A_53B9)
; reads: wC5F9, wD868, wD869, wD86A, wD86B
Func_03A_540A::
    ld a, [wC5F9]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_5451
    push hl
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5424
    add a, $E0
    jr Jump_03A_5426

Jump_03A_5424::
    sub a, $02

Jump_03A_5426::
    ld b, a
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    ld a, b
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5440
    add a, $E0
    jr Jump_03A_5442

Jump_03A_5440::
    sub a, $02

Jump_03A_5442::
    ld b, a
    ld a, [wD868]
    ld l, a
    ld a, [wD869]
    ld h, a
    dec hl
    ld a, b
    call WriteVRAMByte
    pop hl

Jump_03A_5451::
    dec hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_548E
    push af
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_5462
    add a, $E0
    jr Jump_03A_5464

Jump_03A_5462::
    sub a, $02

Jump_03A_5464::
    ld b, a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    ld a, b
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, Jump_03A_547E
    add a, $E0
    jr Jump_03A_5480

Jump_03A_547E::
    sub a, $02

Jump_03A_5480::
    ld b, a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a
    dec hl
    ld a, b
    call WriteVRAMByte

Jump_03A_548E::
    ret

; 1 call site from 1 routine (e.g. Func_0E0_4ABB)
; reads: wC5FE, wD801
; writes: wD801, wDAB5, wDAB9, wD804, wD802, wD800, wDAAA, wDAB3, ...
; points at: wD805, wDAB3
Func_03A_548F::
    ld a, [wC5FE]
    ld [wD801], a
    ld [wDAB5], a
    ld a, $01
    ld [wDAB9], a
    xor a, a
    ld [wD804], a
    ld a, $FF
    ld hl, wD805
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wD802], a
    ld a, $01
    ld [wD800], a
    ld a, $01
    ld [wDAAA], a
    ld a, $00
    ld [wDAB3], a
    ld hl, wDAB3
    ld a, l
    ld [wCB75], a
    ld a, h
    ld [wCB76], a
    farcall Func_032_4001
    call Func_03A_4A3A
    ld a, [wD801]
    ld c, a
    call Func_03A_5516
    ret

; 1 call site from 1 routine (e.g. Func_0E0_48B7)
; reads: wD800, wD801, wDAB3, wDAAA
; writes: wD800, wDAAA, wD802
Func_03A_54DC::
    ld a, [wD800]
    cp a, $01
    jr nz, Jump_03A_54F0
    ld a, [wD801]
    ld c, a
    call Func_03A_52A4
    ld a, $02
    ld [wD800], a
    ret

Jump_03A_54F0::
    farcall Func_032_4001
    call Func_03A_536D
    ld a, [wDAB3]
    or a, a
    jr z, Jump_03A_5509
    ld a, [wDAAA]
    or a, a
    jr z, Jump_03A_5509
    call Func_03A_5383
    ret

Jump_03A_5509::
    xor a, a
    ld [wD800], a
    ld [wDAAA], a
    ld a, $FF
    ld [wD802], a
    ret

; 3 call sites from 3 routines (e.g. Func_03A_4ADB, Func_03A_4001, Func_03A_548F)
; reads: wIsCGB
; writes: wC527
; points at: wC4DF
Func_03A_5516::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld l, c
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, Data_03A_7D9A
    add hl, bc
    ld b, $08
    ld de, wC4DF

Jump_03A_552A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_03A_552A
    ld a, $80
    ld [wC527], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_4ADB)
; reads: wIsCGB, wC5E9, rSTAT, wC5EA
; writes: rBGPI, wD040, rOBPI, wD041
; points at: wD040, wC49F, wD041, wC4DF
Func_03A_5536::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld hl, wD040
    ld a, [wC5E9]
    cp a, [hl]
    jp z, Jump_03A_564C
    ld c, $69

Jump_03A_5547::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5547
    ld a, $80
    ldh [rBGPI], a
    ld hl, wC49F
    call Func_03A_55BB

Jump_03A_5557::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5557
    ld a, $88
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_5564::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5564
    ld a, $90
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_5571::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5571
    ld a, $98
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_557E::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_557E
    ld a, $A0
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_558B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_558B
    ld a, $A8
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_5598::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5598
    ld a, $B0
    ldh [rBGPI], a
    call Func_03A_55BB

Jump_03A_55A5::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_55A5
    ld a, $B8
    ldh [rBGPI], a
    call Func_03A_55BB
    ld a, [wC5E9]
    ld [wD040], a
    jp Jump_03A_564C

; 8 call sites from 1 routine (e.g. Func_03A_5536)
; reads: wC5E9, rSTAT
Func_03A_55BB::
    push hl
    ld a, [wC5E9]
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_55C9
    inc d

Jump_03A_55C9::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_55CF
    inc h

Jump_03A_55CF::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_55CF
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5E9]
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_55EC
    inc d

Jump_03A_55EC::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_55F2
    inc h

Jump_03A_55F2::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_55F2
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5E9]
    swap a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_560D
    inc d

Jump_03A_560D::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5613
    inc h

Jump_03A_5613::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5613
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5E9]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_5632
    inc d

Jump_03A_5632::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5638
    inc h

Jump_03A_5638::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5638
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_03A_564C::
    ld hl, wD041
    ld a, [wC5EA]
    cp a, [hl]
    jp z, Jump_03A_575D
    ld c, $6B

Jump_03A_5658::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5658
    ld a, $80
    ldh [rOBPI], a
    ld hl, wC4DF
    call Func_03A_56CC

Jump_03A_5668::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5668
    ld a, $88
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_5675::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5675
    ld a, $90
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_5682::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5682
    ld a, $98
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_568F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_568F
    ld a, $A0
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_569C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_569C
    ld a, $A8
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_56A9::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_56A9
    ld a, $B0
    ldh [rOBPI], a
    call Func_03A_56CC

Jump_03A_56B6::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_56B6
    ld a, $B8
    ldh [rOBPI], a
    call Func_03A_56CC
    ld a, [wC5EA]
    ld [wD041], a
    jp Jump_03A_575D

; 8 call sites from 1 routine (e.g. Func_03A_55BB)
; reads: wC5EA, rSTAT
Func_03A_56CC::
    push hl
    ld a, [wC5EA]
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_56DA
    inc d

Jump_03A_56DA::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_56E0
    inc h

Jump_03A_56E0::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_56E0
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5EA]
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_56FD
    inc d

Jump_03A_56FD::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5703
    inc h

Jump_03A_5703::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5703
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5EA]
    swap a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_571E
    inc d

Jump_03A_571E::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5724
    inc h

Jump_03A_5724::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5724
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wC5EA]
    swap a
    srl a
    srl a
    and a, $03
    ld de, Data_03A_575E
    add a, e
    ld e, a
    jr nc, Jump_03A_5743
    inc d

Jump_03A_5743::
    ld a, [de]
    add a, l
    ld l, a
    jr nc, Jump_03A_5749
    inc h

Jump_03A_5749::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_03A_5749
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

Jump_03A_575D::
    ret

Data_03A_575E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $04, $00, $06

; 15 call sites from 12 routines (e.g. Func_03A_4ADB, Func_032_543C, Func_032_5820, Func_032_5EAB, ...)
; reads: wDAD3, wD8A5, wD8A6
; writes: wD8A4
Func_03A_5762::
    ld a, [wDAD3]
    or a, a
    ret z
    bit 7, a
    jr nz, Jump_03A_5796
    bit 6, a
    jr nz, Jump_03A_579B
    bit 5, a
    jr nz, Jump_03A_57A0
    bit 3, a
    jr nz, Jump_03A_57B1
    bit 2, a
    jr nz, Jump_03A_578B
    bit 0, a
    jr nz, Jump_03A_5780
    ret

Jump_03A_5780::
    ld a, [wD8A5]
    ld [wD8A4], a
    ld hl, Data_03A_60B7
    jr Jump_03A_57B4

Jump_03A_578B::
    ld a, [wD8A5]
    ld [wD8A4], a
    ld hl, Data_03A_6107
    jr Jump_03A_57B4

Jump_03A_5796::
    ld hl, Data_03A_57F7
    jr Jump_03A_57B4

Jump_03A_579B::
    ld hl, Data_03A_59BF
    jr Jump_03A_57B4

Jump_03A_57A0::
    ld b, a
    call Func_03A_57CA
    ret nz
    ld hl, Data_03A_5B87
    bit 4, b
    jr nz, Jump_03A_57B4
    ld hl, Data_03A_5D4F
    jr Jump_03A_57B4

Jump_03A_57B1::
    ld hl, Data_03A_5F17

Jump_03A_57B4::
    ld a, [wD8A6]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    call Func_03A_7C9A
    jr nc, Jump_03A_57C2
    inc hl

Jump_03A_57C2::
    ld a, [hl]
    cp a, $FF
    ret z
    call StoreWC60B
    ret

; 1 call site from 1 routine (e.g. Func_03A_5762)
; reads: wD8A6, wDAC0
; points at: wD872
Func_03A_57CA::
    bit 4, a
    ret z
    ld a, [wD8A6]
    cp a, $15
    jr z, Jump_03A_57E2
    cp a, $20
    jr z, Jump_03A_57F1
    cp a, $7B
    jr z, Jump_03A_57F1
    cp a, $D6
    jr z, Jump_03A_57E2
    xor a, a
    ret

Jump_03A_57E2::
    ld hl, wD872
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ld a, $81
    call StoreWC60B
    ret

Jump_03A_57F1::
    ld a, [wDAC0]
    bit 6, a
    ret

Data_03A_57F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $7C
    ds $78, $7A
    INCBIN "dwm2-cobi-us.gbc", $0E9871, $BE
    ds $1C, $FF
    db $80, $7C, $FF, $FF, $FF, $FF, $7A, $FF, $7A
    ds $15, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9969, $56

Data_03A_59BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $89, $FF, $8B, $FF, $8B, $FF, $8D, $FF, $8D, $FF, $8F, $FF, $90
    db $FF, $D9, $FF, $91, $FF, $93, $FF, $93, $FF, $94, $FF, $97, $FF, $97, $FF, $98
    db $FF, $95, $FF, $95, $FF, $96
    ds $55, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9A3A, $61
    ds $2A, $FF
    db $B0, $B0
    ds $1B, $FF
    db $B6
    ds $12, $FF
    db $DC, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $BA
    ds $5E, $FF
    db $BC, $FF, $BD, $FF, $BF, $FF, $C1, $FF, $C3, $FF, $C5, $FF, $FF, $FF, $99, $FF
    db $99, $FF, $C7
    ds $12, $FF
    db $CB, $FF

Data_03A_5B87:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $26, $81
    db $B1, $B1, $B1, $B1, $B1, $B1
    ds $10, $85
    db $FF, $FF, $FF, $FF, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $86, $86
    db $86, $86, $87, $87, $87, $87, $86, $86, $86, $86, $87, $87, $87, $87, $86, $86
    db $99, $99, $88, $88, $88, $88, $86, $FF, $86, $87, $87, $87, $FF, $88, $FF, $FF
    db $9B, $9B, $9B, $9B, $FF, $FF, $FF, $FF, $9A, $9A, $9A, $9A, $FF, $FF
    ds $56, $81
    db $FF, $FF
    ds $10, $81
    db $88, $88, $88, $88, $88, $88, $88, $88, $88, $88, $87, $87, $86, $87, $88, $88
    db $B1, $B1, $88, $88, $85, $85, $85, $85, $FF, $FF, $88, $99, $81, $81, $FF, $FF
    db $85, $85, $87, $87
    ds $10, $FF
    db $88, $88, $88, $88, $81, $81, $81, $81, $88, $88, $81, $81, $7A, $7A, $87, $87
    db $87, $87, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $9B, $9B, $85, $85, $FF, $FF, $FF, $FF, $85, $85
    ds $14, $FF
    INCBIN "dwm2-cobi-us.gbc", $0E9CDB, $4C
    ds $14, $81
    db $85, $85, $FF, $FF, $9A, $9A, $86, $86, $FF, $FF, $86, $87, $FF, $FF, $88, $88
    db $FF, $FF, $FF, $FF

Data_03A_5D4F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $84, $84
    ds $9E, $FF
    ds $30, $84
    db $FF, $FF
    ds $10, $84
    ds $72, $FF
    db $84, $84
    ds $1C, $FF
    db $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $84, $84
    db $84, $84, $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $82, $82
    db $FF, $FF, $FF, $FF, $FF, $FF, $84, $84, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $84, $84, $84, $84, $84, $84, $84, $84, $FF, $FF, $84, $84, $84, $84
    ds $16, $FF

Data_03A_5F17:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $BE, $FF
    db $88, $88, $88, $88, $88, $88
    ds $16, $FF
    db $81, $81, $FF, $FF, $81, $81, $81, $81
    ds $BE, $FF

Data_03A_60B7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF
    ds $18, $85
    ds $2A, $FF
    db $87, $FF, $86, $FF, $81, $FF, $81, $FF, $81, $FF, $81, $FF

Data_03A_6107:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $32, $FF
    db $85, $FF, $85, $FF, $85, $FF, $85, $FF, $88, $88, $85, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $93, $FF, $97, $FF, $96, $FF, $96, $FF

; 2 call sites from 2 routines (e.g. Func_031_4365, Func_0A0_5278)
; reads: wC52B, wD802, wC58A, wCFCA
Func_03A_6157::
    ld a, [wC52B]
    or a, a
    ret nz
    call Func_03A_66A9
    ld a, [wD802]
    cp a, $FF
    jr z, Jump_03A_6172
    ld a, [wC58A]
    or a, a
    ret nz
    farcall Func_03A_4ADB
    ret

Jump_03A_6172::
    ld a, [wCFCA]
    rst $00
    dw Jump_03A_618C
    dw Jump_03A_6193
    dw Jump_03A_619A
    dw Jump_03A_61AE
    dw Func_03A_61F8
    dw Jump_03A_6269
    dw Jump_03A_62A3
    dw Jump_03A_6300
    dw Jump_03A_6408
    dw Jump_03A_640F
    dw Jump_03A_6698

Jump_03A_618C::
    farcall Func_032_4ADC
    ret

Jump_03A_6193::
    farcall Func_036_4001
    ret

Jump_03A_619A::
    ld a, [wD8A6]
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    farcall Func_01A_4001
    call Func_03A_69AA
    ret

Jump_03A_61AE::
    ld a, [wCFF2]
    cp a, $80
    jr z, Jump_03A_61CB
    and a, $0F
    cp a, $02
    jr z, Jump_03A_61CB
    cp a, $04
    jr z, Jump_03A_61D7
    ld a, [wD8A6]
    cp a, $63
    jr z, Jump_03A_61F4
    ld hl, wCFCA
    inc [hl]
    ret

Jump_03A_61CB::
    ld a, [wDAB2]
    or a, a
    jp z, Func_03A_6711
    ld hl, wCFCA
    inc [hl]
    ret

Jump_03A_61D7::
    ld a, [wD8A6]
    cp a, $64
    jr z, Jump_03A_61F4
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_03A_61F0
    ld hl, wCFCA
    inc [hl]
    ret

Jump_03A_61F0::
    call Func_03A_6814
    ret

Jump_03A_61F4::
    call Func_03A_6846
    ret

; 1 call site from 1 routine (e.g. Func_03A_68C9)
; reads: wD8A6, wD8A4, wDABA
; writes: wC982, wC983, wCFCA, wCFCB, wCFCC
; points at: wCFCA, wCFCF, wD812
Func_03A_61F8::
    ld a, [wD8A6]
    cp a, $4E
    jr z, Jump_03A_6211
    cp a, $4F
    jr z, Jump_03A_6211
    cp a, $B9
    jr z, Jump_03A_6230
    cp a, $15
    jr z, Jump_03A_624F
    cp a, $D6
    jr z, Jump_03A_6245
    jr Jump_03A_6264

Jump_03A_6211::
    ld a, [wDABA]
    or a, a
    jr z, Jump_03A_6264
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr z, Jump_03A_6264
    res 0, [hl]
    ld d, $81
    farcall Func_03A_7193
    jr Jump_03A_6264

Jump_03A_6230::
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    res 0, [hl]
    ld d, $86
    farcall Func_03A_7193
    jr Jump_03A_6264

Jump_03A_6245::
    ld a, [wD8A4]
    ld [wC982], a
    xor a, a
    ld [wC983], a

Jump_03A_624F::
    ld a, $01
    ld [wCFCA], a
    ld a, $0E
    ld [wCFCB], a
    ld a, $00
    ld [wCFCC], a
    ld hl, wCFCF
    set 0, [hl]
    ret

Jump_03A_6264::
    ld hl, wCFCA
    inc [hl]
    ret

Jump_03A_6269::
    ld a, [wDAB2]
    or a, a
    jr z, Jump_03A_629F
    xor a, a
    ld [wDAB2], a
    ld a, $01
    ld [wC970], a
    ld a, [wD8A5]
    call Func_03A_7D6A
    jr c, Jump_03A_629F
    ld hl, wD812
    call AddAx9ToHL
    bit 1, [hl]
    jr z, Jump_03A_629F
    ld hl, wCFC9
    inc [hl]
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ld d, $7E
    farcall Func_03A_7193
    ret

Jump_03A_629F::
    ld hl, wCFCA
    inc [hl]

Jump_03A_62A3::
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_62FC
    ld hl, wD810
    call AddAx9ToHL
    bit 6, [hl]
    jr z, Jump_03A_62FC
    res 6, [hl]
    ld a, [wCFF5]
    bit 4, a
    jr z, Jump_03A_62FC
    call Func_03A_639A
    jr nc, Jump_03A_62C5
    jr Jump_03A_62FC

Jump_03A_62C5::
    xor a, a
    ld [wDAD2], a
    ld a, $FF
    ld [wD802], a
    xor a, a
    ld [wDABA], a
    xor a, a
    ld [wDABF], a
    xor a, a
    ld [wDABD], a
    ld a, $FF
    ld [wDAD1], a
    xor a, a
    ld [wCFCA], a
    ld a, $01
    ld [wCFCB], a
    ld a, $04
    ld [wCFCC], a
    xor a, a
    ld [wDABA], a
    farcall Func_030_4102
    ld a, d
    ld [wD8A5], a
    ret

Jump_03A_62FC::
    ld hl, wCFCA
    inc [hl]

Jump_03A_6300::
    xor a, a
    ld [wDABD], a
    xor a, a
    ld [wDABE], a
    xor a, a
    ld [wCFCF], a
    call Func_03A_639A
    jr nc, Jump_03A_6322
    ld hl, wCFC8
    inc [hl]
    xor a, a
    ld [wCFC9], a
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_03A_6322::
    ld a, [wD89E]
    ld hl, wD895
    add_a_to_hl
    ld a, [hl]
    cp a, $10
    jr z, Jump_03A_635F
    ld a, [wD8A4]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    push hl
    ld a, [wD8A4]
    ld hl, wDA1C
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $CC
    jr nz, Jump_03A_635E
    ld a, [wD8A4]
    ld hl, wD810
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a

Jump_03A_635E::
    pop hl

Jump_03A_635F::
    ld a, [wD89E]
    inc a
    ld [wD89E], a
    cp a, $09
    jr nc, Jump_03A_6390
    ld a, [wD89E]
    ld hl, wD895
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_6390
    cp a, $10
    jr z, Jump_03A_6383
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_635F

Jump_03A_6383::
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ret

Jump_03A_6390::
    ld a, $09
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

; 5 call sites from 4 routines (e.g. Func_03A_61F8, Func_03A_6533, Func_03A_6C46, Func_03A_69AA)
; reads: wD8A6, wDABA
Func_03A_639A::
    ld a, [wD8A6]
    cp a, $BD
    jr nz, Jump_03A_63AA
    ld a, [wDABA]
    and a, $7F
    jr z, Jump_03A_63AA
    xor a, a
    ret

Jump_03A_63AA::
    call Func_03A_63B2
    ret c
    call Func_03A_63D2
    ret

; 1 call site from 1 routine (e.g. Func_03A_639A)
; reads: wC58A, wC57F
Func_03A_63B2::
    ld c, $00
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_63C4
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_63C4
    ld c, $04

Jump_03A_63C4::
    call Func_03A_63F7
    ret nc
    inc c
    call Func_03A_63F7
    ret nc
    inc c
    call Func_03A_63F7
    ret

; 1 call site from 1 routine (e.g. Func_03A_639A)
; reads: wC58A, wC57F
Func_03A_63D2::
    ld c, $04
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_63E6
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_63C4
    ld c, $00
    jr Jump_03A_63C4

Jump_03A_63E6::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret nc
    inc c
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret nc
    inc c
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret

; 3 call sites from 1 routine (e.g. Func_03A_63B2)
; points at: wD80C
Func_03A_63F7::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret c
    ld a, c
    ld hl, wD80C
    call AddAx9ToHL
    bit 6, [hl]
    ret z
    scf
    ret

Jump_03A_6408::
    farcall Func_03B_42F4
    ret

Jump_03A_640F::
    ld a, [wCFCB]
    rst $00
    dw Jump_03A_6421
    dw Jump_03A_6480
    dw Jump_03A_64AF
    dw Jump_03A_6584
    dw Jump_03A_65A4
    dw Jump_03A_6665
    dw Jump_03A_6677

Jump_03A_6421::
    ld hl, wCFCB
    inc [hl]
    ld hl, wD80A
    ld a, [hl]
    and a, $AF
    ld [hl+], a
    ld a, [hl]
    and a, $AF
    ld [hl], a
    ld hl, wD864
    ld a, [hl]
    and a, $03
    ld [hl+], a
    ld a, [hl]
    and a, $03
    ld [hl], a
    ld b, $09
    ld hl, wD80C

Jump_03A_6440::
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    rrca
    and a, $55
    ld [hl+], a
    ld a, [hl]
    and a, $30
    jr z, Jump_03A_6458
    ld a, [hl]
    and a, $CF
    ld e, a
    ld a, [hl]
    rrca
    and a, $10
    or a, e
    ld [hl], a

Jump_03A_6458::
    inc hl
    ld a, [hl]
    and a, $C0
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld a, [hl]
    and a, $03
    jr z, Jump_03A_646E
    ld a, [hl]
    and a, $FC
    ld e, a
    ld a, [hl]
    rrca
    and a, $01
    or a, e
    ld [hl], a

Jump_03A_646E::
    inc hl
    dec b
    jr nz, Jump_03A_6440
    xor a, a
    ld [wD8A4], a
    call CarryUnlessWDA63SlotEmpty
    ret nc
    ld a, $04
    ld [wCFCB], a
    ret

Jump_03A_6480::
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD811
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld d, a
    ld a, [hl]
    and a, $C0
    jr z, Jump_03A_64AE
    push hl
    push de
    sub a, $40
    jr nz, Jump_03A_64A5
    ld d, $84
    farcall Func_03A_7193
    xor a, a

Jump_03A_64A5::
    pop de
    pop hl
    or a, d
    ld [hl], a
    ld a, $04
    ld [wCFCB], a

Jump_03A_64AE::
    ret

Jump_03A_64AF::
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A4]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    ret z
    bit 0, a
    jr nz, Jump_03A_64D1
    ld b, $06
    ld a, $89
    ld [wD868], a
    jr Jump_03A_64D8

Jump_03A_64D1::
    ld b, $10
    ld a, $88
    ld [wD868], a

Jump_03A_64D8::
    ld a, [wD8A4]
    ld [wD8A5], a
    call Func_03A_64F8
    call Func_03A_6533
    ld a, [wD868]
    ld d, a
    farcall Func_03A_7193
    ld a, [wD871]
    or a, a
    ret z
    ld hl, wCFCB
    dec [hl]
    ret

; 1 call site from 1 routine (e.g. Func_03A_63F7)
; reads: wD8A4
; writes: wD872, wD873
Func_03A_64F8::
    push bc
    ld a, [wD8A4]
    call Func_03A_7C66
    ld a, b
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, Jump_03A_650A
    ld hl, $0001

Jump_03A_650A::
    pop bc
    ld a, b
    cp a, $06
    jr z, Jump_03A_651E
    ld a, h
    or a, a
    jr nz, Jump_03A_6519
    ld a, l
    cp a, $32
    jr c, Jump_03A_652A

Jump_03A_6519::
    ld hl, $0032
    jr Jump_03A_652A

Jump_03A_651E::
    ld a, h
    or a, a
    jr nz, Jump_03A_6527
    ld a, l
    cp a, $96
    jr c, Jump_03A_652A

Jump_03A_6527::
    ld hl, $0096

Jump_03A_652A::
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_63F7)
; reads: wD8A4, wD872, wD873, wD868
; writes: wD871, wD868, wDABE
; points at: wD8BF
Func_03A_6533::
    xor a, a
    ld [wD871], a
    ld a, [wD8A4]
    ld hl, wD8BF
    call Func_03A_7C93
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
    jr c, Jump_03A_655A
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, Jump_03A_657D
    inc hl

Jump_03A_655A::
    ld a, [hl-]
    ld b, a
    ld c, [hl]
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wD8A4]
    call Func_03A_7D06
    ld a, [wD868]
    push af
    farcall Func_032_5B12
    pop af
    ld [wD868], a
    xor a, a
    ld [wDABE], a
    ld a, $01
    ld [wD871], a

Jump_03A_657D::
    ld a, [wD8A4]
    call Func_03A_7CEC
    ret

Jump_03A_6584::
    ld hl, wCFCB
    inc [hl]
    farcall Func_032_5AB3
    ld d, $90
    farcall Func_03A_7193
    call Func_03A_639A
    ret nc
    ld a, $0A
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_03A_65A4::
    ld hl, wD8A4
    inc [hl]
    ld a, [hl]
    cp a, $08
    jr z, Jump_03A_65B8
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_65A4
    ld a, $01
    ld [wCFCB], a
    ret

Jump_03A_65B8::
    ld hl, wDA5B
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld b, $03
    ld c, $00
    ld d, $00
    call Func_03A_6650
    ld b, $01
    ld d, $01
    call Func_03A_6650
    ld b, $03
    ld c, $04
    ld d, $00
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_65E2
    ld d, $01

Jump_03A_65E2::
    call Func_03A_6650
    ld b, $01
    ld d, $01
    call Func_03A_6650
    ld hl, wD891
    ld a, [hl]
    cp a, $FF
    jr z, Jump_03A_65F5
    inc [hl]

Jump_03A_65F5::
    ld a, [wC58A]
    or a, a
    jr z, Jump_03A_6631
    cp a, $02
    jr z, Jump_03A_6631
    ld a, [wD043]
    or a, a
    jr z, Jump_03A_6631
    ld a, [wD04B]
    bit 7, a
    jr z, Jump_03A_6631
    res 7, a
    sub a, [hl]
    jr nc, Jump_03A_6619
    ld hl, wCFCB
    inc [hl]
    ld a, $62
    jr Jump_03A_663E

Jump_03A_6619::
    inc a
    ld c, a
    ld b, $00
    ld hl, wC130
    call Func_000_2F84
    ld hl, wC130
    ld a, [hl]
    cp a, $01
    ld a, $61
    jr nz, Jump_03A_662F
    ld a, $88

Jump_03A_662F::
    jr Jump_03A_663E

Jump_03A_6631::
    xor a, a
    ld [wCFC9], a
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_03A_663E::
    ld [wC529], a
    xor a, a
    ld [wC528], a
    farcall Func_02F_4001
    ld hl, wCFCB
    inc [hl]
    ret

; 4 call sites from 1 routine (e.g. Func_03A_6533)
; points at: wDA5B
Func_03A_6650::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_6660
    ld a, c
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], d

Jump_03A_6660::
    inc c
    dec b
    jr nz, Func_03A_6650
    ret

Jump_03A_6665::
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wCFC9], a
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_03A_6677::
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $02
    ld [wCFC8], a
    ld a, $08
    ld [wCFC9], a
    xor a, a
    ld [wCFCA], a
    ld [wCFCB], a
    ld a, $80
    ld [wD092], a
    ld a, $42
    call Func_000_122D
    ret

Jump_03A_6698::
    ld hl, wCFC8
    inc [hl]
    xor a, a
    ld [wCFC9], a
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

; 2 call sites from 2 routines (e.g. Func_03A_6157, Func_03A_68C9)
; reads: wC58A, wC57F, wD88F
; points at: wD095
Func_03A_66A9::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_66B7
    ld a, [wC57F]
    bit 1, a
    jr nz, Jump_03A_66BF

Jump_03A_66B7::
    ld a, [wD88F]
    ld b, a
    ld c, $00
    jr Jump_03A_66C5

Jump_03A_66BF::
    ld a, [wD88F]
    ld b, a
    ld c, $04

Jump_03A_66C5::
    push bc
    ld a, c
    ld hl, wD095
    add_a_to_hl
    bit 0, [hl]
    jr z, Jump_03A_66E3
    push hl
    farcall Func_031_7806
    farcall Func_031_7914
    pop hl
    res 0, [hl]

Jump_03A_66E3::
    bit 1, [hl]
    jr z, Jump_03A_66F7
    push hl
    farcall Func_031_785F
    farcall Func_031_7965
    pop hl
    res 1, [hl]

Jump_03A_66F7::
    bit 2, [hl]
    jr z, Jump_03A_670B
    push hl
    farcall Func_031_76AE
    farcall Func_031_77B9
    pop hl
    res 2, [hl]

Jump_03A_670B::
    pop bc
    inc c
    dec b
    jr nz, Jump_03A_66C5
    ret

; 1 call site from 1 routine (e.g. Func_03A_68C9)
; reads: wD8A4
; writes: wD8A5, wCFCA, wCFCB
; points at: wDA1D
Func_03A_6711::
    call Func_03A_6731
    ret z
    ld a, c
    ld [wD8A5], a
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld [hl], c
    ld a, $01
    ld [wCFCA], a
    ld a, $00
    ld [wCFCB], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_6711)
; reads: wDABA, wD8A6, wD8A4
; writes: wDABA, wC982, wC983, wCFCA, wCFCB, wCFCC
; points at: wCFCA, wCFCF
Func_03A_6731::
    ld a, [wDABA]
    bit 7, a
    jr nz, Jump_03A_6743
    call Func_03A_6785
    ld a, [wDABA]
    or a, $80
    ld [wDABA], a

Jump_03A_6743::
    call Func_03A_67D8
    ld a, [wDABA]
    and a, $7F
    ret nz
    ld a, [wD8A6]
    cp a, $15
    jr z, Jump_03A_676F
    cp a, $20
    jr z, Jump_03A_676F
    cp a, $7B
    jr z, Jump_03A_676F
    cp a, $D6
    jr z, Jump_03A_6765
    ld hl, wCFCA
    inc [hl]
    jr Jump_03A_6783

Jump_03A_6765::
    ld a, [wD8A4]
    ld [wC982], a
    xor a, a
    ld [wC983], a

Jump_03A_676F::
    ld a, $01
    ld [wCFCA], a
    ld a, $0E
    ld [wCFCB], a
    ld a, $00
    ld [wCFCC], a
    ld hl, wCFCF
    set 0, [hl]

Jump_03A_6783::
    xor a, a
    ret

; 1 call site from 1 routine (e.g. Func_03A_6731)
; reads: wCFF2, wD8A5, wD8A6
; points at: wDABA
Func_03A_6785::
    ld b, $04
    ld a, [wCFF2]
    cp a, $80
    jr nz, Jump_03A_6790
    ld b, $08

Jump_03A_6790::
    ld a, [wD8A5]
    and a, $04
    ld c, a

Jump_03A_6796::
    ld a, [wD8A5]
    cp a, c
    jr z, Jump_03A_67B9
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_67B9
    jr z, Jump_03A_67BD
    ld a, [wD8A6]
    cp a, $20
    jr z, Jump_03A_67B9
    cp a, $7B
    jr z, Jump_03A_67B9
    cp a, $CE
    jr z, Jump_03A_67B9
    cp a, $BB
    jr z, Jump_03A_67B9
    jr Jump_03A_67BD

Jump_03A_67B9::
    ld hl, wDABA
    inc [hl]

Jump_03A_67BD::
    inc c
    dec b
    ld a, [wCFF2]
    cp a, $80
    jr nz, Jump_03A_67D3
    ld a, b
    cp a, $04
    jr nz, Jump_03A_67D3
    ld a, [wD8A5]
    and a, $04
    xor a, $04
    ld c, a

Jump_03A_67D3::
    ld a, b
    or a, a
    jr nz, Jump_03A_6796
    ret

; 1 call site from 1 routine (e.g. Func_03A_6731)
; reads: wD8A5, wCFF2, wD8A6
; points at: wDABA
Func_03A_67D8::
    ld a, [wD8A5]
    inc a
    ld c, a
    ld hl, wDABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    ret z

Jump_03A_67E5::
    ld a, [wCFF2]
    cp a, $80
    jr nz, Jump_03A_67FB
    ld a, c
    and a, $03
    jr nz, Jump_03A_67FB
    ld a, [wD8A5]
    and a, $04
    xor a, $04
    ld c, a
    jr nz, Jump_03A_67FB

Jump_03A_67FB::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    ret nc
    jr z, Jump_03A_6811
    ld a, [wD8A6]
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $CE
    ret z
    cp a, $BB
    ret z

Jump_03A_6811::
    inc c
    jr Jump_03A_67E5

; 2 call sites from 2 routines (e.g. Func_03A_68C9, Func_03A_6157)
; reads: wDABA, wC58A, wD8A4, wD8A6, wD8A5
; writes: wDABA, wD8A5, wCFCA, wCFCB
; points at: wDABA, wDAD8, wCFCA
Func_03A_6814::
    ld a, [wDABA]
    bit 7, a
    jp nz, Jump_03A_6877
    ld hl, $0001
    ld bc, $0004
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_6832
    ld a, [wD8A4]
    cp a, $04
    jr c, Jump_03A_6832
    ld c, $03

Jump_03A_6832::
    ld a, [wD8A6]
    cp a, $4E
    jr z, Jump_03A_683B
    sla c

Jump_03A_683B::
    call Func_000_3E98
    ld a, e
    or a, $80
    ld [wDABA], a
    jr Jump_03A_688F

; 2 call sites from 2 routines (e.g. Func_03A_68C9, Func_03A_6157)
; reads: wD8A4, wDABA, wD8A6, wD8A5
; writes: wDABA, wCFCA, wCFCB, wD8A5
; points at: wCFCA, wDAD8, wDABA
Func_03A_6846::
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_6855
    ld a, $80
    ld [wDABA], a
    jr Jump_03A_68A4

Jump_03A_6855::
    ld a, [wDABA]
    bit 7, a
    jp nz, Jump_03A_6877
    ld a, [wD8A6]
    cp a, $63
    ld a, $81
    jr z, Jump_03A_6868
    ld a, $83

Jump_03A_6868::
    ld [wDABA], a
    jr nz, Jump_03A_68A9
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_6899
    jr Jump_03A_68A4

Jump_03A_6877::
    ld hl, wDABA
    dec [hl]
    ld a, [hl]
    and a, $7F
    jr z, Jump_03A_68A4
    ld a, [wD8A6]
    cp a, $63
    jr nz, Jump_03A_68A9
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr nc, Jump_03A_6899

Jump_03A_688F::
    farcall Func_030_4102
    ld a, d
    ld [wD8A5], a

Jump_03A_6899::
    ld a, $01
    ld [wCFCA], a
    ld a, $01
    ld [wCFCB], a
    ret

Jump_03A_68A4::
    ld hl, wCFCA
    inc [hl]
    ret

Jump_03A_68A9::
    ld a, [wD8A4]
    ld hl, wDAD8
    add_a_to_hl
    push hl
    ld a, [hl]
    push af
    or a, $80
    ld [hl], a
    farcall Func_030_4102
    ld a, d
    ld [wD8A5], a
    pop af
    pop hl
    ld [hl], a
    jr Jump_03A_6899

; 2 call sites from 2 routines (e.g. Func_031_4365, Func_0A0_5278)
; reads: wC52B, wD802, wC58A, wCFCA
Func_03A_68C9::
    ld a, [wC52B]
    or a, a
    ret nz
    call Func_03A_66A9
    ld a, [wD802]
    cp a, $FF
    jr z, Jump_03A_68E4
    ld a, [wC58A]
    or a, a
    ret nz
    farcall Func_03A_4ADB
    ret

Jump_03A_68E4::
    ld a, [wCFCA]
    rst $00
    dw Jump_03A_68F4
    dw Jump_03A_68FB
    dw Jump_03A_6902
    dw Jump_03A_6906
    dw Jump_03A_6944
    dw Jump_03A_6948

Jump_03A_68F4::
    farcall Func_032_5820
    ret

Jump_03A_68FB::
    farcall Func_036_4001
    ret

Jump_03A_6902::
    call Func_03A_69AA
    ret

Jump_03A_6906::
    ld a, [wCFF2]
    and a, $0F
    cp a, $02
    jr z, Jump_03A_691F
    cp a, $04
    jr z, Jump_03A_6923
    ld a, [wD8A6]
    cp a, $63
    jr z, Jump_03A_6940
    ld hl, wCFCA
    inc [hl]
    ret

Jump_03A_691F::
    call Func_03A_6711
    ret

Jump_03A_6923::
    ld a, [wD8A6]
    cp a, $64
    jr z, Jump_03A_6940
    ld a, [wD8A4]
    ld hl, wD812
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, Jump_03A_693C
    ld hl, wCFCA
    inc [hl]
    ret

Jump_03A_693C::
    call Func_03A_6814
    ret

Jump_03A_6940::
    call Func_03A_6846
    ret

Jump_03A_6944::
    call Func_03A_61F8
    ret

Jump_03A_6948::
    ld hl, wDAC9
    ld a, [hl+]
    ld [wD8A4], a
    ld a, [hl+]
    ld [wD8A5], a
    ld a, [hl+]
    ld [wDABA], a
    ld a, [wD8A4]
    ld de, wDA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6963
    inc d

Jump_03A_6963::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wD8A5]
    ld de, wDA1C
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6974
    inc d

Jump_03A_6974::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wD8A5]
    ld de, wDA5B
    add a, e
    ld e, a
    jr nc, Jump_03A_6984
    inc d

Jump_03A_6984::
    ld a, [hl]
    ld [de], a
    xor a, a
    ld [wDABD], a
    ld hl, wCFC9
    dec [hl]
    ld a, $03
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    ld a, [wC970]
    or a, a
    ret z
    xor a, a
    ld [wC970], a
    ld a, $06
    ld [wCFCA], a
    ret

; 2 call sites from 2 routines (e.g. Func_03A_68C9, Func_03A_6157)
; reads: wCFCB
Func_03A_69AA::
    ld a, [wCFCB]
    rst $00
    dw Jump_03A_69C2
    dw Jump_03A_6A60
    dw Jump_03A_6ABC
    dw Jump_03A_6AEC
    dw Jump_03A_6AFE
    dw Jump_03A_6BF1
    dw Jump_03A_6BF8
    dw Jump_03A_6C52
    dw Jump_03A_6C5E
    dw Jump_03A_6C76

Jump_03A_69C2::
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A5]
    ld hl, wD80E
    call AddAx9ToHL
    bit 0, [hl]
    jp z, Jump_03A_6A60
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jp c, Jump_03A_6A60
    ld a, [wCFF5]
    bit 0, a
    jr z, Jump_03A_6A60
    ld a, [wDABD]
    bit 2, a
    jr z, Jump_03A_69F2
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_03A_6A60

Jump_03A_69F2::
    ld a, [wD8A5]
    call Func_03A_7C6B
    push hl
    ld a, [wD8A5]
    call Func_03A_7C75
    pop bc
    call CompareHLToBC
    jr z, Jump_03A_6A60
    ld a, [wD872]
    ld e, a
    ld a, [wD873]
    ld d, a
    push de
    ld a, [wCFEE]
    ld e, a
    ld d, $00
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    add hl, de
    call CompareHLToBC
    jr c, Jump_03A_6A3A
    jr z, Jump_03A_6A3A
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ld h, b
    ld l, c

Jump_03A_6A3A::
    push hl
    ld a, [wD8A5]
    ld hl, wD8DF
    call Func_03A_7C93
    pop bc
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wD8A5]
    call Func_03A_7CF9
    ld d, $40
    farcall Func_03A_7193
    pop de
    ld a, e
    ld [wD872], a
    ld a, d
    ld [wD873], a
    ret

Jump_03A_6A60::
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A5]
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_6AB6
    ld a, [wCFF5]
    bit 3, a
    jr z, Jump_03A_6AB6
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_03A_6AB6
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    and a, $90
    jr z, Jump_03A_6AB6
    push hl
    call Func_000_3ED4
    call Func_03A_6C7A
    pop hl
    jr nc, Jump_03A_6AB6
    bit 7, [hl]
    jr z, Jump_03A_6ABC
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld a, [wD8A5]
    call Func_03A_7D06
    ld d, $82
    farcall Func_03A_7193
    ret

Jump_03A_6AB6::
    ld hl, wCFCB
    inc [hl]
    jr Jump_03A_6AEC

Jump_03A_6ABC::
    ld hl, wCFCB
    inc [hl]
    ld a, [wD8A5]
    ld hl, wD80C
    call AddAx9ToHL
    ld a, [hl]
    bit 4, [hl]
    jr z, Jump_03A_6AEC
    res 4, [hl]
    ld a, [wD8A5]
    ld hl, wDA5B
    add_a_to_hl
    ld [hl], $03
    ld a, [wD8A5]
    call Func_03A_7D06
    ld d, $83
    farcall Func_03A_7193
    ret

Jump_03A_6AEC::
    ld hl, wCFCB
    inc [hl]
    call Func_03A_639A
    jr nc, Jump_03A_6AFE
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    ret

Jump_03A_6AFE::
    ld a, [wDABD]
    or a, a
    jp nz, Jump_03A_6BE8
    ld a, [wD8A5]
    ld hl, wD813
    call AddAx9ToHL
    bit 2, [hl]
    jp z, Jump_03A_6BE8
    ld a, [wCFF3]
    bit 7, a
    jp z, Jump_03A_6BE8
    ld a, [wD8A4]
    call CarryUnlessWDA63SlotEmpty
    jp c, Jump_03A_6BE8
    ld a, [wD8A5]
    call Func_000_3E25
    jp c, Jump_03A_6BE8
    ld a, [wDAC0]
    bit 4, a
    jp z, Jump_03A_6BE8
    ld a, [wD8A5]
    ld hl, wD854
    call Func_03A_7C93
    ld a, [hl]
    and a, $08
    ld [wD868], a
    push hl
    ld a, [wD8A5]
    ld hl, wD813
    call AddAx9ToHL
    bit 3, [hl]
    jr z, Jump_03A_6B66
    pop hl
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    add hl, hl
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a
    jr Jump_03A_6B7B

Jump_03A_6B66::
    pop hl
    ld a, [wD872]
    ld l, a
    ld a, [wD873]
    ld h, a
    srl h
    rr l
    ld a, l
    ld [wD872], a
    ld a, h
    ld [wD873], a

Jump_03A_6B7B::
    ld a, h
    or a, l
    jr z, Jump_03A_6B86
    ld a, $11
    ld [wDAD2], a
    jr Jump_03A_6B8B

Jump_03A_6B86::
    ld a, $10
    ld [wDAD2], a

Jump_03A_6B8B::
    ld hl, wD8A4
    ld a, [hl+]
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wDAD2]
    bit 0, a
    jr z, Jump_03A_6BB9
    ld a, [wD868]
    or a, a
    jr z, Jump_03A_6BAB
    ld d, $31
    farcall Func_03A_6EE5
    jr Jump_03A_6BCF

Jump_03A_6BAB::
    call Func_000_3ED4
    ld a, [wC5E7]
    and a, $01
    jr nz, Jump_03A_6BB9
    ld d, $7C
    jr Jump_03A_6BBB

Jump_03A_6BB9::
    ld d, $7D

Jump_03A_6BBB::
    farcall Func_03A_7193
    ld a, [wDAD2]
    bit 0, a
    jr z, Jump_03A_6BD8
    ld a, [wC5E7]
    and a, $01
    jr nz, Jump_03A_6BD8

Jump_03A_6BCF::
    ld hl, wCFCB
    inc [hl]
    xor a, a
    ld [wCFCC], a
    ret

Jump_03A_6BD8::
    ld a, [wD8A4]
    ld l, a
    ld a, [wD8A5]
    ld h, a
    ld a, l
    ld [wD8A5], a
    ld a, h
    ld [wD8A4], a

Jump_03A_6BE8::
    ld hl, wCFCB
    inc [hl]
    ld hl, wCFCB
    inc [hl]
    ret

Jump_03A_6BF1::
    farcall Func_032_6662
    ret

Jump_03A_6BF8::
    ld hl, wCFCB
    inc [hl]
    ld a, [wDAD1]
    cp a, $FF
    jr z, Jump_03A_6C17
    ld [wD8A5], a
    ld b, a
    ld a, [wD8A4]
    ld hl, wDA1D
    call Func_03A_7C93
    ld [hl], b
    ld a, $FF
    ld [wDAD1], a
    ret

Jump_03A_6C17::
    ld a, [wCFC9]
    cp a, $04
    jr z, Jump_03A_6C52
    ld a, [wDABD]
    or a, a
    jr z, Jump_03A_6C52
    xor a, a
    ld [wDABD], a
    ld hl, wDAC9
    ld a, [hl+]
    ld [wD8A4], a
    ld a, [hl+]
    ld [wD8A5], a
    ld a, [hl+]
    ld [wDABA], a
    ld a, [wD8A4]
    ld de, wDA1C
    call Func_03A_6C46
    ld a, [wD8A5]
    ld de, wDA1C

; 1 call site from 1 routine (e.g. Func_03A_69AA)
Func_03A_6C46::
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_03A_6C4C
    inc d

Jump_03A_6C4C::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

Jump_03A_6C52::
    ld a, [wDABE]
    or a, a
    call nz, Func_03A_6C93
    ld hl, wCFCB
    inc [hl]
    ret

Jump_03A_6C5E::
    call Func_03A_639A
    jr c, Jump_03A_6C68
    ld hl, wCFCB
    inc [hl]
    ret

Jump_03A_6C68::
    xor a, a
    ld [wDABA], a
    ld a, $04
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    ret

Jump_03A_6C76::
    call Func_03A_6CD4
    ret

; 1 call site from 1 routine (e.g. Func_03A_69AA)
; reads: wC58A, wD8A5, wC5E7
Func_03A_6C7A::
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_6C8C
    ld a, [wD8A5]
    cp a, $04
    jr c, Jump_03A_6C8C
    ld b, $40
    jr Jump_03A_6C8E

Jump_03A_6C8C::
    ld b, $80

Jump_03A_6C8E::
    ld a, [wC5E7]
    cp a, b
    ret

; 1 call site from 1 routine (e.g. Func_03A_6C46)
; reads: wDABE
Func_03A_6C93::
    ld a, [wDABE]
    dec a
    rst $00
    dw Jump_03A_6CAC
    dw Jump_03A_6CB7
    dw Jump_03A_6CC2
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC6
    dw Jump_03A_6CC7
    dw Jump_03A_6CC6

Jump_03A_6CAC::
    call Func_03A_7CB5
    ld d, $85
    jr c, Jump_03A_6CC9
    ld d, $E8
    jr Jump_03A_6CC9

Jump_03A_6CB7::
    call Func_03A_7CB5
    ld d, $80
    jr c, Jump_03A_6CC9
    ld d, $E7
    jr Jump_03A_6CC9

Jump_03A_6CC2::
    ld d, $AC
    jr Jump_03A_6CC9

Jump_03A_6CC6::
    ret

Jump_03A_6CC7::
    ld d, $7F

Jump_03A_6CC9::
    farcall Func_03A_7193
    xor a, a
    ld [wDABE], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_6C46)
; reads: wCFC9, wDABD, wD8A5, wCFF5, wD8A6, wD8A4, wC981, wDAC0
; writes: wCFCA, wCFCB, wCFCC, wC981, wDABD
; points at: wD812, wCFC9, wCFCA
Func_03A_6CD4::
    ld a, [wCFC9]
    cp a, $04
    jr z, Jump_03A_6D45
    ld a, [wDABD]
    or a, a
    jr nz, Jump_03A_6D39
    ld a, [wD8A5]
    call Func_03A_7D6A
    jr c, Jump_03A_6D45
    ld hl, wD812
    call AddAx9ToHL
    bit 3, [hl]
    jr z, Jump_03A_6D45
    ld a, [wCFF5]
    bit 2, a
    jr z, Jump_03A_6D3D
    ld a, [wD8A6]
    cp a, $6C
    jr nz, Jump_03A_6D11
    ld a, [wD8A4]
    and a, $04
    ld l, a
    ld a, [wD8A5]
    and a, $04
    add a, l
    and a, $04
    jr z, Jump_03A_6D45

Jump_03A_6D11::
    ld a, [wC981]
    cp a, $01
    jr z, Jump_03A_6D45
    ld a, [wDAC0]
    bit 4, a
    jr z, Jump_03A_6D45
    ld d, $7A
    farcall Func_03A_7193
    ld hl, wCFC9
    inc [hl]
    xor a, a
    ld [wCFCA], a
    xor a, a
    ld [wCFCB], a
    xor a, a
    ld [wCFCC], a
    xor a, a
    ret

Jump_03A_6D39::
    xor a, a
    ld [wDABD], a

Jump_03A_6D3D::
    ld d, $7B
    farcall Func_03A_7193

Jump_03A_6D45::
    xor a, a
    ld [wC981], a
    ld hl, wCFCA
    inc [hl]
    xor a, a
    ld [wCFCB], a
    scf
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD895
Func_03A_6D53:: ; heuristic: follows a terminator; C0
    ld hl, wD895
    ld b, $08
    ld d, $00

Jump_03A_6D5A::
    bit 0, d
    jr nz, Jump_03A_6D64
    ld a, [hl]
    cp a, c
    jr nz, Jump_03A_6D71
    ld d, $01

Jump_03A_6D64::
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, Jump_03A_6D5A
    ld [hl], $FF
    ret

Jump_03A_6D71::
    inc hl
    dec b
    jr nz, Jump_03A_6D5A
    ret

; 2 call sites from 2 routines (e.g. Func_032_543C, Func_032_5820)
; reads: wD8A6
; writes: wC529, wC528
Func_03A_6D76::
    ld a, [wD8A6]
    ld hl, Data_03A_6DAA
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    ld a, [wD8A6]
    cp a, $CF
    call z, Func_03A_6D91
    jp Func_03A_7193

; 1 call site from 1 routine (e.g. Func_03A_6D76)
; reads: wC5E7
; writes: wC96F
Func_03A_6D91::
    call Func_000_3ED4
    ld a, [wC5E7]
    cp a, $80
    jr c, Jump_03A_6DA2
    xor a, a
    ld [wC96F], a
    ld d, $91
    ret

Jump_03A_6DA2::
    ld a, $01
    ld [wC96F], a
    ld d, $D6
    ret

Data_03A_6DAA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00
    ds $3C, $01
    INCBIN "dwm2-cobi-us.gbc", $0EADE7, $AB

; 2 call sites from 2 routines (e.g. Func_03B_42F4, Func_03B_4373)
; reads: wD8A6
; writes: wC529, wC528
Func_03A_6E92::
    ld a, [wD8A6]
    ld hl, Data_03A_6EA5
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    jp Func_03A_7193

Data_03A_6EA5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $9F, $9F, $A2, $9F, $9F, $9F, $9F, $9F, $9F, $9F, $A1, $9F, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $94, $94, $94, $94, $94, $97, $99
    db $FF, $FF, $A5, $9B, $A4, $A3, $A6, $A7
    ds $10, $FF
    db $97, $FF, $FF, $FF, $0D, $A9, $28, $D6

; 22 call sites from 12 routines (e.g. Func_030_43C4, Func_032_4ADC, Func_032_4C3E, Func_032_4D23, ...)
; writes: wC529, wC528
Func_03A_6EE5::
    push de
    ld hl, Data_03A_6F06
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_03A_6EF6
    dec hl
    call Func_000_000B

Jump_03A_6EF6::
    pop af
    ld [wC529], a
    ld a, $00
    ld [wC528], a
    farcall Func_02F_4001
    ret

Data_03A_6F06:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_03A_7106
    dw Data_03A_7106
    dw Data_03A_7107
    dw Data_03A_7108
    dw Data_03A_7108
    dw Data_03A_7109
    dw Data_03A_710A
    dw Data_03A_710B
    dw Data_03A_710C
    dw Data_03A_710C
    INCBIN "dwm2-cobi-us.gbc", $0EAF1A, $F0
    ds $FC, $00

Data_03A_7106:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7107:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7108:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_7109:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710A:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710B:: ; heuristic: target of a monotone pointer table; C0
    db $C9

Data_03A_710C:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EB10C, $87

; 66 call sites from 40 routines (e.g. Func_032_4E51, Func_032_553B, Func_032_55EE, Func_032_5820, ...)
; writes: wC529, wC528
Func_03A_7193::
    push de
    ld hl, Data_03A_71B4
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_03A_71A4
    dec hl
    call Func_000_000B

Jump_03A_71A4::
    pop af
    ld [wC529], a
    ld a, $01
    ld [wC528], a
    farcall Func_02F_4001
    ret

Data_03A_71B4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EB1B4, $1C2
    dw Data_03A_73B4
    db $B4, $73
    dw Data_03A_73CB
    db $CB, $73
    dw Data_03A_73CB
    db $B8, $73
    dw Data_03A_73E0
    db $E0, $73
    dw Data_03A_73E0
    db $E0, $73
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $FE, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74
    dw Data_03A_74F7
    db $F7, $74, $00, $00, $00, $00, $BB, $74, $BB, $74, $00, $00

Data_03A_73B4:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $C9, $FA, $A5, $D8, $FE, $03, $38, $0B, $CD, $E3, $7A, $78, $FE
    db $01, $20, $03, $CD, $27, $79, $C9

Data_03A_73CB:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $CD, $1A, $79, $C9, $CD, $EE, $78, $CD, $34, $79, $C9, $CD, $27
    db $79, $CD, $4E, $79, $C9

Data_03A_73E0:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $0EB3E0, $117

Data_03A_74F7:: ; heuristic: target of a monotone pointer table; C0
    db $CD, $EE, $78, $CD, $08, $79, $C9, $CD, $41, $79, $CD, $EE, $78, $CD, $08, $79
    db $C9

; 4 call sites from 2 routines (e.g. Func_032_4F0A, Func_032_5820)
; reads: wD8A6, wD8A4, wC982
; writes: wC982, wD86C, wC529, wC528
; points at: wDA1D, wC150
Func_03A_7508::
    push de
    ld a, [wD8A6]
    cp a, $D0
    jr nc, Jump_03A_7532
    xor a, a
    ld [wC982], a
    call Func_03A_78EE
    call Func_03A_791A
    ld a, [wD8A4]
    ld hl, wDA1D
    add a, a
    add_a_to_hl
    ld a, [hl]
    ld hl, wC150
    ld [wD86C], a
    call Func_03A_799C
    jr Jump_03A_753D

Jump_03A_7532::
    ld a, $01
    ld [wC982], a
    call Func_03A_78EE
    call Func_03A_7908

Jump_03A_753D::
    pop de
    ld a, d
    cp a, $03
    jp z, Jump_03A_7570
    cp a, $04
    jp z, Jump_03A_7594
    cp a, $05
    jp z, Jump_03A_7580
    cp a, $06
    jp z, Jump_03A_7584
    ld a, [wD8A6]
    ld hl, Data_03A_7603
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_03A_76E7
    dec d
    jr z, Jump_03A_7568
    ld hl, Data_03A_76FE

Jump_03A_7568::
    add_a_to_hl
    ld a, [hl]
    jr Jump_03A_75A4

Jump_03A_7570::
    ld a, [wC982]
    bit 0, a
    jr nz, Jump_03A_757B
    ld a, $49
    jr Jump_03A_75A4

Jump_03A_757B::
    ld hl, Data_03A_75C7
    jr Jump_03A_75B7

Jump_03A_7580::
    ld a, $4A
    jr Jump_03A_75A4

Jump_03A_7584::
    ld a, [wC982]
    bit 0, a
    jr nz, Jump_03A_758F
    ld a, $4B
    jr Jump_03A_75A4

Jump_03A_758F::
    ld hl, Data_03A_75DB
    jr Jump_03A_75B7

Jump_03A_7594::
    ld a, [wC982]
    bit 0, a
    jr nz, Jump_03A_759F
    ld a, $4C
    jr Jump_03A_75A4

Jump_03A_759F::
    ld hl, Data_03A_75EF
    jr Jump_03A_75B7

Jump_03A_75A4::
    cp a, $FF
    jr z, Jump_03A_75B6
    ld [wC529], a
    ld a, $00
    ld [wC528], a
    farcall Func_02F_4001

Jump_03A_75B6::
    ret

Jump_03A_75B7::
    ld a, [wD8A6]
    sub a, $D0
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_03A_75A4
    ret

Data_03A_75C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6C, $6E, $FF, $FF, $FF, $FF, $70, $FF, $80, $72, $FF, $FF, $76, $FF, $FF, $78
    db $FF, $81, $FF, $FF

Data_03A_75DB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $74, $75, $FF, $FF, $82, $83
    db $FF, $7A, $FF, $FF

Data_03A_75EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6D, $6F, $FF, $FF, $FF, $FF, $71, $FF, $84, $73, $FF, $FF, $77, $FF, $FF, $79
    db $FF, $85, $FF, $FF

Data_03A_7603:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $3D, $00
    db $04, $04, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $04, $11, $03, $10
    db $11, $06, $07
    ds $18, $03
    db $13, $08, $05, $03, $03, $03, $03, $03, $03, $01, $01, $01, $01, $09, $02, $02
    db $02, $02, $02, $02, $02, $02, $04, $04, $04, $04, $04, $04, $04, $03, $03, $03
    db $03, $12, $03, $03, $03, $03, $03, $03, $03, $04, $03, $0B, $03, $03, $03, $03
    db $03, $04, $04, $0D, $0F, $0A, $03, $03, $0C, $0E
    ds $2E, $00
    db $14, $14, $15, $15, $15, $15, $15, $15, $15, $16, $15, $15, $14, $15, $15, $15
    db $15, $15, $15, $15

Data_03A_76E7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $36, $37, $38, $46, $47, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43
    db $44, $45, $48, $FF, $69, $6A, $6B

Data_03A_76FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $4F, $56, $4E, $50, $55, $51, $52, $54, $5F, $5A, $58, $5B, $59, $5C, $FF
    db $4D, $4E, $57, $53, $FF, $FF, $FF

; 1 call site from 1 routine (e.g. Func_032_4F0A)
; reads: wD8A6
; writes: wC529, wC528
Func_03A_7715::
    call Func_03A_78EE
    call Func_03A_7908
    ld a, [wD8A6]
    sub a, $D0
    ld hl, Data_03A_7738
    add_a_to_hl
    ld a, [hl]
    ld [wC529], a
    ld a, $00
    ld [wC528], a
    farcall Func_02F_4001
    ret

Data_03A_7738:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $66, $67, $67, $67, $67, $67, $67, $67, $68, $67, $67, $66, $67, $67, $67
    db $67, $67, $67, $67

; 1 call site from 1 routine (e.g. Func_03B_444A)
; reads: hFFC6, wD8A5, wDAC4
; writes: wDAC4
; points at: wC0A0, wC0A8, wC130
Func_03A_774C::
    ldh a, [hFFC6]
    ld b, a
    ld a, b
    cp a, $01
    jr z, Jump_03A_77CF
    xor a, a
    ld [wDAC4], a
    ld a, [wD8A5]
    bit 2, a
    ld hl, wC0A0
    jr z, Jump_03A_7765
    ld hl, wC0A8

Jump_03A_7765::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_776B::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_7774::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_7784
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_7784
    ld a, [wDAC4]
    inc a
    ld [wDAC4], a

Jump_03A_7784::
    inc hl
    dec c
    jr nz, Jump_03A_7774
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_776B
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wDAC4]
    cp a, l
    jr z, Jump_03A_77BE
    ld hl, wC130
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

Jump_03A_77BE::
    call Func_03A_7927
    jr Jump_03A_77CB

; no direct call (reached through a table, a jump or a vector)
Func_03A_77C3:: ; heuristic: follows a terminator; C0
    ld a, e
    cp a, $01
    jr z, Jump_03A_77CF
    call Func_03A_795D

Jump_03A_77CB::
    call Func_03A_7B82
    ret

Jump_03A_77CF::
    call Func_03A_7927
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wD8A5, wDAC4
; writes: wDAC4
; points at: wC0A0, wC0A8, wC130
Func_03A_77D3:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    ld b, a
    ld a, b
    cp a, $01
    jr z, Jump_03A_7856
    xor a, a
    ld [wDAC4], a
    ld a, [wD8A5]
    bit 2, a
    ld hl, wC0A0
    jr z, Jump_03A_77EC
    ld hl, wC0A8

Jump_03A_77EC::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_77F2::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_77FB::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_780B
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_780B
    ld a, [wDAC4]
    inc a
    ld [wDAC4], a

Jump_03A_780B::
    inc hl
    dec c
    jr nz, Jump_03A_77FB
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_77F2
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wDAC4]
    cp a, l
    jr z, Jump_03A_7845
    ld hl, wC130
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

Jump_03A_7845::
    call Func_03A_7927
    jr Jump_03A_7852

; no direct call (reached through a table, a jump or a vector)
Func_03A_784A:: ; heuristic: follows a terminator; C0
    ld a, e
    cp a, $01
    jr z, Jump_03A_7856
    call Func_03A_795D

Jump_03A_7852::
    call Func_03A_7B82
    ret

Jump_03A_7856::
    call Func_03A_7927
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wD8A5, wDAC4
; writes: wDAC4
; points at: wC0A0, wC0A8, wC130
Func_03A_785A:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    ld b, a
    ld a, b
    cp a, $01
    jp z, Jump_03A_78EA
    xor a, a
    ld [wDAC4], a
    ld a, [wD8A5]
    bit 2, a
    ld hl, wC0A0
    jr z, Jump_03A_7874
    ld hl, wC0A8

Jump_03A_7874::
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

Jump_03A_787A::
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

Jump_03A_7883::
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, Jump_03A_7893
    ld a, d
    cp a, [hl]
    jr nz, Jump_03A_7893
    ld a, [wDAC4]
    inc a
    ld [wDAC4], a

Jump_03A_7893::
    inc hl
    dec c
    jr nz, Jump_03A_7883
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, Jump_03A_787A
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wDAC4]
    cp a, l
    jr z, Jump_03A_78D9
    ld hl, wC130
    ld [hl], $1D
    inc hl
    ld [hl], $2B
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $90
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

Jump_03A_78D9::
    call Func_03A_7927
    jr Jump_03A_78E6

; no direct call (reached through a table, a jump or a vector)
Func_03A_78DE:: ; heuristic: follows a terminator; C0
    ld a, e
    cp a, $01
    jr z, Jump_03A_78EA
    call Func_03A_795D

Jump_03A_78E6::
    call Func_03A_7B82
    ret

Jump_03A_78EA::
    call Func_03A_7927
    ret

; 3 call sites from 2 routines (e.g. Func_03A_7508, Func_03A_7715)
; reads: wD8A4
; writes: wD86C
; points at: wC130
Func_03A_78EE::
    ld a, [wD8A4]
    ld hl, wC130
    ld [wD86C], a
    call Func_03A_799C
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; writes: wD86C
; points at: wC140
Func_03A_78FB:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    ld hl, wC140
    ld [wD86C], a
    call Func_03A_799C
    ret

; 2 call sites from 2 routines (e.g. Func_03A_7508, Func_03A_7715)
; reads: hFFC6
; writes: wD86C
; points at: wC140
Func_03A_7908::
    farcall Func_0A3_414F
    ldh a, [hFFC6]
    ld hl, wC140
    ld [wD86C], a
    call Func_03A_799C
    ret

; 1 call site from 1 routine (e.g. Func_03A_7508)
; reads: wD8A6
; points at: wC140
Func_03A_791A::
    ld a, [wD8A6]
    ld l, a
    ld h, $04
    ld de, wC140
    call Func_000_2E81
    ret

; 6 call sites from 6 routines (e.g. Func_03A_774C, Func_03A_77C3, Func_03A_77D3, Func_03A_784A, ...)
; reads: wD8A5
; writes: wD86C
; points at: wC130
Func_03A_7927::
    ld a, [wD8A5]
    ld hl, wC130
    ld [wD86C], a
    call Func_03A_799C
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD86C
; points at: wC140
Func_03A_7934:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wC140
    ld [wD86C], a
    call Func_03A_799C
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A5
; writes: wD86C
; points at: wC150
Func_03A_7941:: ; heuristic: follows a terminator; C0
    ld a, [wD8A5]
    ld hl, wC150
    ld [wD86C], a
    call Func_03A_799C
    ret
    db $21, $40, $C1, $FA, $72, $D8, $4F, $FA, $73, $D8, $47, $CD, $84, $2F, $C9

; 3 call sites from 3 routines (e.g. Func_03A_77C3, Func_03A_784A, Func_03A_78DE)
; reads: wD8A5
; writes: wD86C
; points at: wC130
Func_03A_795D::
    ld a, [wD8A5]
    and a, $04
    ld hl, wC130
    ld [wD86C], a
    call Func_03A_799C
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC60C, wC130
Func_03A_796C:: ; heuristic: follows a terminator; C0
    ld de, wC60C
    ld hl, wC130
    call Func_000_2FE1
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wC60C, wC140
Func_03A_7976:: ; heuristic: follows a terminator; C0
    ld de, wC60C
    ld hl, wC140
    call Func_000_2FE1
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A6
; points at: wC150
Func_03A_7980:: ; heuristic: follows a terminator; C0
    ld a, [wD8A6]
    ld l, a
    ld h, $05
    ld de, wC150
    call Func_000_2E81
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wD8A4
; writes: wD86C
; points at: wC130
Func_03A_798D:: ; heuristic: follows a terminator; C0
    ld a, [wD8A4]
    and a, $04
    ld hl, wC130
    ld [wD86C], a
    call Func_03A_799C
    ret

; 10 call sites from 10 routines (e.g. Func_03A_7BF9, Func_03A_7508, Func_03A_78EE, Func_03A_7908, ...)
; reads: wC58A, wD86C
; writes: wD869
; points at: wDAD4
Func_03A_799C::
    cp a, $03
    jr nc, Jump_03A_79BB

; 1 call site from 1 routine (e.g. Func_03A_79ED)
Func_03A_79A0::
    push hl
    push bc
    ld e, $00
    call Func_000_3F32
    ld e, l
    ld d, h
    pop bc
    pop hl
    push hl
    call Func_000_2FE1
    pop hl

Jump_03A_79B0::
    ld a, [hl]
    cp a, $F0
    ret z
    inc hl
    jr Jump_03A_79B0

Jump_03A_79B7::
    ld a, b
    pop bc
    jr Func_03A_79A0

Jump_03A_79BB::
    push bc
    ld b, a
    and a, $03
    cp a, $03
    ld a, b
    pop bc
    jr z, Jump_03A_79E4
    push bc
    ld b, a
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_79B7
    push hl
    ld a, b
    and a, $03
    ld hl, wDAD4
    add_a_to_hl
    ld a, [hl]
    pop hl
    cp a, $FF
    jr nz, Jump_03A_79E1
    ld a, b

Jump_03A_79E1::
    pop bc
    jr nz, Jump_03A_7A10

Jump_03A_79E4::
    push af
    call Func_03A_79ED
    pop af
    call Func_03A_7A6E
    ret

; 1 call site from 1 routine (e.g. Func_03A_79A0)
; writes: wD87C, wD87A, wD87B
; points at: wD958
Func_03A_79ED::
    ld [wD87C], a
    push hl
    ld hl, wD958
    add a, a
    add_a_to_hl
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    add a, $02
    ld h, a
    ld l, c
    pop bc
    pop de
    ld a, e
    ld [wD87A], a
    ld a, d
    ld [wD87B], a
    call Func_000_2E81
    ret

Jump_03A_7A10::
    call Func_03A_79A0
    ld a, $47
    ld [hl+], a
    ld [hl], $F0
    push hl
    ld hl, wDAD4
    ld a, [wD86C]
    and a, $03
    cp a, $01
    jr z, Jump_03A_7A33
    cp a, $02
    jr z, Jump_03A_7A3D
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A59
    inc hl
    cp a, [hl]
    jr z, Jump_03A_7A59
    jr Jump_03A_7A68

Jump_03A_7A33::
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A5E
    ld a, [hl+]
    cp a, [hl]
    jr z, Jump_03A_7A59
    jr Jump_03A_7A68

Jump_03A_7A3D::
    ld d, $00
    inc hl
    inc hl
    ld a, [hl-]
    dec hl
    cp a, [hl]
    jr nz, Jump_03A_7A47
    inc d

Jump_03A_7A47::
    inc hl
    cp a, [hl]
    jr nz, Jump_03A_7A4C
    inc d

Jump_03A_7A4C::
    ld a, d
    or a, a
    jr z, Jump_03A_7A68
    cp a, $01
    jr z, Jump_03A_7A5E
    pop hl
    ld a, $0C
    jr Jump_03A_7A61

Jump_03A_7A59::
    pop hl
    ld a, $0A
    jr Jump_03A_7A61

Jump_03A_7A5E::
    pop hl
    ld a, $0B

Jump_03A_7A61::
    ld [wD869], a
    ld [hl+], a
    ld [hl], $F0
    ret

Jump_03A_7A68::
    pop hl
    xor a, a
    ld [wD869], a
    ret

; 1 call site from 1 routine (e.g. Func_03A_79A0)
; reads: wD87C, wC0A0, wD87A, wD87B
; writes: wC0A0
; points at: wD958, wC0A0
Func_03A_7A6E::
    call Func_03A_7AE3
    inc b
    ld c, $04
    xor a, a
    ld [wC0A0], a
    ld a, [wD87C]
    add a, a
    ld hl, wD958
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a

Jump_03A_7A87::
    ld a, c
    add a, a
    ld hl, wD958
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03A_7AA4
    ld a, [hl]
    cp a, d
    jr nz, Jump_03A_7AA4
    ld a, [wD87C]
    cp a, c
    jp z, Jump_03A_7AA9
    ld hl, wC0A0
    inc [hl]

Jump_03A_7AA4::
    inc c
    dec b
    jr nz, Jump_03A_7A87
    ret

Jump_03A_7AA9::
    ld a, [wC0A0]
    or a, a
    jr nz, Jump_03A_7AC7
    inc c

Jump_03A_7AB0::
    ld a, c
    add a, a
    ld hl, wD958
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, Jump_03A_7AC2
    ld a, [hl]
    cp a, d
    jr z, Jump_03A_7AC7

Jump_03A_7AC2::
    inc c
    dec b
    jr nz, Jump_03A_7AB0
    ret

Jump_03A_7AC7::
    ld a, [wD87A]
    ld l, a
    ld a, [wD87B]
    ld h, a
    ld a, [wC0A0]
    add a, $0A
    push af

Jump_03A_7AD5::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_03A_7ADD
    inc hl
    jr Jump_03A_7AD5

Jump_03A_7ADD::
    pop af
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; 6 call sites from 5 routines (e.g. Func_03A_7A6E, Func_03A_7B66, Func_03B_4711, Func_03B_4C95, ...)
; reads: wC58A, wC57F
; points at: wC0A0, wD958, wC0A8
Func_03A_7AE3::
    xor a, a
    ld hl, wC0A0
    ld bc, $0010
    call FillBytes
    ld de, $0000
    ld c, $00
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7B02
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7B02
    ld c, $04

Jump_03A_7B02::
    ld b, $03

Jump_03A_7B04::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_7B26
    ld a, e
    add a, a
    ld hl, wC0A0
    add_a_to_hl
    push de
    ld a, c
    add a, a
    ld de, wD958
    add a, e
    ld e, a
    jr nc, Jump_03A_7B1F
    inc d

Jump_03A_7B1F::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    pop de
    inc e

Jump_03A_7B26::
    inc c
    dec b
    jr nz, Jump_03A_7B04
    ld c, $04
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7B3C
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7B3C
    ld c, $00

Jump_03A_7B3C::
    ld b, $03

Jump_03A_7B3E::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr c, Jump_03A_7B60
    ld a, d
    add a, a
    ld hl, wC0A8
    add_a_to_hl
    push de
    ld a, c
    add a, a
    ld de, wD958
    add a, e
    ld e, a
    jr nc, Jump_03A_7B59
    inc d

Jump_03A_7B59::
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc d

Jump_03A_7B60::
    inc c
    dec b
    jr nz, Jump_03A_7B3E
    ld b, d
    ret

; 1 call site from 1 routine (e.g. Func_036_6FF1)
; reads: wC58A, wD8A5
Func_03A_7B66:: ; heuristic: follows a terminator; C0
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_7B77
    ld a, [wD8A5]
    cp a, $04
    jr c, Jump_03A_7B77

Jump_03A_7B74::
    ld d, $47
    ret

Jump_03A_7B77::
    call Func_03A_7AE3
    ld a, e
    cp a, $01
    jr z, Jump_03A_7B74
    ld d, $46
    ret

; 3 call sites from 3 routines (e.g. Func_03A_77C3, Func_03A_784A, Func_03A_78DE)
; points at: wC130
Func_03A_7B82::
    ld hl, wC130
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

; 3 call sites from 1 routine (e.g. Func_031_4EB9)
; reads: wC58A, wD869, wD86D, wD86E, wD86F, wC52D, wC52E, wC52F, ...
; writes: wD86C, wC528, wC529, wC52D, wC52E, wC52F, wC530
; points at: wD86D, wC130
Func_03A_7BA0::
    ld a, $FF
    ld hl, wD86D
    ld bc, $0003
    call FillBytes
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_03A_7BB6
    ld c, $04
    jr Jump_03A_7BC0

Jump_03A_7BB6::
    ld a, [wC57F]
    sla a
    and a, $04
    xor a, $04
    ld c, a

Jump_03A_7BC0::
    ld b, $03
    ld e, $00

Jump_03A_7BC4::
    ld a, c
    call CarryUnlessWDA63SlotEmpty
    jr z, Jump_03A_7BDC
    jr nc, Jump_03A_7BD2
    ld a, [wD869]
    or a, a
    jr z, Jump_03A_7BDC

Jump_03A_7BD2::
    ld a, e
    ld hl, wD86D
    add_a_to_hl
    ld [hl], c

Jump_03A_7BDC::
    inc e
    inc c
    dec b
    jr nz, Jump_03A_7BC4
    ld a, [wD86D]
    ld hl, vTiles1 + $6D0
    call Func_03A_7BF9
    ld hl, vTiles1 + $770
    ld a, [wD86E]
    call Func_03A_7BF9
    ld hl, vTiles2 + $10
    ld a, [wD86F]

; 2 call sites from 1 routine (e.g. Func_03A_7BA0)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wD86C, wC528, wC529, wC52D, wC52E, wC52F, wC530
; points at: wC130
Func_03A_7BF9::
    cp a, $FF
    jr z, Jump_03A_7C14
    push hl
    ld hl, wC130
    ld [wD86C], a
    call Func_03A_799C
    ld a, $08
    ld [wC528], a
    ld a, $05
    ld [wC529], a
    pop hl
    jr Jump_03A_7C1E

Jump_03A_7C14::
    ld a, $02
    ld [wC528], a
    ld a, $00
    ld [wC529], a

Jump_03A_7C1E::
    ld de, $0A01
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall Func_008_402B
    pop de
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23

; 1 call site from 1 routine (e.g. Func_03A_64F8)
; points at: wD8CF
Func_03A_7C66::
    ld hl, wD8CF
    jr Jump_03A_7C89

; 1 call site from 1 routine (e.g. Func_03A_69AA)
; points at: wD8EF
Func_03A_7C6B::
    ld hl, wD8EF
    jr Jump_03A_7C89
    db $21, $BF, $D8, $18, $14

; 1 call site from 1 routine (e.g. Func_03A_69AA)
; points at: wD8DF
Func_03A_7C75::
    ld hl, wD8DF
    jr Jump_03A_7C89
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

Jump_03A_7C89::
    add a, a
    add_a_to_hl
    deref_hl
    ret

; 4 call sites from 2 routines (e.g. Func_03A_6533, Func_03A_69AA)
Func_03A_7C93::
    add a, a
    add_a_to_hl
    ret

; 2 call sites from 2 routines (e.g. Func_03A_5762, Func_03A_4001)
; reads: wC58A, wC57F, wD8A4
Func_03A_7C9A::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7CAF
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7CAF
    ld a, [wD8A4]
    cp a, $04
    ccf
    ret

Jump_03A_7CAF::
    ld a, [wD8A4]
    cp a, $04
    ret

; 4 call sites from 2 routines (e.g. Func_03A_6C93, Func_03A_4001)
; reads: wC58A, wC57F, wD8A5
Func_03A_7CB5::
    ld a, [wC58A]
    cp a, $01
    jr nz, Jump_03A_7CCA
    ld a, [wC57F]
    bit 1, a
    jr z, Jump_03A_7CCA
    ld a, [wD8A5]
    cp a, $04
    ccf
    ret

Jump_03A_7CCA::
    ld a, [wD8A5]
    cp a, $04
    ret
    db $7A, $21, $E5, $7C, $85, $6F, $30, $01, $24, $56, $7B, $21, $0C, $D8, $CD, $25
    db $3F, $7A, $A6, $77, $C9, $DF, $FE, $00, $FD, $73, $EF, $BF

; 1 call site from 1 routine (e.g. Func_03A_6533)
; points at: wD095
Func_03A_7CEC::
    push hl
    ld hl, wD095
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_03A_69AA)
; points at: wD095
Func_03A_7CF9::
    push hl
    ld hl, wD095
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; 3 call sites from 2 routines (e.g. Func_03A_6533, Func_03A_69AA)
; points at: wD095
Func_03A_7D06::
    push hl
    ld hl, wD095
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD968, wD970, wD978
Func_03A_7D13:: ; heuristic: follows a terminator; C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wD968
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D2F
    ld l, $09
    cp a, $40
    jr nc, Jump_03A_7D2F
    ld l, $12

Jump_03A_7D2F::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wD970
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D4A
    ld l, $03
    cp a, $40
    jr nc, Jump_03A_7D4A
    ld l, $06

Jump_03A_7D4A::
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wD978
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, Jump_03A_7D65
    ld l, $01
    cp a, $40
    jr nc, Jump_03A_7D65
    ld l, $02

Jump_03A_7D65::
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; 2 call sites from 2 routines (e.g. Func_03A_61F8, Func_03A_6CD4)
; points at: wD80F
Func_03A_7D6A::
    call Func_000_3E25
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03A_7D84
    ld a, [hl]
    and a, $0C
    jr nz, Jump_03A_7D84
    xor a, a
    jr Jump_03A_7D85

Jump_03A_7D84::
    scf

Jump_03A_7D85::
    ld a, c
    pop bc
    pop hl
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wD80F
Func_03A_7D89:: ; heuristic: follows a terminator; C0
    push hl
    ld hl, wD80F
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, Jump_03A_7D98
    ld a, [hl]
    and a, $0C

Jump_03A_7D98::
    pop hl
    ret

Data_03A_7D9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0EBD9A, $1DF
    ds $87, $00
