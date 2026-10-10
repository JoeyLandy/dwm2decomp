SECTION "Bank 0A", ROMX[$4000], BANK[$0A]
    db $0A

; 1 call site from 1 routine (e.g. Func_002_4C4E)
; reads: wC46B, wC46C, wC915, wCC44
; writes: wC46B, rRAMG, wC916, wC917, wModeState
Func_00A_4001::
    call Func_00A_4196
    ld a, [wC46B]
    inc a
    ld [wC46B], a
    cp a, $05
    ret nz
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC46C]
    or a, a
    jr nz, Jump_00A_4021
    call Func_00A_4110
    call Func_00A_4055
    jr Jump_00A_4027

Jump_00A_4021::
    call Func_00A_40A4
    call Func_00A_4055

Jump_00A_4027::
    xor a, a
    ld [rRAMG], a
    ld a, [wC915]
    and a, $07
    jr z, Jump_00A_4042
    ld a, $04
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    ret

Jump_00A_4042::
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_00A_404F
    ld a, $00
    ld [wModeState], a
    ret

Jump_00A_404F::
    ld a, $05
    ld [wModeState], a
    ret

; 2 call sites from 1 routine (e.g. Func_00A_4001)
; reads: wC88C, wC6FD, hFFC6, hFFC7
; points at: wC6FE
Func_00A_4055::
    ld a, [wC88C]
    and a, $01
    ret z
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_00A_4062::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_4095
    bit 0, a
    jr z, Jump_00A_4095
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld a, e
    or a, d
    jr z, Jump_00A_4095
    ld a, e
    sub a, $01
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_4095::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_4062
    ret

; 2 call sites from 2 routines (e.g. Func_00A_4110, Func_00A_40A4)
; reads: wC8BF
; writes: wC8BF
Func_00A_409B::
    ld a, [wC8BF]
    set 7, a
    ld [wC8BF], a
    ret

; 1 call site from 1 routine (e.g. Func_00A_4001)
; reads: wC6FD, hFFC6, hFFC7, wC915
; writes: wC915
; points at: wC6FE
Func_00A_40A4::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_00A_40AB::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_410A
    bit 2, a
    jr z, Jump_00A_410A
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld a, e
    sub a, $01
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr nz, Jump_00A_40D5
    or a, e
    jr nz, Jump_00A_40FE

Jump_00A_40D5::
    ld c, $01
    call Func_00A_409B
    ld a, [wC6FD]
    sub a, b
    jr z, Jump_00A_40E6
    ld b, a

Jump_00A_40E1::
    sla c
    dec b
    jr nz, Jump_00A_40E1

Jump_00A_40E6::
    ld a, [wC915]
    or a, c
    ld [wC915], a
    push hl
    ld a, [hl]
    ld c, $55
    call SRAMRecordAddress
    ld a, [hl]
    and a, $F3
    or a, $80
    ld [hl], a
    pop hl
    ld de, $0000

Jump_00A_40FE::
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_410A::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_40AB
    ret

; 1 call site from 1 routine (e.g. Func_00A_4001)
; reads: wC6FD, hFFC6, hFFC7, wC915, wCC44, hFF90
; writes: wC8BF, wC915
; points at: wC6FE
Func_00A_4110::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_00A_4117::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_4190
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld a, [wC915]
    bit 7, a
    jr nz, Jump_00A_413E
    ld c, $0A
    ld a, $40
    ld [wC8BF], a
    jr Jump_00A_414F

Jump_00A_413E::
    ld c, $02
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_00A_414F
    ldh a, [hFF90]
    cp a, $3A
    jr nz, Jump_00A_414F
    ld c, $05

Jump_00A_414F::
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    bit 7, a
    jr nz, Jump_00A_415D
    or a, e
    jr nz, Jump_00A_4184

Jump_00A_415D::
    ld c, $01
    call Func_00A_409B
    ld a, [wC6FD]
    sub a, b
    jr z, Jump_00A_416E
    ld b, a

Jump_00A_4169::
    sla c
    dec b
    jr nz, Jump_00A_4169

Jump_00A_416E::
    ld a, [wC915]
    or a, c
    ld [wC915], a
    push hl
    ld a, [hl]
    ld c, $55
    call SRAMRecordAddress
    ld a, [hl]
    or a, $80
    ld [hl], a
    pop hl
    ld de, $0000

Jump_00A_4184::
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_4190::
    inc hl
    pop bc
    dec b
    jr nz, Jump_00A_4117
    ret

; 1 call site from 1 routine (e.g. Func_00A_4001)
; reads: wC46B, wIsCGB
; writes: wC526
; points at: wC5E9, wC49F, wC0F0
Func_00A_4196::
    ld a, [wC46B]
    or a, a
    jr nz, Jump_00A_41C1
    ld a, $66
    call QueueSoundEffect
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00A_4213
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes
    jr Jump_00A_420E

Jump_00A_41C1::
    ld a, [wC46B]
    srl a
    srl a
    and a, $01
    jr z, Jump_00A_41EC
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00A_4213
    ld hl, wC0F0
    ld de, wC49F
    ld bc, $0040
    call CopyBytes
    jr Jump_00A_420E

Jump_00A_41EC::
    ld hl, wC5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00A_4213
    ld b, $40
    ld hl, wC0F0
    ld de, wC49F

Jump_00A_4206::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00A_4206

Jump_00A_420E::
    ld a, $7F
    ld [wC526], a

Jump_00A_4213::
    ret

; 2 call sites from 2 routines (e.g. Func_002_56DC, Func_002_5BD7)
; reads: wC194
Func_00A_4214::
    ld a, [wC194]
    rst $00
    dw Jump_00A_4228
    dw Jump_00A_4243
    dw Jump_00A_424D
    dw Jump_00A_4257
    dw Jump_00A_4261
    dw Jump_00A_4271
    dw Jump_00A_4229
    dw Jump_00A_4239

Jump_00A_4228::
    ret

Jump_00A_4229::
    ld a, $50
    ldh [hFFC7], a
    ld a, $80
    ld [wC915], a
    ld a, $40
    ld [wC8BF], a
    jr Jump_00A_427B

Jump_00A_4239::
    ld a, $52
    ldh [hFFC7], a
    xor a, a
    ld [wC915], a
    jr Jump_00A_427B

Jump_00A_4243::
    ld a, $44
    ldh [hFFC7], a
    xor a, a
    ld [wC915], a
    jr Jump_00A_427B

Jump_00A_424D::
    ld a, $56
    ldh [hFFC7], a
    xor a, a
    ld [wC915], a
    jr Jump_00A_427B

Jump_00A_4257::
    ld a, $44
    ldh [hFFC7], a
    xor a, a
    ld [wC915], a
    jr Jump_00A_427B

Jump_00A_4261::
    ld a, $44
    ldh [hFFC7], a
    ld a, $80
    ld [wC915], a
    ld a, $40
    ld [wC8BF], a
    jr Jump_00A_427B

Jump_00A_4271::
    ld a, $44
    ldh [hFFC7], a
    xor a, a
    ld [wC915], a
    jr Jump_00A_427B

Jump_00A_427B::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC91F]
    or a, a
    ret nz
    ld a, [wD069]
    or a, a
    ret nz
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call Func_00A_461E
    ldh a, [hFFC7]
    ld c, a
    ld a, [wC910]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [wC911]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [wC912]
    cp a, c
    jr z, Jump_00A_42AF
    ld a, [wC913]
    cp a, c
    jr z, Jump_00A_42AF
    ret

Jump_00A_42AF::
    ld a, $07
    ld [wModeState], a
    xor a, a
    ld [wC46B], a
    ld [wC46C], a
    ret

; 2 call sites from 2 routines (e.g. Func_002_56DC, Func_002_5BD7)
; reads: hFF8C, wModeState, wCC44, hFF90, wC6FD, wC88C
; writes: rRAMG, wC88C, wC902, wModeState, wC46B, wC46C, wC915
; points at: wC6FE
Func_00A_42BC::
    ldh a, [hFF8C]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wModeState]
    and a, $0F
    dec a
    ret z
    ld a, [wModeState]
    cp a, $07
    ret z
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_00A_42F1
    ldh a, [hFF90]
    cp a, $20
    ret c
    ld c, a
    ld hl, Data_00A_4374

Jump_00A_42E8::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_00A_42FD
    cp a, c
    ret z
    jr Jump_00A_42E8

Jump_00A_42F1::
    cp a, $82
    ret z
    cp a, $83
    ret z
    cp a, $84
    ret z
    cp a, $87
    ret z

Jump_00A_42FD::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_00A_4309::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_4350
    bit 2, a
    jr nz, Jump_00A_431E
    bit 0, a
    jr nz, Jump_00A_4349
    jr Jump_00A_4350

Jump_00A_431E::
    call Func_00A_4362

Jump_00A_4321::
    pop bc
    ld a, [wModeState]
    cp a, $03
    jr nz, Jump_00A_432D
    xor a, a
    ld [wC902], a

Jump_00A_432D::
    ld a, $07
    ld [wModeState], a
    xor a, a
    ld [wC46B], a
    ld a, $01
    ld [wC46C], a
    xor a, a
    ld [wC915], a
    ld a, [wC88C]
    and a, $7F
    ld [wC88C], a
    jr Jump_00A_4355

Jump_00A_4349::
    call Func_00A_4362
    and a, $01
    jr nz, Jump_00A_4321

Jump_00A_4350::
    pop bc
    inc hl
    dec b
    jr nz, Jump_00A_4309

Jump_00A_4355::
    ld a, [wC88C]
    and a, $7F
    ld [wC88C], a
    xor a, a
    ld [rRAMG], a
    ret

; 2 call sites from 1 routine (e.g. Func_00A_42BC)
; reads: wC88C
; writes: wC88C
Func_00A_4362::
    ld a, [wC88C]
    bit 7, a
    ret nz
    ld a, [wC88C]
    inc a
    and a, $01
    or a, $80
    ld [wC88C], a
    ret

Data_00A_4374:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $22, $23, $24, $25, $26, $29, $2A, $2B, $2D, $2E, $31, $32, $33, $34, $3C
    db $3D, $41, $45, $49, $4A, $4B, $4C, $4D, $4F
    dw Data_00A_5150
    dw Data_00A_5852
    dw Data_00A_5A59
    dw Data_00A_5C5B
    dw Data_00A_5E5D
    dw Data_00A_605F
    dw Data_00A_6861
    dw Data_00A_7271
    dw Data_00A_7978
    dw Data_00A_7D7C
    dw Data_00A_7F7E
    db $89, $92, $9D, $A4, $A9, $AB, $AF, $B2, $B1, $B6, $B9, $BA, $BC, $C5, $D0, $D9
    db $E2, $FF

; 2 call sites from 2 routines (e.g. Func_002_56DC, Func_002_5BD7)
; reads: wFadeState, wC91F, wC901, wD069
; writes: wD069, wC916, wC917
Func_00A_43B5::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC91F]
    or a, a
    ret nz
    ld a, [wC901]
    and a, $7F
    ret z
    ld a, [wD069]
    or a, a
    ret z
    dec a
    ld [wD069], a
    or a, a
    ret nz
    ld a, [wC91F]
    or a, a
    jr z, Jump_00A_43DC
    ld a, $01
    ld [wD069], a
    ret

Jump_00A_43DC::
    ld a, $1E
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    ret

; 3 call sites from 3 routines (e.g. Func_002_4C4E, Func_002_56DC, Func_002_5BD7)
; reads: wFadeState, wC91F, hFF8C, wModeState, wC901, wD091, wC902, wCC44, ...
; writes: wC901, wD091, wC916, wC917, wC902, wC903, wModeState, wC904, ...
Func_00A_43EC::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, [wC91F]
    or a, a
    ret nz
    ldh a, [hFF8C]
    bit 7, a
    ret nz
    bit 5, a
    ret nz
    ld a, [wModeState]
    cp a, $04
    ret z
    cp a, $01
    ret z
    ld a, [wC901]
    bit 7, a
    jr z, Jump_00A_4414
    and a, $7F
    ld [wC901], a
    ret

Jump_00A_4414::
    ld a, [wC901]
    or a, a
    ret z
    ld a, [wD091]
    or a, a
    jr z, Jump_00A_4442
    dec a
    ld [wD091], a
    or a, a
    ret nz
    ld a, [wModeState]
    cp a, $01
    jr nz, Jump_00A_4432
    ld a, $01
    ld [wD091], a
    ret

Jump_00A_4432::
    ld a, $1D
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    ret

Jump_00A_4442::
    ld a, [wC901]
    push af
    ldh a, [hFF8C]
    bit 3, a
    jr z, Jump_00A_4451
    pop af
    ld b, $02
    jr Jump_00A_44A0

Jump_00A_4451::
    pop af
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add a, $FE
    ld l, a
    ld a, h
    adc a, $44
    ld h, a
    ld a, [hl+]
    or a, a
    jr nz, Jump_00A_44AD
    push hl
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call Func_00A_461E
    pop hl
    ld b, $02

Jump_00A_447A::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_00A_4498
    ld c, a
    ld a, [wC910]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [wC911]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [wC912]
    cp a, c
    jr z, Jump_00A_44A0
    ld a, [wC913]
    cp a, c
    jr z, Jump_00A_44A0

Jump_00A_4498::
    inc b
    ld a, b
    cp a, $09
    jr nz, Jump_00A_447A
    ld b, $02

Jump_00A_44A0::
    ld a, b
    srl a
    ld b, a
    ld a, [wC902]
    sub a, b
    ld [wC902], a
    jr Jump_00A_44B6

Jump_00A_44AD::
    ld a, [hl]
    ld c, a
    ld a, [wC902]
    sub a, c
    ld [wC902], a

Jump_00A_44B6::
    jr c, Jump_00A_44C3
    ld a, [wC902]
    or a, a
    jr z, Jump_00A_44C3
    cp a, $E0
    jr nc, Jump_00A_44C3
    ret

Jump_00A_44C3::
    xor a, a
    ld [wC903], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_00A_44D3
    ld a, $01
    ld [wC903], a

Jump_00A_44D3::
    farcall Func_002_5B9E
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wC904], a
    call NextRandomSeed
    ld a, [wCD03]
    and a, $01
    sla a
    ld [wC905], a
    ld a, $02
    ld [wC8C7], a
    farcall Func_002_5EEE
    call Func_00A_476E
    ret
    INCBIN "dwm2-cobi-us.gbc", $0284FE, $120

; 2 call sites from 2 routines (e.g. Func_00A_43EC, Func_00A_4214)
; writes: wC910, wC911, wC912, wC913
Func_00A_461E::
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wC910], a
    ld a, [hl-]
    ld [wC911], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wC912], a
    ld a, [hl]
    ld [wC913], a
    ret

; 1 call site from 1 routine (e.g. Func_00A_51FD)
; reads: wC903
; writes: wC96C
Func_00A_465D::
    xor a, a
    ld [wC96C], a
    ld a, [wC903]
    and a, $07
    rst $00
    dw Jump_00A_49B4
    dw Jump_00A_50D1
    dw Jump_00A_50CB
    dw Jump_00A_51DF
    dw Jump_00A_51F1
    dw Jump_00A_472E
    dw Jump_00A_4677
    dw Jump_00A_51F7

Jump_00A_4677::
    ld a, [wC935]
    and a, $0F
    cp a, $0C
    jr nc, Jump_00A_46D0
    farcall Func_061_40B4
    ld a, [wCD05]
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    add a, a
    ld de, Data_00A_46EE
    add a, e
    ld e, a
    jr nc, Jump_00A_4699
    inc d

Jump_00A_4699::
    ld a, [de]
    ldh [hFFC6], a
    inc de
    ld a, [de]
    ldh [hFFC7], a
    ld hl, wCFDD
    ld b, $03

Jump_00A_46A5::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    cp a, $0A
    jr nc, Jump_00A_46A5
    push af
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    pop af
    add a, e
    ld e, a
    jr nc, Jump_00A_46BE
    inc d

Jump_00A_46BE::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    dec b
    jr nz, Jump_00A_46A5

Jump_00A_46C5::
    ld a, $02
    ld [wCFDC], a
    ld a, $06
    ld [wCFC5], a
    ret

Jump_00A_46D0::
    sub a, $0C
    ld c, a
    add a, a
    add a, c
    add a, a
    ld de, Data_00A_4716
    add a, e
    ld e, a
    jr nc, Jump_00A_46DE
    inc d

Jump_00A_46DE::
    ld hl, wCFDD
    ld b, $03

Jump_00A_46E3::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00A_46E3
    jr Jump_00A_46C5

Data_00A_46EE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AC, $00, $BC, $00, $CC, $00, $DC, $00, $EC, $00, $FC, $00, $0C, $01, $1C, $01
    db $2C, $01, $3C, $01, $1E, $02, $23, $02, $28, $02, $2D, $02, $32, $02, $37, $02
    db $3C, $02, $41, $02, $46, $02, $48, $02

Data_00A_4716:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $02, $0C, $02, $0D, $02, $0E, $02, $0F, $02, $0E, $02, $10, $02, $11, $02
    db $12, $02, $13, $02, $14, $02, $15, $02

Jump_00A_472E::
    farcall Func_061_4001
    ld c, $76
    ld a, [wCD05]
    cp a, $05
    jr c, Jump_00A_475C
    inc c
    cp a, $0A
    jr c, Jump_00A_475C
    inc c
    cp a, $0F
    jr c, Jump_00A_475C
    inc c
    cp a, $14
    jr c, Jump_00A_475C
    inc c
    cp a, $19
    jr c, Jump_00A_475C
    inc c
    cp a, $1E
    jr c, Jump_00A_475C
    inc c
    cp a, $23
    jr c, Jump_00A_475C
    inc c

Jump_00A_475C::
    ld a, c
    ld [wCFDD], a
    xor a, a
    ld [wCFDE], a
    xor a, a
    ld [wCFDC], a
    ld a, $02
    ld [wCFC5], a
    ret

; 5 call sites from 5 routines (e.g. Func_00A_43EC, Func_007_6213, Func_00A_47A4, Func_05F_6C71, ...)
; reads: wCD04
; writes: wC902
Func_00A_476E::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $3F
    cp a, $64
    jr nc, Func_00A_476E
    ld b, a
    ld a, $05
    call DivideBByA
    ld a, b
    ld hl, Data_00A_478F
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld [wC902], a
    ret

Data_00A_478F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $19, $1E, $23, $28, $2A, $2C, $2D, $2E, $30, $32, $34, $36, $38, $3A
    db $3C, $41, $46, $50, $50

; 14 call sites from 14 routines (e.g. Func_00F_59E6, Func_00F_5AF3, Func_00F_5D9D, Func_00F_60E6, ...)
; reads: hFFC6
; writes: wCFDC, wCFDD, wCFDE, wCFDF, wCFE0, wCFE1, wCFE2, wC903, ...
Func_00A_47A4::
    push hl
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $48
    ld h, a
    ld a, [hl+]
    ld [wCFDC], a
    inc hl
    ld a, [hl+]
    ld [wCFDD], a
    ld a, [hl+]
    ld [wCFDE], a
    ld a, [hl+]
    ld [wCFDF], a
    ld a, [hl+]
    ld [wCFE0], a
    ld a, [hl+]
    ld [wCFE1], a
    ld a, [hl]
    ld [wCFE2], a
    ld a, $02
    ld [wC903], a
    ldh a, [hFFC6]
    cp a, $14
    jr z, Jump_00A_47F6
    cp a, $15
    jr z, Jump_00A_47F6
    cp a, $2F
    jr z, Jump_00A_47F6
    cp a, $30
    jr z, Jump_00A_47F6
    cp a, $31
    jr nz, Jump_00A_47FB

Jump_00A_47F6::
    ld a, $07
    ld [wC903], a

Jump_00A_47FB::
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wC904], a
    ld a, $01
    ld [wC905], a
    ld a, $02
    ld [wC8C7], a
    farcall Func_002_5EEE
    farcall Func_00A_476E
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $02881C, $198

Jump_00A_49B4::
    ldh a, [hFF90]
    cp a, $20
    jp z, Jump_00A_4ACF
    cp a, $2B
    jp z, Jump_00A_4AD8
    cp a, $30
    jp z, Jump_00A_4AEE
    cp a, $35
    jp z, Jump_00A_4B04
    cp a, $38
    jp z, Jump_00A_4B0D
    cp a, $39
    jp z, Jump_00A_4B16
    cp a, $3A
    jp z, Jump_00A_4B1F
    cp a, $3E
    jp z, Jump_00A_4B28
    cp a, $3F
    jp z, Jump_00A_4B31
    cp a, $37
    jp z, Jump_00A_4B3A
    cp a, $42
    jp z, Jump_00A_4B43
    cp a, $43
    jp z, Jump_00A_4B4C
    cp a, $48
    jp z, Jump_00A_4B55
    cp a, $53
    jp z, Jump_00A_4B6B
    cp a, $54
    jp z, Jump_00A_4B74
    cp a, $55
    jp z, Jump_00A_4B74
    cp a, $56
    jp z, Jump_00A_4B74
    cp a, $5D
    jp z, Jump_00A_4B7B
    cp a, $62
    jp z, Jump_00A_4B84
    cp a, $63
    jp z, Jump_00A_4B8D
    cp a, $64
    jp z, Jump_00A_4B96
    cp a, $65
    jp z, Jump_00A_4B9F
    cp a, $66
    jp z, Jump_00A_4BA8
    cp a, $67
    jp z, Jump_00A_4BB1
    cp a, $70
    jp z, Jump_00A_4BBA
    cp a, $73
    jp z, Jump_00A_4BC3
    cp a, $74
    jp z, Jump_00A_4BCC
    cp a, $75
    jp z, Jump_00A_4BD5
    cp a, $76
    jp z, Jump_00A_4BDE
    cp a, $81
    jp z, Jump_00A_4BE7
    cp a, $82
    jp z, Jump_00A_4BF0
    cp a, $83
    jp z, Jump_00A_4BF9
    cp a, $85
    jp z, Jump_00A_4C02
    cp a, $86
    jp z, Jump_00A_4C0B
    cp a, $87
    jp z, Jump_00A_4C14
    cp a, $88
    jp z, Jump_00A_4C1D
    cp a, $8B
    jp z, Jump_00A_4C26
    cp a, $8C
    jp z, Jump_00A_4C2F
    cp a, $8E
    jp z, Jump_00A_4C38
    cp a, $90
    jp z, Jump_00A_4C41
    cp a, $A0
    jp z, Jump_00A_4C4A
    cp a, $A2
    jp z, Jump_00A_4C53
    cp a, $A8
    jp z, Jump_00A_4C5C
    cp a, $AD
    jp z, Jump_00A_4C65
    cp a, $AE
    jp z, Jump_00A_4C65
    cp a, $B0
    jp z, Jump_00A_4C6E
    cp a, $B3
    jp z, Jump_00A_4C77
    cp a, $B4
    jp z, Jump_00A_4C77
    cp a, $B5
    jp z, Jump_00A_4C77
    cp a, $B8
    jp z, Jump_00A_4C80
    cp a, $BE
    jp z, Jump_00A_4C96
    cp a, $BF
    jp z, Jump_00A_4C9F
    cp a, $C0
    jp z, Jump_00A_4CA8
    cp a, $C1
    jp z, Jump_00A_4CA8
    cp a, $C2
    jp z, Jump_00A_4CB1
    cp a, $C3
    jp z, Jump_00A_4CB1
    ret

Jump_00A_4ACF::
    ld de, Data_00A_5773
    ld a, $08
    call Func_00A_4CBA
    ret

Jump_00A_4AD8::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_4AE7
    ld de, Data_00A_5856
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4AE7::
    ld de, Data_00A_588E
    call Func_00A_4CD4
    ret

Jump_00A_4AEE::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_4AFD
    ld de, Data_00A_589B
    ld a, $08
    call Func_00A_4CBA
    ret

Jump_00A_4AFD::
    ld de, Data_00A_5A3B
    call Func_00A_4CD4
    ret

Jump_00A_4B04::
    ld de, Data_00A_5A4C
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B0D::
    ld de, Data_00A_5A8A
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B16::
    ld de, Data_00A_5AB7
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B1F::
    ld de, Data_00A_5ADE
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B28::
    ld de, Data_00A_5AFF
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B31::
    ld de, Data_00A_5B14
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B3A::
    ld de, Data_00A_5B29
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B43::
    ld de, Data_00A_5B45
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B4C::
    ld de, Data_00A_5B58
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4B55::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_4B64
    ld de, Data_00A_5B6B
    ld a, $0C
    call Func_00A_4CBA
    ret

Jump_00A_4B64::
    ld de, Data_00A_5D4E
    call Func_00A_4CD4
    ret

Jump_00A_4B6B::
    ld de, Data_00A_5D5D
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B74::
    ld de, Data_00A_5D8C
    call Func_00A_4CD4
    ret

Jump_00A_4B7B::
    ld de, Data_00A_5D9B
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4B84::
    ld de, Data_00A_5DCA
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B8D::
    ld de, Data_00A_5DE7
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B96::
    ld de, Data_00A_5DEF
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4B9F::
    ld de, Data_00A_5DF7
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BA8::
    ld de, Data_00A_5E0C
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BB1::
    ld de, Data_00A_5E14
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BBA::
    ld de, Data_00A_5E2B
    ld a, $0C
    call Func_00A_4CBA
    ret

Jump_00A_4BC3::
    ld de, Data_00A_6028
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BCC::
    ld de, Data_00A_603D
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BD5::
    ld de, Data_00A_6052
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BDE::
    ld de, Data_00A_606B
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4BE7::
    ld de, Data_00A_6084
    ld a, $01
    call Func_00A_4CBA
    ret

Jump_00A_4BF0::
    ld de, Data_00A_6097
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4BF9::
    ld de, Data_00A_60BA
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C02::
    ld de, Data_00A_60DD
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C0B::
    ld de, Data_00A_60F2
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C14::
    ld de, Data_00A_6107
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C1D::
    ld de, Data_00A_6120
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C26::
    ld de, Data_00A_6139
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C2F::
    ld de, Data_00A_6160
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C38::
    ld de, Data_00A_6181
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C41::
    ld de, Data_00A_61A2
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C4A::
    ld de, Data_00A_61BD
    ld a, $04
    call Func_00A_4CBA
    ret

Jump_00A_4C53::
    ld de, Data_00A_61FB
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C5C::
    ld de, Data_00A_6220
    ld a, $06
    call Func_00A_4CBA
    ret

Jump_00A_4C65::
    ld de, Data_00A_62AB
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C6E::
    ld de, Data_00A_62D2
    ld a, $03
    call Func_00A_4CBA
    ret

Jump_00A_4C77::
    ld de, Data_00A_62EB
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4C80::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_4C8F
    ld de, Data_00A_6300
    ld a, $05
    call Func_00A_4CBA
    ret

Jump_00A_4C8F::
    ld de, Data_00A_6375
    call Func_00A_4CD4
    ret

Jump_00A_4C96::
    ld de, Data_00A_6382
    ld a, $01
    call Func_00A_4CBA
    ret

Jump_00A_4C9F::
    ld de, Data_00A_6393
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4CA8::
    ld de, Data_00A_63AA
    ld a, $02
    call Func_00A_4CBA
    ret

Jump_00A_4CB1::
    ld de, Data_00A_63BF
    ld a, $02
    call Func_00A_4CBA
    ret

; 48 call sites from 1 routine (e.g. Func_00A_47A4)
; reads: hFF92, hFF8F, wC5E7, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, ...
; writes: wCFDC, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, wCFC5
; points at: wCFDD
Func_00A_4CBA::
    sla a
    ld c, a
    ldh a, [hFF92]
    and a, $0F
    call Multiply8
    ldh a, [hFF8F]
    and a, $0F
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

; 5 call sites from 1 routine (e.g. Func_00A_47A4)
; reads: wC5E7, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, wCFDC
; writes: wCFDC, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, wCFC5
; points at: wCFDD
Func_00A_4CD4::
    ld a, [de]
    inc de
    dec a
    ld [wCFDC], a
    ld a, [de]
    inc de
    ldh [hFFC6], a
    ld a, [de]
    inc de
    ldh [hFFC7], a
    ld a, [de]
    inc de
    ldh [hFFC8], a
    ld a, [de]
    inc de
    ldh [hFFC9], a
    ld a, [de]
    inc de
    ldh [hFFCA], a
    ld a, [de]
    inc de
    ldh [hFFCB], a
    ld hl, wCFDD
    ld b, $03

Jump_00A_4CF7::
    call NextTableByte
    ld a, [wC5E7]
    and a, $7F
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr c, Jump_00A_4CF7
    push hl
    push de
    ldh a, [hFFC7]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hFFC8]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hFFC9]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hFFCA]
    cp a, c
    jr nc, Jump_00A_4D31
    inc de
    inc de
    ldh a, [hFFCB]
    cp a, c
    jr nc, Jump_00A_4D31

Jump_00A_4D28::
    pop de
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_00A_4CF7
    jr Jump_00A_4D38

Jump_00A_4D31::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    ld [hl], a
    jr Jump_00A_4D28

Jump_00A_4D38::
    xor a, a
    ld [wCFC5], a
    ld a, [wCFDC]
    or a, a
    ret z
    dec a
    jr nz, Jump_00A_4D49
    ld hl, Data_00A_5150
    jr Jump_00A_4D4C

Jump_00A_4D49::
    ld hl, Data_00A_514C

Jump_00A_4D4C::
    call NextTableByte
    ld a, [wC5E7]
    and a, $03
    add_a_to_hl
    ld a, [hl]
    ld [wCFDC], a
    ret

; 1 call site from 1 routine (e.g. Func_016_56E4)
; reads: hFF90, hFF8C
Func_00A_4D5E::
    ldh a, [hFF90]
    cp a, $20
    jp z, Jump_00A_4E79
    cp a, $2B
    jp z, Jump_00A_4E82
    cp a, $30
    jp z, Jump_00A_4E98
    cp a, $35
    jp z, Jump_00A_4EAE
    cp a, $38
    jp z, Jump_00A_4EB7
    cp a, $39
    jp z, Jump_00A_4EC0
    cp a, $3A
    jp z, Jump_00A_4EC9
    cp a, $3E
    jp z, Jump_00A_4ED2
    cp a, $3F
    jp z, Jump_00A_4EDB
    cp a, $37
    jp z, Jump_00A_4EE4
    cp a, $42
    jp z, Jump_00A_4EED
    cp a, $43
    jp z, Jump_00A_4EF6
    cp a, $48
    jp z, Jump_00A_4EFF
    cp a, $53
    jp z, Jump_00A_4F15
    cp a, $54
    jp z, Jump_00A_4F1E
    cp a, $55
    jp z, Jump_00A_4F1E
    cp a, $56
    jp z, Jump_00A_4F1E
    cp a, $5D
    jp z, Jump_00A_4F25
    cp a, $62
    jp z, Jump_00A_4F2E
    cp a, $63
    jp z, Jump_00A_4F37
    cp a, $64
    jp z, Jump_00A_4F40
    cp a, $65
    jp z, Jump_00A_4F49
    cp a, $66
    jp z, Jump_00A_4F52
    cp a, $67
    jp z, Jump_00A_4F5B
    cp a, $70
    jp z, Jump_00A_4F64
    cp a, $73
    jp z, Jump_00A_4F6D
    cp a, $74
    jp z, Jump_00A_4F76
    cp a, $75
    jp z, Jump_00A_4F7F
    cp a, $76
    jp z, Jump_00A_4F88
    cp a, $81
    jp z, Jump_00A_4F91
    cp a, $82
    jp z, Jump_00A_4F9A
    cp a, $83
    jp z, Jump_00A_4FA3
    cp a, $85
    jp z, Jump_00A_4FAC
    cp a, $86
    jp z, Jump_00A_4FB5
    cp a, $87
    jp z, Jump_00A_4FBE
    cp a, $88
    jp z, Jump_00A_4FC7
    cp a, $8B
    jp z, Jump_00A_4FD0
    cp a, $8C
    jp z, Jump_00A_4FD9
    cp a, $8E
    jp z, Jump_00A_4FE2
    cp a, $90
    jp z, Jump_00A_4FEB
    cp a, $A0
    jp z, Jump_00A_4FF4
    cp a, $A2
    jp z, Jump_00A_4FFD
    cp a, $A8
    jp z, Jump_00A_5006
    cp a, $AD
    jp z, Jump_00A_500F
    cp a, $AE
    jp z, Jump_00A_500F
    cp a, $B0
    jp z, Jump_00A_5018
    cp a, $B3
    jp z, Jump_00A_5021
    cp a, $B4
    jp z, Jump_00A_5021
    cp a, $B5
    jp z, Jump_00A_5021
    cp a, $B8
    jp z, Jump_00A_502A
    cp a, $BE
    jp z, Jump_00A_5033
    cp a, $BF
    jp z, Jump_00A_503C
    cp a, $C0
    jp z, Jump_00A_5045
    cp a, $C1
    jp z, Jump_00A_5045
    cp a, $C2
    jp z, Jump_00A_504E
    cp a, $C3
    jp z, Jump_00A_504E
    ret

Jump_00A_4E79::
    ld de, Data_00A_5773
    ld a, $08
    call Func_00A_5057
    ret

Jump_00A_4E82::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_4E91
    ld de, Data_00A_5856
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4E91::
    ld de, Data_00A_588E
    call Func_00A_5071
    ret

Jump_00A_4E98::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_4EA7
    ld de, Data_00A_589B
    ld a, $08
    call Func_00A_5057
    ret

Jump_00A_4EA7::
    ld de, Data_00A_5A3B
    call Func_00A_5071
    ret

Jump_00A_4EAE::
    ld de, Data_00A_5A4C
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4EB7::
    ld de, Data_00A_5A8A
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4EC0::
    ld de, Data_00A_5AB7
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4EC9::
    ld de, Data_00A_5ADE
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4ED2::
    ld de, Data_00A_5AFF
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4EDB::
    ld de, Data_00A_5B14
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4EE4::
    ld de, Data_00A_5B29
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4EED::
    ld de, Data_00A_5B45
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4EF6::
    ld de, Data_00A_5B58
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4EFF::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_4F0E
    ld de, Data_00A_5B6B
    ld a, $0C
    call Func_00A_5057
    ret

Jump_00A_4F0E::
    ld de, Data_00A_5D4E
    call Func_00A_5071
    ret

Jump_00A_4F15::
    ld de, Data_00A_5D5D
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4F1E::
    ld de, Data_00A_5D8C
    call Func_00A_5071
    ret

Jump_00A_4F25::
    ld de, Data_00A_5D9B
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4F2E::
    ld de, Data_00A_5DCA
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F37::
    ld de, Data_00A_5DE7
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F40::
    ld de, Data_00A_5DEF
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F49::
    ld de, Data_00A_5DF7
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F52::
    ld de, Data_00A_5E0C
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F5B::
    ld de, Data_00A_5E14
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F64::
    ld de, Data_00A_5E2B
    ld a, $0C
    call Func_00A_5057
    ret

Jump_00A_4F6D::
    ld de, Data_00A_6028
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F76::
    ld de, Data_00A_603D
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F7F::
    ld de, Data_00A_6052
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F88::
    ld de, Data_00A_606B
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4F91::
    ld de, Data_00A_6084
    ld a, $01
    call Func_00A_5057
    ret

Jump_00A_4F9A::
    ld de, Data_00A_6097
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FA3::
    ld de, Data_00A_60BA
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FAC::
    ld de, Data_00A_60DD
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FB5::
    ld de, Data_00A_60F2
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FBE::
    ld de, Data_00A_6107
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FC7::
    ld de, Data_00A_6120
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_4FD0::
    ld de, Data_00A_6139
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FD9::
    ld de, Data_00A_6160
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FE2::
    ld de, Data_00A_6181
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FEB::
    ld de, Data_00A_61A2
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_4FF4::
    ld de, Data_00A_61BD
    ld a, $04
    call Func_00A_5057
    ret

Jump_00A_4FFD::
    ld de, Data_00A_61FB
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_5006::
    ld de, Data_00A_6220
    ld a, $06
    call Func_00A_5057
    ret

Jump_00A_500F::
    ld de, Data_00A_62AB
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_5018::
    ld de, Data_00A_62D2
    ld a, $03
    call Func_00A_5057
    ret

Jump_00A_5021::
    ld de, Data_00A_62EB
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_502A::
    ld de, Data_00A_6300
    ld a, $05
    call Func_00A_5057
    ret

Jump_00A_5033::
    ld de, Data_00A_6382
    ld a, $01
    call Func_00A_5057
    ret

Jump_00A_503C::
    ld de, Data_00A_6393
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_5045::
    ld de, Data_00A_63AA
    ld a, $02
    call Func_00A_5057
    ret

Jump_00A_504E::
    ld de, Data_00A_63BF
    ld a, $02
    call Func_00A_5057
    ret

; 48 call sites from 1 routine (e.g. Func_00A_4D5E)
; reads: hFF92, hFF8F, wD09D, hFFC6, hFFC7
; writes: wD09D, wD09E, wMonsterId, wCFE7, hFFC6
; points at: wD09F, hFFC6
Func_00A_5057::
    sla a
    ld c, a
    ldh a, [hFF92]
    and a, $0F
    call Multiply8
    ldh a, [hFF8F]
    and a, $0F
    sla a
    add_a_to_hl
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

; 4 call sites from 1 routine (e.g. Func_00A_4D5E)
; reads: wD09D, hFFC6, hFFC7
; writes: wD09D, wD09E, wMonsterId, wCFE7, hFFC6
; points at: wD09F, hFFC6
Func_00A_5071::
    inc de
    inc de
    push de
    ld b, $00

Jump_00A_5076::
    ld a, [de]
    inc de
    or a, a
    jr z, Jump_00A_5083
    inc b
    ld a, b
    cp a, $05
    jr z, Jump_00A_5083
    jr Jump_00A_5076

Jump_00A_5083::
    pop de
    ld a, $05
    add a, e
    ld e, a
    jr nc, Jump_00A_508B
    inc d

Jump_00A_508B::
    ld a, b
    ld [wD09D], a
    xor a, a
    ld [wD09E], a
    ld hl, wD09F

Jump_00A_5096::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_00A_5096
    ld a, [wD09D]
    ld b, a
    ld hl, wD09F

Jump_00A_50A6::
    push bc
    ld a, [hl+]
    ld [wMonsterId], a
    ld a, [hl-]
    ld [wCFE7], a
    push hl
    ld a, $02
    ldh [hFFC6], a
    ld de, hFFC6
    ld c, $00
    farcall Func_034_4008
    pop hl
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl+], a
    pop bc
    dec b
    jr nz, Jump_00A_50A6
    ret

Jump_00A_50CB::
    ld a, $02
    ld [wCFC5], a
    ret

Jump_00A_50D1::
    call NextTableByte
    ld a, [wC5E7]
    and a, $03
    ld hl, Data_00A_514C
    add_a_to_hl
    ld a, [hl]
    ld [wCFDC], a
    ld a, [wCC44]
    and a, $07
    cp a, $01
    jr z, Jump_00A_50F1
    or a, a
    jr nz, Jump_00A_5116

Jump_00A_50F1::
    ldh a, [hFF92]
    srl a
    and a, $FE
    ld c, a
    ldh a, [hFF8F]
    srl a
    srl a
    add a, c
    ld hl, wCD70
    add_a_to_hl
    ld a, [hl]
    ld c, a
    add a, a
    add a, a
    add a, c
    ld c, a
    call Func_00A_5154
    ld a, $01
    ld [wCFC5], a
    ret

Jump_00A_5116::
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD88
    add_a_to_hl
    ld a, [hl]
    push af
    and a, $0F
    srl a
    and a, $FE
    ld c, a
    pop af
    swap a
    and a, $0F
    srl a
    srl a
    add a, c
    ld hl, wCD70
    add_a_to_hl
    ld a, [hl]
    add a, a
    add a, a
    add a, a
    ld c, a
    call Func_00A_5154
    ld a, $01
    ld [wCFC5], a
    ret

Data_00A_514C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $02, $01, $02

Data_00A_5150:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $01

; 2 call sites from 1 routine (e.g. Func_00A_5071)
; reads: hFF8C, wCD03
; points at: wCFDD, wCD10
Func_00A_5154::
    ldh a, [hFF8C]
    bit 3, a
    jr nz, Jump_00A_519F
    ld b, $03
    ld de, wCFDD

Jump_00A_515F::
    push bc
    call NextRandomSeed
    ld a, [wCD03]
    and a, $07
    add a, c
    cp a, $20
    jr c, Jump_00A_516F
    ld a, $1F

Jump_00A_516F::
    add a, a
    ld hl, wCD10
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    and a, $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $DF
    ld e, a
    ld a, d
    sbc a, $CF
    ld d, a
    sra d
    rr e
    ld a, e
    add a, $E3
    ld e, a
    ld a, d
    adc a, $CF
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, Jump_00A_515F
    ret

Jump_00A_519F::
    ld b, $03
    ld de, wCFDD

Jump_00A_51A4::
    push bc
    call NextRandomSeed
    ld a, [wCD03]
    and a, $07
    add a, $20
    add a, a
    ld hl, wCD10
    add_a_to_hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    and a, $01
    ld [de], a
    inc de
    push de
    ld a, e
    sub a, $DF
    ld e, a
    ld a, d
    sbc a, $CF
    ld d, a
    sra d
    rr e
    ld a, e
    add a, $E3
    ld e, a
    ld a, d
    adc a, $CF
    ld d, a
    ld a, [hl]
    srl a
    ld [de], a
    pop de
    pop bc
    dec b
    jr nz, Jump_00A_51A4
    ret

Jump_00A_51DF::
    ld a, [wCC44]
    cp a, $82
    jr nz, Jump_00A_51EB
    ld a, $01
    ld [wC96C], a

Jump_00A_51EB::
    ld a, $03
    ld [wCFC5], a
    ret

Jump_00A_51F1::
    ld a, $04
    ld [wCFC5], a
    ret

Jump_00A_51F7::
    ld a, $05
    ld [wCFC5], a
    ret

; 1 call site from 1 routine (e.g. Func_002_4AE0)
; reads: wC904
Func_00A_51FD::
    ld a, [wC904]
    rst $00
    dw Jump_00A_5207
    dw Jump_00A_52A4
    dw Jump_00A_525C

Jump_00A_5207::
    ld a, [wC608]
    ld [wD2CD], a
    ld a, [wC905]
    and a, $01
    sla a
    add a, $44
    call QueueMusic
    ld a, $03
    ldh [hFFB9], a
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_00A_5245
    inc d

Jump_00A_5245::
    ld a, e
    ld [wC909], a
    ld a, d
    ld [wC90A], a
    xor a, a
    ld [wC906], a
    ld [wC907], a
    ld [wC908], a
    ld hl, wC904
    inc [hl]
    ret

Jump_00A_525C::
    ld a, [wSoundChannelSlots]
    ld hl, wDC01
    and a, [hl]
    ld hl, wDC20
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC40
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC60
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDC80
    and a, [hl]
    inc hl
    and a, [hl]
    ld hl, wDCA0
    and a, [hl]
    inc hl
    and a, [hl]
    cp a, $FF
    ret nz
    call Func_00A_465D
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wC5DD], a
    ld [wC5DE], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wD066
    inc [hl]
    ret

Jump_00A_52A4::
    ld a, [wC905]
    rst $00
    dw Jump_00A_52AE
    dw Jump_00A_5362
    dw Jump_00A_54AF

Jump_00A_52AE::
    ld a, [wC906]
    rst $00
    dw Jump_00A_52B6
    dw Jump_00A_5309

Jump_00A_52B6::
    ld a, [wC907]
    cp a, $14
    jr nz, Jump_00A_52C2
    ld hl, wC906
    inc [hl]
    ret

Jump_00A_52C2::
    ld a, [wC907]
    ld hl, $0000
    add_a_to_hl
    ld b, $09

Jump_00A_52CF::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_52CF
    ld a, [wC907]
    ld b, a
    ld a, $13
    sub a, b
    ld hl, $0020
    add_a_to_hl
    ld b, $09

Jump_00A_52F2::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_52F2
    ld hl, wC907
    inc [hl]
    ret

Jump_00A_5309::
    ld hl, wC904
    inc [hl]
    ret

; 10 call sites from 2 routines (e.g. Func_00A_51FD, Func_00A_534E)
; reads: wIsCGB
; writes: rVBK
Func_00A_530E::
    call Func_00A_5328
    ld a, $C4
    call WriteVRAMByte
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    xor a, a
    call WriteVRAMByte
    ld a, $00
    ldh [rVBK], a
    ret

; 1 call site from 1 routine (e.g. Func_00A_530E)
Func_00A_5328::
    push bc
    ld b, l
    ld a, l
    and a, $E0
    ld l, a
    call Func_00A_534E
    ld a, b
    and a, $1F
    jr z, Jump_00A_533D
    ld b, a

Jump_00A_5337::
    call NextBGMapColumn_Bank0A
    dec b
    jr nz, Jump_00A_5337

Jump_00A_533D::
    pop bc
    ret

; L = (L & $E0) | ((L + 1) & $1F): moves HL one entry right inside its 32-entry BG map row, wrapping at the row end; keeps AF (the same 15 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_00A_5328)
NextBGMapColumn_Bank0A::
Func_00A_533F:: ; address name
    push af
    ld a, l
    and a, $E0
    push af
    ld a, l
    inc a
    and a, $1F
    ld l, a
    pop af
    or a, l
    ld l, a
    pop af
    ret

; 1 call site from 1 routine (e.g. Func_00A_5328)
; reads: wC909, wC90A
Func_00A_534E::
    ld a, [wC909]
    add a, l
    ld l, a
    ld a, [wC90A]
    adc a, h
    and a, $03
    ld h, a
    ld a, [wC90A]
    and a, $FC
    or a, h
    ld h, a
    ret

Jump_00A_5362::
    ld b, $06

Jump_00A_5364::
    ld a, [wC906]
    rst $00
    dw Jump_00A_536E
    dw Jump_00A_53C6
    dw Jump_00A_54AA

Jump_00A_536E::
    push bc
    ld a, [wC907]
    cp a, $11
    jp c, Jump_00A_5413
    cp a, $23
    jp c, Jump_00A_5438
    cp a, $33
    jp c, Jump_00A_545D
    cp a, $43
    jp c, Jump_00A_5474
    cp a, $51
    jp c, Jump_00A_5413
    cp a, $5F
    jp c, Jump_00A_5438
    cp a, $6B
    jp c, Jump_00A_545D
    cp a, $77
    jp c, Jump_00A_5474
    cp a, $81
    jr c, Jump_00A_5413
    cp a, $8B
    jp c, Jump_00A_5438
    cp a, $93
    jp c, Jump_00A_545D
    cp a, $9B
    jp c, Jump_00A_5474
    cp a, $A1
    jr c, Jump_00A_5413
    cp a, $A7
    jp c, Jump_00A_5438
    cp a, $AB
    jp c, Jump_00A_545D
    cp a, $AF
    jp c, Jump_00A_5474
    cp a, $B1
    jr c, Jump_00A_5413
    jr Jump_00A_5438

Jump_00A_53C6::
    push bc
    ld a, [wC907]
    cp a, $02
    jr c, Jump_00A_5438
    cp a, $04
    jr c, Jump_00A_5413
    cp a, $08
    jp c, Jump_00A_5474
    cp a, $0C
    jp c, Jump_00A_545D
    cp a, $12
    jr c, Jump_00A_5438
    cp a, $18
    jr c, Jump_00A_5413
    cp a, $20
    jp c, Jump_00A_5474
    cp a, $28
    jr c, Jump_00A_545D
    cp a, $32
    jr c, Jump_00A_5438
    cp a, $3C
    jr c, Jump_00A_5413
    cp a, $48
    jr c, Jump_00A_5474
    cp a, $54
    jr c, Jump_00A_545D
    cp a, $62
    jr c, Jump_00A_5438
    cp a, $70
    jr c, Jump_00A_5413
    cp a, $80
    jr c, Jump_00A_5474
    cp a, $90
    jr c, Jump_00A_545D
    cp a, $A2
    jr c, Jump_00A_5438
    jr Jump_00A_5413

Jump_00A_5413::
    or a, a
    jr nz, Jump_00A_5421
    ld hl, $0233
    ld a, l
    ld [wC90B], a
    ld a, h
    ld [wC90C], a

Jump_00A_5421::
    ld a, [wC90B]
    ld l, a
    ld a, [wC90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_5438::
    or a, a
    jr nz, Jump_00A_5446
    ld hl, $012A
    ld a, l
    ld [wC90B], a
    ld a, h
    ld [wC90C], a

Jump_00A_5446::
    ld a, [wC90B]
    ld l, a
    ld a, [wC90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    sub a, $01
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_545D::
    ld a, [wC90B]
    ld l, a
    ld a, [wC90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Jump_00A_5489

Jump_00A_5474::
    ld a, [wC90B]
    ld l, a
    ld a, [wC90C]
    ld h, a
    push hl
    call Func_00A_530E
    pop hl
    ld a, l
    add a, $01
    ld l, a
    ld a, h
    adc a, $00
    ld h, a

Jump_00A_5489::
    ld a, l
    ld [wC90B], a
    ld a, h
    ld [wC90C], a
    ld hl, wC907
    inc [hl]
    ld a, [wC907]
    cp a, $B4
    jr nz, Jump_00A_54A4
    ld hl, wC906
    inc [hl]
    xor a, a
    ld [wC907], a

Jump_00A_54A4::
    pop bc
    dec b
    jp nz, Jump_00A_5364
    ret

Jump_00A_54AA::
    ld hl, wC904
    inc [hl]
    ret

Jump_00A_54AF::
    ld a, [wC906]
    rst $00
    dw Jump_00A_54B9
    dw Jump_00A_5589
    dw Jump_00A_558E

Jump_00A_54B9::
    ld a, [wC907]
    or a, a
    jr nz, Jump_00A_54CA
    ld hl, $0000
    ld a, l
    ld [wC90B], a
    ld a, h
    ld [wC90C], a

Jump_00A_54CA::
    ld hl, Data_00A_55FA
    ld a, [wC907]
    add_a_to_hl
    ld b, [hl]
    ld hl, Data_00A_560C
    ld a, [wC907]
    add a, a
    add_a_to_hl
    ld a, [wC90B]
    ld e, a
    ld a, [wC90C]
    ld d, a
    call Func_00A_5593

Jump_00A_54ED::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_00A_54ED
    ld hl, Data_00A_55FA
    ld a, [wC907]
    add_a_to_hl
    ld b, [hl]
    ld a, [wC90B]
    ld l, a
    ld a, [wC90C]
    ld h, a

Jump_00A_550C::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    inc hl
    dec b
    jr nz, Jump_00A_550C
    push hl
    ld hl, Data_00A_5603
    ld a, [wC907]
    add_a_to_hl
    ld b, [hl]
    pop hl
    dec hl

Jump_00A_5526::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_5526
    ld hl, Data_00A_5603
    ld a, [wC907]
    add_a_to_hl
    ld b, [hl]
    ld a, [wC90B]
    ld l, a
    ld a, [wC90C]
    ld h, a

Jump_00A_554C::
    push hl
    push bc
    call Func_00A_530E
    pop bc
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_554C
    ld a, [wC90B]
    ld l, a
    ld a, [wC90C]
    ld h, a
    ld a, l
    add a, $21
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld [wC90B], a
    ld a, h
    ld [wC90C], a
    ld hl, wC907
    inc [hl]
    ld hl, wC906
    inc [hl]
    ld a, [wC907]
    cp a, $09
    ret nz
    ld hl, wC906
    inc [hl]
    ret

Jump_00A_5589::
    ld hl, wC906
    dec [hl]
    ret

Jump_00A_558E::
    ld hl, wC904
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_00A_534E)
Func_00A_5593::
    deref_hl
    jp hl
    INCBIN "dwm2-cobi-us.gbc", $029597, $63

Data_00A_55FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $14, $12, $10, $0E, $0C, $0A, $08, $06, $04

Data_00A_5603:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $12, $10, $0E, $0C, $0A, $08, $06, $04, $02

Data_00A_560C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $97, $55, $A2, $55, $AD, $55, $B8, $55, $C3, $55, $CE, $55, $D9, $55, $E4, $55
    db $EF, $55

; 2 call sites from 2 routines (e.g. Func_002_56DC, Func_002_5BD7)
; reads: wC91F, wC901, wC7C9, wC7CA, hFFC6
; writes: hFFC6, wC7C9, wC7CA, rRAMG
; points at: sA000
Func_00A_561E::
    ld a, [wC91F]
    or a, a
    ret nz
    ld a, [wC901]
    and a, $7F
    ret z
    xor a, a
    ldh [hFFC6], a
    ld a, [wC7C9]
    ld l, a
    ld a, [wC7CA]
    ld h, a
    inc hl
    push hl
    ld a, $64
    call DivideHLByA
    or a, a
    jr nz, Jump_00A_5642
    ld a, $01
    ldh [hFFC6], a

Jump_00A_5642::
    pop hl
    ld a, l
    cp a, $E8
    jr nz, Jump_00A_5656
    ld a, h
    cp a, $03
    jr nz, Jump_00A_5656
    ldh a, [hFFC6]
    or a, $02
    ldh [hFFC6], a
    ld hl, $0000

Jump_00A_5656::
    ld a, l
    ld [wC7C9], a
    ld a, h
    ld [wC7CA], a
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $0A
    ld [rRAMG], a
    ld hl, sA000
    ld a, $6B
    add_a_to_hl
    ld de, sA000
    ld b, $1E

Jump_00A_5676::
    ld a, [de]
    or a, a
    jr z, Jump_00A_56B8
    dec a
    jr nz, Jump_00A_56A7
    ldh a, [hFFC6]
    bit 1, a
    jr z, Jump_00A_56B8
    push de
    ld a, e
    add a, $6E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    or a, a
    jr nz, Jump_00A_56B8
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    cp a, $03
    jr nz, Jump_00A_569F
    ld a, e
    cp a, $E7
    jr z, Jump_00A_56A4

Jump_00A_569F::
    inc de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl-], a

Jump_00A_56A4::
    pop de
    jr Jump_00A_56B8

Jump_00A_56A7::
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    cp a, e
    jr nz, Jump_00A_56B2
    or a, a
    jr z, Jump_00A_56B7

Jump_00A_56B2::
    dec de
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl-], a

Jump_00A_56B7::
    pop de

Jump_00A_56B8::
    ld a, e
    add a, $A5
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, l
    add a, $A5
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_00A_5676
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_002_56DC)
; reads: wC901, wC91F, wC6FD, hFFC6, hFFC7
; writes: rRAMG
; points at: wC6FE
Func_00A_56D0::
    ld a, [wC901]
    and a, $7F
    ret z
    ld a, [wC91F]
    or a, a
    ret nz
    ld de, $0002
    call TestFlagBit
    ret nc
    ld a, [wC6FD]
    or a, a
    ret z
    ld b, a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_00A_56F0::
    push bc
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_00A_573E
    ld a, [hl]
    ld c, $A4
    call LoadSRAMRecordByte
    cp a, $1B
    jr nz, Jump_00A_5709
    ld c, $5D
    jr Jump_00A_570F

Jump_00A_5709::
    cp a, $1C
    jr nz, Jump_00A_573E
    ld c, $61

Jump_00A_570F::
    push bc
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    pop bc
    dec c
    dec c
    push bc
    ld a, [hl]
    call LoadSRAMRecordWord
    pop bc
    ldh a, [hFFC6]
    cp a, e
    jr nz, Jump_00A_572D
    ldh a, [hFFC7]
    cp a, d
    jr z, Jump_00A_573E

Jump_00A_572D::
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    inc de
    push hl
    ld a, [hl]
    call SRAMRecordAddress
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl], a
    pop hl

Jump_00A_573E::
    pop bc
    inc hl
    dec b
    jr nz, Jump_00A_56F0
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_002_56DC)
; reads: hFF93, wC91F, hFF96, hFF97
; writes: hFF96, hFF97, wC916, wC917
Func_00A_5748::
    ldh a, [hFF93]
    bit 7, a
    ret z
    ld a, [wC91F]
    or a, a
    ret nz
    ldh a, [hFF96]
    ld l, a
    ldh a, [hFF97]
    ld h, a
    dec hl
    ld a, l
    ldh [hFF96], a
    ld a, h
    ldh [hFF97], a
    ld a, h
    bit 7, a
    ret z
    ld a, $0A
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall Func_013_405C
    ret

Data_00A_5773:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57FE
    dw Data_00A_5827
    dw Data_00A_5827
    dw Data_00A_5845
    db $F3, $57, $F3, $57, $F3, $57, $F3, $57, $FE, $57, $FE, $57, $27, $58, $27, $58
    db $F3, $57, $F3, $57, $F3, $57, $FE, $57, $FE, $57, $FE, $57, $FE, $57, $27, $58
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57FE
    dw Data_00A_57FE
    dw Data_00A_57FE
    dw Data_00A_5818
    dw Data_00A_5827
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_5818
    dw Data_00A_5836
    dw Data_00A_5845
    dw Data_00A_5845
    db $0B, $58, $F3, $57, $F3, $57, $F3, $57, $18, $58, $36, $58, $45, $58, $45, $58
    dw Data_00A_580B
    dw Data_00A_580B
    dw Data_00A_580B
    dw Data_00A_580B
    dw Data_00A_5818
    dw Data_00A_5836
    dw Data_00A_5845
    dw Data_00A_5845
    dw Data_00A_57F3
    dw Data_00A_57F3
    dw Data_00A_580B
    dw Data_00A_5818
    dw Data_00A_5818
    dw Data_00A_5836
    dw Data_00A_5845
    dw Data_00A_5845

Data_00A_57F3:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $03, $07, $00, $00, $00, $02, $00, $03, $00

Data_00A_57FE:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0B, $04, $08, $0B, $00, $00, $02, $00, $03, $00, $05, $00

Data_00A_580B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $0C, $05, $0A, $0C, $00, $00, $02, $00, $03, $00, $04, $00

Data_00A_5818:: ; heuristic: target of a monotone pointer table; C0
    db $01, $10, $05, $0A, $0C, $10, $00, $02, $00, $03, $00, $04, $00, $05, $00

Data_00A_5827:: ; heuristic: target of a monotone pointer table; C0
    db $02, $0D, $02, $04, $09, $0D, $00, $02, $00, $03, $00, $05, $00, $06, $00

Data_00A_5836:: ; heuristic: target of a monotone pointer table; C0
    db $02, $0E, $02, $04, $09, $0E, $00, $02, $00, $03, $00, $05, $00, $04, $00

Data_00A_5845:: ; heuristic: target of a monotone pointer table; C0
    db $02, $14, $02, $04, $09, $0E, $14, $02, $00, $03, $00, $05, $00

Data_00A_5852:: ; heuristic: target of a monotone pointer table; C0
    db $04, $00, $06, $00

Data_00A_5856:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $81, $58, $81, $58, $81, $58, $81, $58, $81, $58, $81, $58, $81, $58, $81, $58
    db $81, $58, $81, $58, $81, $58, $81, $58, $81, $58, $76, $58, $76, $58, $76, $58
    db $02, $08, $04, $08, $00, $00, $00, $80, $01, $81, $01, $02, $0B, $03, $06, $0B
    db $00, $00, $80, $01, $81, $01, $84, $01

Data_00A_588E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $0C, $05, $0A, $0C, $00, $00, $80, $01, $81, $01, $86, $01

Data_00A_589B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $02989B, $1A0

Data_00A_5A3B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $12, $04, $08, $0B, $0E, $12, $1D, $00, $1F, $00, $18, $00, $20, $00, $21
    db $00

Data_00A_5A4C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6C, $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C

Data_00A_5A59:: ; heuristic: target of a monotone pointer table; C0
    db $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C, $5A, $6C
    db $5A, $6C, $5A, $03, $0F, $03, $05, $0A, $0F, $00, $22, $00, $15, $00, $17, $00
    db $18, $00, $02, $0F, $03, $05, $0A, $0F, $00, $22, $00, $15, $00, $17, $00, $18
    db $00

Data_00A_5A8A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A
    db $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A, $AA, $5A
    db $03, $0C, $04, $08, $0C, $00, $00, $24, $00, $25, $00, $27, $00

Data_00A_5AB7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CF, $5A, $CF, $5A, $CF, $5A, $CF, $5A, $CF, $5A, $CF, $5A, $CF, $5A, $CF, $5A
    db $CF, $5A, $CF, $5A, $CF, $5A, $CF, $5A, $03, $12, $03, $08, $0D, $12, $00, $23
    db $00, $24, $00, $25, $00, $27, $00

Data_00A_5ADE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F0, $5A, $F0, $5A, $F0, $5A, $F0, $5A, $F0, $5A, $F0, $5A, $F0, $5A, $F0, $5A
    db $F0, $5A, $03, $0F, $03, $05, $0A, $0F, $00, $8D, $01, $23, $00, $19, $00, $1E
    db $00

Data_00A_5AFF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $07, $5B, $07, $5B, $07, $5B, $07, $5B, $03, $0C, $04, $08, $0C, $00, $00, $13
    db $00, $26, $00, $16, $00

Data_00A_5B14:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $5B, $1C, $5B, $1C, $5B, $1C, $5B, $03, $0A, $02, $06, $0A, $00, $00, $0F
    db $00, $12, $00, $16, $00

Data_00A_5B29:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $5B, $2F, $5B, $2F, $5B, $02, $08, $04, $08, $00, $00, $00, $26, $00, $0E
    db $00, $02, $08, $04, $08, $00, $00, $00, $26, $00, $0E, $00

Data_00A_5B45:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4B, $5B, $4B, $5B, $4B, $5B, $02, $0B, $04, $08, $0B, $00, $00, $26, $00, $0E
    db $00, $0D, $00

Data_00A_5B58:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5E, $5B, $5E, $5B, $5E, $5B, $03, $0B, $04, $08, $0B, $00, $00, $26, $00, $0E
    db $00, $0D, $00

Data_00A_5B6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $029B6B, $60
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5CB4
    dw Data_00A_5CB4
    dw Data_00A_5CB4
    dw Data_00A_5CC3
    dw Data_00A_5CD2
    INCBIN "dwm2-cobi-us.gbc", $029BDF, $62
    dw Data_00A_5C8B
    dw Data_00A_5C8B
    dw Data_00A_5CEE
    dw Data_00A_5CEE
    dw Data_00A_5CEE
    dw Data_00A_5D0E
    dw Data_00A_5D0E
    dw Data_00A_5D0E
    dw Data_00A_5D0E
    dw Data_00A_5D1D
    dw Data_00A_5D1D
    dw Data_00A_5D1D
    dw Data_00A_5D1D

Data_00A_5C5B:: ; heuristic: target of a monotone pointer table; C0
    db $EE, $5C, $FD, $5C, $EE, $5C, $EE, $5C, $0E, $5D, $0E, $5D, $0E, $5D, $8B, $5C
    db $1D, $5D, $1D, $5D, $1D, $5D, $1D, $5D, $EE, $5C, $EE, $5C, $EE, $5C, $8B, $5C
    db $8B, $5C, $8B, $5C, $8B, $5C, $8B, $5C, $8B, $5C, $1D, $5D, $1D, $5D, $1D, $5D

Data_00A_5C8B:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $03, $07, $00, $00, $00, $02, $00, $03, $00, $03, $0E, $04, $09, $0E
    db $00, $00, $36, $00, $3C, $00, $91, $01, $03, $15, $04, $09, $0E, $11, $15, $38
    db $00, $2B, $00, $3B, $00, $36, $00, $3C, $00

Data_00A_5CB4:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $05, $09, $0D, $12, $00, $2A, $00, $2B, $00, $3B, $00, $36, $00

Data_00A_5CC3:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $04, $08, $0D, $12, $00, $2B, $00, $3B, $00, $36, $00, $91, $01

Data_00A_5CD2:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0C, $02, $07, $0C, $00, $00, $40, $00, $36, $00, $91, $01, $03, $10, $04
    db $09, $0D, $10, $00, $2A, $00, $2D, $00, $36, $00, $34, $00

Data_00A_5CEE:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $04, $09, $0E, $12, $00, $28, $00, $2D, $00, $34, $00, $3E, $00, $03
    db $15, $03, $07, $0D, $11, $15, $28, $00, $2D, $00, $38, $00, $3B, $00, $3E, $00

Data_00A_5D0E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $05, $0A, $0E, $12, $00, $2C, $00, $37, $00, $34, $00, $3E, $00

Data_00A_5D1D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $15, $04, $07, $0B, $10, $15, $29, $00, $33, $00, $37, $00, $39, $00, $92
    db $01, $03, $11, $03, $08, $0D, $11, $00, $33, $00, $3A, $00, $3D, $00, $92, $01
    db $03, $15, $05, $0A, $0E, $12, $15, $3F, $00, $40, $00, $37, $00, $29, $00, $33
    db $00

Data_00A_5D4E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $12, $05, $0A, $0F, $12, $00, $40, $00, $93, $01, $94, $01, $95, $01

Data_00A_5D5D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D
    db $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D, $7D, $5D
    db $03, $13, $04, $09, $0E, $13, $00, $2E, $00, $2F, $00, $30, $00, $31, $00

Data_00A_5D8C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $13, $04, $09, $0E, $13, $00, $2E, $00, $2F, $00, $30, $00, $31, $00

Data_00A_5D9B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D
    db $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D, $BB, $5D
    db $03, $10, $04, $08, $0C, $10, $00, $41, $00, $96, $01, $97, $01, $35, $00

Data_00A_5DCA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DA, $5D, $DA, $5D, $DA, $5D, $DA, $5D, $DA, $5D, $DA, $5D, $DA, $5D, $DA, $5D
    db $03, $0C, $04, $08, $0C, $00, $00, $42, $00, $43, $00, $98, $01

Data_00A_5DE7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $5D, $FF, $5D, $FF, $5D, $FF, $5D

Data_00A_5DEF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $5D, $FF, $5D, $FF, $5D, $FF, $5D

Data_00A_5DF7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $5D, $FF, $5D, $FF, $5D, $FF, $5D, $03, $0C, $04, $09, $0C, $00, $00, $9E
    db $01, $9F, $01, $A0, $01

Data_00A_5E0C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $5E, $1C, $5E, $1C, $5E, $1C, $5E

Data_00A_5E14:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $5E, $1C, $5E, $1C, $5E, $1C, $5E, $03, $0E, $01, $05, $0A, $0E, $00, $9D
    db $01, $9E, $01, $9F, $01, $A0, $01

Data_00A_5E2B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4B, $5F, $0A, $60, $0A, $60, $FB, $5F, $FB, $5F, $FB, $5F, $4B, $5F, $4B, $5F
    db $4B, $5F, $4B, $5F, $4B, $5F, $4B, $5F, $4B, $5F, $0A, $60, $0A, $60, $4B, $5F
    db $FB, $5F, $FB, $5F, $FB, $5F, $4B, $5F, $4B, $5F, $4B, $5F, $56, $5F, $56, $5F
    db $4B, $5F

Data_00A_5E5D:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029E5D, $92
    dw Data_00A_5F4B
    dw Data_00A_5FA1
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FCE
    dw Data_00A_5FCE
    dw Data_00A_5FCE
    db $4B, $5F, $4B, $5F, $EE, $5F, $EE, $5F
    dw Data_00A_5F4B
    dw Data_00A_5F4B
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FBF
    dw Data_00A_5FDF
    dw Data_00A_5FDF
    dw Data_00A_5FDF
    dw Data_00A_5FEE
    dw Data_00A_5FEE
    dw Data_00A_5FEE
    dw Data_00A_5FEE
    db $B0, $5F, $B0, $5F, $BF, $5F, $4B, $5F, $4B, $5F, $DF, $5F, $DF, $5F, $DF, $5F
    db $EE, $5F, $EE, $5F, $EE, $5F, $EE, $5F, $B0, $5F, $B0, $5F, $BF, $5F, $4B, $5F
    db $4B, $5F, $4B, $5F, $DF, $5F, $DF, $5F

Data_00A_5F4B:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $029F4B, $56

Data_00A_5FA1:: ; heuristic: target of a monotone pointer table; C0
    db $02, $10, $03, $06, $0B, $10, $00, $5E, $00, $A9, $01, $A8, $01, $4D, $00, $02
    db $13, $06, $0C, $12, $13, $00, $A8, $01, $5C, $00, $4D, $00, $53, $00

Data_00A_5FBF:: ; heuristic: target of a monotone pointer table; C0
    db $02, $14, $06, $0C, $12, $14, $00, $A8, $01, $5C, $00, $4D, $00, $58, $00

Data_00A_5FCE:: ; heuristic: target of a monotone pointer table; C0
    db $03, $16, $04, $09, $0E, $13, $16, $55, $00, $5D, $00, $4D, $00, $5C, $00, $A8
    db $01

Data_00A_5FDF:: ; heuristic: target of a monotone pointer table; C0
    db $03, $12, $05, $0A, $0E, $12, $00, $AA, $01, $6F, $00, $59, $00, $62, $00

Data_00A_5FEE:: ; heuristic: target of a monotone pointer table; C0
    db $02, $0C, $04, $08, $0C, $00, $00, $6E, $00, $4C, $00, $68, $00, $03, $14, $06
    db $09, $0E, $14, $00, $5B, $00, $65, $00, $54, $00, $46, $00, $03, $0F, $03, $08
    db $0D, $0F, $00, $65, $00, $46, $00, $54, $00, $58, $00, $02, $0D, $02, $03, $0A
    db $0D, $00, $58, $00, $4B, $00, $51, $00, $AD, $01

Data_00A_6028:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $60, $30, $60, $30, $60, $30, $60, $03, $0C, $04, $08, $0C, $00, $00, $4E
    db $00, $4F, $00, $50, $00

Data_00A_603D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $45, $60, $45, $60, $45, $60, $45, $60, $03, $0C, $04, $08, $0C, $00, $00, $4E
    db $00, $4F, $00, $50, $00

Data_00A_6052:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5A, $60, $5A, $60, $5A, $60, $5A, $60, $03, $16, $04, $08, $0C

Data_00A_605F:: ; heuristic: target of a monotone pointer table; C0
    db $11, $16, $4E, $00, $4F, $00, $50, $00, $57, $00, $66, $00

Data_00A_606B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $73, $60, $73, $60, $73, $60, $73, $60, $03, $16, $04, $08, $0C, $11, $16, $4E
    db $00, $4F, $00, $50, $00, $51, $00, $57, $00

Data_00A_6084:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $86, $60, $03, $14, $04, $08, $0C, $10, $14, $A1, $01, $A2, $01, $A3, $01, $A4
    db $01, $A5, $01

Data_00A_6097:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A9, $60, $A9, $60, $A9, $60, $A9, $60, $A9, $60, $A9, $60, $A9, $60, $A9, $60
    db $A9, $60, $03, $14, $04, $08, $0C, $10, $14, $A1, $01, $A2, $01, $A3, $01, $A4
    db $01, $A5, $01

Data_00A_60BA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $60, $CC, $60, $CC, $60, $CC, $60, $CC, $60, $CC, $60, $CC, $60, $CC, $60
    db $CC, $60, $03, $14, $04, $08, $0C, $10, $14, $A1, $01, $A2, $01, $A3, $01, $A4
    db $01, $A5, $01

Data_00A_60DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E5, $60, $E5, $60, $E5, $60, $E5, $60, $03, $0E, $05, $09, $0E, $00, $00, $5F
    db $00, $68, $00, $69, $00

Data_00A_60F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FA, $60, $FA, $60, $FA, $60, $FA, $60, $03, $0E, $05, $09, $0E, $00, $00, $5F
    db $00, $68, $00, $69, $00

Data_00A_6107:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0F, $61, $0F, $61, $0F, $61, $0F, $61, $03, $17, $04, $09, $0D, $12, $17, $5F
    db $00, $67, $00, $68, $00, $69, $00, $6A, $00

Data_00A_6120:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $28, $61, $28, $61, $28, $61, $28, $61, $03, $17, $04, $09, $0D, $12, $17, $5F
    db $00, $67, $00, $68, $00, $69, $00, $6A, $00

Data_00A_6139:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $51, $61, $51, $61, $51, $61, $51, $61, $51, $61, $51, $61, $51, $61, $51, $61
    db $51, $61, $51, $61, $51, $61, $51, $61, $03, $12, $05, $09, $0E, $12, $00, $59
    db $00, $5A, $00, $60, $00, $62, $00

Data_00A_6160:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $72, $61, $72, $61, $72, $61, $72, $61, $72, $61, $72, $61, $72, $61, $72, $61
    db $72, $61, $03, $11, $04, $09, $0E, $11, $00, $5A, $00, $60, $00, $61, $00, $63
    db $00

Data_00A_6181:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $93, $61, $93, $61, $93, $61, $93, $61, $93, $61, $93, $61, $93, $61, $93, $61
    db $93, $61, $03, $12, $05, $09, $0E, $12, $00, $57, $00, $59, $00, $60, $00, $62
    db $00

Data_00A_61A2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AE, $61, $AE, $61, $AE, $61, $AE, $61, $AE, $61, $AE, $61, $03, $11, $04, $09
    db $0E, $11, $00, $5A, $00, $60, $00, $61, $00, $63, $00

Data_00A_61BD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $EC, $61, $EC, $61, $DD, $61, $DD, $61, $EC, $61, $EC, $61, $EC, $61, $DD, $61
    db $EC, $61, $EC, $61, $EC, $61, $DD, $61, $DD, $61, $DD, $61, $DD, $61, $DD, $61
    db $03, $0E, $04, $07, $0B, $0E, $00, $70, $00, $71, $00, $72, $00, $AE, $01, $03
    db $0E, $04, $07, $0B, $0E, $00, $70, $00, $71, $00, $72, $00, $AE, $01

Data_00A_61FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $13
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    dw Func_000_1362
    db $62, $03, $0A, $04, $08, $0A, $00, $00, $70, $00, $71, $00, $65, $02

Data_00A_6220:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $02A220, $8B

Data_00A_62AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $62, $C3, $62, $C3, $62, $C3, $62, $C3, $62, $C3, $62, $C3, $62, $C3, $62
    db $C3, $62, $C3, $62, $C3, $62, $C3, $62, $03, $0A, $03, $05, $07, $0A, $00, $DC
    db $01, $DD, $01, $E0, $01, $E1, $01

Data_00A_62D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DE, $62, $DE, $62, $DE, $62, $DE, $62, $DE, $62, $DE, $62, $02, $0A, $04, $07
    db $0A, $00, $00, $E3, $01, $E4, $01, $E5, $01

Data_00A_62EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F3, $62, $F3, $62, $F3, $62, $F3, $62, $03, $0A, $06, $08, $0A, $00, $00, $E6
    db $01, $E7, $01, $E8, $01

Data_00A_6300:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3F, $63, $3F, $63, $3F, $63, $3F, $63, $3F, $63
    dw Data_00A_6332
    dw Data_00A_6332
    dw Data_00A_633F
    dw Data_00A_633F
    dw Data_00A_633F
    dw Data_00A_634E
    dw Data_00A_634E
    dw Data_00A_634E
    dw Data_00A_634E
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_635D
    dw Data_00A_636A
    dw Data_00A_636A
    db $5D, $63, $5D, $63, $5D, $63

Data_00A_6332:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $03, $07, $0A, $00, $00, $EF, $01, $F2, $01, $F7, $01

Data_00A_633F:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $03, $06, $08, $0A, $00, $EF, $01, $F2, $01, $F4, $01, $F7, $01

Data_00A_634E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $03, $06, $08, $0A, $00, $ED, $01, $EE, $01, $EF, $01, $F7, $01

Data_00A_635D:: ; heuristic: target of a monotone pointer table; C0
    db $03, $0A, $04, $07, $0A, $00, $00, $ED, $01, $EE, $01, $F7, $01

Data_00A_636A:: ; heuristic: target of a monotone pointer table; C0
    db $02, $0A, $06, $0A, $00, $00, $00, $F1, $01, $F2, $01

Data_00A_6375:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $03, $0A, $04, $06, $0A, $00, $00, $16, $02, $17, $02, $18, $02

Data_00A_6382:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $84, $63, $03, $0A, $02, $04, $08, $0A, $00, $F0, $01, $F2, $01, $F4, $01, $F7
    db $01

Data_00A_6393:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $9B, $63, $9B, $63, $9B, $63, $9B, $63, $03, $0A, $03, $05, $08, $0A, $00, $F0
    db $01, $F4, $01, $F6, $01, $F7, $01

Data_00A_63AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B2, $63, $B2, $63, $B2, $63, $B2, $63, $03, $0A, $04, $07, $0A, $00, $00, $F0
    db $01, $F5, $01, $F6, $01

Data_00A_63BF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C7, $63, $C7, $63, $C7, $63, $C7, $63, $03, $0A, $03, $07, $0A, $00, $00, $EF
    db $01, $F5, $01, $F6, $01
    ds $48D, $00

Data_00A_6861:: ; heuristic: target of a monotone pointer table; C0
    ds $A10, $00

Data_00A_7271:: ; heuristic: target of a monotone pointer table; C0
    ds $707, $00

Data_00A_7978:: ; heuristic: target of a monotone pointer table; C0
    ds $404, $00

Data_00A_7D7C:: ; heuristic: target of a monotone pointer table; C0
    ds $202, $00

Data_00A_7F7E:: ; heuristic: target of a monotone pointer table; C0
    ds $82, $00
