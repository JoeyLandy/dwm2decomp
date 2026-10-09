SECTION "Bank 17", ROMX[$4000], BANK[$17]
    db $17

Func_017_4001::
    ld a, [$C524]
    or a, a
    ret z
    ld a, [$C47C]
    cp a, $FF
    jr nz, Jump_017_4012
    ld hl, $C47F
    jr Jump_017_401F

Jump_017_4012::
    ld l, a
    ld h, $00
    add hl, hl
    ld de, Data_017_4055
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    pop hl

Jump_017_401F::
    ld a, [hl]
    and a, $07
    ret z
    ld b, a
    ld c, $00

Jump_017_4026::
    push bc
    ld a, $00
    ldh [c], a
    ld a, $30
    ldh [c], a
    ld b, $10

Jump_017_402F::
    ld e, $08
    ld a, [hl+]
    ld d, a

Jump_017_4033::
    bit 0, d
    ld a, $10
    jr nz, Jump_017_403B
    ld a, $20

Jump_017_403B::
    ldh [c], a
    ld a, $30
    ldh [c], a
    rr d
    dec e
    jr nz, Jump_017_4033
    dec b
    jr nz, Jump_017_402F
    ld a, $20
    ldh [c], a
    ld a, $30
    ldh [c], a
    pop bc
    dec b
    ret z
    call Func_000_05D1
    jr Jump_017_4026

Data_017_4055:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $40, $0F, $41, $7F, $40
    dw Data_017_408F
    dw Data_017_409F
    dw Data_017_40AF
    dw Data_017_40BF
    dw Data_017_40CF
    dw Data_017_40DF
    dw Data_017_40EF
    dw Data_017_411F
    dw Data_017_412F
    dw Data_017_413F
    dw Data_017_414F
    dw Data_017_415F
    dw Data_017_416F
    dw Data_017_417F
    dw Data_017_418F
    dw Data_017_419F
    dw Data_017_41AF
    dw Data_017_41BF
    dw Data_017_5D79
    db $08, $00, $0B, $8C, $D0, $F4, $60, $00, $00, $00, $00, $00, $00, $00

Data_017_408F:: ; heuristic: target of a monotone pointer table; C0
    db $79, $52, $08, $00, $0B, $A9, $E7, $9F, $01, $C0, $7E, $E8, $E8, $E8, $E8, $E0

Data_017_409F:: ; heuristic: target of a monotone pointer table; C0
    db $79, $47, $08, $00, $0B, $C4, $D0, $16, $A5, $CB, $C9, $05, $D0, $10, $A2, $28

Data_017_40AF:: ; heuristic: target of a monotone pointer table; C0
    db $79, $3C, $08, $00, $0B, $F0, $12, $A5, $C9, $C9, $C8, $D0, $1C, $A5, $CA, $C9

Data_017_40BF:: ; heuristic: target of a monotone pointer table; C0
    db $79, $31, $08, $00, $0B, $0C, $A5, $CA, $C9, $7E, $D0, $06, $A5, $CB, $C9, $7E

Data_017_40CF:: ; heuristic: target of a monotone pointer table; C0
    db $79, $26, $08, $00, $0B, $39, $CD, $48, $0C, $D0, $34, $A5, $C9, $C9, $80, $D0

Data_017_40DF:: ; heuristic: target of a monotone pointer table; C0
    db $79, $1B, $08, $00, $0B, $EA, $EA, $EA, $EA, $EA, $A9, $01, $CD, $4F, $0C, $D0

Data_017_40EF:: ; heuristic: target of a monotone pointer table; C0
    db $79, $10, $08, $00, $0B, $4C, $20, $08, $EA, $EA, $EA, $EA, $EA, $60, $EA, $EA
    db $B9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $B9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_411F:: ; heuristic: target of a monotone pointer table; C0
    db $89, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_412F:: ; heuristic: target of a monotone pointer table; C0
    db $89, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_413F:: ; heuristic: target of a monotone pointer table; C0
    db $59, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_414F:: ; heuristic: target of a monotone pointer table; C0
    db $A9, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_415F:: ; heuristic: target of a monotone pointer table; C0
    db $51, $00, $00, $01, $00, $02, $00, $03, $00, $C0, $00, $00, $00, $00, $00, $00

Data_017_416F:: ; heuristic: target of a monotone pointer table; C0
    db $A1, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_417F:: ; heuristic: target of a monotone pointer table; C0
    db $99, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_418F:: ; heuristic: target of a monotone pointer table; C0
    db $99, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_419F:: ; heuristic: target of a monotone pointer table; C0
    db $C9, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_41AF:: ; heuristic: target of a monotone pointer table; C0
    db $71, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_017_41BF:: ; heuristic: target of a monotone pointer table; C0
    db $B9, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Func_017_41CF::
    ld a, [$C524]
    or a, a
    ret z
    call Func_000_076B
    ld a, $51
    ld [$C47F], a
    ld a, [$C51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, Data_017_426C
    add hl, de
    ld de, $C480
    ld bc, $C577
    ld a, $08
    ld [$C0A0], a

Jump_017_41F4::
    ld a, [hl+]
    ld [de], a
    ld [bc], a
    inc de
    inc bc
    ld a, [$C0A0]
    dec a
    ld [$C0A0], a
    jr nz, Jump_017_41F4
    ld a, [$C520]
    or a, $80
    ld [de], a
    call Func_017_421A
    ld a, $FF
    ld [$C47C], a
    ld b, $17
    ld hl, Func_017_4001
    rst $10
    call Func_000_05D1
    ret

Func_017_421A::
    ld a, [$C524]
    or a, a
    ret z
    ld a, [$C577]
    ld l, a
    ld a, [$C578]
    ld h, a
    ld de, $C4DF
    call Func_017_4258
    ld de, $C4E7
    ld a, [$C579]
    ld l, a
    ld a, [$C57A]
    ld h, a
    call Func_017_4258
    ld de, $C4EF
    ld a, [$C57B]
    ld l, a
    ld a, [$C57C]
    ld h, a
    call Func_017_4258
    ld de, $C4F7
    ld a, [$C57D]
    ld l, a
    ld a, [$C57E]
    ld h, a
    call Func_017_4258
    ret

Func_017_4258::
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $6C
    ld l, a
    ld a, h
    adc a, $44
    ld h, a
    ld c, $08

Jump_017_4265::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_017_4265
    ret

Data_017_426C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05C26C, $87
    dw Data_017_4400
    dw Data_017_4500
    dw Data_017_4600
    dw Data_017_4700
    dw Data_017_4800
    dw Data_017_4900
    dw Data_017_4A00
    dw Data_017_4B00
    dw Data_017_4C00
    dw Data_017_4D00
    dw Data_017_4E00
    dw Data_017_4F00
    dw Data_017_5000
    dw Data_017_5100
    dw Data_017_5200
    dw Data_017_5300
    dw Data_017_5400
    dw Data_017_5500
    dw Data_017_5600
    dw Data_017_5700
    dw Data_017_5800
    dw Data_017_5900
    dw Data_017_5A00
    dw Data_017_5B00
    dw Data_017_5C00
    dw Data_017_5D00
    dw Data_017_5E00
    dw Data_017_5F00
    dw Data_017_6000
    dw Data_017_6100
    dw Data_017_6200
    dw Data_017_6300
    dw Data_017_6400
    dw Data_017_6500
    dw Data_017_6600
    dw Data_017_6700
    dw Data_017_6800
    dw Data_017_6900
    dw Data_017_6A00
    dw Data_017_6B00
    dw Data_017_6C00
    dw Data_017_6D00
    dw Data_017_6E00
    dw Data_017_6F00
    dw Data_017_7000
    dw Data_017_7100
    dw Data_017_7200
    dw Data_017_7300
    dw Data_017_7400
    dw Data_017_7500
    dw Data_017_7600
    dw Data_017_7700
    dw Data_017_7800
    dw Data_017_7900
    dw Data_017_7A00
    dw Data_017_7B00
    dw Data_017_7C00
    dw Data_017_7D00
    dw Data_017_7E00
    dw Data_017_7F00
    INCBIN "dwm2-cobi-us.gbc", $05C36B, $95

Data_017_4400:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05C400, $100

Data_017_4500:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05C500, $100

Data_017_4600:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05C600, $100

Data_017_4700:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05C700, $100

Data_017_4800:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05C800, $100

Data_017_4900:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05C900, $100

Data_017_4A00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05CA00, $100

Data_017_4B00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05CB00, $100

Data_017_4C00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05CC00, $100

Data_017_4D00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05CD00, $100

Data_017_4E00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05CE00, $100

Data_017_4F00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05CF00, $100

Data_017_5000:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D000, $100

Data_017_5100:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D100, $100

Data_017_5200:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D200, $100

Data_017_5300:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D300, $100

Data_017_5400:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D400, $100

Data_017_5500:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D500, $100

Data_017_5600:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D600, $100

Data_017_5700:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D700, $100

Data_017_5800:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D800, $100

Data_017_5900:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05D900, $100

Data_017_5A00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DA00, $100

Data_017_5B00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DB00, $100

Data_017_5C00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DC00, $100

Data_017_5D00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DD00, $79

Data_017_5D79:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DD79, $87

Data_017_5E00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DE00, $100

Data_017_5F00:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DF00, $100

Data_017_6000:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E000, $100

Data_017_6100:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E100, $100

Data_017_6200:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E200, $100

Data_017_6300:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E300, $100

Data_017_6400:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E400, $100

Data_017_6500:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E500, $100

Data_017_6600:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E600, $100

Data_017_6700:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E700, $100

Data_017_6800:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05E800, $100

Data_017_6900:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $B4, $02, $E4, $02, $82, $00, $09, $0F, $01, $AA, $00, $00, $00, $9F, $4A
    db $BD, $2D, $F7, $18, $10, $00, $FF, $7F, $61, $00, $00, $00, $47, $7F, $DC, $36
    db $D6, $15, $E4, $08, $86, $9F, $4A, $60, $7E, $E4, $16, $8F, $07, $68, $31, $E4
    db $32, $8C, $00, $7C, $E4, $62, $8F, $09
    ds $C8, $00

Data_017_6A00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_6B00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_6C00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_6D00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_6E00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_6F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7000:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7100:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7200:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7300:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7400:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7500:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7600:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7700:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7800:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7900:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7A00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7B00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7C00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7D00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7E00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00

Data_017_7F00:: ; heuristic: target of a monotone pointer table; C0
    ds $100, $00
