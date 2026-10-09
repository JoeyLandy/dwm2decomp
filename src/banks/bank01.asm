SECTION "Bank 01", ROMX[$4000], BANK[$01]
    db $01

Func_001_4001::
    ld hl, $8800
    ld de, $1007
    call Func_000_2E98
    ld hl, $9000
    ld de, $1007
    call Func_000_2E98
    xor a, a
    ld [$C5F8], a
    ld [$C5F9], a
    ld [$C5FA], a
    ld [$C5FB], a
    ld [$C5FC], a
    ld [$C5FD], a
    ld [$C5FE], a
    ld [$C5FF], a
    xor a, a
    ld [$C5F6], a
    ld [$C5F7], a
    call Func_001_4045
    ld a, $FC
    call Func_000_0DF2
    ld a, $03
    ld [$C5EC], a
    ld a, $01
    jp Jump_000_077A

Func_001_4045::
    ld a, [$C5DC]
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
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $9300
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1207
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $99C1
    ld a, l
    ld [$C554], a
    ld a, h
    ld [$C555], a
    ld hl, $9200
    ld de, Data_01F_4160
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9210
    ld de, Data_01F_4130
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9220
    ld de, Data_01F_4180
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9230
    ld de, Data_01F_4190
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9240
    ld de, Data_01F_4170
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9250
    ld de, Data_01F_41D0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    xor a, a
    ld [$C5F8], a
    ld [$C5F9], a
    ld [$C5FA], a
    ld [$C5FB], a
    ld [$C5FC], a
    ld [$C5FD], a
    ld [$C5FE], a
    ld [$C5FF], a
    ld a, $01
    ld de, Data_001_412F
    ld hl, $9800
    ld bc, $1412
    call Func_000_15DE
    xor a, a
    ld [$C46B], a
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    xor a, a
    ld [$C0A2], a
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
    ld [$C528], a
    ld a, $01
    ld [$C529], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ld a, $01
    ld de, Data_008_42BC
    ld hl, $9800
    ld bc, $1412
    call Func_000_15DE
    ld hl, $0000
    call Func_001_4F80
    ret
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
    db $31, $16, $19, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_001_43D0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $12, $1E, $2C
    ds $11, $00
    db $33, $34, $24, $30, $1E, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $30, $35, $2B
    ds $24, $00

Jump_001_4424::
    ld a, $0F
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ld a, $01
    ld de, Data_008_6F30
    ld hl, $9800
    ld bc, $1412
    call Func_000_15DE
    ld a, [$C525]
    or a, a
    jr z, Jump_001_445A
    ld a, $01
    ldh [$FF4F], a
    xor a, a
    ld hl, $9800
    ld bc, $0400
    call Func_000_0949
    ld a, $00
    ldh [$FF4F], a

Jump_001_445A::
    xor a, a
    ld hl, $C5F8
    ld [hl+], a
    dec a
    ld [hl], a
    ret

Jump_001_4462::
    ld a, $31
    call Func_000_122D
    xor a, a
    ld hl, $D09D
    ld bc, $0038
    call Func_000_0949
    ret

Jump_001_4472::
    call Func_001_4AA4
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1005
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $27
    ld [$C529], a
    ld hl, $4C94
    ld b, $1B
    rst $10
    ld hl, $9860
    ld bc, $1001
    ld a, $80
    call Func_001_4A75
    ld hl, $98A0
    ld bc, $1004
    ld a, $90
    call Func_001_4A75
    ld hl, $9920
    ld bc, $1002
    ld a, $B0
    call Func_001_4A75
    ld a, $FC
    ld [$9981], a
    ld [$99E1], a
    ld [$9801], a
    ld a, $FD
    ld [$99A1], a
    ld [$9A01], a
    ld [$9821], a
    ld a, $FB
    ld [$99C1], a
    ld [$9A21], a
    ld de, Data_01F_4A80
    ld hl, $8FE0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4A90
    ld hl, $8FF0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4780
    ld hl, $8FC0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_48F0
    ld hl, $8FC0
    ld b, $1F
    ld c, $10
    call Func_000_0B46
    ld de, Data_01F_4160
    ld hl, $8FD0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld de, Data_01F_4480
    ld hl, $8FB0
    ld b, $1F
    ld c, $10
    call Func_000_0B2B
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $9300
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    call Func_000_290E
    ld hl, $9400
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    call Func_000_290E
    ld hl, $9500
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    call Func_000_290E
    ld hl, $988A
    ld bc, $0901
    ld a, $20
    call Func_001_4A75
    ld hl, $98EA
    ld bc, $0901
    ld a, $30
    call Func_001_4A75
    ld hl, $992A
    ld bc, $0901
    ld a, $40
    call Func_001_4A75
    ld hl, $98AA
    ld bc, $0901
    ld a, $50
    call Func_001_4A75
    xor a, a
    ld [$D7F1], a
    add a, $10
    ld [$9881], a
    xor a, a
    ld [$C5F8], a
    ld [$C5F9], a
    ld [$C5FA], a
    ld [$C5FB], a
    ld [$C5FC], a
    ld [$C5FD], a
    ld [$C5FE], a
    ld [$C5FF], a
    ld hl, $D780
    ld b, $60

Jump_001_45E2::
    xor a, a
    ld [$D780], a
    dec b
    jr nz, Jump_001_45E2
    ret

Jump_001_45EA::
    call Func_001_4AA4
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1008
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $01
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $98A3
    ld bc, $1002
    ld a, $80
    call Func_001_4A75
    ret

Jump_001_461E::
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1008
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $02
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $98A3
    ld bc, $1007
    ld a, $80
    call Func_001_4A75
    ld a, $01
    ld de, Data_001_46A4
    ld hl, $98EA
    ld bc, $1001
    call Func_000_15DE
    xor a, a
    ld [$C5F8], a
    ldh a, [$FF90]
    ld [$C5F9], a
    ldh a, [$FF8F]
    ld [$C5FA], a
    ldh a, [$FF8E]
    ld [$C5FB], a
    ldh a, [$FF92]
    ld [$C5FC], a
    ldh a, [$FF91]
    ld [$C5FD], a
    ld a, $01
    ld [$C5FE], a
    ret

Data_001_46A4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F

Jump_001_46B4::
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1008
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $04
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $98A3
    ld bc, $1007
    ld a, $80
    call Func_001_4A75
    ld a, $01
    ld de, Data_001_4733
    ld hl, $98EA
    ld bc, $1001
    call Func_000_15DE
    xor a, a
    ld [$C5F8], a
    ld a, [$C833]
    push af
    call Func_001_5E6C
    pop af
    or a, $80
    ld [$C5F9], a
    ldh a, [$FF8F]
    ld [$C5FB], a
    ldh a, [$FF92]
    ld [$C5FC], a
    ret

Data_001_4733:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F

Jump_001_4743::
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1008
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $03
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $98A3
    ld bc, $1002
    ld a, $80
    call Func_001_4A75
    ld a, $01
    ld de, Data_001_47DE
    ld hl, $9924
    ld bc, $0606
    call Func_000_15DE
    ld a, [$C525]
    or a, a
    jr z, Jump_001_47C4
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld a, $01
    ld de, Data_001_4802
    ld hl, $9924
    ld bc, $0606
    call Func_000_15DE
    ld c, $4F
    ld a, $00
    ldh [c], a

Jump_001_47C4::
    ld a, $00
    ld [$C5F9], a
    ld a, $80
    ld [$C5FA], a
    ld a, $00
    ld [$C5FB], a
    ld a, $80
    ld [$C5FC], a
    ld a, $00
    ld [$C5FD], a
    ret

Data_001_47DE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
    db $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
    db $40, $41, $42, $43

Data_001_4802:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

Data_001_480C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1A, $01

Jump_001_4826::
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1008
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $06
    ld [$C529], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ld a, $01
    ld de, Data_008_488A
    ld hl, $98A3
    ld bc, $0B04
    call Func_000_15DE
    xor a, a
    ld [$C46B], a
    xor a, a
    ld [$C0A0], a
    ld [$C0A1], a
    ret
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $90, $91, $92, $93, $94
    db $95, $96, $97, $98, $99, $9A

Data_001_48A0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A0, $A1, $A2, $A3, $A4, $A5, $10, $10, $A8, $10, $12, $B0, $B1, $B2, $B3, $B4
    db $B5, $10, $10, $B8, $10, $10

Jump_001_48B6::
    ld hl, $9100
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $00
    ld [$C529], a
    ld hl, $402B
    ld b, $08
    rst $10
    ld hl, $8800
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0B09
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    xor a, a
    ld [$C528], a
    ld a, $09
    ld [$C529], a
    ld hl, Func_008_402B
    ld b, $08
    rst $10
    ld a, $01
    ld de, Data_008_495D
    ld hl, $9840
    ld bc, $140E
    call Func_000_15DE
    xor a, a
    ld hl, $D09D
    ld bc, $0018
    call Func_000_0949
    ld a, $01
    ld [$C46B], a
    call Func_001_6903
    ld a, $02
    ld [$C46B], a
    call Func_001_6903
    ld a, $03
    ld [$C46B], a
    call Func_001_6903
    ld a, $04
    ld [$C46B], a
    call Func_001_6903
    ld a, $05
    ld [$C46B], a
    call Func_001_6903
    ld a, $06
    ld [$C46B], a
    call Func_001_6903
    ld a, $08
    ld [$C46B], a
    call Func_001_6903
    ld a, $0A
    ld [$C46B], a
    call Func_001_6903
    xor a, a
    ld [$C46B], a
    ret
    db $00, $00, $00, $00, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A
    ds $19, $00
    INCBIN "dwm2-cobi-us.gbc", $004985, $F0

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
    add a, l
    ld l, a
    jr nc, Jump_001_4A86
    inc h

Jump_001_4A86::
    ld a, e
    dec c
    jr nz, Func_001_4A75
    ld a, [$C525]
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, $9800
    ld bc, $0240
    xor a, a
    call Func_000_0949
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

Func_001_4AA4::
    ld a, [$C525]
    or a, a
    ret z
    ld de, Data_001_4ACC
    ld hl, $C49F
    ld bc, $0008
    call Func_000_1679
    ld a, $7F
    ld [$C526], a
    ld de, Data_001_4ACC
    ld hl, $C49F
    ld bc, $0008
    call Func_000_1679
    ld a, $7F
    ld [$C527], a
    ret

Data_001_4ACC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $5E, $FF, $7F, $F2, $66, $00, $00

Func_001_4AD4::
    ld a, [$C5DC]
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
    ld a, [$C52B]
    bit 0, a
    ret nz
    ld a, [$C562]
    and a, $01
    jp z, Jump_001_4C56
    ld a, [$C0A2]
    ld [$C529], a
    ld a, [$C0A1]
    ld [$C528], a
    ld de, $1204
    ld hl, $9300
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, [$C0A0]
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
    ld hl, Func_001_4001
    ld b, $08
    rst $10
    ret

Jump_001_4B6F::
    ld hl, Func_001_4001
    ld b, $09
    rst $10
    ret

Jump_001_4B76::
    ld hl, Func_001_4001
    ld b, $28
    rst $10
    ret

Jump_001_4B7D::
    ld hl, Func_001_4001
    ld b, $29
    rst $10
    ret

Jump_001_4B84::
    ld hl, Func_001_4001
    ld b, $2A
    rst $10
    ret

Jump_001_4B8B::
    ld hl, Func_001_4001
    ld b, $2B
    rst $10
    ret

Jump_001_4B92::
    ld hl, Func_001_4001
    ld b, $2C
    rst $10
    ret

Jump_001_4B99::
    ld hl, Func_001_4001
    ld b, $2D
    rst $10
    ret

Jump_001_4BA0::
    ld hl, Func_001_4001
    ld b, $2E
    rst $10
    ret

Jump_001_4BA7::
    ld hl, Func_001_4001
    ld b, $7C
    rst $10
    ret

Jump_001_4BAE::
    ld hl, Func_001_4001
    ld b, $80
    rst $10
    ret

Jump_001_4BB5::
    ld hl, Func_001_4001
    ld b, $82
    rst $10
    ret

Jump_001_4BBC::
    ld hl, Func_001_4001
    ld b, $86
    rst $10
    ret

Jump_001_4BC3::
    ld hl, Func_001_4001
    ld b, $89
    rst $10
    ret

Jump_001_4BCA::
    ld hl, Func_001_4001
    ld b, $07
    rst $10
    ret

Jump_001_4BD1::
    ld hl, Func_001_4001
    ld b, $2F
    rst $10
    ret

Jump_001_4BD8::
    ld hl, Func_001_4001
    ld b, $37
    rst $10
    ret

Jump_001_4BDF::
    ld hl, Func_001_4001
    ld b, $88
    rst $10
    ret

Jump_001_4BE6::
    ld hl, Func_001_4001
    ld b, $83
    rst $10
    ret

Jump_001_4BED::
    ld hl, Func_001_4001
    ld b, $1D
    rst $10
    ret

Jump_001_4BF4::
    ld hl, Func_001_4001
    ld b, $8A
    rst $10
    ret

Jump_001_4BFB::
    ld hl, Func_001_4001
    ld b, $F0
    rst $10
    ret

Jump_001_4C02::
    ld hl, Jump_001_4C86
    ld b, $1B
    rst $10
    ret

Jump_001_4C09::
    ld hl, $520E
    ld b, $1F
    rst $10
    ret

Jump_001_4C10::
    ld hl, Data_001_48A0
    ld b, $F0
    rst $10
    ret

Jump_001_4C17::
    ld hl, Func_001_4001
    ld b, $0D
    rst $10
    ret

Jump_001_4C1E::
    ld hl, $6490
    ld b, $33
    rst $10
    ret

Jump_001_4C25::
    ld hl, $5D10
    ld b, $24
    rst $10
    ret

Jump_001_4C2C::
    ld hl, Func_001_4001
    ld b, $0E
    rst $10
    ret

Jump_001_4C33::
    ld hl, $5370
    ld b, $0E
    rst $10
    ret

Jump_001_4C3A::
    ld hl, Data_001_43D0
    ld b, $F2
    rst $10
    ret

Jump_001_4C41::
    ld hl, Data_001_7037
    ld b, $33
    rst $10
    ret

Jump_001_4C48::
    ld hl, Func_001_4001
    ld b, $0B
    rst $10
    ret

Jump_001_4C4F::
    ld hl, Data_001_480C
    ld b, $1B
    rst $10
    ret

Jump_001_4C56::
    ld a, [$C563]
    and a, $40
    jr z, Jump_001_4C86
    ld a, [$C46B]
    cp a, $00
    call z, Func_001_4D6E
    ld a, [$C46B]
    cp a, $01
    call z, Func_001_4D93
    ld a, [$C46B]
    cp a, $02
    call z, Func_001_4DB1
    ld a, [$C46B]
    sub a, $01
    jr nc, Jump_001_4C7E
    ld a, $02

Jump_001_4C7E::
    ld [$C46B], a
    ld a, $69
    call Func_000_1278

Jump_001_4C86::
    ld a, [$C563]
    and a, $80
    jr z, Jump_001_4CB8
    ld a, [$C46B]
    cp a, $00
    call z, Func_001_4D6E
    ld a, [$C46B]
    cp a, $01
    call z, Func_001_4D93
    ld a, [$C46B]
    cp a, $02
    call z, Func_001_4DB1
    ld a, [$C46B]
    add a, $01
    cp a, $03
    jr nz, Jump_001_4CB0
    ld a, $00

Jump_001_4CB0::
    ld [$C46B], a
    ld a, $69
    call Func_000_1278

Jump_001_4CB8::
    ld a, [$C46B]
    ld c, a
    ld b, $00
    ld hl, $C0A0
    add hl, bc
    ld a, [$C563]
    and a, $10
    jr z, Jump_001_4CCF
    inc [hl]
    call Func_001_4E3B
    jr Jump_001_4CE5

Jump_001_4CCF::
    ld a, [$C563]
    and a, $20
    jr z, Jump_001_4CDC
    dec [hl]
    call Func_001_4E3B
    jr Jump_001_4CE5

Jump_001_4CDC::
    ld a, [$C562]
    and a, $08
    jr z, Jump_001_4D44
    xor a, a
    ld [hl], a

Jump_001_4CE5::
    ld a, $69
    call Func_000_1278
    ld a, [$C46B]
    ld b, $21
    cp a, $00
    call z, Func_001_4DED
    ld a, [$C0A0]
    add a, a
    ld hl, Data_001_4E54
    add a, l
    ld l, a
    jr nc, Jump_001_4D00
    inc h

Jump_001_4D00::
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
    ld a, [$C46B]
    cp a, $01
    call z, Func_001_4DED
    ld a, [$C0A0]
    add a, a
    ld hl, Data_001_4E54
    add a, l
    ld l, a
    jr nc, Jump_001_4D21
    inc h

Jump_001_4D21::
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
    ld a, [$C0A1]
    inc a
    add a, l
    ld l, a
    jr nc, Jump_001_4D3A
    inc h

Jump_001_4D3A::
    ld a, [hl]

Jump_001_4D3B::
    ld b, a
    ld a, [$C46B]
    cp a, $02
    call z, Func_001_4DED

Jump_001_4D44::
    ld a, [$C562]
    and a, $02
    jr z, Jump_001_4D54
    xor a, a
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_4D54::
    ld a, [$C46B]
    cp a, $00
    jr nz, Jump_001_4D79
    ld a, [$C5F0]
    bit 3, a
    jr nz, Func_001_4D6E
    xor a, a
    ld hl, $986D
    call Func_000_121F
    call Func_000_1211
    jr Jump_001_4DBC

Func_001_4D6E::
    ld a, [$C0A0]
    ld de, $986D
    call Func_001_6A7E
    jr Jump_001_4DBC

Jump_001_4D79::
    ld a, [$C46B]
    cp a, $01
    jr nz, Jump_001_4D9E
    ld a, [$C5F0]
    bit 3, a
    jr nz, Func_001_4D93
    xor a, a
    ld hl, $98AD
    call Func_000_121F
    call Func_000_1211
    jr Jump_001_4DBC

Func_001_4D93::
    ld a, [$C0A1]
    ld de, $98AD
    call Func_001_6A7E
    jr Jump_001_4DBC

Jump_001_4D9E::
    ld a, [$C5F0]
    bit 3, a
    jr nz, Func_001_4DB1
    xor a, a
    ld hl, $98ED
    call Func_000_121F
    call Func_000_1211
    jr Jump_001_4DBC

Func_001_4DB1::
    ld a, [$C0A2]
    ld de, $98ED
    call Func_001_6A7E
    jr Jump_001_4DBC

Jump_001_4DBC::
    ld a, [$C46B]
    cp a, $00
    jr z, Jump_001_4DCC
    ld a, [$C0A0]
    ld de, $986D
    call Func_001_6A7E

Jump_001_4DCC::
    ld a, [$C46B]
    cp a, $01
    jr z, Jump_001_4DDC
    ld a, [$C0A1]
    ld de, $98AD
    call Func_001_6A7E

Jump_001_4DDC::
    ld a, [$C46B]
    cp a, $02
    jr z, Jump_001_4DEC
    ld a, [$C0A2]
    ld de, $98ED
    call Func_001_6A7E

Jump_001_4DEC::
    ret

Func_001_4DED::
    push af
    ld a, [$C46B]
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_001_4DF9
    inc h

Jump_001_4DF9::
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
    ld a, [$C46B]
    cp a, $00
    jr nz, Jump_001_4E1B
    ld de, $986D
    ld a, [$C0A0]
    jr Jump_001_4E30

Jump_001_4E1B::
    ld a, [$C46B]
    cp a, $01
    jr nz, Jump_001_4E2A
    ld de, $98AD
    ld a, [$C0A1]
    jr Jump_001_4E30

Jump_001_4E2A::
    ld de, $98ED
    ld a, [$C0A2]

Jump_001_4E30::
    add a, l
    ld l, a
    jr nc, Jump_001_4E35
    inc h

Jump_001_4E35::
    ld a, [hl]
    call Func_001_6A7E
    pop af
    ret

Func_001_4E3B::
    ld a, [$C46B]
    cp a, $00
    jr nz, Jump_001_4E4B
    xor a, a
    ld [$C0A1], a
    xor a, a
    ld [$C0A2], a
    ret

Jump_001_4E4B::
    cp a, $01
    jr nz, Jump_001_4E53
    xor a, a
    ld [$C0A2], a

Jump_001_4E53::
    ret

Data_001_4E54:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $004E54, $80

Jump_001_4ED4::
    ld a, [$C562]
    bit 1, a
    jr z, Jump_001_4EE7
    xor a, a
    ld [$C5DB], a
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_4EE7::
    ld a, [$C563]
    bit 5, a
    jr z, Jump_001_4F34
    ld a, [$C55E]
    bit 2, a
    jr nz, Jump_001_4F07
    ld a, [$C5F8]
    sub a, $01
    ld [$C5F8], a
    ld a, [$C5F9]
    sbc a, $00
    ld [$C5F9], a
    jr Jump_001_4F1F

Jump_001_4F07::
    ld a, [$C5F8]
    ld l, a
    ld a, [$C5F9]
    ld h, a
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [$C5F8], a
    ld a, h
    ld [$C5F9], a

Jump_001_4F1F::
    ld a, [$C5F8]
    ld l, a
    ld a, [$C5F9]
    ld h, a
    ld bc, $02AB
    call Func_000_3E7A
    jr c, Func_001_4F80
    ld hl, $02AB
    jr Func_001_4F80

Jump_001_4F34::
    ld a, [$C563]
    bit 4, a
    jp z, Jump_001_50EC
    ld a, [$C55E]
    bit 2, a
    jr nz, Jump_001_4F55
    ld a, [$C5F8]
    add a, $01
    ld [$C5F8], a
    ld a, [$C5F9]
    adc a, $00
    ld [$C5F9], a
    jr Jump_001_4F6D

Jump_001_4F55::
    ld a, [$C5F8]
    ld l, a
    ld a, [$C5F9]
    ld h, a
    ld a, l
    add a, $10
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld [$C5F8], a
    ld a, h
    ld [$C5F9], a

Jump_001_4F6D::
    ld a, [$C5F8]
    ld l, a
    ld a, [$C5F9]
    ld h, a
    ld bc, $02AB
    call Func_000_3E7A
    jr c, Func_001_4F80
    ld hl, $0000

Func_001_4F80::
    ld a, l
    ld [$C5F8], a
    ld a, h
    ld [$C5F9], a
    ld a, l
    ld [$CFE6], a
    ld a, h
    ld [$CFE7], a
    ld hl, Func_001_4001
    ld b, $34
    rst $10
    ld a, [$CFE6]
    ld hl, $9824
    ld bc, $0100
    call Func_001_5420
    ld a, [$CFE7]
    ld hl, $9824
    call Func_001_542C
    ld a, [$CFE7]
    ld [$C528], a
    ld a, [$CFE6]
    ld [$C529], a
    ld hl, $9400
    ld de, $0901
    ld a, [$C52D]
    ld c, a
    ld a, [$C52E]
    ld b, a
    push bc
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    push bc
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, $400F
    ld b, $88
    rst $10
    pop de
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld a, [$CFEC]
    ld hl, $984F
    ld bc, $0100
    call Func_001_5420
    ld a, [$CFED]
    ld hl, $984F
    call Func_001_542C
    ld a, [$CFEE]
    ld hl, $9866
    ld bc, $0100
    call Func_001_5420
    ld a, [$CFEF]
    inc hl
    call Func_001_5420
    ld a, [$CFF0]
    inc hl
    call Func_001_5420
    ld a, [$CFF1]
    inc hl
    call Func_001_5420
    ld a, [$CFF2]
    ld e, a
    ld a, [$CFF3]
    ld d, a
    ld hl, $988D
    ld bc, $0100
    call Func_001_536C
    ld a, [$CFF4]
    ld hl, $98AF
    ld bc, $0100
    call Func_001_53DC
    ld a, [$CFF5]
    ld hl, $98CF
    ld bc, $0100
    call Func_001_53DC
    ld a, [$CFF6]
    ld e, a
    ld a, [$CFF7]
    ld d, a
    ld hl, $98ED
    ld bc, $0100
    call Func_001_536C
    ld a, [$CFF8]
    ld e, a
    ld a, [$CFF9]
    ld d, a
    ld hl, $990D
    ld bc, $0100
    call Func_001_536C
    ld a, [$CFFA]
    ld e, a
    ld a, [$CFFB]
    ld d, a
    ld hl, $992D
    ld bc, $0100
    call Func_001_536C
    ld a, [$CFFC]
    ld e, a
    ld a, [$CFFD]
    ld d, a
    ld hl, $994D
    ld bc, $0100
    call Func_001_536C
    ld a, [$CFFE]
    ld e, a
    ld a, [$CFFF]
    ld d, a
    ld hl, $996D
    ld bc, $0100
    call Func_001_536C
    ld a, [$D000]
    ld e, a
    ld a, [$D001]
    ld d, a
    ld hl, $998D
    ld bc, $0100
    call Func_001_536C
    ld a, [$D002]
    ld hl, $99AF
    ld bc, $0100
    call Func_001_53DC
    ld a, [$D003]
    ld hl, $99CF
    ld bc, $0100
    call Func_001_53DC
    ld a, [$D004]
    ld hl, $99EF
    ld bc, $0100
    call Func_001_53DC
    ld a, [$D005]
    ld hl, $9A0F
    ld bc, $0100
    call Func_001_53DC

Jump_001_50EC::
    ret

Jump_001_50ED::
    ld a, [$C562]
    bit 1, a
    jr z, Jump_001_5100
    xor a, a
    ld [$C5DB], a
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_5100::
    ld a, [$C563]
    bit 5, a
    jr z, Jump_001_5117
    ld a, [$C5F8]
    dec a
    ld [$C5F8], a
    cp a, $AF
    jr c, Jump_001_5117
    ld a, $AE
    ld [$C5F8], a

Jump_001_5117::
    ld a, [$C563]
    bit 4, a
    jr z, Jump_001_512D
    ld a, [$C5F8]
    inc a
    ld [$C5F8], a
    cp a, $AF
    jr c, Jump_001_512D
    xor a, a
    ld [$C5F8], a

Jump_001_512D::
    ld hl, $C5F8
    ld a, [hl+]
    cp a, [hl]
    ld [hl], a
    ret z
    ld hl, $9846
    ld bc, $0100
    call Func_001_5420
    ld a, [$C5F8]
    ld [$CFEC], a
    xor a, a
    ld [$CFED], a
    xor a, a
    ld [$D868], a
    ld a, $11
    ld [$D869], a
    ld hl, $CFEE
    ld a, l
    ld [$D86A], a
    ld a, h
    ld [$D86B], a
    ld hl, $4022
    ld b, $1A
    rst $10
    ld a, [$CFEE]
    ld hl, $9890
    ld bc, $0100
    call Func_001_53DC
    ld a, $04
    ld [$C528], a
    ld a, [$CFEC]
    or a, a
    jr nz, Jump_001_517F
    ld a, $0E
    ld [$C528], a
    ld a, $01

Jump_001_517F::
    ld [$C529], a
    ld hl, $8A00
    ld de, $0901
    call Func_000_2E98
    ld hl, $402B
    ld b, $08
    rst $10
    ld a, $12
    ld [$C528], a
    ld a, [$CFEF]
    ld [$C529], a
    ld hl, $8800
    ld de, $0501
    call Func_000_2E98
    ld hl, $402B
    ld b, $08
    rst $10
    ld a, $13
    ld [$C528], a
    ld a, [$CFF0]
    ld [$C529], a
    ld hl, $8850
    ld de, $0401
    call Func_000_2E98
    ld hl, $402B
    ld b, $08
    rst $10
    ld a, $14
    ld [$C528], a
    ld a, [$CFF1]
    and a, $03
    ld [$C529], a
    ld hl, $8890
    ld de, $0401
    call Func_000_2E98
    ld hl, $402B
    ld b, $08
    rst $10
    ld a, $10
    ld [$C528], a
    ld a, [$CFF1]
    and a, $F0
    swap a
    ld [$C529], a
    ld hl, $88D0
    ld de, $0801
    call Func_000_2E98
    ld hl, $402B
    ld b, $08
    rst $10
    ld a, $11
    ld [$C528], a
    ld a, [$CFF2]
    call Func_001_5311
    ld [$C529], a
    ld hl, $8950
    ld de, $0801
    call Func_000_2E98
    ld hl, $402B
    ld b, $08
    rst $10
    ld a, [$CFF3]
    ld hl, $994B
    ld bc, $0801
    call Func_001_5344
    ld a, [$CFF4]
    ld hl, $996B
    ld bc, $0801
    call Func_001_5344
    ld a, [$CFF5]
    ld hl, $998B
    ld bc, $0801
    call Func_001_5344
    ld a, [$CFF6]
    ld hl, $99AB
    ld bc, $0801
    call Func_001_5344
    ld a, [$CFF7]
    ld l, a
    ld a, [$CFF8]
    ld h, a
    call Func_001_52AF
    ld hl, $99EA
    ld bc, $0100
    call Func_001_52CD
    ld a, [$CFF7]
    ld l, a
    ld a, [$CFF8]
    ld h, a
    ld a, [$CFF9]
    ld e, a
    ld a, [$CFFA]
    ld d, a
    add hl, de
    call Func_001_52AF
    ld hl, $99EF
    ld bc, $0100
    call Func_001_52CD
    ld a, [$CFFB]
    ld l, a
    ld a, [$CFFC]
    ld h, a
    call Func_001_52AF
    ld hl, $9A0A
    ld bc, $0100
    call Func_001_52CD
    ld a, [$CFFB]
    ld l, a
    ld a, [$CFFC]
    ld h, a
    ld a, [$CFFD]
    ld e, a
    ld a, [$CFFE]
    ld d, a
    add hl, de
    call Func_001_52AF
    ld hl, $9A0F
    ld bc, $0100
    call Func_001_52CD
    ret

Func_001_52AF::
    ld a, l
    ld [$C8C0], a
    ld a, h
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    ld hl, $FFC9
    ld a, [hl-]
    or a, [hl]
    ret z
    ld a, $99
    ldh [$FFC7], a
    ld a, $99
    ldh [$FFC6], a
    ret

Func_001_52CD::
    ld e, $00
    ldh a, [$FFC7]
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
    call Func_000_121F
    ei
    ldh a, [$FFC7]
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
    call Func_000_121F
    ei
    ldh a, [$FFC6]
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
    call Func_000_121F
    ei
    ldh a, [$FFC6]
    and a, $0F
    add a, b
    di
    call Func_000_121F
    ei
    ret

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

Func_001_5344::
    ld d, a
    ld e, $00

Jump_001_5347::
    push hl
    ld a, e
    ld hl, Data_001_5364
    add a, l
    ld l, a
    jr nc, Jump_001_5351
    inc h

Jump_001_5351::
    ld a, d
    and a, [hl]
    jr z, Jump_001_5357
    ld a, $01

Jump_001_5357::
    add a, c
    pop hl
    di
    call Func_000_1211
    ei
    inc hl
    inc e
    dec b
    jr nz, Jump_001_5347
    ret

Data_001_5364:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

Func_001_536C::
    push bc
    push hl
    ld a, e
    ld [$C8C0], a
    ld a, d
    ld [$C8C1], a
    xor a, a
    ld [$C8C2], a
    call Func_000_173A
    pop hl
    pop bc
    ld e, $00
    ldh a, [$FFC8]
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
    call Func_000_121F
    ei
    ldh a, [$FFC7]
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
    call Func_000_121F
    ei
    ldh a, [$FFC7]
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
    call Func_000_121F
    ei
    ldh a, [$FFC6]
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
    call Func_000_121F
    ei
    ldh a, [$FFC6]
    and a, $0F
    add a, b
    di
    call Func_000_1211
    ei
    ret

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

Func_001_5405::
    ld d, $FF

Jump_001_5407::
    inc d
    sub a, e
    jr nc, Jump_001_5407
    add a, e
    ret

Func_001_540D::
    push af
    ld a, d
    add a, b
    di
    call Func_000_1211
    ei
    pop af
    ret

Func_001_5417::
    push af
    ld a, c
    di
    call Func_000_1211
    ei
    pop af
    ret

Func_001_5420::
    inc hl
    push af
    swap a
    and a, $0F
    ld d, a
    call Func_001_540D
    inc hl
    pop af

Func_001_542C::
    and a, $0F
    ld d, a
    call Func_001_540D
    ret

Jump_001_5433::
    ld hl, $5AD3
    ld b, $E0
    rst $10
    ret

Jump_001_543A::
    ld a, [$D780]
    and a, a
    jp z, Jump_001_56F1
    cp a, $01
    jp z, Jump_001_5564
    ld a, [$C563]
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
    ld [$D780], a
    ld [$D7BD], a
    ret

Jump_001_547A::
    ld a, [$C5F8]
    cp a, $04
    jr nz, Jump_001_5486
    ld hl, $D787
    jr Jump_001_5489

Jump_001_5486::
    ld hl, $D7A2

Jump_001_5489::
    ld a, [$D7BD]
    add a, l
    ld l, a
    jr nc, Jump_001_5491
    inc h

Jump_001_5491::
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
    ld a, [$C5F8]
    cp a, $04
    jr nz, Jump_001_54A9
    ld hl, $D787
    jr Jump_001_54AC

Jump_001_54A9::
    ld hl, $D7A2

Jump_001_54AC::
    ld a, [$D7BD]
    add a, l
    ld l, a
    jr nc, Jump_001_54B4
    inc h

Jump_001_54B4::
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
    ld a, [$D7BD]
    cp a, $1A
    jr c, Jump_001_54CD
    ld a, $FF

Jump_001_54CD::
    inc a
    ld [$D7BD], a
    call Func_001_54E8
    ret

Jump_001_54D5::
    call Func_001_54FB
    ld a, [$D7BD]
    and a, a
    jr nz, Jump_001_54E0
    ld a, $1B

Jump_001_54E0::
    dec a
    ld [$D7BD], a
    call Func_001_54E8
    ret

Func_001_54E8::
    ld a, [$C5FF]
    inc a
    ld [$C5FF], a
    cp a, $10
    jr c, Func_001_54FB
    cp a, $18
    jr c, Jump_001_552A
    xor a, a
    ld [$C5FF], a

Func_001_54FB::
    ld a, [$C5F8]
    cp a, $04
    jr nz, Jump_001_5507
    ld hl, $D787
    jr Jump_001_550A

Jump_001_5507::
    ld hl, $D7A2

Jump_001_550A::
    ld a, [$D7BD]
    add a, l
    ld l, a
    jr nc, Jump_001_5512
    inc h

Jump_001_5512::
    ld a, [hl]
    ld l, a
    ld h, $00
    call Func_000_16F5
    call Func_001_5535
    ld a, [$C8C2]
    add a, $10
    ld c, a
    di
    call Func_000_120A
    ld a, c
    ld [hl], a
    ei
    ret

Jump_001_552A::
    call Func_001_5535
    di
    call Func_000_120A
    xor a, a
    ld [hl], a
    ei
    ret

Func_001_5535::
    ld a, [$C5F8]
    cp a, $04
    jr nz, Jump_001_5541
    ld de, Data_001_555C
    jr Jump_001_5544

Jump_001_5541::
    ld de, Data_001_5560

Jump_001_5544::
    ld a, [$D7BD]
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
    add a, l
    ld l, a
    jr nc, Jump_001_555B
    inc h

Jump_001_555B::
    ret

Data_001_555C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $86, $99, $A6, $99

Data_001_5560:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E6, $99, $06, $9A

Jump_001_5564::
    ld a, [$D7F1]
    and a, a
    jr z, Jump_001_5572
    cp a, $02
    jr z, Jump_001_5572
    xor a, a
    ld [$D7F1], a

Jump_001_5572::
    ld hl, $5688
    ld b, $0E
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    ret nz
    ld a, [$D7F1]
    push af
    ld a, [$D7F7]
    cp a, $FF
    jr nz, Jump_001_5590
    ld a, [$D7F6]
    cp a, $FF
    jr z, Jump_001_55D8

Jump_001_5590::
    ld a, [$D7F6]
    ld [$D7F1], a
    ld a, [$D7F7]
    ld [$D7F2], a
    ld de, Data_001_75C5
    ld a, e
    ld [$D7F3], a
    ld a, d
    ld [$D7F4], a
    ld hl, Data_001_68FA
    ld b, $15
    rst $10
    ld a, [$D7F5]
    cp a, $FF
    jr z, Jump_001_561F
    call Func_001_5BE8
    ld hl, $9500
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld de, $9500
    call Func_000_21A1
    jr Jump_001_5638

Jump_001_55D8::
    call Func_001_5BE8
    ld hl, $9500
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    call Func_000_290E
    ld de, $9200
    call Func_000_21A1
    ld de, $9500
    call Func_000_21A1
    ld bc, $0000
    ld de, $986A
    call Func_001_6A98
    xor a, a
    ld [$D780], a
    ld [$CFA8], a
    ret

Jump_001_561F::
    ld hl, $9500
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E

Jump_001_5638::
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    call Func_000_290E
    ld de, $D7F6
    ld hl, $9200
    call Func_001_5B98
    ld a, [$D7F6]
    ld c, a
    ld a, [$D7F7]
    ld b, a
    ld de, $986A
    call Func_001_6A98
    ld hl, $CADE
    ld a, [hl]
    and a, $01
    add a, $FE
    ld c, a
    ld hl, $9871
    di
    call Func_000_120A
    ld a, c
    ld [hl], a
    ei
    ld hl, $CB3D
    ld a, [hl]
    ld c, a
    ld de, $9802
    call Func_001_5B2D
    call Func_001_56D3
    ld hl, $CB26
    ld a, [hl]
    ld c, a
    ld de, $9822
    call Func_001_5B2D
    call Func_001_56D3
    ld hl, $CB27
    ld a, [hl]
    ld c, a
    ld de, $9842
    call Func_001_5B2D
    call Func_001_56D3
    ld hl, $CB43
    ld de, $9806
    ld c, $00

Jump_001_56A2::
    di
    call Func_000_120A
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, Jump_001_56A2
    ld de, $9826
    ld c, $00

Jump_001_56B7::
    di
    call Func_000_120A
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
    ld [$D7F1], a
    xor a, a
    ld [$D780], a
    ld [$CFA8], a
    ret

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
    call Func_000_120A
    ld a, b
    ld [de], a
    inc de
    ei
    di
    call Func_000_120A
    ld a, c
    ld [de], a
    ei
    ret

Jump_001_56F1::
    ld a, [$C563]
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
    ld a, [$C5F9]
    ld [$D7F2], a
    ld a, [$C5FA]
    ld [$D7F3], a
    ld a, [$D7F2]
    ld [$D006], a
    ld a, [$D7F3]
    ld [$D007], a
    ld hl, Func_001_4001
    ld b, $35
    rst $10
    ld c, $00
    ld de, $D787
    call Func_001_57C7
    ld a, [$C5FC]
    ld [$D7F2], a
    ld a, [$C5FD]
    ld [$D7F3], a
    ld a, [$D7F2]
    ld [$D006], a
    ld a, [$D7F3]
    ld [$D007], a
    ld hl, Func_001_4001
    ld b, $35
    rst $10
    ld c, $00
    ld de, $D7A2
    call Func_001_57C7
    ld hl, $D787
    ld de, $9986
    ld c, $00

Jump_001_5774::
    di
    call Func_000_120A
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, Jump_001_5774
    ld de, $99A6
    ld c, $00

Jump_001_5789::
    di
    call Func_000_120A
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0D
    jr c, Jump_001_5789
    ld hl, $D7A2
    ld de, $99E6
    ld c, $00

Jump_001_57A1::
    di
    call Func_000_120A
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, Jump_001_57A1
    ld de, $9A06
    ld c, $00

Jump_001_57B6::
    di
    call Func_000_120A
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

Func_001_57C7::
    push bc
    push de
    ld a, c
    ld [$D7F4], a
    ld hl, $5E1D
    ld b, $0E
    rst $10
    pop de
    pop bc
    ld a, [$D7F5]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $1B
    jr c, Func_001_57C7
    ret

Func_001_57E1::
    ld a, [$D7F1]
    and a, a
    jr nz, Jump_001_57EE
    ld a, $02
    ld [$D7F1], a
    jr Jump_001_57F2

Jump_001_57EE::
    xor a, a
    ld [$D7F1], a

Jump_001_57F2::
    di
    call Func_000_120A
    ld a, [$D7F1]
    add a, $10
    ld [$9881], a
    ei
    ret

Jump_001_5800::
    ld a, [$C5F8]
    cp a, $04
    jr z, Jump_001_5812
    cp a, $07
    jr z, Jump_001_5812
    call Func_001_57E1
    call Func_001_5AAC
    ret

Jump_001_5812::
    call Func_001_5AC0
    ld a, [$D780]
    inc a
    inc a
    ld [$D780], a
    xor a, a
    ld [$D7BD], a
    ret

Jump_001_5822::
    call Func_001_5AC0
    ld a, [$C5F8]
    and a, a
    ret z
    dec a
    ld [$C5F8], a
    call Func_001_5AAC
    ret

Jump_001_5832::
    call Func_001_5AC0
    ld a, [$C5F8]
    cp a, $09
    ret z
    inc a
    ld [$C5F8], a
    call Func_001_5AAC
    ret

Jump_001_5843::
    ld a, [$C5F8]
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
    ld hl, $C5FB
    jr Jump_001_5860

Jump_001_585D::
    ld hl, $C5FE

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
    ld hl, $C5FC
    jr Jump_001_5879

Jump_001_5876::
    ld hl, $C5F9

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
    ld bc, $FFFF

Jump_001_588A::
    inc bc
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl], a
    call Func_001_5AAC
    ld a, [$C5F8]
    cp a, $02
    jr z, Jump_001_58A2
    ld de, $C5F9
    ld hl, $9300
    jr Jump_001_58A8

Jump_001_58A2::
    ld de, $C5FC
    ld hl, $9400

Jump_001_58A8::
    push de
    push hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $0901
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    call Func_000_290E
    pop hl
    pop de
    call Func_001_5B98
    ret

Jump_001_58C6::
    ld a, [$C5F8]
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
    ld hl, $C5FB
    jr Jump_001_58E3

Jump_001_58E0::
    ld hl, $C5FE

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
    ld hl, $C5F9
    jr Jump_001_58FA

Jump_001_58F7::
    ld hl, $C5FC

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
    ld a, [$C5F8]
    cp a, $02
    jp z, Jump_001_58A2
    ld de, $C5F9
    ld hl, $9300
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
    ld hl, $D781
    ld c, $63
    jr Jump_001_5945

Jump_001_5940::
    ld hl, $D782
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
    ld hl, $D783
    ld c, $63
    jr Jump_001_5945

Jump_001_595A::
    ld hl, $D784
    ld c, $63
    jr Jump_001_5945

Jump_001_5961::
    ld hl, $D785
    ld c, $1B
    jr Jump_001_5945

Jump_001_5968::
    ld hl, $D786
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
    ld hl, $D781
    ld c, $64
    jr Jump_001_5991

Jump_001_598C::
    ld hl, $D782
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
    ld hl, $D783
    ld c, $64
    jr Jump_001_5991

Jump_001_59A5::
    ld hl, $D784
    ld c, $64
    jr Jump_001_5991

Jump_001_59AC::
    ld hl, $D785
    ld c, $1C
    jr Jump_001_5991

Jump_001_59B3::
    ld hl, $D786
    ld c, $1C
    jr Jump_001_5991

Jump_001_59BA::
    xor a, a
    ld [$C5F8], a
    ld [$C5F9], a
    ld [$C5FA], a
    ld [$C5FB], a
    ld [$C5FC], a
    ld [$C5FD], a
    ld [$C5FE], a
    ld [$C5FF], a
    xor a, a
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_59DC::
    ld a, [$D783]
    cp a, $0A
    ret c
    ld a, [$D784]
    cp a, $0A
    ret c
    ld hl, $C5FB
    ld de, $C5FE
    ld a, [hl]
    ld b, a
    ld a, [de]
    cp a, b
    jr nz, Jump_001_59F5
    ret

Jump_001_59F5::
    ld hl, $C986
    ld bc, $01EF

Jump_001_59FB::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_001_59FB
    ld hl, $C991
    ld a, [$C5F9]
    ld [hl+], a
    ld a, [$C5FA]
    ld [hl+], a
    ld hl, $CA36
    ld a, [$C5FC]
    ld [hl+], a
    ld a, [$C5FD]
    ld [hl+], a
    ld hl, $C994
    ld a, [$C5FB]
    ld [hl], a
    ld hl, $CA39
    ld a, [$C5FE]
    ld [hl], a
    ld a, [$C5F9]
    ld [$D7F6], a
    ld a, [$C5FA]
    ld [$D7F7], a
    ld hl, $615A
    ld b, $0E
    rst $10
    ld a, [$D7F5]
    ld hl, $C993
    ld [hl], a
    ld a, [$C5FC]
    ld [$D7F6], a
    ld a, [$C5FD]
    ld [$D7F7], a
    ld hl, $615A
    ld b, $0E
    rst $10
    ld a, [$D7F5]
    ld hl, $CA38
    ld [hl], a
    ld hl, $C9F3
    ld a, [$D781]
    ld [hl], a
    ld hl, $CA98
    ld a, [$D782]
    ld [hl], a
    ld hl, $C9DC
    ld a, [$D783]
    ld [hl], a
    ld hl, $CA81
    ld a, [$D784]
    ld [hl], a
    ld hl, $CA2A
    ld a, [$D785]
    ld [hl], a
    ld hl, $CACF
    ld a, [$D786]
    ld [hl], a
    ld hl, $D787
    ld de, $C9F9
    ld b, $1B

Jump_001_5A8A::
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_001_5A8A
    ld hl, $D7A2
    ld de, $CA9E
    ld b, $1B

Jump_001_5A99::
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, Jump_001_5A99
    ld a, [$D780]
    inc a
    ld [$D780], a
    xor a, a
    ld [$CFA8], a
    ret

Func_001_5AAC::
    ld a, [$C5FF]
    inc a
    ld [$C5FF], a
    cp a, $10
    jr c, Func_001_5AC0
    cp a, $18
    jp c, Jump_001_5B45
    xor a, a
    ld [$C5FF], a

Func_001_5AC0::
    ld a, [$C5F8]
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
    ld a, [$C5F8]
    cp a, $04
    jr nc, Jump_001_5B14
    bit 0, a
    jr nz, Jump_001_5AF8
    ld a, [$C5F8]
    sla a
    ld hl, Data_001_5B84
    add a, l
    ld l, a
    jr nc, Jump_001_5AEF
    inc h

Jump_001_5AEF::
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    call Func_001_6A98
    ret

Jump_001_5AF8::
    ld a, [$C5F8]
    sla a
    ld hl, Data_001_5B84
    add a, l
    ld l, a
    jr nc, Jump_001_5B05
    inc h

Jump_001_5B05::
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call Func_000_120A
    ld a, c
    add a, $FE
    ld [de], a
    ei
    ret

Jump_001_5B14::
    ld a, [$C5F8]
    sla a
    ld hl, Data_001_5B84
    add a, l
    ld l, a
    jr nc, Jump_001_5B21
    inc h

Jump_001_5B21::
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    call Func_001_5B2D
    call Func_001_6A7E
    ret

Func_001_5B2D::
    push de
    ld l, c
    ld h, $00
    call Func_000_16F5
    ld a, [$C8C1]
    and a, $0F
    swap a
    ld c, a
    ld a, [$C8C2]
    and a, $0F
    or a, c
    ld c, a
    pop de
    ret

Jump_001_5B45::
    ld a, [$C5F8]
    sla a
    ld hl, Data_001_5B84
    add a, l
    ld l, a
    jr nc, Jump_001_5B52
    inc h

Jump_001_5B52::
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call Func_000_120A
    xor a, a
    ld [de], a
    inc de
    ei
    di
    call Func_000_120A
    xor a, a
    ld [de], a
    inc de
    ei
    di
    call Func_000_120A
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

Func_001_5B98::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call Func_001_5BAD
    pop hl
    ld e, l
    ld d, h
    ld a, $F0
    ld [$C8D9], a
    call Func_000_21A1
    ret

Func_001_5BAD::
    push hl
    ld a, [$D7FE]
    push af
    ld a, $08
    ld [$D7FE], a
    ld hl, $4032
    ld a, $04
    add a, l
    ld l, a
    jr nc, Jump_001_5BC1
    inc h

Jump_001_5BC1::
    call Func_000_0B6C
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
    call Func_000_0B6C
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [$D7FE], a
    ld hl, $C8CF
    ld b, $08
    ld c, $10
    call Func_000_0B2B
    ret

Func_001_5BE8::
    ld c, $00
    ld hl, $C8CF

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
    ld a, [$C562]
    bit 0, a
    jp z, Jump_001_5C14
    ld a, [$C5FD]
    cp a, $FF
    jr z, Jump_001_5C10
    ld a, [$C5FE]
    bit 7, a
    jr nz, Jump_001_5C18

Jump_001_5C10::
    call Func_001_5DBA
    ret

Jump_001_5C14::
    bit 1, a
    jr z, Jump_001_5C8D

Jump_001_5C18::
    ld a, [$C5FD]
    cp a, $FF
    ret z
    ld a, [$C5F9]
    ld [$C833], a
    ld a, [$C5FB]
    ldh [$FF8F], a
    ld a, [$C5FC]
    ldh [$FF92], a
    ld a, [$C5FE]
    bit 7, a
    jr z, Jump_001_5C5B
    ld a, [$C5FD]
    and a, $1F
    ld hl, Data_001_5DAD
    add a, l
    ld l, a
    jr nc, Jump_001_5C42
    inc h

Jump_001_5C42::
    ld a, [hl]
    ldh [$FF90], a
    xor a, a
    ld [$CC44], a
    xor a, a
    ld [$C91F], a
    ld a, $01
    ld [$C5DB], a
    xor a, a
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_5C5B::
    ld a, [$C5FD]
    and a, $7F
    ld [$CC42], a
    ld hl, $6CD1
    ld b, $60
    rst $10
    ld a, $80
    ld [$CC44], a
    xor a, a
    ld [$C91F], a
    ld a, [$CD0D]
    ld [$C190], a
    ld a, [$CD0E]
    ld [$C191], a
    ld a, $01
    ld [$C5DB], a
    ld a, $05
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_5C8D::
    bit 3, a
    jr z, Jump_001_5CA0
    ld a, $00
    ld [$C5DB], a
    ld a, $00
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_5CA0::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_001_5CB6
    ld a, [$C5F8]
    dec a
    cp a, $FF
    jr nz, Jump_001_5CB1
    ld a, $03

Jump_001_5CB1::
    ld [$C5F8], a
    jr Jump_001_5CC6

Jump_001_5CB6::
    bit 7, a
    jr z, Jump_001_5CC6
    ld a, [$C5F8]
    inc a
    cp a, $04
    jr nz, Jump_001_5CC3
    xor a, a

Jump_001_5CC3::
    ld [$C5F8], a

Jump_001_5CC6::
    ld c, $00
    ld a, [$C563]
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
    ld a, [$C5F8]
    or a, a
    jr nz, Jump_001_5D00
    ld a, [$C5F9]
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
    ld [$C5F9], a
    and a, $7F
    call Func_001_5E6C
    jr Jump_001_5D3C

Jump_001_5D00::
    dec a
    jr nz, Jump_001_5D22
    ld a, [$C5FE]
    bit 7, a
    jr nz, Jump_001_5D22
    ld a, [$C5FA]
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
    ld [$C5FA], a
    jr Jump_001_5D3C

Jump_001_5D22::
    dec a
    jr nz, Jump_001_5D30
    ld a, [$C5FB]
    add a, c
    and a, $0F
    ld [$C5FB], a
    jr Jump_001_5D3C

Jump_001_5D30::
    dec a
    jr nz, Jump_001_5D3C
    ld a, [$C5FC]
    add a, c
    and a, $0F
    ld [$C5FC], a

Jump_001_5D3C::
    ld a, [$C5F9]
    bit 7, a
    jr z, Jump_001_5D46
    call Func_001_5EAF

Jump_001_5D46::
    ld a, [$C5F9]
    bit 7, a
    jr z, Jump_001_5D55
    and a, $7F
    ld de, $990A
    call Func_001_6A7E

Jump_001_5D55::
    ld a, [$C5F9]
    bit 7, a
    jr nz, Jump_001_5D63
    ld a, [$C5FA]
    bit 7, a
    jr z, Jump_001_5D76

Jump_001_5D63::
    ld a, [$C5F9]
    and a, $7F
    ld [$C5F9], a
    ld a, [$C5FA]
    and a, $7F
    ld [$C5FA], a
    call Func_001_5E8A

Jump_001_5D76::
    ld a, [$C5FB]
    ld de, $994A
    call Func_001_6A7E
    ld a, [$C5FC]
    ld de, $996A
    call Func_001_6A7E
    ld hl, $9909
    ld b, $00

Jump_001_5D8D::
    ld a, [$C5F8]
    cp a, b
    jr z, Jump_001_5D9A
    ld a, $80
    call Func_000_1211
    jr Jump_001_5D9F

Jump_001_5D9A::
    ld a, $F8
    call Func_000_1211

Jump_001_5D9F::
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_001_5DA6
    inc h

Jump_001_5DA6::
    inc b
    ld a, b
    cp a, $05
    jr nz, Jump_001_5D8D
    ret

Data_001_5DAD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $05, $20, $30, $48, $70, $A0, $A8, $B0, $B8, $C8, $D1, $DA

Func_001_5DBA::
    ld a, [$C5FA]
    ldh [$FFC6], a
    ld hl, $6916
    ld b, $60
    rst $10
    ld a, [$C5F9]
    ld [$C833], a
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
    ld a, [$C5FD]
    cp a, $FF
    jr nz, Jump_001_5DEF
    push hl
    ld hl, $6C61
    ld b, $60
    rst $10
    pop hl
    ldh a, [$FFC6]
    cp a, $FF
    ret z
    ld [hl+], a
    jr Jump_001_5DF3

Jump_001_5DEF::
    ld a, [hl]
    and a, $7F
    ld [hl+], a

Jump_001_5DF3::
    ld [$CC42], a
    ldh a, [$FFC7]
    ld [hl+], a
    ldh a, [$FFC8]
    ld [hl+], a
    ldh a, [$FFC9]
    ld [hl], a
    ld [$CD05], a
    ld hl, $4035
    ld b, $60
    rst $10
    ld hl, $6C96
    ld b, $60
    rst $10
    ld a, [$CD0D]
    ld [$C190], a
    ld a, [$CD0E]
    ld [$C191], a
    xor a, a
    ldh [$FF98], a
    ld a, [$CD08]
    swap a
    and a, $0F
    ldh [$FF8F], a
    ld a, [$CD08]
    and a, $0F
    ldh [$FF92], a
    ld a, [$CD09]
    ldh [$FF8E], a
    ld a, [$CD0A]
    ldh [$FF91], a
    ldh a, [$FF98]
    ld [$C8EF], a
    ld [$C8F4], a
    ld [$C8F9], a
    ldh a, [$FF8E]
    ld [$C8F0], a
    ld [$C8F5], a
    ld [$C8FA], a
    ldh a, [$FF91]
    ld [$C8F1], a
    ld [$C8F6], a
    ld [$C8FB], a
    ld a, $80
    ld [$CC44], a
    ld a, $01
    ld [$C5DB], a
    ld a, $05
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

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
    ld [$C5FD], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld [$C5FE], a
    or a, $80
    ld [$C5FA], a
    ret

Func_001_5E8A::
    ld a, [$C5FD]
    cp a, $FF
    jr z, Jump_001_5EA4
    ld a, [$C5FE]
    bit 7, a
    jr nz, Jump_001_5EA4
    ld a, [$C5FA]
    and a, $7F
    ld de, $992A
    call Func_001_6A7E
    ret

Jump_001_5EA4::
    xor a, a
    ld [$C5FA], a
    ld de, $992A
    call Func_001_6A7E
    ret

Func_001_5EAF::
    ld a, $90
    ld [$C8CF], a
    ld [$C8D0], a
    ld [$C8D1], a
    ld [$C8D2], a
    ld [$C8D3], a
    ld [$C8D4], a
    ld [$C8D5], a
    ld [$C8D6], a
    ld [$C8D7], a
    ld [$C8D8], a
    ld [$C8D9], a
    ld [$C8DA], a
    ld [$C8DB], a
    ld [$C8DC], a
    ld [$C8DD], a
    ld a, $F0
    ld [$C8DE], a
    ld de, $9200
    call Func_000_21A1
    ld a, [$C5FE]
    bit 7, a
    jr z, Jump_001_5F1C
    ld a, [$C5FD]
    cp a, $FF
    jr nz, Jump_001_5F1C
    ld a, $29
    ld [$C8CF], a
    ld a, $2A
    ld [$C8D0], a
    ld a, $8D
    ld [$C8D1], a
    ld a, $39
    ld [$C8D2], a
    ld a, $2F
    ld [$C8D3], a
    ld a, $F0
    ld [$C8D4], a
    ld de, $9200
    call Func_000_21A1
    ret

Jump_001_5F1C::
    ld a, [$C5FE]
    bit 7, a
    jr z, Jump_001_5F44
    ld a, [$C5FD]
    dec a
    swap a
    and a, $F0
    ld hl, Data_001_5F56
    add a, l
    ld l, a
    jr nc, Jump_001_5F33
    inc h

Jump_001_5F33::
    ld de, $C8CF

Jump_001_5F36::
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, Jump_001_5F36
    ld de, $9200
    call Func_000_21A1
    ret

Jump_001_5F44::
    ld a, [$C5F9]
    and a, $1F
    ld de, $C8CF
    call Func_000_2458
    ld de, $9200
    call Func_000_21A1
    ret

Data_001_5F56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $005F56, $A8

Jump_001_5FFE::
    ld a, [$C563]
    bit 0, a
    jr z, Jump_001_604B
    ld a, [$C5F9]
    ldh [$FFC6], a
    call Func_000_1D90
    or a, a
    jr z, Jump_001_601F
    ld b, $08
    ld hl, $99A5
    ld a, $F0

Jump_001_6017::
    call Func_000_121F
    inc a
    dec b
    jr nz, Jump_001_6017
    ret

Jump_001_601F::
    ld a, [$C5F9]
    ldh [$FF90], a
    ld a, [$C5FA]
    ldh [$FF8F], a
    ld a, [$C5FB]
    ldh [$FF8E], a
    ld a, [$C5FC]
    ldh [$FF92], a
    ld a, [$C5FD]
    ldh [$FF91], a
    xor a, a
    ld [$C8C7], a
    ld a, $00
    ld [$C5DB], a
    ld a, $00
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_604B::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_001_6061
    ld a, [$C5F8]
    dec a
    cp a, $FF
    jr nz, Jump_001_605C
    ld a, $04

Jump_001_605C::
    ld [$C5F8], a
    jr Jump_001_6071

Jump_001_6061::
    bit 7, a
    jr z, Jump_001_6071
    ld a, [$C5F8]
    inc a
    cp a, $05
    jr nz, Jump_001_606E
    xor a, a

Jump_001_606E::
    ld [$C5F8], a

Jump_001_6071::
    ld c, $00
    ld a, [$C5F0]
    and a, $03
    jr nz, Jump_001_608B
    ld a, [$C55E]
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
    ld a, [$C5F8]
    or a, a
    jr nz, Jump_001_60A8
    ld a, [$C5F9]
    add a, c
    cp a, $FF
    jr nz, Jump_001_609F
    ld a, $E1

Jump_001_609F::
    ld [$C5F9], a
    ld hl, $C5FE
    inc [hl]
    jr Jump_001_60E7

Jump_001_60A8::
    dec a
    jr nz, Jump_001_60B6
    ld a, [$C5FA]
    add a, c
    and a, $0F
    ld [$C5FA], a
    jr Jump_001_60E7

Jump_001_60B6::
    dec a
    jr nz, Jump_001_60C4
    ld a, [$C5FC]
    add a, c
    and a, $0F
    ld [$C5FC], a
    jr Jump_001_60E7

Jump_001_60C4::
    dec a
    jr nz, Jump_001_60D8
    sla c
    sla c
    sla c
    sla c
    ld a, [$C5FB]
    add a, c
    ld [$C5FB], a
    jr Jump_001_60E7

Jump_001_60D8::
    sla c
    sla c
    sla c
    sla c
    ld a, [$C5FD]
    add a, c
    ld [$C5FD], a

Jump_001_60E7::
    ld a, [$C5FE]
    or a, a
    jr z, Jump_001_6119
    ld a, [$C5F9]
    add a, $0A
    ld [$C529], a
    xor a, a
    ld [$C528], a
    ld hl, $9200
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld hl, $1001
    ld a, l
    ld [$C52F], a
    ld a, h
    ld [$C530], a
    ld hl, $402B
    ld b, $08
    rst $10
    xor a, a
    ld [$C5FE], a

Jump_001_6119::
    ld a, [$C5FA]
    ld de, $990A
    call Func_001_6A7E
    ld a, [$C5FC]
    ld de, $992A
    call Func_001_6A7E
    ld a, [$C5FB]
    swap a
    and a, $0F
    ld de, $994A
    call Func_001_6A7E
    ld a, [$C5FD]
    swap a
    and a, $0F
    ld de, $996A
    call Func_001_6A7E
    ld hl, $98E9
    ld b, $00

Jump_001_614A::
    ld a, [$C5F8]
    cp a, b
    jr z, Jump_001_6157
    ld a, $80
    call Func_000_1211
    jr Jump_001_615C

Jump_001_6157::
    ld a, $F8
    call Func_000_1211

Jump_001_615C::
    ld a, $20
    add a, l
    ld l, a
    jr nc, Jump_001_6163
    inc h

Jump_001_6163::
    inc b
    ld a, b
    cp a, $05
    jr nz, Jump_001_614A
    ret

Jump_001_616A::
    ld a, [$C563]
    and a, $90
    jr z, Jump_001_617D
    ld a, [$C5F8]
    inc a
    cp a, $0C
    jr nz, Jump_001_618E
    ld a, $00
    jr Jump_001_618E

Jump_001_617D::
    ld a, [$C563]
    and a, $60
    jr z, Jump_001_6191
    ld a, [$C5F8]
    dec a
    cp a, $FF
    jr nz, Jump_001_618E
    ld a, $0B

Jump_001_618E::
    ld [$C5F8], a

Jump_001_6191::
    ld a, [$C5F8]
    swap a
    add a, $A0
    ld hl, $9922
    ld b, $10

Jump_001_619D::
    call Func_000_121F
    inc a
    dec b
    jr nz, Jump_001_619D
    ld a, [$C562]
    and a, $01
    ret z
    ld a, [$C5F8]
    or a, a
    jr nz, Jump_001_61C3
    ld a, $01
    ld [$C5DB], a
    ld hl, $C5DF
    inc [hl]
    xor a, a
    ld [$CC44], a
    ld a, $80
    ld [$C893], a
    ret

Jump_001_61C3::
    dec a
    jr nz, Jump_001_61D5
    ld a, $00
    ld [$C5DB], a
    ld a, $02
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_61D5::
    dec a
    jr nz, Jump_001_61E7
    ld a, $00
    ld [$C5DB], a
    ld a, $03
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_61E7::
    dec a
    jr nz, Jump_001_61FE
    ld a, $00
    ld [$C5DB], a
    ld a, $04
    ld [$C5DC], a
    ld a, $80
    ld [$C8C5], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_61FE::
    dec a
    jr nz, Jump_001_6210
    ld a, $00
    ld [$C5DB], a
    ld a, $05
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_6210::
    dec a
    jr nz, Jump_001_6222
    ld a, $00
    ld [$C5DB], a
    ld a, $06
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_6222::
    dec a
    jr nz, Jump_001_6234
    ld a, $00
    ld [$C5DB], a
    ld a, $07
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_6234::
    dec a
    jr nz, Jump_001_6246
    ld a, $00
    ld [$C5DB], a
    ld a, $08
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_6246::
    dec a
    jr nz, Jump_001_6258
    ld a, $00
    ld [$C5DB], a
    ld a, $09
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_6258::
    dec a
    jr nz, Jump_001_626A
    ld a, $00
    ld [$C5DB], a
    ld a, $0A
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_626A::
    dec a
    jr nz, Jump_001_627C
    ld a, $00
    ld [$C5DB], a
    ld a, $0B
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_627C::
    ld hl, $C5DB
    ld a, [$C600]
    ld [hl+], a
    ld a, [$C601]
    ld [hl+], a
    ld a, [$C602]
    ld [hl+], a
    ld a, [$C603]
    ld [hl], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_6294::
    ld a, [$C562]
    bit 0, a
    jr z, Jump_001_62A6
    ld a, [$C5FD]
    inc a
    and a, $03
    ld [$C5FD], a
    jr Jump_001_62B9

Jump_001_62A6::
    bit 1, a
    jr z, Jump_001_62B9
    ld a, $00
    ld [$C5DB], a
    ld a, $00
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_62B9::
    ld a, [$C562]
    and a, $C0
    jr z, Jump_001_62CA
    ld a, [$C5F8]
    inc a
    and a, $01
    ld [$C5F8], a
    ret

Jump_001_62CA::
    ld a, [$C5F8]
    sla a
    ld de, $C5F9
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
    ld a, [$C563]
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
    ld a, [$C5F8]
    or a, a
    jr nz, Jump_001_6307
    ld hl, $017E
    ld a, h
    or a, $80
    ld h, a
    ld a, l
    ld [$C5F9], a
    ld a, h
    ld [$C5FA], a
    jr Jump_001_634E

Jump_001_6307::
    ld hl, $017E
    ld a, h
    or a, $80
    ld h, a
    ld a, l
    ld [$C5FB], a
    ld a, h
    ld [$C5FC], a
    jr Jump_001_634E

Jump_001_6318::
    bit 4, a
    jr z, Jump_001_634E
    ld a, [$C5F8]
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
    ld a, [$C5FA]
    bit 7, a
    jr z, Jump_001_6387
    and a, $7F
    ld [$C5FA], a
    ld a, [$C5F9]
    ld e, a
    ld a, [$C5FA]
    ld d, a
    ld hl, $9200
    ld c, $01
    call Func_000_1FE3
    ld a, [$C525]
    or a, a
    jr z, Jump_001_6387
    ld hl, $9924
    ld a, $01
    ldh [$FFC6], a
    ld a, [$C5F9]
    ld e, a
    ld a, [$C5FA]
    ld d, a
    call Func_000_2090
    ld a, $7F
    ld [$C526], a

Jump_001_6387::
    ld a, [$C5FC]
    bit 7, a
    jr z, Jump_001_63F5
    and a, $7F
    ld [$C5FC], a
    ld a, [$C5FB]
    ld e, a
    ld a, [$C5FC]
    ld d, a
    ld a, [$C5FB]
    ld l, a
    ld a, [$C5FC]
    ld h, a
    add hl, hl
    add hl, de
    ld de, Data_004_4EAA
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call Func_000_1872
    ld l, c
    inc de
    call Func_000_1872
    ld h, c
    inc de
    call Func_000_1872
    ld b, c
    ld e, l
    ld d, h
    ld hl, $8200
    call Func_000_0CF5
    ld a, [$C525]
    or a, a
    jr z, Jump_001_63F5
    ld a, [$C5FB]
    ld l, a
    ld a, [$C5FC]
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
    ld hl, $C4DF
    ld c, $08

Jump_001_63E5::
    push bc
    call Func_000_1872
    ld a, c
    ld [hl+], a
    pop bc
    inc de
    dec c
    jr nz, Jump_001_63E5
    ld a, $7F
    ld [$C527], a

Jump_001_63F5::
    ld hl, $C5FE
    inc [hl]
    ld a, [$C5F8]
    or a, a
    jr nz, Jump_001_6415
    ld a, [$C5FE]
    bit 3, a
    jr z, Jump_001_6415
    xor a, a
    ld hl, $98AB
    call Func_000_121F
    call Func_000_121F
    call Func_000_121F
    jr Jump_001_6423

Jump_001_6415::
    ld a, [$C5F9]
    ld c, a
    ld a, [$C5FA]
    ld b, a
    ld de, $98AB
    call Func_001_6A98

Jump_001_6423::
    ld a, [$C5F8]
    or a, a
    jr z, Jump_001_643F
    ld a, [$C5FE]
    bit 3, a
    jr z, Jump_001_643F
    xor a, a
    ld hl, $98CB
    call Func_000_121F
    call Func_000_121F
    call Func_000_121F
    jr Jump_001_644D

Jump_001_643F::
    ld a, [$C5FB]
    ld c, a
    ld a, [$C5FC]
    ld b, a
    ld de, $98CB
    call Func_001_6A98

Jump_001_644D::
    ld a, $00
    ldh [$FFB0], a
    ld a, [$C5FD]
    cp a, $03
    jr nz, Jump_001_645E
    ld a, $20
    ldh [$FFB0], a
    ld a, $01

Jump_001_645E::
    sla a
    ld c, a
    ld a, [$C5F0]
    swap a
    and a, $01
    add a, c
    ldh [$FFAE], a
    ld a, $20
    ldh [$FFAF], a
    ldh a, [$FFA1]
    ld c, a
    ldh a, [$FFA2]
    ld b, a
    ld a, c
    add a, $70
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    ld a, c
    ldh [$FFA9], a
    ld a, b
    ldh [$FFAA], a
    ldh a, [$FFA5]
    ld c, a
    ldh a, [$FFA6]
    ld b, a
    ld a, c
    add a, $60
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    ld a, c
    ldh [$FFAB], a
    ld a, b
    ldh [$FFAC], a
    ld a, [$C5FB]
    and a, $7F
    ldh [$FFAD], a
    ld a, [$C5FC]
    or a, a
    jr nz, Jump_001_64B9
    ld a, [$C5FB]
    bit 7, a
    jr nz, Jump_001_64B2
    ld hl, Func_001_4001
    ld b, $25
    rst $10
    ret

Jump_001_64B2::
    ld hl, Func_001_4001
    ld b, $26
    rst $10
    ret

Jump_001_64B9::
    ld hl, Func_001_4001
    ld b, $27
    rst $10
    ret

Jump_001_64C0::
    ld a, [$C562]
    and a, $08
    jr z, Jump_001_64F0
    ld a, [$C46B]
    or a, a
    jr nz, Jump_001_64E0
    call Func_000_3290
    ld a, [$C0A0]
    ld hl, Data_001_65DE
    add a, l
    ld l, a
    jr nc, Jump_001_64DB
    inc h

Jump_001_64DB::
    ld a, [hl]
    call Func_000_122D
    ret

Jump_001_64E0::
    ld a, [$C0A1]
    ld hl, Data_001_65FE
    add a, l
    ld l, a
    jr nc, Jump_001_64EB
    inc h

Jump_001_64EB::
    ld a, [hl]
    call Func_000_1278
    ret

Jump_001_64F0::
    ld a, [$C563]
    and a, $C0
    jr z, Jump_001_6512
    ld a, [$C46B]
    or a, a
    jr nz, Jump_001_6502
    call Func_001_6578
    jr Jump_001_6505

Jump_001_6502::
    call Func_001_6596

Jump_001_6505::
    ld a, [$C46B]
    xor a, $01
    ld [$C46B], a
    ld a, $69
    call Func_000_1278

Jump_001_6512::
    ld a, [$C46B]
    ld c, a
    ld b, $00
    ld hl, $C0A0
    add hl, bc
    ld a, [$C563]
    and a, $10
    jr z, Jump_001_6526
    inc [hl]
    jr Jump_001_6539

Jump_001_6526::
    ld a, [$C563]
    and a, $20
    jr z, Jump_001_6530
    dec [hl]
    jr Jump_001_6539

Jump_001_6530::
    ld a, [$C562]
    and a, $01
    jr z, Jump_001_654F
    xor a, a
    ld [hl], a

Jump_001_6539::
    ld a, $69
    call Func_000_1278
    ld a, [$C46B]
    ld b, $20
    cp a, $00
    call z, Func_001_65A0
    ld b, $54
    cp a, $01
    call z, Func_001_65A0

Jump_001_654F::
    ld a, [$C562]
    and a, $02
    jr z, Jump_001_655F
    xor a, a
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_655F::
    ld a, [$C46B]
    or a, a
    jr nz, Jump_001_6583
    ld a, [$C5F0]
    bit 3, a
    jr nz, Func_001_6578
    xor a, a
    ld hl, $98E9
    call Func_000_121F
    call Func_000_1211
    jr Jump_001_659F

Func_001_6578::
    ld a, [$C0A0]
    ld de, $98E9
    call Func_001_6A7E
    jr Jump_001_659F

Jump_001_6583::
    ld a, [$C5F0]
    bit 3, a
    jr nz, Func_001_6596
    xor a, a
    ld hl, $9909
    call Func_000_121F
    call Func_000_1211
    jr Jump_001_659F

Func_001_6596::
    ld a, [$C0A1]
    ld de, $9909
    call Func_001_6A7E

Jump_001_659F::
    ret

Func_001_65A0::
    push af
    ld a, [$C46B]
    ld hl, $C0A0
    add a, l
    ld l, a
    jr nc, Jump_001_65AC
    inc h

Jump_001_65AC::
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
    ld a, [$C46B]
    or a, a
    jr nz, Jump_001_65CA
    ld hl, Data_001_65DE
    ld de, $98EC
    ld a, [$C0A0]
    jr Jump_001_65D3

Jump_001_65CA::
    ld hl, Data_001_65FE
    ld de, $990C
    ld a, [$C0A1]

Jump_001_65D3::
    add a, l
    ld l, a
    jr nc, Jump_001_65D8
    inc h

Jump_001_65D8::
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
    ld a, [$C562]
    and a, $08
    jp z, Jump_001_66E8
    ld a, [$D09D]
    ld [$CFDC], a
    ld a, [$D0A5]
    sra a
    ld [$CFC5], a
    or a, a
    jr nz, Jump_001_66BD
    ld hl, $CFDD
    ld de, $D09F
    call Func_001_66AD
    call Func_001_66AD
    call Func_001_66AD

Jump_001_667A::
    xor a, a
    ld [$C46B], a
    xor a, a
    ld [$C5F8], a
    ld [$C5F9], a
    ld [$C5FA], a
    ld a, [$D0A5]
    or a, a
    jr nz, Jump_001_6693
    call Func_001_6880
    jr Jump_001_6696

Jump_001_6693::
    call Func_001_6ABE

Jump_001_6696::
    ld a, $04
    ld [$C5DB], a
    xor a, a
    ld [$C5DC], a
    ld a, $04
    call Func_000_0DF2
    ld hl, $C5DF
    inc [hl]
    ld hl, $D066
    inc [hl]
    ret

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
    ld hl, $D0A9
    ld a, [hl+]
    ld [$CFDD], a
    ld a, [hl+]
    ld [$CFDE], a
    ld a, [hl+]
    ld [$CFE3], a
    inc hl
    ld a, [hl+]
    ld [$CFDF], a
    ld a, [hl+]
    ld [$CFE0], a
    ld a, [hl+]
    ld [$CFE4], a
    inc hl
    ld a, [hl+]
    ld [$CFE1], a
    ld a, [hl+]
    ld [$CFE2], a
    ld a, [hl+]
    ld [$CFE5], a
    jr Jump_001_667A

Jump_001_66E8::
    ld a, [$C562]
    and a, $01
    jr z, Jump_001_6701
    ld a, [$C46B]
    add a, a
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_001_66FB
    inc h

Jump_001_66FB::
    xor a, a
    ld [hl+], a
    ld [hl], a
    jp Jump_001_6801

Jump_001_6701::
    ld a, [$C562]
    and a, $02
    jr z, Jump_001_6734
    ld a, [$D09D]
    ld [$CFDC], a
    ld hl, $CFDD
    ld de, $D09F
    call Func_001_66AD
    call Func_001_66AD
    call Func_001_66AD
    xor a, a
    ld [$C5F8], a
    ld [$C5F9], a
    ld [$C5FA], a
    xor a, a
    ld [$C46B], a
    xor a, a
    ld [$C5DC], a
    ld hl, $C5DF
    inc [hl]
    ret

Jump_001_6734::
    ld a, [$C563]
    bit 6, a
    jr z, Jump_001_674E
    call Func_001_6809
    ld a, [$C46B]
    dec a
    cp a, $FF
    jr nz, Jump_001_6748
    ld a, $0B

Jump_001_6748::
    ld [$C46B], a
    jp Jump_001_6801

Jump_001_674E::
    bit 7, a
    jr z, Jump_001_6764
    call Func_001_6809
    ld a, [$C46B]
    inc a
    cp a, $0C
    jr nz, Jump_001_675E
    xor a, a

Jump_001_675E::
    ld [$C46B], a
    jp Jump_001_6801

Jump_001_6764::
    and a, $30
    jr z, Jump_001_67C9
    ld a, [$C46B]
    add a, a
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_001_6774
    inc h

Jump_001_6774::
    ld e, [hl]
    inc hl
    ld d, [hl]
    dec hl
    ld a, [$C563]
    bit 4, a
    jr z, Jump_001_67A4
    ld a, [$C55E]
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
    ld a, [$C55E]
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
    ld a, [$C46B]
    ld hl, Data_001_68D3
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_67D5
    inc h

Jump_001_67D5::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld a, [$C5F0]
    bit 3, a
    jr nz, Jump_001_67EB
    xor a, a
    call Func_000_121F
    call Func_000_121F
    call Func_000_1211
    jr Jump_001_6808

Jump_001_67EB::
    push hl
    ld a, [$C46B]
    add a, a
    ld hl, $D09D
    add a, l
    ld l, a
    jr nc, Jump_001_67F8
    inc h

Jump_001_67F8::
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop de
    call Func_001_6A98
    jr Jump_001_6808

Jump_001_6801::
    xor a, a
    ld [$C5F0], a
    call Func_001_6903

Jump_001_6808::
    ret

Func_001_6809::
    ld a, [$C46B]
    ld hl, Data_001_68D3
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6815
    inc h

Jump_001_6815::
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [$C46B]
    ld hl, $D09D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6824
    inc h

Jump_001_6824::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    call Func_001_6A98
    ret

Func_001_682B::
    push hl
    ld a, [$C46B]
    ld hl, Data_001_68EB
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6838
    inc h

Jump_001_6838::
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

Func_001_6857::
    push hl
    ld a, [$C46B]
    ld hl, Data_001_68EB
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6864
    inc h

Jump_001_6864::
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld h, d
    ld l, e
    inc bc
    call Func_000_3E7A
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

Func_001_6880::
    ld a, [$C6FD]
    or a, a
    jr z, Jump_001_68B4
    cp a, $04
    jr nc, Jump_001_68B4
    ld b, a
    ld hl, $C6FE
    ld a, [$C7C7]
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
    ld hl, Data_001_706E
    ld b, $02
    rst $10
    ldh a, [$FFC6]
    or a, a
    jr nz, Jump_001_68C6
    ld hl, Data_001_717D
    ld b, $02
    rst $10
    ret

Jump_001_68C6::
    call Func_001_6ABE
    ret

Func_001_68CA::
    ld c, $00
    call Func_000_1F49
    ld a, [hl]
    cp a, $02
    ret

Data_001_68D3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $87, $98, $A7, $98, $C7, $98, $E7, $98, $07, $99, $27, $99, $47, $99, $67, $99
    db $87, $99, $A7, $99, $C7, $99, $E7, $99

Data_001_68EB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $00, $AB, $02, $AB, $02, $AB, $02, $01, $00, $00, $00, $40, $01, $63

Data_001_68FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $40, $01, $63, $00, $40, $01, $63, $00

Func_001_6903::
    ld a, [$C46B]
    or a, a
    ret z
    cp a, $04
    jr z, Jump_001_6976
    cp a, $05
    jp z, Jump_001_69C2
    cp a, $06
    jp nc, Jump_001_6A0C
    ld hl, $D09D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_691F
    inc h

Jump_001_691F::
    ld a, [hl+]
    ld h, [hl]
    ld [$C529], a
    ld a, h
    ld [$C528], a
    ld hl, Data_001_6A6C
    ld a, [$C46B]
    dec a
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6935
    inc h

Jump_001_6935::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0901
    ld a, [$C52D]
    ld c, a
    ld a, [$C52E]
    ld b, a
    push bc
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    push bc
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, $400F
    ld b, $88
    rst $10
    pop de
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ret

Jump_001_6976::
    ld a, [$D0A5]
    ld [$C529], a
    ld a, $02
    ld [$C528], a
    ld hl, $93C0
    ld de, $0901
    ld a, [$C52D]
    ld c, a
    ld a, [$C52E]
    ld b, a
    push bc
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    push bc
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, $400F
    ld b, $2F
    rst $10
    pop de
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ret

Jump_001_69C2::
    xor a, a
    ld [$C529], a
    ld a, $04
    ld [$C528], a
    ld hl, $9450
    ld de, $0901

Jump_001_69D1::
    ld a, [$C52D]
    ld c, a
    ld a, [$C52E]
    ld b, a
    push bc
    ld a, [$C52F]
    ld c, a
    ld a, [$C530]
    ld b, a
    push bc
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ld hl, $402B
    ld b, $08
    rst $10
    pop de
    pop hl
    ld a, l
    ld [$C52D], a
    ld a, h
    ld [$C52E], a
    ld a, e
    ld [$C52F], a
    ld a, d
    ld [$C530], a
    ret

Jump_001_6A0C::
    ld a, [$C46B]
    ld hl, $D09D
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6A18
    inc h

Jump_001_6A18::
    ld a, [$C46B]
    cp a, $07
    jr z, Jump_001_6A46
    cp a, $09
    jr z, Jump_001_6A46
    cp a, $0B
    jr z, Jump_001_6A46
    ld a, [hl+]
    ld [$C529], a
    ld a, [hl]
    add a, $02
    ld [$C528], a
    ld a, [$C46B]
    sub a, $06
    ld hl, Data_001_6A72
    add a, l
    ld l, a
    jr nc, Jump_001_6A3E
    inc h

Jump_001_6A3E::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    ld de, $0901
    jr Jump_001_69D1

Jump_001_6A46::
    ld b, [hl]
    ld a, $0A
    call Func_000_16BF
    ld c, a
    push bc
    ld a, [$C46B]
    sub a, $07
    ld hl, Data_001_6A78
    add a, l
    ld l, a
    jr nc, Jump_001_6A5B
    inc h

Jump_001_6A5B::
    ld a, [hl+]
    ld h, [hl]
    ld l, a
    pop bc
    ld a, b
    add a, $10
    call Func_000_121F
    ld a, c
    add a, $10
    call Func_000_1211
    ret

Data_001_6A6C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $92, $A0, $92, $30, $93

Data_001_6A72:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $94, $70, $95, $00, $96

Data_001_6A78:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6B, $99, $AB, $99, $EB, $99

Func_001_6A7E::
    push af
    swap a
    and a, $0F
    add a, $10
    push af
    call Func_000_120A
    pop af
    ld [de], a
    inc de
    pop af
    and a, $0F
    add a, $10
    push af
    call Func_000_120A
    pop af
    ld [de], a
    ret

Func_001_6A98::
    ld a, b
    and a, $0F
    add a, $10
    push af
    call Func_000_120A
    pop af
    ld [de], a
    inc de
    ld a, c
    swap a
    and a, $0F
    add a, $10
    push af
    call Func_000_120A
    pop af
    ld [de], a
    inc de
    ld a, c
    and a, $0F
    add a, $10
    push af
    call Func_000_120A
    pop af
    ld [de], a
    ret

Func_001_6ABE::
    ld a, $00
    ldh [$FF90], a
    ld a, $02
    ldh [$FF8F], a
    ld a, $00
    ldh [$FF92], a
    ld a, $40
    ldh [$FF8E], a
    ld a, $40
    ldh [$FF91], a
    ld a, $00
    ld [$C8EF], a
    ld a, $40
    ld [$C8F0], a
    ld a, $40
    ld [$C8F1], a
    ld a, $00
    ld [$C8F4], a
    ld a, $40
    ld [$C8F5], a
    ld a, $40
    ld [$C8F6], a
    ld a, $00
    ld [$C8F9], a
    ld a, $40
    ld [$C8FA], a
    ld a, $40
    ld [$C8FB], a
    ld a, $24
    ld [$C60C], a
    ld a, $35
    ld [$C60D], a
    ld a, $8D
    ld [$C60E], a
    ld a, $2F
    ld [$C60F], a
    ld a, $2B
    ld [$C610], a
    ld a, $55
    ld [$C611], a
    ld a, $F0
    ld [$C612], a
    ld a, $F0
    ld [$C613], a
    ld a, $F0
    ld [$C614], a
    ld a, $F0
    ld [$C615], a
    ld a, $9F
    ld [$C617], a
    ld a, $86
    ld [$C618], a
    ld a, $01
    ld [$C619], a
    ld a, $03
    ld [$C6FD], a
    ld a, $00
    ld [$C6FE], a
    ld a, $01
    ld [$C6FF], a
    ld a, $02
    ld [$C700], a
    ld a, $01
    ld [$C61D], a
    ld a, $02
    ld [$C61E], a
    ld a, $03
    ld [$C61F], a
    ld a, $04
    ld [$C620], a
    ld a, $05
    ld [$C621], a
    ld a, $06
    ld [$C622], a
    ld a, $01
    ld [$C623], a
    ld a, $1F
    ld [$C624], a
    ld a, $09
    ld [$C625], a
    ld a, $33
    ld [$C626], a
    ld a, $0B
    ld [$C627], a
    ld a, $20
    ld [$C628], a
    ld a, $28
    ld [$C629], a
    ld a, $0E
    ld [$C62A], a
    ld a, $0F
    ld [$C62B], a
    ld a, $10
    ld [$C62C], a
    ld a, $11
    ld [$C62D], a
    ld a, $12
    ld [$C62E], a
    ld a, $1C
    ld [$C62F], a
    ld a, $1C
    ld [$C630], a
    ld a, $1C
    ld [$C631], a
    ld a, $0C
    ld [$C632], a
    ld a, $0C
    ld [$C633], a
    ld a, $0C
    ld [$C634], a
    ld a, $50
    ld [$C838], a
    xor a, a
    ld [$C839], a
    call Func_001_6E98
    call Func_001_6BDC
    ret

Func_001_6BDC::
    ld b, $1E
    xor a, a
    ld [$D868], a

Jump_001_6BE2::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    push bc
    call Func_001_6C1F
    pop bc
    xor a, a
    ld [$0100], a
    ld hl, $D868
    inc [hl]
    dec b
    jr nz, Jump_001_6BE2
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ld hl, $A000
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
    ld [$0100], a
    ret

Func_001_6C1F::
    call Func_000_095B
    ld a, [$C5E7]
    ld e, a
    ld a, [$C5E8]
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

Func_001_6C48::
    ldh a, [$FFC9]
    push af
    ld a, e
    ld [$CFE6], a
    ld a, d
    ld [$CFE7], a
    ld hl, Func_001_4001
    ld b, $34
    rst $10
    ld a, [$D868]
    ld c, $00
    call Func_000_1FD1
    pop af
    ld [hl], a
    ld a, l
    add a, $0B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$CFEC]
    ld [hl+], a
    ld a, [$CFED]
    ld [hl+], a
    inc hl
    ld a, [$D869]
    cp a, $FF
    jr nz, Jump_001_6C82
    ld a, [$C5E8]
    and a, $01
    jr Jump_001_6C8D

Jump_001_6C82::
    push hl
    ld hl, Data_001_70AA
    add a, l
    ld l, a
    jr nc, Jump_001_6C8B
    inc h

Jump_001_6C8B::
    ld a, [hl]
    pop hl

Jump_001_6C8D::
    ld [hl+], a
    ld de, $C60C
    ld b, $0B
    call Func_001_6E25
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call Func_001_6E31
    call Func_001_6E31
    ld a, [$CFEE]
    ld [hl+], a
    ld a, [$CFEF]
    ld [hl+], a
    ld a, [$CFF0]
    ld [hl+], a
    ld a, [$CFF1]
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
    ld a, [$CFF5]
    ld [hl+], a
    ld [$C9DC], a
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$CFF6]
    ld e, a
    ld a, [$CFF7]
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
    ld a, [$CFF8]
    ld [hl+], a
    ld a, [$CFF9]
    ld [hl+], a
    ld a, [$CFF8]
    ld [hl+], a
    ld a, [$CFF9]
    ld [hl+], a
    ld a, [$CFFA]
    ld [hl+], a
    ld a, [$CFFB]
    ld [hl+], a
    ld a, [$CFFC]
    ld [hl+], a
    ld a, [$CFFD]
    ld [hl+], a
    ld a, [$CFFE]
    ld [hl+], a
    ld a, [$CFFF]
    ld [hl+], a
    ld a, [$D000]
    ld [hl+], a
    ld a, [$D001]
    ld [hl+], a
    ld a, [$D86A]
    or a, a
    jr z, Jump_001_6D30
    push hl
    call Func_000_095B
    pop hl
    ld a, [$C5E7]
    ld [hl+], a
    ld a, [$C5E8]
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
    ld a, [$D002]
    ld [hl+], a
    ld a, [$D003]
    ld [hl+], a
    ld a, [$D004]
    ld [hl+], a
    ld a, [$D005]
    ld [hl+], a
    ld a, [$CFEC]
    ld l, a
    ld a, [$CFED]
    ld h, a
    ld a, l
    ld [$D006], a
    ld a, h
    ld [$D007], a
    ld hl, Func_001_4001
    ld b, $35
    rst $10
    ld a, [$D868]
    ld c, $0D
    call Func_000_1FD1
    ld a, [$D008]
    ld [hl], a
    ld a, a
    ld [$D09D], a
    ld a, l
    add a, $2F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [$D010]
    ld [hl+], a
    ld a, [$D011]
    ld [hl+], a
    ld a, [$D012]
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
    ld a, [$D00E]
    ld [hl], a
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld de, $D01A
    ld b, $1B
    call Func_001_6E25
    call Func_001_6E31
    call Func_001_6E31
    ld [hl], $00
    ld a, [$D869]
    cp a, $FF
    jr nz, Jump_001_6DD9
    call Func_000_095B
    ld a, [$C5E7]
    ld b, a
    ld a, $0E
    call Func_000_16BF
    ld [$D09E], a
    ld a, [$D868]
    ld c, $01
    call Func_000_1FD1
    ld a, l
    ld [$D09F], a
    ld a, h
    ld [$D0A0], a
    ld hl, Data_001_7F9C
    ld b, $14
    rst $10
    jr Jump_001_6DF4

Jump_001_6DD9::
    push hl
    ld hl, Data_001_70B3
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6DE3
    inc h

Jump_001_6DE3::
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
    ld a, [$D006]
    ld l, a
    ld a, [$D007]
    ld h, a
    ld a, l
    ld [$C991], a
    ld a, h
    ld [$C992], a
    ld hl, Data_001_73A2
    ld b, $19
    rst $10
    ld a, [$D868]
    ld c, $58
    call Func_000_1FD1
    ld a, [$C9DE]
    ld [hl+], a
    ld a, [$C9DF]
    ld [hl+], a
    ld a, [$C9E0]
    ld [hl+], a
    ld hl, $5AAF
    ld b, $16
    rst $10
    ret

Func_001_6E25::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Func_001_6E25
    ret

Func_001_6E2C::
    ld [hl+], a
    dec b
    jr nz, Func_001_6E2C
    ret

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

Func_001_6E46::
    ld a, $0A
    ld [$0100], a
    xor a, a
    ld [$4100], a
    ldh a, [$FFC7]
    ld [$D869], a
    ld hl, Data_001_7098
    add a, a
    add a, l
    ld l, a
    jr nc, Jump_001_6E5D
    inc h

Jump_001_6E5D::
    ld e, [hl]
    inc hl
    ld d, [hl]
    xor a, a
    ld [$D86A], a
    ldh a, [$FFC8]
    call Func_001_6E91
    ldh a, [$FFC7]
    cp a, $01
    jr z, Jump_001_6E73
    cp a, $02
    jr nz, Jump_001_6E7D

Jump_001_6E73::
    ld a, [$D868]
    ld c, $6E
    call Func_000_1FD1
    ld [hl], $01

Jump_001_6E7D::
    xor a, a
    ld [$0100], a
    ret

Func_001_6E82::
    ld a, $FF
    ld [$D869], a
    ld [$D86A], a
    ld a, $01
    ldh [$FFC9], a
    ld a, [$D868]

Func_001_6E91::
    ld [$D868], a
    call Func_001_6C48
    ret

Func_001_6E98::
    ld de, Data_001_6EB0
    ld hl, $C707
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
    ds $29, $00
    db $11, $12, $13, $35, $0E, $00, $00, $00, $00, $A0, $A1, $A2, $A3, $A4, $A5, $A6
    db $A7, $A8
    ds $16, $00
    INCBIN "dwm2-cobi-us.gbc", $006F81, $B6

Data_001_7037:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2C, $36, $05
    ds $17, $00
    db $31, $29, $14, $15, $16, $00, $31, $29, $32, $29, $00, $00, $2D, $27, $2E, $1A
    db $30, $26, $16, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_001_706E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $2F, $25, $1A, $30, $26, $16
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
    ds $5E, $00

Data_001_717D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $225, $00

Data_001_73A2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $223, $00

Data_001_75C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $9D7, $00

Data_001_7F9C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $64, $00
