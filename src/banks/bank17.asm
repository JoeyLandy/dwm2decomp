SECTION "Bank 17", ROMX[$4000], BANK[$17]
    db $17

; 1 call site from 1 routine (e.g. Func_017_41CF)
; reads: wSGBActive, wSGBPacketIndex
; points at: wSGBPacketBuffer
Func_017_4001::
    ld a, [wSGBActive]
    or a, a
    ret z
    ld a, [wSGBPacketIndex]
    cp a, $FF
    jr nz, Jump_017_4012
    ld hl, wSGBPacketBuffer
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
    call SpinDelay
    jr Jump_017_4026

Data_017_4055:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $40, $0F, $41
    dw Data_017_407F
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

Data_017_407F:: ; heuristic: target of a monotone pointer table; C0
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

; 9 call sites from 7 routines (e.g. Func_000_0150, GameMode1_Init, GameMode5_Init, Func_007_4B27, ...)
; reads: wSGBActive, wC51F, wC0A0, wC520
; writes: wSGBPacketBuffer, wC0A0, wSGBPacketIndex
; points at: wC480, wC577
Func_017_41CF::
    ld a, [wSGBActive]
    or a, a
    ret z
    call Func_000_076B
    ld a, $51
    ld [wSGBPacketBuffer], a
    ld a, [wC51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, Data_017_426C
    add hl, de
    ld de, wC480
    ld bc, wC577
    ld a, $08
    ld [wC0A0], a

Jump_017_41F4::
    ld a, [hl+]
    ld [de], a
    ld [bc], a
    inc de
    inc bc
    ld a, [wC0A0]
    dec a
    ld [wC0A0], a
    jr nz, Jump_017_41F4
    ld a, [wC520]
    or a, $80
    ld [de], a
    call Func_017_421A
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b Func_017_4001
    call SpinDelay
    ret

; 7 call sites from 7 routines (e.g. Func_017_41CF, Func_002_5F9B, GameMode5_Init, Func_007_600E, ...)
; reads: wSGBActive, wC577, wC578, wC579, wC57A, wC57B, wC57C, wC57D, ...
; points at: wC4DF, wC4E7, wC4EF, wC4F7
Func_017_421A::
    ld a, [wSGBActive]
    or a, a
    ret z
    ld a, [wC577]
    ld l, a
    ld a, [wC578]
    ld h, a
    ld de, wC4DF
    call Func_017_4258
    ld de, wC4E7
    ld a, [wC579]
    ld l, a
    ld a, [wC57A]
    ld h, a
    call Func_017_4258
    ld de, wC4EF
    ld a, [wC57B]
    ld l, a
    ld a, [wC57C]
    ld h, a
    call Func_017_4258
    ld de, wC4F7
    ld a, [wC57D]
    ld l, a
    ld a, [wC57E]
    ld h, a
    call Func_017_4258
    ret

; 4 call sites from 1 routine (e.g. Func_017_421A)
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
    INCBIN "dwm2-cobi-us.gbc", $05C26C, $1B0D

Data_017_5D79:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $05DD79, $BBF
    ds $16C8, $00
