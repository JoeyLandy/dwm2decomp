SECTION "Bank 01", ROMX[$4000], BANK[$01]
    db $01

; 1 call site from 1 routine (e.g. Func_000_0355)
; writes: wC5F8, wC5F9, wC5FA, wC5FB, wC5FC, wC5FD, wC5FE, wC5FF, ...
Func_001_4001::
    ld hl, vTiles1
    ld de, $1007
    call FillTilesRequest
    ld hl, vTiles2
    ld de, $1007
    call FillTilesRequest
    xor a, a
    ld [wC5F8], a
    ld [wC5F9], a
    ld [wC5FA], a
    ld [wC5FB], a
    ld [wC5FC], a
    ld [wC5FD], a
    ld [wC5FE], a
    ld [wC5FF], a
    xor a, a
    ld [wC5F6], a
    ld [wC5F7], a
    call Func_001_4045
    ld a, $FC
    call StartPaletteFade
    ld a, $03
    ld [wC5EC], a
    ld a, $01
    jp Jump_000_077A

; 1 call site from 1 routine (e.g. Func_001_4001)
; reads: wC5DC
Func_001_4045::
    ld a, [wC5DC]
    rst $00
    dw Jump_001_45EA
    dw Jump_001_45EA
    dw Jump_001_461E
    dw Jump_001_46B4
    dw Jump_001_4743
    dw Jump_001_4826
    dw Jump_001_48B6
    dw Jump_001_4472
    dw Jump_001_4462
    dw Jump_001_4424
    dw Jump_001_4297
    dw Jump_001_4061

Jump_001_4061::
    call Func_001_4AA4
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1207
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    ld hl, vTiles2 + $200
    ld de, Data_01F_4160
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $210
    ld de, Data_01F_4130
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $220
    ld de, Data_01F_4180
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $230
    ld de, Data_01F_4190
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $240
    ld de, Data_01F_4170
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $250
    ld de, Data_01F_41D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wC5F8], a
    ld [wC5F9], a
    ld [wC5FA], a
    ld [wC5FB], a
    ld [wC5FC], a
    ld [wC5FD], a
    ld [wC5FE], a
    ld [wC5FF], a
    ld a, $01
    ld de, Data_001_412F
    ld hl, vBGMap0
    ld bc, $1412
    call Func_000_15DE
    xor a, a
    ld [wC46B], a
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    xor a, a
    ld [wC0A2], a
    ret

Data_001_412F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $40, $00
    db $20, $21, $1B, $22, $23, $00, $00, $00, $00, $10, $10
    ds $1D, $00
    db $24, $1E, $25, $22, $23, $10, $00, $00, $00, $10, $10
    ds $1D, $00
    db $24, $1E, $25, $22, $23, $11, $00, $00, $00, $10, $10
    ds $CD, $00

Jump_001_4297::
    ld a, $0F
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, Data_001_42BC
    ld hl, vBGMap0
    ld bc, $1412
    call Func_000_15DE
    ld hl, $0000
    call Func_001_4F80
    ret

Data_001_42BC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1B, $00
    db $11, $40, $41, $42, $43, $44, $45, $46, $47, $48, $00, $00, $00, $00, $12, $13
    db $14, $15
    ds $10, $00
    db $17, $15, $18
    ds $11, $00
    db $0F, $1A, $1B
    ds $11, $00
    db $1C, $19, $1D, $19, $15, $1E, $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $20, $21, $22
    ds $11, $00
    INCBIN "dwm2-cobi-us.gbc", $004349, $54
    ds $10, $00
    db $19, $12, $29, $23
    ds $10, $00
    db $31, $16, $19, $23
    ds $10, $00
    db $12, $1E, $2C
    ds $11, $00
    db $33, $34, $24, $30, $1E, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $30, $35, $2B
    ds $24, $00

Jump_001_4424::
    ld a, $0F
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, Data_001_6F30
    ld hl, vBGMap0
    ld bc, $1412
    call Func_000_15DE
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_001_445A
    ld a, $01
    ldh [rVBK], a
    xor a, a
    ld hl, vBGMap0
    ld bc, $0400
    call FillBytes
    ld a, $00
    ldh [rVBK], a

Jump_001_445A::
    xor a, a
    ld hl, wC5F8
    ld [hl+], a
    dec a
    ld [hl], a
    ret

Jump_001_4462::
    ld a, $31
    call Func_000_122D
    xor a, a
    ld hl, wD09D
    ld bc, $0038
    call FillBytes
    ret

Jump_001_4472::
    call Func_001_4AA4
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1005
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a
    farcall ShowString_Bank1B_4C94
    ld hl, vBGMap0 + $60
    ld bc, $1001
    ld a, $80
    call Func_001_4A75
    ld hl, vBGMap0 + $A0
    ld bc, $1004
    ld a, $90
    call Func_001_4A75
    ld hl, vBGMap0 + $120
    ld bc, $1002
    ld a, $B0
    call Func_001_4A75
    ld a, $FC
    ld [vBGMap0 + $181], a
    ld [vBGMap0 + $1E1], a
    ld [vBGMap0 + $1], a
    ld a, $FD
    ld [vBGMap0 + $1A1], a
    ld [vBGMap0 + $201], a
    ld [vBGMap0 + $21], a
    ld a, $FB
    ld [vBGMap0 + $1C1], a
    ld [vBGMap0 + $221], a
    ld de, Data_01F_4A80
    ld hl, vTiles1 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4A90
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4780
    ld hl, vTiles1 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_48F0
    ld hl, vTiles1 + $7C0
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Data_01F_4160
    ld hl, vTiles1 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4480
    ld hl, vTiles1 + $7B0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $200
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
    ld hl, vTiles2 + $300
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $400
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $500
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call FillTilesFromRequest
    ld hl, vBGMap0 + $8A
    ld bc, $0901
    ld a, $20
    call Func_001_4A75
    ld hl, vBGMap0 + $EA
    ld bc, $0901
    ld a, $30
    call Func_001_4A75
    ld hl, vBGMap0 + $12A
    ld bc, $0901
    ld a, $40
    call Func_001_4A75
    ld hl, vBGMap0 + $AA
    ld bc, $0901
    ld a, $50
    call Func_001_4A75
    xor a, a
    ld [wD7F1], a
    add a, $10
    ld [vBGMap0 + $81], a
    xor a, a
    ld [wC5F8], a
    ld [wC5F9], a
    ld [wC5FA], a
    ld [wC5FB], a
    ld [wC5FC], a
    ld [wC5FD], a
    ld [wC5FE], a
    ld [wC5FF], a
    ld hl, wD780
    ld b, $60

Jump_001_45E2::
    xor a, a
    ld [wD780], a
    dec b
    jr nz, Jump_001_45E2
    ret

Jump_001_45EA::
    call Func_001_4AA4
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1008
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1002
    ld a, $80
    call Func_001_4A75
    ret

Jump_001_461E::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1008
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1007
    ld a, $80
    call Func_001_4A75
    ld a, $01
    ld de, Data_001_46A4
    ld hl, vBGMap0 + $EA
    ld bc, $1001
    call Func_000_15DE
    xor a, a
    ld [wC5F8], a
    ldh a, [hFF90]
    ld [wC5F9], a
    ldh a, [hFF8F]
    ld [wC5FA], a
    ldh a, [hFF8E]
    ld [wC5FB], a
    ldh a, [hFF92]
    ld [wC5FC], a
    ldh a, [hFF91]
    ld [wC5FD], a
    ld a, $01
    ld [wC5FE], a
    ret

Data_001_46A4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F

Jump_001_46B4::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1008
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1007
    ld a, $80
    call Func_001_4A75
    ld a, $01
    ld de, Data_001_4733
    ld hl, vBGMap0 + $EA
    ld bc, $1001
    call Func_000_15DE
    xor a, a
    ld [wC5F8], a
    ld a, [wC833]
    push af
    call Func_001_5E6C
    pop af
    or a, $80
    ld [wC5F9], a
    ldh a, [hFF8F]
    ld [wC5FB], a
    ldh a, [hFF92]
    ld [wC5FC], a
    ret

Data_001_4733:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F

Jump_001_4743::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1008
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1002
    ld a, $80
    call Func_001_4A75
    ld a, $01
    ld de, Data_001_47DE
    ld hl, vBGMap0 + $124
    ld bc, $0606
    call Func_000_15DE
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_001_47C4
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld a, $01
    ld de, Data_001_4802
    ld hl, vBGMap0 + $124
    ld bc, $0606
    call Func_000_15DE
    ld c, $4F
    ld a, $00
    ldh [c], a

Jump_001_47C4::
    ld a, $00
    ld [wC5F9], a
    ld a, $80
    ld [wC5FA], a
    ld a, $00
    ld [wC5FB], a
    ld a, $80
    ld [wC5FC], a
    ld a, $00
    ld [wC5FD], a
    ret

Data_001_47DE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
    db $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
    db $40, $41, $42, $43

Data_001_4802:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $24, $01

Jump_001_4826::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1008
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, Data_001_488A
    ld hl, vBGMap0 + $A3
    ld bc, $0B04
    call Func_000_15DE
    xor a, a
    ld [wC46B], a
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

Data_001_488A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $90, $91, $92, $93, $94
    db $95, $96, $97, $98, $99, $9A, $A0, $A1, $A2, $A3, $A4, $A5, $10, $10, $A8, $10
    db $12, $B0, $B1, $B2, $B3, $B4, $B5, $10, $10, $B8, $10, $10

Jump_001_48B6::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0B09
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, Data_001_495D
    ld hl, vBGMap0 + $40
    ld bc, $140E
    call Func_000_15DE
    xor a, a
    ld hl, wD09D
    ld bc, $0018
    call FillBytes
    ld a, $01
    ld [wC46B], a
    call Func_001_6903
    ld a, $02
    ld [wC46B], a
    call Func_001_6903
    ld a, $03
    ld [wC46B], a
    call Func_001_6903
    ld a, $04
    ld [wC46B], a
    call Func_001_6903
    ld a, $05
    ld [wC46B], a
    call Func_001_6903
    ld a, $06
    ld [wC46B], a
    call Func_001_6903
    ld a, $08
    ld [wC46B], a
    call Func_001_6903
    ld a, $0A
    ld [wC46B], a
    call Func_001_6903
    xor a, a
    ld [wC46B], a
    ret

Data_001_495D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A
    ds $19, $00
    INCBIN "dwm2-cobi-us.gbc", $004985, $F0

; 11 call sites from 1 routine (e.g. Func_001_4045)
; reads: wIsCGB
Func_001_4A75::
    push hl
    ld d, b

Jump_001_4A77::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_001_4A77
    ld b, d
    ld e, a
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, e
    dec c
    jr nz, Func_001_4A75
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0240
    xor a, a
    call FillBytes
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; 7 call sites from 3 routines (e.g. Func_001_4045, Func_007_4B27, Func_007_4E11)
; reads: wIsCGB
; writes: wC526, wC527
; points at: wC49F
Func_001_4AA4::
    ld a, [wIsCGB]
    or a, a
    ret z
    ld de, Data_001_4ACC
    ld hl, wC49F
    ld bc, $0008
    call Func_000_1679
    ld a, $7F
    ld [wC526], a
    ld de, Data_001_4ACC
    ld hl, wC49F
    ld bc, $0008
    call Func_000_1679
    ld a, $7F
    ld [wC527], a
    ret

Data_001_4ACC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $5E, $FF, $7F, $F2, $66, $00, $00

; 1 call site from 1 routine (e.g. Func_000_048A)
; reads: wC5DC
Func_001_4AD4::
    ld a, [wC5DC]
    rst $00
    dw Jump_001_616A
    dw Jump_001_616A
    dw Jump_001_5FFE
    dw Jump_001_5BFA
    dw Jump_001_6294
    dw Jump_001_64C0
    dw Jump_001_6652
    dw Jump_001_543A
    dw Jump_001_5433
    dw Jump_001_50ED
    dw Jump_001_4ED4
    dw Jump_001_4AF0

Jump_001_4AF0::
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wC562]
    and a, $01
    jp z, Jump_001_4C56
    ld a, [wC0A2]
    ld [wStringIndex], a
    ld a, [wC0A1]
    ld [wStringCategory], a
    ld de, $1204
    ld hl, vTiles2 + $300
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, [wC0A0]
    rst $00
    dw Jump_001_4B68
    dw Jump_001_4B6F
    dw Jump_001_4B76
    dw Jump_001_4B7D
    dw Jump_001_4B84
    dw Jump_001_4B8B
    dw Jump_001_4B92
    dw Jump_001_4B99
    dw Jump_001_4BA0
    dw Jump_001_4BA7
    dw Jump_001_4BAE
    dw Jump_001_4BB5
    dw Jump_001_4BBC
    dw Jump_001_4BC3
    dw Jump_001_4BCA
    dw Jump_001_4BD1
    dw Jump_001_4BD8
    dw Jump_001_4BDF
    dw Jump_001_4BE6
    dw Jump_001_4BED
    dw Jump_001_4BF4
    dw Jump_001_4BFB
    dw Jump_001_4C02
    dw Jump_001_4C09
    dw Jump_001_4C10
    dw Jump_001_4C17
    dw Jump_001_4C1E
    dw Jump_001_4C25
    dw Jump_001_4C2C
    dw Jump_001_4C33
    dw Jump_001_4C3A
    dw Jump_001_4C41
    dw Jump_001_4C48
    dw Jump_001_4C4F

Jump_001_4B68::
    farcall BeginStringDisplay_Bank08
    ret

Jump_001_4B6F::
    farcall BeginStringDisplay_Bank09
    ret

Jump_001_4B76::
    farcall BeginStringDisplay_Bank28
    ret

Jump_001_4B7D::
    farcall Func_029_4001
    ret

Jump_001_4B84::
    farcall Func_02A_4001
    ret

Jump_001_4B8B::
    farcall Func_02B_4001
    ret

Jump_001_4B92::
    farcall Func_02C_4001
    ret

Jump_001_4B99::
    farcall Func_02D_4001
    ret

Jump_001_4BA0::
    farcall Func_02E_4001
    ret

Jump_001_4BA7::
    farcall Func_07C_4001
    ret

Jump_001_4BAE::
    farcall Func_080_4001
    ret

Jump_001_4BB5::
    farcall Func_082_4001
    ret

Jump_001_4BBC::
    farcall BeginStringDisplay_Bank86
    ret

Jump_001_4BC3::
    farcall Func_089_4001
    ret

Jump_001_4BCA::
    farcall BeginStringDisplay_Bank07
    ret

Jump_001_4BD1::
    farcall BeginStringDisplay_Bank2F
    ret

Jump_001_4BD8::
    farcall BeginStringDisplay_Bank37
    ret

Jump_001_4BDF::
    farcall BeginStringDisplay_Bank88
    ret

Jump_001_4BE6::
    farcall Func_083_4001
    ret

Jump_001_4BED::
    farcall BeginStringDisplay_Bank1D
    ret

Jump_001_4BF4::
    farcall BeginStringDisplay_Bank8A
    ret

Jump_001_4BFB::
    farcall BeginStringDisplay_BankF0_4001
    ret

Jump_001_4C02::
    farcall BeginStringDisplay_Bank1B_4C86
    ret

Jump_001_4C09::
    farcall BeginStringDisplay_Bank1F
    ret

Jump_001_4C10::
    farcall BeginStringDisplay_BankF0_48A0
    ret

Jump_001_4C17::
    farcall BeginStringDisplay_Bank0D
    ret

Jump_001_4C1E::
    farcall BeginStringDisplay_Bank33_6490
    ret

Jump_001_4C25::
    farcall BeginStringDisplay_Bank24
    ret

Jump_001_4C2C::
    farcall Func_00E_4001
    ret

Jump_001_4C33::
    farcall BeginStringDisplay_Bank0E
    ret

Jump_001_4C3A::
    farcall BeginStringDisplay_BankF2
    ret

Jump_001_4C41::
    farcall BeginStringDisplay_Bank33_7037
    ret

Jump_001_4C48::
    farcall BeginStringDisplay_Bank0B
    ret

Jump_001_4C4F::
    farcall BeginStringDisplay_Bank1B_480C
    ret

Jump_001_4C56::
    ld a, [wC563]
    and a, $40
    jr z, Jump_001_4C86
    ld a, [wC46B]
    cp a, $00
    call z, Func_001_4D6E
    ld a, [wC46B]
    cp a, $01
    call z, Func_001_4D93
    ld a, [wC46B]
    cp a, $02
    call z, Func_001_4DB1
    ld a, [wC46B]
    sub a, $01
    jr nc, Jump_001_4C7E
    ld a, $02

Jump_001_4C7E::
    ld [wC46B], a
    ld a, $69
    call StoreWC60B

Jump_001_4C86::
    ld a, [wC563]
    and a, $80
    jr z, Jump_001_4CB8
    ld a, [wC46B]
    cp a, $00
    call z, Func_001_4D6E
    ld a, [wC46B]
    cp a, $01
    call z, Func_001_4D93
    ld a, [wC46B]
    cp a, $02
    call z, Func_001_4DB1
    ld a, [wC46B]
    add a, $01
    cp a, $03
    jr nz, Jump_001_4CB0
    ld a, $00

Jump_001_4CB0::
    ld [wC46B], a
    ld a, $69
    call StoreWC60B

Jump_001_4CB8::
    ld a, [wC46B]
    ld c, a
    ld b, $00
    ld hl, wC0A0
    add hl, bc
    ld a, [wC563]
    and a, $10
    jr z, Jump_001_4CCF
    inc [hl]
    call Func_001_4E3B
    jr Jump_001_4CE5

Jump_001_4CCF::
    ld a, [wC563]
    and a, $20
    jr z, Jump_001_4CDC
    dec [hl]
    call Func_001_4E3B
    jr Jump_001_4CE5

Jump_001_4CDC::
    ld a, [wC562]
    and a, $08
    jr z, Jump_001_4D44
    xor a, a
    ld [hl], a

Jump_001_4CE5::
    ld a, $69
    call StoreWC60B
    ld a, [wC46B]
    ld b, $21
    cp a, $00
    call z, Func_001_4DED
    ld a, [wC0A0]
    add a, a
    ld hl, Data_001_4E54
    add_a_to_hl
    push hl
    inc hl
    ld a, [hl]
    pop hl
    cp a, $00
    jr z, Jump_001_4D0C
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [de]

Jump_001_4D0C::
    ld b, a
    ld a, [wC46B]
    cp a, $01
    call z, Func_001_4DED
    ld a, [wC0A0]
    add a, a
    ld hl, Data_001_4E54
    add_a_to_hl
    push hl
    inc hl
    ld a, [hl]
    pop hl
    cp a, $00
    jr nz, Jump_001_4D2C
    ld a, [hl]
    jr Jump_001_4D3B

Jump_001_4D2C::
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld h, b
    ld l, c
    ld a, [wC0A1]
    inc a
    add_a_to_hl
    ld a, [hl]

Jump_001_4D3B::
    ld b, a
    ld a, [wC46B]
    cp a, $02
    call z, Func_001_4DED

Jump_001_4D44::
    ld a, [wC562]
    and a, $02
    jr z, Jump_001_4D54
    xor a, a
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_4D54::
    ld a, [wC46B]
    cp a, $00
    jr nz, Jump_001_4D79
    ld a, [wC5F0]
    bit 3, a
    jr nz, Func_001_4D6E
    xor a, a
    ld hl, vBGMap0 + $6D
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr Jump_001_4DBC

; 2 call sites from 1 routine (e.g. Func_001_4AD4)
; reads: wC0A0, wC46B, wC0A1, wC0A2
Func_001_4D6E::
    ld a, [wC0A0]
    ld de, vBGMap0 + $6D
    call Func_001_6A7E
    jr Jump_001_4DBC

Jump_001_4D79::
    ld a, [wC46B]
    cp a, $01
    jr nz, Jump_001_4D9E
    ld a, [wC5F0]
    bit 3, a
    jr nz, Func_001_4D93
    xor a, a
    ld hl, vBGMap0 + $AD
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr Jump_001_4DBC

; 2 call sites from 1 routine (e.g. Func_001_4AD4)
; reads: wC0A1, wC46B, wC0A0, wC0A2
Func_001_4D93::
    ld a, [wC0A1]
    ld de, vBGMap0 + $AD
    call Func_001_6A7E
    jr Jump_001_4DBC

Jump_001_4D9E::
    ld a, [wC5F0]
    bit 3, a
    jr nz, Func_001_4DB1
    xor a, a
    ld hl, vBGMap0 + $ED
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr Jump_001_4DBC

; 2 call sites from 1 routine (e.g. Func_001_4AD4)
; reads: wC0A2, wC46B, wC0A0, wC0A1
Func_001_4DB1::
    ld a, [wC0A2]
    ld de, vBGMap0 + $ED
    call Func_001_6A7E
    jr Jump_001_4DBC

Jump_001_4DBC::
    ld a, [wC46B]
    cp a, $00
    jr z, Jump_001_4DCC
    ld a, [wC0A0]
    ld de, vBGMap0 + $6D
    call Func_001_6A7E

Jump_001_4DCC::
    ld a, [wC46B]
    cp a, $01
    jr z, Jump_001_4DDC
    ld a, [wC0A1]
    ld de, vBGMap0 + $AD
    call Func_001_6A7E

Jump_001_4DDC::
    ld a, [wC46B]
    cp a, $02
    jr z, Jump_001_4DEC
    ld a, [wC0A2]
    ld de, vBGMap0 + $ED
    call Func_001_6A7E

Jump_001_4DEC::
    ret

; 3 call sites from 1 routine (e.g. Func_001_4AD4)
; reads: wC46B, wC0A0, wC0A1, wC0A2
; points at: wC0A0
Func_001_4DED::
    push af
    ld a, [wC46B]
    ld hl, wC0A0
    add_a_to_hl
    ld a, b
    cp a, $FF
    jr z, Jump_001_4E0C
    ld a, [hl]
    inc b
    cp a, b
    jr nz, Jump_001_4E05
    ld [hl], $00

Jump_001_4E05::
    dec b
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_001_4E0C
    ld [hl], b

Jump_001_4E0C::
    ld a, [wC46B]
    cp a, $00
    jr nz, Jump_001_4E1B
    ld de, vBGMap0 + $6D
    ld a, [wC0A0]
    jr Jump_001_4E30

Jump_001_4E1B::
    ld a, [wC46B]
    cp a, $01
    jr nz, Jump_001_4E2A
    ld de, vBGMap0 + $AD
    ld a, [wC0A1]
    jr Jump_001_4E30

Jump_001_4E2A::
    ld de, vBGMap0 + $ED
    ld a, [wC0A2]

Jump_001_4E30::
    add_a_to_hl
    ld a, [hl]
    call Func_001_6A7E
    pop af
    ret

; 2 call sites from 1 routine (e.g. Func_001_4AD4)
; reads: wC46B
; writes: wC0A1, wC0A2
Func_001_4E3B::
    ld a, [wC46B]
    cp a, $00
    jr nz, Jump_001_4E4B
    xor a, a
    ld [wC0A1], a
    xor a, a
    ld [wC0A2], a
    ret

Jump_001_4E4B::
    cp a, $01
    jr nz, Jump_001_4E53
    xor a, a
    ld [wC0A2], a

Jump_001_4E53::
    ret

Data_001_4E54:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $004E54, $80

Jump_001_4ED4::
    ld a, [wC562]
    bit 1, a
    jr z, Jump_001_4EE7
    xor a, a
    ld [wC5DB], a
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_4EE7::
    ld a, [wC563]
    bit 5, a
    jr z, Jump_001_4F34
    ld a, [wC55E]
    bit 2, a
    jr nz, Jump_001_4F07
    ld a, [wC5F8]
    sub a, $01
    ld [wC5F8], a
    ld a, [wC5F9]
    sbc a, $00
    ld [wC5F9], a
    jr Jump_001_4F1F

Jump_001_4F07::
    ld a, [wC5F8]
    ld l, a
    ld a, [wC5F9]
    ld h, a
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wC5F8], a
    ld a, h
    ld [wC5F9], a

Jump_001_4F1F::
    ld a, [wC5F8]
    ld l, a
    ld a, [wC5F9]
    ld h, a
    ld bc, $02AB
    call CompareHLToBC
    jr c, Func_001_4F80
    ld hl, $02AB
    jr Func_001_4F80

Jump_001_4F34::
    ld a, [wC563]
    bit 4, a
    jp z, Jump_001_50EC
    ld a, [wC55E]
    bit 2, a
    jr nz, Jump_001_4F55
    ld a, [wC5F8]
    add a, $01
    ld [wC5F8], a
    ld a, [wC5F9]
    adc a, $00
    ld [wC5F9], a
    jr Jump_001_4F6D

Jump_001_4F55::
    ld a, [wC5F8]
    ld l, a
    ld a, [wC5F9]
    ld h, a
    ld a, l
    add a, $10
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld [wC5F8], a
    ld a, h
    ld [wC5F9], a

Jump_001_4F6D::
    ld a, [wC5F8]
    ld l, a
    ld a, [wC5F9]
    ld h, a
    ld bc, $02AB
    call CompareHLToBC
    jr c, Func_001_4F80
    ld hl, $0000

; 1 call site from 1 routine (e.g. Func_001_4045)
; reads: wCFE6, wCFE7, wC52D, wC52E, wC52F, wC530, wCFEC, wCFED, ...
; writes: wC5F8, wC5F9, wCFE6, wCFE7, wStringCategory, wStringIndex, wC52D, wC52E, ...
Func_001_4F80::
    ld a, l
    ld [wC5F8], a
    ld a, h
    ld [wC5F9], a
    ld a, l
    ld [wCFE6], a
    ld a, h
    ld [wCFE7], a
    farcall Func_034_4001
    ld a, [wCFE6]
    ld hl, vBGMap0 + $24
    ld bc, $0100
    call Func_001_5420
    ld a, [wCFE7]
    ld hl, vBGMap0 + $24
    call Func_001_542C
    ld a, [wCFE7]
    ld [wStringCategory], a
    ld a, [wCFE6]
    ld [wStringIndex], a
    ld hl, vTiles2 + $400
    ld de, $0901
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
    farcall ShowString_Bank88
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
    ld a, [wCFEC]
    ld hl, vBGMap0 + $4F
    ld bc, $0100
    call Func_001_5420
    ld a, [wCFED]
    ld hl, vBGMap0 + $4F
    call Func_001_542C
    ld a, [wCFEE]
    ld hl, vBGMap0 + $66
    ld bc, $0100
    call Func_001_5420
    ld a, [wCFEF]
    inc hl
    call Func_001_5420
    ld a, [wCFF0]
    inc hl
    call Func_001_5420
    ld a, [wCFF1]
    inc hl
    call Func_001_5420
    ld a, [wCFF2]
    ld e, a
    ld a, [wCFF3]
    ld d, a
    ld hl, vBGMap0 + $8D
    ld bc, $0100
    call Func_001_536C
    ld a, [wCFF4]
    ld hl, vBGMap0 + $AF
    ld bc, $0100
    call Func_001_53DC
    ld a, [wCFF5]
    ld hl, vBGMap0 + $CF
    ld bc, $0100
    call Func_001_53DC
    ld a, [wCFF6]
    ld e, a
    ld a, [wCFF7]
    ld d, a
    ld hl, vBGMap0 + $ED
    ld bc, $0100
    call Func_001_536C
    ld a, [wCFF8]
    ld e, a
    ld a, [wCFF9]
    ld d, a
    ld hl, vBGMap0 + $10D
    ld bc, $0100
    call Func_001_536C
    ld a, [wCFFA]
    ld e, a
    ld a, [wCFFB]
    ld d, a
    ld hl, vBGMap0 + $12D
    ld bc, $0100
    call Func_001_536C
    ld a, [wCFFC]
    ld e, a
    ld a, [wCFFD]
    ld d, a
    ld hl, vBGMap0 + $14D
    ld bc, $0100
    call Func_001_536C
    ld a, [wCFFE]
    ld e, a
    ld a, [wCFFF]
    ld d, a
    ld hl, vBGMap0 + $16D
    ld bc, $0100
    call Func_001_536C
    ld a, [wD000]
    ld e, a
    ld a, [wD001]
    ld d, a
    ld hl, vBGMap0 + $18D
    ld bc, $0100
    call Func_001_536C
    ld a, [wD002]
    ld hl, vBGMap0 + $1AF
    ld bc, $0100
    call Func_001_53DC
    ld a, [wD003]
    ld hl, vBGMap0 + $1CF
    ld bc, $0100
    call Func_001_53DC
    ld a, [wD004]
    ld hl, vBGMap0 + $1EF
    ld bc, $0100
    call Func_001_53DC
    ld a, [wD005]
    ld hl, vBGMap0 + $20F
    ld bc, $0100
    call Func_001_53DC

Jump_001_50EC::
    ret

Jump_001_50ED::
    ld a, [wC562]
    bit 1, a
    jr z, Jump_001_5100
    xor a, a
    ld [wC5DB], a
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_5100::
    ld a, [wC563]
    bit 5, a
    jr z, Jump_001_5117
    ld a, [wC5F8]
    dec a
    ld [wC5F8], a
    cp a, $AF
    jr c, Jump_001_5117
    ld a, $AE
    ld [wC5F8], a

Jump_001_5117::
    ld a, [wC563]
    bit 4, a
    jr z, Jump_001_512D
    ld a, [wC5F8]
    inc a
    ld [wC5F8], a
    cp a, $AF
    jr c, Jump_001_512D
    xor a, a
    ld [wC5F8], a

Jump_001_512D::
    ld hl, wC5F8
    ld a, [hl+]
    cp a, [hl]
    ld [hl], a
    ret z
    ld hl, vBGMap0 + $46
    ld bc, $0100
    call Func_001_5420
    ld a, [wC5F8]
    ld [wCFEC], a
    xor a, a
    ld [wCFED], a
    xor a, a
    ld [wD868], a
    ld a, $11
    ld [wD869], a
    ld hl, wCFEE
    ld a, l
    ld [wD86A], a
    ld a, h
    ld [wD86B], a
    farcall Func_01A_4022
    ld a, [wCFEE]
    ld hl, vBGMap0 + $90
    ld bc, $0100
    call Func_001_53DC
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCFEC]
    or a, a
    jr nz, Jump_001_517F
    ld a, $0E
    ld [wStringCategory], a
    ld a, $01

Jump_001_517F::
    ld [wStringIndex], a
    ld hl, vTiles1 + $200
    ld de, $0901
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $12
    ld [wStringCategory], a
    ld a, [wCFEF]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0501
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $13
    ld [wStringCategory], a
    ld a, [wCFF0]
    ld [wStringIndex], a
    ld hl, vTiles1 + $50
    ld de, $0401
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $14
    ld [wStringCategory], a
    ld a, [wCFF1]
    and a, $03
    ld [wStringIndex], a
    ld hl, vTiles1 + $90
    ld de, $0401
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $10
    ld [wStringCategory], a
    ld a, [wCFF1]
    and a, $F0
    swap a
    ld [wStringIndex], a
    ld hl, vTiles1 + $D0
    ld de, $0801
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $11
    ld [wStringCategory], a
    ld a, [wCFF2]
    call Func_001_5311
    ld [wStringIndex], a
    ld hl, vTiles1 + $150
    ld de, $0801
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, [wCFF3]
    ld hl, vBGMap0 + $14B
    ld bc, $0801
    call Func_001_5344
    ld a, [wCFF4]
    ld hl, vBGMap0 + $16B
    ld bc, $0801
    call Func_001_5344
    ld a, [wCFF5]
    ld hl, vBGMap0 + $18B
    ld bc, $0801
    call Func_001_5344
    ld a, [wCFF6]
    ld hl, vBGMap0 + $1AB
    ld bc, $0801
    call Func_001_5344
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF8]
    ld h, a
    call Func_001_52AF
    ld hl, vBGMap0 + $1EA
    ld bc, $0100
    call Func_001_52CD
    ld a, [wCFF7]
    ld l, a
    ld a, [wCFF8]
    ld h, a
    ld a, [wCFF9]
    ld e, a
    ld a, [wCFFA]
    ld d, a
    add hl, de
    call Func_001_52AF
    ld hl, vBGMap0 + $1EF
    ld bc, $0100
    call Func_001_52CD
    ld a, [wCFFB]
    ld l, a
    ld a, [wCFFC]
    ld h, a
    call Func_001_52AF
    ld hl, vBGMap0 + $20A
    ld bc, $0100
    call Func_001_52CD
    ld a, [wCFFB]
    ld l, a
    ld a, [wCFFC]
    ld h, a
    ld a, [wCFFD]
    ld e, a
    ld a, [wCFFE]
    ld d, a
    add hl, de
    call Func_001_52AF
    ld hl, vBGMap0 + $20F
    ld bc, $0100
    call Func_001_52CD
    ret

; 4 call sites from 1 routine (e.g. Func_001_4F80)
; writes: wC8C0, wC8C1, wC8C2, hFFC7, hFFC6
; points at: hFFC9
Func_001_52AF::
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld hl, hFFC9
    ld a, [hl-]
    or a, [hl]
    ret z
    ld a, $99
    ldh [hFFC7], a
    ld a, $99
    ldh [hFFC6], a
    ret

; 4 call sites from 1 routine (e.g. Func_001_4F80)
; reads: hFFC7, hFFC6
Func_001_52CD::
    ld e, $00
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, c
    jr z, Jump_001_52DD
    ld a, d
    add a, b

Jump_001_52DD::
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC7]
    and a, $0F
    ld d, a
    or a, e
    ld e, a
    ld a, c
    jr z, Jump_001_52EE
    ld a, d
    add a, b

Jump_001_52EE::
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC6]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, c
    jr z, Jump_001_5301
    ld a, d
    add a, b

Jump_001_5301::
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC6]
    and a, $0F
    add a, b
    di
    call WriteVRAMByteInc
    ei
    ret

; 1 call site from 1 routine (e.g. Func_001_4F80)
Func_001_5311::
    or a, a
    ret z
    ld c, $01
    cp a, $11
    jr z, Jump_001_5342
    inc c
    cp a, $12
    jr z, Jump_001_5342
    inc c
    cp a, $14
    jr z, Jump_001_5342
    inc c
    cp a, $21
    jr z, Jump_001_5342
    inc c
    cp a, $22
    jr z, Jump_001_5342
    inc c
    cp a, $31
    jr z, Jump_001_5342
    inc c
    cp a, $32
    jr z, Jump_001_5342
    inc c
    cp a, $40
    jr z, Jump_001_5342
    inc c
    cp a, $80
    jr z, Jump_001_5342
    inc c

Jump_001_5342::
    ld a, c
    ret

; 4 call sites from 1 routine (e.g. Func_001_4F80)
Func_001_5344::
    ld d, a
    ld e, $00

Jump_001_5347::
    push hl
    ld a, e
    ld hl, Data_001_5364
    add_a_to_hl
    ld a, d
    and a, [hl]
    jr z, Jump_001_5357
    ld a, $01

Jump_001_5357::
    add a, c
    pop hl
    di
    call WriteVRAMByte
    ei
    inc hl
    inc e
    dec b
    jr nz, Jump_001_5347
    ret

Data_001_5364:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

; 7 call sites from 1 routine (e.g. Func_001_4F80)
; reads: hFFC8, hFFC7, hFFC6
; writes: wC8C0, wC8C1, wC8C2
Func_001_536C::
    push bc
    push hl
    ld a, e
    ld [wC8C0], a
    ld a, d
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    pop hl
    pop bc
    ld e, $00
    ldh a, [hFFC8]
    and a, $0F
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, Jump_001_538E
    ld a, c
    jr Jump_001_538F

Jump_001_538E::
    add a, b

Jump_001_538F::
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, Jump_001_53A3
    ld a, c
    jr Jump_001_53A4

Jump_001_53A3::
    add a, b

Jump_001_53A4::
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC7]
    and a, $0F
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, Jump_001_53B6
    ld a, c
    jr Jump_001_53B7

Jump_001_53B6::
    add a, b

Jump_001_53B7::
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC6]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, Jump_001_53CB
    ld a, c
    jr Jump_001_53CC

Jump_001_53CB::
    add a, b

Jump_001_53CC::
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hFFC6]
    and a, $0F
    add a, b
    di
    call WriteVRAMByte
    ei
    ret

; 7 call sites from 1 routine (e.g. Func_001_4F80)
Func_001_53DC::
    cp a, $64
    jr nc, Jump_001_53EE
    call Func_001_5417
    inc hl
    cp a, $0A
    jr nc, Jump_001_53F7
    call Func_001_5417
    inc hl
    jr Jump_001_5400

Jump_001_53EE::
    ld e, $64
    call Func_001_5405
    call Func_001_540D
    inc hl

Jump_001_53F7::
    ld e, $0A
    call Func_001_5405
    call Func_001_540D
    inc hl

Jump_001_5400::
    ld d, a
    call Func_001_540D
    ret

; 2 call sites from 1 routine (e.g. Func_001_53DC)
Func_001_5405::
    ld d, $FF

Jump_001_5407::
    inc d
    sub a, e
    jr nc, Jump_001_5407
    add a, e
    ret

; 5 call sites from 3 routines (e.g. Func_001_53DC, Func_001_542C, Func_001_5420)
Func_001_540D::
    push af
    ld a, d
    add a, b
    di
    call WriteVRAMByte
    ei
    pop af
    ret

; 2 call sites from 1 routine (e.g. Func_001_53DC)
Func_001_5417::
    push af
    ld a, c
    di
    call WriteVRAMByte
    ei
    pop af
    ret

; 7 call sites from 1 routine (e.g. Func_001_4F80)
Func_001_5420::
    inc hl
    push af
    swap a
    and a, $0F
    ld d, a
    call Func_001_540D
    inc hl
    pop af

; 2 call sites from 1 routine (e.g. Func_001_4F80)
Func_001_542C::
    and a, $0F
    ld d, a
    call Func_001_540D
    ret

Jump_001_5433::
    farcall Func_0E0_5AD3
    ret

Jump_001_543A::
    ld a, [wD780]
    and a, a
    jp z, Jump_001_56F1
    cp a, $01
    jp z, Jump_001_5564
    ld a, [wC563]
    bit 0, a
    jp nz, Jump_001_59DC
    bit 1, a
    jp nz, Jump_001_59BA
    bit 4, a
    jp nz, Jump_001_54C1
    bit 5, a
    jp nz, Jump_001_54D5
    bit 6, a
    jp nz, Jump_001_547A
    bit 7, a
    jp nz, Jump_001_549D
    bit 3, a
    jr nz, Jump_001_546F
    call Func_001_54E8
    ret

Jump_001_546F::
    call Func_001_54FB
    xor a, a
    ld [wD780], a
    ld [wD7BD], a
    ret

Jump_001_547A::
    ld a, [wC5F8]
    cp a, $04
    jr nz, Jump_001_5486
    ld hl, wD787
    jr Jump_001_5489

Jump_001_5486::
    ld hl, wD7A2

Jump_001_5489::
    ld a, [wD7BD]
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr nz, Jump_001_5497
    ld a, $04

Jump_001_5497::
    dec a
    ld [hl], a
    call Func_001_54E8
    ret

Jump_001_549D::
    ld a, [wC5F8]
    cp a, $04
    jr nz, Jump_001_54A9
    ld hl, wD787
    jr Jump_001_54AC

Jump_001_54A9::
    ld hl, wD7A2

Jump_001_54AC::
    ld a, [wD7BD]
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr c, Jump_001_54BB
    ld a, $FF

Jump_001_54BB::
    inc a
    ld [hl], a
    call Func_001_54E8
    ret

Jump_001_54C1::
    call Func_001_54FB
    ld a, [wD7BD]
    cp a, $1A
    jr c, Jump_001_54CD
    ld a, $FF

Jump_001_54CD::
    inc a
    ld [wD7BD], a
    call Func_001_54E8
    ret

Jump_001_54D5::
    call Func_001_54FB
    ld a, [wD7BD]
    and a, a
    jr nz, Jump_001_54E0
    ld a, $1B

Jump_001_54E0::
    dec a
    ld [wD7BD], a
    call Func_001_54E8
    ret

; 5 call sites from 1 routine (e.g. Func_001_542C)
; reads: wC5FF, wC5F8, wD7BD, wC8C2
; writes: wC5FF
; points at: wD787, wD7A2
Func_001_54E8::
    ld a, [wC5FF]
    inc a
    ld [wC5FF], a
    cp a, $10
    jr c, Func_001_54FB
    cp a, $18
    jr c, Jump_001_552A
    xor a, a
    ld [wC5FF], a

; 3 call sites from 1 routine (e.g. Func_001_542C)
; reads: wC5F8, wD7BD, wC8C2
; points at: wD787, wD7A2
Func_001_54FB::
    ld a, [wC5F8]
    cp a, $04
    jr nz, Jump_001_5507
    ld hl, wD787
    jr Jump_001_550A

Jump_001_5507::
    ld hl, wD7A2

Jump_001_550A::
    ld a, [wD7BD]
    add_a_to_hl
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call Func_001_5535
    ld a, [wC8C2]
    add a, $10
    ld c, a
    di
    call WaitForVRAMAccess
    ld a, c
    ld [hl], a
    ei
    ret

Jump_001_552A::
    call Func_001_5535
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ret

; 2 call sites from 1 routine (e.g. Func_001_54FB)
; reads: wC5F8, wD7BD
Func_001_5535::
    ld a, [wC5F8]
    cp a, $04
    jr nz, Jump_001_5541
    ld de, Data_001_555C
    jr Jump_001_5544

Jump_001_5541::
    ld de, Data_001_5560

Jump_001_5544::
    ld a, [wD7BD]
    cp a, $0E
    jr c, Jump_001_554F
    sub a, $0E
    inc de
    inc de

Jump_001_554F::
    push af
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop af
    add_a_to_hl
    ret

Data_001_555C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $86, $99, $A6, $99

Data_001_5560:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E6, $99, $06, $9A

Jump_001_5564::
    ld a, [wD7F1]
    and a, a
    jr z, Jump_001_5572
    cp a, $02
    jr z, Jump_001_5572
    xor a, a
    ld [wD7F1], a

Jump_001_5572::
    farcall Func_00E_5688
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7F1]
    push af
    ld a, [wD7F7]
    cp a, $FF
    jr nz, Jump_001_5590
    ld a, [wD7F6]
    cp a, $FF
    jr z, Jump_001_55D8

Jump_001_5590::
    ld a, [wD7F6]
    ld [wD7F1], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld de, Data_001_75C5
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    farcall Func_015_68FA
    ld a, [wD7F5]
    cp a, $FF
    jr z, Jump_001_561F
    call Func_001_5BE8
    ld hl, vTiles2 + $500
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
    ld de, vTiles2 + $500
    call CopyGlyphTilesToVRAM
    jr Jump_001_5638

Jump_001_55D8::
    call Func_001_5BE8
    ld hl, vTiles2 + $500
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
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call FillTilesFromRequest
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ld de, vTiles2 + $500
    call CopyGlyphTilesToVRAM
    ld bc, $0000
    ld de, vBGMap0 + $6A
    call Func_001_6A98
    xor a, a
    ld [wD780], a
    ld [wCFA8], a
    ret

Jump_001_561F::
    ld hl, vTiles2 + $500
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

Jump_001_5638::
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call FillTilesFromRequest
    ld de, wD7F6
    ld hl, vTiles2 + $200
    call Func_001_5B98
    ld a, [wD7F6]
    ld c, a
    ld a, [wD7F7]
    ld b, a
    ld de, vBGMap0 + $6A
    call Func_001_6A98
    ld hl, wCADE
    ld a, [hl]
    and a, $01
    add a, $FE
    ld c, a
    ld hl, vBGMap0 + $71
    di
    call WaitForVRAMAccess
    ld a, c
    ld [hl], a
    ei
    ld hl, wCB3D
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $2
    call Func_001_5B2D
    call Func_001_56D3
    ld hl, wCB26
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $22
    call Func_001_5B2D
    call Func_001_56D3
    ld hl, wCB27
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $42
    call Func_001_5B2D
    call Func_001_56D3
    ld hl, wCB43
    ld de, vBGMap0 + $6
    ld c, $00

Jump_001_56A2::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, Jump_001_56A2
    ld de, vBGMap0 + $26
    ld c, $00

Jump_001_56B7::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0D
    jr c, Jump_001_56B7
    pop af
    ld [wD7F1], a
    xor a, a
    ld [wD780], a
    ld [wCFA8], a
    ret

; 3 call sites from 1 routine (e.g. Func_001_5535)
Func_001_56D3::
    ld a, c
    and a, $F0
    swap a
    add a, $10
    ld b, a
    ld a, c
    and a, $0F
    add a, $10
    ld c, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    ld a, c
    ld [de], a
    ei
    ret

Jump_001_56F1::
    ld a, [wC563]
    bit 0, a
    jp nz, Jump_001_59DC
    bit 1, a
    jp nz, Jump_001_59BA
    bit 6, a
    jp nz, Jump_001_5822
    bit 7, a
    jp nz, Jump_001_5832
    bit 4, a
    jp nz, Jump_001_5843
    bit 5, a
    jp nz, Jump_001_58C6
    bit 3, a
    jp nz, Jump_001_5800
    bit 2, a
    jp nz, Jump_001_5720
    call Func_001_5AAC
    ret

Jump_001_5720::
    ld a, [wC5F9]
    ld [wD7F2], a
    ld a, [wC5FA]
    ld [wD7F3], a
    ld a, [wD7F2]
    ld [wD006], a
    ld a, [wD7F3]
    ld [wD007], a
    farcall Func_035_4001
    ld c, $00
    ld de, wD787
    call Func_001_57C7
    ld a, [wC5FC]
    ld [wD7F2], a
    ld a, [wC5FD]
    ld [wD7F3], a
    ld a, [wD7F2]
    ld [wD006], a
    ld a, [wD7F3]
    ld [wD007], a
    farcall Func_035_4001
    ld c, $00
    ld de, wD7A2
    call Func_001_57C7
    ld hl, wD787
    ld de, vBGMap0 + $186
    ld c, $00

Jump_001_5774::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, Jump_001_5774
    ld de, vBGMap0 + $1A6
    ld c, $00

Jump_001_5789::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0D
    jr c, Jump_001_5789
    ld hl, wD7A2
    ld de, vBGMap0 + $1E6
    ld c, $00

Jump_001_57A1::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, Jump_001_57A1
    ld de, vBGMap0 + $206
    ld c, $00

Jump_001_57B6::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0D
    jr c, Jump_001_57B6
    ret

; 2 call sites from 1 routine (e.g. Func_001_56D3)
; reads: wD7F5
; writes: wD7F4
Func_001_57C7::
    push bc
    push de
    ld a, c
    ld [wD7F4], a
    farcall Func_00E_5E1D
    pop de
    pop bc
    ld a, [wD7F5]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $1B
    jr c, Func_001_57C7
    ret

; 1 call site from 1 routine (e.g. Func_001_57E1)
; reads: wD7F1
; writes: wD7F1
Func_001_57E1::
    ld a, [wD7F1]
    and a, a
    jr nz, Jump_001_57EE
    ld a, $02
    ld [wD7F1], a
    jr Jump_001_57F2

Jump_001_57EE::
    xor a, a
    ld [wD7F1], a

Jump_001_57F2::
    di
    call WaitForVRAMAccess
    ld a, [wD7F1]
    add a, $10
    ld [vBGMap0 + $81], a
    ei
    ret

Jump_001_5800::
    ld a, [wC5F8]
    cp a, $04
    jr z, Jump_001_5812
    cp a, $07
    jr z, Jump_001_5812
    call Func_001_57E1
    call Func_001_5AAC
    ret

Jump_001_5812::
    call Func_001_5AC0
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7BD], a
    ret

Jump_001_5822::
    call Func_001_5AC0
    ld a, [wC5F8]
    and a, a
    ret z
    dec a
    ld [wC5F8], a
    call Func_001_5AAC
    ret

Jump_001_5832::
    call Func_001_5AC0
    ld a, [wC5F8]
    cp a, $09
    ret z
    inc a
    ld [wC5F8], a
    call Func_001_5AAC
    ret

Jump_001_5843::
    ld a, [wC5F8]
    and a, a
    jr z, Jump_001_5876
    cp a, $01
    jr z, Jump_001_5858
    cp a, $02
    jr z, Jump_001_5871
    cp a, $03
    jr z, Jump_001_585D
    jp Jump_001_5923

Jump_001_5858::
    ld hl, wC5FB
    jr Jump_001_5860

Jump_001_585D::
    ld hl, wC5FE

Jump_001_5860::
    push hl
    ld a, [hl]
    ld c, a
    and a, a
    jr z, Jump_001_5868
    ld a, $FF

Jump_001_5868::
    inc a
    ld c, a
    pop hl
    ld a, c
    ld [hl], a
    call Func_001_5AAC
    ret

Jump_001_5871::
    ld hl, wC5FC
    jr Jump_001_5879

Jump_001_5876::
    ld hl, wC5F9

Jump_001_5879::
    push hl
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    cp a, $01
    jr c, Jump_001_588A
    ld a, c
    cp a, $74
    jr c, Jump_001_588A
    ld bc, rIE

Jump_001_588A::
    inc bc
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl], a
    call Func_001_5AAC
    ld a, [wC5F8]
    cp a, $02
    jr z, Jump_001_58A2
    ld de, wC5F9
    ld hl, vTiles2 + $300
    jr Jump_001_58A8

Jump_001_58A2::
    ld de, wC5FC
    ld hl, vTiles2 + $400

Jump_001_58A8::
    push de
    push hl
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
    pop hl
    pop de
    call Func_001_5B98
    ret

Jump_001_58C6::
    ld a, [wC5F8]
    and a, a
    jr z, Jump_001_58F2
    cp a, $01
    jr z, Jump_001_58DB
    cp a, $02
    jr z, Jump_001_58F7
    cp a, $03
    jr z, Jump_001_58E0
    jp Jump_001_596F

Jump_001_58DB::
    ld hl, wC5FB
    jr Jump_001_58E3

Jump_001_58E0::
    ld hl, wC5FE

Jump_001_58E3::
    push hl
    ld a, [hl]
    cp a, $01
    jr z, Jump_001_58EB
    ld a, $02

Jump_001_58EB::
    dec a
    pop hl
    ld [hl], a
    call Func_001_5AAC
    ret

Jump_001_58F2::
    ld hl, wC5F9
    jr Jump_001_58FA

Jump_001_58F7::
    ld hl, wC5FC

Jump_001_58FA::
    push hl
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    and a, a
    jr nz, Jump_001_5909
    ld a, c
    and a, a
    jr nz, Jump_001_5909
    ld bc, $0175

Jump_001_5909::
    dec bc
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl], a
    call Func_001_5AAC
    ld a, [wC5F8]
    cp a, $02
    jp z, Jump_001_58A2
    ld de, wC5F9
    ld hl, vTiles2 + $300
    jp Jump_001_58A8

Jump_001_5923::
    cp a, $04
    jr z, Jump_001_5939
    cp a, $05
    jr z, Jump_001_5953
    cp a, $06
    jr z, Jump_001_5961
    cp a, $07
    jr z, Jump_001_5940
    cp a, $08
    jr z, Jump_001_595A
    jr Jump_001_5968

Jump_001_5939::
    ld hl, wD781
    ld c, $63
    jr Jump_001_5945

Jump_001_5940::
    ld hl, wD782
    ld c, $63

Jump_001_5945::
    push hl
    ld a, [hl]
    cp a, c
    jr c, Jump_001_594C
    ld a, $FF

Jump_001_594C::
    inc a
    pop hl
    ld [hl], a
    call Func_001_5AAC
    ret

Jump_001_5953::
    ld hl, wD783
    ld c, $63
    jr Jump_001_5945

Jump_001_595A::
    ld hl, wD784
    ld c, $63
    jr Jump_001_5945

Jump_001_5961::
    ld hl, wD785
    ld c, $1B
    jr Jump_001_5945

Jump_001_5968::
    ld hl, wD786
    ld c, $1B
    jr Jump_001_5945

Jump_001_596F::
    cp a, $04
    jr z, Jump_001_5985
    cp a, $05
    jr z, Jump_001_599E
    cp a, $06
    jr z, Jump_001_59AC
    cp a, $07
    jr z, Jump_001_598C
    cp a, $08
    jr z, Jump_001_59A5
    jr Jump_001_59B3

Jump_001_5985::
    ld hl, wD781
    ld c, $64
    jr Jump_001_5991

Jump_001_598C::
    ld hl, wD782
    ld c, $64

Jump_001_5991::
    push hl
    ld a, [hl]
    and a, a
    jr nz, Jump_001_5997
    ld a, c

Jump_001_5997::
    dec a
    pop hl
    ld [hl], a
    call Func_001_5AAC
    ret

Jump_001_599E::
    ld hl, wD783
    ld c, $64
    jr Jump_001_5991

Jump_001_59A5::
    ld hl, wD784
    ld c, $64
    jr Jump_001_5991

Jump_001_59AC::
    ld hl, wD785
    ld c, $1C
    jr Jump_001_5991

Jump_001_59B3::
    ld hl, wD786
    ld c, $1C
    jr Jump_001_5991

Jump_001_59BA::
    xor a, a
    ld [wC5F8], a
    ld [wC5F9], a
    ld [wC5FA], a
    ld [wC5FB], a
    ld [wC5FC], a
    ld [wC5FD], a
    ld [wC5FE], a
    ld [wC5FF], a
    xor a, a
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_59DC::
    ld a, [wD783]
    cp a, $0A
    ret c
    ld a, [wD784]
    cp a, $0A
    ret c
    ld hl, wC5FB
    ld de, wC5FE
    ld a, [hl]
    ld b, a
    ld a, [de]
    cp a, b
    jr nz, Jump_001_59F5
    ret

Jump_001_59F5::
    ld hl, wC986
    ld bc, $01EF

Jump_001_59FB::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_001_59FB
    ld hl, wC991
    ld a, [wC5F9]
    ld [hl+], a
    ld a, [wC5FA]
    ld [hl+], a
    ld hl, wCA36
    ld a, [wC5FC]
    ld [hl+], a
    ld a, [wC5FD]
    ld [hl+], a
    ld hl, wC994
    ld a, [wC5FB]
    ld [hl], a
    ld hl, wCA39
    ld a, [wC5FE]
    ld [hl], a
    ld a, [wC5F9]
    ld [wD7F6], a
    ld a, [wC5FA]
    ld [wD7F7], a
    farcall Func_00E_615A
    ld a, [wD7F5]
    ld hl, wC993
    ld [hl], a
    ld a, [wC5FC]
    ld [wD7F6], a
    ld a, [wC5FD]
    ld [wD7F7], a
    farcall Func_00E_615A
    ld a, [wD7F5]
    ld hl, wCA38
    ld [hl], a
    ld hl, wC9F3
    ld a, [wD781]
    ld [hl], a
    ld hl, wCA98
    ld a, [wD782]
    ld [hl], a
    ld hl, wC9DC
    ld a, [wD783]
    ld [hl], a
    ld hl, wCA81
    ld a, [wD784]
    ld [hl], a
    ld hl, wCA2A
    ld a, [wD785]
    ld [hl], a
    ld hl, wCACF
    ld a, [wD786]
    ld [hl], a
    ld hl, wD787
    ld de, wC9F9
    ld b, $1B

Jump_001_5A8A::
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_001_5A8A
    ld hl, wD7A2
    ld de, wCA9E
    ld b, $1B

Jump_001_5A99::
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_001_5A99
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wCFA8], a
    ret

; 10 call sites from 2 routines (e.g. Func_001_56D3, Func_001_57E1)
; reads: wC5FF, wC5F8
; writes: wC5FF
Func_001_5AAC::
    ld a, [wC5FF]
    inc a
    ld [wC5FF], a
    cp a, $10
    jr c, Func_001_5AC0
    cp a, $18
    jp c, Jump_001_5B45
    xor a, a
    ld [wC5FF], a

; 3 call sites from 1 routine (e.g. Func_001_57E1)
; reads: wC5F8
Func_001_5AC0::
    ld a, [wC5F8]
    sla a
    ld de, Data_001_5B70
    add a, e
    ld e, a
    jr nc, Jump_001_5ACD
    inc d

Jump_001_5ACD::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    ld c, a
    inc hl
    ld a, [hl]
    ld b, a
    ld a, [wC5F8]
    cp a, $04
    jr nc, Jump_001_5B14
    bit 0, a
    jr nz, Jump_001_5AF8
    ld a, [wC5F8]
    sla a
    ld hl, Data_001_5B84
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    call Func_001_6A98
    ret

Jump_001_5AF8::
    ld a, [wC5F8]
    sla a
    ld hl, Data_001_5B84
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call WaitForVRAMAccess
    ld a, c
    add a, $FE
    ld [de], a
    ei
    ret

Jump_001_5B14::
    ld a, [wC5F8]
    sla a
    ld hl, Data_001_5B84
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    call Func_001_5B2D
    call Func_001_6A7E
    ret

; 4 call sites from 2 routines (e.g. Func_001_5535, Func_001_5AC0)
; reads: wC8C1, wC8C2
Func_001_5B2D::
    push de
    ld l, c
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, $0F
    swap a
    ld c, a
    ld a, [wC8C2]
    and a, $0F
    or a, c
    ld c, a
    pop de
    ret

Jump_001_5B45::
    ld a, [wC5F8]
    sla a
    ld hl, Data_001_5B84
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    xor a, a
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    xor a, a
    ld [de], a
    inc de
    ei
    ret

Data_001_5B70:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F9, $C5, $FB, $C5, $FC, $C5, $FE, $C5, $81, $D7, $83, $D7, $85, $D7, $82, $D7
    db $84, $D7, $86, $D7

Data_001_5B84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E6, $98, $06, $99, $26, $99, $46, $99, $82, $99, $A2, $99, $C2, $99, $E2, $99
    db $02, $9A, $22, $9A

; 2 call sites from 2 routines (e.g. Func_001_5535, Func_001_57E1)
; writes: wC8D9
Func_001_5B98::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_B01
    pop hl
    ld e, l
    ld d, h
    ld a, $F0
    ld [wC8D9], a
    call CopyGlyphTilesToVRAM
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 1 call site from 1 routine (e.g. Func_001_5B98)
; reads: wDataBank
; writes: wDataBank
; points at: wC8CF
CopyMonsterNameToBuffer_B01::
Func_001_5BAD:: ; address name
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
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
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; 2 call sites from 1 routine (e.g. Func_001_5535)
; points at: wC8CF
Func_001_5BE8::
    ld c, $00
    ld hl, wC8CF

Jump_001_5BED::
    ld a, $98
    ld [hl+], a
    inc c
    ld a, c
    cp a, $09
    jr c, Jump_001_5BED
    ld a, $F0
    ld [hl], a
    ret

Jump_001_5BFA::
    ld a, [wC562]
    bit 0, a
    jp z, Jump_001_5C14
    ld a, [wC5FD]
    cp a, $FF
    jr z, Jump_001_5C10
    ld a, [wC5FE]
    bit 7, a
    jr nz, Jump_001_5C18

Jump_001_5C10::
    call Func_001_5DBA
    ret

Jump_001_5C14::
    bit 1, a
    jr z, Jump_001_5C8D

Jump_001_5C18::
    ld a, [wC5FD]
    cp a, $FF
    ret z
    ld a, [wC5F9]
    ld [wC833], a
    ld a, [wC5FB]
    ldh [hFF8F], a
    ld a, [wC5FC]
    ldh [hFF92], a
    ld a, [wC5FE]
    bit 7, a
    jr z, Jump_001_5C5B
    ld a, [wC5FD]
    and a, $1F
    ld hl, Data_001_5DAD
    add_a_to_hl
    ld a, [hl]
    ldh [hFF90], a
    xor a, a
    ld [wCC44], a
    xor a, a
    ld [wC91F], a
    ld a, $01
    ld [wC5DB], a
    xor a, a
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_5C5B::
    ld a, [wC5FD]
    and a, $7F
    ld [wCC42], a
    farcall Func_060_6CD1
    ld a, $80
    ld [wCC44], a
    xor a, a
    ld [wC91F], a
    ld a, [wCD0D]
    ld [wC190], a
    ld a, [wCD0E]
    ld [wC191], a
    ld a, $01
    ld [wC5DB], a
    ld a, $05
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_5C8D::
    bit 3, a
    jr z, Jump_001_5CA0
    ld a, $00
    ld [wC5DB], a
    ld a, $00
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_5CA0::
    ld a, [wC563]
    bit 6, a
    jr z, Jump_001_5CB6
    ld a, [wC5F8]
    dec a
    cp a, $FF
    jr nz, Jump_001_5CB1
    ld a, $03

Jump_001_5CB1::
    ld [wC5F8], a
    jr Jump_001_5CC6

Jump_001_5CB6::
    bit 7, a
    jr z, Jump_001_5CC6
    ld a, [wC5F8]
    inc a
    cp a, $04
    jr nz, Jump_001_5CC3
    xor a, a

Jump_001_5CC3::
    ld [wC5F8], a

Jump_001_5CC6::
    ld c, $00
    ld a, [wC563]
    bit 5, a
    jr z, Jump_001_5CD3
    ld c, $FF
    jr Jump_001_5CD9

Jump_001_5CD3::
    bit 4, a
    jr z, Jump_001_5CD9
    ld c, $01

Jump_001_5CD9::
    bit 0, c
    jr z, Jump_001_5D3C
    ld a, [wC5F8]
    or a, a
    jr nz, Jump_001_5D00
    ld a, [wC5F9]
    add a, c
    cp a, $20
    jr nz, Jump_001_5CEE
    xor a, a
    jr Jump_001_5CF4

Jump_001_5CEE::
    cp a, $FF
    jr nz, Jump_001_5CF4
    ld a, $13

Jump_001_5CF4::
    or a, $80
    ld [wC5F9], a
    and a, $7F
    call Func_001_5E6C
    jr Jump_001_5D3C

Jump_001_5D00::
    dec a
    jr nz, Jump_001_5D22
    ld a, [wC5FE]
    bit 7, a
    jr nz, Jump_001_5D22
    ld a, [wC5FA]
    add a, c
    cp a, $64
    jr nz, Jump_001_5D15
    xor a, a
    jr Jump_001_5D1B

Jump_001_5D15::
    cp a, $FF
    jr nz, Jump_001_5D1B
    ld a, $63

Jump_001_5D1B::
    or a, $80
    ld [wC5FA], a
    jr Jump_001_5D3C

Jump_001_5D22::
    dec a
    jr nz, Jump_001_5D30
    ld a, [wC5FB]
    add a, c
    and a, $0F
    ld [wC5FB], a
    jr Jump_001_5D3C

Jump_001_5D30::
    dec a
    jr nz, Jump_001_5D3C
    ld a, [wC5FC]
    add a, c
    and a, $0F
    ld [wC5FC], a

Jump_001_5D3C::
    ld a, [wC5F9]
    bit 7, a
    jr z, Jump_001_5D46
    call Func_001_5EAF

Jump_001_5D46::
    ld a, [wC5F9]
    bit 7, a
    jr z, Jump_001_5D55
    and a, $7F
    ld de, vBGMap0 + $10A
    call Func_001_6A7E

Jump_001_5D55::
    ld a, [wC5F9]
    bit 7, a
    jr nz, Jump_001_5D63
    ld a, [wC5FA]
    bit 7, a
    jr z, Jump_001_5D76

Jump_001_5D63::
    ld a, [wC5F9]
    and a, $7F
    ld [wC5F9], a
    ld a, [wC5FA]
    and a, $7F
    ld [wC5FA], a
    call Func_001_5E8A

Jump_001_5D76::
    ld a, [wC5FB]
    ld de, vBGMap0 + $14A
    call Func_001_6A7E
    ld a, [wC5FC]
    ld de, vBGMap0 + $16A
    call Func_001_6A7E
    ld hl, vBGMap0 + $109
    ld b, $00

Jump_001_5D8D::
    ld a, [wC5F8]
    cp a, b
    jr z, Jump_001_5D9A
    ld a, $80
    call WriteVRAMByte
    jr Jump_001_5D9F

Jump_001_5D9A::
    ld a, $F8
    call WriteVRAMByte

Jump_001_5D9F::
    ld a, $20
    add_a_to_hl
    inc b
    ld a, b
    cp a, $05
    jr nz, Jump_001_5D8D
    ret

Data_001_5DAD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $05, $20, $30, $48, $70, $A0, $A8, $B0, $B8, $C8, $D1, $DA

; 1 call site from 1 routine (e.g. Func_001_5BE8)
; reads: wC5FA, wC5F9, wC5FD, hFFC6, hFFC7, hFFC8, hFFC9, wCD0D, ...
; writes: hFFC6, wC833, wCC42, wCD05, wC190, wC191, hFF98, hFF8F, ...
; points at: wC5DF
Func_001_5DBA::
    ld a, [wC5FA]
    ldh [hFFC6], a
    farcall Func_060_6916
    ld a, [wC5F9]
    ld [wC833], a
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
    ld a, [wC5FD]
    cp a, $FF
    jr nz, Jump_001_5DEF
    push hl
    farcall Func_060_6C61
    pop hl
    ldh a, [hFFC6]
    cp a, $FF
    ret z
    ld [hl+], a
    jr Jump_001_5DF3

Jump_001_5DEF::
    ld a, [hl]
    and a, $7F
    ld [hl+], a

Jump_001_5DF3::
    ld [wCC42], a
    ldh a, [hFFC7]
    ld [hl+], a
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl], a
    ld [wCD05], a
    farcall Func_060_4035
    farcall Func_060_6C96
    ld a, [wCD0D]
    ld [wC190], a
    ld a, [wCD0E]
    ld [wC191], a
    xor a, a
    ldh [hFF98], a
    ld a, [wCD08]
    swap a
    and a, $0F
    ldh [hFF8F], a
    ld a, [wCD08]
    and a, $0F
    ldh [hFF92], a
    ld a, [wCD09]
    ldh [hFF8E], a
    ld a, [wCD0A]
    ldh [hFF91], a
    ldh a, [hFF98]
    ld [wC8EF], a
    ld [wC8F4], a
    ld [wC8F9], a
    ldh a, [hFF8E]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hFF91]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ld a, $80
    ld [wCC44], a
    ld a, $01
    ld [wC5DB], a
    ld a, $05
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. Func_001_5BE8, Func_001_4045)
; writes: wC5FD, wC5FE, wC5FA
Func_001_5E6C::
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
    ld [wC5FD], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld [wC5FE], a
    or a, $80
    ld [wC5FA], a
    ret

; 1 call site from 1 routine (e.g. Func_001_5BE8)
; reads: wC5FD, wC5FE, wC5FA
; writes: wC5FA
Func_001_5E8A::
    ld a, [wC5FD]
    cp a, $FF
    jr z, Jump_001_5EA4
    ld a, [wC5FE]
    bit 7, a
    jr nz, Jump_001_5EA4
    ld a, [wC5FA]
    and a, $7F
    ld de, vBGMap0 + $12A
    call Func_001_6A7E
    ret

Jump_001_5EA4::
    xor a, a
    ld [wC5FA], a
    ld de, vBGMap0 + $12A
    call Func_001_6A7E
    ret

; 1 call site from 1 routine (e.g. Func_001_5BE8)
; reads: wC5FE, wC5FD, wC5F9
; writes: wC8CF, wC8D0, wC8D1, wC8D2, wC8D3, wC8D4, wC8D5, wC8D6, ...
; points at: wC8CF
Func_001_5EAF::
    ld a, $90
    ld [wC8CF], a
    ld [wC8D0], a
    ld [wC8D1], a
    ld [wC8D2], a
    ld [wC8D3], a
    ld [wC8D4], a
    ld [wC8D5], a
    ld [wC8D6], a
    ld [wC8D7], a
    ld [wC8D8], a
    ld [wC8D9], a
    ld [wC8DA], a
    ld [wC8DB], a
    ld [wC8DC], a
    ld [wC8DD], a
    ld a, $F0
    ld [wC8DE], a
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ld a, [wC5FE]
    bit 7, a
    jr z, Jump_001_5F1C
    ld a, [wC5FD]
    cp a, $FF
    jr nz, Jump_001_5F1C
    ld a, $29
    ld [wC8CF], a
    ld a, $2A
    ld [wC8D0], a
    ld a, $8D
    ld [wC8D1], a
    ld a, $39
    ld [wC8D2], a
    ld a, $2F
    ld [wC8D3], a
    ld a, $F0
    ld [wC8D4], a
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

Jump_001_5F1C::
    ld a, [wC5FE]
    bit 7, a
    jr z, Jump_001_5F44
    ld a, [wC5FD]
    dec a
    swap a
    and a, $F0
    ld hl, Data_001_5F56
    add_a_to_hl
    ld de, wC8CF

Jump_001_5F36::
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, Jump_001_5F36
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

Jump_001_5F44::
    ld a, [wC5F9]
    and a, $1F
    ld de, wC8CF
    call Func_000_2458
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

Data_001_5F56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $005F56, $A8

Jump_001_5FFE::
    ld a, [wC563]
    bit 0, a
    jr z, Jump_001_604B
    ld a, [wC5F9]
    ldh [hFFC6], a
    call Func_000_1D90
    or a, a
    jr z, Jump_001_601F
    ld b, $08
    ld hl, vBGMap0 + $1A5
    ld a, $F0

Jump_001_6017::
    call WriteVRAMByteInc
    inc a
    dec b
    jr nz, Jump_001_6017
    ret

Jump_001_601F::
    ld a, [wC5F9]
    ldh [hFF90], a
    ld a, [wC5FA]
    ldh [hFF8F], a
    ld a, [wC5FB]
    ldh [hFF8E], a
    ld a, [wC5FC]
    ldh [hFF92], a
    ld a, [wC5FD]
    ldh [hFF91], a
    xor a, a
    ld [wC8C7], a
    ld a, $00
    ld [wC5DB], a
    ld a, $00
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_604B::
    ld a, [wC563]
    bit 6, a
    jr z, Jump_001_6061
    ld a, [wC5F8]
    dec a
    cp a, $FF
    jr nz, Jump_001_605C
    ld a, $04

Jump_001_605C::
    ld [wC5F8], a
    jr Jump_001_6071

Jump_001_6061::
    bit 7, a
    jr z, Jump_001_6071
    ld a, [wC5F8]
    inc a
    cp a, $05
    jr nz, Jump_001_606E
    xor a, a

Jump_001_606E::
    ld [wC5F8], a

Jump_001_6071::
    ld c, $00
    ld a, [wC5F0]
    and a, $03
    jr nz, Jump_001_608B
    ld a, [wC55E]
    bit 5, a
    jr z, Jump_001_6085
    ld c, $FF
    jr Jump_001_608B

Jump_001_6085::
    bit 4, a
    jr z, Jump_001_608B
    ld c, $01

Jump_001_608B::
    bit 0, c
    jr z, Jump_001_60E7
    ld a, [wC5F8]
    or a, a
    jr nz, Jump_001_60A8
    ld a, [wC5F9]
    add a, c
    cp a, $FF
    jr nz, Jump_001_609F
    ld a, $E1

Jump_001_609F::
    ld [wC5F9], a
    ld hl, wC5FE
    inc [hl]
    jr Jump_001_60E7

Jump_001_60A8::
    dec a
    jr nz, Jump_001_60B6
    ld a, [wC5FA]
    add a, c
    and a, $0F
    ld [wC5FA], a
    jr Jump_001_60E7

Jump_001_60B6::
    dec a
    jr nz, Jump_001_60C4
    ld a, [wC5FC]
    add a, c
    and a, $0F
    ld [wC5FC], a
    jr Jump_001_60E7

Jump_001_60C4::
    dec a
    jr nz, Jump_001_60D8
    sla c
    sla c
    sla c
    sla c
    ld a, [wC5FB]
    add a, c
    ld [wC5FB], a
    jr Jump_001_60E7

Jump_001_60D8::
    sla c
    sla c
    sla c
    sla c
    ld a, [wC5FD]
    add a, c
    ld [wC5FD], a

Jump_001_60E7::
    ld a, [wC5FE]
    or a, a
    jr z, Jump_001_6119
    ld a, [wC5F9]
    add a, $0A
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1001
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    farcall ShowString_Bank08
    xor a, a
    ld [wC5FE], a

Jump_001_6119::
    ld a, [wC5FA]
    ld de, vBGMap0 + $10A
    call Func_001_6A7E
    ld a, [wC5FC]
    ld de, vBGMap0 + $12A
    call Func_001_6A7E
    ld a, [wC5FB]
    swap a
    and a, $0F
    ld de, vBGMap0 + $14A
    call Func_001_6A7E
    ld a, [wC5FD]
    swap a
    and a, $0F
    ld de, vBGMap0 + $16A
    call Func_001_6A7E
    ld hl, vBGMap0 + $E9
    ld b, $00

Jump_001_614A::
    ld a, [wC5F8]
    cp a, b
    jr z, Jump_001_6157
    ld a, $80
    call WriteVRAMByte
    jr Jump_001_615C

Jump_001_6157::
    ld a, $F8
    call WriteVRAMByte

Jump_001_615C::
    ld a, $20
    add_a_to_hl
    inc b
    ld a, b
    cp a, $05
    jr nz, Jump_001_614A
    ret

Jump_001_616A::
    ld a, [wC563]
    and a, $90
    jr z, Jump_001_617D
    ld a, [wC5F8]
    inc a
    cp a, $0C
    jr nz, Jump_001_618E
    ld a, $00
    jr Jump_001_618E

Jump_001_617D::
    ld a, [wC563]
    and a, $60
    jr z, Jump_001_6191
    ld a, [wC5F8]
    dec a
    cp a, $FF
    jr nz, Jump_001_618E
    ld a, $0B

Jump_001_618E::
    ld [wC5F8], a

Jump_001_6191::
    ld a, [wC5F8]
    swap a
    add a, $A0
    ld hl, vBGMap0 + $122
    ld b, $10

Jump_001_619D::
    call WriteVRAMByteInc
    inc a
    dec b
    jr nz, Jump_001_619D
    ld a, [wC562]
    and a, $01
    ret z
    ld a, [wC5F8]
    or a, a
    jr nz, Jump_001_61C3
    ld a, $01
    ld [wC5DB], a
    ld hl, wC5DF
    inc [hl]
    xor a, a
    ld [wCC44], a
    ld a, $80
    ld [wC893], a
    ret

Jump_001_61C3::
    dec a
    jr nz, Jump_001_61D5
    ld a, $00
    ld [wC5DB], a
    ld a, $02
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_61D5::
    dec a
    jr nz, Jump_001_61E7
    ld a, $00
    ld [wC5DB], a
    ld a, $03
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_61E7::
    dec a
    jr nz, Jump_001_61FE
    ld a, $00
    ld [wC5DB], a
    ld a, $04
    ld [wC5DC], a
    ld a, $80
    ld [wC8C5], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_61FE::
    dec a
    jr nz, Jump_001_6210
    ld a, $00
    ld [wC5DB], a
    ld a, $05
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_6210::
    dec a
    jr nz, Jump_001_6222
    ld a, $00
    ld [wC5DB], a
    ld a, $06
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_6222::
    dec a
    jr nz, Jump_001_6234
    ld a, $00
    ld [wC5DB], a
    ld a, $07
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_6234::
    dec a
    jr nz, Jump_001_6246
    ld a, $00
    ld [wC5DB], a
    ld a, $08
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_6246::
    dec a
    jr nz, Jump_001_6258
    ld a, $00
    ld [wC5DB], a
    ld a, $09
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_6258::
    dec a
    jr nz, Jump_001_626A
    ld a, $00
    ld [wC5DB], a
    ld a, $0A
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_626A::
    dec a
    jr nz, Jump_001_627C
    ld a, $00
    ld [wC5DB], a
    ld a, $0B
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_627C::
    ld hl, wC5DB
    ld a, [wC600]
    ld [hl+], a
    ld a, [wC601]
    ld [hl+], a
    ld a, [wC602]
    ld [hl+], a
    ld a, [wC603]
    ld [hl], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_6294::
    ld a, [wC562]
    bit 0, a
    jr z, Jump_001_62A6
    ld a, [wC5FD]
    inc a
    and a, $03
    ld [wC5FD], a
    jr Jump_001_62B9

Jump_001_62A6::
    bit 1, a
    jr z, Jump_001_62B9
    ld a, $00
    ld [wC5DB], a
    ld a, $00
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_62B9::
    ld a, [wC562]
    and a, $C0
    jr z, Jump_001_62CA
    ld a, [wC5F8]
    inc a
    and a, $01
    ld [wC5F8], a
    ret

Jump_001_62CA::
    ld a, [wC5F8]
    sla a
    ld de, wC5F9
    add a, e
    ld e, a
    jr nc, Jump_001_62D7
    inc d

Jump_001_62D7::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wC563]
    bit 5, a
    jr z, Jump_001_6318
    dec hl
    ld a, h
    or a, $80
    ld [de], a
    dec de
    ld a, l
    ld [de], a
    ld a, h
    cp a, $FF
    jr nz, Jump_001_634E
    ld a, [wC5F8]
    or a, a
    jr nz, Jump_001_6307
    ld hl, $017E
    ld a, h
    or a, $80
    ld h, a
    ld a, l
    ld [wC5F9], a
    ld a, h
    ld [wC5FA], a
    jr Jump_001_634E

Jump_001_6307::
    ld hl, $017E
    ld a, h
    or a, $80
    ld h, a
    ld a, l
    ld [wC5FB], a
    ld a, h
    ld [wC5FC], a
    jr Jump_001_634E

Jump_001_6318::
    bit 4, a
    jr z, Jump_001_634E
    ld a, [wC5F8]
    or a, a
    jr nz, Jump_001_6334
    ld a, $7E
    cp a, l
    jr nz, Jump_001_6346
    ld a, $01
    cp a, h
    jr nz, Jump_001_6346
    ld a, $80
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    jr Jump_001_634E

Jump_001_6334::
    ld a, $7E
    cp a, l
    jr nz, Jump_001_6346
    ld a, $01
    cp a, h
    jr nz, Jump_001_6346
    ld a, $80
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    jr Jump_001_634E

Jump_001_6346::
    inc hl
    ld a, h
    or a, $80
    ld [de], a
    dec de
    ld a, l
    ld [de], a

Jump_001_634E::
    ld a, [wC5FA]
    bit 7, a
    jr z, Jump_001_6387
    and a, $7F
    ld [wC5FA], a
    ld a, [wC5F9]
    ld e, a
    ld a, [wC5FA]
    ld d, a
    ld hl, vTiles2 + $200
    ld c, $01
    call Func_000_1FE3
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_001_6387
    ld hl, vBGMap0 + $124
    ld a, $01
    ldh [hFFC6], a
    ld a, [wC5F9]
    ld e, a
    ld a, [wC5FA]
    ld d, a
    call Func_000_2090
    ld a, $7F
    ld [wC526], a

Jump_001_6387::
    ld a, [wC5FC]
    bit 7, a
    jr z, Jump_001_63F5
    and a, $7F
    ld [wC5FC], a
    ld a, [wC5FB]
    ld e, a
    ld a, [wC5FC]
    ld d, a
    ld a, [wC5FB]
    ld l, a
    ld a, [wC5FC]
    ld h, a
    add hl, hl
    add hl, de
    ld de, Data_004_4EAA
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    inc de
    call ReadByteInBank
    ld b, c
    ld e, l
    ld d, h
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_001_63F5
    ld a, [wC5FB]
    ld l, a
    ld a, [wC5FC]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    ld hl, wC4DF
    ld c, $08

Jump_001_63E5::
    push bc
    call ReadByteInBank
    ld a, c
    ld [hl+], a
    pop bc
    inc de
    dec c
    jr nz, Jump_001_63E5
    ld a, $7F
    ld [wC527], a

Jump_001_63F5::
    ld hl, wC5FE
    inc [hl]
    ld a, [wC5F8]
    or a, a
    jr nz, Jump_001_6415
    ld a, [wC5FE]
    bit 3, a
    jr z, Jump_001_6415
    xor a, a
    ld hl, vBGMap0 + $AB
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    jr Jump_001_6423

Jump_001_6415::
    ld a, [wC5F9]
    ld c, a
    ld a, [wC5FA]
    ld b, a
    ld de, vBGMap0 + $AB
    call Func_001_6A98

Jump_001_6423::
    ld a, [wC5F8]
    or a, a
    jr z, Jump_001_643F
    ld a, [wC5FE]
    bit 3, a
    jr z, Jump_001_643F
    xor a, a
    ld hl, vBGMap0 + $CB
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    jr Jump_001_644D

Jump_001_643F::
    ld a, [wC5FB]
    ld c, a
    ld a, [wC5FC]
    ld b, a
    ld de, vBGMap0 + $CB
    call Func_001_6A98

Jump_001_644D::
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, [wC5FD]
    cp a, $03
    jr nz, Jump_001_645E
    ld a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

Jump_001_645E::
    sla a
    ld c, a
    ld a, [wC5F0]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld c, a
    ldh a, [hFFA2]
    ld b, a
    ld a, c
    add a, $70
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    ld a, c
    ldh [hSpriteOriginX], a
    ld a, b
    ldh [hFFAA], a
    ldh a, [hScrollY]
    ld c, a
    ldh a, [hFFA6]
    ld b, a
    ld a, c
    add a, $60
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    ld a, c
    ldh [hSpriteOriginY], a
    ld a, b
    ldh [hFFAC], a
    ld a, [wC5FB]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [wC5FC]
    or a, a
    jr nz, Jump_001_64B9
    ld a, [wC5FB]
    bit 7, a
    jr nz, Jump_001_64B2
    farcall Func_025_4001
    ret

Jump_001_64B2::
    farcall Func_026_4001
    ret

Jump_001_64B9::
    farcall Func_027_4001
    ret

Jump_001_64C0::
    ld a, [wC562]
    and a, $08
    jr z, Jump_001_64F0
    ld a, [wC46B]
    or a, a
    jr nz, Jump_001_64E0
    call Func_000_3290
    ld a, [wC0A0]
    ld hl, Data_001_65DE
    add_a_to_hl
    ld a, [hl]
    call Func_000_122D
    ret

Jump_001_64E0::
    ld a, [wC0A1]
    ld hl, Data_001_65FE
    add_a_to_hl
    ld a, [hl]
    call StoreWC60B
    ret

Jump_001_64F0::
    ld a, [wC563]
    and a, $C0
    jr z, Jump_001_6512
    ld a, [wC46B]
    or a, a
    jr nz, Jump_001_6502
    call Func_001_6578
    jr Jump_001_6505

Jump_001_6502::
    call Func_001_6596

Jump_001_6505::
    ld a, [wC46B]
    xor a, $01
    ld [wC46B], a
    ld a, $69
    call StoreWC60B

Jump_001_6512::
    ld a, [wC46B]
    ld c, a
    ld b, $00
    ld hl, wC0A0
    add hl, bc
    ld a, [wC563]
    and a, $10
    jr z, Jump_001_6526
    inc [hl]
    jr Jump_001_6539

Jump_001_6526::
    ld a, [wC563]
    and a, $20
    jr z, Jump_001_6530
    dec [hl]
    jr Jump_001_6539

Jump_001_6530::
    ld a, [wC562]
    and a, $01
    jr z, Jump_001_654F
    xor a, a
    ld [hl], a

Jump_001_6539::
    ld a, $69
    call StoreWC60B
    ld a, [wC46B]
    ld b, $20
    cp a, $00
    call z, Func_001_65A0
    ld b, $54
    cp a, $01
    call z, Func_001_65A0

Jump_001_654F::
    ld a, [wC562]
    and a, $02
    jr z, Jump_001_655F
    xor a, a
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_655F::
    ld a, [wC46B]
    or a, a
    jr nz, Jump_001_6583
    ld a, [wC5F0]
    bit 3, a
    jr nz, Func_001_6578
    xor a, a
    ld hl, vBGMap0 + $E9
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr Jump_001_659F

; 1 call site from 1 routine (e.g. Func_001_5EAF)
; reads: wC0A0
Func_001_6578::
    ld a, [wC0A0]
    ld de, vBGMap0 + $E9
    call Func_001_6A7E
    jr Jump_001_659F

Jump_001_6583::
    ld a, [wC5F0]
    bit 3, a
    jr nz, Func_001_6596
    xor a, a
    ld hl, vBGMap0 + $109
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr Jump_001_659F

; 1 call site from 1 routine (e.g. Func_001_5EAF)
; reads: wC0A1
Func_001_6596::
    ld a, [wC0A1]
    ld de, vBGMap0 + $109
    call Func_001_6A7E

Jump_001_659F::
    ret

; 2 call sites from 1 routine (e.g. Func_001_5EAF)
; reads: wC46B, wC0A0, wC0A1
; points at: wC0A0
Func_001_65A0::
    push af
    ld a, [wC46B]
    ld hl, wC0A0
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jr nz, Jump_001_65B2
    ld [hl], $00

Jump_001_65B2::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_001_65B9
    dec b
    ld [hl], b

Jump_001_65B9::
    ld a, [wC46B]
    or a, a
    jr nz, Jump_001_65CA
    ld hl, Data_001_65DE
    ld de, vBGMap0 + $EC
    ld a, [wC0A0]
    jr Jump_001_65D3

Jump_001_65CA::
    ld hl, Data_001_65FE
    ld de, vBGMap0 + $10C
    ld a, [wC0A1]

Jump_001_65D3::
    add_a_to_hl
    ld a, [hl]
    call Func_001_6A7E
    pop af
    ret

Data_001_65DE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $06, $09, $0C, $0F, $13, $16, $19, $1C, $1F, $22, $25, $28, $2B, $2E, $31
    db $35, $3D, $40, $42, $44, $46, $48, $4A, $4D, $50, $52, $54, $58, $CC, $CF, $D6

Data_001_65FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0065FE, $54

Jump_001_6652::
    ld a, [wC562]
    and a, $08
    jp z, Jump_001_66E8
    ld a, [wD09D]
    ld [wCFDC], a
    ld a, [wD0A5]
    sra a
    ld [wCFC5], a
    or a, a
    jr nz, Jump_001_66BD
    ld hl, wCFDD
    ld de, wD09F
    call Func_001_66AD
    call Func_001_66AD
    call Func_001_66AD

Jump_001_667A::
    xor a, a
    ld [wC46B], a
    xor a, a
    ld [wC5F8], a
    ld [wC5F9], a
    ld [wC5FA], a
    ld a, [wD0A5]
    or a, a
    jr nz, Jump_001_6693
    call Func_001_6880
    jr Jump_001_6696

Jump_001_6693::
    call Func_001_6ABE

Jump_001_6696::
    ld a, $04
    ld [wC5DB], a
    xor a, a
    ld [wC5DC], a
    ld a, $04
    call StartPaletteFade
    ld hl, wC5DF
    inc [hl]
    ld hl, wD066
    inc [hl]
    ret

; 6 call sites from 2 routines (e.g. Func_001_65A0, Func_001_66AD)
Func_001_66AD::
    ld a, [de]
    inc de
    ld [hl+], a
    ld c, a
    ld a, [de]
    inc de
    ld [hl+], a
    or a, c
    ret nz
    dec hl
    dec hl
    ld [hl], $01
    inc hl
    inc hl
    ret

Jump_001_66BD::
    ld hl, wD0A9
    ld a, [hl+]
    ld [wCFDD], a
    ld a, [hl+]
    ld [wCFDE], a
    ld a, [hl+]
    ld [wCFE3], a
    inc hl
    ld a, [hl+]
    ld [wCFDF], a
    ld a, [hl+]
    ld [wCFE0], a
    ld a, [hl+]
    ld [wCFE4], a
    inc hl
    ld a, [hl+]
    ld [wCFE1], a
    ld a, [hl+]
    ld [wCFE2], a
    ld a, [hl+]
    ld [wCFE5], a
    jr Jump_001_667A

Jump_001_66E8::
    ld a, [wC562]
    and a, $01
    jr z, Jump_001_6701
    ld a, [wC46B]
    add a, a
    ld hl, wD09D
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl], a
    jp Jump_001_6801

Jump_001_6701::
    ld a, [wC562]
    and a, $02
    jr z, Jump_001_6734
    ld a, [wD09D]
    ld [wCFDC], a
    ld hl, wCFDD
    ld de, wD09F
    call Func_001_66AD
    call Func_001_66AD
    call Func_001_66AD
    xor a, a
    ld [wC5F8], a
    ld [wC5F9], a
    ld [wC5FA], a
    xor a, a
    ld [wC46B], a
    xor a, a
    ld [wC5DC], a
    ld hl, wC5DF
    inc [hl]
    ret

Jump_001_6734::
    ld a, [wC563]
    bit 6, a
    jr z, Jump_001_674E
    call Func_001_6809
    ld a, [wC46B]
    dec a
    cp a, $FF
    jr nz, Jump_001_6748
    ld a, $0B

Jump_001_6748::
    ld [wC46B], a
    jp Jump_001_6801

Jump_001_674E::
    bit 7, a
    jr z, Jump_001_6764
    call Func_001_6809
    ld a, [wC46B]
    inc a
    cp a, $0C
    jr nz, Jump_001_675E
    xor a, a

Jump_001_675E::
    ld [wC46B], a
    jp Jump_001_6801

Jump_001_6764::
    and a, $30
    jr z, Jump_001_67C9
    ld a, [wC46B]
    add a, a
    ld hl, wD09D
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    dec hl
    ld a, [wC563]
    bit 4, a
    jr z, Jump_001_67A4
    ld a, [wC55E]
    bit 2, a
    jr z, Jump_001_679B
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    call Func_001_6857
    jr Jump_001_679F

Jump_001_679B::
    inc de
    call Func_001_682B

Jump_001_679F::
    call Func_001_6809
    jr Jump_001_6801

Jump_001_67A4::
    ld a, [wC55E]
    bit 2, a
    jr z, Jump_001_67C0
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    call Func_001_6857
    jr Jump_001_67C4

Jump_001_67C0::
    dec de
    call Func_001_682B

Jump_001_67C4::
    call Func_001_6809
    jr Jump_001_6801

Jump_001_67C9::
    ld a, [wC46B]
    ld hl, Data_001_68D3
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wC5F0]
    bit 3, a
    jr nz, Jump_001_67EB
    xor a, a
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr Jump_001_6808

Jump_001_67EB::
    push hl
    ld a, [wC46B]
    add a, a
    ld hl, wD09D
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop de
    call Func_001_6A98
    jr Jump_001_6808

Jump_001_6801::
    xor a, a
    ld [wC5F0], a
    call Func_001_6903

Jump_001_6808::
    ret

; 4 call sites from 1 routine (e.g. Func_001_66AD)
; reads: wC46B
; points at: wD09D
Func_001_6809::
    ld a, [wC46B]
    ld hl, Data_001_68D3
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wC46B]
    ld hl, wD09D
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    call Func_001_6A98
    ret

; 2 call sites from 1 routine (e.g. Func_001_66AD)
; reads: wC46B
Func_001_682B::
    push hl
    ld a, [wC46B]
    ld hl, Data_001_68EB
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, d
    and a, e
    cp a, $FF
    jr z, Jump_001_6850
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    bit 7, b
    jr z, Jump_001_6852
    xor a, a
    ld d, a
    ld e, a
    jr Jump_001_6852

Jump_001_6850::
    ld d, b
    ld e, c

Jump_001_6852::
    pop hl
    ld [hl], e
    inc hl
    ld [hl], d
    ret

; 2 call sites from 1 routine (e.g. Func_001_66AD)
; reads: wC46B
Func_001_6857::
    push hl
    ld a, [wC46B]
    ld hl, Data_001_68EB
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld h, d
    ld l, e
    inc bc
    call CompareHLToBC
    jr c, Jump_001_687B
    dec bc
    bit 7, h
    jr nz, Jump_001_6879
    xor a, a
    ld d, a
    ld e, a
    jr Jump_001_687B

Jump_001_6879::
    ld d, b
    ld e, c

Jump_001_687B::
    pop hl
    ld [hl], e
    inc hl
    ld [hl], d
    ret

; 1 call site from 1 routine (e.g. Func_001_65A0)
; reads: wC6FD, wC7C7, hFFC6
; points at: wC6FE
Func_001_6880::
    ld a, [wC6FD]
    or a, a
    jr z, Jump_001_68B4
    cp a, $04
    jr nc, Jump_001_68B4
    ld b, a
    ld hl, wC6FE
    ld a, [wC7C7]
    cp a, $03
    jr nc, Jump_001_68B4
    ld c, $0A
    cp a, $00
    jr z, Jump_001_68A3
    ld c, $14
    cp a, $01
    jr z, Jump_001_68A3
    ld c, $1E

Jump_001_68A3::
    ld a, [hl+]
    cp a, c
    jr nc, Jump_001_68B4
    push bc
    push hl
    call Func_001_68CA
    pop hl
    pop bc
    jr nz, Jump_001_68B4
    dec b
    jr nz, Jump_001_68A3
    ret

Jump_001_68B4::
    farcall Func_002_706E
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_001_68C6
    farcall Func_002_717D
    ret

Jump_001_68C6::
    call Func_001_6ABE
    ret

; 1 call site from 1 routine (e.g. Func_001_6880)
Func_001_68CA::
    ld c, $00
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp a, $02
    ret

Data_001_68D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $87, $98, $A7, $98, $C7, $98, $E7, $98, $07, $99, $27, $99, $47, $99, $67, $99
    db $87, $99, $A7, $99, $C7, $99, $E7, $99

Data_001_68EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $00, $AB, $02, $AB, $02, $AB, $02, $01, $00, $00, $00, $40, $01, $63, $00
    db $40, $01, $63, $00, $40, $01, $63, $00

; 9 call sites from 2 routines (e.g. Func_001_66AD, Func_001_4045)
; reads: wC46B, wC52D, wC52E, wC52F, wC530, wD0A5
; writes: wStringIndex, wStringCategory, wC52D, wC52E, wC52F, wC530
; points at: wD09D
Func_001_6903::
    ld a, [wC46B]
    or a, a
    ret z
    cp a, $04
    jr z, Jump_001_6976
    cp a, $05
    jp z, Jump_001_69C2
    cp a, $06
    jp nc, Jump_001_6A0C
    ld hl, wD09D
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld h, [hl]
    ld [wStringIndex], a
    ld a, h
    ld [wStringCategory], a
    ld hl, Data_001_6A6C
    ld a, [wC46B]
    dec a
    add a, a
    add_a_to_hl
    deref_hl
    ld de, $0901
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
    farcall ShowString_Bank88
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

Jump_001_6976::
    ld a, [wD0A5]
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $3C0
    ld de, $0901
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
    farcall ShowString_Bank2F
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

Jump_001_69C2::
    xor a, a
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    ld hl, vTiles2 + $450
    ld de, $0901

Jump_001_69D1::
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
    farcall ShowString_Bank08
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

Jump_001_6A0C::
    ld a, [wC46B]
    ld hl, wD09D
    add a, a
    add_a_to_hl
    ld a, [wC46B]
    cp a, $07
    jr z, Jump_001_6A46
    cp a, $09
    jr z, Jump_001_6A46
    cp a, $0B
    jr z, Jump_001_6A46
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    ld a, [wC46B]
    sub a, $06
    ld hl, Data_001_6A72
    add_a_to_hl
    deref_hl
    ld de, $0901
    jr Jump_001_69D1

Jump_001_6A46::
    ld b, [hl]
    ld a, $0A
    call DivideBByA
    ld c, a
    push bc
    ld a, [wC46B]
    sub a, $07
    ld hl, Data_001_6A78
    add_a_to_hl
    deref_hl
    pop bc
    ld a, b
    add a, $10
    call WriteVRAMByteInc
    ld a, c
    add a, $10
    call WriteVRAMByte
    ret

Data_001_6A6C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $92, $A0, $92, $30, $93

Data_001_6A72:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $94, $70, $95, $00, $96

Data_001_6A78:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6B, $99, $AB, $99, $EB, $99

; 20 call sites from 11 routines (e.g. Func_001_4DB1, Func_001_4DED, Func_001_4D93, Func_001_4D6E, ...)
Func_001_6A7E::
    push af
    swap a
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    pop af
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    ret

; 7 call sites from 5 routines (e.g. Func_001_5535, Func_001_5AC0, Func_001_6809, Func_001_66AD, ...)
Func_001_6A98::
    ld a, b
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    ld a, c
    swap a
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    ld a, c
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    ret

; 2 call sites from 2 routines (e.g. Func_001_6880, Func_001_65A0)
; writes: hFF90, hFF8F, hFF92, hFF8E, hFF91, wC8EF, wC8F0, wC8F1, ...
Func_001_6ABE::
    ld a, $00
    ldh [hFF90], a
    ld a, $02
    ldh [hFF8F], a
    ld a, $00
    ldh [hFF92], a
    ld a, $40
    ldh [hFF8E], a
    ld a, $40
    ldh [hFF91], a
    ld a, $00
    ld [wC8EF], a
    ld a, $40
    ld [wC8F0], a
    ld a, $40
    ld [wC8F1], a
    ld a, $00
    ld [wC8F4], a
    ld a, $40
    ld [wC8F5], a
    ld a, $40
    ld [wC8F6], a
    ld a, $00
    ld [wC8F9], a
    ld a, $40
    ld [wC8FA], a
    ld a, $40
    ld [wC8FB], a
    ld a, $24
    ld [wC60C], a
    ld a, $35
    ld [wC60D], a
    ld a, $8D
    ld [wC60E], a
    ld a, $2F
    ld [wC60F], a
    ld a, $2B
    ld [wC610], a
    ld a, $55
    ld [wC611], a
    ld a, $F0
    ld [wC612], a
    ld a, $F0
    ld [wC613], a
    ld a, $F0
    ld [wC614], a
    ld a, $F0
    ld [wC615], a
    ld a, $9F
    ld [wC617], a
    ld a, $86
    ld [wC618], a
    ld a, $01
    ld [wC619], a
    ld a, $03
    ld [wC6FD], a
    ld a, $00
    ld [wC6FE], a
    ld a, $01
    ld [wC6FF], a
    ld a, $02
    ld [wC700], a
    ld a, $01
    ld [wC61D], a
    ld a, $02
    ld [wC61E], a
    ld a, $03
    ld [wC61F], a
    ld a, $04
    ld [wC620], a
    ld a, $05
    ld [wC621], a
    ld a, $06
    ld [wC622], a
    ld a, $01
    ld [wC623], a
    ld a, $1F
    ld [wC624], a
    ld a, $09
    ld [wC625], a
    ld a, $33
    ld [wC626], a
    ld a, $0B
    ld [wC627], a
    ld a, $20
    ld [wC628], a
    ld a, $28
    ld [wC629], a
    ld a, $0E
    ld [wC62A], a
    ld a, $0F
    ld [wC62B], a
    ld a, $10
    ld [wC62C], a
    ld a, $11
    ld [wC62D], a
    ld a, $12
    ld [wC62E], a
    ld a, $1C
    ld [wC62F], a
    ld a, $1C
    ld [wC630], a
    ld a, $1C
    ld [wC631], a
    ld a, $0C
    ld [wC632], a
    ld a, $0C
    ld [wC633], a
    ld a, $0C
    ld [wC634], a
    ld a, $50
    ld [wC838], a
    xor a, a
    ld [wC839], a
    call Func_001_6E98
    call Func_001_6BDC
    ret

; 1 call site from 1 routine (e.g. Func_001_6ABE)
; writes: wD868, rRAMG, rRAMB
; points at: wD868, sA000
Func_001_6BDC::
    ld b, $1E
    xor a, a
    ld [wD868], a

Jump_001_6BE2::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    push bc
    call Func_001_6C1F
    pop bc
    xor a, a
    ld [rRAMG], a
    ld hl, wD868
    inc [hl]
    dec b
    jr nz, Jump_001_6BE2
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA000
    ld de, $00A5
    ld [hl], $02
    add hl, de
    ld [hl], $02
    add hl, de
    ld [hl], $02
    ld b, $1B

Jump_001_6C14::
    add hl, de
    ld [hl], $01
    dec b
    jr nz, Jump_001_6C14
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_001_6BDC)
; reads: wC5E7, wC5E8
Func_001_6C1F::
    call NextTableByte
    ld a, [wC5E7]
    ld e, a
    ld a, [wC5E8]
    or a, e
    ld e, a
    or a, a
    jr z, Func_001_6C1F
    cp a, $7E
    jr z, Func_001_6C1F
    cp a, $7F
    jr z, Func_001_6C1F
    cp a, $80
    jr z, Func_001_6C1F
    cp a, $81
    jr z, Func_001_6C1F
    cp a, $82
    jr z, Func_001_6C1F
    ld d, $00
    call Func_001_6E82
    ret

; 1 call site from 1 routine (e.g. Func_001_6E91)
; reads: hFFC9, wD868, wCFEC, wCFED, wD869, wC5E8, wCFEE, wCFEF, ...
; writes: wCFE6, wCFE7, wC9DC, wD006, wD007, wD09D, wD09E, wD09F, ...
; points at: wC60C, wD01A
Func_001_6C48::
    ldh a, [hFFC9]
    push af
    ld a, e
    ld [wCFE6], a
    ld a, d
    ld [wCFE7], a
    farcall Func_034_4001
    ld a, [wD868]
    ld c, $00
    call SRAMRecordAddress
    pop af
    ld [hl], a
    ld a, l
    add a, $0B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wCFEC]
    ld [hl+], a
    ld a, [wCFED]
    ld [hl+], a
    inc hl
    ld a, [wD869]
    cp a, $FF
    jr nz, Jump_001_6C82
    ld a, [wC5E8]
    and a, $01
    jr Jump_001_6C8D

Jump_001_6C82::
    push hl
    ld hl, Data_001_70AA
    add_a_to_hl
    ld a, [hl]
    pop hl

Jump_001_6C8D::
    ld [hl+], a
    ld de, wC60C
    ld b, $0B
    call Func_001_6E25
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_001_6E31
    call Func_001_6E31
    ld a, [wCFEE]
    ld [hl+], a
    ld a, [wCFEF]
    ld [hl+], a
    ld a, [wCFF0]
    ld [hl+], a
    ld a, [wCFF1]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    xor a, a
    ld [hl+], a
    ld a, [wCFF5]
    ld [hl+], a
    ld [wC9DC], a
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wCFF6]
    ld e, a
    ld a, [wCFF7]
    ld d, a
    ld a, d
    cp a, $04
    jr c, Jump_001_6CE1
    ld de, $03E7

Jump_001_6CE1::
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
    ld a, d
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
    ld a, [wD86A]
    or a, a
    jr z, Jump_001_6D30
    push hl
    call NextTableByte
    pop hl
    ld a, [wC5E7]
    ld [hl+], a
    ld a, [wC5E8]
    and a, $01
    ld [hl+], a
    jr Jump_001_6D33

Jump_001_6D30::
    xor a, a
    ld [hl+], a
    ld [hl+], a

Jump_001_6D33::
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, [wD002]
    ld [hl+], a
    ld a, [wD003]
    ld [hl+], a
    ld a, [wD004]
    ld [hl+], a
    ld a, [wD005]
    ld [hl+], a
    ld a, [wCFEC]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    ld [wD006], a
    ld a, h
    ld [wD007], a
    farcall Func_035_4001
    ld a, [wD868]
    ld c, $0D
    call SRAMRecordAddress
    ld a, [wD008]
    ld [hl], a
    ld a, a
    ld [wD09D], a
    ld a, l
    add a, $2F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD010]
    ld [hl+], a
    ld a, [wD011]
    ld [hl+], a
    ld a, [wD012]
    ld [hl+], a
    ld b, $16
    ld a, $FF
    call Func_001_6E2C
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD00E]
    ld [hl], a
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld de, wD01A
    ld b, $1B
    call Func_001_6E25
    call Func_001_6E31
    call Func_001_6E31
    ld [hl], $00
    ld a, [wD869]
    cp a, $FF
    jr nz, Jump_001_6DD9
    call NextTableByte
    ld a, [wC5E7]
    ld b, a
    ld a, $0E
    call DivideBByA
    ld [wD09E], a
    ld a, [wD868]
    ld c, $01
    call SRAMRecordAddress
    ld a, l
    ld [wD09F], a
    ld a, h
    ld [wD0A0], a
    farcall Func_014_7F9C
    jr Jump_001_6DF4

Jump_001_6DD9::
    push hl
    ld hl, Data_001_70B3
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, l
    sub a, $A3
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld b, $0A
    call Func_001_6E25

Jump_001_6DF4::
    ld a, [wD006]
    ld l, a
    ld a, [wD007]
    ld h, a
    ld a, l
    ld [wC991], a
    ld a, h
    ld [wC992], a
    farcall Func_019_73A2
    ld a, [wD868]
    ld c, $58
    call SRAMRecordAddress
    ld a, [wC9DE]
    ld [hl+], a
    ld a, [wC9DF]
    ld [hl+], a
    ld a, [wC9E0]
    ld [hl+], a
    farcall Func_016_5AAF
    ret

; 3 call sites from 1 routine (e.g. Func_001_6C48)
Func_001_6E25::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Func_001_6E25
    ret

; 1 call site from 1 routine (e.g. Func_001_6C48)
Func_001_6E2C::
    ld [hl+], a
    dec b
    jr nz, Func_001_6E2C
    ret

; 4 call sites from 1 routine (e.g. Func_001_6C48)
Func_001_6E31::
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld b, $07

Jump_001_6E3E::
    ld [hl+], a
    dec b
    jr nz, Jump_001_6E3E
    ld a, $00
    ld [hl+], a
    ret

; 10 call sites from 8 routines (e.g. Func_013_5EF4, Func_073_5F55, Func_085_4047, Func_085_4249, ...)
; reads: hFFC7, hFFC8, wD868
; writes: rRAMG, rRAMB, wD869, wD86A
Func_001_6E46::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ldh a, [hFFC7]
    ld [wD869], a
    ld hl, Data_001_7098
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    xor a, a
    ld [wD86A], a
    ldh a, [hFFC8]
    call Func_001_6E91
    ldh a, [hFFC7]
    cp a, $01
    jr z, Jump_001_6E73
    cp a, $02
    jr nz, Jump_001_6E7D

Jump_001_6E73::
    ld a, [wD868]
    ld c, $6E
    call SRAMRecordAddress
    ld [hl], $01

Jump_001_6E7D::
    xor a, a
    ld [rRAMG], a
    ret

; 1 call site from 1 routine (e.g. Func_001_6C1F)
; reads: wD868
; writes: wD869, wD86A, hFFC9, wD868
Func_001_6E82::
    ld a, $FF
    ld [wD869], a
    ld [wD86A], a
    ld a, $01
    ldh [hFFC9], a
    ld a, [wD868]

; 1 call site from 1 routine (e.g. Func_001_6E46)
; writes: wD868
Func_001_6E91::
    ld [wD868], a
    call Func_001_6C48
    ret

; 1 call site from 1 routine (e.g. Func_001_6ABE)
; points at: wC707
Func_001_6E98::
    ld de, Data_001_6EB0
    ld hl, wC707
    ld b, $20

Jump_001_6EA0::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_001_6EA0
    ret

Data_001_6EB0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $80, $FF

Data_001_6F30:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $29, $00
    db $11, $12, $13, $35, $0E, $00, $00, $00, $00, $A0, $A1, $A2, $A3, $A4, $A5, $A6
    db $A7, $A8
    ds $16, $00
    INCBIN "dwm2-cobi-us.gbc", $006F81, $B9
    ds $17, $00
    db $31, $29, $14, $15, $16, $00, $31, $29, $32, $29, $00, $00, $2D, $27, $2E, $1A
    db $30, $26, $16, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $2F, $25, $1A, $30, $26, $16
    ds $21, $00

Data_001_7098:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $83, $01, $63, $02, $64, $02, $58, $02, $59, $02, $1B, $00, $7A, $02, $79, $02
    db $78, $02

Data_001_70AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $00, $00, $00, $01, $00, $00

Data_001_70B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_001_70C5
    dw Data_001_70CF
    dw Data_001_70D9
    dw Data_001_70E3
    dw Data_001_70ED
    dw Data_001_70F7
    dw Data_001_7101
    dw Data_001_710B
    dw Data_001_7115

Data_001_70C5:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $2C, $2C, $31, $32, $F0, $F0, $F0, $F0, $F0

Data_001_70CF:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $2A, $F0, $F0, $F0, $F0, $F0, $F0, $F0

Data_001_70D9:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2A, $2A, $F0, $F0, $F0, $F0, $F0, $F0, $F0

Data_001_70E3:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $38, $0B, $F0, $F0, $F0, $F0, $F0

Data_001_70ED:: ; heuristic: target of a monotone pointer table; C0
    db $19, $28, $37, $2C, $0B, $F0, $F0, $F0, $F0, $F0

Data_001_70F7:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $34, $38, $2C, $3D, $F0, $F0, $F0, $F0, $F0

Data_001_7101:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $30, $2C, $24, $F0, $F0, $F0, $F0, $F0

Data_001_710B:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $37, $30, $24, $F0, $F0, $F0, $F0, $F0

Data_001_7115:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $24, $25, $32, $F0, $F0, $F0, $F0, $F0
    ds $4A6, $00

Data_001_75C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $A3B, $00
